Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_75_100,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561A3C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE7214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfJKNjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:39:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35882 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfJKNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:39:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4B5102905ED
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        tzungbi@google.com, rrangel@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_trace: Match trace commands with EC commands
Date:   Fri, 11 Oct 2019 15:39:01 +0200
Message-Id: <20191011133901.11099-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some EC commands that are not included yet as trace commands,
in order to get all the traces for the all supported commands match the
commands accordingly.

Note that a change, adding or removing an EC command, should be
reflected in the cros_ec_trace.c file in order to avoid mismatches
again.

The list of current commands is generated using the following script:

 sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' \
        include/linux/platform_data/cros_ec_commands.h

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_trace.c | 73 ++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 6f80ff4532ae..8e93cccfbcf5 100644
--- a/drivers/platform/chrome/cros_ec_trace.c
+++ b/drivers/platform/chrome/cros_ec_trace.c
@@ -8,6 +8,11 @@
 // Generate the list using the following script:
 // sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/platform_data/cros_ec_commands.h
 #define EC_CMDS \
+	TRACE_SYMBOL(EC_CMD_ACPI_READ), \
+	TRACE_SYMBOL(EC_CMD_ACPI_WRITE), \
+	TRACE_SYMBOL(EC_CMD_ACPI_BURST_ENABLE), \
+	TRACE_SYMBOL(EC_CMD_ACPI_BURST_DISABLE), \
+	TRACE_SYMBOL(EC_CMD_ACPI_QUERY_EVENT), \
 	TRACE_SYMBOL(EC_CMD_PROTO_VERSION), \
 	TRACE_SYMBOL(EC_CMD_HELLO), \
 	TRACE_SYMBOL(EC_CMD_GET_VERSION), \
@@ -22,6 +27,8 @@
 	TRACE_SYMBOL(EC_CMD_GET_PROTOCOL_INFO), \
 	TRACE_SYMBOL(EC_CMD_GSV_PAUSE_IN_S5), \
 	TRACE_SYMBOL(EC_CMD_GET_FEATURES), \
+	TRACE_SYMBOL(EC_CMD_GET_SKU_ID), \
+	TRACE_SYMBOL(EC_CMD_SET_SKU_ID), \
 	TRACE_SYMBOL(EC_CMD_FLASH_INFO), \
 	TRACE_SYMBOL(EC_CMD_FLASH_READ), \
 	TRACE_SYMBOL(EC_CMD_FLASH_WRITE), \
@@ -29,6 +36,8 @@
 	TRACE_SYMBOL(EC_CMD_FLASH_PROTECT), \
 	TRACE_SYMBOL(EC_CMD_FLASH_REGION_INFO), \
 	TRACE_SYMBOL(EC_CMD_VBNV_CONTEXT), \
+	TRACE_SYMBOL(EC_CMD_FLASH_SPI_INFO), \
+	TRACE_SYMBOL(EC_CMD_FLASH_SELECT), \
 	TRACE_SYMBOL(EC_CMD_PWM_GET_FAN_TARGET_RPM), \
 	TRACE_SYMBOL(EC_CMD_PWM_SET_FAN_TARGET_RPM), \
 	TRACE_SYMBOL(EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT), \
@@ -40,6 +49,8 @@
 	TRACE_SYMBOL(EC_CMD_LED_CONTROL), \
 	TRACE_SYMBOL(EC_CMD_VBOOT_HASH), \
 	TRACE_SYMBOL(EC_CMD_MOTION_SENSE_CMD), \
+	TRACE_SYMBOL(EC_CMD_FORCE_LID_OPEN), \
+	TRACE_SYMBOL(EC_CMD_CONFIG_POWER_BUTTON), \
 	TRACE_SYMBOL(EC_CMD_USB_CHARGE_SET_MODE), \
 	TRACE_SYMBOL(EC_CMD_PSTORE_INFO), \
 	TRACE_SYMBOL(EC_CMD_PSTORE_READ), \
@@ -50,6 +61,9 @@
 	TRACE_SYMBOL(EC_CMD_RTC_SET_ALARM), \
 	TRACE_SYMBOL(EC_CMD_PORT80_LAST_BOOT), \
 	TRACE_SYMBOL(EC_CMD_PORT80_READ), \
+	TRACE_SYMBOL(EC_CMD_VSTORE_INFO), \
+	TRACE_SYMBOL(EC_CMD_VSTORE_READ), \
+	TRACE_SYMBOL(EC_CMD_VSTORE_WRITE), \
 	TRACE_SYMBOL(EC_CMD_THERMAL_SET_THRESHOLD), \
 	TRACE_SYMBOL(EC_CMD_THERMAL_GET_THRESHOLD), \
 	TRACE_SYMBOL(EC_CMD_THERMAL_AUTO_FAN_CTRL), \
@@ -59,10 +73,12 @@
 	TRACE_SYMBOL(EC_CMD_MKBP_STATE), \
 	TRACE_SYMBOL(EC_CMD_MKBP_INFO), \
 	TRACE_SYMBOL(EC_CMD_MKBP_SIMULATE_KEY), \
+	TRACE_SYMBOL(EC_CMD_GET_KEYBOARD_ID), \
 	TRACE_SYMBOL(EC_CMD_MKBP_SET_CONFIG), \
 	TRACE_SYMBOL(EC_CMD_MKBP_GET_CONFIG), \
 	TRACE_SYMBOL(EC_CMD_KEYSCAN_SEQ_CTRL), \
 	TRACE_SYMBOL(EC_CMD_GET_NEXT_EVENT), \
+	TRACE_SYMBOL(EC_CMD_KEYBOARD_FACTORY_TEST), \
 	TRACE_SYMBOL(EC_CMD_TEMP_SENSOR_GET_INFO), \
 	TRACE_SYMBOL(EC_CMD_HOST_EVENT_GET_B), \
 	TRACE_SYMBOL(EC_CMD_HOST_EVENT_GET_SMI_MASK), \
@@ -73,6 +89,7 @@
 	TRACE_SYMBOL(EC_CMD_HOST_EVENT_CLEAR), \
 	TRACE_SYMBOL(EC_CMD_HOST_EVENT_SET_WAKE_MASK), \
 	TRACE_SYMBOL(EC_CMD_HOST_EVENT_CLEAR_B), \
+	TRACE_SYMBOL(EC_CMD_HOST_EVENT), \
 	TRACE_SYMBOL(EC_CMD_SWITCH_ENABLE_BKLIGHT), \
 	TRACE_SYMBOL(EC_CMD_SWITCH_ENABLE_WIRELESS), \
 	TRACE_SYMBOL(EC_CMD_GPIO_SET), \
@@ -92,33 +109,75 @@
 	TRACE_SYMBOL(EC_CMD_CHARGE_STATE), \
 	TRACE_SYMBOL(EC_CMD_CHARGE_CURRENT_LIMIT), \
 	TRACE_SYMBOL(EC_CMD_EXTERNAL_POWER_LIMIT), \
+	TRACE_SYMBOL(EC_CMD_OVERRIDE_DEDICATED_CHARGER_LIMIT), \
+	TRACE_SYMBOL(EC_CMD_HIBERNATION_DELAY), \
 	TRACE_SYMBOL(EC_CMD_HOST_SLEEP_EVENT), \
+	TRACE_SYMBOL(EC_CMD_DEVICE_EVENT), \
 	TRACE_SYMBOL(EC_CMD_SB_READ_WORD), \
 	TRACE_SYMBOL(EC_CMD_SB_WRITE_WORD), \
 	TRACE_SYMBOL(EC_CMD_SB_READ_BLOCK), \
 	TRACE_SYMBOL(EC_CMD_SB_WRITE_BLOCK), \
 	TRACE_SYMBOL(EC_CMD_BATTERY_VENDOR_PARAM), \
-	TRACE_SYMBOL(EC_CMD_CODEC_I2S), \
-	TRACE_SYMBOL(EC_CMD_REBOOT_EC), \
-	TRACE_SYMBOL(EC_CMD_GET_PANIC_INFO), \
-	TRACE_SYMBOL(EC_CMD_ACPI_READ), \
-	TRACE_SYMBOL(EC_CMD_ACPI_WRITE), \
-	TRACE_SYMBOL(EC_CMD_ACPI_QUERY_EVENT), \
+	TRACE_SYMBOL(EC_CMD_SB_FW_UPDATE), \
+	TRACE_SYMBOL(EC_CMD_ENTERING_MODE), \
+	TRACE_SYMBOL(EC_CMD_I2C_PASSTHRU_PROTECT), \
 	TRACE_SYMBOL(EC_CMD_CEC_WRITE_MSG), \
 	TRACE_SYMBOL(EC_CMD_CEC_SET), \
 	TRACE_SYMBOL(EC_CMD_CEC_GET), \
+	TRACE_SYMBOL(EC_CMD_CODEC_I2S), \
+	TRACE_SYMBOL(EC_CMD_REBOOT_EC), \
+	TRACE_SYMBOL(EC_CMD_GET_PANIC_INFO), \
 	TRACE_SYMBOL(EC_CMD_REBOOT), \
 	TRACE_SYMBOL(EC_CMD_RESEND_RESPONSE), \
 	TRACE_SYMBOL(EC_CMD_VERSION0), \
 	TRACE_SYMBOL(EC_CMD_PD_EXCHANGE_STATUS), \
+	TRACE_SYMBOL(EC_CMD_PD_HOST_EVENT_STATUS), \
 	TRACE_SYMBOL(EC_CMD_USB_PD_CONTROL), \
 	TRACE_SYMBOL(EC_CMD_USB_PD_PORTS), \
 	TRACE_SYMBOL(EC_CMD_USB_PD_POWER_INFO), \
 	TRACE_SYMBOL(EC_CMD_CHARGE_PORT_COUNT), \
+	TRACE_SYMBOL(EC_CMD_USB_PD_FW_UPDATE), \
+	TRACE_SYMBOL(EC_CMD_USB_PD_RW_HASH_ENTRY), \
+	TRACE_SYMBOL(EC_CMD_USB_PD_DEV_INFO), \
 	TRACE_SYMBOL(EC_CMD_USB_PD_DISCOVERY), \
 	TRACE_SYMBOL(EC_CMD_PD_CHARGE_PORT_OVERRIDE), \
 	TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
-	TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
+	TRACE_SYMBOL(EC_CMD_USB_PD_GET_AMODE), \
+	TRACE_SYMBOL(EC_CMD_USB_PD_SET_AMODE), \
+	TRACE_SYMBOL(EC_CMD_PD_WRITE_LOG_ENTRY), \
+	TRACE_SYMBOL(EC_CMD_PD_CONTROL), \
+	TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO), \
+	TRACE_SYMBOL(EC_CMD_PD_CHIP_INFO), \
+	TRACE_SYMBOL(EC_CMD_RWSIG_CHECK_STATUS), \
+	TRACE_SYMBOL(EC_CMD_RWSIG_ACTION), \
+	TRACE_SYMBOL(EC_CMD_EFS_VERIFY), \
+	TRACE_SYMBOL(EC_CMD_GET_CROS_BOARD_INFO), \
+	TRACE_SYMBOL(EC_CMD_SET_CROS_BOARD_INFO), \
+	TRACE_SYMBOL(EC_CMD_GET_UPTIME_INFO), \
+	TRACE_SYMBOL(EC_CMD_ADD_ENTROPY), \
+	TRACE_SYMBOL(EC_CMD_ADC_READ), \
+	TRACE_SYMBOL(EC_CMD_ROLLBACK_INFO), \
+	TRACE_SYMBOL(EC_CMD_AP_RESET), \
+	TRACE_SYMBOL(EC_CMD_CR51_BASE), \
+	TRACE_SYMBOL(EC_CMD_CR51_LAST), \
+	TRACE_SYMBOL(EC_CMD_FP_PASSTHRU), \
+	TRACE_SYMBOL(EC_CMD_FP_MODE), \
+	TRACE_SYMBOL(EC_CMD_FP_INFO), \
+	TRACE_SYMBOL(EC_CMD_FP_FRAME), \
+	TRACE_SYMBOL(EC_CMD_FP_TEMPLATE), \
+	TRACE_SYMBOL(EC_CMD_FP_CONTEXT), \
+	TRACE_SYMBOL(EC_CMD_FP_STATS), \
+	TRACE_SYMBOL(EC_CMD_FP_SEED), \
+	TRACE_SYMBOL(EC_CMD_FP_ENC_STATUS), \
+	TRACE_SYMBOL(EC_CMD_TP_SELF_TEST), \
+	TRACE_SYMBOL(EC_CMD_TP_FRAME_INFO), \
+	TRACE_SYMBOL(EC_CMD_TP_FRAME_SNAPSHOT), \
+	TRACE_SYMBOL(EC_CMD_TP_FRAME_GET), \
+	TRACE_SYMBOL(EC_CMD_BATTERY_GET_STATIC), \
+	TRACE_SYMBOL(EC_CMD_BATTERY_GET_DYNAMIC), \
+	TRACE_SYMBOL(EC_CMD_CHARGER_CONTROL), \
+	TRACE_SYMBOL(EC_CMD_BOARD_SPECIFIC_BASE), \
+	TRACE_SYMBOL(EC_CMD_BOARD_SPECIFIC_LAST)
 
 #define CREATE_TRACE_POINTS
 #include "cros_ec_trace.h"
-- 
2.20.1

