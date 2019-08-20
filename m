Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43107C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1542722DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322890;
	bh=Sko6TAt8PS0BvloZiQh75yc+bXwSdw9gzEvK6bUCb+I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HRwmZb48qCPsCuNEwZfG/8QqSrrtOzz2/r78qBWSiYBDS0cD1fzfC7VFHOqjelrQg
	 7ejSOUS2Hp/eyBBxvWGNjmfvV1p9g2X9LAFyOP3CLc2lIqMlMb/FPyrwrtxCX1ftbh
	 tNvb/HfcaIWoUGRT6Fl084YRBQnoz+J/0y2aGr3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbfHTRl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:29 -0400
Received: from mail-wm1-f98.google.com ([209.85.128.98]:54917 "EHLO
        mail-wm1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:08 -0400
Received: by mail-wm1-f98.google.com with SMTP id p74so3351434wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=kKDiaFCwlI0LG0aQF2OZkw6zY1nZxCPFkp4+u3CT6J4=;
        b=p/EUSRfVFeRTOltVbm5VsG5PAt5ELX8Mw+ve7OS/sCmGq8+M45qAI2RhgStY7ujl37
         RWz4Ce/WRqz4G6KUBbeIhAqXgCX3FHR6kZr7vzeFedRdivLHUdqnjKSNwr/Q2jqIaKf8
         +7h7OIklDTDkURrSAY0fz/sC+flnIaO7Jdty23zfg98Rv4mmnqC+aQbQMfvWTMoaqkjD
         4rcHnqbBk9ovQfOJx8ogm6xsIhMhvNoICge6hPSwpHFoXQez3fas/hcXyUGp5noVuJ8N
         /Rifg+AD+CfjvuMsIuVLMMGzY0bPMkDQti5l7RhBRWHMqeIyFeKk9iph/jw+Uk33sabV
         AyPg==
X-Gm-Message-State: APjAAAWE3busfN0K6qvVeJdGNnKhMDq2zOrNS4tiL6zFUo/Z/PhLLw7R
        yag4+2yPylkQZmHl5ByK1gR9ZAM63Kds2w3aO/OU7a/KMMVJxovp3zGNHBco7j5Wkg==
X-Google-Smtp-Source: APXvYqz01JLuHJLn0Dp3nZavjwETeEjksL0n8HDLWQn0OO42CozJjNxHMz07TpXOEgSP5pxKNxvMFZvfsmkH
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr1179446wmm.119.1566322866279;
        Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id x21sm7945wmj.52.2019.08.20.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0882-00032m-0T; Tue, 20 Aug 2019 17:41:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 63827274314E; Tue, 20 Aug 2019 18:41:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: RX and TX counter registers are swapped" to the asoc tree
In-Reply-To: <8b26477560ad5fd8f69e037b167c5e61de5c26a3.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174105.63827274314E@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: RX and TX counter registers are swapped

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

From cf2c0e1ce9544df42170fb921f12da82dc0cc8d6 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:17 +0200
Subject: [PATCH] ASoC: sun4i-i2s: RX and TX counter registers are swapped

The RX and TX counters registers offset have been swapped, fix that.

Fixes: fa7c0d13cb26 ("ASoC: sunxi: Add Allwinner A10 Digital Audio driver")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/8b26477560ad5fd8f69e037b167c5e61de5c26a3.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 0a7f1d0f7371..53c95e5289f5 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -76,8 +76,8 @@
 #define SUN4I_I2S_CLK_DIV_MCLK_MASK		GENMASK(3, 0)
 #define SUN4I_I2S_CLK_DIV_MCLK(mclk)			((mclk) << 0)
 
-#define SUN4I_I2S_RX_CNT_REG		0x28
-#define SUN4I_I2S_TX_CNT_REG		0x2c
+#define SUN4I_I2S_TX_CNT_REG		0x28
+#define SUN4I_I2S_RX_CNT_REG		0x2c
 
 #define SUN4I_I2S_TX_CHAN_SEL_REG	0x30
 #define SUN4I_I2S_CHAN_SEL_MASK			GENMASK(2, 0)
-- 
2.20.1

