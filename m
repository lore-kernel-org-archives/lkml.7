Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D47FC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD81233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G36uhWdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbfHVJ5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:57:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34666 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732515AbfHVJ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:57:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so6723499wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ODWBtpVLXMipclxHeFDJwXNUN4EjiRweHSVWcVI6sA=;
        b=G36uhWdjCUarled0tt/nSqTGRJQobhmevHt5CRxzXkO/id6ns//zyh8swvKcYiP5hP
         MePfesYxsFXE+AH+vUpilA6rkLRBJ60Ami99R4xugrNxzNGYXhlYndPwx7r8fCspudEC
         5dTZ5I9O7i15l2VxKUyEGtr3pKlSrTedwqFffBImWCL5QM4j4RQb5JY7kcqXMsx9ONlP
         DOPHXkE2zWy8y48D4N7xbSn9FB3XIjYe4L+1c1qSu8wsbhbeMaa7U0Ok9t2KLJBJn3+9
         g0+9o6mCl0LRK634Bl4jG8LFfJ9q/h9Y89CHoJ2ipMsCxuFDrXAhXKHKIECZhs04Rr/9
         hiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ODWBtpVLXMipclxHeFDJwXNUN4EjiRweHSVWcVI6sA=;
        b=PJxBlgBFbkMTE96PseDc4sqe18jvANDp77d+zJ7TymanGQLWY4i3au2hPL9txLx7so
         8voiVVAuhOWqVzIQpkuUIis5UvDyq1fMCTEEEVHG2Sms0e0Up7+oBKb4uw+XFHeYJR4s
         zVKLkB+Dt+uRsT3UwoszI5A1beVbxvht4/P8wTvNcYsyA3glAX1CHfdrxOTNERz8Gdfp
         I9iw7kUO5Zj2FookpXMoHV5gfdmmysd/B8iTwTUybYd7+c7qtY8MoDid/FKk+UikeeqC
         /X5cm6++cFvzN1AP/U3ftrNab1q1SpbYoVc6DZs9Rh4E0ZFFVvPFELccH/8S1JpYzhVe
         RUMA==
X-Gm-Message-State: APjAAAV0BfynCEVZ/gdx1bXZ833BoTGsnX9XA2+anT6pFYOrGlGFkWpm
        HCx4b9TqsBSKy2BPllL9TQTuOw==
X-Google-Smtp-Source: APXvYqxjfvPKXwZ5wrQs6B9UpLQ68Dhwn+dJarTiv+pkkJKtnaXNqYzjP96D+uOlERQ+0fxYsHfW4w==
X-Received: by 2002:a05:600c:24cb:: with SMTP id 11mr5205419wmu.94.1566467852327;
        Thu, 22 Aug 2019 02:57:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t24sm3298909wmj.14.2019.08.22.02.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 02:57:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, tiwai@suse.de
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/4] ASoC: qdsp6: q6afe-dai: Update max rate for slim and tdm dais
Date:   Thu, 22 Aug 2019 10:56:52 +0100
Message-Id: <20190822095653.7200-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QDSP supports up to 384000 rates on SLIM dais and 352800 rate on TDM dais.
Add this missing rates.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 92 +++++++++++---------------------
 1 file changed, 32 insertions(+), 60 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index c1a7624eaf17..ae2baefdb6e2 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -18,14 +18,14 @@
 			.stream_name = pre" TDM"#num" Playback",	\
 			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
-				SNDRV_PCM_RATE_176400,			\
+				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_352800,\
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
 				   SNDRV_PCM_FMTBIT_S24_LE |		\
 				   SNDRV_PCM_FMTBIT_S32_LE,		\
 			.channels_min = 1,				\
 			.channels_max = 8,				\
 			.rate_min = 8000,				\
-			.rate_max = 176400,				\
+			.rate_max = 352800,				\
 		},							\
 		.name = #did,						\
 		.ops = &q6tdm_ops,					\
@@ -39,14 +39,14 @@
 			.stream_name = pre" TDM"#num" Capture",		\
 			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
-				SNDRV_PCM_RATE_176400,			\
+				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_352800,\
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
 				   SNDRV_PCM_FMTBIT_S24_LE |		\
 				   SNDRV_PCM_FMTBIT_S32_LE,		\
 			.channels_min = 1,				\
 			.channels_max = 8,				\
 			.rate_min = 8000,				\
-			.rate_max = 176400,				\
+			.rate_max = 352800,				\
 		},							\
 		.name = #did,						\
 		.ops = &q6tdm_ops,					\
@@ -646,15 +646,13 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.playback = {
 			.stream_name = "Slimbus Playback",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.name = "SLIMBUS_0_TX",
@@ -664,28 +662,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus1 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_1_RX",
 		.ops = &q6slim_ops,
@@ -700,28 +694,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus1 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus2 Playback",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_2_RX",
 		.ops = &q6slim_ops,
@@ -737,28 +727,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus2 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus3 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_3_RX",
 		.ops = &q6slim_ops,
@@ -774,28 +760,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus3 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus4 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_4_RX",
 		.ops = &q6slim_ops,
@@ -811,28 +793,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus4 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus5 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_5_RX",
 		.ops = &q6slim_ops,
@@ -848,28 +826,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus5 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus6 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.ops = &q6slim_ops,
 		.name = "SLIMBUS_6_RX",
@@ -885,15 +859,13 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus6 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
-- 
2.21.0

