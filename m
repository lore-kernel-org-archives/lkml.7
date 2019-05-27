Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E3C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B326F208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeo2Ptya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE0TQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:16:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51943 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfE0TQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:16:13 -0400
Received: by mail-it1-f193.google.com with SMTP id m3so686695itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8/iFdWejLczB8BKk2sa3IeHBpahb+b0Wsxw58n9MfY=;
        b=jeo2Ptya1YMu0fev0kNjUIVZZTPjPc8Mmzv+cNCQ9ah3Uq9xBJeRaHIPrhV9DQPSAp
         FTuCg0l3vMtBbhx7HuRdYd11W9IHk1ZJ2ZJfge+D/Fh0IMriZIaCtG2DtDNXLf4PCj5X
         OJkhF5O8r5bN0Vo8ZC6OzEnXPFcXq2pOYo3VbYaP9HWlux41hf5qUoTBoOrOIHqbfdPU
         InL401XoxpCraBhnHHh/jqDsfiDAS+Iv82zid53S9L61m9glNTQe6vMZhU4Nj8baZV73
         1lisapIJanAsLvUDsCg7zW3ah5sik9GKq9Cd4+p3V2DbB6S9CnLcQdfeSH08VKfnMeFk
         Qx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R8/iFdWejLczB8BKk2sa3IeHBpahb+b0Wsxw58n9MfY=;
        b=tS8MLq0qn8CfTmAaxDhf976zDf9gMhb22Up9y6ObEJtpR0n6c6uVx7sMVj3Mg2NNM1
         pwNz0FqsuYM5kVUoztZCfbVio34WbEC+s1ysxXSU9JFHNz9pF9uPhCZFnG3iY77A4sO/
         Z31/HC+tAKf1IQOBdhfVAGsPLYsi9JoZBFe2XHzWu0c2d5vk+LG80+cfkx69+mO25koR
         7Q8yZcP8kLzYHtUf1lm5S+VoB4MRD5g9P21qlnqpf3SH9quNvOkENktVkvc0Mb1pjlhH
         AsPOxD86mlcIv89jgYTnjeH72T6/bBqmiKhlDqS14ZZiGW11GZsN6QcrSisxuOiqlzWB
         Grfw==
X-Gm-Message-State: APjAAAVOXqJmlukDqdeHxwSetvp7NqlvJumhjhqsKdyHh5sQT83PoKLX
        53stNE7DBeUpwQsW9kz9KjbtRD3Z
X-Google-Smtp-Source: APXvYqzs2bR57gQD3gU61Jdm9RH7M6/cgNwa7JB66L19wtp9SanMzs8VBCGygAxuxHan4uP6KSxd+Q==
X-Received: by 2002:a24:c0c1:: with SMTP id u184mr439128itf.9.1558984572688;
        Mon, 27 May 2019 12:16:12 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id h26sm176750itf.13.2019.05.27.12.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:16:12 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v1 2/2] drm/i2c: tda998x: remove indirect reg_read/_write() calls
Date:   Mon, 27 May 2019 15:15:52 -0400
Message-Id: <20190527191552.10413-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527191552.10413-1-TheSven73@gmail.com>
References: <20190527191552.10413-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove indirect reg_read/_write() calls, and replace them
with direct calls to regmap functions.

For the sake of readability, keep the following indirect
register access calls:
- reg_set()
- reg_clear()
- reg_write16()

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 333 ++++++++++++++----------------
 1 file changed, 157 insertions(+), 176 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 8153e2e19e18..1bddd2cf92ea 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -548,89 +548,59 @@ static void tda998x_cec_hook_release(void *data)
 }
 
 static int
-reg_read_range(struct tda998x_priv *priv, u16 reg, char *buf, int cnt)
-{
-	int ret;
-
-	ret = regmap_bulk_read(priv->regmap, reg, buf, cnt);
-	if (ret < 0)
-		return ret;
-	return cnt;
-}
-
-static void
-reg_write_range(struct tda998x_priv *priv, u16 reg, u8 *p, int cnt)
-{
-	regmap_bulk_write(priv->regmap, reg, p, cnt);
-}
-
-static int
-reg_read(struct tda998x_priv *priv, u16 reg)
-{
-	int ret, val;
-
-	ret = regmap_read(priv->regmap, reg, &val);
-	if (ret < 0)
-		return ret;
-	return val;
-}
-
-static void
-reg_write(struct tda998x_priv *priv, u16 reg, u8 val)
-{
-	regmap_write(priv->regmap, reg, val);
-}
-
-static void
-reg_write16(struct tda998x_priv *priv, u16 reg, u16 val)
+reg_write16(struct regmap *regmap, u16 reg, u16 val)
 {
 	u8 buf[] = {val >> 8, val};
 
-	regmap_bulk_write(priv->regmap, reg, buf, ARRAY_SIZE(buf));
+	return regmap_bulk_write(regmap, reg, buf, ARRAY_SIZE(buf));
 }
 
-static void
-reg_set(struct tda998x_priv *priv, u16 reg, u8 val)
+static int
+reg_set(struct regmap *regmap, u16 reg, u8 val)
 {
-	regmap_update_bits(priv->regmap, reg, val, val);
+	return regmap_update_bits(regmap, reg, val, val);
 }
 
-static void
-reg_clear(struct tda998x_priv *priv, u16 reg, u8 val)
+static int
+reg_clear(struct regmap *regmap, u16 reg, u8 val)
 {
-	regmap_update_bits(priv->regmap, reg, val, 0);
+	return regmap_update_bits(regmap, reg, val, 0);
 }
 
 static void
 tda998x_reset(struct tda998x_priv *priv)
 {
+	struct regmap *regmap = priv->regmap;
+
 	/* reset audio and i2c master: */
-	reg_write(priv, REG_SOFTRESET, SOFTRESET_AUDIO | SOFTRESET_I2C_MASTER);
+	regmap_write(regmap, REG_SOFTRESET,
+			SOFTRESET_AUDIO | SOFTRESET_I2C_MASTER);
 	msleep(50);
-	reg_write(priv, REG_SOFTRESET, 0);
+	regmap_write(regmap, REG_SOFTRESET, 0);
 	msleep(50);
 
 	/* reset transmitter: */
-	reg_set(priv, REG_MAIN_CNTRL0, MAIN_CNTRL0_SR);
-	reg_clear(priv, REG_MAIN_CNTRL0, MAIN_CNTRL0_SR);
+	reg_set(regmap, REG_MAIN_CNTRL0, MAIN_CNTRL0_SR);
+	reg_clear(regmap, REG_MAIN_CNTRL0, MAIN_CNTRL0_SR);
 
 	/* PLL registers common configuration */
-	reg_write(priv, REG_PLL_SERIAL_1, 0x00);
-	reg_write(priv, REG_PLL_SERIAL_2, PLL_SERIAL_2_SRL_NOSC(1));
-	reg_write(priv, REG_PLL_SERIAL_3, 0x00);
-	reg_write(priv, REG_SERIALIZER,   0x00);
-	reg_write(priv, REG_BUFFER_OUT,   0x00);
-	reg_write(priv, REG_PLL_SCG1,     0x00);
-	reg_write(priv, REG_AUDIO_DIV,    AUDIO_DIV_SERCLK_8);
-	reg_write(priv, REG_SEL_CLK,      SEL_CLK_SEL_CLK1 | SEL_CLK_ENA_SC_CLK);
-	reg_write(priv, REG_PLL_SCGN1,    0xfa);
-	reg_write(priv, REG_PLL_SCGN2,    0x00);
-	reg_write(priv, REG_PLL_SCGR1,    0x5b);
-	reg_write(priv, REG_PLL_SCGR2,    0x00);
-	reg_write(priv, REG_PLL_SCG2,     0x10);
+	regmap_write(regmap, REG_PLL_SERIAL_1, 0x00);
+	regmap_write(regmap, REG_PLL_SERIAL_2, PLL_SERIAL_2_SRL_NOSC(1));
+	regmap_write(regmap, REG_PLL_SERIAL_3, 0x00);
+	regmap_write(regmap, REG_SERIALIZER,   0x00);
+	regmap_write(regmap, REG_BUFFER_OUT,   0x00);
+	regmap_write(regmap, REG_PLL_SCG1,     0x00);
+	regmap_write(regmap, REG_AUDIO_DIV,    AUDIO_DIV_SERCLK_8);
+	regmap_write(regmap, REG_SEL_CLK,
+				SEL_CLK_SEL_CLK1 | SEL_CLK_ENA_SC_CLK);
+	regmap_write(regmap, REG_PLL_SCGN1,    0xfa);
+	regmap_write(regmap, REG_PLL_SCGN2,    0x00);
+	regmap_write(regmap, REG_PLL_SCGR1,    0x5b);
+	regmap_write(regmap, REG_PLL_SCGR2,    0x00);
+	regmap_write(regmap, REG_PLL_SCG2,     0x10);
 
 	/* Write the default value MUX register */
-	reg_write(priv, REG_MUX_VP_VIP_OUT, 0x24);
+	regmap_write(regmap, REG_MUX_VP_VIP_OUT, 0x24);
 }
 
 /*
@@ -685,16 +655,18 @@ static void tda998x_detect_work(struct work_struct *work)
 static irqreturn_t tda998x_irq_thread(int irq, void *data)
 {
 	struct tda998x_priv *priv = data;
-	u8 sta, cec, lvl, flag0, flag1, flag2;
+	struct regmap *regmap = priv->regmap;
+	u8 sta, cec, lvl;
+	unsigned int flag0, flag1, flag2;
 	bool handled = false;
 
 	sta = cec_read(priv, REG_CEC_INTSTATUS);
 	if (sta & CEC_INTSTATUS_HDMI) {
 		cec = cec_read(priv, REG_CEC_RXSHPDINT);
 		lvl = cec_read(priv, REG_CEC_RXSHPDLEV);
-		flag0 = reg_read(priv, REG_INT_FLAGS_0);
-		flag1 = reg_read(priv, REG_INT_FLAGS_1);
-		flag2 = reg_read(priv, REG_INT_FLAGS_2);
+		regmap_read(regmap, REG_INT_FLAGS_0, &flag0);
+		regmap_read(regmap, REG_INT_FLAGS_1, &flag1);
+		regmap_read(regmap, REG_INT_FLAGS_2, &flag2);
 		DRM_DEBUG_DRIVER(
 			"tda irq sta %02x cec %02x lvl %02x f0 %02x f1 %02x f2 %02x\n",
 			sta, cec, lvl, flag0, flag1, flag2);
@@ -725,6 +697,7 @@ static void
 tda998x_write_if(struct tda998x_priv *priv, u8 bit, u16 addr,
 		 union hdmi_infoframe *frame)
 {
+	struct regmap *regmap = priv->regmap;
 	u8 buf[32];
 	ssize_t len;
 
@@ -736,9 +709,9 @@ tda998x_write_if(struct tda998x_priv *priv, u8 bit, u16 addr,
 		return;
 	}
 
-	reg_clear(priv, REG_DIP_IF_FLAGS, bit);
-	reg_write_range(priv, addr, buf, len);
-	reg_set(priv, REG_DIP_IF_FLAGS, bit);
+	reg_clear(regmap, REG_DIP_IF_FLAGS, bit);
+	regmap_bulk_write(regmap, addr, buf, len);
+	reg_set(regmap, REG_DIP_IF_FLAGS, bit);
 }
 
 static int tda998x_write_aif(struct tda998x_priv *priv,
@@ -767,14 +740,14 @@ tda998x_write_avi(struct tda998x_priv *priv, const struct drm_display_mode *mode
 
 /* Audio support */
 
-static void tda998x_audio_mute(struct tda998x_priv *priv, bool on)
+static void tda998x_audio_mute(struct regmap *regmap, bool on)
 {
 	if (on) {
-		reg_set(priv, REG_SOFTRESET, SOFTRESET_AUDIO);
-		reg_clear(priv, REG_SOFTRESET, SOFTRESET_AUDIO);
-		reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
+		reg_set(regmap, REG_SOFTRESET, SOFTRESET_AUDIO);
+		reg_clear(regmap, REG_SOFTRESET, SOFTRESET_AUDIO);
+		reg_set(regmap, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
 	} else {
-		reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
+		reg_clear(regmap, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
 	}
 }
 
@@ -782,25 +755,26 @@ static int
 tda998x_configure_audio(struct tda998x_priv *priv,
 			struct tda998x_audio_params *params)
 {
+	struct regmap *regmap = priv->regmap;
 	u8 buf[6], clksel_aip, clksel_fs, cts_n, adiv;
 	u32 n;
 
 	/* Enable audio ports */
-	reg_write(priv, REG_ENA_AP, params->config);
+	regmap_write(regmap, REG_ENA_AP, params->config);
 
 	/* Set audio input source */
 	switch (params->format) {
 	case AFMT_SPDIF:
-		reg_write(priv, REG_ENA_ACLK, 0);
-		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_SPDIF);
+		regmap_write(regmap, REG_ENA_ACLK, 0);
+		regmap_write(regmap, REG_MUX_AP, MUX_AP_SELECT_SPDIF);
 		clksel_aip = AIP_CLKSEL_AIP_SPDIF;
 		clksel_fs = AIP_CLKSEL_FS_FS64SPDIF;
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
 		break;
 
 	case AFMT_I2S:
-		reg_write(priv, REG_ENA_ACLK, 1);
-		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
+		regmap_write(regmap, REG_ENA_ACLK, 1);
+		regmap_write(regmap, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP_I2S;
 		clksel_fs = AIP_CLKSEL_FS_ACLK;
 		switch (params->sample_width) {
@@ -824,10 +798,10 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		return -EINVAL;
 	}
 
-	reg_write(priv, REG_AIP_CLKSEL, clksel_aip);
-	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT |
+	regmap_write(regmap, REG_AIP_CLKSEL, clksel_aip);
+	reg_clear(regmap, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT |
 					AIP_CNTRL_0_ACR_MAN);	/* auto CTS */
-	reg_write(priv, REG_CTS_N, cts_n);
+	regmap_write(regmap, REG_CTS_N, cts_n);
 
 	/*
 	 * Audio input somehow depends on HDMI line rate which is
@@ -844,7 +818,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	if (params->format == AFMT_SPDIF)
 		adiv++;			/* AUDIO_DIV_SERCLK_16 or _32 */
 
-	reg_write(priv, REG_AUDIO_DIV, adiv);
+	regmap_write(regmap, REG_AUDIO_DIV, adiv);
 
 	/*
 	 * This is the approximate value of N, which happens to be
@@ -859,14 +833,14 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	buf[3] = n;
 	buf[4] = n >> 8;
 	buf[5] = n >> 16;
-	reg_write_range(priv, REG_ACR_CTS_0, buf, 6);
+	regmap_bulk_write(regmap, REG_ACR_CTS_0, buf, 6);
 
 	/* Set CTS clock reference */
-	reg_write(priv, REG_AIP_CLKSEL, clksel_aip | clksel_fs);
+	regmap_write(regmap, REG_AIP_CLKSEL, clksel_aip | clksel_fs);
 
 	/* Reset CTS generator */
-	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
-	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
+	reg_set(regmap, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
+	reg_clear(regmap, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
 
 	/* Write the channel status
 	 * The REG_CH_STAT_B-registers skip IEC958 AES2 byte, because
@@ -876,11 +850,11 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	buf[1] = params->status[1];
 	buf[2] = params->status[3];
 	buf[3] = params->status[4];
-	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
+	regmap_bulk_write(regmap, REG_CH_STAT_B(0), buf, 4);
 
-	tda998x_audio_mute(priv, true);
+	tda998x_audio_mute(regmap, true);
 	msleep(20);
-	tda998x_audio_mute(priv, false);
+	tda998x_audio_mute(regmap, false);
 
 	return tda998x_write_aif(priv, &params->cea);
 }
@@ -950,7 +924,7 @@ static void tda998x_audio_shutdown(struct device *dev, void *data)
 
 	mutex_lock(&priv->audio_mutex);
 
-	reg_write(priv, REG_ENA_AP, 0);
+	regmap_write(priv->regmap, REG_ENA_AP, 0);
 
 	priv->audio_params.format = AFMT_UNUSED;
 
@@ -963,7 +937,7 @@ int tda998x_audio_digital_mute(struct device *dev, void *data, bool enable)
 
 	mutex_lock(&priv->audio_mutex);
 
-	tda998x_audio_mute(priv, enable);
+	tda998x_audio_mute(priv->regmap, enable);
 
 	mutex_unlock(&priv->audio_mutex);
 	return 0;
@@ -1043,6 +1017,8 @@ static const struct drm_connector_funcs tda998x_connector_funcs = {
 static int read_edid_block(void *data, u8 *buf, unsigned int blk, size_t length)
 {
 	struct tda998x_priv *priv = data;
+	struct regmap *regmap = priv->regmap;
+	unsigned int flag2;
 	u8 offset, segptr;
 	int ret, i;
 
@@ -1051,17 +1027,17 @@ static int read_edid_block(void *data, u8 *buf, unsigned int blk, size_t length)
 
 	mutex_lock(&priv->edid_mutex);
 
-	reg_write(priv, REG_DDC_ADDR, 0xa0);
-	reg_write(priv, REG_DDC_OFFS, offset);
-	reg_write(priv, REG_DDC_SEGM_ADDR, 0x60);
-	reg_write(priv, REG_DDC_SEGM, segptr);
+	regmap_write(regmap, REG_DDC_ADDR, 0xa0);
+	regmap_write(regmap, REG_DDC_OFFS, offset);
+	regmap_write(regmap, REG_DDC_SEGM_ADDR, 0x60);
+	regmap_write(regmap, REG_DDC_SEGM, segptr);
 
 	/* enable reading EDID: */
 	priv->wq_edid_wait = 1;
-	reg_write(priv, REG_EDID_CTRL, 0x1);
+	regmap_write(regmap, REG_EDID_CTRL, 0x1);
 
 	/* flag must be cleared by sw: */
-	reg_write(priv, REG_EDID_CTRL, 0x0);
+	regmap_write(regmap, REG_EDID_CTRL, 0x0);
 
 	/* wait for block read to complete: */
 	if (priv->hdmi->irq) {
@@ -1076,10 +1052,10 @@ static int read_edid_block(void *data, u8 *buf, unsigned int blk, size_t length)
 	} else {
 		for (i = 100; i > 0; i--) {
 			msleep(1);
-			ret = reg_read(priv, REG_INT_FLAGS_2);
-			if (ret < 0)
+			ret = regmap_read(regmap, REG_INT_FLAGS_2, &flag2);
+			if (ret)
 				goto failed;
-			if (ret & INT_FLAGS_2_EDID_BLK_RD)
+			if (flag2 & INT_FLAGS_2_EDID_BLK_RD)
 				break;
 		}
 	}
@@ -1090,8 +1066,8 @@ static int read_edid_block(void *data, u8 *buf, unsigned int blk, size_t length)
 		goto failed;
 	}
 
-	ret = reg_read_range(priv, REG_EDID_DATA_0, buf, length);
-	if (ret != length) {
+	ret = regmap_bulk_read(regmap, REG_EDID_DATA_0, buf, length);
+	if (ret) {
 		dev_err(&priv->hdmi->dev, "failed to read edid block %d: %d\n",
 			blk, ret);
 		goto failed;
@@ -1107,6 +1083,7 @@ static int read_edid_block(void *data, u8 *buf, unsigned int blk, size_t length)
 static int tda998x_connector_get_modes(struct drm_connector *connector)
 {
 	struct tda998x_priv *priv = conn_to_tda998x_priv(connector);
+	struct regmap *regmap = priv->regmap;
 	struct edid *edid;
 	int n;
 
@@ -1119,12 +1096,12 @@ static int tda998x_connector_get_modes(struct drm_connector *connector)
 		return 0;
 
 	if (priv->rev == TDA19988)
-		reg_clear(priv, REG_TX4, TX4_PD_RAM);
+		reg_clear(regmap, REG_TX4, TX4_PD_RAM);
 
 	edid = drm_do_get_edid(connector, read_edid_block, priv);
 
 	if (priv->rev == TDA19988)
-		reg_set(priv, REG_TX4, TX4_PD_RAM);
+		reg_set(regmap, REG_TX4, TX4_PD_RAM);
 
 	if (!edid) {
 		dev_warn(&priv->hdmi->dev, "failed to read EDID\n");
@@ -1218,16 +1195,17 @@ static enum drm_mode_status tda998x_bridge_mode_valid(struct drm_bridge *bridge,
 static void tda998x_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+	struct regmap *regmap = priv->regmap;
 
 	if (!priv->is_on) {
 		/* enable video ports, audio will be enabled later */
-		reg_write(priv, REG_ENA_VP_0, 0xff);
-		reg_write(priv, REG_ENA_VP_1, 0xff);
-		reg_write(priv, REG_ENA_VP_2, 0xff);
+		regmap_write(regmap, REG_ENA_VP_0, 0xff);
+		regmap_write(regmap, REG_ENA_VP_1, 0xff);
+		regmap_write(regmap, REG_ENA_VP_2, 0xff);
 		/* set muxing after enabling ports: */
-		reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
-		reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
-		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
+		regmap_write(regmap, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
+		regmap_write(regmap, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
+		regmap_write(regmap, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
 
 		priv->is_on = true;
 	}
@@ -1236,12 +1214,13 @@ static void tda998x_bridge_enable(struct drm_bridge *bridge)
 static void tda998x_bridge_disable(struct drm_bridge *bridge)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+	struct regmap *regmap = priv->regmap;
 
 	if (priv->is_on) {
 		/* disable video ports */
-		reg_write(priv, REG_ENA_VP_0, 0x00);
-		reg_write(priv, REG_ENA_VP_1, 0x00);
-		reg_write(priv, REG_ENA_VP_2, 0x00);
+		regmap_write(regmap, REG_ENA_VP_0, 0x00);
+		regmap_write(regmap, REG_ENA_VP_1, 0x00);
+		regmap_write(regmap, REG_ENA_VP_2, 0x00);
 
 		priv->is_on = false;
 	}
@@ -1252,6 +1231,7 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 				    const struct drm_display_mode *adjusted_mode)
 {
 	struct tda998x_priv *priv = bridge_to_tda998x_priv(bridge);
+	struct regmap *regmap = priv->regmap;
 	unsigned long tmds_clock;
 	u16 ref_pix, ref_line, n_pix, n_line;
 	u16 hs_pix_s, hs_pix_e;
@@ -1340,43 +1320,43 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 	mutex_lock(&priv->audio_mutex);
 
 	/* mute the audio FIFO: */
-	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
+	reg_set(regmap, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
 
 	/* set HDMI HDCP mode off: */
-	reg_write(priv, REG_TBG_CNTRL_1, TBG_CNTRL_1_DWIN_DIS);
-	reg_clear(priv, REG_TX33, TX33_HDMI);
-	reg_write(priv, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(0));
+	regmap_write(regmap, REG_TBG_CNTRL_1, TBG_CNTRL_1_DWIN_DIS);
+	reg_clear(regmap, REG_TX33, TX33_HDMI);
+	regmap_write(regmap, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(0));
 
 	/* no pre-filter or interpolator: */
-	reg_write(priv, REG_HVF_CNTRL_0, HVF_CNTRL_0_PREFIL(0) |
+	regmap_write(regmap, REG_HVF_CNTRL_0, HVF_CNTRL_0_PREFIL(0) |
 			HVF_CNTRL_0_INTPOL(0));
-	reg_set(priv, REG_FEAT_POWERDOWN, FEAT_POWERDOWN_PREFILT);
-	reg_write(priv, REG_VIP_CNTRL_5, VIP_CNTRL_5_SP_CNT(0));
-	reg_write(priv, REG_VIP_CNTRL_4, VIP_CNTRL_4_BLANKIT(0) |
+	reg_set(regmap, REG_FEAT_POWERDOWN, FEAT_POWERDOWN_PREFILT);
+	regmap_write(regmap, REG_VIP_CNTRL_5, VIP_CNTRL_5_SP_CNT(0));
+	regmap_write(regmap, REG_VIP_CNTRL_4, VIP_CNTRL_4_BLANKIT(0) |
 			VIP_CNTRL_4_BLC(0));
 
-	reg_clear(priv, REG_PLL_SERIAL_1, PLL_SERIAL_1_SRL_MAN_IZ);
-	reg_clear(priv, REG_PLL_SERIAL_3, PLL_SERIAL_3_SRL_CCIR |
+	reg_clear(regmap, REG_PLL_SERIAL_1, PLL_SERIAL_1_SRL_MAN_IZ);
+	reg_clear(regmap, REG_PLL_SERIAL_3, PLL_SERIAL_3_SRL_CCIR |
 					  PLL_SERIAL_3_SRL_DE);
-	reg_write(priv, REG_SERIALIZER, 0);
-	reg_write(priv, REG_HVF_CNTRL_1, HVF_CNTRL_1_VQR(0));
+	regmap_write(regmap, REG_SERIALIZER, 0);
+	regmap_write(regmap, REG_HVF_CNTRL_1, HVF_CNTRL_1_VQR(0));
 
 	/* TODO enable pixel repeat for pixel rates less than 25Msamp/s */
 	rep = 0;
-	reg_write(priv, REG_RPT_CNTRL, 0);
-	reg_write(priv, REG_SEL_CLK, SEL_CLK_SEL_VRF_CLK(0) |
+	regmap_write(regmap, REG_RPT_CNTRL, 0);
+	regmap_write(regmap, REG_SEL_CLK, SEL_CLK_SEL_VRF_CLK(0) |
 			SEL_CLK_SEL_CLK1 | SEL_CLK_ENA_SC_CLK);
 
-	reg_write(priv, REG_PLL_SERIAL_2, PLL_SERIAL_2_SRL_NOSC(div) |
+	regmap_write(regmap, REG_PLL_SERIAL_2, PLL_SERIAL_2_SRL_NOSC(div) |
 			PLL_SERIAL_2_SRL_PR(rep));
 
 	/* set color matrix bypass flag: */
-	reg_write(priv, REG_MAT_CONTRL, MAT_CONTRL_MAT_BP |
+	regmap_write(regmap, REG_MAT_CONTRL, MAT_CONTRL_MAT_BP |
 				MAT_CONTRL_MAT_SC(1));
-	reg_set(priv, REG_FEAT_POWERDOWN, FEAT_POWERDOWN_CSC);
+	reg_set(regmap, REG_FEAT_POWERDOWN, FEAT_POWERDOWN_CSC);
 
 	/* set BIAS tmds value: */
-	reg_write(priv, REG_ANA_GENERAL, 0x09);
+	regmap_write(regmap, REG_ANA_GENERAL, 0x09);
 
 	/*
 	 * Sync on rising HSYNC/VSYNC
@@ -1391,33 +1371,33 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 		reg |= VIP_CNTRL_3_H_TGL;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		reg |= VIP_CNTRL_3_V_TGL;
-	reg_write(priv, REG_VIP_CNTRL_3, reg);
-
-	reg_write(priv, REG_VIDFORMAT, 0x00);
-	reg_write16(priv, REG_REFPIX_MSB, ref_pix);
-	reg_write16(priv, REG_REFLINE_MSB, ref_line);
-	reg_write16(priv, REG_NPIX_MSB, n_pix);
-	reg_write16(priv, REG_NLINE_MSB, n_line);
-	reg_write16(priv, REG_VS_LINE_STRT_1_MSB, vs1_line_s);
-	reg_write16(priv, REG_VS_PIX_STRT_1_MSB, vs1_pix_s);
-	reg_write16(priv, REG_VS_LINE_END_1_MSB, vs1_line_e);
-	reg_write16(priv, REG_VS_PIX_END_1_MSB, vs1_pix_e);
-	reg_write16(priv, REG_VS_LINE_STRT_2_MSB, vs2_line_s);
-	reg_write16(priv, REG_VS_PIX_STRT_2_MSB, vs2_pix_s);
-	reg_write16(priv, REG_VS_LINE_END_2_MSB, vs2_line_e);
-	reg_write16(priv, REG_VS_PIX_END_2_MSB, vs2_pix_e);
-	reg_write16(priv, REG_HS_PIX_START_MSB, hs_pix_s);
-	reg_write16(priv, REG_HS_PIX_STOP_MSB, hs_pix_e);
-	reg_write16(priv, REG_VWIN_START_1_MSB, vwin1_line_s);
-	reg_write16(priv, REG_VWIN_END_1_MSB, vwin1_line_e);
-	reg_write16(priv, REG_VWIN_START_2_MSB, vwin2_line_s);
-	reg_write16(priv, REG_VWIN_END_2_MSB, vwin2_line_e);
-	reg_write16(priv, REG_DE_START_MSB, de_pix_s);
-	reg_write16(priv, REG_DE_STOP_MSB, de_pix_e);
+	regmap_write(regmap, REG_VIP_CNTRL_3, reg);
+
+	regmap_write(regmap, REG_VIDFORMAT, 0x00);
+	reg_write16(regmap, REG_REFPIX_MSB, ref_pix);
+	reg_write16(regmap, REG_REFLINE_MSB, ref_line);
+	reg_write16(regmap, REG_NPIX_MSB, n_pix);
+	reg_write16(regmap, REG_NLINE_MSB, n_line);
+	reg_write16(regmap, REG_VS_LINE_STRT_1_MSB, vs1_line_s);
+	reg_write16(regmap, REG_VS_PIX_STRT_1_MSB, vs1_pix_s);
+	reg_write16(regmap, REG_VS_LINE_END_1_MSB, vs1_line_e);
+	reg_write16(regmap, REG_VS_PIX_END_1_MSB, vs1_pix_e);
+	reg_write16(regmap, REG_VS_LINE_STRT_2_MSB, vs2_line_s);
+	reg_write16(regmap, REG_VS_PIX_STRT_2_MSB, vs2_pix_s);
+	reg_write16(regmap, REG_VS_LINE_END_2_MSB, vs2_line_e);
+	reg_write16(regmap, REG_VS_PIX_END_2_MSB, vs2_pix_e);
+	reg_write16(regmap, REG_HS_PIX_START_MSB, hs_pix_s);
+	reg_write16(regmap, REG_HS_PIX_STOP_MSB, hs_pix_e);
+	reg_write16(regmap, REG_VWIN_START_1_MSB, vwin1_line_s);
+	reg_write16(regmap, REG_VWIN_END_1_MSB, vwin1_line_e);
+	reg_write16(regmap, REG_VWIN_START_2_MSB, vwin2_line_s);
+	reg_write16(regmap, REG_VWIN_END_2_MSB, vwin2_line_e);
+	reg_write16(regmap, REG_DE_START_MSB, de_pix_s);
+	reg_write16(regmap, REG_DE_STOP_MSB, de_pix_e);
 
 	if (priv->rev == TDA19988) {
 		/* let incoming pixels fill the active space (if any) */
-		reg_write(priv, REG_ENABLE_SPACE, 0x00);
+		regmap_write(regmap, REG_ENABLE_SPACE, 0x00);
 	}
 
 	/*
@@ -1429,10 +1409,10 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 		reg |= TBG_CNTRL_1_H_TGL;
 	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
 		reg |= TBG_CNTRL_1_V_TGL;
-	reg_write(priv, REG_TBG_CNTRL_1, reg);
+	regmap_write(regmap, REG_TBG_CNTRL_1, reg);
 
 	/* must be last register set: */
-	reg_write(priv, REG_TBG_CNTRL_0, 0);
+	regmap_write(regmap, REG_TBG_CNTRL_0, 0);
 
 	priv->tmds_clock = adjusted_mode->clock;
 
@@ -1452,9 +1432,9 @@ static void tda998x_bridge_mode_set(struct drm_bridge *bridge,
 	if (priv->supports_infoframes) {
 		/* We need to turn HDMI HDCP stuff on to get audio through */
 		reg &= ~TBG_CNTRL_1_DWIN_DIS;
-		reg_write(priv, REG_TBG_CNTRL_1, reg);
-		reg_write(priv, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(1));
-		reg_set(priv, REG_TX33, TX33_HDMI);
+		regmap_write(regmap, REG_TBG_CNTRL_1, reg);
+		regmap_write(regmap, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(1));
+		reg_set(regmap, REG_TX33, TX33_HDMI);
 
 		tda998x_write_avi(priv, adjusted_mode);
 
@@ -1546,7 +1526,7 @@ static void tda998x_destroy(struct device *dev)
 
 	/* disable all IRQs and free the IRQ handler */
 	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
-	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
+	reg_clear(priv->regmap, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
 	if (priv->audio_pdev)
 		platform_device_unregister(priv->audio_pdev);
@@ -1773,9 +1753,10 @@ static int tda998x_create(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct device_node *np = client->dev.of_node;
 	struct i2c_board_info cec_info;
+	unsigned int rev_lo, rev_hi, dummy;
 	struct tda998x_priv *priv;
 	u32 video;
-	int rev_lo, rev_hi, ret;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -1811,16 +1792,16 @@ static int tda998x_create(struct device *dev)
 	tda998x_reset(priv);
 
 	/* read version: */
-	rev_lo = reg_read(priv, REG_VERSION_LSB);
-	if (rev_lo < 0) {
-		dev_err(dev, "failed to read version: %d\n", rev_lo);
-		return rev_lo;
+	ret = regmap_read(priv->regmap, REG_VERSION_LSB, &rev_lo);
+	if (ret) {
+		dev_err(dev, "failed to read version: %d\n", ret);
+		return ret;
 	}
 
-	rev_hi = reg_read(priv, REG_VERSION_MSB);
-	if (rev_hi < 0) {
-		dev_err(dev, "failed to read version: %d\n", rev_hi);
-		return rev_hi;
+	ret = regmap_read(priv->regmap, REG_VERSION_MSB, &rev_hi);
+	if (ret) {
+		dev_err(dev, "failed to read version: %d\n", ret);
+		return ret;
 	}
 
 	priv->rev = rev_lo | rev_hi << 8;
@@ -1847,14 +1828,14 @@ static int tda998x_create(struct device *dev)
 	}
 
 	/* after reset, enable DDC: */
-	reg_write(priv, REG_DDC_DISABLE, 0x00);
+	regmap_write(priv->regmap, REG_DDC_DISABLE, 0x00);
 
 	/* set clock on DDC channel: */
-	reg_write(priv, REG_TX3, 39);
+	regmap_write(priv->regmap, REG_TX3, 39);
 
 	/* if necessary, disable multi-master: */
 	if (priv->rev == TDA19989)
-		reg_set(priv, REG_I2C_MASTER, I2C_MASTER_DIS_MM);
+		reg_set(priv->regmap, REG_I2C_MASTER, I2C_MASTER_DIS_MM);
 
 	cec_write(priv, REG_CEC_FRO_IM_CLK_CTRL,
 			CEC_FRO_IM_CLK_CTRL_GHOST_DIS | CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
@@ -1864,9 +1845,9 @@ static int tda998x_create(struct device *dev)
 
 	/* clear pending interrupts */
 	cec_read(priv, REG_CEC_RXSHPDINT);
-	reg_read(priv, REG_INT_FLAGS_0);
-	reg_read(priv, REG_INT_FLAGS_1);
-	reg_read(priv, REG_INT_FLAGS_2);
+	regmap_read(priv->regmap, REG_INT_FLAGS_0, &dummy);
+	regmap_read(priv->regmap, REG_INT_FLAGS_1, &dummy);
+	regmap_read(priv->regmap, REG_INT_FLAGS_2, &dummy);
 
 	/* initialize the optional IRQ */
 	if (client->irq) {
@@ -1928,7 +1909,7 @@ static int tda998x_create(struct device *dev)
 	}
 
 	/* enable EDID read irq: */
-	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
+	reg_set(priv->regmap, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
 	if (np) {
 		/* get the device tree parameters */
-- 
2.17.1

