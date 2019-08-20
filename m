Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A322C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC4D233FE
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322870;
	bh=kupHJuiJvXp9WggSD7PpC5YOjKYBJfylKbL1pa5WXRM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0hkB3yqacyTFClBmSWpUPHYjNV3suyUWVP0GT/arNtplGlxpVNwpYJWtz9aL2YwPQ
	 x8pJ0udiPCrT3Gaw7HoksBf4fx3JLDvBflGtDK7/gCGxaDwTKq/CBTKwy5VpzbsfBv
	 hjoTOQJph5MnNWnplboFw0L81ZyvYtJkHtx5YGoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfHTRlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:08 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:34183 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbfHTRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:07 -0400
Received: by mail-wr1-f97.google.com with SMTP id s18so13286820wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=CNHnOIouTXcfZi2QJaXlrxvoIBJ+2d0YiQ2eL3BvS1U=;
        b=X2WSgYgpXtVxSmiRZfQtsv9oFNQw5EQgn/UNkcc7XJYIietct7eaF3uiRJEtgLKxwF
         mxsQA0b0MvwZSSajLz3h8b0IO5Rg0x+tVjjocJjBoKKuuqn+Po5snEuWf4ChgqsVjUpF
         380nbXCEUm6/F2SMYayXm35IQxjgdhwQwJNYrluSmxadpJost5B/IjMaxRgIuI7sunLG
         tvBm5+UUoVmBbXb/1jcr+WgqmoUwskuiL2RG+h1R5ElvCgsTnA1lWNrB6nktm3fF478r
         cumBV/MN18GRVVjsTN86qJqfak0nAqIo54asypZGsCUhmMH8lEaEs2+DBGOFbLXGMJH0
         yYGg==
X-Gm-Message-State: APjAAAU/h9yz9TRyO9x4G0fqYMh3WmTxI7oV/+OlILXyXGC+YbPdv1wN
        VDvLuDoW2jmQ+pGDXxFPPOd/oOYMiKitu0hQCf0TZVC44MZJPoJUUMz5p55uq9kXaQ==
X-Google-Smtp-Source: APXvYqze162Y+KpGs3T8/NLX6GYRPKPfdwtR2t59Iiph1sIsbnGEZfF800kRYfhtJoHFNm9YuZ6/M2tO/KS9
X-Received: by 2002:adf:d1b4:: with SMTP id w20mr35978435wrc.301.1566322865376;
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id z17sm2346wml.40.2019.08.20.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0881-00032V-3M; Tue, 20 Aug 2019 17:41:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 97890274314E; Tue, 20 Aug 2019 18:41:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t" to the asoc tree
In-Reply-To: <43b07f8cd8e0e280c64ce61d57c307678c923e9b.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174104.97890274314E@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t

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

From bf943d527987c38f6fb11f9515e0cf2839286eb8 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:22 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t

The A83t, unlike previous SoCs, has the MCLK enable bit at the 8th bit of
the CLK_DIV register, unlike what is declared in the driver.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/43b07f8cd8e0e280c64ce61d57c307678c923e9b.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 59d809df8d2a..0fce3c476772 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1047,7 +1047,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
-	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
 	.bclk_dividers		= sun8i_i2s_clk_div,
-- 
2.20.1

