local MogIt, mog = ...
local L = mog.L

local TEXTURE = [[Interface\RaidFrame\ReadyCheck-Ready]]

local function getTexture(hasItem, embedded)
	local texture = hasItem and TEXTURE or ""
	return embedded and format("|T%s:0|t ", texture) or texture
end

local itemQualityColor = {
	[0] = "9d9d9d",
	[1] = "ffffff",
	[2] = "1eff00",
	[3] = "0070dd",
	[4] = "a335ee",
	[5] = "ff8000",
	[6] = "e6cc80",
	[7] = "e6cc80"
}

local tblZoneFix = {
	[4] = "Durotar",
	[9] = "Mulgore",
	[11] = "The Barrens",
	[13] = "Kalimdor",
	[14] = "Eastern Kingdoms",
	[15] = "Alterac Mountains",
	[16] = "Arathi Highlands",
	[17] = "Badlands",
	[19] = "Blasted Lands",
	[20] = "Tirisfal Glade",
	[21] = "Silverpine Forest",
	[22] = "Western Plaguelands",
	[23] = "Eastern Plaguelands",
	[24] = "Hillsbrad Foothills",
	[26] = "The Hinterlands",
	[27] = "Dun Morogh",
	[28] = "Searing Gorge",
	[29] = "Burning Steppes",
	[30] = "Elwynn Forest",
	[32] = "Deadwind Pass",
	[34] = "Duskwood",
	[35] = "Loch Modan",
	[36] = "Redridge Mountains",
	[37] = "Northern Stranglethorn",
	[38] = "Swamp of Sorrows",
	[39] = "Westfall",
	[40] = "Wetlands",
	[41] = "Teldrassil",
	[42] = "Darkshore",
	[43] = "Ashenvale",
	[61] = "Thousand Needles",
	[81] = "Stonetalon Mountains",
	[101] = "Desolace",
	[121] = "Feralas",
	[141] = "Dustwallow Marsh",
	[161] = "Tanaris",
	[181] = "Azshara",
	[182] = "Felwood",
	[201] = "Un'Goro Crater",
	[241] = "Moonglade",
	[261] = "Silithus",
	[281] = "Winterspring",
	[301] = "Stormwind City",
	[321] = "Orgrimmar",
	[341] = "Ironforge",
	[362] = "Thunder Bluff",
	[381] = "Darnassus",
	[382] = "Undercity",
	[401] = "Alterac Valley",
	[443] = "Warsong Gulch",
	[461] = "Arathi Basin",
	[462] = "Eversong Woods",
	[463] = "Ghostlands",
	[464] = "Azuremyst Isle",
	[465] = "Hellfire Peninsula",
	[466] = "Outland",
	[467] = "Zangarmarsh",
	[471] = "The Exodar",
	[473] = "Shadowmoon Valley",
	[475] = "Blade's Edge Mountains",
	[476] = "Bloodmyst Isle",
	[477] = "Nagrand",
	[478] = "Terokkar Forest",
	[479] = "Netherstorm",
	[480] = "Silvermoon City",
	[481] = "Shattrath City",
	[482] = "Eye of the Storm",
	[485] = "Northrend",
	[486] = "Borean Tundra",
	[488] = "Dragonblight",
	[490] = "Grizzly Hills",
	[491] = "Howling Fjord",
	[492] = "Icecrown",
	[493] = "Sholazar Basin",
	[495] = "The Storm Peaks",
	[496] = "Zul'Drak",
	[499] = "Isle of Quel'Danas",
	[501] = "Wintergrasp",
	[502] = "The Scarlet Enclave",
	[504] = "Dalaran",
	[510] = "Crystalsong Forest",
	[512] = "Strand of the Ancients",
	[520] = "The Nexus",
	[521] = "The Culling of Stratholme",
	[522] = "Ahn'kahet",
	[523] = "Utgarde Keep",
	[524] = "Utgarde Pinnacle",
	[525] = "Halls of Lightning",
	[526] = "Halls of Stone",
	[527] = "The Eye of Eternity",
	[528] = "The Oculus",
	[529] = "Ulduar",
	[530] = "Gundrak",
	[531] = "The Obsidian Sanctum",
	[532] = "Vault of Archavon",
	[533] = "Azjol-Nerub",
	[534] = "Drak'Tharon Keep",
	[535] = "Naxxramas",
	[536] = "The Violet Hold",
	[540] = "Isle of Conquest",
	[541] = "Hrothgar's Landing",
	[542] = "Trial of the Champion",
	[543] = "Trial of the Crusader",
	[544] = "The Lost Isles",
	[545] = "Gilneas",
	[601] = "The Forge of Souls",
	[602] = "Pit of Saron",
	[603] = "Halls of Reflection",
	[604] = "Icecrown Citadel",
	[605] = "Kezan",
	[606] = "Mount Hyjal",
	[607] = "Southern Barrens",
	[609] = "The Ruby Sanctum",
	[610] = "Kelp'thar Forest",
	[611] = "Gilneas City",
	[613] = "Vashj'ir",
	[614] = "Abyssal Depths",
	[615] = "Shimmering Expanse",
	[626] = "Twin Peaks",
	[640] = "Deepholm",
	[673] = "The Cape of Stranglethorn",
	[680] = "Ragefire Chasm",
	[684] = "Ruins of Gilneas",
	[685] = "Ruins of Gilneas City",
	[686] = "Zul'Farrak",
	[687] = "The Temple of Atal'Hakkar",
	[688] = "Blackfathom Deeps",
	[689] = "Stranglethorn Vale",
	[690] = "The Stockade",
	[691] = "Gnomeregan",
	[692] = "Uldaman",
	[696] = "Molten Core",
	[697] = "Zul'Gurub",
	[699] = "Dire Maul",
	[700] = "Twilight Highlands",
	[704] = "Blackrock Depths",
	[708] = "Tol Barad",
	[709] = "Tol Barad Peninsula",
	[710] = "The Shattered Halls",
	[717] = "Ruins of Ahn'Qiraj",
	[718] = "Onyxia's Lair",
	[720] = "Uldum",
	[721] = "Blackrock Spire",
	[722] = "Auchenai Crypts",
	[723] = "Sethekk Halls",
	[724] = "Shadow Labyrinth",
	[725] = "The Blood Furnace",
	[726] = "The Underbog",
	[727] = "The Steamvault",
	[728] = "The Slave Pens",
	[729] = "The Botanica",
	[730] = "The Mechanar",
	[731] = "The Arcatraz",
	[732] = "Mana-Tombs",
	[733] = "The Black Morass",
	[734] = "Old Hillsbrad Foothills",
	[736] = "The Battle for Gilneas",
	[737] = "The Maelstrom",
	[747] = "Lost City of the Tol'vir",
	[749] = "Wailing Caverns",
	[750] = "Maraudon",
	[751] = "The Maelstrom",
	[752] = "Baradin Hold",
	[753] = "Blackrock Caverns",
	[754] = "Blackwing Descent",
	[755] = "Blackwing Lair",
	[756] = "The Deadmines",
	[757] = "Grim Batol",
	[758] = "The Bastion of Twilight",
	[759] = "Halls of Origination",
	[760] = "Razorfen Downs",
	[761] = "Razorfen Kraul",
	[762] = "Scarlet Monastery",
	[763] = "Scholomance",
	[764] = "Shadowfang Keep",
	[765] = "Stratholme",
	[766] = "Temple of Ahn'Qiraj",
	[767] = "Throne of the Tides",
	[768] = "The Stonecore",
	[769] = "The Vortex Pinnacle",
	[772] = "Ahn'Qiraj: The Fallen Kingdom",
	[773] = "Throne of the Four Winds",
	[775] = "Hyjal Summit",
	[776] = "Gruul's Lair",
	[779] = "Magtheridon's Lair",
	[780] = "Serpentshrine Cavern",
	[781] = "Zul'Aman",
	[782] = "The Eye",
	[789] = "Sunwell Plateau",
	[793] = "Zul'Gurub",
	[795] = "Molten Front",
	[796] = "Black Temple",
	[797] = "Hellfire Ramparts",
	[798] = "Magisters' Terrace",
	[799] = "Karazhan",
	[800] = "Firelands",
	[806] = "The Jade Forest",
	[807] = "Valley of the Four Winds",
	[808] = "The Wandering Isle",
	[809] = "Kun-Lai Summit",
	[810] = "Townlong Steppes",
	[811] = "Vale of Eternal Blossoms",
	[816] = "Well of Eternity",
	[819] = "Hour of Twilight",
	[820] = "End Time",
	[824] = "Dragon Soul",
	[851] = "Theramore's Fall (H)",
	[856] = "Temple of Kotmogu",
	[857] = "Krasarang Wilds",
	[858] = "Dread Wastes",
	[860] = "Silvershard Mines",
	[862] = "Pandaria",
	[864] = "Northshire",
	[866] = "Coldridge Valley",
	[867] = "Temple of the Jade Serpent",
	[871] = "Scarlet Halls",
	[873] = "The Veiled Stair",
	[874] = "Scarlet Monastery",
	[875] = "Gate of the Setting Sun",
	[876] = "Stormstout Brewery",
	[877] = "Shado-pan Monastery",
	[878] = "A Brewing Storm",
	[880] = "Greenstone Village",
	[882] = "Unga Ingoo",
	[883] = "Assault on Zan'vess",
	[884] = "Brewmoon Festival",
	[885] = "Mogu'Shan Palace",
	[886] = "Terrace of Endless Spring",
	[887] = "Siege of Niuzao Temple",
	[888] = "Shadowglen",
	[889] = "Valley of Trials",
	[890] = "Camp Narache",
	[891] = "Echo Isles",
	[892] = "Deathknell",
	[893] = "Sunstrider Isle",
	[894] = "Ammen Vale",
	[895] = "New Tinkertown",
	[896] = "Mogu'shan Vaults",
	[897] = "Heart of Fear",
	[898] = "Scholomance",
	[899] = "Arena of Annihilation",
	[900] = "Crypt of Forgotten Kings",
	[903] = "Shrine of Two Moons",
	[905] = "Shrine of Seven Stars",
	[906] = "Theramore's Fall (A)",
	[911] = "Lion's Landing (A)",
	[912] = "A Little Patience",
	[914] = "Dagger in the Dark",
	[920] = "Domination Point (H)",
	[928] = "Isle of Thunder",
	[929] = "Isle of Giants",
	[930] = "Throne of Thunder",
	[935] = "Deepwind Gorge",
	[937] = "Dark Heart of Pandaria",
	[938] = "The Secrets of Ragefire",
	[939] = "Blood in the Snow",
	[940] = "Battle on the High Seas",
	[941] = "Frostfire Ridge",
	[945] = "Tanaan Jungle",
	[946] = "Talador",
	[948] = "Spires of Arak",
	[949] = "Gorgrond",
	[950] = "Nagrand",
	[951] = "Timeless Isle",
	[953] = "Siege of Orgrimmar",
	[955] = "Celestial Tournament",
	[962] = "Draenor",
	[964] = "Bloodmaul Slag Mines",
	[969] = "Shadowmoon Burial Grounds",
	[970] = "Tanaan Jungle - Assault on the Dark Portal",
	[971] = "Lunarfall",
	[976] = "Frostwall",
	[978] = "Ashran",
	[984] = "Auchindoun",
	[987] = "Iron Docks",
	[989] = "Skyreach",
	[993] = "Grimrail Depot",
	[995] = "Upper Blackrock Spire ",
	[1008] = "The Everbloom",
	[1009] = "Stormshield",
	[1011] = "Warspear",
}

function mog:GetItemLabel(itemID, callback, includeIcon, iconSize)
	local name,_,quality = GetItemInfo(itemID)
	local itemname = mog:GetData("item", itemID, "itemname")
	local itemquality = mog:GetData("item", itemID, "quality")
	local includeIcon = GetItemIcon(itemID)
	
	-- Uncached items will revert to local database and show an asterisk next to them.  Non-existent items will not show an icon.
	-- GetItemInfo requires the item to be in the cache.  GetItemIcon does not.
	return (includeIcon and "|T"..GetItemIcon(itemID)..":"..(iconSize or "32") .."|t" or "")..
			(name and "|cff"..itemQualityColor[quality].." "..name .."|r" or itemname and "|cff"..itemQualityColor[itemquality].." "..itemname .."|r"..RED_FONT_COLOR_CODE.."*" or RED_FONT_COLOR_CODE..RETRIEVING_ITEM_INFO..FONT_COLOR_CODE_CLOSE)
end

local function addTooltipDoubleLine(textLeft, textRight)
	GameTooltip:AddDoubleLine(textLeft, textRight, nil, nil, nil, 1, 1, 1)
end

local function addItemTooltipLine(itemID)
	addTooltipDoubleLine(getTexture(mog:HasItem(itemID), true)..mog:GetItemLabel(itemID, "ModelOnEnter"), mog.GetItemSourceShort(itemID))
end

function mog.GetItemSourceInfo(itemID)
	local source, info;
	local sourceType = mog:GetData("item", itemID, "source");
	local sourceID = mog:GetData("item", itemID, "sourceid");
	local sourceInfo = mog:GetData("item", itemID, "sourceinfo");
	
	if sourceType == 1 and sourceID then -- Drop
		source = mog:GetData("npc", sourceID, "name");
-- IsQuestFlaggedCompleted is a MoP API.  WotLK has GetQuestsCompleted which returns all quests (option?)
--	elseif sourceType == 3 and sourceID then -- Quest	
--		info = IsQuestFlaggedCompleted(sourceID) or false;
--		info = false
	elseif sourceType == 5 and sourceInfo then -- Crafted
		source = L.professions[sourceInfo];
	elseif sourceType == 6 and sourceID then -- Achievement
		local _, name, _, complete = GetAchievementInfo(sourceID);
		source = name;
		info = complete;
	end
	
	local zone = mog:GetData("item", itemID, "zone");
	if zone then
		--zone = GetMapNameByID(zone);
		
		-- SetMapByID(zone)
		-- zone = GetMapInfo()
		-- SetMapByID(GetCurrentMapAreaID())
		local zoneNum = zone
		zone = tblZoneFix[zone]
		if zone then
			local diff = L.diffs[sourceInfo];
			if sourceType == 1 and diff then
				zone = format("%s (%s)", zone, diff);
			end
		else
			-- print(string.format("-- unable to find zone %d", zoneNum)) -- DEBUG
		end
	end
	
	return L.source[sourceType], source, zone, info;
end

function mog.GetItemSourceShort(itemID)
	local sourceType, source, zone, info = mog.GetItemSourceInfo(itemID);
	if zone then
		if source then
			sourceType = source;
		end
		source = zone;
		if sourceType == L.source[3] then
			source = format("%s (%s)", source, sourceType)
		end
	end
	return source or sourceType
end

-- create a new set and add the item to it
local function previewOnClick(self, previewFrame)
	mog:AddToPreview(self.value, mog:GetPreview(previewFrame))
	CloseDropDownMenus()
end

-- create a new set and add the item to it
local function newSetOnClick(self)
	StaticPopup_Show("MOGIT_WISHLIST_CREATE_SET", nil, nil, self.value)
	CloseDropDownMenus()
end

local previewItem = {
	text = L["Preview"],
	-- hasArrow = true,
	menuList = function(level)
		local info = UIDropDownMenu_CreateInfo()
		info.text = L["Active preview"]
		info.value = UIDROPDOWNMENU_MENU_VALUE
		info.func = previewOnClick
		info.disabled = not mog.activePreview
		info.notCheckable = true
		info.arg1 = mog.activePreview
		UIDropDownMenu_AddButton(info, level)
		
		for i, preview in ipairs(mog.previews) do
			local info = UIDropDownMenu_CreateInfo()
			info.text = format("%s %d", L["Preview"], preview:GetID())
			info.value = UIDROPDOWNMENU_MENU_VALUE
			info.func = previewOnClick
			info.notCheckable = true
			info.arg1 = preview
			UIDropDownMenu_AddButton(info, level)
		end
		
		local info = UIDropDownMenu_CreateInfo()
		info.text = L["New preview"]
		info.value = UIDROPDOWNMENU_MENU_VALUE
		info.func = previewOnClick
		info.notCheckable = true
		UIDropDownMenu_AddButton(info, level)
	end,
}

local itemOptionsMenu = {
	previewItem,
	{
		text = L["Add to wishlist"],
		func = function(self)
			mog.wishlist:AddItem(self.value)
			mog:BuildList()
			CloseDropDownMenus()
		end,
	},
	{
		text = L["Add to set"],
		hasArrow = true,
		menuList = function(level)
			mog.wishlist:AddSetMenuItems(level, "addItem", UIDROPDOWNMENU_MENU_VALUE)
			
			local info = UIDropDownMenu_CreateInfo()
			info.text = L["New set"]
			info.value = UIDROPDOWNMENU_MENU_VALUE
			info.func = newSetOnClick
			info.colorCode = GREEN_FONT_COLOR_CODE
			info.notCheckable = true
			UIDropDownMenu_AddButton(info, level)
		end,
	},
	{
		wishlist = true,
		text = L["Delete"],
		func = function(self, set)	
			mog.wishlist:DeleteItem(self.value, set.name)
			mog:BuildList(nil, "Wishlist")	
			CloseDropDownMenus()
		end,
	},
}

function mog:SetPreviewMenu(isSinglePreview)
	if isSinglePreview then
		previewItem.func = previewOnClick
		previewItem.hasArrow = nil
	else
		previewItem.func = nil
		previewItem.hasArrow = true
	end
end

function mog:AddItemOption(info)
	tinsert(itemOptionsMenu, info)
end

local function createItemMenu(dropdown, data, func)
	local items = data.items
	-- not listing the items if it's only 1 and it's not a set
	if not items or (data.item and #items == 1) then
		return
	end
	local isArray = #items > 0
	
	for i, v in ipairs(isArray and items or mog.slots) do
		v = isArray and v or items[v]
		if v then
			local info = UIDropDownMenu_CreateInfo()
			info.text = mog:GetItemLabel(v, func and "ItemMenu" or "SetMenu")
			info.value = v
			info.func = func
			info.checked = (i == data.cycle)
			info.hasArrow = true
			info.notCheckable = data.isSaved or data.name
			info.arg1 = data
			info.arg2 = i
			info.menuList = itemOptionsMenu
			dropdown:AddButton(info)
		end
	end
	return true
end

local function createMenu(self, level, menuList)
	local data = self.data
	if type(menuList) == "function" then
		menuList(level)
	else
		for i, info in ipairs(menuList) do
			if (info.wishlist == nil or info.wishlist == data.isSaved) and (not info.set or data.items) then
				info.value = UIDROPDOWNMENU_MENU_VALUE
				info.notCheckable = true
				info.arg1 = data
				self:AddButton(info, level)
			end
		end
	end
end

local slots = {
	[1] = "MainHandSlot",
	-- [2] = "mainhand",
	-- [3] = "offhand",
}

function mog.Item_FrameUpdate(self, data)
	self:ApplyDress()
	self:TryOn(("item:".. data.item.. (mog.weaponEnchant and ":"..mog.weaponEnchant or "")), slots[mog:GetData("item", data.item, "slot")])
end

local sourceLabels = {
	[L.source[1]] = BOSS,
}

GameTooltip:RegisterEvent("MODIFIER_STATE_CHANGED")
GameTooltip:HookScript("OnEvent", function(self, event, key, state)
	local owner = self:GetOwner()
	if owner and self[mog] then
		owner:OnEnter()
	end
end)
GameTooltip:HookScript("OnTooltipCleared", function(self)
	self[mog] = nil
end)

local class_HEXcolors = {
  ["HUNTER"] = "ffabd473",
  ["WARLOCK"] = "ff9482c9",
  ["PRIEST"] = "ffffffff",
  ["PALADIN"] = "fff58cba",
  ["MAGE"] = "ff69ccf0",
  ["ROGUE"] = "fffff569",
  ["DRUID"] = "ffff7d0a",
  ["SHAMAN"] = "ff0070de",
  ["WARRIOR"] = "ffc79c6e",
  ["DEATHKNIGHT"] = "ffc41f3b",
}
function mog.ShowItemTooltip(self, item, items, cycle)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip[mog] = true
	local l
	if IsAltKeyDown() then
		GameTooltip:SetHyperlink('|Hitem:'..item..'|h')
		l = true
		if cycle and #items > 1 then GameTooltip:AddLine(" ") GameTooltip:AddDoubleLine("", L["Item %d/%d"]:format(cycle, #items), nil, nil, nil, 1, 0, 0) end
	end
	
	if not l then
		-- Reverts to local database if item isn't cached
		local itemLevel = (select(4,GetItemInfo(item))) or mog:GetData("item", item, "itemlevel")
		local itemLabel = mog:GetItemLabel(item, "ModelOnEnter")
		if cycle and #items > 1 then
			GameTooltip:AddDoubleLine(itemLabel, L["Item %d/%d"]:format(cycle, #items), nil, nil, nil, 1, 0, 0)
		else
			GameTooltip:AddLine(itemLabel)
		end
		
		local bindType = mog:GetData("item", item, "bind")
		if bindType then
			addTooltipDoubleLine(L["Bind"]..":", L.bind[bindType])
		end
		-- Can't use GetItemInfo on LevelReq due to many quest items not having one
		local requiredLevel = mog:GetData("item", item, "level")
		if requiredLevel then
			addTooltipDoubleLine(LEVEL..":", requiredLevel)
		end
		addTooltipDoubleLine("Item level:", itemLevel)
		local faction = mog:GetData("item", item, "faction")
		if faction then
			addTooltipDoubleLine(FACTION..":", (faction == 1 and FACTION_ALLIANCE or FACTION_HORDE))
		end
		local class = mog:GetData("item", item, "class")
		if class and class > 0 then
			local str
			for k, v in pairs(L.classBits) do 
				if bit.band(class, v) > 0 then
					local color = class_HEXcolors[k]
					local name = LOCALIZED_CLASS_NAMES_MALE[k]
					if color and name then
						if str then
							str = format("%s, |c%s%s|r", str, color, name)
						else
							str = format("|c%s%s|r", color, name)
						end
					else print("Error: MogIt\Core\Template.lua:316 ", color,name )
					end
				end
			end
			addTooltipDoubleLine(CLASS..":", str)
		end
		local slot = mog:GetData("item", item, "slot")
		if slot then
			addTooltipDoubleLine(L["Slot"]..":", L.slots[slot])
		end
	end
	GameTooltip:AddLine(" ")
	local sourceType, source, zone, info = mog.GetItemSourceInfo(item)
	if sourceType then
		addTooltipDoubleLine(L["Source"]..":", sourceType)
		if source then
			addTooltipDoubleLine((sourceLabels[sourceType] or sourceType)..":", source)
		end
		if info ~= nil then
			addTooltipDoubleLine(STATUS..":", info and COMPLETE or INCOMPLETE)
		end
	end
	if zone then
		addTooltipDoubleLine(ZONE..":", zone)
	end
	
	GameTooltip:AddLine(" ")
	addTooltipDoubleLine(ID..":", item)
	
	if mog:HasItem(item) then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["You have this item."], 1, 1, 1)
		GameTooltip:AddTexture(TEXTURE)
	end
	
	if (not mog.active or mog.active.name ~= "Wishlist") and mog.wishlist:IsItemInWishlist(item) then
		if not mog:HasItem(item) then
			GameTooltip:AddLine(" ")
		end
		GameTooltip:AddLine(L["This item is on your wishlist."], 1, 1, 1)
		GameTooltip:AddTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_1")
	end
	
	if items and #items > 1 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["Other items using this appearance:"])
		for i, v in ipairs(items) do
			if v ~= item then
				addItemTooltipLine(v)
			end
		end
	end
	
	if l and AtlasLoot then
		if AtlasLoot.db.profile.SearchOn.All then
			AtlasLoot_LoadAllModules();
		else
			for k, v in pairs(AtlasLoot.db.profile.SearchOn) do
				if k ~= "All" and v == true and not IsAddOnLoaded(k) and LoadAddOn(k) and self.db.profile.LoDNotify then
					--DEFAULT_CHAT_FRAME:AddMessage(GREEN..AL["AtlasLoot"]..": "..ORANGE..k..WHITE.." "..AL["sucessfully loaded."]);
				end
			end
		end
		
		for dataID, data in pairs(AtlasLoot_Data) do
			for _, v in ipairs(data) do
				local id = v[2]
				if item == id then 
					local a = AtlasLoot_TableNames[dataID] and AtlasLoot_TableNames[dataID][1] or "Argh!"
					GameTooltip:AddLine(" ");
					GameTooltip:AddDoubleLine("|cff6578ffAtlasLoot: |cffffff00"..a, dataID, nil, nil, nil, 1, 1, 1);
				end
			end
		end
	end
	
	GameTooltip:Show()
end

local function showMenu(menu, data, isSaved)
	if menu:IsShown() and menu.data ~= data then
		HideDropDownMenu(1)
	end
	-- needs to be either true or false
	data.isSaved = isSaved ~= nil
	menu.data = data
	menu:Toggle(data.item, "cursor")
end

function mog.Item_OnClick(self, btn, data, isSaved)
	local item = data.item
	if not (self and item) then return end
	
	if btn == "LeftButton" then
		if (not HandleModifiedItemClick(select(2, GetItemInfo(item))) or IsAltKeyDown()) and data.items then
			data.cycle = (data.cycle % #data.items) + 1
			data.item = data.items[data.cycle]
			self:OnEnter()
		end
	elseif btn == "RightButton" then 
		if IsControlKeyDown() then 
			mog:AddToPreview(item)
		elseif IsShiftKeyDown() then
			mog:ShowURL(item)
		else
			showMenu(mog.Item_Menu, data, isSaved)
		end
	end
end

do
	local function itemOnClick(self, data, index)
		data.cycle = index
		data.item = data.items[index]
	end
	
	mog.Item_Menu = mog:CreateDropdown("Menu")
	mog.Item_Menu.initialize = function(self, level, menuList)
		local data = self.data
		
		if not menuList then
			if not createItemMenu(self, data, itemOnClick) then
				-- this is a single item, so skip directly to the item options menu
				createMenu(self, level, itemOptionsMenu)
			end
			return
		end
		
		createMenu(self, level, menuList)
	end
end

function mog.Set_FrameUpdate(self, data)
	self:ShowIndicator("label")
	self:SetText(data.name)
	self:Undress()
	for k, v in pairs(data.items) do
		self:TryOn(v, k)
	end
end

function mog.ShowSetTooltip(self, items, name)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip[mog] = true
	
	GameTooltip:AddLine(name)
	for i, slot in ipairs(mog.slots) do
		local itemID = items[slot] or items[i]
		if itemID then
			addItemTooltipLine(itemID)
		end
	end
	GameTooltip:Show()
end

function mog.Set_OnClick(self, btn, data, isSaved)
	if btn == "LeftButton" then
		if IsShiftKeyDown() then
			ChatEdit_InsertLink(mog:SetToLink(data.items))
		elseif IsControlKeyDown() then
			if mog.db.profile.dressupPreview then
				mog:AddToPreview(data.items, mog:GetPreview())
			else
				if not DressUpFrame:IsShown() or DressUpFrame.mode ~= "player" then
					DressUpFrame.mode = "player"
--					DressUpFrame.ResetButton:Show()

					local race, fileName = UnitRace("player")
					SetDressUpBackground(DressUpFrame, fileName)

					ShowUIPanel(DressUpFrame)
					DressUpModel:SetUnit("player")
				end
				DressUpModel:Undress()
				for k, v in pairs(data.items) do
					DressUpItemLink(v)
				end
			end
		end
	elseif btn == "RightButton" then
		if IsShiftKeyDown() then
			if data.set then
				mog:ShowURL(data.set, "set")
			else
				mog:ShowURL(data.items, "compare")
			end
		elseif IsControlKeyDown() then
			mog:AddToPreview(data.items, mog:GetPreview())
		else
			showMenu(mog.Set_Menu, data, isSaved)
		end
	end
end

do
	local setMenu = {
		{
			wishlist = false,
			text = L["Add set to wishlist"],
			func = function(self, set, items)
				local create = mog.wishlist:CreateSet(set)
				if create then
					for i, itemID in pairs(items) do
						mog.wishlist:AddItem(itemID, set)
					end
				end
			end,
		},
		{
			wishlist = true,
			text = L["Rename set"],
			func = function(self, set)
				mog.wishlist:RenameSet(set)
			end,
		},
		{
			wishlist = true,
			text = L["Delete set"],
			func = function(self, set)
				mog.wishlist:DeleteSet(set)
			end,
		},
	}
	
	function mog:AddSetOption(info)
		tinsert(setMenu, info)
	end
	
	mog.Set_Menu = mog:CreateDropdown("Menu")
	mog.Set_Menu.initialize = function(self, level, menuList)
		local data = self.data
		
		if not menuList then
			createItemMenu(self, data)
			
			for i, info in ipairs(setMenu) do
				if info.wishlist == nil or info.wishlist == data.isSaved then
					info.value = data.name
					info.notCheckable = true
					info.arg1 = data.name
					info.arg2 = data.items
					self:AddButton(info, level)
				end
			end
			return
		end
		
		createMenu(self, level, menuList)
	end
end