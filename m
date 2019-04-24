Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F47EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BF7214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYCTrvJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbfDXXbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:31:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34714 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfDXX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so10134646pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSVP1sdwAT8EQ/+FCxWW81aQ9djcRef+ot+X1kUIa3s=;
        b=TYCTrvJjj/P1aoc528skfecQjLTYQZ7MKNgTBujqmR8JoIg/YYqOsxlvirr3uw8+0A
         zVKqMI0StR/+H/NmmItvaSn6dzY6TYANlxSKDo+YRr6rRdL/OQ1vZTtQZIIjdaT8Fur7
         Ob96/6EzDMBRDuG0dPovPxjMbfHXHU4l0zNTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSVP1sdwAT8EQ/+FCxWW81aQ9djcRef+ot+X1kUIa3s=;
        b=YsWjzApTQzPTguppoEpojsn9wnax7XZxhD4/V3EBHf4sYatUa0IWhkNYUtOfU6pMjD
         iFhBDwK2ztseh/8/SWgwb5c8ltJvODbVNCIvwmuWoqAWM7xFSclZdo9aQaSnIXe1wBeM
         PKWNz1PBq7mCkNIMc2e+n88KjyhpT2dOaOQAXL30Upe2GUcFVS2G9DCE1yMOivpcYXWP
         cnsf0SmrCh3URNu86Hd6cjytir74OjkXd0rz20BsUTNxGuqK4nUrWPQN3DCveROa354q
         osYv5uH88rO4DRhqXi7cQ5zlb85uLaYZ+VL52Bm4UFxhjOEKm9GWkFjhNwkmNIP+KImN
         nj3g==
X-Gm-Message-State: APjAAAWn0FXCEuG8Krg1VG36Zhj6Mt/rmN4pRL8XjMqNid3y09I91ifT
        1dx2HFY43Qypu56VHKbpnIDfcA==
X-Google-Smtp-Source: APXvYqyqt05F0WIUgoycelCpmfrgk+r0QmwQwgSVUJxuQdPNzgZ1qUKpQQSbOcJJCf4cfo0HiKMIEw==
X-Received: by 2002:a63:6cc4:: with SMTP id h187mr20687973pgc.437.1556148583958;
        Wed, 24 Apr 2019 16:29:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id f71sm35165255pfc.109.2019.04.24.16.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:43 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 12/30] mfd: cros_ec: Add lightbar v2 API
Date:   Wed, 24 Apr 2019 16:29:00 -0700
Message-Id: <20190424232918.243308-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New API split commands, improve EC command latency.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 124 ++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 5747bbcfa45f..d55f155eb735 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1628,7 +1628,10 @@ struct lightbar_params_v1 {
 	int32_t s3_sleep_for;
 	int32_t s3_ramp_up;
 	int32_t s3_ramp_down;
+	int32_t s5_ramp_up;
+	int32_t s5_ramp_down;
 	int32_t tap_tick_delay;
+	int32_t tap_gate_delay;
 	int32_t tap_display_time;
 
 	/* Tap-for-battery params */
@@ -1656,11 +1659,82 @@ struct lightbar_params_v1 {
 	uint8_t s0_idx[2][LB_BATTERY_LEVELS];	/* AP is running */
 	uint8_t s3_idx[2][LB_BATTERY_LEVELS];	/* AP is sleeping */
 
+	/* s5: single color pulse on inhibited power-up */
+	uint8_t s5_idx;
+
 	/* Color palette */
 	struct rgb_s color[8];			/* 0-3 are Google colors */
 } __ec_todo_packed;
 
-/* Lightbar program */
+/* Lightbar command params v2
+ * crbug.com/467716
+ *
+ * lightbar_parms_v1 was too big for i2c, therefore in v2, we split them up by
+ * logical groups to make it more manageable ( < 120 bytes).
+ *
+ * NOTE: Each of these groups must be less than 120 bytes.
+ */
+
+struct lightbar_params_v2_timing {
+	/* Timing */
+	int32_t google_ramp_up;
+	int32_t google_ramp_down;
+	int32_t s3s0_ramp_up;
+	int32_t s0_tick_delay[2];		/* AC=0/1 */
+	int32_t s0a_tick_delay[2];		/* AC=0/1 */
+	int32_t s0s3_ramp_down;
+	int32_t s3_sleep_for;
+	int32_t s3_ramp_up;
+	int32_t s3_ramp_down;
+	int32_t s5_ramp_up;
+	int32_t s5_ramp_down;
+	int32_t tap_tick_delay;
+	int32_t tap_gate_delay;
+	int32_t tap_display_time;
+} __ec_todo_packed;
+
+struct lightbar_params_v2_tap {
+	/* Tap-for-battery params */
+	uint8_t tap_pct_red;
+	uint8_t tap_pct_green;
+	uint8_t tap_seg_min_on;
+	uint8_t tap_seg_max_on;
+	uint8_t tap_seg_osc;
+	uint8_t tap_idx[3];
+} __ec_todo_packed;
+
+struct lightbar_params_v2_oscillation {
+	/* Oscillation */
+	uint8_t osc_min[2];			/* AC=0/1 */
+	uint8_t osc_max[2];			/* AC=0/1 */
+	uint8_t w_ofs[2];			/* AC=0/1 */
+} __ec_todo_packed;
+
+struct lightbar_params_v2_brightness {
+	/* Brightness limits based on the backlight and AC. */
+	uint8_t bright_bl_off_fixed[2];		/* AC=0/1 */
+	uint8_t bright_bl_on_min[2];		/* AC=0/1 */
+	uint8_t bright_bl_on_max[2];		/* AC=0/1 */
+} __ec_todo_packed;
+
+struct lightbar_params_v2_thresholds {
+	/* Battery level thresholds */
+	uint8_t battery_threshold[LB_BATTERY_LEVELS - 1];
+} __ec_todo_packed;
+
+struct lightbar_params_v2_colors {
+	/* Map [AC][battery_level] to color index */
+	uint8_t s0_idx[2][LB_BATTERY_LEVELS];	/* AP is running */
+	uint8_t s3_idx[2][LB_BATTERY_LEVELS];	/* AP is sleeping */
+
+	/* s5: single color pulse on inhibited power-up */
+	uint8_t s5_idx;
+
+	/* Color palette */
+	struct rgb_s color[8];			/* 0-3 are Google colors */
+} __ec_todo_packed;
+
+/* Lightbar program. */
 #define EC_LB_PROG_LEN 192
 struct lightbar_program {
 	uint8_t size;
@@ -1674,7 +1748,10 @@ struct ec_params_lightbar {
 		 * The following commands have no args:
 		 *
 		 * dump, off, on, init, get_seq, get_params_v0, get_params_v1,
-		 * version, get_brightness, get_demo, suspend, resume
+		 * version, get_brightness, get_demo, suspend, resume,
+		 * get_params_v2_timing, get_params_v2_tap, get_params_v2_osc,
+		 * get_params_v2_bright, get_params_v2_thlds,
+		 * get_params_v2_colors
 		 *
 		 * Don't use an empty struct, because C++ hates that.
 		 */
@@ -1701,6 +1778,14 @@ struct ec_params_lightbar {
 
 		struct lightbar_params_v0 set_params_v0;
 		struct lightbar_params_v1 set_params_v1;
+
+		struct lightbar_params_v2_timing set_v2par_timing;
+		struct lightbar_params_v2_tap set_v2par_tap;
+		struct lightbar_params_v2_oscillation set_v2par_osc;
+		struct lightbar_params_v2_brightness set_v2par_bright;
+		struct lightbar_params_v2_thresholds set_v2par_thlds;
+		struct lightbar_params_v2_colors set_v2par_colors;
+
 		struct lightbar_program set_program;
 	};
 } __ec_todo_packed;
@@ -1722,6 +1807,14 @@ struct ec_response_lightbar {
 		struct lightbar_params_v0 get_params_v0;
 		struct lightbar_params_v1 get_params_v1;
 
+
+		struct lightbar_params_v2_timing get_params_v2_timing;
+		struct lightbar_params_v2_tap get_params_v2_tap;
+		struct lightbar_params_v2_oscillation get_params_v2_osc;
+		struct lightbar_params_v2_brightness get_params_v2_bright;
+		struct lightbar_params_v2_thresholds get_params_v2_thlds;
+		struct lightbar_params_v2_colors get_params_v2_colors;
+
 		struct __ec_todo_unpacked {
 			uint32_t num;
 			uint32_t flags;
@@ -1734,9 +1827,11 @@ struct ec_response_lightbar {
 		/*
 		 * The following commands have no response:
 		 *
-		 * off, on, init, set_brightness, seq, reg, set_rgb,
+		 * off, on, init, set_brightness, seq, reg, set_rgb, demo,
 		 * set_params_v0, set_params_v1, set_program,
-		 * manual_suspend_ctrl, suspend, resume
+		 * manual_suspend_ctrl, suspend, resume, set_v2par_timing,
+		 * set_v2par_tap, set_v2par_osc, set_v2par_bright,
+		 * set_v2par_thlds, set_v2par_colors
 		 */
 	};
 } __ec_todo_packed;
@@ -1765,6 +1860,18 @@ enum lightbar_command {
 	LIGHTBAR_CMD_MANUAL_SUSPEND_CTRL = 19,
 	LIGHTBAR_CMD_SUSPEND = 20,
 	LIGHTBAR_CMD_RESUME = 21,
+	LIGHTBAR_CMD_GET_PARAMS_V2_TIMING = 22,
+	LIGHTBAR_CMD_SET_PARAMS_V2_TIMING = 23,
+	LIGHTBAR_CMD_GET_PARAMS_V2_TAP = 24,
+	LIGHTBAR_CMD_SET_PARAMS_V2_TAP = 25,
+	LIGHTBAR_CMD_GET_PARAMS_V2_OSCILLATION = 26,
+	LIGHTBAR_CMD_SET_PARAMS_V2_OSCILLATION = 27,
+	LIGHTBAR_CMD_GET_PARAMS_V2_BRIGHTNESS = 28,
+	LIGHTBAR_CMD_SET_PARAMS_V2_BRIGHTNESS = 29,
+	LIGHTBAR_CMD_GET_PARAMS_V2_THRESHOLDS = 30,
+	LIGHTBAR_CMD_SET_PARAMS_V2_THRESHOLDS = 31,
+	LIGHTBAR_CMD_GET_PARAMS_V2_COLORS = 32,
+	LIGHTBAR_CMD_SET_PARAMS_V2_COLORS = 33,
 	LIGHTBAR_NUM_CMDS
 };
 
@@ -1783,6 +1890,14 @@ enum ec_led_id {
 	EC_LED_ID_POWER_LED,
 	/* LED on power adapter or its plug */
 	EC_LED_ID_ADAPTER_LED,
+	/* LED to indicate left side */
+	EC_LED_ID_LEFT_LED,
+	/* LED to indicate right side */
+	EC_LED_ID_RIGHT_LED,
+	/* LED to indicate recovery mode with HW_REINIT */
+	EC_LED_ID_RECOVERY_HW_REINIT_LED,
+	/* LED to indicate sysrq debug mode. */
+	EC_LED_ID_SYSRQ_DEBUG_LED,
 
 	EC_LED_ID_COUNT
 };
@@ -1797,6 +1912,7 @@ enum ec_led_colors {
 	EC_LED_COLOR_BLUE,
 	EC_LED_COLOR_YELLOW,
 	EC_LED_COLOR_WHITE,
+	EC_LED_COLOR_AMBER,
 
 	EC_LED_COLOR_COUNT
 };
-- 
2.21.0.593.g511ec345e18-goog

