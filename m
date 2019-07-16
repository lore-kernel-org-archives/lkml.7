Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB6C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684FB20665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfGPJzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:55:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50148 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbfGPJzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:55:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0847820004B;
        Tue, 16 Jul 2019 11:55:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69425200008;
        Tue, 16 Jul 2019 11:55:43 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C00E040293;
        Tue, 16 Jul 2019 17:55:37 +0800 (SGT)
From:   shengjiu.wang@nxp.com
To:     brian.austin@cirrus.com, Paul.Handrigan@cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: cs42xx8: Fix MFREQ selection issue for async mode
Date:   Tue, 16 Jul 2019 17:45:47 +0800
Message-Id: <20190716094547.46787-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

When sample rate of TX is different with sample rate of RX in
async mode, the MFreq selection will be wrong.

For example, sysclk = 24.576MHz, TX rate = 96000Hz, RX rate = 48000Hz.
Then ratio of TX = 256, ratio of RX = 512, For MFreq is shared by TX
and RX instance, the correct value of MFreq is 2 for both TX and RX.

But original method will cause MFreq = 0 for TX, MFreq = 2 for RX.
If TX is started after RX, RX will be impacted, RX work abnormal with
MFreq = 0.

This patch is to select proper MFreq value according to TX rate and
RX rate.

Fixes: 0c516b4ff85c ("ASoC: cs42xx8: Add codec driver support for CS42448/CS42888")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/cs42xx8.c | 116 +++++++++++++++++++++++++++++++------
 1 file changed, 97 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index b377cddaf2e6..804969495754 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -47,6 +47,7 @@ struct cs42xx8_priv {
 	unsigned long sysclk;
 	u32 tx_channels;
 	struct gpio_desc *gpiod_reset;
+	u32 rate[2];
 };
 
 /* -127.5dB to 0dB with step of 0.5dB */
@@ -176,21 +177,27 @@ static const struct snd_soc_dapm_route cs42xx8_adc3_dapm_routes[] = {
 };
 
 struct cs42xx8_ratios {
-	unsigned int ratio;
-	unsigned char speed;
-	unsigned char mclk;
+	unsigned int mfreq;
+	unsigned int min_mclk;
+	unsigned int max_mclk;
+	unsigned int ratio[3];
 };
 
+/*
+ * According to reference mannual, define the cs42xx8_ratio struct
+ * MFreq2 | MFreq1 | MFreq0 |     Description     | SSM | DSM | QSM |
+ * 0      | 0      | 0      |1.029MHz to 12.8MHz  | 256 | 128 |  64 |
+ * 0      | 0      | 1      |1.536MHz to 19.2MHz  | 384 | 192 |  96 |
+ * 0      | 1      | 0      |2.048MHz to 25.6MHz  | 512 | 256 | 128 |
+ * 0      | 1      | 1      |3.072MHz to 38.4MHz  | 768 | 384 | 192 |
+ * 1      | x      | x      |4.096MHz to 51.2MHz  |1024 | 512 | 256 |
+ */
 static const struct cs42xx8_ratios cs42xx8_ratios[] = {
-	{ 64, CS42XX8_FM_QUAD, CS42XX8_FUNCMOD_MFREQ_256(4) },
-	{ 96, CS42XX8_FM_QUAD, CS42XX8_FUNCMOD_MFREQ_384(4) },
-	{ 128, CS42XX8_FM_QUAD, CS42XX8_FUNCMOD_MFREQ_512(4) },
-	{ 192, CS42XX8_FM_QUAD, CS42XX8_FUNCMOD_MFREQ_768(4) },
-	{ 256, CS42XX8_FM_SINGLE, CS42XX8_FUNCMOD_MFREQ_256(1) },
-	{ 384, CS42XX8_FM_SINGLE, CS42XX8_FUNCMOD_MFREQ_384(1) },
-	{ 512, CS42XX8_FM_SINGLE, CS42XX8_FUNCMOD_MFREQ_512(1) },
-	{ 768, CS42XX8_FM_SINGLE, CS42XX8_FUNCMOD_MFREQ_768(1) },
-	{ 1024, CS42XX8_FM_SINGLE, CS42XX8_FUNCMOD_MFREQ_1024(1) }
+	{ 0, 1029000, 12800000, {256, 128, 64} },
+	{ 2, 1536000, 19200000, {384, 192, 96} },
+	{ 4, 2048000, 25600000, {512, 256, 128} },
+	{ 6, 3072000, 38400000, {768, 384, 192} },
+	{ 8, 4096000, 51200000, {1024, 512, 256} },
 };
 
 static int cs42xx8_set_dai_sysclk(struct snd_soc_dai *codec_dai,
@@ -257,14 +264,68 @@ static int cs42xx8_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct cs42xx8_priv *cs42xx8 = snd_soc_component_get_drvdata(component);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-	u32 ratio = cs42xx8->sysclk / params_rate(params);
-	u32 i, fm, val, mask;
+	u32 ratio[2];
+	u32 rate[2];
+	u32 fm[2];
+	u32 i, val, mask;
+	bool condition1, condition2;
 
 	if (tx)
 		cs42xx8->tx_channels = params_channels(params);
 
+	rate[tx]  = params_rate(params);
+	rate[!tx] = cs42xx8->rate[!tx];
+
+	ratio[tx] = rate[tx] > 0 ? cs42xx8->sysclk / rate[tx] : 0;
+	ratio[!tx] = rate[!tx] > 0 ? cs42xx8->sysclk / rate[!tx] : 0;
+
+	/* Get functional mode for tx and rx according to rate */
+	for (i = 0; i < 2; i++) {
+		if (cs42xx8->slave_mode) {
+			fm[i] = CS42XX8_FM_AUTO;
+		} else {
+			if (rate[i] < 50000) {
+				fm[i] = CS42XX8_FM_SINGLE;
+			} else if (rate[i] > 50000 && rate[i] < 100000) {
+				fm[i] = CS42XX8_FM_DOUBLE;
+			} else if (rate[i] > 100000 && rate[i] < 200000) {
+				fm[i] = CS42XX8_FM_QUAD;
+			} else {
+				dev_err(component->dev,
+					"unsupported sample rate\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cs42xx8_ratios); i++) {
-		if (cs42xx8_ratios[i].ratio == ratio)
+		/* Is the ratio[tx] valid ? */
+		condition1 = ((fm[tx] == CS42XX8_FM_AUTO) ?
+			(cs42xx8_ratios[i].ratio[0] == ratio[tx] ||
+			cs42xx8_ratios[i].ratio[1] == ratio[tx] ||
+			cs42xx8_ratios[i].ratio[2] == ratio[tx]) :
+			(cs42xx8_ratios[i].ratio[fm[tx]] == ratio[tx])) &&
+			cs42xx8->sysclk >= cs42xx8_ratios[i].min_mclk &&
+			cs42xx8->sysclk <= cs42xx8_ratios[i].max_mclk;
+
+		if (!ratio[tx])
+			condition1 = true;
+
+		/* Is the ratio[!tx] valid ? */
+		condition2 = ((fm[!tx] == CS42XX8_FM_AUTO) ?
+			(cs42xx8_ratios[i].ratio[0] == ratio[!tx] ||
+			cs42xx8_ratios[i].ratio[1] == ratio[!tx] ||
+			cs42xx8_ratios[i].ratio[2] == ratio[!tx]) :
+			(cs42xx8_ratios[i].ratio[fm[!tx]] == ratio[!tx]));
+
+		if (!ratio[!tx])
+			condition2 = true;
+
+		/*
+		 * Both ratio[tx] and ratio[!tx] is valid, then we get
+		 * a proper MFreq.
+		 */
+		if (condition1 && condition2)
 			break;
 	}
 
@@ -273,15 +334,31 @@ static int cs42xx8_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	mask = CS42XX8_FUNCMOD_MFREQ_MASK;
-	val = cs42xx8_ratios[i].mclk;
+	cs42xx8->rate[tx] = params_rate(params);
 
-	fm = cs42xx8->slave_mode ? CS42XX8_FM_AUTO : cs42xx8_ratios[i].speed;
+	mask = CS42XX8_FUNCMOD_MFREQ_MASK;
+	val = cs42xx8_ratios[i].mfreq;
 
 	regmap_update_bits(cs42xx8->regmap, CS42XX8_FUNCMOD,
 			   CS42XX8_FUNCMOD_xC_FM_MASK(tx) | mask,
-			   CS42XX8_FUNCMOD_xC_FM(tx, fm) | val);
+			   CS42XX8_FUNCMOD_xC_FM(tx, fm[tx]) | val);
+
+	return 0;
+}
+
+static int cs42xx8_hw_free(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs42xx8_priv *cs42xx8 = snd_soc_component_get_drvdata(component);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 
+	/* Clear stored rate */
+	cs42xx8->rate[tx] = 0;
+
+	regmap_update_bits(cs42xx8->regmap, CS42XX8_FUNCMOD,
+			   CS42XX8_FUNCMOD_xC_FM_MASK(tx),
+			   CS42XX8_FUNCMOD_xC_FM(tx, CS42XX8_FM_AUTO));
 	return 0;
 }
 
@@ -302,6 +379,7 @@ static const struct snd_soc_dai_ops cs42xx8_dai_ops = {
 	.set_fmt	= cs42xx8_set_dai_fmt,
 	.set_sysclk	= cs42xx8_set_dai_sysclk,
 	.hw_params	= cs42xx8_hw_params,
+	.hw_free	= cs42xx8_hw_free,
 	.digital_mute	= cs42xx8_digital_mute,
 };
 
-- 
2.21.0

