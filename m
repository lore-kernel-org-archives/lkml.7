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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCABC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17292084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBv26dnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfHNGJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34420 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfHNGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id b29so71217742lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zp/v+XPoakv64rsBqvBGuIEtgA5Sr07uhpM4FUxkm0E=;
        b=NBv26dndxs9cji1ckOrrLw9r4eCTy627IatAHmthw0P10JNQy/fo4/Qsr0CZq3R2GA
         JFDIxO/FLHkLuJ6c2nN3ynNHGqDKRnqqvY4VxQ/9AsshGyZuSHFffen9s5Q2RhA6TdDS
         GA3unKrtvCGGq5WgGiOOL6HvpqoNQAgZeCn5LKm54cTu9eU1qYQjeyydNOstczE34Wa8
         PgiKR2PRzQEARvIWQscCMtOdWiGC1Gg20eVvKr/9zxR4dksm3Q53vZT0DsT2HVL230X/
         fnOmLKVDVsjfYJ2/mj9hCxNZ10gmcRDp+iHH7eFHXl1RZIsBM4DX8GMQcg3WsrFf1bf7
         soHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zp/v+XPoakv64rsBqvBGuIEtgA5Sr07uhpM4FUxkm0E=;
        b=EWOGXn8a1R2GFRFa6bVnr6jkWvWbW3vwxR8DmuufwjdEL4HHhARFsSJhWHsecKu3AE
         gZNphhJvDhopvqDLX+KFxi2b6HLUqA6i1f9ODgjYgYpgnXKEit4Zg1k23p4QHcrWYAE0
         3Xd9zxwp+vAzgkvfHBsOFgAP/KIo++wALDi89yNNyN00rWBr0j6eS30kBxxSsODtP39/
         fyydP+jSRlkMPMkjPj4AiMfqDxYtVG8oBTCWHUnLNFM7cvvUIvcxpgly3/wXGkX83wc+
         IcOsXRrvgATZOwCx6dc6WsLESiT5BR+WLHQ2RxRwGoR9tqHERPgaWbyxICehmNqVoK6v
         MmFQ==
X-Gm-Message-State: APjAAAU2bE+lhl3Tfc8DdcxKpFUaSpQmu60nI99pD8tbu4FvW2Ow+zYf
        yVdJgRDPGaJZSQvmePMVOmY=
X-Google-Smtp-Source: APXvYqyefwP7/5DXwzqu3ScUtSJPu1sJZjbH/PhzSRoaWYRjfKhYTb3xwmY8hWHgFLZ9JmPJ59vJGw==
X-Received: by 2002:ac2:5094:: with SMTP id f20mr23616419lfm.53.1565762945896;
        Tue, 13 Aug 2019 23:09:05 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:05 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 04/15] ASoC: sun4i-i2s: Support more formats on newer SoCs
Date:   Wed, 14 Aug 2019 08:08:43 +0200
Message-Id: <20190814060854.26345-5-codekipper@gmail.com>
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

There is a need to support more formats on the newer SoCs(H3 and later).
Extend the formats supported to include DSP_A and DSP_B modes.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 87 +++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 34f31439ae7b..3553c17318b0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -27,6 +27,8 @@
 #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
 #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
 #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
+#define SUN4I_I2S_CTRL_PCM			BIT(4)
+#define SUN4I_I2S_CTRL_LOOP			BIT(3)
 #define SUN4I_I2S_CTRL_TX_EN			BIT(2)
 #define SUN4I_I2S_CTRL_RX_EN			BIT(1)
 #define SUN4I_I2S_CTRL_GL_EN			BIT(0)
@@ -91,6 +93,9 @@
 /* Defines required for sun8i-h3 support */
 #define SUN8I_I2S_CTRL_BCLK_OUT			BIT(18)
 #define SUN8I_I2S_CTRL_LRCK_OUT			BIT(17)
+#define SUN8I_I2S_CTRL_MODE_RIGHT_J			(2 << 0)
+#define SUN8I_I2S_CTRL_MODE_I2S_LEFT_J			(1 << 0)
+#define SUN8I_I2S_CTRL_MODE_PCM				(0 << 0)
 
 #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK		GENMASK(17, 8)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
@@ -164,6 +169,7 @@ struct sun4i_i2s_quirks {
 
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
+	int	(*set_format)(struct sun4i_i2s *, unsigned int);
 };
 
 struct sun4i_i2s {
@@ -194,6 +200,7 @@ struct sun4i_i2s {
 
 	unsigned int	tdm_slots;
 	unsigned int	slot_width;
+	unsigned int	offset;
 };
 
 struct sun4i_i2s_clk_div {
@@ -484,19 +491,14 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 				      i2s->slot_width : params_width(params));
 }
 
-static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+static int sun4i_i2s_set_format(struct sun4i_i2s *i2s, unsigned int fmt)
 {
-	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	u32 val;
-	u32 offset = 0;
-	u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
-	u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
 
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		val = SUN4I_I2S_FMT0_FMT_I2S;
-		offset = 1;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		val = SUN4I_I2S_FMT0_FMT_LEFT_J;
@@ -505,32 +507,64 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		val = SUN4I_I2S_FMT0_FMT_RIGHT_J;
 		break;
 	default:
-		dev_err(dai->dev, "Unsupported format: %d\n",
-			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
 		return -EINVAL;
 	}
 
-	if (i2s->variant->has_chsel_offset) {
-		/*
-		 * offset being set indicates that we're connected to an i2s
-		 * device, however offset is only used on the sun8i block and
-		 * i2s shares the same setting with the LJ format. Increment
-		 * val so that the bit to value to write is correct.
-		 */
-		if (offset > 0)
-			val++;
-		/* blck offset determines whether i2s or LJ */
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+	regmap_field_write(i2s->field_fmt_mode, val);
+
+	return 0;
+}
+
+static int sun8i_i2s_set_format(struct sun4i_i2s *i2s, unsigned int fmt)
+{
+	u32 val;
 
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-				   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+	/* DAI Mode */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		i2s->offset = 1;
+	case SND_SOC_DAIFMT_LEFT_J:
+		val = SUN8I_I2S_CTRL_MODE_I2S_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		val = SUN8I_I2S_CTRL_MODE_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		i2s->offset = 1;
+	case SND_SOC_DAIFMT_DSP_B:
+		val = SUN8I_I2S_CTRL_MODE_PCM;
+		break;
+
+	default:
+		return -EINVAL;
 	}
 
+	/*
+	 * bclk offset determines whether i2s or LJ if in i2s mode and
+	 * DSP_A or DSP_B if in PCM mode.
+	 */
+	i2s->variant->set_txchanoffset(i2s, 0);
+	i2s->variant->set_rxchanoffset(i2s);
+
 	regmap_field_write(i2s->field_fmt_mode, val);
 
+	return 0;
+}
+
+static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	u32 val;
+	u32 bclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
+	u32 lrclk_polarity = SUN4I_I2S_FMT0_POLARITY_NORMAL;
+
+	/* Set DAI Mode */
+	if (i2s->variant->set_format(i2s, fmt) != 0) {
+		dev_err(dai->dev, "Unsupported format: %d\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
 	/* DAI clock polarity */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_IF:
@@ -976,6 +1010,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
+	.set_format		= sun4i_i2s_set_format,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
@@ -996,6 +1031,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
+	.set_format		= sun4i_i2s_set_format,
 };
 
 static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
@@ -1015,6 +1051,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
+	.set_format		= sun4i_i2s_set_format,
 };
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
@@ -1038,6 +1075,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN8I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
+	.set_format		= sun8i_i2s_set_format,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
@@ -1058,6 +1096,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_rxchansel	= REG_FIELD(SUN4I_I2S_RX_CHAN_SEL_REG, 0, 2),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
+	.set_format		= sun4i_i2s_set_format,
 };
 
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
-- 
2.22.0

