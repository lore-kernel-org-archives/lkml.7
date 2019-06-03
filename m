Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD8C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEA825DE8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inCF8BOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfFCRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:48:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfFCRrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id r15so14266495lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ur5v7XbU91UriUW2h6RMKxmyWAgpctbZAf13n7i/6Rw=;
        b=inCF8BOYhELNpO/KJh+A9lLUq1a8C5GA+kjnPdhiui+U8rQ/FNyRp9cmbMe5Lyj+NU
         J6we28dVAYeeJDArsApnLoE7mruvGGGwgbR2D+B0MSFyt9s9qDQcXluySyZY5gaBnYYO
         whfSHTH67PwTBfrFkBHC+hIhx6AcMne8EmQtymOGyE+PV0FU9MULvMtgqH4XgBTJdsFO
         /v6kT43Ab+IikIpVESppgg/G6eB+QTJ+1wEANTKi4v32CgL+pLPH5RyvL3c+7eE9T9tl
         qFtgTexW5lYMnlqAJo6fTfPkSeSvarpM+zkC5GUkatUGpOQt+aEO/Qen0SldMX2l/UO7
         /N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ur5v7XbU91UriUW2h6RMKxmyWAgpctbZAf13n7i/6Rw=;
        b=kfWISEbDcNDLxS/c5KL2CfoN5rCJepXHVdfls1rciYRwaADOk4MRg+wv9B46lDMIw+
         /vACJW/tTuBuNQK9ZfbFtAUOfntIJg05PEAexhKGPczdFAhER/uAg/pU7huB9WuqyRJD
         EnfKI60pTzB/necS8dX3T7brwtFDCPf5yUmf3KJ5Pi9YgLdBIEuXLMfKp2WFTj1hJ+D5
         0F3ERIa8MdKOdidqv2LCrE5m1UD0O6m8IswDASriPCaBa9y1SBxK2CnJg333j+HYD8eB
         jYy2plZfqTc4Xn6k+Mv1EW9N/MFdxCIVYYpjr082rt/PLxAVep65myZ3BmdmyDerbS4t
         fxlg==
X-Gm-Message-State: APjAAAUlww5IRFoWlp+MvbTwB/ktZ5+uZYILPQQLSDstv6sKVSASGV4Y
        zEweayoQwq4lLlY9/6fkjdM=
X-Google-Smtp-Source: APXvYqz2pKQV+7BUdcmW2KcRqAvIDAP90CUT/MMbXp8JSZvceyq2+oSKVnW9wvS+b/LqDYdXRxkXIw==
X-Received: by 2002:ac2:434c:: with SMTP id o12mr14255240lfl.128.1559584064659;
        Mon, 03 Jun 2019 10:47:44 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:44 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 7/9] ASoC: sun4i-i2s: Add multichannel functionality
Date:   Mon,  3 Jun 2019 19:47:33 +0200
Message-Id: <20190603174735.21002-8-codekipper@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603174735.21002-1-codekipper@gmail.com>
References: <20190603174735.21002-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

The i2s block can be used to pass PCM data over multiple channels
and is sometimes used for the audio side of an HDMI connection.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 121 +++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 57 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 75217fb52bfa..3549a87ed9e9 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -189,6 +189,7 @@ struct sun4i_i2s {
 
 	unsigned int	tdm_slots;
 	unsigned int	slot_width;
+	unsigned int	offset;
 };
 
 struct sun4i_i2s_clk_div {
@@ -358,56 +359,71 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	int lines;
 
 	channels = params_channels(params);
-	if ((channels > dai->driver->playback.channels_max) ||
-		(channels < dai->driver->playback.channels_min)) {
-		dev_err(dai->dev, "Unsupported number of channels: %d\n",
-			channels);
-		return -EINVAL;
-	}
-
-	lines = (channels + 1) / 2;
-
-	/* Enable the required output lines */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_SDO_EN_MASK,
-			   SUN4I_I2S_CTRL_SDO_EN(lines));
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if ((channels > dai->driver->playback.channels_max) ||
+			(channels < dai->driver->playback.channels_min)) {
+			dev_err(dai->dev, "Unsupported number of channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
 
-	if (i2s->variant->is_h3_i2s_based) {
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
-	}
+		lines = (channels + 1) / 2;
 
-	/* Map the channels for playback and capture */
-	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
-	regmap_field_write(i2s->field_txchanmap, 0x10);
-	if (i2s->variant->is_h3_i2s_based) {
-		if (channels > 2)
-			regmap_write(i2s->regmap,
-				     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
-		if (channels > 4)
-			regmap_write(i2s->regmap,
-				     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
-		if (channels > 6)
-			regmap_write(i2s->regmap,
-				     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
+		/* Enable the required output lines */
+		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+				   SUN4I_I2S_CTRL_SDO_EN_MASK,
+				   SUN4I_I2S_CTRL_SDO_EN(lines));
+
+		if (i2s->variant->is_h3_i2s_based)
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
+
+		regmap_field_write(i2s->field_txchanmap, 0x10);
+		/* Configure the channels */
+		regmap_field_write(i2s->field_txchansel, SUN4I_I2S_CHAN_SEL(2));
+
+		if (i2s->variant->is_h3_i2s_based) {
+			u32 chan_sel = SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset) | 0x1;
+			regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
+				     chan_sel | 0x30);
+
+			if (channels > 2) {
+				regmap_write(i2s->regmap,
+					     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
+				regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG+4,
+					     chan_sel | 0x30);
+			}
+			if (channels > 4) {
+				regmap_write(i2s->regmap,
+					     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
+				regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG+8,
+					     chan_sel | 0x30);
+			}
+			if (channels > 6) {
+				regmap_write(i2s->regmap,
+					     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
+				regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG+12,
+					     chan_sel | 0x30);
+			}
+		}
+	} else {
+		/* Map the channels for capture */
+		regmap_field_write(i2s->field_rxchanmap, 0x00003210);
+		regmap_field_write(i2s->field_rxchansel,
+				   SUN4I_I2S_CHAN_SEL(params_channels(params)));
+
+		if (i2s->variant->is_h3_i2s_based) {
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
+
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
+					   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+					   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
+		}
 	}
 
-	/* Configure the channels */
-	regmap_field_write(i2s->field_txchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
-
-	regmap_field_write(i2s->field_rxchansel,
-			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
-
-	if (i2s->variant->is_h3_i2s_based)
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_EN_MASK,
-				   SUN8I_I2S_TX_CHAN_EN(channels));
-
 	switch (params_physical_width(params)) {
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -445,7 +461,6 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	u32 val;
-	u32 offset = 0;
 	u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 	u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 
@@ -453,7 +468,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		val = SUN4I_I2S_FMT0_FMT_I2S;
-		offset = 1;
+		i2s->offset = 1;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		val = SUN4I_I2S_FMT0_FMT_LEFT_J;
@@ -474,16 +489,8 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		 * i2s shares the same setting with the LJ format. Increment
 		 * val so that the bit to value to write is correct.
 		 */
-		if (offset > 0)
+		if (i2s->offset > 0)
 			val++;
-		/* blck offset determines whether i2s or LJ */
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
-
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 	}
 
 	regmap_field_write(i2s->field_fmt_mode, val);
-- 
2.21.0

