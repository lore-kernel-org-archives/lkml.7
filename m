Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9104C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67EE21881
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5ZI20/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbfHZSHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:07:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34005 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbfHZSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:07:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id x18so15996959ljh.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukuuUBdDBhaCevdSYR2WXtuXiYA+/tk7SlxUyZaPi3U=;
        b=X5ZI20/CE7C81ZGz/W4Y/X/QmOCV5xtQN4RNxkIU7eUjrSA0n/z9clpTiZX8hVFZoH
         HNGhFUWhuJTyoDCrhkWLZsZroLsojNdY+wFLYWSJWG1uyRHfg0sORzhZbRAip95gEy/7
         lqUNDC53zrLWta46uPCP0BcIrIrFO60CvRXNNG0KmVAB30fJrH62qtQY/mhNh6g0E1Q/
         yIJJ0HvGKPGAo+cp+UVVk3Y/8NQQKxsGBUpQ0lkk26zIGilaPpgZN1C+hNOQsHFNxntS
         XW44tdSO2UMcU70Gq8LOsItG6SnVdwyMPE5UtwaTK8Dv7qCbF9801WXmw5EC9N+ONuod
         k0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukuuUBdDBhaCevdSYR2WXtuXiYA+/tk7SlxUyZaPi3U=;
        b=AitaiWJ8HFxabIcGoQP/QnZ7xNnoxOfU06w2ZQJc7U0o1qDUGRkCEJA9j8T7AJb2I4
         +62S2wlo9OiMXYgGNgrK2imsXlHyPrIQBxOdQQQtXo5YoPWG+jm3TfjOb8hK5Ggla/EK
         4cxU36+WU8EEdg5zEn9vYtrTm0R7Iowv3IAsnuY9OqFED46x22O1EwR5P2uUUJnHPFIb
         3CiQKyKHT1Fv09TvP5APu/z3S0swN7rWrScyoBqNYwFgxPZOnLK8Omq5vgd0PAvsqQP4
         NDKXI1/Zl6EKLaoobQluWrOpJkouKUnYRYrXjEocjZxRxyDyhPQ6coJLjiCKgC/wFwJ9
         04Vg==
X-Gm-Message-State: APjAAAUFReVzqRstlqiaSjPxc+Xka70CcyfbHOdCrWgMcWfEWVn1N1ZH
        ObJXjTaFKt2/NEzWcQXWJIfyIfvE
X-Google-Smtp-Source: APXvYqyYEpihsZF+JV1SShitkdzIKCoMZNNq7L/fwZ9FV8upcocQMT8ztPvcFOkyMOEOCgpILghRAA==
X-Received: by 2002:a2e:6393:: with SMTP id s19mr11066423lje.46.1566842859207;
        Mon, 26 Aug 2019 11:07:39 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id u3sm2215564lfm.16.2019.08.26.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 11:07:38 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 2/3] ASoC: sun4i-i2s: Add regmap field to sign extend sample
Date:   Mon, 26 Aug 2019 20:07:33 +0200
Message-Id: <20190826180734.15801-3-codekipper@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826180734.15801-1-codekipper@gmail.com>
References: <20190826180734.15801-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

On the newer SoCs such as the H3 and A64 this is set by default
to transfer a 0 after each sample in each slot. However the A10
and A20 SoCs that this driver was developed on had a default
setting where it padded the audio gain with zeros.

This isn't a problem whilst we have only support for 16bit audio
but with larger sample resolution rates in the pipeline then SEXT
bits should be cleared so that they also pad at the LSB. Without
this the audio gets distorted.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 34575a8aa9f6..056a299c03fb 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -135,6 +135,7 @@ struct sun4i_i2s;
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
+ * @field_fmt_sext: regmap field to set the sign extension.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
@@ -145,6 +146,7 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_clkdiv_mclk_en;
 	struct reg_field		field_fmt_wss;
 	struct reg_field		field_fmt_sr;
+	struct reg_field		field_fmt_sext;
 
 	const struct sun4i_i2s_clk_div	*bclk_dividers;
 	unsigned int			num_bclk_dividers;
@@ -177,6 +179,7 @@ struct sun4i_i2s {
 	struct regmap_field	*field_clkdiv_mclk_en;
 	struct regmap_field	*field_fmt_wss;
 	struct regmap_field	*field_fmt_sr;
+	struct regmap_field	*field_fmt_sext;
 
 	const struct sun4i_i2s_quirks	*variant;
 };
@@ -354,6 +357,10 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 
 	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
 
+
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_field_write(i2s->field_fmt_sext, 0);
+
 	return 0;
 }
 
@@ -1073,6 +1080,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.mclk_dividers		= sun4i_i2s_mclk_div,
 	.num_mclk_dividers	= ARRAY_SIZE(sun4i_i2s_mclk_div),
 	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
+	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
@@ -1091,6 +1099,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.mclk_dividers		= sun4i_i2s_mclk_div,
 	.num_mclk_dividers	= ARRAY_SIZE(sun4i_i2s_mclk_div),
 	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
+	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
@@ -1109,6 +1118,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.mclk_dividers		= sun8i_i2s_clk_div,
 	.num_mclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
 	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
+	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
@@ -1127,6 +1137,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.mclk_dividers		= sun4i_i2s_mclk_div,
 	.num_mclk_dividers	= ARRAY_SIZE(sun4i_i2s_mclk_div),
 	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
+	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
@@ -1154,6 +1165,12 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	if (IS_ERR(i2s->field_fmt_sr))
 		return PTR_ERR(i2s->field_fmt_sr);
 
+	i2s->field_fmt_sext =
+			devm_regmap_field_alloc(dev, i2s->regmap,
+						i2s->variant->field_fmt_sext);
+	if (IS_ERR(i2s->field_fmt_sext))
+		return PTR_ERR(i2s->field_fmt_sext);
+
 	return 0;
 }
 
-- 
2.23.0

