Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46832230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322927;
	bh=5mRPbPYzUGzdVOCHLOCUyzdhxM8AVscxQN+4+raTykE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kZEaJFeZak0ud/IZEnX2pY58RCDElyL0sUEMv7DLNwNATJeX6gUQqiOC88MO8O2BU
	 1dBG6l8/pLVt379IBybIPs/3i7bc8DaawZibzwTlwpAlamzhHCN1hLNKnYfdXudLg/
	 06raiRGSR5KqFrqVLWWS4iAllXaXDoQU2DX3b9Ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfHTRmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:42:05 -0400
Received: from mail-wr1-f99.google.com ([209.85.221.99]:41216 "EHLO
        mail-wr1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfHTRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:07 -0400
Received: by mail-wr1-f99.google.com with SMTP id j16so13258421wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=Ykr2ti2nWYJlvFYvrUQQ3egoqvPPKK3gISVOAT9VfWc=;
        b=AWXAYTZm0R1iI1DRAnhIW2ldoPHH2RLqvttEBto3cPMw4lqb5IP+gRrXkZQ/DPS43i
         vR69+iWs/7RUIvtQQLxQXIEfHgk2brKom1khgYfJ3+U6s9O/2vcEKNU5LcV50H4BK1iR
         5Xf0kKw6TTmrR9l4quQrWNHVlwTJMegRpglsyBQK+T722VHt6ASqr0IyLw0fJH48wqws
         MPOFnR0tYZ+q+sSvh8C3SP2MkBB8hjj083aFGlT1ffFMA32GTt3j05hpLt6L6WaHTXN9
         mSa1IycGoo11Bd7iulOfWDAtWXCsjZPXALhEVq6lgwRVScAvu2x4cg1rUiYl62E6Sqjz
         3QeQ==
X-Gm-Message-State: APjAAAVelEQNAeTDu0tT7gyi27GzbXzYf1UkdJB0BL990t0lxayIquL0
        Z9VcwSAD7YIkKGf6k1vHU12vd9Hc+I59v02z5IA3AdaXcNZaQjYY58Udujpzda6UVA==
X-Google-Smtp-Source: APXvYqzA28Vdw32QmqeGXTEfJeos8NeI7FDcQlTUqGBgqqFGRTO65EHp27djzALulPpHRw7nRETO0/dsnLsr
X-Received: by 2002:adf:fe12:: with SMTP id n18mr35700959wrr.105.1566322865868;
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id h25sm2328wmb.21.2019.08.20.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0881-00032g-Ju; Tue, 20 Aug 2019 17:41:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F371F2742B4A; Tue, 20 Aug 2019 18:41:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Fix the LRCK polarity" to the asoc tree
In-Reply-To: <e03fb6b2a916223070b9f18405b0ef117a452ff4.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174104.F371F2742B4A@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Fix the LRCK polarity

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

From dd657eae8164f7e4bafe8b875031a7c6c50646a9 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:20 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Fix the LRCK polarity

The LRCK polarity "normal" polarity in the I2S/TDM specs and in the
Allwinner datasheet are not the same. In the case where the i2s controller
is being used as the LRCK master, it's pretty clear when looked at under a
scope.

Let's fix this, and add a comment to clear up as much the confusion as
possible.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/e03fb6b2a916223070b9f18405b0ef117a452ff4.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index e3eadfe38aaf..29b5eacd3abe 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -570,23 +570,29 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	u32 mode, val;
 	u8 offset;
 
-	/* DAI clock polarity */
+	/*
+	 * DAI clock polarity
+	 *
+	 * The setup for LRCK contradicts the datasheet, but under a
+	 * scope it's clear that the LRCK polarity is reversed
+	 * compared to the expected polarity on the bus.
+	 */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_IF:
 		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
+		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
 		/* Invert frame clock */
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		val = 0;
 		break;
 	case SND_SOC_DAIFMT_NB_NF:
-		val = 0;
+		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
 		break;
 	default:
 		return -EINVAL;
-- 
2.20.1

