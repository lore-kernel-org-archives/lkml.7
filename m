Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72676C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A9422DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322936;
	bh=EeyGyAEIY/UephUMN8bI7v8VPB9LxYHEvqw8pqMfT/w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LD6fWzLLq6Vge0NwX0FjrM1DXR3/evULfHl6gMRKNWYJsUjZP+BPhJq5p7qtGvRHX
	 3kdfjIwJu8YmYUUqvoE20n/QG3Mt8B0IS0W3Y6ziDN4X7bHcI8vrpz1GEeNxIyCElr
	 LK7n38GWnfYVUjL/SBcrmFDRJbU1u4Ozh2LuejDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfHTRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:42:15 -0400
Received: from mail-ed1-f98.google.com ([209.85.208.98]:36124 "EHLO
        mail-ed1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfHTRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:07 -0400
Received: by mail-ed1-f98.google.com with SMTP id p28so7259624edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=6Cjn1aWqcdZkl7+dMm/bKsnvkfd0nWS0/oSgaIM7Z20=;
        b=RbBnB9o1Ls3XkIxBZcWmmGpEMwcX/kpw3YfgHYd/QfAb3sFdaQjTslTQjZNw3+ojXv
         2Ff8eeIEjVrtReAeeWyGeHR9yjzQlf5mo+Jlh+zxhwmPH9+wiVPh+pYvWv2ejAXHKQGY
         FeNu/2iyPa2hFP+ijoj9uTwDMG9gSMLb9Z0nWWaiB4B+pYTl3mNT10nzkfE3oRzlyY/s
         qfAlUfLpLz2AoFxnl/O9LNq3n4KJqRzPryM5MlT3bkQx/b0XtFJ00E36kM2NVrPvoUAL
         VZTi9Qh776lmoWcyUodrtStFej3zQ18qqSctQvF/MOnm1Me/S8mERB3rAe1RbUluYB9f
         beYw==
X-Gm-Message-State: APjAAAXLK94Ru2zVuydJbXpo2bHrHRu+cwG9iVSBwLwk+9YFHXio+K4B
        AaABjjIwDh4TiN7kP59XTa7CiqIFRT403wGjxU/Xeds0T6bJ96sc3iPkCOiPJebbQw==
X-Google-Smtp-Source: APXvYqxGhF6vo/wtFSr8kkBUl+JAQEj4GArvjlAePwbbDhF95Bb3UIurjXaYDQui+Z1oyf2mQlSgT7de5fwy
X-Received: by 2002:a17:906:48da:: with SMTP id d26mr27550508ejt.106.1566322865145;
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id r3sm294701eds.40.2019.08.20.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0880-00032N-QR; Tue, 20 Aug 2019 17:41:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3373B2742B4A; Tue, 20 Aug 2019 18:41:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Remove duplicated quirks structure" to the asoc tree
In-Reply-To: <5ade5de27d23918c5ef30387c23aead951d5ad64.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174104.3373B2742B4A@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Remove duplicated quirks structure

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

From 3e9acd7ac6933cdc20c441bbf9a38ed9e42e1490 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:24 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Remove duplicated quirks structure

The A83t and H3 have the same quirks, so it doesn't make sense to duplicate
the quirks structure.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/5ade5de27d23918c5ef30387c23aead951d5ad64.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9468584f4eb0..4c636f1cf7dc 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1062,25 +1062,6 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.set_fmt		= sun8i_i2s_set_soc_fmt,
 };
 
-static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
-	.has_reset		= true,
-	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
-	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
-	.has_fmt_set_lrck_period = true,
-	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
-	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
-	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
-	.bclk_dividers		= sun8i_i2s_clk_div,
-	.num_bclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
-	.mclk_dividers		= sun8i_i2s_clk_div,
-	.num_mclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
-	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
-	.get_sr			= sun8i_i2s_get_sr_wss,
-	.get_wss		= sun8i_i2s_get_sr_wss,
-	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
-	.set_fmt		= sun8i_i2s_set_soc_fmt,
-};
-
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
@@ -1262,7 +1243,7 @@ static const struct of_device_id sun4i_i2s_match[] = {
 	},
 	{
 		.compatible = "allwinner,sun8i-h3-i2s",
-		.data = &sun8i_h3_i2s_quirks,
+		.data = &sun8i_a83t_i2s_quirks,
 	},
 	{
 		.compatible = "allwinner,sun50i-a64-codec-i2s",
-- 
2.20.1

