Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6543AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E8F2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 20:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bo0RSleA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfKFUv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:51:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32783 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfKFUv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:51:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so1014459pgn.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 12:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFiNWyMflniaQ+hxsLc2CB/Yzoo5au6Qxr5eWvWMwyU=;
        b=bo0RSleA21RYRkIBPh0hzJelWl2sSdgdAMvq0g42LmxFrQ6bgbuv9FwxQom8YBgJnQ
         NtpYAGSyo26fE4D3yBy3yimGZ5ZAvr5352XBovyTzdWmEa+gSdpyf4i8Ts+QJ4Aq2y8R
         1y7skLhOLBEFIW4SsRpf8ZgHWykU+DY1wxYOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFiNWyMflniaQ+hxsLc2CB/Yzoo5au6Qxr5eWvWMwyU=;
        b=rNrcgYHJ9m/Bh1+fB0Pkn71I8IVcLhnznQtu0tjjR0mexC1OlhiAxSFuiNzw774X0I
         P8qcfRbnnE3yZGrRdhCjhkcGSASp4FgOqZyshuFmRwp7fdevKj59fZXkW4bTv2GsRRIn
         vTc54U0U2exsOWPqg4CppPdg/Q0XFVkpYmnpnjeRDTJKOjHXP3ZY/U/p/iER/Y7ajkh3
         LgbYIDXQVJBXIvmF/8ApeFd+PUb9gtfGAcUFrLPzNBI3IcLyOFlMfGH1LlPSqWAM49UT
         lldhWE4OaoH0gRDggeBP+D5yBabL+VyS28BFXfTCGHpp4vOionldrZy02XelXHeue/Gn
         Z7fA==
X-Gm-Message-State: APjAAAWdxNaPjbrqG/7N1Qs3sHveNo/0GtkIihGaxakrAwc9T7sFmj0U
        uvCQTCHWKawx2hcmnL55PHZOZA==
X-Google-Smtp-Source: APXvYqzJMVLW10o4iKD4eb7QxoYA6IZt9AZ0vYKHbNoWhqawz9RrfJuPbhE+qGaxJFuxQ3CZQTc+3Q==
X-Received: by 2002:a63:f441:: with SMTP id p1mr5286190pgk.362.1573073483671;
        Wed, 06 Nov 2019 12:51:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id z14sm24886798pfq.66.2019.11.06.12.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 12:51:23 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     groeck@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/1] platform: chrome: Update traced EC commands
Date:   Wed,  6 Nov 2019 12:51:17 -0800
Message-Id: <20191106205117.49584-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191106205117.49584-1-gwendal@chromium.org>
References: <20191106205117.49584-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the sed script described in cros_ec_trace.c, update the list of
commands tracable.
Remove BOARD_SPECIFIC command range definition.
Check that some functions have moved, but no functions have been removed.

For testing:
echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
echo 1 > /sys/kernel/debug/tracing/tracing_on
cat /sys/kernel/debug/tracing/trace_pipe

  timberslide-... cros_ec_cmd: version: 0, command: 0x121
becomes
  timberslide-... cros_ec_cmd: version: 0, command: EC_CMD_GET_UPTIME_INFO

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_trace.c | 71 ++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
index 5af1d66d9eca..3758313beccc 100644
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
@@ -92,36 +109,76 @@
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
+	TRACE_SYMBOL(EC_CMD_SB_FW_UPDATE), \
+	TRACE_SYMBOL(EC_CMD_ENTERING_MODE), \
+	TRACE_SYMBOL(EC_CMD_I2C_PASSTHRU_PROTECT), \
+	TRACE_SYMBOL(EC_CMD_CEC_WRITE_MSG), \
+	TRACE_SYMBOL(EC_CMD_CEC_SET), \
+	TRACE_SYMBOL(EC_CMD_CEC_GET), \
 	TRACE_SYMBOL(EC_CMD_EC_CODEC), \
 	TRACE_SYMBOL(EC_CMD_EC_CODEC_DMIC), \
 	TRACE_SYMBOL(EC_CMD_EC_CODEC_I2S_RX), \
 	TRACE_SYMBOL(EC_CMD_EC_CODEC_WOV), \
 	TRACE_SYMBOL(EC_CMD_REBOOT_EC), \
 	TRACE_SYMBOL(EC_CMD_GET_PANIC_INFO), \
-	TRACE_SYMBOL(EC_CMD_ACPI_READ), \
-	TRACE_SYMBOL(EC_CMD_ACPI_WRITE), \
-	TRACE_SYMBOL(EC_CMD_ACPI_QUERY_EVENT), \
-	TRACE_SYMBOL(EC_CMD_CEC_WRITE_MSG), \
-	TRACE_SYMBOL(EC_CMD_CEC_SET), \
-	TRACE_SYMBOL(EC_CMD_CEC_GET), \
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
+	TRACE_SYMBOL(EC_CMD_CHARGER_CONTROL)
 
 #define CREATE_TRACE_POINTS
 #include "cros_ec_trace.h"
-- 
2.24.0.432.g9d3f5f5b63-goog

