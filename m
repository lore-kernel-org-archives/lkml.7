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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E29ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C31621835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNEosleP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389612AbfJPHHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:07:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43370 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbfJPHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so22776327ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDtdILcfLHoVejEtGgLfvnr1m900cxUvF44JNpWqBWQ=;
        b=XNEoslePrQiCPCXuOnDyy5PnKlhPhOjFeGvb9qfXg63GuYrL1wakT6kL3MgLI7npCd
         SICpSGkSVRWkjYZ64LBiiMnOtjDXe+5RnsP2Ko1deb/JUik1ialZMRvRvWzFV0ytNCNn
         C1mnQPSR+Zk1niRVJzjo5QCTHUIT+/KwUfAE41lqF0eF/L5vL99jfL/VXmKXS2fSeDEQ
         KjNG0lEiyju1a5qnai9EJJ0oHfwp54AG86k8qK3xtFDreiTsBoGoaZcZxMUeaHW6yPD9
         ynztCpZHXYXllLnfhQsUjlgGCuKzFq9CZmqkAderDUGu4nxmuDpPgqMlD1JuUDMYk1sk
         KJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDtdILcfLHoVejEtGgLfvnr1m900cxUvF44JNpWqBWQ=;
        b=noBVJQqETP6daCx0Qn9rrOmIF2rDflWI+tH6UfoWZVaWmuAD93oAHWG0L1MP9GSetR
         p/pAyH9XBYIK5fQMSHmuH3EroAofH327c0GQidbZE5yzRhKj1Gen/J6O0xYzgJ+FD7IB
         U0ZF0gSdqtVHbB6Mz1+qgyqzBaQPVWIlRTL8ZnzLmzs3UTNjqfU3ugP2IvP2LTh0b+Ib
         zAJwappCrkmTTe+2yoMW4sLuVhXS0hLGWT/g1antl57hoS5DzFPQZYtBlaCwjA+fqLXe
         ug3VTaRVuetnetRmZNuZJ3GABjIYPsGbSWC4Mrn1P0jgbichLvJPLczFgXOyW7JD6bk+
         Im9Q==
X-Gm-Message-State: APjAAAX/nU6Y+i63MM0d/NlImCeEC8flpYHwuSHdCnJXA/yuU5Dn1q/8
        8O9O0U3Z4miCWKDzjkvIBcM=
X-Google-Smtp-Source: APXvYqzPrA41KnDu7zXYKhTKIDFPIusxpkGfQ/f36MqaVUccNYdTjpt+jBN/sHBQmPMYw+AofQ+MZg==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr24989061ljg.82.1571209663820;
        Wed, 16 Oct 2019 00:07:43 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se. [213.102.65.51])
        by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:07:43 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 1/7] ASoC: sun4i-i2s: Move channel select offset
Date:   Wed, 16 Oct 2019 09:07:34 +0200
Message-Id: <20191016070740.121435-2-codekipper@gmail.com>
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

On the newer SoCs the offset is used to set the mode of the
connection. As it is to be used elsewhere then it makes sense
to move it to the main structure.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d5810c0a..f1a80973c450 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -156,7 +156,7 @@ struct sun4i_i2s_quirks {
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *,
 				const struct snd_pcm_hw_params *);
-	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
+	int	(*set_fmt)(struct sun4i_i2s *, unsigned int);
 };
 
 struct sun4i_i2s {
@@ -169,6 +169,7 @@ struct sun4i_i2s {
 	unsigned int	mclk_freq;
 	unsigned int	slots;
 	unsigned int	slot_width;
+	unsigned int	offset;
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
@@ -516,7 +517,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 				      slots, slot_width);
 }
 
-static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
+static int sun4i_i2s_set_soc_fmt(struct sun4i_i2s *i2s,
 				 unsigned int fmt)
 {
 	u32 val;
@@ -589,11 +590,10 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	return 0;
 }
 
-static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
+static int sun8i_i2s_set_soc_fmt(struct sun4i_i2s *i2s,
 				 unsigned int fmt)
 {
 	u32 mode, val;
-	u8 offset;
 
 	/*
 	 * DAI clock polarity
@@ -632,27 +632,27 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
-		offset = 1;
+		i2s->offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
-		offset = 0;
+		i2s->offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
-		offset = 1;
+		i2s->offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
-		offset = 0;
+		i2s->offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
-		offset = 0;
+		i2s->offset = 0;
 		break;
 
 	default:
@@ -663,10 +663,10 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_CTRL_MODE_MASK, mode);
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-			   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
 	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
 			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-			   SUN8I_I2S_TX_CHAN_OFFSET(offset));
+			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
 
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-- 
2.23.0

