Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A6AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D9222CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242813;
	bh=VhgrAobupFnriBgAL6k/Hl/4bbBPIrD3sq1OXXE+ARA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dVy00enN24MltYvIoMO5IZyAQc5td1M2jMnyormbnKo4C6CDluc0xl6FW7IUdUkUW
	 HtEC8gDN2CpSdqbaExGYGrvz0kyL1mOW/j8ML60Ro83Jpxced1CtHwgMAQ3eIZz2SZ
	 WSfyx1Nt2m/i8cSvqEmoWJa31W2tH5JLW3uByJZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfHST0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbfHST0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:33 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB3722CF4;
        Mon, 19 Aug 2019 19:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242792;
        bh=VhgrAobupFnriBgAL6k/Hl/4bbBPIrD3sq1OXXE+ARA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p6RdV/Ep6Zv/LdJ6M63W54T7enRfvTzAFbFTpGD6mSPL6xECJZJtZgMIyJThLBUQE
         h8hfQANxa2XBhT49fZUNlmbNmMs6tSRA8KA/gyh+0tSsqtI/Fbm247keYgCwCuuJOJ
         kClyW1GK3ieNh3fbnQAI6YrtJpWlJ6xlbIERyND0=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 20/21] ASoC: sun4i-i2s: Add support for TDM slots
Date:   Mon, 19 Aug 2019 21:25:27 +0200
Message-Id: <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
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

The i2s controller supports TDM, for up to 8 slots. Let's support the TDM
API.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 40 ++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 0dac09814b65..4f76daeaaed7 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -168,6 +168,8 @@ struct sun4i_i2s {
 	struct reset_control *rst;
 
 	unsigned int	mclk_freq;
+	unsigned int	slots;
+	unsigned int	slot_width;
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
@@ -287,7 +289,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
 
 static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int rate,
-				  unsigned int channels,
+				  unsigned int slots,
 				  unsigned int word_size)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -335,7 +337,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 
 	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
 	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
-					  rate, channels, word_size);
+					  rate, slots, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
 		return -EINVAL;
@@ -419,6 +421,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 				  const struct snd_pcm_hw_params *params)
 {
 	unsigned int channels = params_channels(params);
+	unsigned int slots = channels;
+
+	if (i2s->slots)
+		slots = i2s->slots;
 
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
@@ -428,7 +434,6 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 			   SUN4I_I2S_CHAN_SEL_MASK,
 			   SUN4I_I2S_CHAN_SEL(channels));
-
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
 			   SUN4I_I2S_CHAN_SEL_MASK,
 			   SUN4I_I2S_CHAN_SEL(channels));
@@ -452,10 +457,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	unsigned int word_size = params_width(params);
 	unsigned int channels = params_channels(params);
+	unsigned int slots = channels;
 	int ret, sr, wss;
 	u32 width;
 
+	if (i2s->slots)
+		slots = i2s->slots;
+
+	if (i2s->slot_width)
+		word_size = i2s->slot_width;
+
 	ret = i2s->variant->set_chan_cfg(i2s, params);
 	if (ret < 0) {
 		dev_err(dai->dev, "Invalid channel configuration\n");
@@ -477,15 +490,14 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (sr < 0)
 		return -EINVAL;
 
-	wss = i2s->variant->get_wss(i2s, params_width(params));
+	wss = i2s->variant->get_wss(i2s, word_size);
 	if (wss < 0)
 		return -EINVAL;
 
 	regmap_field_write(i2s->field_fmt_wss, wss);
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
-	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      channels, params_width(params));
+	return sun4i_i2s_set_clk_rate(dai, params_rate(params), slots, word_size);
 }
 
 static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
@@ -785,10 +797,26 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int sun4i_i2s_set_tdm_slot(struct snd_soc_dai *dai,
+				  unsigned int tx_mask, unsigned int rx_mask,
+				  int slots, int slot_width)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	if (slots > 8)
+		return -EINVAL;
+
+	i2s->slots = slots;
+	i2s->slot_width = slot_width;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
+	.set_tdm_slot	= sun4i_i2s_set_tdm_slot,
 	.trigger	= sun4i_i2s_trigger,
 };
 
-- 
git-series 0.9.1
