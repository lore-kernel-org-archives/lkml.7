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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE2AC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8642084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qk+jM+K0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfHNGJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39814 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfHNGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so24697530lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPLudcRzbh9pt0l2M8FXktJHz701GH+KgTT8RYkVGIs=;
        b=qk+jM+K0vI/LKsh5ysFVuy2eVbnhZh8xo0AFbgGyCvu5Xc/NA4Hpl40Uwcfrp4Ohp2
         TxV8F3KzKhzeX25+H/nbGQk6DE0+v2VzuX20o/1bgVpSNxxsCpbxO3K12YDMOfy85xDa
         duhNak/9LjNvbT/2PBW01pJMACr4/YNmEX9eOTRV9oRiNU5uZYE2d3O4X7TxnDZfaZgf
         UeIH8aprHzhS9vmLr09ukcg2Ywj5qoUkQ9ej7/UKqkHmem4CM85wzd7XgBIQT3OE3DFH
         GiE37u6sRwPldWf9CA41lNlZao+Pryj3hMOjpm+EXdsZlMGJULIo8i6K9lLPwzoIU5A0
         ebVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPLudcRzbh9pt0l2M8FXktJHz701GH+KgTT8RYkVGIs=;
        b=L6ia/7kY9VWAnYcRq3yChVaLVyOUHaucvivnK4FiILbRx2sKaq9CH/Q0KCIITh/o1I
         mEmr5xwjujncFKmQqQS2Bz4WvUaMF3GnZ3FGP26mtOFTBJ76PcOB81NTMnEBYB4GQIoM
         QA7saY+NO2+Yukx1edjfz8r/MM7XH52RQy2m2Y7fQsQ6z3zxDlti1cVaMx+MziCWtsg1
         p6OHf9tf/rndNILMqoxikcB+s1z7Ps3xlB3fhsopXHtrLwBfkP0rzEIEgCW5MMEQqEUK
         d1nmwEfymAkWNRZZzuGkNusgyO/kcSejzzHBGBWu1pcnWnKKCeiWCXvF/XVBbsr2vaFg
         2eZA==
X-Gm-Message-State: APjAAAU0Koah1i/Sawf2taElwrejrKzvI2vCEZjIzqIr602qYeHVGzs9
        hv0qQBuh8w/v3RPpN6t2UFY=
X-Google-Smtp-Source: APXvYqzJ0E9KwCK29s7CtES+3tatrdemY5NfMpbpcc5gvJ1CGx2srYIvgpPLkkGZa3nJq1u4h/lLPA==
X-Received: by 2002:a05:6512:4c8:: with SMTP id w8mr15647941lfq.98.1565762960478;
        Tue, 13 Aug 2019 23:09:20 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:19 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Wed, 14 Aug 2019 08:08:54 +0200
Message-Id: <20190814060854.26345-16-codekipper@gmail.com>
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

Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
to reflect this.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d3c8789f70bb..ecfc1ed79379 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -876,9 +876,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
 {
 	/* Flush RX FIFO */
+	regcache_cache_bypass(i2s->regmap, true);
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
+	regcache_cache_bypass(i2s->regmap, false);
 
 	/* Clear RX counter */
 	regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
@@ -897,9 +899,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
 static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
 {
 	/* Flush TX FIFO */
+	regcache_cache_bypass(i2s->regmap, true);
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
 			   SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
+	regcache_cache_bypass(i2s->regmap, false);
 
 	/* Clear TX counter */
 	regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
@@ -1053,13 +1057,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
 
 static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case SUN4I_I2S_FIFO_TX_REG:
-		return false;
-
-	default:
-		return true;
-	}
+	return true;
 }
 
 static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
@@ -1078,6 +1076,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_TX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
 	case SUN4I_I2S_INT_STA_REG:
 	case SUN4I_I2S_RX_CNT_REG:
 	case SUN4I_I2S_TX_CNT_REG:
@@ -1088,23 +1088,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case SUN8I_I2S_FIFO_TX_REG:
-		return false;
-
-	default:
-		return true;
-	}
-}
-
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	if (reg == SUN8I_I2S_INT_STA_REG)
 		return true;
 	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
+		return true;
 
 	return sun4i_i2s_volatile_reg(dev, reg);
 }
@@ -1175,7 +1164,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
 	.reg_defaults	= sun8i_i2s_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(sun8i_i2s_reg_defaults),
 	.writeable_reg	= sun4i_i2s_wr_reg,
-	.readable_reg	= sun8i_i2s_rd_reg,
+	.readable_reg	= sun4i_i2s_rd_reg,
 	.volatile_reg	= sun8i_i2s_volatile_reg,
 };
 
@@ -1188,7 +1177,7 @@ static const struct regmap_config sun50i_i2s_regmap_config = {
 	.reg_defaults	= sun50i_i2s_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(sun50i_i2s_reg_defaults),
 	.writeable_reg	= sun4i_i2s_wr_reg,
-	.readable_reg	= sun8i_i2s_rd_reg,
+	.readable_reg	= sun4i_i2s_rd_reg,
 	.volatile_reg	= sun8i_i2s_volatile_reg,
 };
 
-- 
2.22.0

