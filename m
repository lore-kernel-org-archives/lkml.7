Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F484C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78FD22CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242778;
	bh=kgJgyL0lhyr3mxrc8eG/4G2XdFkqx4XD8pY1GUjQG9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Unwz6rXb8DmNeaqSEH9MtpQJoGhjZMHLxXCP2KloGDrf4kX2l2qXAFJ8FQ2w2+ia+
	 mmcThqD8LMqIulWdI1TKsECkrx0JxHqM0hMm1O4/3qobms9tGwJwhzVakxvf1St+Q6
	 4o86je/3eZI2S+I6XNV+oba+DA5m318ktuz1xz4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfHST0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfHST0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:10 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4761322CF6;
        Mon, 19 Aug 2019 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242769;
        bh=kgJgyL0lhyr3mxrc8eG/4G2XdFkqx4XD8pY1GUjQG9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4iSbwGRhGzQJ8Zk83WPR0s0008xKvHCSPCcZtVxbJKXYiFhrKuT9QIId1NVWbTA+
         YHJpTk0mqChaF3k2jDCxSGCqVtDKOkmRKfsxGrzxU080wnW5wsK2JOt0w7PhydX21V
         iLd8PXPAfKvMNeqYJTQzsugX0wmiOifR0pgROXw4=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs
Date:   Mon, 19 Aug 2019 21:25:19 +0200
Message-Id: <9cbdde80a299288878e58225df4d7884e0301348.1566242458.git-series.maxime.ripard@bootlin.com>
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

The LRCK and BCLK polarity offsets on newer SoCs has been
changed, yet the driver didn't take it into account for all of them.

This was taken into account for the H3, but not the A83t. This was handled
using a reg_field for the H3.

However, the value in that field will not be the same, so reg_field is not
adapted in that case. Let's change for proper calls with the regular
values.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 118 ++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 2996beb4f092..e614c2d52af5 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -46,8 +46,6 @@
 #define SUN4I_I2S_FMT0_FMT_RIGHT_J			(2 << 0)
 #define SUN4I_I2S_FMT0_FMT_LEFT_J			(1 << 0)
 #define SUN4I_I2S_FMT0_FMT_I2S				(0 << 0)
-#define SUN4I_I2S_FMT0_POLARITY_INVERTED		(1)
-#define SUN4I_I2S_FMT0_POLARITY_NORMAL			(0)
 
 #define SUN4I_I2S_FMT1_REG		0x08
 #define SUN4I_I2S_FIFO_TX_REG		0x0c
@@ -98,8 +96,14 @@
 #define SUN8I_I2S_CTRL_MODE_LEFT		(1 << 4)
 #define SUN8I_I2S_CTRL_MODE_PCM			(0 << 4)
 
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK	BIT(19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED		(1 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL		(0 << 19)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK		GENMASK(17, 8)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
+#define SUN8I_I2S_FMT0_BCLK_POLARITY_MASK	BIT(7)
+#define SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED		(1 << 7)
+#define SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL		(0 << 7)
 
 #define SUN8I_I2S_INT_STA_REG		0x0c
 #define SUN8I_I2S_FIFO_TX_REG		0x20
@@ -132,8 +136,6 @@ struct sun4i_i2s;
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
- * @field_fmt_bclk: regmap field to set clk polarity.
- * @field_fmt_lrclk: regmap field to set frame polarity.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
@@ -145,8 +147,6 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_clkdiv_mclk_en;
 	struct reg_field		field_fmt_wss;
 	struct reg_field		field_fmt_sr;
-	struct reg_field		field_fmt_bclk;
-	struct reg_field		field_fmt_lrclk;
 
 	const struct sun4i_i2s_clk_div	*bclk_dividers;
 	unsigned int			num_bclk_dividers;
@@ -176,8 +176,6 @@ struct sun4i_i2s {
 	struct regmap_field	*field_clkdiv_mclk_en;
 	struct regmap_field	*field_fmt_wss;
 	struct regmap_field	*field_fmt_sr;
-	struct regmap_field	*field_fmt_bclk;
-	struct regmap_field	*field_fmt_lrclk;
 
 	const struct sun4i_i2s_quirks	*variant;
 };
@@ -498,6 +496,33 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 {
 	u32 val;
 
+	/* DAI clock polarity */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		val = SUN4I_I2S_FMT0_BCLK_POLARITY_INVERTED |
+		      SUN4I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		val = SUN4I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		val = SUN4I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN4I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN4I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   val);
+
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -545,6 +570,33 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	u32 mode, val;
 	u8 offset;
 
+	/* DAI clock polarity */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
+		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   val);
+
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -601,36 +653,8 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
-	u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 	int ret;
 
-	/* DAI clock polarity */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		bclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
-		lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		bclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		break;
-	default:
-		dev_err(dai->dev, "Unsupported clock polarity: %d\n",
-			fmt & SND_SOC_DAIFMT_INV_MASK);
-		return -EINVAL;
-	}
-
-	regmap_field_write(i2s->field_fmt_bclk, bclk_polarity);
-	regmap_field_write(i2s->field_fmt_lrclk, lrclk_polarity);
-
 	ret = i2s->variant->set_fmt(i2s, fmt);
 	if (ret) {
 		dev_err(dai->dev, "Unsupported format configuration\n");
@@ -984,8 +1008,6 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
-	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
-	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.bclk_dividers		= sun4i_i2s_bclk_div,
 	.num_bclk_dividers	= ARRAY_SIZE(sun4i_i2s_bclk_div),
 	.mclk_dividers		= sun4i_i2s_mclk_div,
@@ -1004,8 +1026,6 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
-	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
-	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.bclk_dividers		= sun4i_i2s_bclk_div,
 	.num_bclk_dividers	= ARRAY_SIZE(sun4i_i2s_bclk_div),
 	.mclk_dividers		= sun4i_i2s_mclk_div,
@@ -1024,8 +1044,6 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
-	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
-	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.bclk_dividers		= sun8i_i2s_clk_div,
 	.num_bclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
 	.mclk_dividers		= sun8i_i2s_clk_div,
@@ -1045,8 +1063,6 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
-	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
-	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
 	.bclk_dividers		= sun8i_i2s_clk_div,
 	.num_bclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
 	.mclk_dividers		= sun8i_i2s_clk_div,
@@ -1065,8 +1081,6 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
-	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
-	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.bclk_dividers		= sun4i_i2s_bclk_div,
 	.num_bclk_dividers	= ARRAY_SIZE(sun4i_i2s_bclk_div),
 	.mclk_dividers		= sun4i_i2s_mclk_div,
@@ -1099,18 +1113,6 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	if (IS_ERR(i2s->field_fmt_sr))
 		return PTR_ERR(i2s->field_fmt_sr);
 
-	i2s->field_fmt_bclk =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_fmt_bclk);
-	if (IS_ERR(i2s->field_fmt_bclk))
-		return PTR_ERR(i2s->field_fmt_bclk);
-
-	i2s->field_fmt_lrclk =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_fmt_lrclk);
-	if (IS_ERR(i2s->field_fmt_lrclk))
-		return PTR_ERR(i2s->field_fmt_lrclk);
-
 	return 0;
 }
 
-- 
git-series 0.9.1
