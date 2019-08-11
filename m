Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C985C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D91E20820
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHKTzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 15:55:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53648 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfHKTzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 15:55:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 814232005A4;
        Sun, 11 Aug 2019 21:55:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7371620059A;
        Sun, 11 Aug 2019 21:55:47 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 105AD2060E;
        Sun, 11 Aug 2019 21:55:47 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     nicoleotsuka@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, festevam@gmail.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH] ASoC: fsl_sai: Enable data lines based on input channels
Date:   Sun, 11 Aug 2019 22:55:45 +0300
Message-Id: <20190811195545.32606-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An audio data frame consists of a number of slots one for each
channel. In the case of I2S there are 2 data slots / frame.

The maximum number of SAI slots / frame is configurable at
IP integration time. This affects the width of Mask Register.
SAI supports up to 32 slots per frame.

The number of datalines is also configurable (up to 8 datalines)
and affects TCE/RCE and the number of data/FIFO registers.

The number of needed data lines (pins) is computed as follows:

* pins = channels / slots.

This can be computed in hw_params function so lets move TRCE bits
seting from startup to hw_params.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 34 +++++++++++++---------------------
 sound/soc/fsl/fsl_sai.h |  2 +-
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 69cf3678c859..b70032c82fe2 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -414,6 +414,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	u32 val_cr4 = 0, val_cr5 = 0;
 	u32 slots = (channels == 1) ? 2 : channels;
 	u32 slot_width = word_width;
+	u32 pins;
 	int ret;
 
 	if (sai->slots)
@@ -422,6 +423,8 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	if (sai->slot_width)
 		slot_width = sai->slot_width;
 
+	pins = DIV_ROUND_UP(channels, slots);
+
 	if (!sai->is_slave_mode[tx]) {
 		ret = fsl_sai_set_bclk(cpu_dai, tx,
 				slots * slot_width * params_rate(params));
@@ -480,13 +483,17 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
+	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
+			   FSL_SAI_CR3_TRCE_MASK,
+			   FSL_SAI_CR3_TRCE((1 << pins) - 1));
+
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx, ofs),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
 			   val_cr4);
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR5(tx, ofs),
 			   FSL_SAI_CR5_WNW_MASK | FSL_SAI_CR5_W0W_MASK |
 			   FSL_SAI_CR5_FBT_MASK, val_cr5);
-	regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << channels) - 1));
+	regmap_write(sai->regmap, FSL_SAI_xMR(tx), ~0UL - ((1 << slots) - 1));
 
 	return 0;
 }
@@ -496,6 +503,10 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int ofs = sai->soc_data->reg_offset;
+
+	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
+			   FSL_SAI_CR3_TRCE_MASK, 0);
 
 	if (!sai->is_slave_mode[tx] &&
 			sai->mclk_streams & BIT(substream->stream)) {
@@ -603,32 +614,13 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 static int fsl_sai_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
-	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int ofs = sai->soc_data->reg_offset;
-	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int ret;
 
-	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
-			   FSL_SAI_CR3_TRCE_MASK,
-			   FSL_SAI_CR3_TRCE);
-
 	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
-
 	return ret;
 }
 
-static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai)
-{
-	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int ofs = sai->soc_data->reg_offset;
-	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
-
-	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
-			   FSL_SAI_CR3_TRCE_MASK, 0);
-}
-
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
@@ -637,7 +629,6 @@ static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.hw_free	= fsl_sai_hw_free,
 	.trigger	= fsl_sai_trigger,
 	.startup	= fsl_sai_startup,
-	.shutdown	= fsl_sai_shutdown,
 };
 
 static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -881,6 +872,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sai->pdev = pdev;
+
 	sai->soc_data = of_device_get_match_data(&pdev->dev);
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index c2c43a7d9ba1..3c5383139dc2 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -109,7 +109,7 @@
 #define FSL_SAI_CR2_DIV_MASK	0xff
 
 /* SAI Transmit and Receive Configuration 3 Register */
-#define FSL_SAI_CR3_TRCE	BIT(16)
+#define FSL_SAI_CR3_TRCE(x)	((x) << 16)
 #define FSL_SAI_CR3_TRCE_MASK	GENMASK(23, 16)
 #define FSL_SAI_CR3_WDFL(x)	(x)
 #define FSL_SAI_CR3_WDFL_MASK	0x1f
-- 
2.17.1

