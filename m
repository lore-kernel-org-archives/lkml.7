Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101EBC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D2121872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566898335;
	bh=CWtPfbqJFrgG+7X79G+npxJ/Ss/7eRL/CPDBSZIQam8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLwu8FrLfCt+75t9UxU3OvJXQP9UKUcAG/8EBMTKTwtpdv9JZ6OsPI9zNvbucOrDM
	 nIKhAECkr7F6yBUMENAi65gONhN3MJpFTpJzgNthHv8D+ZcejzPNzTvvhzNU85pW7a
	 iJIeoGkonLLoWSWCRuXRUMo959/JPdh6+M7sD4bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfH0JcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbfH0JcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:32:13 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849682189D;
        Tue, 27 Aug 2019 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566898332;
        bh=CWtPfbqJFrgG+7X79G+npxJ/Ss/7eRL/CPDBSZIQam8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0W9vs2Fny1Ax/hs0rRXidCQxA82Bpl1cqXeN+rKtRCcujsqYouc9Qj5MSUAhF/ASu
         gEwZ10iyZMPprOf7QqFqYUDH+s/WJHO2VdarCET0BXd0j78TUS7n0Xc9SDcsXYSp9j
         DR59k3yKQjrzEpC0gB6CbCLY+dtPsCuF69bhZoNM=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: sun4i: Revert A83t description
Date:   Tue, 27 Aug 2019 11:32:06 +0200
Message-Id: <20190827093206.17919-2-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827093206.17919-1-mripard@kernel.org>
References: <20190827093206.17919-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The last set of reworks included some fixes to change the A83t behaviour
and "fix" it.

It turns out that the controller described in the datasheet and the one
supported here are not the same, yet the A83t has the two of them, and the
one supported in the driver wasn't the one described in the datasheet.

Fix this by reintroducing the proper quirks.

Fixes: 69e450e50ca6 ("ASoC: sun4i-i2s: Fix the LRCK period on A83t")
Fixes: bf943d527987 ("ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t")
Fixes: 2e04fc4dbf50 ("ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t")
Fixes: 515fcfbc7736 ("ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs")
Fixes: c1d3a921d72b ("ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs")
Fixes: fb19739d7f68 ("ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs")
Fixes: 71137bcd0a9a ("ASoC: sun4i-i2s: Move the format configuration to a callback")
Fixes: d70be625f25a ("ASoC: sun4i-i2s: Move the channel configuration to a callback")
Reported-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a6a3f772fdf0..498ceebd9135 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1106,18 +1106,18 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
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
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
+	.bclk_dividers		= sun4i_i2s_bclk_div,
+	.num_bclk_dividers	= ARRAY_SIZE(sun4i_i2s_bclk_div),
+	.mclk_dividers		= sun4i_i2s_mclk_div,
+	.num_mclk_dividers	= ARRAY_SIZE(sun4i_i2s_mclk_div),
+	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
+	.get_sr			= sun4i_i2s_get_sr_wss,
+	.get_wss		= sun4i_i2s_get_sr_wss,
+	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
+	.set_fmt		= sun4i_i2s_set_soc_fmt,
 };
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
-- 
2.21.0

