Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BDFC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8A6230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322921;
	bh=HlTioWhyZFwTqc4Q34ekJ/gwMBpajBNKe66osFqTmIc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dMDoGNQlWcD5OauMMECs67eSNFhw/XumuBye0/JavRVlxKpgsT2Qe+78MFV6YTMOv
	 q0bX88lueYX3EOd/7yLk/6O+8cF9zoFrJr6lnZFNm/dwgiWtDoa/ECiNx17UFKCGF2
	 sH3GrBIwQe2yGV5ERSANOSGey6OeC00CTcXR2cEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfHTRmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:42:00 -0400
Received: from mail-ed1-f99.google.com ([209.85.208.99]:44433 "EHLO
        mail-ed1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbfHTRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:08 -0400
Received: by mail-ed1-f99.google.com with SMTP id a21so7255223edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=ijBvODsMnl6QkrSP5hYni3nXw5ctFV0IEowqc4OQmR0=;
        b=l/YMfsIVJjYDTgorBsejLqsRoB9asR2867+A1Xjhg8IkfSgmhG+b+Z6/2vsXnmbltj
         s15F7zUhSQ9Nz2qlDB9EwKyp0uRBapZnt6Z+vkKb7ZFfED3ELBGa7gioy+r5PSdXQZbz
         3LMrJgO3jz2ZM+p7tm7uY5F9KSx80QZd9acUgLc9XnE2KGDYnh0F4S7tXDl6JEC/twbP
         Joyev7mP9RO1qxKMf0FdtIhOxPDGHl+CeqM+arijxQC2oPf6oN3EXnFODl6PZYkWBTaR
         S/74V4hArt6YR+SwtCw7lX81wjiZsXj+2Hr9KsVE8gMY+OHZJnGcnncOJa4v5C8ps2z7
         E7mw==
X-Gm-Message-State: APjAAAUCp/wtaLwnV3PApoTFfFKPSfaiDwc+i5Dx0iJ2c2WKokuubaPI
        vOGJqociA680NExyVfUmxooBmTJekWsd+I8n1GdOyRt0ZFfYwm2ett6ceornu0kz2g==
X-Google-Smtp-Source: APXvYqxaMgLQllmcGTjN5p/8iDzz9yuWVTlnosVpaFmbguognoCtGY95w14rOToRKWceznGhEwMp6NWXxoz0
X-Received: by 2002:a17:906:244c:: with SMTP id a12mr26757259ejb.288.1566322866265;
        Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id c66sm283196edf.12.2019.08.20.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0881-00032k-Pc; Tue, 20 Aug 2019 17:41:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2E69C274314C; Tue, 20 Aug 2019 18:41:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs" to the asoc tree
In-Reply-To: <9cbdde80a299288878e58225df4d7884e0301348.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174105.2E69C274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 515fcfbc773632e160f4b94e8df8d278a8d704f7 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:19 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer
 SoCs

The LRCK and BCLK polarity offsets on newer SoCs has been
changed, yet the driver didn't take it into account for all of them.

This was taken into account for the H3, but not the A83t. This was handled
using a reg_field for the H3.

However, the value in that field will not be the same, so reg_field is not
adapted in that case. Let's change for proper calls with the regular
values.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/9cbdde80a299288878e58225df4d7884e0301348.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 118 ++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 53c95e5289f5..e3eadfe38aaf 100644
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
2.20.1

