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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B70ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CB22082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7jKcqJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfJPHHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:07:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40010 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389634AbfJPHHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id f23so1009886lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfnwO8vvijCwZxuUL06QD5Tx1fxFqAFTG2kXsJEWJMY=;
        b=P7jKcqJWpHrW1gaub0fSy2vbAtI/feqgoOpswUlXO9Je+VTo59n3zc/RFhfKNPOHYo
         X5RCZt1cS1NVGjTKtTS5zTsXPdX2MFhM5jti2LrRKX0HtZjSy6X89TEvTCgHOH6dZApV
         JhSyjrS8Jv3ik/H7deMyV9fRxuNoNZdx8yPbx2I5BvIs5Y1NXhK115S8cbJvzlW7wgwr
         m7YhX1l8TsMUm9UfJOnlonv/WJ92jOmqjnwJc2+N757v9eYaQ0dXoLImO+zfrilQHiuR
         3zAm4rCjVZcgWEW0V4HPRLXhOKetlFT2zdktVefFU2P696B8kikobkWenLpt4C8fmDap
         BJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfnwO8vvijCwZxuUL06QD5Tx1fxFqAFTG2kXsJEWJMY=;
        b=ZIhPubbKh5NvxVQiBAxGeWywWnDZlP7UojpX77owKIwT657W7Umy80IhDWPXz+dy4h
         Qn8ElgLDlCMCKgUi6HEWnMXmWGr+vVuKcAVcI92oQVeJmuXnUWdgn86nFNpSF1/Qy83L
         OUiMyfVR8FV+UdiL+B39MNzCaHp/WhT4HcZSB4pOD+EAyKpxkEU1L5m+CRXn30UkV5dx
         qLbdwCbYX2KDHa7zbS5Xwq87a3Mq+I/5GGPonRnhynG4XNUFCkdepBgXo6fKtvn56ziP
         5XcwCpcuA5bRjHHPXdnKUMs6kXXRY0uGbhCrhnp6Dxw9BanBkq0qYvCNCoa+MlulYjIQ
         31/Q==
X-Gm-Message-State: APjAAAUOophYsu8C747CAtcmMHR0M6nlIVHacPHI3QnKaSremgRLhCp/
        gylSSe2Pt/p563GoghwsTzEwkKHC
X-Google-Smtp-Source: APXvYqz5kC5mHtEuZCkmB220wctQYP7NsY41HDsa9pdKX2nuuRVHlx3tF9FC50FqXmDOK4Pu2/vSxg==
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr11797775lfk.135.1571209669188;
        Wed, 16 Oct 2019 00:07:49 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se. [213.102.65.51])
        by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:07:48 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 5/7] ASoC: sun4i-i2s: Add functions for RX and TX channel mapping
Date:   Wed, 16 Oct 2019 09:07:38 +0200
Message-Id: <20191016070740.121435-6-codekipper@gmail.com>
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

As we will eventually add multi-channel audio support to the i2s
then create function calls as opposed to regmap fields to add
support for different devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 45 +++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 19988d61a085..63ae9da180f2 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -165,6 +165,8 @@ struct sun4i_i2s_quirks {
 	void	(*set_rxchanen)(const struct sun4i_i2s *, int);
 	void	(*set_txchansel)(const struct sun4i_i2s *, int, int);
 	void	(*set_rxchansel)(const struct sun4i_i2s *, int);
+	void	(*set_txchanmap)(const struct sun4i_i2s *, int, int);
+	void	(*set_rxchanmap)(const struct sun4i_i2s *, int);
 };
 
 struct sun4i_i2s {
@@ -405,8 +407,8 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	unsigned int channels = params_channels(params);
 
 	/* Map the channels for playback and capture */
-	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
-	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
+	i2s->variant->set_txchanmap(i2s, 0, 0x76543210);
+	i2s->variant->set_rxchanmap(i2s, 0x00003210);
 
 	/* Configure the channels */
 	i2s->variant->set_txchansel(i2s, 0, channels);
@@ -426,8 +428,8 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 		slots = i2s->slots;
 
 	/* Map the channels for playback and capture */
-	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
-	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
+	i2s->variant->set_txchanmap(i2s, 0, 0x76543210);
+	i2s->variant->set_rxchanmap(i2s, 0x00003210);
 
 	/* Configure the channels */
 	i2s->variant->set_txchansel(i2s, 0, channels);
@@ -534,6 +536,31 @@ static void sun8i_i2s_set_rxchansel(const struct sun4i_i2s *i2s, int channel)
 			   SUN8I_I2S_TX_CHAN_SEL(channel));
 }
 
+static void sun4i_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int output,
+				    int channel)
+{
+	if (output == 0)
+		regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, channel);
+}
+
+static void sun8i_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int output,
+				    int channel)
+{
+	if (output >= 0 && output < 4)
+		regmap_write(i2s->regmap,
+			     SUN8I_I2S_TX_CHAN_MAP_REG + (output * 4), channel);
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
@@ -1154,6 +1181,8 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
@@ -1174,6 +1203,8 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 /*
@@ -1199,6 +1230,8 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
@@ -1223,6 +1256,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.set_rxchanen		= sun8i_i2s_set_rxchanen,
 	.set_txchansel		= sun8i_i2s_set_txchansel,
 	.set_rxchansel		= sun8i_i2s_set_rxchansel,
+	.set_txchanmap		= sun8i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun8i_i2s_set_rxchanmap,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
@@ -1243,6 +1278,8 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
 	.set_txchansel		= sun4i_i2s_set_txchansel,
 	.set_rxchansel		= sun4i_i2s_set_rxchansel,
+	.set_txchanmap		= sun4i_i2s_set_txchanmap,
+	.set_rxchanmap		= sun4i_i2s_set_rxchanmap,
 };
 
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
-- 
2.23.0

