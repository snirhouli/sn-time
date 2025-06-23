local QBCore = exports['qb-core']:GetCoreObject()

-- RegisterCommand for /time (HH MM format)
RegisterCommand("time", function(source, args, rawCommand)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Check if player exists and is in the "admin" group
    if Player and Player.PlayerData.group == "admin" then
        local hour = tonumber(args[1])
        local minute = tonumber(args[2]) or 0

        -- Validate input
        if hour == nil or hour < 0 or hour > 23 then
            TriggerClientEvent('chat:addMessage', src, {
                color = {255, 0, 0},
                args = {"System", "Invalid hour. Use: /time [0-23] [0-59]"}
            })
            return
        end

        if minute < 0 or minute > 59 then
            TriggerClientEvent('chat:addMessage', src, {
                color = {255, 0, 0},
                args = {"System", "Invalid minute. Use: /time [0-59]"}
            })
            return
        end

        -- Set time on all clients
        TriggerClientEvent('qb-weathersync:client:SyncTime', -1, hour, minute)
        TriggerClientEvent('chat:addMessage', -1, {
            color = {0, 255, 0},
            args = {"Time System", "Time changed to " .. hour .. ":" .. string.format("%02d", minute) .. " by an Admin"}
        })
    else
        -- Not in admin group
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            args = {"System", "You do not have permission to use this command."}
        })
    end
end, false)