Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17438C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09BF233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389736;
	bh=z8GpUnHxe4DPTYTlWCksnNVEN8JhV88zCoOJnScCekU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UAvFVTxGT23f748vQ4N4Nr3xEnCH/CcPYVddyXDDP/u0TcaGpqdL8PAedsOSe8fsI
	 W6XPkt5FSNPiLtOvPAeIT9B0vuQE085fIPoFUSdisKgT0+KajE+4uR9cRK3Mmmtcxm
	 UfMArzV76uaE0gRyT4QfowiThj38s1k6PN9UXMjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfHUMPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:15:35 -0400
Received: from mail-ed1-f98.google.com ([209.85.208.98]:42062 "EHLO
        mail-ed1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfHUMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:15:35 -0400
Received: by mail-ed1-f98.google.com with SMTP id m44so2664460edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=k289+UQdb0wqQEwx6q0SK2SU4kG2QQx1UHCebGGvX40=;
        b=OctC9oWu8wLf6L64z+FymYTUt83mNsG0SMIANL1+DctlOV7efeDBDG0s4VAj6cKGXO
         BMW3aEbr2MFO0tRfm4Jutk4uEZtxAae3Rm0ZrYSKVQrJmcCdDidfPHP2wzsUO9Mn8mm3
         T8KxslM8/fY7VBLZNlka1sINfWmG+gOKSWU5nPGU7axPXKjNDTkrrhgQVRMZdoXFg+ku
         hyqZDNTP0mm1leyzxku8jtXZT1yU/cdAGhXi0GTYVF3NG+kvpDzl0ajbLKRLx6HX6nU6
         XKkCdo/m3PZFqnyyWhDr6NdTWVPl3qNzNOvm/xll+lg/ouLoUTQ+X/2MqUEl2AhCoI17
         qT4Q==
X-Gm-Message-State: APjAAAVA2yN16ZszGpiK3jYvc+xbzyC8Uz8R/5FbrcqHeczHdHYYai4T
        LmsUi4grOfFNrueYcsSTSr3Aq7K4oYIbPiK34Rfb24wXUzERzbwk08CgnLCWFHe5jA==
X-Google-Smtp-Source: APXvYqxemBvnGhrYqvB0zgpm980Eih485gmWiHKCun5oIIJmdz0Fc3/+4ucl+1xOP2OLUQqKIf6a9df73Lv3
X-Received: by 2002:a17:906:f2d0:: with SMTP id gz16mr29860515ejb.21.1566389733011;
        Wed, 21 Aug 2019 05:15:33 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id m12sm340610edq.41.2019.08.21.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:15:32 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0PWW-000774-IS; Wed, 21 Aug 2019 12:15:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0757D2742FCD; Wed, 21 Aug 2019 13:15:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Add support for TDM slots" to the asoc tree
In-Reply-To: <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190821121532.0757D2742FCD@ypsilon.sirena.org.uk>
Date:   Wed, 21 Aug 2019 13:15:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Add support for TDM slots

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

From 137befe19f310400a8b20fd8a4ce8c4141aafde0 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:27 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Add support for TDM slots

The i2s controller supports TDM, for up to 8 slots. Let's support the TDM
API.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 40 +++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9e691baee1e8..8326b8cfa569 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -168,6 +168,8 @@ struct sun4i_i2s {
 	struct reset_control *rst;
 
 	unsigned int	mclk_freq;
+	unsigned int	slots;
+	unsigned int	slot_width;
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
@@ -287,7 +289,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
 
 static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int rate,
-				  unsigned int channels,
+				  unsigned int slots,
 				  unsigned int word_size)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -335,7 +337,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 
 	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
 	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
-					  rate, channels, word_size);
+					  rate, slots, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
@@ -419,6 +421,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 				  const struct snd_pcm_hw_params *params)
 {
 	unsigned int channels = params_channels(params);
+	unsigned int slots = channels;
+
+	if (i2s->slots)
+		slots = i2s->slots;
 
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
@@ -428,7 +434,6 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 			   SUN4I_I2S_CHAN_SEL_MASK,
 			   SUN4I_I2S_CHAN_SEL(channels));
-
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
 			   SUN4I_I2S_CHAN_SEL_MASK,
 			   SUN4I_I2S_CHAN_SEL(channels));
@@ -452,10 +457,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int word_size = params_width(params);
 	unsigned int channels = params_channels(params);
+	unsigned int slots = channels;
 	int ret, sr, wss;
 	u32 width;
 
+	if (i2s->slots)
+		slots = i2s->slots;
+
+	if (i2s->slot_width)
+		word_size = i2s->slot_width;
+
 	ret = i2s->variant->set_chan_cfg(i2s, params);
 	if (ret < 0) {
 		dev_err(dai->dev, "Invalid channel configuration\n");
@@ -477,15 +490,14 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (sr < 0)
 		return -EINVAL;
 
-	wss = i2s->variant->get_wss(i2s, params_width(params));
+	wss = i2s->variant->get_wss(i2s, word_size);
 	if (wss < 0)
 		return -EINVAL;
 
 	regmap_field_write(i2s->field_fmt_wss, wss);
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
-	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      channels, params_width(params));
+	return sun4i_i2s_set_clk_rate(dai, params_rate(params), slots, word_size);
 }
 
 static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
@@ -785,10 +797,26 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int sun4i_i2s_set_tdm_slot(struct snd_soc_dai *dai,
+				  unsigned int tx_mask, unsigned int rx_mask,
+				  int slots, int slot_width)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	if (slots > 8)
+		return -EINVAL;
+
+	i2s->slots = slots;
+	i2s->slot_width = slot_width;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
+	.set_tdm_slot	= sun4i_i2s_set_tdm_slot,
 	.trigger	= sun4i_i2s_trigger,
 };
 
-- 
2.20.1

