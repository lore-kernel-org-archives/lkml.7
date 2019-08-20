Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85587C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B194230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566322931;
	bh=GQ6Ht7gEMEx1kcetLGyVp09WiypTLFPDSDd3b0eCUxI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UBB8FvP1zOat+VwzZJnNmtWGMsGps0HqeIsoT6alVy1AZJxNmN/hqxdlPwMpzid6b
	 3ywVS748+L/FtVbc2XuIYpEtd2q6+Oi+id+6Oy4IdxfRI14UqBGiZcY4puwkwIrHZe
	 TQX1Aq8eR6SiwV5KwoRyfc9SNzwqwT3puactugAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfHTRmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:42:10 -0400
Received: from mail-ed1-f99.google.com ([209.85.208.99]:44432 "EHLO
        mail-ed1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbfHTRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:07 -0400
Received: by mail-ed1-f99.google.com with SMTP id a21so7255154edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=qBAo3cxSBUzYkQwP713qVmqAb1nzWJ6m9zk9ALNnNwY=;
        b=J0sFZYJNtYes2g4hOAHmFmp9Hq/1K5QpnNIsC350ZHCOjJKAt3vGD/nlsyBw0mupoY
         met1mNDufCCRCOMN8n4zvkCYjb8KEMfQJXYmbuJlPsuOSv/1tZEfUOJYO+C+zACnuWgh
         brUkPsS8v4pD0Dxt0lor6GGl28o71GKFrzPnOZYAsSf5tvLHd8z1HfL21X/Y5IUkx1z4
         rqhgfTjp4O9Oa+j/IPMInbKB6jNb+r7tG6J/wC68bls8wZjliHRfvaFNsSldCgR7K9AQ
         O/UGQxFeycoHiJr3sQ6bFYGcNC1E8lDLthh20kVRrhk3fpgCbfDGlT8NnUfRGmVzV0BU
         TA2g==
X-Gm-Message-State: APjAAAXrXmuH1tItzcK+PUQYIUetAkWI6+aYi0nXn0B44wPm2SAdDplY
        nHnsNC98nzwudhuLC0x8GwYBhbD/TDhdar00tWQWNSrZnNVX23J5RcTQ16T184B1gQ==
X-Google-Smtp-Source: APXvYqz9otcJ0QBmKRz9DZ4q7HPAEoZRKoZlzxcnzAH3geHkf4DUyiFZJoL74mc5pqbc0agxyiSHzNnEpxOv
X-Received: by 2002:a17:907:4362:: with SMTP id nd2mr26896901ejb.29.1566322865208;
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id v11sm329824eds.33.2019.08.20.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:05 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0880-00032R-TY; Tue, 20 Aug 2019 17:41:04 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6884D274314C; Tue, 20 Aug 2019 18:41:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, codekipper@gmail.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: Fix the LRCK period on A83t" to the asoc tree
In-Reply-To: <6a0ee0bc1375bcb53840d3fb2d2f3d9732b8e57e.1566242458.git-series.maxime.ripard@bootlin.com>
X-Patchwork-Hint: ignore
Message-Id: <20190820174104.6884D274314C@ypsilon.sirena.org.uk>
Date:   Tue, 20 Aug 2019 18:41:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sun4i-i2s: Fix the LRCK period on A83t

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

From 69e450e50ca6dde566f3ac3f2c329fb0492441ef Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 19 Aug 2019 21:25:23 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Fix the LRCK period on A83t

Unlike the previous SoCs, the A83t, like the newer ones, need the LRCK
bitfield to be set. Let's add it.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://lore.kernel.org/r/6a0ee0bc1375bcb53840d3fb2d2f3d9732b8e57e.1566242458.git-series.maxime.ripard@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 0fce3c476772..9468584f4eb0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1047,6 +1047,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
+	.has_fmt_set_lrck_period = true,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
-- 
2.20.1

