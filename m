Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C297FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840C822CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242781;
	bh=VQisiV0NIuLIf9+CmCsYjURNwOBi/jgC+hl2YoTNV70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PDU5WqBlIaDxvI2tEtPi+CZOx5+wJyVH0INOUx3e4Q95dv1pZYEsd9fTm3ifNog4d
	 fevEYV0g7fK3OLV7IEaUTcP3G9qSdm1sxyUAxJbhE0zfvNgmXRf1uBtEI81p8QtSiz
	 rg6n6+V8YobIL2PcU15tDZf2Yt/sbDTeic4anyoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfHST0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfHST0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:17 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D94A206C1;
        Mon, 19 Aug 2019 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242776;
        bh=VQisiV0NIuLIf9+CmCsYjURNwOBi/jgC+hl2YoTNV70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMpKf+WVlYwY8VPvQhpGEdTQPNXKPhOzHBvkDTnWBycN8AzYf2+wensloYhxL4Zt2
         4r2tm735SjrU5kqjUemDd2Ze/8Jm/KJZrAEeldbm9XDuqFGSCPe/XN3j+LINEBEJvA
         bi+DY+wqWFsCtZdvwc1D2gxdsFP5KsshsO4XJSE4=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] ASoC: sun4i-i2s: Move the channel configuration to a callback
Date:   Mon, 19 Aug 2019 21:25:11 +0200
Message-Id: <6414463de69584e8227fa495b13aa5f4798e1f0e.1566242458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The two main generations of our I2S controller require a slightly different
channel configuration, mostly because of a quite different register layout
and some additional registers being needed on the newer generation.

This used to be controlled through a bunch of booleans, however this proved
to be quite impractical, especially since a bunch of SoCs forgot to set
those parameters and therefore were broken from that point of view.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 156 ++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 87 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index ac84c29224eb..657041606c2f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -80,6 +80,7 @@
 #define SUN4I_I2S_TX_CNT_REG		0x2c
 
 #define SUN4I_I2S_TX_CHAN_SEL_REG	0x30
+#define SUN4I_I2S_CHAN_SEL_MASK			GENMASK(2, 0)
 #define SUN4I_I2S_CHAN_SEL(num_chan)		(((num_chan) - 1) << 0)
 
 #define SUN4I_I2S_TX_CHAN_MAP_REG	0x34
@@ -122,8 +123,6 @@ struct sun4i_i2s;
  * @has_reset: SoC needs reset deasserted.
  * @has_slave_select_bit: SoC has a bit to enable slave mode.
  * @has_fmt_set_lrck_period: SoC requires lrclk period to be set.
- * @has_chcfg: tx and rx slot number need to be set.
- * @has_chsel_tx_chen: SoC requires that the tx channels are enabled.
  * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
@@ -135,17 +134,11 @@ struct sun4i_i2s;
  * @field_fmt_bclk: regmap field to set clk polarity.
  * @field_fmt_lrclk: regmap field to set frame polarity.
  * @field_fmt_mode: regmap field to set the operational mode.
- * @field_txchanmap: location of the tx channel mapping register.
- * @field_rxchanmap: location of the rx channel mapping register.
- * @field_txchansel: location of the tx channel select bit fields.
- * @field_rxchansel: location of the rx channel select bit fields.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
 	bool				has_slave_select_bit;
 	bool				has_fmt_set_lrck_period;
-	bool				has_chcfg;
-	bool				has_chsel_tx_chen;
 	bool				has_chsel_offset;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
@@ -159,13 +152,11 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_bclk;
 	struct reg_field		field_fmt_lrclk;
 	struct reg_field		field_fmt_mode;
-	struct reg_field		field_txchanmap;
-	struct reg_field		field_rxchanmap;
-	struct reg_field		field_txchansel;
-	struct reg_field		field_rxchansel;
 
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
+	int	(*set_chan_cfg)(const struct sun4i_i2s *,
+				const struct snd_pcm_hw_params *);
 };
 
 struct sun4i_i2s {
@@ -186,10 +177,6 @@ struct sun4i_i2s {
 	struct regmap_field	*field_fmt_bclk;
 	struct regmap_field	*field_fmt_lrclk;
 	struct regmap_field	*field_fmt_mode;
-	struct regmap_field	*field_txchanmap;
-	struct regmap_field	*field_rxchanmap;
-	struct regmap_field	*field_txchansel;
-	struct regmap_field	*field_rxchansel;
 
 	const struct sun4i_i2s_quirks	*variant;
 };
@@ -381,44 +368,77 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
 	return (width - 8) / 4 + 1;
 }
 
-static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
-			       struct snd_pcm_hw_params *params,
-			       struct snd_soc_dai *dai)
+static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
+				  const struct snd_pcm_hw_params *params)
 {
-	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	int sr, wss, channels;
-	u32 width;
+	unsigned int channels = params_channels(params);
 
-	channels = params_channels(params);
-	if (channels != 2) {
-		dev_err(dai->dev, "Unsupported number of channels: %d\n",
-			channels);
+	if (channels != 2)
 		return -EINVAL;
-	}
 
-	if (i2s->variant->has_chcfg) {
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
-	}
+	/* Map the channels for playback and capture */
+	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
+	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
+
+	/* Configure the channels */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
+			   SUN4I_I2S_CHAN_SEL_MASK,
+			   SUN4I_I2S_CHAN_SEL(channels));
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_RX_CHAN_SEL_REG,
+			   SUN4I_I2S_CHAN_SEL_MASK,
+			   SUN4I_I2S_CHAN_SEL(channels));
+
+	return 0;
+}
+
+static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
+				  const struct snd_pcm_hw_params *params)
+{
+	unsigned int channels = params_channels(params);
+
+	if (channels != 2)
+		return -EINVAL;
 
 	/* Map the channels for playback and capture */
-	regmap_field_write(i2s->field_txchanmap, 0x76543210);
-	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
+	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
+	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
 
 	/* Configure the channels */
-	regmap_field_write(i2s->field_txchansel,
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
+			   SUN4I_I2S_CHAN_SEL_MASK,
 			   SUN4I_I2S_CHAN_SEL(channels));
-	regmap_field_write(i2s->field_rxchansel,
+
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+			   SUN4I_I2S_CHAN_SEL_MASK,
 			   SUN4I_I2S_CHAN_SEL(channels));
 
-	if (i2s->variant->has_chsel_tx_chen)
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_EN_MASK,
-				   SUN8I_I2S_TX_CHAN_EN(channels));
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
+			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
+			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
+
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
+			   SUN8I_I2S_TX_CHAN_EN_MASK,
+			   SUN8I_I2S_TX_CHAN_EN(channels));
+
+	return 0;
+}
+
+static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *dai)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	int ret, sr, wss;
+	u32 width;
+
+	ret = i2s->variant->set_chan_cfg(i2s, params);
+	if (ret < 0) {
+		dev_err(dai->dev, "Invalid channel configuration\n");
+		return ret;
+	}
 
 	switch (params_physical_width(params)) {
 	case 16:
@@ -916,12 +936,9 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
-	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
-	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
+	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
@@ -935,12 +952,9 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
-	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
-	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
+	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
 };
 
 static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
@@ -954,12 +968,9 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
-	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
-	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
+	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
 };
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
@@ -969,8 +980,6 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.mclk_offset		= 1,
 	.bclk_offset		= 2,
 	.has_fmt_set_lrck_period = true,
-	.has_chcfg		= true,
-	.has_chsel_tx_chen	= true,
 	.has_chsel_offset	= true,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
@@ -978,12 +987,9 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
-	.field_txchanmap	= REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
-	.field_txchansel	= REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
-	.field_rxchansel	= REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
+	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
@@ -997,12 +1003,9 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
-	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
-	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
+	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
 };
 
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
@@ -1044,28 +1047,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	if (IS_ERR(i2s->field_fmt_mode))
 		return PTR_ERR(i2s->field_fmt_mode);
 
-	i2s->field_txchanmap =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_txchanmap);
-	if (IS_ERR(i2s->field_txchanmap))
-		return PTR_ERR(i2s->field_txchanmap);
-
-	i2s->field_rxchanmap =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_rxchanmap);
-	if (IS_ERR(i2s->field_rxchanmap))
-		return PTR_ERR(i2s->field_rxchanmap);
-
-	i2s->field_txchansel =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_txchansel);
-	if (IS_ERR(i2s->field_txchansel))
-		return PTR_ERR(i2s->field_txchansel);
-
-	i2s->field_rxchansel =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_rxchansel);
-	return PTR_ERR_OR_ZERO(i2s->field_rxchansel);
+	return 0;
 }
 
 static int sun4i_i2s_probe(struct platform_device *pdev)
-- 
git-series 0.9.1
