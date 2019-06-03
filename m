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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C7EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F3D25E73
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB7x2Efd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfFCRsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:48:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41680 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfFCRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id s21so6435714lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4qDu9sgTgZn0ixKovZtDdWsY36CDb/LQcyeDWdfScG8=;
        b=VB7x2EfdwROpsggAChY65dDFdT4snrzfhIsqFYJismvsXq0mLGWEpQPGANo6GZ86WD
         EhluPWYQPbQI/VFt/GMWVZTgyYHqszB0rLOaGRMVg4VjXS18RqJW09eEmeXOXKqQcm31
         omLCWC5Mh3F3Y0cq0FGe9FoX3NMaq3Ek60AZkyyAxJI/PVrudcafQaC1CcwU/zP0+PFm
         X162LXhajyp+9zrRGf/vq0gBV6Uj4Lp9j1a2J4KZYbtmiywJ1hIvGs18iNVcojXLfNjM
         2v0tYS+Bywfe4G3RLDioJokRUvLQbkLXF3/T6eNyQo3HxlZRXWV+avdLO2X9ZAJVAtYk
         ccqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qDu9sgTgZn0ixKovZtDdWsY36CDb/LQcyeDWdfScG8=;
        b=VUybziibhUcgFF4OhyeH2YFTvSgylaoe9pjDFEqXromrJosXvwcXImqmAJScMBBKBk
         kwxk/UcK8PnrkcxcBznmu4NnqxZvVVhi5C9SDI8AdfYCHRL+3AJknDWEDsBRfUiybnNa
         asgr0mwJqUQzWZyjDYIU3h0458uYO+VLHt5EvJV90xN/eHb5mBnzbM8/O436q/rQNITb
         rJQGELIIptq/nUqQjmHAwZCXEkCsDA5GLFS7qQKUdeOOQ708dkxZVCs2NIALir/sE+UC
         3ZhUfHLt+aabO1KaX0qh0BGMkcV5gWxJwhrHT7Ngl9to4O/+SzToj4FO2iVblrzR9c1i
         NOVQ==
X-Gm-Message-State: APjAAAX/G5HiZfFASv7CCHn9hNR9glAxoem4dFudIeegRSe4Anbc6Toc
        8YukKOjrnL1eT+LMH9sNiTo=
X-Google-Smtp-Source: APXvYqz2F0PyDNUFtpD+QUjxtj9ZHAQF3f3fXBXumc+SWsHJ+iRNTuzAyPXaNJZS7kycwtwb/Rn35A==
X-Received: by 2002:a2e:91d7:: with SMTP id u23mr14465389ljg.150.1559584062466;
        Mon, 03 Jun 2019 10:47:42 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:41 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 5/9] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Date:   Mon,  3 Jun 2019 19:47:31 +0200
Message-Id: <20190603174735.21002-6-codekipper@gmail.com>
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

Some codecs require a different amount of a bit clocks per frame than
what is calculated by the sample width. Use the tdm slot bindings to
provide this mechanism.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 329883750d6f..bca73b3c0d74 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -186,6 +186,9 @@ struct sun4i_i2s {
 	struct regmap_field	*field_rxchansel;
 
 	const struct sun4i_i2s_quirks	*variant;
+
+	unsigned int	tdm_slots;
+	unsigned int	slot_width;
 };
 
 struct sun4i_i2s_clk_div {
@@ -337,7 +340,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->is_h3_i2s_based)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
 
 	/* Set sign extension to pad out LSB with 0 */
 	regmap_field_write(i2s->field_fmt_sext, 0);
@@ -414,7 +417,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			   sr + i2s->variant->fmt_offset);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      i2s->tdm_slots ?
+				      i2s->slot_width : params_width(params));
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -657,11 +661,25 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask,
+	int slots, int width)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	i2s->tdm_slots = slots;
+
+	i2s->slot_width = width;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
 	.trigger	= sun4i_i2s_trigger,
+	.set_tdm_slot	= sun4i_i2s_set_dai_tdm_slot,
 };
 
 static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
-- 
2.21.0

