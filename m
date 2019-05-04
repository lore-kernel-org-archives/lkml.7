Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8806FC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D95206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkV9CeLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfEDPRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 11:17:04 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37587 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDPRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 11:17:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so9711226edw.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKxuf/hi1yYphfQ+88mSEQc9wjYEjbyUrnqcwIgu1rk=;
        b=GkV9CeLHxp45QEwPr7UlPQCxO4xWKkm8OzvxrchpOF1GptdulXMIET8lsMxLk8/H8u
         rLJR57mikKX6OQhxrJczdiTEXxuRyjM0gh4WC14xEj8oYMnT+mTSJAjnDplqvT35I4eo
         CskCdAjugYQgvWJQ350soR5+eFuUWD2W/Xfe+zXflXWPZof3zcfAUQhe/5RGCmjcVif0
         Jvipxb6sdOdS/GtoMs29eQcVa3SRI/yDKOGdG1VOJeB4SajaKpuims8ihZWlGOVkVpS4
         RcBr8d/tzB9WrLMUpdUcRcTZwRMIUhpvqc2XoU19apiTtF5By/tam09gHtqIL47dnUkY
         2+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKxuf/hi1yYphfQ+88mSEQc9wjYEjbyUrnqcwIgu1rk=;
        b=HyCf9gJJdAmjDyoVezQ3Z0UfSUsdW3/ivO8O/xA/n9HnsNX/sDIdDylomLY4sgC5yq
         ToZokYFAyQs0ILKHnCTXjXZHjR6YSN4TDpFbcB28lOvxXP2Xgoq/hZUEb23LCQ073GVl
         CvaHZWez4PjZsgWRXskU9qRjtpcmWGHY6unghjCCWlkZ64/sAkPgc1WK0vGFw8IAiTAs
         N997Wezt+0cqGlvMHkJUyqUlEqeTtbkY0SxLRWxqUd0G+jU82JllQnmJvUVCozSafjTn
         oByMhnOedbtKFW3CqWTnJx5szUoOrzdK1O7fa84sTpGJT1gF64QDySLk2bk1eKeUFlI7
         3gzA==
X-Gm-Message-State: APjAAAXck007ZKVeKEAHqxjBDW0O1IAuDOpH5J8kul6rlgnW94+fhf5E
        J5OrEYYTfRcOKZBKWUEpi+0=
X-Google-Smtp-Source: APXvYqzYI91jwcJvMMaT9G5FwRumk2j9LLyXM+6BB+GxQwFDolbwDkJrK/enUdUkjHQJTDF392fpng==
X-Received: by 2002:a17:906:2583:: with SMTP id m3mr11319529ejb.74.1556983021553;
        Sat, 04 May 2019 08:17:01 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id v17sm51489ejj.33.2019.05.04.08.17.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 May 2019 08:17:00 -0700 (PDT)
From:   Nariman <narimantos@gmail.com>
X-Google-Original-From: Nariman <root>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, Erik Bussing <eabbussing@outlook.com>
Subject: [PATCH] ASoC: Intel: bytcr_5640.c: refactored codec_fixup
Date:   Sat,  4 May 2019 17:16:51 +0200
Message-Id: <20190504151652.5213-3-user@elitebook-localhost>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190504151652.5213-1-user@elitebook-localhost>
References: <20190504151652.5213-1-user@elitebook-localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Bussing <eabbussing@outlook.com>

Remove code duplication in byt_rt5640_codec_fixup

Signed-off-by: Erik Bussing <eabbussing@outlook.com>
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

