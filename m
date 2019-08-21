Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566392834;
	bh=eSW5sonthn00aXlq3sEz9PnmYO5sWVMvXRhzux/NTmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HpoJRpTAAtYA2vBPXAFIFaMD8R6wJXjWT16g2j9B4Mpsmer45z2D494l+EXseNupN
	 7Pguj3jbOKqpVxpK18yaCGjgL0JZ+AlZ6j3lMLPK5/rkZ/sTF8jgbH4agj+6VfpUSI
	 e8V8kwgmbH9it+cyf+9M8qm9L3eoNZLnsKFR2eWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfHUNHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfHUNHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:07:10 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED79E2082F;
        Wed, 21 Aug 2019 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566392829;
        bh=eSW5sonthn00aXlq3sEz9PnmYO5sWVMvXRhzux/NTmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYjCEIIz20TVKTI18/ajVvJxgxHNChwRE7yKBWVpf5MHfJ9f3EAMKFZTnz4fasKUk
         cc43jyfFrW8MNh0F5QOtpJYM8ZPFe5rhSHzd11FMrQdbIr9DcuxDZcJ10M8oRTXyNn
         FL6OgoDD464E3SYzBW7K3323MmRq06j2PGLgL5rw=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ASoC: sun4i-i2s: Add support for DSP formats
Date:   Wed, 21 Aug 2019 15:06:56 +0200
Message-Id: <5562db1ac8759f12b1b87c3258223eed629ef771.1566392800.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
References: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

In addition to the I2S format, the controller also supports the DSP_*
formats.

This requires some extra care on the LRCK period calculation, since the
controller, with the PCM formats, require that the value set is no longer
the periods of LRCK for a single channel, but for all of them.

Let's add the code to deal with this, and support the DSP_A and DSP_B
formats.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 44 ++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 69162af9fd65..57bf2a33753e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -130,7 +130,6 @@ struct sun4i_i2s;
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
- * @has_fmt_set_lrck_period: SoC requires lrclk period to be set.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
@@ -139,7 +138,6 @@ struct sun4i_i2s;
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
-	bool				has_fmt_set_lrck_period;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
 
@@ -167,6 +165,7 @@ struct sun4i_i2s {
 	struct regmap	*regmap;
 	struct reset_control *rst;
 
+	unsigned int	format;
 	unsigned int	mclk_freq;
 	unsigned int	slots;
 	unsigned int	slot_width;
@@ -355,12 +354,6 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 
 	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
 
-	/* Set sync period */
-	if (i2s->variant->has_fmt_set_lrck_period)
-		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(slot_width));
-
 	return 0;
 }
 
@@ -422,6 +415,7 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 {
 	unsigned int channels = params_channels(params);
 	unsigned int slots = channels;
+	unsigned int lrck_period;
 
 	if (i2s->slots)
 		slots = i2s->slots;
@@ -445,6 +439,26 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
 			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
 
+	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		lrck_period = params_physical_width(params) * slots;
+		break;
+
+	case SND_SOC_DAIFMT_I2S:
+		lrck_period = params_physical_width(params);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
+			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
+
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 			   SUN8I_I2S_TX_CHAN_EN_MASK,
 			   SUN8I_I2S_TX_CHAN_EN(channels));
@@ -616,6 +630,16 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		mode = SUN8I_I2S_CTRL_MODE_PCM;
+		offset = 1;
+		break;
+
+	case SND_SOC_DAIFMT_DSP_B:
+		mode = SUN8I_I2S_CTRL_MODE_PCM;
+		offset = 0;
+		break;
+
 	case SND_SOC_DAIFMT_I2S:
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
@@ -684,6 +708,9 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			   SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
 			   SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
 			   SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
+
+	i2s->format = fmt;
+
 	return 0;
 }
 
@@ -1074,7 +1101,6 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
-	.has_fmt_set_lrck_period = true,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
-- 
git-series 0.9.1
