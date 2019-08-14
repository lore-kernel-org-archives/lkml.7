Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372C6C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0410F2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVSGjxma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfHNGJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45750 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfHNGJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id t3so15166245ljj.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=147UIFX9DA9SvYsUgY5biO/zYXvXueKjoVP+mGnAo6Q=;
        b=UVSGjxmasNyFoGwIFM2MIfDLyoPAHuTGqF6HFKtf0cC6SR8TB025wG4wYwGiR5YwqZ
         ULZEl/xeqFArjCdDjefrZsUMBFDjjMe4nojLar2lHvZFBDQ2wt3QutLeVoAk/v96bHIL
         rG44kfVICwZxhA2labXn/Z09qeDTZzJo9ScRTEhl4nollvs8L2Xvx7LUvu4kG26K2Ntv
         2Gbiu6j/ohX5UKkJarNj54onXtNCH0aWWnt+GtNzmQFkk5m2CLlpKgc4yDPx93EiT10I
         rj+m8uhlKHiV3aEKDeamdSaKhVQZdCN1Giirge4eIuFZC93lSW137EDyrIUTyjBMD5bw
         HOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=147UIFX9DA9SvYsUgY5biO/zYXvXueKjoVP+mGnAo6Q=;
        b=Z9WI2gESGQP9QqhpRhbdxXrur2N+K+lv+aiflCahc7rBHY9U3wF9s1zkhHVb46gZQP
         drwB46zBBJpbUPU+JjWg5fRZY3/d5v4wNit2lg6ZtGHwZ+3jIb50vKn6HSgg7joXUUjk
         NpU364yQwkFK2GcUAvVz3PBpZyDf46vCCao2Rv5RlQyIcDiQoBqeOwmjS9pAriT+TOPZ
         EaoBXP61+yd/0Kxq3Pkykq2A54i3ebPti2EyiUbsJGqzAMkEeE8x8UlBwhzRkLebKzBg
         3wRKoAga0FU9c5f9yJX3Ja34rc2XRfu1eAPew4bPy2pszjE03K+2U9VJif2BahSf1D5l
         z6tg==
X-Gm-Message-State: APjAAAUBzeiZtfv1pk6M1u7JDgSSel0BtfYLp+VmNw5i79ORRhRst2ds
        ZW+cg37B8pN5q5Y6JkwmjwQ=
X-Google-Smtp-Source: APXvYqy9/3FWFJxlWdMewFGb1jP7tuiF9PZlPe111B5EpfQlyq1S5HyPMPjC1ihUplSJ6WZcUN+GOA==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr9599742lja.140.1565762943470;
        Tue, 13 Aug 2019 23:09:03 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:02 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 03/15] ASoC: sun4i-i2s: Correct divider calculations
Date:   Wed, 14 Aug 2019 08:08:42 +0200
Message-Id: <20190814060854.26345-4-codekipper@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814060854.26345-1-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

The clock division circuitry is different on the H3 and later SoCs.
The division of bclk is now based on pll2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 73 +++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 7c37b6291df0..34f31439ae7b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -127,8 +127,6 @@ struct sun4i_i2s;
  * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
- * @mclk_offset: Value by which mclkdiv needs to be adjusted.
- * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
@@ -150,8 +148,6 @@ struct sun4i_i2s_quirks {
 	bool				has_chsel_offset;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
-	unsigned int			mclk_offset;
-	unsigned int			bclk_offset;
 
 	/* Register fields for i2s */
 	struct reg_field		field_clkdiv_mclk_en;
@@ -212,7 +208,25 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
 	{ .div = 8, .val = 3 },
 	{ .div = 12, .val = 4 },
 	{ .div = 16, .val = 5 },
-	/* TODO - extend divide ratio supported by newer SoCs */
+};
+
+static const struct sun4i_i2s_clk_div sun8i_i2s_clk_div[] = {
+	{ .div = 0, .val = 0 },
+	{ .div = 1, .val = 1 },
+	{ .div = 2, .val = 2 },
+	{ .div = 4, .val = 3 },
+	{ .div = 6, .val = 4 },
+	{ .div = 8, .val = 5 },
+	{ .div = 12, .val = 6 },
+	{ .div = 16, .val = 7 },
+	{ .div = 24, .val = 8 },
+	{ .div = 32, .val = 9 },
+	{ .div = 48, .val = 10 },
+	{ .div = 64, .val = 11 },
+	{ .div = 96, .val = 12 },
+	{ .div = 128, .val = 13 },
+	{ .div = 176, .val = 14 },
+	{ .div = 192, .val = 15 },
 };
 
 static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
@@ -224,21 +238,21 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 	{ .div = 12, .val = 5 },
 	{ .div = 16, .val = 6 },
 	{ .div = 24, .val = 7 },
-	/* TODO - extend divide ratio supported by newer SoCs */
 };
 
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 				  unsigned int oversample_rate,
-				  unsigned int word_size)
+				  unsigned int word_size,
+				  const struct sun4i_i2s_clk_div *bdiv,
+				  unsigned int size)
 {
 	int div = oversample_rate / word_size / 2;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_bclk_div); i++) {
-		const struct sun4i_i2s_clk_div *bdiv = &sun4i_i2s_bclk_div[i];
-
+	for (i = 0; i < size; i++) {
 		if (bdiv->div == div)
 			return bdiv->val;
+		bdiv++;
 	}
 
 	return -EINVAL;
@@ -247,16 +261,17 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
 				  unsigned int oversample_rate,
 				  unsigned int module_rate,
-				  unsigned int sampling_rate)
+				  unsigned int sampling_rate,
+				  const struct sun4i_i2s_clk_div *mdiv,
+				  unsigned int size)
 {
 	int div = module_rate / sampling_rate / oversample_rate;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_mclk_div); i++) {
-		const struct sun4i_i2s_clk_div *mdiv = &sun4i_i2s_mclk_div[i];
-
+	for (i = 0; i < size; i++) {
 		if (mdiv->div == div)
 			return mdiv->val;
+		mdiv++;
 	}
 
 	return -EINVAL;
@@ -321,24 +336,36 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-					  word_size);
+	if (i2s->variant->has_fmt_set_lrck_period)
+		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
+						  word_size,
+						  sun8i_i2s_clk_div,
+						  ARRAY_SIZE(sun8i_i2s_clk_div));
+	else
+		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+						  word_size,
+						  sun4i_i2s_bclk_div,
+						  ARRAY_SIZE(sun4i_i2s_bclk_div));
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
 	}
 
-	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-					  clk_rate, rate);
+	if (i2s->variant->has_fmt_set_lrck_period)
+		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+						  clk_rate, rate,
+						  sun8i_i2s_clk_div,
+						  ARRAY_SIZE(sun8i_i2s_clk_div));
+	else
+		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+						  clk_rate, rate,
+						  sun4i_i2s_mclk_div,
+						  ARRAY_SIZE(sun4i_i2s_mclk_div));
 	if (mclk_div < 0) {
 		dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
 		return -EINVAL;
 	}
 
-	/* Adjust the clock division values if needed */
-	bclk_div += i2s->variant->bclk_offset;
-	mclk_div += i2s->variant->mclk_offset;
-
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
 		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
@@ -994,8 +1021,6 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
-	.mclk_offset		= 1,
-	.bclk_offset		= 2,
 	.has_fmt_set_lrck_period = true,
 	.has_chcfg		= true,
 	.has_chsel_tx_chen	= true,
-- 
2.22.0

