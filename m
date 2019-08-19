Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2517622CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242784;
	bh=pQ0Ph5rDPXfgCMzspmmfi9ilgy1fIlAZIRPD3Q25eMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugLnQ6QKWuRGRkcWLBwFAlSD4u7Y/tPz4mysg6agsVfA4eGyqSgz8gjl9+vlU1M3W
	 P+yOCuCEx9GmhtnZQl0gBPFNW16Ndk4WC1ZlcuN6iY9BTU08NlsICtq+goHBnsh9om
	 YdGIag+mxa5GNsxFy8ZNjLvUp8m1HifpZDjWx1v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfHST0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbfHST0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:20 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C701022CEC;
        Mon, 19 Aug 2019 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242779;
        bh=pQ0Ph5rDPXfgCMzspmmfi9ilgy1fIlAZIRPD3Q25eMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ArqWz0AnMOdmhO835g6d4XeWAlJn1HhRUJuMTUbfai/uRIO2GpwRWbRIEUI+fu326
         0D9GyE8X3d4q4fKSLn3SW3mGtcCTMEcmskatfV/vsHMpPqCjGmcuMJzT04MVaelMFI
         GhRJXzGZdXNd9hawaBHazR0jBMq8Jry2QPgRu2dQ=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 16/21] ASoC: sun4i-i2s: Fix the LRCK period on A83t
Date:   Mon, 19 Aug 2019 21:25:23 +0200
Message-Id: <6a0ee0bc1375bcb53840d3fb2d2f3d9732b8e57e.1566242458.git-series.maxime.ripard@bootlin.com>
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

Unlike the previous SoCs, the A83t, like the newer ones, need the LRCK
bitfield to be set. Let's add it.

Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 5dd742f24a7e..65bc296abb37 100644
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
git-series 0.9.1
