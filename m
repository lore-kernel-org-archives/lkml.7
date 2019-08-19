Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD4CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1163C22DA7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242794;
	bh=lxoSThi24SXgg6Bi+ISpQJ6IhICcstHztsngc91tupU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9SqumK9oLuTSKtxih0IEaPagJf3xOEvIQmW7C5OPuheaR6uT1iUCF07nt+rM+cy5
	 P5L7it+iL9S7b2u3YRWVx5yBto6M4xyxReJHzbs/Yl7vvczKYQFjGHjdnlriSf5WWI
	 syjbdwbXwhFwmkjQIkhft+ueP6ly2mrps1HnJGZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfHST0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfHST00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:26 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D71CE22CF4;
        Mon, 19 Aug 2019 19:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242786;
        bh=lxoSThi24SXgg6Bi+ISpQJ6IhICcstHztsngc91tupU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX5YpjCR6Cy5taU2uu95MCXzwXruGWw5Fg3YRi8pLtYNw8bHv3htNZ+8dlD3NSYZ/
         8mVF3pTOnIEeSdHhUy6ijh4GvuTjyCyzEWz8AcBevmuSWJ8LbjFW9HBO5FAjJs+9/b
         YTCaAM6cXrVVF1XIcSDWMwsKaXhav19FUncboFss=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] ASoC: sun4i-i2s: Pass the channels number as an argument
Date:   Mon, 19 Aug 2019 21:25:25 +0200
Message-Id: <48887cf7abfaab6597db233b24d7a088a913e48a.1566242458.git-series.maxime.ripard@bootlin.com>
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

The channels number have been hardcoded to 2 so far, while the controller
supports more than that.

Remove the instance where it has been hardcoded to compute the BCLK
divider, and pass it through as an argument to ease further support of more
channels.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 5dcbab0b4bcb..905e9bd16024 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -238,10 +238,11 @@ static unsigned long sun8i_i2s_get_bclk_parent_rate(const struct sun4i_i2s *i2s)
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 				  unsigned long parent_rate,
 				  unsigned int sampling_rate,
+				  unsigned int channels,
 				  unsigned int word_size)
 {
 	const struct sun4i_i2s_clk_div *dividers = i2s->variant->bclk_dividers;
-	int div = parent_rate / sampling_rate / word_size / 2;
+	int div = parent_rate / sampling_rate / word_size / channels;
 	int i;
 
 	for (i = 0; i < i2s->variant->num_bclk_dividers; i++) {
@@ -286,6 +287,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
 
 static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int rate,
+				  unsigned int channels,
 				  unsigned int word_size)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -333,7 +335,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 
 	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
 	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
-					  rate, word_size);
+					  rate, channels, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
@@ -488,7 +490,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      2, params_width(params));
 }
 
 static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
-- 
git-series 0.9.1
