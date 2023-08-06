local petting = false
local soundplaying = false

RegisterNetEvent('tg:petcat')
AddEventHandler('tg:petcat', function(source)
	local player = PlayerPedId()
	local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local animation = "machinic_loop_mechandplayer"
	loadAnimDict(animDict)
	local animLength = GetAnimDuration(animDict, animation)
	-- TaskTurnPedToFaceEntity(player, ped3, 5000)
	Wait(1500)
	petting = true
	FreezeEntityPosition(PlayerPedId(), true)
	TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 49, 0, 0, 0, 0)
	Wait(1500)
	catsound()
	Wait(Config.PetCatDuration)
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	petting = false
	soundplaying = false
end)

if Config.OxTarget then
	exports.ox_target:addBoxZone({
		coords = vec3(-575.17, -1058.14, 23.15),
		size = vec3(0.5, 0.5, 0.5),
		rotation = 150.0,
		debug = drawZones,
		options = {
			{
				name = 'box',
				event = 'tg:petcat',
				icon = 'fa-solid fa-cat',
				label = 'Pet the cat',
			}
		}
	})
	exports.ox_target:addBoxZone({
		coords = vec3(-573.99, -1054.84, 22.40),
		size = vec3(0.5, 0.5, 0.5),
		rotation = 111.99,
		debug = drawZones,
		options = {
			{
				name = 'box',
				event = 'tg:petcat',
				icon = 'fa-solid fa-cat',
				label = 'Pet the cat',
			}
		}
	})
	exports.ox_target:addBoxZone({
		coords = vec3(-576.49, -1056.34, 22.40),
		size = vec3(0.5, 0.5, 0.5),
		rotation = 292.72,
		debug = drawZones,
		options = {
			{
				name = 'box',
				event = 'tg:petcat',
				icon = 'fa-solid fa-cat',
				label = 'Pet the cat',
			}
		}
	})
	exports.ox_target:addBoxZone({
		coords = vec3(-578.63, -1050.92, 22.75),
		size = vec3(0.5, 0.5, 0.5),
		rotation =  90.0,
		debug = drawZones,
		options = {
			{
				name = 'box',
				event = 'tg:petcat',
				icon = 'fa-solid fa-cat',
				label = 'Pet the cat',
			}
		}
	})
	exports.ox_target:addBoxZone({
		coords = vec3(-584.1, -1062.91, 23.17),
		size = vec3(0.5, 0.5, 0.5),
		rotation = 200.0,
		debug = drawZones,
		options = {
			{
				name = 'box',
				event = 'tg:petcat',
				icon = 'fa-solid fa-cat',
				label = 'Pet the cat',
			}
		}
	})
end

function DrawText3D(x, y, z, text, scale)
    SetTextScale(0.35, 0.35)
	SetTextFont(8)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 300
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 155)
	ClearDrawOrigin()
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function catsound()
	if soundplaying == false then
		soundplaying = true
		SendNUIMessage({
			command = "play",
			file = 'cat',
		})
	end
end

function pet()
	local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
	local animation = "machinic_loop_mechandplayer"
	loadAnimDict(animDict)
	local animLength = GetAnimDuration(animDict, animation)
	Wait(1500)
	petting = true
	FreezeEntityPosition(PlayerPedId(), true)
	TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 49, 0, 0, 0, 0)
	Wait(1500)
	catsound()
	Wait(Config.PetCatDuration)
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
	petting = false
	soundplaying = false
end

-- Pet the cat

Citizen.CreateThread(function()
    while true do
		local sleep = 100
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(-584.05, -1062.94, 22.8, playerCoords, true)
        if distance <= 1.2 and petting == false and Config.OxTarget == false then
			sleep = 0
            DrawText3D(-584.05, -1063.0, 22.8,'[~g~E~w~] - Pet the cat')
            if IsControlJustPressed(1, 38) then
				TaskTurnPedToFaceEntity(player, ped3, 5000)
				pet()
			end
        end
		Citizen.Wait(sleep)
    end
end)


--- Spawn Cats

local uwucat = {
	Config.Cat1,
}

Citizen.CreateThread(function()
	for _,v in pairs(uwucat) do
		RequestModel(v[7])
		while not HasModelLoaded(v[7]) do
			Wait(500)
		end
		RequestAnimDict("amb@lo_res_idles@")
		while not HasAnimDictLoaded("amb@lo_res_idles@") do
			Wait(500)
		end
		ped =  CreatePed(4, v[7],v[1],v[2],v[3]-1, 3374176, false, true)
		SetEntityHeading(ped, v[5])
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped,"amb@lo_res_idles@","creatures_world_cat_ledge_sleep_lo_res_base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	end
end)

local uwucat2 = {
	Config.Cat2,
	Config.Cat3,
	Config.Cat4,
}

Citizen.CreateThread(function()
	for _,v in pairs(uwucat2) do
		RequestModel(v[7])
		while not HasModelLoaded(v[7]) do
			Wait(500)
		end
		RequestAnimDict("amb@lo_res_idles@")
		while not HasAnimDictLoaded("amb@lo_res_idles@") do
			Wait(500)
		end
		ped2 =  CreatePed(4, v[7],v[1],v[2],v[3]-1, 3374176, false, true)
		SetEntityHeading(ped2, v[5])
		FreezeEntityPosition(ped2, true)
		SetEntityInvincible(ped2, true)
		SetBlockingOfNonTemporaryEvents(ped2, true)
		TaskPlayAnim(ped2,"amb@lo_res_idles@","creatures_world_cat_ground_sleep_lo_res_base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	end
end)

local uwucat3 = {
	Config.Cat5,
}
Citizen.CreateThread(function()
	for _,v in pairs(uwucat3) do
		RequestModel(v[7])
		while not HasModelLoaded(v[7]) do
			Wait(500)
		end
		RequestAnimDict("amb@lo_res_idles@")
		while not HasAnimDictLoaded("amb@lo_res_idles@") do
			Wait(500)
		end
		ped3 =  CreatePed(4, v[7],v[1],v[2],v[3]-1, 3374176, false, true)
		SetEntityHeading(ped3, v[5])
		FreezeEntityPosition(ped3, true)
		SetEntityInvincible(ped3, true)
		SetBlockingOfNonTemporaryEvents(ped3, true)
		TaskPlayAnim(ped3,"amb@lo_res_idles@","creatures_world_cat_ledge_sleep_lo_res_base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	end
end)
