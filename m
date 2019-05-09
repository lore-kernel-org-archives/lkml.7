Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE52C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F7217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c0Evvz7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEIVOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEIVOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so1740984plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udiEMwpcNcNB7NyeY/LW3vmQ/pONNdgNOWTQwo1KqlY=;
        b=c0Evvz7SqIOpBtbszMd48zTsrve/UCxIf0zJ3NbeQdTbGmEXUbBUQ0dA2DmGDsdfmL
         5QJ/doUBjbnRNMinj4mcdm+qI8hY9z1YqO8lI9pPIMbi/3wF4n8YBVr2tyJ9sPa7j3o5
         PE2ekHh9c2rPk7lZeLT8tumnx40ByJrS3BmYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udiEMwpcNcNB7NyeY/LW3vmQ/pONNdgNOWTQwo1KqlY=;
        b=k2ud6h3MSXpFmtsCEwKPYh13cJXVRUqYwFr+9tSdh/6S490F/MO8XzX4mlzhjGV0CK
         WOYY5onerbavMRwZMIo5U+AlOES5zHGtJ5Y9yFuWzoQ7UYrkUzADaMjqbweP7Y1NzKzc
         25xBM5u0LRV6Di9X5jVMLzOt01JyLZM8hELMhsoz1ulKF6KJBmN1OvXICxVoB9ViuNVP
         y067aTzBPWaorM0E05UP4prRtV+RJ0sJ/A+e5blsncTDQNg1CGqR6Ajk5/q7uGbD+zeK
         3OpQJZtNIGDFkU59og61JCcsrV/gztIDjI1DF2ef0tDgNO9GcshYE3UD57bZffMiQbau
         T2lQ==
X-Gm-Message-State: APjAAAUKvfgVdW4AxTfrt0gJPbBko78uLMvhQU1finOGPn5wFKg38lf5
        VRZOpp6bgiejSDCvdg1sLCxBQw==
X-Google-Smtp-Source: APXvYqzaHvYO2NqU95lNWxf5E7dLuEc324JyFJKSOrlPvERXlmWHUaZy1PHRco+qjJyOyJtPPm/duA==
X-Received: by 2002:a17:902:b098:: with SMTP id p24mr8249554plr.38.1557436456796;
        Thu, 09 May 2019 14:14:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id n13sm3874787pgh.6.2019.05.09.14.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:16 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 09/30] mfd: cros_ec: Remove zero-size structs
Date:   Thu,  9 May 2019 14:13:32 -0700
Message-Id: <20190509211353.213194-10-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Empty structure size is different between C and C++.
To prevent clang warning when compiling this include file in C++
programs, remove empty structures.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 33 +++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index d8bde2b5e9ce..fabf341af97f 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1540,10 +1540,14 @@ struct lightbar_program {
 struct ec_params_lightbar {
 	uint8_t cmd;		      /* Command (see enum lightbar_command) */
 	union {
-		struct {
-			/* no args */
-		} dump, off, on, init, get_seq, get_params_v0, get_params_v1,
-			version, get_brightness, get_demo, suspend, resume;
+		/*
+		 * The following commands have no args:
+		 *
+		 * dump, off, on, init, get_seq, get_params_v0, get_params_v1,
+		 * version, get_brightness, get_demo, suspend, resume
+		 *
+		 * Don't use an empty struct, because C++ hates that.
+		 */
 
 		struct __ec_todo_unpacked {
 			uint8_t num;
@@ -1597,11 +1601,13 @@ struct ec_response_lightbar {
 			uint8_t red, green, blue;
 		} get_rgb;
 
-		struct {
-			/* no return params */
-		} off, on, init, set_brightness, seq, reg, set_rgb,
-			demo, set_params_v0, set_params_v1,
-			set_program, manual_suspend_ctrl, suspend, resume;
+		/*
+		 * The following commands have no response:
+		 *
+		 * off, on, init, set_brightness, seq, reg, set_rgb,
+		 * set_params_v0, set_params_v1, set_program,
+		 * manual_suspend_ctrl, suspend, resume
+		 */
 	};
 } __ec_todo_packed;
 
@@ -3021,9 +3027,7 @@ enum charge_state_params {
 struct ec_params_charge_state {
 	uint8_t cmd;				/* enum charge_state_command */
 	union {
-		struct {
-			/* no args */
-		} get_state;
+		/* get_state has no args */
 
 		struct __ec_todo_unpacked {
 			uint32_t param;		/* enum charge_state_param */
@@ -3049,9 +3053,8 @@ struct ec_response_charge_state {
 		struct __ec_align4 {
 			uint32_t value;
 		} get_param;
-		struct {
-			/* no return values */
-		} set_param;
+
+		/* set_param returns no args */
 	};
 } __ec_align4;
 
-- 
2.21.0.1020.gf2820cf01a-goog

