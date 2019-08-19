Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C4B22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242749;
	bh=FI1Z16G2L56w/PfOf7U0vDl+HugLB6iI5NKI53j5Uo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o9Ri5qaYq8mUGesZTIv6RU6EeeupdnUecnPnHuSVibvD1XXYeJO5F7jmWbQMHaJPf
	 2jVY5x+wrSvk0Kzwww3gC6Xa4t49yBEBo9cFywgo+OwR5qWPTfhJER2fQdKZHUYA5C
	 TnBsTJXqZvAkWZOc/pFaN6rDHgzkxxfyhQcS/tDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfHSTZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfHSTZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:25:45 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1896522CF4;
        Mon, 19 Aug 2019 19:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242744;
        bh=FI1Z16G2L56w/PfOf7U0vDl+HugLB6iI5NKI53j5Uo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7ebQ20pnYfudZkMO7ql+dRP7aKAtfzbda2g7Y+fm6AlxT/xR5DjOOvPAnOiqELFq
         G0tRP4A4yZA8bEsMHO+6T8fhbpR049GxVXJyfdX6sLx2wlcqpM+LF1CGSDVzyte/7/
         GLqJhkNHUpzkicECq+58SkH97rLCM+B6OOo3CWxo=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t
Date:   Mon, 19 Aug 2019 21:25:21 +0200
Message-Id: <d93f0943cc39d880750daf459a0eeab34c63518e.1566242458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The A83t has the same bit fields offsets than the A10 and A31, while this
was the first device with the new layout, fix that.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9c9061621b15..b5c9774e2f60 100644
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
git-series 0.9.1
