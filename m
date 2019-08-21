Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD88C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C74233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566392824;
	bh=BBzaWBopHO0dXbT/Y5GDnPjB6CfdvBFxbOeeyx6S4ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BIdWxMfBiQXcVo0GaBU8tdIrUgtfO/tTCGmZlE/vHkTdSCTdz6KHNmQN5CQ5Zxrmo
	 MzQo1rLyymDzzrGPAo/oktt/CQdzTRZdTSPpxLcnf9bp5KKDwlo5nvzR8gp6ERTvgA
	 cy8VFsfHW9+g2WIHbmE8RGsKLoPjujjAML2EnjRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfHUNHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfHUNHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:07:02 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B30233A1;
        Wed, 21 Aug 2019 13:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566392821;
        bh=BBzaWBopHO0dXbT/Y5GDnPjB6CfdvBFxbOeeyx6S4ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGA0PFtgjnfGGkKB0QnGIWKutIGHg+UW6n7Vpy7rybyGge9TyUJLVB1C5MJtMvxNc
         1qx/u+NBFt6FzGOLWRVYI5CMxt0kXOlmc0Uf0iEeI7dhY08FJu82fEekiiwoJ8hhWV
         B+Nlxkgtsz4JHwE4tdXDl3Reob+rWtS/l3ibNxzw=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ASoC: sun4i-i2s: Use the physical / slot width for the clocks
Date:   Wed, 21 Aug 2019 15:06:53 +0200
Message-Id: <41a359d9885f397e066816961e5e3236afcbe0a1.1566392800.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
References: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The clock dividers function has been using the word size to compute the
clock rate at which it's supposed to be running, but the proper formula
would be to use the physical width and / or slot width in TDM.

It doesn't make any difference at the moment since all the formats
supported have the same sample width and physical width, but it's not going
to last forever.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8326b8cfa569..cdc3fa60ff33 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -290,7 +290,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
 static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int rate,
 				  unsigned int slots,
-				  unsigned int word_size)
+				  unsigned int slot_width)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	unsigned int oversample_rate, clk_rate, bclk_parent_rate;
@@ -337,7 +337,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 
 	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
 	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
-					  rate, slots, word_size);
+					  rate, slots, slot_width);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
@@ -458,6 +458,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	unsigned int word_size = params_width(params);
+	unsigned int slot_width = params_physical_width(params);
 	unsigned int channels = params_channels(params);
 	unsigned int slots = channels;
 	int ret, sr, wss;
@@ -467,7 +468,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		slots = i2s->slots;
 
 	if (i2s->slot_width)
-		word_size = i2s->slot_width;
+		slot_width = i2s->slot_width;
 
 	ret = i2s->variant->set_chan_cfg(i2s, params);
 	if (ret < 0) {
@@ -490,14 +491,15 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (sr < 0)
 		return -EINVAL;
 
-	wss = i2s->variant->get_wss(i2s, word_size);
+	wss = i2s->variant->get_wss(i2s, slot_width);
 	if (wss < 0)
 		return -EINVAL;
 
 	regmap_field_write(i2s->field_fmt_wss, wss);
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
-	return sun4i_i2s_set_clk_rate(dai, params_rate(params), slots, word_size);
+	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
+				      slots, slot_width);
 }
 
 static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
-- 
git-series 0.9.1
