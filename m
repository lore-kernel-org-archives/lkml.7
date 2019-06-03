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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357C7C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E6C27101
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbvcavDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfFCRrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:47:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35388 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfFCRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so14304704lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwGUR02EDQ13UCHXrb89qrEiTxqnpniiixZ9ii9/brU=;
        b=fbvcavDwHCyV2dKEGAeUTgZUKMNr01Q6ULE8FaQUiQ0JNUrjsYilRijeWC2uCcENRm
         ncJuCkU64ceD57b3rxwPalvIbpznVZ7OkkJ4B0ZPwyGyAA2gs/VJl5rtG1a0rPbDNLBj
         Gq4NihVFfIedw9rSwdHTg7pv/zx/Am+uDPlXbJE8VRA2RBdGBsca4ykyyGNXAbwI0pRQ
         Zi/4ypd/JLnHATw3n1vJk8wIgXn44kMJB5tRTL7xqUpY5vhW8KTrfn17Secy0wGMPITQ
         JFijHJq9c8jmkEMhQN8AgIdRwr/DksdSrrCmnStyH+lY/STE05oQ5yB+q0o4EOFL8IDm
         z4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwGUR02EDQ13UCHXrb89qrEiTxqnpniiixZ9ii9/brU=;
        b=dD9p808HTkYZkbCtSN47hnUwj0cFNujMeU94jmXm2rqyCzTR//tJoJZvb5ZkxhgkgC
         oCtCU9NILCYfc7KwRnsCb91FmGgF9p7TDGL7uiuXXYfD5v9BShiA19ZCu+FbDmQ86vJA
         sQ/vHxfnEOlawOCbPacshXX4wv26JwksKGiu0PAGPKo4itCJ0aimHI661R+SJmpQ3nEr
         ezESYjt4jBpvNhLJexcnzpRjquOlYBvxdBO9opjdmhSW3IIZwjyBx0IP8fUCs6FSQC67
         zzXN0f3CJXk2W2ajeYaL3amjAxyemExVL7ELr2kkwcwoFZOfUoPB8mhF9w3gAqgPVz+y
         39dg==
X-Gm-Message-State: APjAAAW1aOziN0zI2j4fwIw41yWHvVA2HVfiJ/eWC5NNUqLxziBzRcKy
        Cp0xHO0pN12vz/QUZXzupIdxTg4q
X-Google-Smtp-Source: APXvYqzhmC7VgtWYMxxp2kY23YtH8Ca0a0KQNKe2mlI1+BLdkn+mgGJp9VxVUIN/qnwBwT0R5uQVCQ==
X-Received: by 2002:a19:4f50:: with SMTP id a16mr13990334lfk.24.1559584061508;
        Mon, 03 Jun 2019 10:47:41 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:41 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 4/9] ASoC: sun4i-i2s: Reduce quirks for sun8i-h3
Date:   Mon,  3 Jun 2019 19:47:30 +0200
Message-Id: <20190603174735.21002-5-codekipper@gmail.com>
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

We have a number of flags used to identify the functionality
of the IP block found on the sun8i-h3 and later devices. As it
is only neccessary to identify this new block then replace
these flags with just one.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index e2961d8f6e8c..329883750d6f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -119,10 +119,7 @@
  *
  * @has_reset: SoC needs reset deasserted.
  * @has_slave_select_bit: SoC has a bit to enable slave mode.
- * @has_fmt_set_lrck_period: SoC requires lrclk period to be set.
- * @has_chcfg: tx and rx slot number need to be set.
- * @has_chsel_tx_chen: SoC requires that the tx channels are enabled.
- * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
+ * @is_h3_i2s_based: This block is similiar to what is found on the h3.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
@@ -143,10 +140,7 @@
 struct sun4i_i2s_quirks {
 	bool				has_reset;
 	bool				has_slave_select_bit;
-	bool				has_fmt_set_lrck_period;
-	bool				has_chcfg;
-	bool				has_chsel_tx_chen;
-	bool				has_chsel_offset;
+	bool				is_h3_i2s_based;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
 	unsigned int			mclk_offset;
@@ -340,7 +334,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	regmap_field_write(i2s->field_clkdiv_mclk_en, 1);
 
 	/* Set sync period */
-	if (i2s->variant->has_fmt_set_lrck_period)
+	if (i2s->variant->is_h3_i2s_based)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
@@ -366,7 +360,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (i2s->variant->has_chcfg) {
+	if (i2s->variant->is_h3_i2s_based) {
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
 				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
 				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
@@ -386,7 +380,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_rxchansel,
 			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
 
-	if (i2s->variant->has_chsel_tx_chen)
+	if (i2s->variant->is_h3_i2s_based)
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
 				   SUN8I_I2S_TX_CHAN_EN_MASK,
 				   SUN8I_I2S_TX_CHAN_EN(channels));
@@ -449,7 +443,7 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	if (i2s->variant->has_chsel_offset) {
+	if (i2s->variant->is_h3_i2s_based) {
 		/*
 		 * offset being set indicates that we're connected to an i2s
 		 * device, however offset is only used on the sun8i block and
@@ -942,10 +936,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.mclk_offset		= 1,
 	.bclk_offset		= 2,
 	.fmt_offset		= 3,
-	.has_fmt_set_lrck_period = true,
-	.has_chcfg		= true,
-	.has_chsel_tx_chen	= true,
-	.has_chsel_offset	= true,
+	.is_h3_i2s_based     = true,
 	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
 	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
-- 
2.21.0

