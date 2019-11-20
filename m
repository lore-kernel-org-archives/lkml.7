Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72838C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5389120730
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfKTPYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:24:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47088 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfKTPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:24:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CF2EA2910ED
Received: by earth.universe (Postfix, from userid 1000)
        id 2C9253C0C7A; Wed, 20 Nov 2019 16:24:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 4/6] ASoC: da7213: Move set_sysclk to codec level
Date:   Wed, 20 Nov 2019 16:24:04 +0100
Message-Id: <20191120152406.2744-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120152406.2744-1-sebastian.reichel@collabora.com>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move set_sysclk function to component level, so that it can be used at
both component and DAI level.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 sound/soc/codecs/da7213.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 0359249118d0..9686948b16ea 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1343,10 +1343,10 @@ static int da7213_mute(struct snd_soc_dai *dai, int mute)
 #define DA7213_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
-				 int clk_id, unsigned int freq, int dir)
+static int da7213_set_component_sysclk(struct snd_soc_component *component,
+				       int clk_id, int source,
+				       unsigned int freq, int dir)
 {
-	struct snd_soc_component *component = codec_dai->component;
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
@@ -1354,7 +1354,7 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		return 0;
 
 	if (((freq < 5000000) && (freq != 32768)) || (freq > 54000000)) {
-		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
+		dev_err(component->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
 	}
@@ -1370,7 +1370,7 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				    DA7213_PLL_MCLK_SQR_EN);
 		break;
 	default:
-		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
+		dev_err(component->dev, "Unknown clock source %d\n", clk_id);
 		return -EINVAL;
 	}
 
@@ -1380,7 +1380,7 @@ static int da7213_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		freq = clk_round_rate(da7213->mclk, freq);
 		ret = clk_set_rate(da7213->mclk, freq);
 		if (ret) {
-			dev_err(codec_dai->dev, "Failed to set clock rate %d\n",
+			dev_err(component->dev, "Failed to set clock rate %d\n",
 				freq);
 			return ret;
 		}
@@ -1507,7 +1507,6 @@ static int da7213_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 static const struct snd_soc_dai_ops da7213_dai_ops = {
 	.hw_params	= da7213_hw_params,
 	.set_fmt	= da7213_set_dai_fmt,
-	.set_sysclk	= da7213_set_dai_sysclk,
 	.set_pll	= da7213_set_dai_pll,
 	.digital_mute	= da7213_mute,
 };
@@ -1845,6 +1844,7 @@ static const struct snd_soc_component_driver soc_component_dev_da7213 = {
 	.num_dapm_widgets	= ARRAY_SIZE(da7213_dapm_widgets),
 	.dapm_routes		= da7213_audio_map,
 	.num_dapm_routes	= ARRAY_SIZE(da7213_audio_map),
+	.set_sysclk		= da7213_set_component_sysclk,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.24.0

