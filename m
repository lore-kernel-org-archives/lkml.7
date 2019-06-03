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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA1C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BB625DE8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMsbuH2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfFCRr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:47:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39064 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfFCRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id p24so7821211lfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EP52HnBImDdJf7rjJmYz8TmWwXw2UkH57yWmp4TnU6I=;
        b=kMsbuH2VtRAEevl5PD0Za9pWTeLXxKuZwm2mHSVRGrcCaYkRfyGB+0tHVh91anOQGN
         FYwkWYWsIihC4795iLplxVDLLXtfzAQ6DOM6E8El2aNrydKRwy28SquK0vH9sLvpLjLT
         jwKnojjBWsjbAAreyuIrVTIqzOIti97HpgvGfm04mDGeewtxm3Jd87mQH51hLybGLdh5
         OyEWvy3aM9qAYIN35EpfsQdb7h2epMb5+ofP4GkLqrLXmgojB/PlCVHrVlMOg4QKL/WL
         5FiymJDpz+YNejmqj5tsoisorq9ICjxaGuHdF/wPI0Jzlo2gCt4XuJGo0tciwbKdEkoM
         NHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EP52HnBImDdJf7rjJmYz8TmWwXw2UkH57yWmp4TnU6I=;
        b=YGUw3nlXOe3NKTOhT9LZ5thAftNi8Ge/8o+mfBZddFtAC22r1psrAguOMskZaed4RK
         nGh9+zJoG9X+NbR7DAXXTOjAC4Cug2WFP+6w36zS+4wSgqq4zsgvYtRRBbU3q7GGgQq9
         pNkEvlz4oF0LtaZYSa4Rx3QzhjDSGr5H0obOAeYjOBflkYEMIbOyXCJ1CYB64dHBzjV+
         SZVDMaQdGeYYxggeOsKDV3nxePkds1JJEQj2pjZU/5ya5k5czLzz6Hxjs5gbmqTpTJ6r
         D9vO8ud+Zf5uwgQiw2wFR83kYxwsXmE3tEQ0O3R85s8BNk+LArLv3uvuwY7P9IETydXi
         rNew==
X-Gm-Message-State: APjAAAWHhBWbGdyoDmDMxysQjDf34R72KVQFynW8767n+O1UR/gtnEbg
        lcznr3HDalq80rEdFdd5zCXcQkbO
X-Google-Smtp-Source: APXvYqzDuyyZ8jJoRuUrujErMlbCM25unS3jF7phVTl+Z3OyXyZoUzPLavy5f6g40fgZMjB6nWJWbA==
X-Received: by 2002:ac2:47fa:: with SMTP id b26mr1178893lfp.82.1559584066627;
        Mon, 03 Jun 2019 10:47:46 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:46 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 9/9] ASoC: sun4i-i2s: Adjust regmap settings
Date:   Mon,  3 Jun 2019 19:47:35 +0200
Message-Id: <20190603174735.21002-10-codekipper@gmail.com>
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

Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
to reflect this.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 351b8021173b..92828a84902d 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -595,9 +595,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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
@@ -616,9 +618,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
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
@@ -771,13 +775,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
 
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
@@ -796,6 +794,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_TX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
 	case SUN4I_I2S_INT_STA_REG:
 	case SUN4I_I2S_RX_CNT_REG:
 	case SUN4I_I2S_TX_CNT_REG:
@@ -806,23 +806,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
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
@@ -877,7 +866,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
 	.reg_defaults	= sun8i_i2s_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(sun8i_i2s_reg_defaults),
 	.writeable_reg	= sun4i_i2s_wr_reg,
-	.readable_reg	= sun8i_i2s_rd_reg,
+	.readable_reg	= sun4i_i2s_rd_reg,
 	.volatile_reg	= sun8i_i2s_volatile_reg,
 };
 
-- 
2.21.0

