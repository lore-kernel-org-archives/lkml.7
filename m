Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14BCC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C080122DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322956;
	bh=Gba5Hu9hanQ4cuu31fV5N0D8jO/QcUL3riT0QfH0M8U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MhD1L0R3bNMBtRKTqlFWCb732BaFDL96VzikQS7HtC8JgHWdMdrTrVrGv+3bOXN9s
	 NWbkLwuvocJ38W2m+dwzCVusE46JaPtI2eDbttd23xvvCavZIFA9uqg1Rri2Rs5gUJ
	 7xvdSW3VDbwwu/KQWZV9MNL7a1T8PxRFT2JRJ4Kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfHTRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:42:35 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:37515 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfHTRlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:06 -0400
Received: by mail-wr1-f97.google.com with SMTP id z11so13269671wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=ABCcOn5GHJ8lNU8EGGWNRlyaGFZyomNizJdK6sCFsYs=;
        b=CQlaT8ArlBYtIeUz/WUb7BzZ3sXN8Uk+o/FfEEtt9ebsjd60Yj612BIf98yp2pQ4Y8
         ApgJssA/lmJC9/lk+fKTD9QTq4MMRrEp5HXCr2UrTtIfrAgfk10m11u1xPJY8IugoUrE
         zgSoEaj9052c9x+C6SGCgxK9FXbyPakNtE5F7BmCuYWmQVelxU0K9ErKxTtGnn1YEfId
         T8tTaLPIkG+7UTS3Jig2451DKSH55/FChYEtcyMOFZIVseIeKESTpc6Q8StN1Ez3St78
         Du1wSgmwDDZEBfra8Fbt1ORdG8b96+XEBWfQCC/unTil/ZChnTSwLcRfT5h6K9pmP2fa
         nULQ==
X-Gm-Message-State: APjAAAXkuGxErHpYbQlwdMqJKWxCd8klCHknOer/wwGwATNLERPL8mQ+
        LZBRA3HyqKWJegYHFE4SMDJKH5P1A0Yl55h/QG2eGXSyA0Gu5RXiOzpRbQOv8jwVgA==
X-Google-Smtp-Source: APXvYqya89xuBIGdtG+azWgCNH3nH0mRaN7p+fQCVe4tmxScBaCkLVxmDB+YfrCLKVXwVasNjDM2XMTuqfy0
X-Received: by 2002:adf:82cd:: with SMTP id 71mr31193025wrc.265.1566322864760;
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id x12sm314086wrv.41.2019.08.20.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:04 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0880-00032F-Fp; Tue, 20 Aug 2019 17:41:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C506D274314F; Tue, 20 Aug 2019 18:41:03 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Support more channels" to the asoc tree
In-Reply-To: <27d9de5cd56f3a544851b8cd8af08bf836d19637.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174103.C506D274314F@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:03 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Support more channels

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

From bbf9a127abca4aac5cc75f882bc7efcc398e86ae Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:26 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Support more channels

We've been limited to 2 channels in the driver while the controller
supports from 1 to 8 channels, in both capture and playback. let's remove
the hardcoded checks and numbers, and extend the range of channel numbers
we can use.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/27d9de5cd56f3a544851b8cd8af08bf836d19637.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 6b172dfbc25d..9e691baee1e8 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -400,9 +400,6 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 {
 	unsigned int channels = params_channels(params);
 
-	if (channels != 2)
-		return -EINVAL;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
@@ -423,9 +420,6 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 {
 	unsigned int channels = params_channels(params);
 
-	if (channels != 2)
-		return -EINVAL;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
@@ -458,6 +452,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int channels = params_channels(params);
 	int ret, sr, wss;
 	u32 width;
 
@@ -490,7 +485,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      2, params_width(params));
+				      channels, params_width(params));
 }
 
 static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
@@ -814,15 +809,15 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 2,
-		.channels_max = 2,
+		.channels_min = 1,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.playback = {
 		.stream_name = "Playback",
-		.channels_min = 2,
-		.channels_max = 2,
+		.channels_min = 1,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-- 
2.20.1

