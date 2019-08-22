Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFEAC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903FB2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLicH0OV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfHVJ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:57:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38085 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbfHVJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:57:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so5099064wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VR0Zo2f2LdCFMXPsnJEJq1uzw3++zs+EK/TmF24Zk8U=;
        b=ZLicH0OVCDzwVWhCLhka6L6kttl49SH+prKuYjagxN7kq1n1T3Z4NJUEBiDUB8J/W9
         C02+TSE7jcGLseF16/U7Eex53jFAzc0NXIGEe4YL8Rlhi1ULSJ5SoujcSB2y6COp7GI3
         6aet3GSxhuQxqyS6RlnCI/mwU0aglT+LqRCsOXfy9NsYl6jYLjcjTOAgP9mT9/V/D7/0
         uTw00t8G/TL911SQB9cLayd1WfnzQ7earGqZLu+5/tm42r219H7s1CurqP12c1vorOgJ
         caQbmfo2k5cr2A1rFoCHr91UoriaATMIk8nOHvbtsLRTFlLbm8W1PaXoFGGwr6kcHiVR
         3aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VR0Zo2f2LdCFMXPsnJEJq1uzw3++zs+EK/TmF24Zk8U=;
        b=HJ3bywNgOSk4YpNDOcNIQEAJnlaszI0uaTufwB/rQ+LaV/N2Nm1ZCAbrav7bhaersC
         0/yqFhBX/rx8F63je05CYkG/REM9Tz+MfqX2zLOMjYNy81izWX+mdHUn+Oo6sPtBbRKQ
         hjxosJy4aLGvg1rUiekpCE0Mpm12qdnsIWEQ9QfLwtGQFIEC4bcZrF0/sJsMt16fV+xq
         KBj+OJgmdyNC92aLeGWVwdnFi6nRlV1HcSVCoyI8ZXNTA7UvcjjOW7oOBF/SpY8iN198
         xMGVQJax7n0prfKW+6A0pIfJ5zau3j8QUQudVefHWJVWU0jzEx0ae9xI769+cJ11LJkG
         94IA==
X-Gm-Message-State: APjAAAVF9pTBrpr1V7Un5BvLp7Sunluayp41wKdUdvgfqZBwgfPsQa7K
        gMHh3Q0VgaIkaHfFEX1KDdf57g==
X-Google-Smtp-Source: APXvYqxeC7PmjNh3A9bR7xWK9OwPh/lSdL8HYSddkfR3Lrm/ispW2G8paCYcovsDSmi6UIpWWXGfpQ==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr5202229wmg.20.1566467853328;
        Thu, 22 Aug 2019 02:57:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t24sm3298909wmj.14.2019.08.22.02.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 02:57:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/4] ASoC: qdsp6: q6asm-dai: fix max rates on q6asm dais
Date:   Thu, 22 Aug 2019 10:56:53 +0100
Message-Id: <20190822095653.7200-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q6ASM dais support max rate up to 384KHz, update this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 548eb4fa2da6..5eaeadec8492 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -80,9 +80,9 @@ static struct snd_pcm_hardware q6asm_dai_hardware_capture = {
 				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE |
 				SNDRV_PCM_FMTBIT_S24_LE),
-	.rates =                SNDRV_PCM_RATE_8000_48000,
+	.rates =                SNDRV_PCM_RATE_8000_384000,
 	.rate_min =             8000,
-	.rate_max =             48000,
+	.rate_max =             384000,
 	.channels_min =         1,
 	.channels_max =         4,
 	.buffer_bytes_max =     CAPTURE_MAX_NUM_PERIODS *
@@ -102,9 +102,9 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE |
 				SNDRV_PCM_FMTBIT_S24_LE),
-	.rates =                SNDRV_PCM_RATE_8000_192000,
+	.rates =                SNDRV_PCM_RATE_8000_384000,
 	.rate_min =             8000,
-	.rate_max =             192000,
+	.rate_max =             384000,
 	.channels_min =         1,
 	.channels_max =         8,
 	.buffer_bytes_max =     (PLAYBACK_MAX_NUM_PERIODS *
@@ -119,25 +119,25 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 #define Q6ASM_FEDAI_DRIVER(num) { \
 		.playback = {						\
 			.stream_name = "MultiMedia"#num" Playback",	\
-			.rates = (SNDRV_PCM_RATE_8000_192000|		\
+			.rates = (SNDRV_PCM_RATE_8000_384000|		\
 					SNDRV_PCM_RATE_KNOT),		\
 			.formats = (SNDRV_PCM_FMTBIT_S16_LE |		\
 					SNDRV_PCM_FMTBIT_S24_LE),	\
 			.channels_min = 1,				\
 			.channels_max = 8,				\
 			.rate_min =     8000,				\
-			.rate_max =	192000,				\
+			.rate_max =	384000,				\
 		},							\
 		.capture = {						\
 			.stream_name = "MultiMedia"#num" Capture",	\
-			.rates = (SNDRV_PCM_RATE_8000_48000|		\
+			.rates = (SNDRV_PCM_RATE_8000_384000|		\
 					SNDRV_PCM_RATE_KNOT),		\
 			.formats = (SNDRV_PCM_FMTBIT_S16_LE |		\
 				    SNDRV_PCM_FMTBIT_S24_LE),		\
 			.channels_min = 1,				\
 			.channels_max = 4,				\
 			.rate_min =     8000,				\
-			.rate_max =	48000,				\
+			.rate_max =	384000,				\
 		},							\
 		.name = "MultiMedia"#num,				\
 		.id = MSM_FRONTEND_DAI_MULTIMEDIA##num,			\
@@ -146,7 +146,7 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 /* Conventional and unconventional sample rate supported */
 static unsigned int supported_sample_rates[] = {
 	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
-	88200, 96000, 176400, 192000
+	88200, 96000, 176400, 192000, 352800, 384000
 };
 
 static struct snd_pcm_hw_constraint_list constraints_sample_rates = {
-- 
2.21.0

