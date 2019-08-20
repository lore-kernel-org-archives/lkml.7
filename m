Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7C5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CE022DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322947;
	bh=DFex1NGiYNAMXXhWiJHBvsmpev7Pr1DN5F/xNzd0Gpw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bKC5JdGZZYsMr02Ur2+o6kbwaWtSeuFX3W0WkWbdg4/MtLiWbYF1/8ZrzAEDosBwA
	 xnII2v77RMOTMlOR5HKG/bpKD/ayPKD36tYXi6oRsmoKhBIvfy5nTMmowaoqT3u1Da
	 yhmi1BFdC0O929/tfWXzpPXhlfFFoTmLAgT/S/oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfHTRm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:42:26 -0400
Received: from mail-wm1-f97.google.com ([209.85.128.97]:52920 "EHLO
        mail-wm1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbfHTRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:07 -0400
Received: by mail-wm1-f97.google.com with SMTP id o4so3368487wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=0sfeTaSMLRPw6OQW2nsE+rZY6o1t1xUbogKZMDZLLEw=;
        b=sp4x3ff7myC4LQy/StukRDiXj83Q+joOee+dCx6OHbRx/Vj9Fw7T35EykewuJXSaVB
         I5Tizb/3W1/7D7/fkqhTf7favYkrvZsEFQP5S7WjzAISTv/m3NrGJYfcO7+Iz+rnUXpm
         Dj3ywJX4tK4zPyOd1yQTNDf0NTyc5EJcht3XpT7u3dBkftABfw0I/ptbc5lN2zUdNYfW
         PwH5b9/1Fy553OSfs8vBltAqcshMB29TRBXD4yRu//mPo8ufHE1GfRIR+EW1E/oxgv5t
         iCRrgoLyI33/UNiu2oQDPpXaecCFf7UC2y4ZKnbdmykIt0tAv3/QLkh+sanH5mrid7ri
         2T+w==
X-Gm-Message-State: APjAAAWCWMQmgSLlbLmhdJMycm/cOs8wI7L8iK0cM3YnFDu7qsrsYhU4
        1APq9IaXJZALVpPeSAQf8HCKEoztA47HKMkfktvz3E9dr+0lXUU9lvvB0iVBIyPu/w==
X-Google-Smtp-Source: APXvYqyIoehCXJci24dNeS0SujgmrXX94WJNLwdaZsUvlBYtjeo3m37ZNLL3PxpVGQ7oj91dmq6wrflUgmRj
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr1243986wml.105.1566322865711;
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id s11sm3417wmj.44.2019.08.20.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0881-00032b-EF; Tue, 20 Aug 2019 17:41:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C46BB274314F; Tue, 20 Aug 2019 18:41:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t" to the asoc tree
In-Reply-To: <d93f0943cc39d880750daf459a0eeab34c63518e.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174104.C46BB274314F@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t

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

From 2e04fc4dbf50195262aa5a2ae6d35baa5b598cae Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:21 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t

The A83t has the same bit fields offsets than the A10 and A31, while this
was the first device with the new layout, fix that.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/d93f0943cc39d880750daf459a0eeab34c63518e.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 29b5eacd3abe..59d809df8d2a 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1048,8 +1048,8 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
-	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
-	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
 	.bclk_dividers		= sun8i_i2s_clk_div,
 	.num_bclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
 	.mclk_dividers		= sun8i_i2s_clk_div,
-- 
2.20.1

