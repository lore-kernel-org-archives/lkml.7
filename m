Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA26C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99F72086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfIIKfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:35:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58252 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbfIIKev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:34:51 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C8ED21A001D;
        Mon,  9 Sep 2019 12:34:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A00171A003B;
        Mon,  9 Sep 2019 12:34:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 48A2F402F2;
        Mon,  9 Sep 2019 18:34:37 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: fsl_asrc: Use in(out)put_format instead of in(out)put_word_width
Date:   Mon,  9 Sep 2019 18:33:19 -0400
Message-Id: <65e96ca15afd4a282b122f3ea8b13642cf4614c7.1568025083.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1568025083.git.shengjiu.wang@nxp.com>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1568025083.git.shengjiu.wang@nxp.com>
References: <cover.1568025083.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_pcm_format_t is more formal than enum asrc_word_width, which has
two property, width and physical width, which is more accurate than
enum asrc_word_width. So it is better to use in(out)put_format
instead of in(out)put_word_width.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 56 +++++++++++++++++++++++++++-------------
 sound/soc/fsl/fsl_asrc.h |  4 +--
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index cfa40ef6b1ca..4d3804a1ea55 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -265,6 +265,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	struct asrc_config *config = pair->config;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
 	enum asrc_pair_index index = pair->index;
+	enum asrc_word_width input_word_width;
+	enum asrc_word_width output_word_width;
 	u32 inrate, outrate, indiv, outdiv;
 	u32 clk_index[2], div[2];
 	int in, out, channels;
@@ -283,9 +285,32 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 		return -EINVAL;
 	}
 
-	/* Validate output width */
-	if (config->output_word_width == ASRC_WIDTH_8_BIT) {
-		pair_err("does not support 8bit width output\n");
+	switch (snd_pcm_format_width(config->input_format)) {
+	case 8:
+		input_word_width = ASRC_WIDTH_8_BIT;
+		break;
+	case 16:
+		input_word_width = ASRC_WIDTH_16_BIT;
+		break;
+	case 24:
+		input_word_width = ASRC_WIDTH_24_BIT;
+		break;
+	default:
+		pair_err("does not support this input format, %d\n",
+			 config->input_format);
+		return -EINVAL;
+	}
+
+	switch (snd_pcm_format_width(config->output_format)) {
+	case 16:
+		output_word_width = ASRC_WIDTH_16_BIT;
+		break;
+	case 24:
+		output_word_width = ASRC_WIDTH_24_BIT;
+		break;
+	default:
+		pair_err("does not support this output format, %d\n",
+			 config->output_format);
 		return -EINVAL;
 	}
 
@@ -383,8 +408,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	/* Implement word_width configurations */
 	regmap_update_bits(asrc_priv->regmap, REG_ASRMCR1(index),
 			   ASRMCR1i_OW16_MASK | ASRMCR1i_IWD_MASK,
-			   ASRMCR1i_OW16(config->output_word_width) |
-			   ASRMCR1i_IWD(config->input_word_width));
+			   ASRMCR1i_OW16(output_word_width) |
+			   ASRMCR1i_IWD(input_word_width));
 
 	/* Enable BUFFER STALL */
 	regmap_update_bits(asrc_priv->regmap, REG_ASRMCR(index),
@@ -497,13 +522,13 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
 	struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
-	int width = params_width(params);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
 	struct asrc_config config;
-	int word_width, ret;
+	snd_pcm_format_t format;
+	int ret;
 
 	ret = fsl_asrc_request_pair(channels, pair);
 	if (ret) {
@@ -513,15 +538,10 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 
 	pair->config = &config;
 
-	if (width == 16)
-		width = ASRC_WIDTH_16_BIT;
-	else
-		width = ASRC_WIDTH_24_BIT;
-
 	if (asrc_priv->asrc_width == 16)
-		word_width = ASRC_WIDTH_16_BIT;
+		format = SNDRV_PCM_FORMAT_S16_LE;
 	else
-		word_width = ASRC_WIDTH_24_BIT;
+		format = SNDRV_PCM_FORMAT_S24_LE;
 
 	config.pair = pair->index;
 	config.channel_num = channels;
@@ -529,13 +549,13 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 	config.outclk = OUTCLK_ASRCK1_CLK;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		config.input_word_width   = width;
-		config.output_word_width  = word_width;
+		config.input_format   = params_format(params);
+		config.output_format  = format;
 		config.input_sample_rate  = rate;
 		config.output_sample_rate = asrc_priv->asrc_rate;
 	} else {
-		config.input_word_width   = word_width;
-		config.output_word_width  = width;
+		config.input_format   = format;
+		config.output_format  = params_format(params);
 		config.input_sample_rate  = asrc_priv->asrc_rate;
 		config.output_sample_rate = rate;
 	}
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index c60075112570..38af485bdd22 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -342,8 +342,8 @@ struct asrc_config {
 	unsigned int dma_buffer_size;
 	unsigned int input_sample_rate;
 	unsigned int output_sample_rate;
-	enum asrc_word_width input_word_width;
-	enum asrc_word_width output_word_width;
+	snd_pcm_format_t input_format;
+	snd_pcm_format_t output_format;
 	enum asrc_inclk inclk;
 	enum asrc_outclk outclk;
 };
-- 
2.21.0

