Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C9626FBA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bfYJ8fj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfFCSeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:34:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfFCSeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so8776588pgr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xR/DqzMPPrGoxIaTkZ/7kRPuceWz8Gdr8xXSBUOz7TU=;
        b=bfYJ8fj9wVH1yn5yGINhXXWE1At3YMNb6Y0xeOAjezyruuwiJEQEyG9IXk8/Xyxv/F
         3bYLBjQSzdXCMBRSaNl6yK65762TU3ktA8kLNcB7IBYJ5YvWNLhLBGc/Y+w9ykDaQKdr
         4HvGwZEvS27lBIGHp5UFN7PNifNh2xSlHqtug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xR/DqzMPPrGoxIaTkZ/7kRPuceWz8Gdr8xXSBUOz7TU=;
        b=CLJ0FL0erZWHlEv0QnnPm9gb0vzxqMnDDytMyk+S/ci7naQRktxQaE2Cl9T+wgRyDE
         0R156G1lOButaxaxh1XeNux490SDCvtJoEBmWLopq2Zqy9cv7luYUcASiBRj28MCssu3
         wyQg8Py0XeGoTOmvb+rQmCb2eBf3s3vKD2fdTLRc6HH30ZF9oajmivnyN2mb2Tjm4R8G
         8Jsa491wrFZnjEytyP14daW+g/b7je8mUfOCktb8KI7EJ0+QXYP8L9ywSNHYLOX6u0Gs
         82Cv3AvFVSLIfR+1MarOPNJo+Lllyz5MMAmPSfaFATuwmM2wql0c3LcOJ9RAkVIyi/Rc
         ffBw==
X-Gm-Message-State: APjAAAVLho/gKHUrpMb3CGMd+G+um5D2gVsBSmzBVHXCXxf90bYYFmiw
        jnkjld/89z6j9L7yNsCocJC04Q==
X-Google-Smtp-Source: APXvYqygT0XNI8h64SjktMSZPQleURftsQ4W7ozR3Nyn0mjSN4fdixVEnbNaAlewO6HpmWOFMF9v/g==
X-Received: by 2002:a62:6507:: with SMTP id z7mr33922308pfb.225.1559586863362;
        Mon, 03 Jun 2019 11:34:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p18sm3267243pff.93.2019.06.03.11.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:22 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 11/30] mfd: cros_ec: Add PWM_SET_DUTY API
Date:   Mon,  3 Jun 2019 11:33:42 -0700
Message-Id: <20190603183401.151408-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API for fan control.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 3d1d26f62bd3..2b3a94a4f0f4 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1521,11 +1521,19 @@ struct ec_response_pwm_get_fan_rpm {
 /* Set target fan RPM */
 #define EC_CMD_PWM_SET_FAN_TARGET_RPM 0x0021
 
-struct ec_params_pwm_set_fan_target_rpm {
+/* Version 0 of input params */
+struct ec_params_pwm_set_fan_target_rpm_v0 {
 	uint32_t rpm;
+} __ec_align4;
+
+/* Version 1 of input params */
+struct ec_params_pwm_set_fan_target_rpm_v1 {
+	uint32_t rpm;
+	uint8_t fan_idx;
 } __ec_align_size1;
 
 /* Get keyboard backlight */
+/* OBSOLETE - Use EC_CMD_PWM_SET_DUTY */
 #define EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT 0x0022
 
 struct ec_response_pwm_get_keyboard_backlight {
@@ -1534,6 +1542,7 @@ struct ec_response_pwm_get_keyboard_backlight {
 } __ec_align1;
 
 /* Set keyboard backlight */
+/* OBSOLETE - Use EC_CMD_PWM_SET_DUTY */
 #define EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT 0x0023
 
 struct ec_params_pwm_set_keyboard_backlight {
@@ -1543,10 +1552,17 @@ struct ec_params_pwm_set_keyboard_backlight {
 /* Set target fan PWM duty cycle */
 #define EC_CMD_PWM_SET_FAN_DUTY 0x0024
 
-struct ec_params_pwm_set_fan_duty {
+/* Version 0 of input params */
+struct ec_params_pwm_set_fan_duty_v0 {
 	uint32_t percent;
 } __ec_align4;
 
+/* Version 1 of input params */
+struct ec_params_pwm_set_fan_duty_v1 {
+	uint32_t percent;
+	uint8_t fan_idx;
+} __ec_align_size1;
+
 #define EC_CMD_PWM_SET_DUTY 0x0025
 /* 16 bit duty cycle, 0xffff = 100% */
 #define EC_PWM_MAX_DUTY 0xffff
-- 
2.21.0.1020.gf2820cf01a-goog

