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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D2C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4523D2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FavTetyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfHNGJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40492 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfHNGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so78468173lff.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIdAGNiLkiiK2Gw0kPcR7I6xu5ZStD9Kxb2ECFc6UjY=;
        b=FavTetyhFsglyGujp7hKFmN5Wjrg8vatZ/OKeJnhnFCTNyNjm6FSQW5m7z4ex3otcK
         XNWNbkpobxRd8dgjYf9tHhgx9aHtDe4FhyV7utEEWuo615XqeQvu3KtvBsKqTrXAaLJ1
         JuZoHI12nV9/EFhVOIcOLI4Efnu30Co0IfQpSZC5NSOOy30Y7vapcGtPogK7LmGHzLKY
         Or1T9GCBBheRfEcR8c9bnEU8DqDNZqWg9zraE2OVhBNP22FEH2TyDi1RHPMZVNkfSQO9
         YuIyZtMpunFNx0/5XICae1ynEKsev56Mf9hGlsmEGDKtPGMhp8nU3Gz9uqEU2jIWK79A
         WWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIdAGNiLkiiK2Gw0kPcR7I6xu5ZStD9Kxb2ECFc6UjY=;
        b=MpoGAqHSsu5+zUpM0g/HNF0hgv6Y2rD37SK6Qn4JNiMbIObrakFre/DQ91BSv9U3an
         J43WVzDeqtki4lyTNAH3z+JgBn9tr4YaPvqnJq5lF1tlv3Th7quWRV7StT+DxsOjkuhv
         8uYEFJQjg48PirSD+4Bpy6c3HVcMMEUOUcuRGXOOfqkNBLxTsnASd4Ep8kS5qE+9A8Jw
         st9uVhNX0vdgfupltNu70htSCNandMyjs2XxWWOzqOve/se6mSj56fFomoesJi2xfjju
         hF4Ywx1XK0XytrReLe3+Hbx4m3Ib0nHAi2BjBmkOwO/InMjdJZivbK+IVoDc7WCzURpj
         x0YA==
X-Gm-Message-State: APjAAAUpsVe7JSwhnnU+g802fJnvm7863guAeDLS6pjUiJeBdoRSH7Mx
        IpZu4TPJOcwba3+w/HksWqo=
X-Google-Smtp-Source: APXvYqzPDghVmAfn8CnRzvuqNzhY1HphT9aHe0MsxJAGXonvqC7XcehgcpyOD4PCKzazCISMYoQs9w==
X-Received: by 2002:a19:c511:: with SMTP id w17mr13345752lfe.31.1565762942016;
        Tue, 13 Aug 2019 23:09:02 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.08.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:01 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 02/15] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Date:   Wed, 14 Aug 2019 08:08:41 +0200
Message-Id: <20190814060854.26345-3-codekipper@gmail.com>
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

Codecs without a control connection such as i2s based HDMI audio and
the Pine64 DAC require a different amount of bit clocks per frame than
what is calculated by the sample width. Use the tdm slot bindings to
provide this mechanism.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8201334a059b..7c37b6291df0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -195,6 +195,9 @@ struct sun4i_i2s {
 	struct regmap_field	*field_rxchansel;
 
 	const struct sun4i_i2s_quirks	*variant;
+
+	unsigned int	tdm_slots;
+	unsigned int	slot_width;
 };
 
 struct sun4i_i2s_clk_div {
@@ -346,7 +349,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->has_fmt_set_lrck_period)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
 
 	/* Set sign extension to pad out LSB with 0 */
 	regmap_field_write(i2s->field_fmt_sext, 0);
@@ -450,7 +453,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_fmt_sr, sr);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      i2s->tdm_slots ?
+				      i2s->slot_width : params_width(params));
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -693,10 +697,25 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
+static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
+				      unsigned int tx_mask,
+				      unsigned int rx_mask,
+				      int slots, int width)
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
+	.set_tdm_slot	= sun4i_i2s_set_dai_tdm_slot,
 	.trigger	= sun4i_i2s_trigger,
 };
 
-- 
2.22.0

