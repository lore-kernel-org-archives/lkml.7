Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C8AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914422175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyQR7ss5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDXX3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:29:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40741 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDXX3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so10081820plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+VJSt6FVlNKMbm46PtMSFQNWA9emOnYNL3BRoOXBqs=;
        b=eyQR7ss531QbUj7fe+yP2cPtCMLkssMpEKijoefPNC84pmezgALsvDWeICvvxmB3DL
         0bbntlLjLp+SmXhxt7k6GLUaQlQ3Bgrt8l8OG8MYnulctWy4C23woD5V3fVjDcgr3DWf
         KeU4Cl5Ch8U0Ls64P9mUidPhUI+RkqUOf0eFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+VJSt6FVlNKMbm46PtMSFQNWA9emOnYNL3BRoOXBqs=;
        b=lP9Ndte1m8oAX1j56tGNr+LZSR3a3yxGQnVAUGTUcmHBf7RCBP8frJh+spc0/C+bly
         Tazy8FLQZcE2ZAwV63Yw40Jd8Zo2dlOWA6q5TFXIJBg23uN42o3BteLhnIbKGtF91Qdo
         Ln57+c8mBXO5Jqo3+/DGL+626AMxv2KPSH6BkJ0MqCSSXjizcmI88D8o8WGQ2wlsYKQA
         yerVSPb3ae+wnH54fz1lLUz4p/Bs2m/jkBak30stgDLmX3NHs8CY89SITtYsVsmbxf0u
         JzChvQPxxdonsMqPHN/nnoQ0pxqrKGe3ooYNQ5dn7l/hQiuNq1bq+ecJjdzZmwdxBDnH
         x5Wg==
X-Gm-Message-State: APjAAAXYxuHlA6JeKANSB6ccHEdezhkpP35QnLmrl8XJqq0RH/vsoAN3
        21bjcYg+VQDRXPbQbe5JPXMvWA==
X-Google-Smtp-Source: APXvYqwf31xZlNlIfKpNFLmnwSevTn95QQhVFm5yI+nhXl49Cm0BNN9H5VeIiBRBaXKTLPOpXD0GSg==
X-Received: by 2002:a17:902:9686:: with SMTP id n6mr36132871plp.282.1556148582715;
        Wed, 24 Apr 2019 16:29:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l4sm25212165pgh.17.2019.04.24.16.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:41 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 11/30] mfd: cros_ec: Add PWM_SET_DUTY API
Date:   Wed, 24 Apr 2019 16:28:59 -0700
Message-Id: <20190424232918.243308-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API for fan control.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 393c5abab7a0..5747bbcfa45f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1491,11 +1491,19 @@ struct ec_response_pwm_get_fan_rpm {
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
@@ -1504,6 +1512,7 @@ struct ec_response_pwm_get_keyboard_backlight {
 } __ec_align1;
 
 /* Set keyboard backlight */
+/* OBSOLETE - Use EC_CMD_PWM_SET_DUTY */
 #define EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT 0x0023
 
 struct ec_params_pwm_set_keyboard_backlight {
@@ -1513,10 +1522,17 @@ struct ec_params_pwm_set_keyboard_backlight {
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
2.21.0.593.g511ec345e18-goog

