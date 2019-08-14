Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BEAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45BC2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/JFLeR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfHNGJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46177 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfHNGJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id n19so10066177lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgF+iQ71N63fzGiwQW4cF1hqYUHS6u6C/HWG5UzaxPs=;
        b=f/JFLeR3DcJywbYWdN8lm2tKUulDCXEf9JpBXBUBrF041WiZSdgsyB4Wi9PMvDUjX6
         NEPWQAkrBgCH90ub/1Mq2e289lSfxj7EOu17iL2kahf/PiRsQPsVM5gkxIpVBDEQIt8Z
         R7BEWYAvbPXnsFE6DHJsyjllky7PZdgjgY6oRelW3PBGn3sKabNjeUcz94fyytsnpsPW
         Dl5tIZhp9o1FklMyxbSIjSW88Cykrke7ZVbuTA7xmUhG6qOcd72iBleye8UmxutefK+d
         Y36C0TGhkoL6fBBuo2nhUma62HQR2ZZnet7xOtunYR7qALgXG1Xm8ApQYJC/bMVrPXAn
         Bhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgF+iQ71N63fzGiwQW4cF1hqYUHS6u6C/HWG5UzaxPs=;
        b=j2Qxp68a4qVzJfTpnqOiofCTKVF5BBedYImwrcUaZGyUPqMVcHU5hxH4qSUOF1nBKN
         kmVaSHuLXzI47sewTzUjw3uPwlx0IUaNIto4zQmIJKuAXm8tHP6E06YeTuYNwfj+okNe
         QU1D8nEpmyAZQzZ2DbJpmwr+atBmDNGa3kSc26y8vZLiLaaZ1WH5b+6chXU3iIz65T/k
         FxviN+bs33PUP3ys9DcO2x3PCofd4f/iOYRaBWHxOl9abhzoWTZco0uyW9xTaWHJxlcD
         noO1dcZkDeWwH6qFc3DQ1zY/eZYE17KfdU4TTAVbYk1k4Hh+rR/ryFoGb3LKkOfeGVIi
         UGWg==
X-Gm-Message-State: APjAAAVjXdkdsA27Vx0GyyZOZjX0zerTHORQzOHfM+NjPwIb0bZcK0Qa
        thewnNm/qK80fxqZtdMEccY=
X-Google-Smtp-Source: APXvYqxhYYTBqUuseJDWWUez3HqTi8OLsZ2iGsFp5mSkUmqRbkZx3k0KgGcdCy65dv073qcEdG4Bpw==
X-Received: by 2002:a19:5217:: with SMTP id m23mr24260832lfb.124.1565762957909;
        Tue, 13 Aug 2019 23:09:17 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:17 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 13/15] ASoC: sun4i-i2s: Add multichannel functionality
Date:   Wed, 14 Aug 2019 08:08:52 +0200
Message-Id: <20190814060854.26345-14-codekipper@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814060854.26345-1-codekipper@gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com>
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
 sound/soc/sunxi/sun4i-i2s.c | 93 +++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 30 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a020c3b372a8..a71969167053 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -617,41 +617,74 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	int lines;
 
 	channels = params_channels(params);
-	if (channels != 2) {
-		dev_err(dai->dev, "Unsupported number of channels: %d\n",
-			channels);
-		return -EINVAL;
-	}
-
-	lines = (channels + 1) / 2;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if ((channels > dai->driver->playback.channels_max) ||
+			(channels < dai->driver->playback.channels_min)) {
+			dev_err(dai->dev, "Unsupported number of channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
 
-	/* Enable the required output lines */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_SDO_EN_MASK,
-			   SUN4I_I2S_CTRL_SDO_EN(lines));
-
-	if (i2s->variant->has_chcfg) {
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
-				   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
-	}
+		lines = (channels + 1) / 2;
 
-	/* Map the channels for playback and capture */
-	i2s->variant->set_txchanmap(i2s, 0, 0x76543210);
-	i2s->variant->set_rxchanmap(i2s, 0x00003210);
+		/* Enable the required output lines */
+		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+				   SUN4I_I2S_CTRL_SDO_EN_MASK,
+				   SUN4I_I2S_CTRL_SDO_EN(lines));
+
+		i2s->variant->set_txchanmap(i2s, 0, 0x10);
+		i2s->variant->set_txchansel(i2s, 0, channels > 1 ? 2:1);
+
+		if (i2s->variant->set_txchanen)
+			i2s->variant->set_txchanen(i2s, 0, 2);
+
+		if (i2s->variant->has_chcfg) {
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
+
+			if (channels > 2) {
+				i2s->variant->set_txchanmap(i2s, 1, 0x32);
+				i2s->variant->set_txchanoffset(i2s, 1);
+				i2s->variant->set_txchansel(i2s, 1,
+							    channels > 3 ? 2:1);
+				i2s->variant->set_txchanen(i2s, 1, 2);
+			}
+			if (channels > 4) {
+				i2s->variant->set_txchanmap(i2s, 2, 0x54);
+				i2s->variant->set_txchanoffset(i2s, 2);
+				i2s->variant->set_txchansel(i2s, 2,
+							    channels > 5 ? 2:1);
+				i2s->variant->set_txchanen(i2s, 2, 2);
+			}
+			if (channels > 6) {
+				i2s->variant->set_txchanmap(i2s, 3, 0x76);
+				i2s->variant->set_txchanoffset(i2s, 3);
+				i2s->variant->set_txchansel(i2s, 3,
+							    channels > 6 ? 2:1);
+				i2s->variant->set_txchanen(i2s, 3, 2);
+			}
+		}
+	} else {
+		if ((channels > dai->driver->capture.channels_max) ||
+			(channels < dai->driver->capture.channels_min)) {
+			dev_err(dai->dev, "Unsupported number of channels: %d\n",
+				channels);
+			return -EINVAL;
+		}
 
-	/* Configure the channels */
-	i2s->variant->set_txchansel(i2s, 0, channels);
-	i2s->variant->set_rxchansel(i2s, channels);
+		/* Map the channels for capture */
+		i2s->variant->set_rxchanmap(i2s, 0x10);
+		i2s->variant->set_rxchansel(i2s, channels);
 
-	if (i2s->variant->set_txchanen)
-		i2s->variant->set_txchanen(i2s, 0, channels);
+		if (i2s->variant->set_rxchanen)
+			i2s->variant->set_rxchanen(i2s, channels);
 
-	if (i2s->variant->set_rxchanen)
-		i2s->variant->set_rxchanen(i2s, channels);
+		if (i2s->variant->has_chcfg)
+			regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
+					   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
+	}
 
 	switch (params_physical_width(params)) {
 	case 16:
-- 
2.22.0

