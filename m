Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B0C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3E822DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322892;
	bh=TLEHO3fJcfKGN5k65E1ESbrx63seMeAO6mCV1OTCQW0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Ywi5njbfwkbeVYWRUImIp6gjma07cgMV7i8HRTDliNUhhZzaFj7nYNjX2uhcyI56v
	 U8VUcZKdn5cjcIE8b4CwC8kfDqdBjjn8WYxv0AmLYq1fVHtlXx41ksHxwKYGku0S/Q
	 /H0JHCqZvB4y/QSll8MAq1b5ksKMceTf9mfVLnfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfHTRlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:31 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:55369 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfHTRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:08 -0400
Received: by mail-wm1-f99.google.com with SMTP id f72so3346208wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=RSHLf/fk8eaNAk0hQQsquTa2DY6x+xoJ3ov9YVjIq/Q=;
        b=CVr65blf+W1K2cOwbnEtD3P6Q0B2AvyAOaQINlmHGDh/IKucuTwoQjXMWTtPbVobGL
         zCadaIwyQYwBZ8KYg7SaTMJ2KqbFSO66xZut10SY+R6fUPZJvl88jSIk+esuzHGImboe
         JyeMsrS1RnWMXs9KawecLfq3wwfixRtcKTJyY2MRzdp4PlyVrSWWNckRjmnUBsp5Eknq
         b+u8oP1D1B9cUPQbzOgdx2QokBw42pOez3bMirEkG5MuMunWP2ZrmI9hbml/VYnKTWYt
         vbUXqyFQMOvUcHDmN5foZmlVNvrDfSOh48KXlsnf12tUVyFhqD42ZwpO+Q9IjTgNoDWw
         oi1A==
X-Gm-Message-State: APjAAAWd/JiD3iibJjGCB/RlEqIk6olHrxudqro2tFPyQJlCnqmqGiPT
        OaIT4uYe3XhqmhtmUiDNdtNC7JMZ2EiMbjDTWVmiHpE6LFXsDZMRvzU/NtrV0ALa5g==
X-Google-Smtp-Source: APXvYqztnyVmdPDzxrUY5iAQAoCgujNpZ+N7WTCnFZWiqy+hQt9r6xjVGCEkruW8NThu5q8NoyncOQMDxu8F
X-Received: by 2002:a1c:a852:: with SMTP id r79mr1220178wme.36.1566322866794;
        Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id 61sm291082wra.39.2019.08.20.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0882-00032u-Fd; Tue, 20 Aug 2019 17:41:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C997E2742B4A; Tue, 20 Aug 2019 18:41:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs" to the asoc tree
In-Reply-To: <0b6665be216b3bd0e7bc43724818f05f3f8ee881.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174105.C997E2742B4A@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs

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

From fb19739d7f688142b61d0fca476188c4fd9e937a Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:15 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Use module clock as BCLK parent on newer
 SoCs

On the first generation of Allwinner SoCs (A10-A31), the i2s controller was
using the MCLK as BCLK parent. However, this changed since the introduction
of the A83t and BCLK now uses the module clock as its parent.

Let's introduce a hook to get the parent rate and use that in our divider
calculations.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/0b6665be216b3bd0e7bc43724818f05f3f8ee881.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 93ea627e2f1f..acfcdb26086a 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -152,6 +152,7 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_bclk;
 	struct reg_field		field_fmt_lrclk;
 
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *,
@@ -207,6 +208,16 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 	/* TODO - extend divide ratio supported by newer SoCs */
 };
 
+static unsigned long sun4i_i2s_get_bclk_parent_rate(const struct sun4i_i2s *i2s)
+{
+	return i2s->mclk_freq;
+}
+
+static unsigned long sun8i_i2s_get_bclk_parent_rate(const struct sun4i_i2s *i2s)
+{
+	return clk_get_rate(i2s->mod_clk);
+}
+
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 				  unsigned long parent_rate,
 				  unsigned int sampling_rate,
@@ -259,7 +270,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int word_size)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	unsigned int oversample_rate, clk_rate;
+	unsigned int oversample_rate, clk_rate, bclk_parent_rate;
 	int bclk_div, mclk_div;
 	int ret;
 
@@ -301,7 +312,8 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, i2s->mclk_freq,
+	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
+	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
 					  rate, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
@@ -957,6 +969,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
@@ -972,6 +985,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
@@ -987,6 +1001,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
@@ -1005,6 +1020,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
+	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
@@ -1020,6 +1036,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
-- 
2.20.1

