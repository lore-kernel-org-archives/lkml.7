Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D126ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0725C2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuNdLmYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390221AbfJPHIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:08:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33972 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389615AbfJPHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so22839209lja.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHYtIhe59LgkE0iURxc0+3vHk4byPJGL3D4yPD8SiX4=;
        b=TuNdLmYaPeWTQwLP1dnD3cA7caOQ67xFZrQFsZOLSt6chsyvzGxpyctNGBFc3HHnPt
         FUlUM20/hHnzwyJw1bMzCmRrrK8Sjv5iQIIlyPwssziKMiasOEltnGhPOkpZlMgDhjFa
         XunsJX+zwo9+tJKqQE9mTQ+EqoJzlZkoXY+JX+5zGhdExn4lDX7WykCX1S2baxF2F75u
         gxXf1d1e1ZbeYH1kShWAxlUgGx2Dk+RlQQIbhogCr6KuA3rUMcpTfbmHLQAt4Q2xoXKG
         vNSL9X1pRU4/tWNL1mc0hgXSGvVlAPXk0zYYju5gQTVrDWc1Ks6ehfw+TRqI+hN4S0iW
         p4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHYtIhe59LgkE0iURxc0+3vHk4byPJGL3D4yPD8SiX4=;
        b=LhBoHaSMTpJ6Q6pAPO7vOxGNzQbCmqBKETznhqBM0lWsNNnNjcQtIhJzisRF16LRw4
         riqvKnh/298LTS1uoxTeTmlmabtibeV0ARQPY6DvIRU9clAHdij1FQOp+/uBbrjz5scH
         jLTeavSIRjKC8Oqu6Hs0WNVYqKdlzDvBwFvNuVTJXl7/6bkcF36wbyLibNkYHWCT2dVr
         Wv1iKaEw6Wfcu5SlQ8Or483oP1Lx0RCbkV/U9JEpm+3QaN/nTUYyDZmjmFmn6pMqeHQo
         ncV+T7klcoeTAP8iVUV8n1H49Rtxk4xe/t9SZutei5SzhUSOtCIj8oevwah4Z7RmLHxI
         bl7w==
X-Gm-Message-State: APjAAAWzlf4qN2/Vl52TME3jVurauk/6vnEpQBrtmYqkfD5Q6xcF694U
        u/Ndgnac5aQbZ1qdFnjKFp8=
X-Google-Smtp-Source: APXvYqwfZtptI3V5Zo3A4sicYjMnE/4Cg4n106UWQ8VH2oVQUkqbEnH1ctIdHJb69OGR6hPK07D5yA==
X-Received: by 2002:a2e:8417:: with SMTP id z23mr24777343ljg.46.1571209666572;
        Wed, 16 Oct 2019 00:07:46 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se. [213.102.65.51])
        by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:07:45 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 3/7] ASoC: sun4i-i2s: Add functions for RX and TX channel enables
Date:   Wed, 16 Oct 2019 09:07:36 +0200
Message-Id: <20191016070740.121435-4-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016070740.121435-1-codekipper@gmail.com>
References: <20191016070740.121435-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Newer SoCs like the H6 have the channel enable bits in a different
position to what is on the H3. As we will eventually add multi-
channel support then create function calls as opposed to regmap
fields to add support for different devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 875567881f30..8d28a386872f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -159,6 +159,8 @@ struct sun4i_i2s_quirks {
 	int	(*set_fmt)(struct sun4i_i2s *, unsigned int);
 	void	(*set_txchanoffset)(const struct sun4i_i2s *, int);
 	void	(*set_rxchanoffset)(const struct sun4i_i2s *);
+	void	(*set_txchanen)(const struct sun4i_i2s *, int, int);
+	void	(*set_rxchanen)(const struct sun4i_i2s *, int);
 };
 
 struct sun4i_i2s {
@@ -462,9 +464,7 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
 
-	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-			   SUN8I_I2S_TX_CHAN_EN_MASK,
-			   SUN8I_I2S_TX_CHAN_EN(channels));
+	i2s->variant->set_txchanen(i2s, 0, channels);
 
 	return 0;
 }
@@ -486,6 +486,24 @@ static void sun8i_i2s_set_rxchanoffset(const struct sun4i_i2s *i2s)
 			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
 }
 
+static void sun8i_i2s_set_txchanen(const struct sun4i_i2s *i2s, int output,
+				   int channel)
+{
+	if (output >= 0 && output < 4)
+		regmap_update_bits(i2s->regmap,
+				   SUN8I_I2S_TX_CHAN_SEL_REG + (output * 4),
+				   SUN8I_I2S_TX_CHAN_EN_MASK,
+				   SUN8I_I2S_TX_CHAN_EN(channel));
+}
+
+static void sun8i_i2s_set_rxchanen(const struct sun4i_i2s *i2s, int channel)
+{
+	regmap_update_bits(i2s->regmap,
+			   SUN8I_I2S_RX_CHAN_SEL_REG,
+			   SUN8I_I2S_TX_CHAN_EN_MASK,
+			   SUN8I_I2S_TX_CHAN_EN(channel));
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -510,6 +528,12 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (i2s->variant->set_txchanen)
+		i2s->variant->set_txchanen(i2s, 0, channels);
+
+	if (i2s->variant->set_rxchanen)
+		i2s->variant->set_rxchanen(i2s, channels);
+
 	switch (params_physical_width(params)) {
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -1155,6 +1179,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.set_fmt		= sun8i_i2s_set_soc_fmt,
 	.set_txchanoffset	= sun8i_i2s_set_txchanoffset,
 	.set_rxchanoffset	= sun8i_i2s_set_rxchanoffset,
+	.set_txchanen		= sun8i_i2s_set_txchanen,
+	.set_rxchanen		= sun8i_i2s_set_rxchanen,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
-- 
2.23.0

