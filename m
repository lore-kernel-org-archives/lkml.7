Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D1C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46ED206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242817;
	bh=ymigtzJxDzs6w2lYCkBBjjo8T8VlyeDsLvih9ONSq0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jLEfWjDydJAcSUT0SPeYwAKltOBI+itQlsEE0EPz8ZzJyD7cJof3451FGHDkvLDiD
	 EeFL5FgyT4CjC9CgK8wToO6Y8mtnB7bwaD6TikMgzKTdDehnzdAuqWiPoNUE/B71HY
	 aDubD8qShas5N+f6vE868f0lfVdwNOJuKquGhLH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfHST0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbfHST0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:30 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02B922CF6;
        Mon, 19 Aug 2019 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242789;
        bh=ymigtzJxDzs6w2lYCkBBjjo8T8VlyeDsLvih9ONSq0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0okEGtFQwjlX7U1MXSTG746Qc8KNHUPK39wSVFPinZ3XhYJgpFLKTLiSpqdc7htN
         jblgOU4qZSeqvvxu4rHG6VdivnWnQvg2oR+Lr+VoWdCAX8VXlUrl5w2I5vBF0h9x7/
         CffkLNgcHwGDYZO7dO416TPSZBS0zqpE/v0U7xUY=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 19/21] ASoC: sun4i-i2s: Support more channels
Date:   Mon, 19 Aug 2019 21:25:26 +0200
Message-Id: <27d9de5cd56f3a544851b8cd8af08bf836d19637.1566242458.git-series.maxime.ripard@bootlin.com>
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

We've been limited to 2 channels in the driver while the controller
supports from 1 to 8 channels, in both capture and playback. let's remove
the hardcoded checks and numbers, and extend the range of channel numbers
we can use.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 905e9bd16024..0dac09814b65 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -400,9 +400,6 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 {
 	unsigned int channels = params_channels(params);
 
-	if (channels != 2)
-		return -EINVAL;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
@@ -423,9 +420,6 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 {
 	unsigned int channels = params_channels(params);
 
-	if (channels != 2)
-		return -EINVAL;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
@@ -458,6 +452,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int channels = params_channels(params);
 	int ret, sr, wss;
 	u32 width;
 
@@ -490,7 +485,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      2, params_width(params));
+				      channels, params_width(params));
 }
 
 static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
@@ -814,15 +809,15 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 2,
-		.channels_max = 2,
+		.channels_min = 1,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.playback = {
 		.stream_name = "Playback",
-		.channels_min = 2,
-		.channels_max = 2,
+		.channels_min = 1,
+		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-- 
git-series 0.9.1
