Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E43D214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LAqafPdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfDXXaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:30:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41976 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbfDXXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:30:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so4149039pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HYjf9SJs9ck8PnwlZQuwTv6BnlCxYDnL7IN+CVipoD8=;
        b=LAqafPdU7zDF0DIgJfbDnPwGyN9JsalPqTdWkKxPEkNdlQWhWMiEF6xbKgpcsnPJfi
         y6B6gC7jUGuxAUhx/LncDKClP9hvD3I0PalvOZOadPnS6xnePVpGFmviDQSc6HQSxcpJ
         fCsRCYDRKRlarQK4iyUpzM5Xca/I6CAr6tdTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HYjf9SJs9ck8PnwlZQuwTv6BnlCxYDnL7IN+CVipoD8=;
        b=degjD9p2sWfW+xLhuSJjnnv0sXsMt4fTxfmBxyVV+BzfYG/O8DyKGZdAJvzve48Wma
         smseze43kkk/jEF1xjTtX0TpBYoUsQKaOTzznmtc/szo3GaYcWh/NC+jyokjXcGqOWE2
         s09nHgxyn//JV/+9DgYT/TVnZ3WrJ9r+e4AUd4PSloI7AUEsAx7LXUS5n8SurfY6X6HL
         FbBavyyWGYBMZHk9s+juK8ni/WiLuBmJwpVRvYSt1Rd8QHzt4EYes1QtEr4Ugue2PVCA
         toOuQnziWYyZeLp3DJ20acWmb3Vkvs7RBV9M8usdVxk79Wdin5swdZ5mMVFs/y7j4AWc
         Dr/g==
X-Gm-Message-State: APjAAAUDxmDNhEbO/HxxUEv2uK5N5lLxWJQFCwpCGsVFp69rOdrkNhCO
        iCMEQLBXaWs2Lpt3pdxTTcfMEw==
X-Google-Smtp-Source: APXvYqyyA9NhrwXiHpkob0yPeQhNaMNKu7Eep90Z4Q2aufbOvhDn/GYaO+ildkT76QkVAnLu7lSvZw==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr35213666plb.219.1556148600248;
        Wed, 24 Apr 2019 16:30:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 129sm35263704pgc.24.2019.04.24.16.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:59 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 24/30] mfd: cros_ec: Update I2S API
Date:   Wed, 24 Apr 2019 16:29:12 -0700
Message-Id: <20190424232918.243308-25-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve I2S API.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 44 +++++++++++++---------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 59ad6bae3f9b..c1fe64c0957b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4417,6 +4417,7 @@ enum mkbp_cec_event {
 /* Commands for I2S recording on audio codec. */
 
 #define EC_CMD_CODEC_I2S 0x00BC
+#define EC_WOV_I2S_SAMPLE_RATE 48000
 
 enum ec_codec_i2s_subcmd {
 	EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
@@ -4426,6 +4427,7 @@ enum ec_codec_i2s_subcmd {
 	EC_CODEC_I2S_SET_CONFIG = 0x4,
 	EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
 	EC_CODEC_I2S_SET_BCLK = 0x6,
+	EC_CODEC_I2S_SUBCMD_COUNT = 0x7,
 };
 
 enum ec_sample_depth_value {
@@ -4442,6 +4444,21 @@ enum ec_i2s_config {
 	EC_DAI_FMT_PCM_TDM = 5,
 };
 
+/*
+ * For subcommand EC_CODEC_GET_GAIN.
+ */
+struct __ec_align1 ec_codec_i2s_gain {
+	uint8_t left;
+	uint8_t right;
+};
+
+struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
+	int16_t ch0_delay; /* 0 to 496 */
+	int16_t ch1_delay; /* -1 to 496 */
+	uint8_t adjacent_to_ch0;
+	uint8_t adjacent_to_ch1;
+};
+
 struct __ec_todo_packed ec_param_codec_i2s {
 	/* enum ec_codec_i2s_subcmd */
 	uint8_t cmd;
@@ -4456,10 +4473,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_SET_GAIN
 		 * Value should be 0~43 for both channels.
 		 */
-		struct __ec_align1 ec_param_codec_i2s_set_gain {
-			uint8_t left;
-			uint8_t right;
-		} gain;
+		struct ec_codec_i2s_gain gain;
 
 		/*
 		 * EC_CODEC_I2S_ENABLE
@@ -4468,7 +4482,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		uint8_t i2s_enable;
 
 		/*
-		 * EC_CODEC_I2S_SET_COFNIG
+		 * EC_CODEC_I2S_SET_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
 		uint8_t i2s_config;
@@ -4477,18 +4491,7 @@ struct __ec_todo_packed ec_param_codec_i2s {
 		 * EC_CODEC_I2S_SET_TDM_CONFIG
 		 * Value should be one of ec_i2s_config.
 		 */
-		struct __ec_todo_unpacked ec_param_codec_i2s_tdm {
-			/*
-			 * 0 to 496
-			 */
-			int16_t ch0_delay;
-			/*
-			 * -1 to 496
-			 */
-			int16_t ch1_delay;
-			uint8_t adjacent_to_ch0;
-			uint8_t adjacent_to_ch1;
-		} tdm_param;
+		struct ec_param_codec_i2s_tdm tdm_param;
 
 		/*
 		 * EC_CODEC_I2S_SET_BCLK
@@ -4497,13 +4500,6 @@ struct __ec_todo_packed ec_param_codec_i2s {
 	};
 };
 
-/*
- * For subcommand EC_CODEC_GET_GAIN.
- */
-struct ec_response_codec_gain {
-	uint8_t left;
-	uint8_t right;
-} __ec_align1;
 
 /*****************************************************************************/
 /* System commands */
-- 
2.21.0.593.g511ec345e18-goog

