Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59276C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F33120675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Om4Lg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfESR5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:57:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38961 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfESR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:57:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id e24so19942804edq.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSaFCnfR2bfpWEW9+IDASa3q4Pa8ivn5CKtNahd44Kw=;
        b=a1Om4Lg2C4tZiOySg407er5np9/4sFg5OyicTgChtep3koC5J4Tq5ZOCeAdArP4JR8
         qJWUcrttMW0Sxm4FGjhIZY0RbgRIkszIDnSvKEXWtx0iyKeaCOSCFE/i8RCX5qASIjZp
         9eheKazLMp2cN10t+brNYq+fiVTdjdIIIZCmEwX6XCWEreYVF3KELUiVRpe//V1bnKek
         eTa5zqObwT3B8jMtczMbR0tIFovKr0E+I/EDjxVcTbJxgTa3w2QsslPcVeCH1iX6BXLj
         9iN3A/kkj5nIqcZA0DzO4Ifi7Ub9G03q7WJOsSG8ms9023GUxugT6Uo9wI1KiD/GpE1U
         qdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSaFCnfR2bfpWEW9+IDASa3q4Pa8ivn5CKtNahd44Kw=;
        b=AiSdKF2FYv4i+h34t7v7uqQLtC10MbcT2mkhVHTA8O5oc9bNg0gJ4Zfpy030k2tYeD
         b11G9suKxit8WV2gtgMHVgEiJlXefpI32lVYHchLk1zlZc7wVHLzJMfJcbLBIWmBrq4y
         G+sUeZ4Z8eMwM5imc6Cjj0lLRxYru/uS+v1iR48mdt0YdVoe7U64kSE3QbyLq8dcG5w3
         1CLk9RPTaOgfLzVdlkzijQeOX2sJ/NgrFnTVwP7HpJWv40HBnrmZuVYmXI+nkjzx5Tc/
         u5P+zq8Qag8YwtvuaWoGFc0ZGmwMg0KJabmuRX8XWVdAbU24XzcjzVXaUuYxXN52C1ml
         lh2A==
X-Gm-Message-State: APjAAAUyv0TskYhz914r5HT14RDBDxD/zf1K9o4yr5Gx1JmiZXeYO1J6
        hsBD6khaaZCXKWnoBOA9urg=
X-Google-Smtp-Source: APXvYqyPTzo5wN45lTEMnmrBzu4K9xsaODSRQIEWRmXE+7IyXmsFj5WvAzAKwjjPXJD3Yr7suxsa+w==
X-Received: by 2002:aa7:c4d2:: with SMTP id p18mr70897008edr.232.1558288648755;
        Sun, 19 May 2019 10:57:28 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id x22sm5000877edd.59.2019.05.19.10.57.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 10:57:28 -0700 (PDT)
From:   nariman <narimantos@gmail.com>
To:     broonie@kernel.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Erik Bussing <eabbussing@outlook.com>,
        Nariman Etemadi <narimantos@gmail.com>
Subject: [PATCH] ASoC: Intel: bytcr_5640.c: refactored codec_fixup
Date:   Sun, 19 May 2019 19:57:05 +0200
Message-Id: <20190519175706.3998-3-narimantos@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190519175706.3998-1-narimantos@gmail.com>
References: <20190519175706.3998-1-narimantos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Bussing <eabbussing@outlook.com>

Remove code duplication in byt_rt5640_codec_fixup

Signed-off-by: Erik Bussing <eabbussing@outlook.com>
Signed-off-by: Nariman Etemadi <narimantos@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 64 ++++++++++-----------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a22366ce33c4..679be55418bf 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -939,6 +939,7 @@ static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
 	int ret;
+	int bits;
 
 	/* The DSP will covert the FE rate to 48k, stereo */
 	rate->min = rate->max = 48000;
@@ -949,53 +950,34 @@ static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 
 		/* set SSP0 to 16-bit */
 		params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
-
-		/*
-		 * Default mode for SSP configuration is TDM 4 slot, override config
-		 * with explicit setting to I2S 2ch 16-bit. The word length is set with
-		 * dai_set_tdm_slot() since there is no other API exposed
-		 */
-		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
-					SND_SOC_DAIFMT_I2S     |
-					SND_SOC_DAIFMT_NB_NF   |
-					SND_SOC_DAIFMT_CBS_CFS
-			);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
-			return ret;
-		}
-
-		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 16);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
-			return ret;
-		}
-
+	bits = 16;
 	} else {
 
 		/* set SSP2 to 24-bit */
 		params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+		bits = 24;
+	}
 
-		/*
-		 * Default mode for SSP configuration is TDM 4 slot, override config
-		 * with explicit setting to I2S 2ch 24-bit. The word length is set with
-		 * dai_set_tdm_slot() since there is no other API exposed
-		 */
-		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
-					SND_SOC_DAIFMT_I2S     |
-					SND_SOC_DAIFMT_NB_NF   |
-					SND_SOC_DAIFMT_CBS_CFS
-			);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
-			return ret;
-		}
 
-		ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
-		if (ret < 0) {
-			dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
-			return ret;
-		}
+	/*
+	 * Default mode for SSP configuration is TDM 4 slot, override config
+	 * with explicit setting to I2S 2ch 24-bit. The word length is set with
+	 * dai_set_tdm_slot() since there is no other API exposed
+	 */
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+		SND_SOC_DAIFMT_I2S     |
+		SND_SOC_DAIFMT_NB_NF   |
+		SND_SOC_DAIFMT_CBS_CFS
+	);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, bits);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
+		return ret;
 	}
 	return 0;
 }
-- 
2.20.1

