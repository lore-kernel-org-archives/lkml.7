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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1C9C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CC22184E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToCBLSOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfHNGJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44344 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfHNGJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id v16so6751634lfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crtvsiVA889p+9+3ULhoKy8AnLlwvnwK5t1CxkiSENY=;
        b=ToCBLSOQP2Tbb2mZuGiLkwo+MFgVCzv4LqkeCVtoMHRBqlYviYg8VDKNYIb6b9KUmy
         SPwsetaPu/vMo39Zaqb4bAqKnyerRsTWs4Rs+t3W+hBFDnk+BR2QB8f2TQb5k7rQJdae
         Eigdi4Muqdr0OtuVbkZ8U8FOK/T4IXYchK2Pphx9sEdTg8GAu2itr95knGa3AJyKlndr
         BTko6AbNwRk1MRLFbcHcS2imbqq0DHHZFfCPyZdYCs4NBzx1fzxrIePn6t5EvAPWFUqM
         VHZe0nWGvHIHFe7Ezbe0FMJN4ssl+IFsrgCiA5WGl5UzRocNaxpBqV+EbaQR7rO07wSS
         rA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crtvsiVA889p+9+3ULhoKy8AnLlwvnwK5t1CxkiSENY=;
        b=BNFfYLV2t+ZZY2oScEX5vmArv5A4aVgQXQ9/PaLputnvKIfDzFE2x00WbocKGDhJ1Y
         8KBIJRXO+Wi/zaWx34qoHipOpQPIQvMheeUshKhGCGnwXsL3Y+davG+j4oBAYmXla7IE
         yRM7O7mlL0/OSifFdian9wYG4/+6xXP+uxCh9J6Fjmhxioi7GjmSZ9uaGa9NTd1bikan
         9QZvYUedAKtF3UyxYnya9O/b7fZiA8T7C59+xBXjRvuaORBqV6el0pxIu1KrsWD23j8O
         +JKq79TzuNZFEr8wbwwt7Oled3oL0akU1H12fWBu9c9u+ses0AtdW7eFD97XZQo1BNgV
         CXDQ==
X-Gm-Message-State: APjAAAUtGv65PHzhIBh0zPX8UgKiBZwvLipVNuuVIwRKpAhlVpv3ZueX
        jqmoUDMq35f8BibBvhw9ygk=
X-Google-Smtp-Source: APXvYqy7K8VGrd491BlThMGswYWIy2Y8noAZYydwdGc5tIBLIzfEYE9aozurWHnS6MzmQSbKiUlM5w==
X-Received: by 2002:a19:6753:: with SMTP id e19mr24673629lfj.187.1565762951298;
        Tue, 13 Aug 2019 23:09:11 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:10 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 08/15] ASoC: sun4i-i2s: Add functions for channel mapping
Date:   Wed, 14 Aug 2019 08:08:47 +0200
Message-Id: <20190814060854.26345-9-codekipper@gmail.com>
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

As we will eventually add multi-channel audio support to the i2s
then create function calls as opposed to regmap fields to add
support for different devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 71 +++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 0b98adde0717..6de3cb41aaf6 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -141,8 +141,6 @@ struct sun4i_i2s;
  * @field_fmt_lrclk: regmap field to set frame polarity.
  * @field_fmt_mode: regmap field to set the operational mode.
  * @field_fmt_sext: regmap field to set the sign extension.
- * @field_txchanmap: location of the tx channel mapping register.
- * @field_rxchanmap: location of the rx channel mapping register.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
@@ -162,8 +160,6 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_lrclk;
 	struct reg_field		field_fmt_mode;
 	struct reg_field		field_fmt_sext;
-	struct reg_field		field_txchanmap;
-	struct reg_field		field_rxchanmap;
 
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
@@ -174,6 +170,8 @@ struct sun4i_i2s_quirks {
 	void	(*set_rxchanen)(const struct sun4i_i2s *, int);
 	void	(*set_txchansel)(const struct sun4i_i2s *, int, int);
 	void	(*set_rxchansel)(const struct sun4i_i2s *, int);
+	void	(*set_txchanmap)(const struct sun4i_i2s *, int, int);
+	void	(*set_rxchanmap)(const struct sun4i_i2s *, int);
 };
 
 struct sun4i_i2s {
@@ -195,8 +193,6 @@ struct sun4i_i2s {
 	struct regmap_field	*field_fmt_lrclk;
 	struct regmap_field	*field_fmt_mode;
 	struct regmap_field	*field_fmt_sext;
-	struct regmap_field	*field_txchanmap;
-	struct regmap_field	*field_rxchanmap;
 
 	const struct sun4i_i2s_quirks	*variant;
 
@@ -499,6 +495,31 @@ static void sun8i_i2s_set_rxchansel(const struct sun4i_i2s *i2s, int channel)
 				   SUN8I_I2S_TX_CHAN_SEL(channel));
 }
 
+static void sun4i_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int output,
+				    int channel)
+{
+	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, channel);
+}
+
+static void sun8i_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int output,
+				    int channel)
+{
+	if (output >= 0 && output < 4) {
+		regmap_write(i2s->regmap,
+			     SUN8I_I2S_TX_CHAN_MAP_REG + (output * 4), channel);
+	}
+}
+
+static void sun4i_i2s_set_rxchanmap(const struct sun4i_i2s *i2s, int channel)
+{
+	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, channel);
+}
+
+static void sun8i_i2s_set_rxchanmap(const struct sun4i_i2s *i2s, int channel)
+{
+	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, channel);
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -524,8 +545,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Map the channels for playback and capture */
-	regmap_field_write(i2s->field_txchanmap, 0x76543210);
-	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
+	i2s->variant->set_txchanmap(i2s, 0, 0x76543210);
+	i2s->variant->set_rxchanmap(i2s, 0x00003210);
 
 	/* Configure the channels */
 	i2s->variant->set_txchansel(i2s, 0, channels);
@@ -1077,13 +1098,13 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
 	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_format		= sun4i_i2s_set_format,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
@@ -1098,13 +1119,13 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
 	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_format		= sun4i_i2s_set_format,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
@@ -1118,13 +1139,13 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_format		= sun4i_i2s_set_format,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
@@ -1142,8 +1163,6 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
 	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
-	.field_txchanmap	= REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_format		= sun8i_i2s_set_format,
@@ -1153,6 +1172,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.set_rxchanen		= sun8i_i2s_set_rxchanen,
 	.set_txchansel		= sun8i_i2s_set_txchansel,
 	.set_rxchansel		= sun8i_i2s_set_rxchansel,
+	.set_txchanmap		= sun8i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun8i_i2s_set_rxchanmap,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
@@ -1167,13 +1188,13 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
 	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
-	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
-	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_format		= sun4i_i2s_set_format,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
@@ -1218,19 +1239,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	i2s->field_fmt_sext =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_fmt_sext);
-	if (IS_ERR(i2s->field_fmt_sext))
-		return PTR_ERR(i2s->field_fmt_sext);
-
-	i2s->field_txchanmap =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_txchanmap);
-	if (IS_ERR(i2s->field_txchanmap))
-		return PTR_ERR(i2s->field_txchanmap);
-
-	i2s->field_rxchanmap =
-			devm_regmap_field_alloc(dev, i2s->regmap,
-						i2s->variant->field_rxchanmap);
-	return PTR_ERR_OR_ZERO(i2s->field_rxchanmap);
+	return PTR_ERR_OR_ZERO(i2s->field_fmt_sext);
 }
 
 static int sun4i_i2s_probe(struct platform_device *pdev)
-- 
2.22.0

