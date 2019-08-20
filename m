Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E72CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0352D230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322919;
	bh=uRsm/7tgV7KegozUBupUH4L602YbMuhOADaMLj8sovk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SL6YqVkQjuXBp2VdVv8i57qp4EsFKLqfjusqER5u1Ximx3ROTMsFPYWnc3AIyC+AQ
	 9iLeVLb7TrBTIwTvBnzdLr2SAlgm1eyvO1Az3mq2A7/NLEUUFYQEcffSUKYMOPlkaf
	 dSnokFVgPZ9KcS6c9Slz0BSL5ir6V/6h55WMtbQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfHTRl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:58 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:53568 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfHTRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:08 -0400
Received: by mail-wm1-f97.google.com with SMTP id 10so3352972wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=cv4TUIOWFi+U3SKBDcKMgdYCwyfU6uWRpO1K0GUZKw4=;
        b=pPcRKht82Qs8vPHt3Oboi+DKLg6CER7V8l88vuPGboLWp7jnEBjduwfwuNvVzHro+M
         lQHPiGsAl+oF4J31d6D2nV7m1WldTejYuQHjk9NFEPKTMNAxZBrlXh4A/Kzf4HPyma6l
         7mSsTfMFjcqLm1Ij2vDczMOJcULKz4dZq+EXHKcCJ05fAryRaodj/QqCGPzo2odRCb7T
         cH8xVd0QjcwLKKIbwT8gMxgXoQ5tn1eMcEVfSBdvYeXgckfzMwPvOk5ztxY4M8pPHVhm
         s/1M9Dw1meukHH9xM1klv11yyhk8cj35WyVsUzlGbarg0eMHeWHoOq45UpG0kPYb7s8c
         32Gg==
X-Gm-Message-State: APjAAAW4Y0Io1TvDi4L78qFHDvVUeVQ/OO965ITzfV0aKDzt/Dp4fhn1
        dsOZHkWCkWHPOzh3IaUDOJ27XcDEbIkkaBLUAdToj2ERUhe3jG5zo91IMm89RZ33tw==
X-Google-Smtp-Source: APXvYqx+uYT4jx9ACy29QjlApKPxhCbQv2rES9wXuR4Nh6Dk5Vdpymoo9jTZUubbskZ+TyFuKXsASa8lpkci
X-Received: by 2002:a1c:4d0c:: with SMTP id o12mr1296350wmh.62.1566322867460;
        Tue, 20 Aug 2019 10:41:07 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id x17sm4152wmk.48.2019.08.20.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:07 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0883-00033C-7z; Tue, 20 Aug 2019 17:41:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A19B12742B4A; Tue, 20 Aug 2019 18:41:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Rework MCLK divider calculation" to the asoc tree
In-Reply-To: <dcc5deb2eb650758d268bddd20f60ba58856d024.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174106.A19B12742B4A@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Rework MCLK divider calculation

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

From 8bcf62b73e5421df94deca95d7d7c152997fe5b4 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:13 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Rework MCLK divider calculation

The MCLK divider calculation is currently computing the ideal divider using
the oversample rate, the sample rate and the parent rate.

However, since we have access to the frequency is supposed to be running at
already, and as it turns out we're using it to compute the oversample rate,
we can just use the ratio between the parent rate and the MCLK rate to
simplify a bit the formula.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/dcc5deb2eb650758d268bddd20f60ba58856d024.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 77b7b81daf74..0a5fb9d4b289 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -240,11 +240,10 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 }
 
 static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
-				  unsigned int oversample_rate,
-				  unsigned int module_rate,
-				  unsigned int sampling_rate)
+				  unsigned long parent_rate,
+				  unsigned long mclk_rate)
 {
-	int div = module_rate / sampling_rate / oversample_rate;
+	int div = parent_rate / mclk_rate;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_mclk_div); i++) {
@@ -323,8 +322,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-					  clk_rate, rate);
+	mclk_div = sun4i_i2s_get_mclk_div(i2s, clk_rate, i2s->mclk_freq);
 	if (mclk_div < 0) {
 		dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
 		return -EINVAL;
-- 
2.20.1

