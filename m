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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39162C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10696208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2du8sAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfHNGJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:09:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43490 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfHNGJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id h15so10027881ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fh22f/sTchPjHgsscoNm3Ov1bjJw2jPP3PY0mrbK/90=;
        b=K2du8sAU2z3W3uufkIcrgtTZxjcma1Gieyp9EV2QFl9U42Xqw0u2uS39AeJOuFIsfc
         3DHN6emglW3b8O0/qx3XjIqOBLWkyMuPguunOKVSXXdtGn3ntouqsHoNIcNpfYHkYsNL
         0S2NxdFod014L3/FTFuE6NdNxntM2J4md4waTLq9ttHELJDrXeahUseG1iEp7+5tgyHd
         LsOeFDBDrPyKJKS8fs8XIvMqBBzZ8t9X/H3h7FxGvGXRGIKx7f1WmF8HCacLVx4v2Ydi
         h7NhthOb94+GEy0y5xQC3v6oj0v4OM5PwPzWmUspU9sgwMneZrNXStf3zlp/4omyY5u/
         A8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fh22f/sTchPjHgsscoNm3Ov1bjJw2jPP3PY0mrbK/90=;
        b=ib8PaNshBDoP+yRbkrFjvQ5pn8VsUfB65Ff4aN0sNyVyeVfcjXGuwvr9cmv0k0v4E8
         vWnjMextcWBV9y6qo7b3I2BqfR+a3QVCZvLJoy3nL3MpzkbAor0+ukPVU8KbiVC2WE2S
         b40GCA8oLGuNbGYOAx5rm9GMKlEu4DhRbJTOjB06VhK67URuY7juAP/WB1QNqBdValj3
         zLkJTY3OEl6c0zKjPAL9MNRAqnSmwTRyAt5eUhLfbKyUzFrdy/Rm9Oiq3ZMgbZobcRQk
         0oyK1BaBKV8EFw0pxTyS3r390yl0RE8WBl4nKQ7xwpAtEWVSRiaNU7h1kEUn536ewu2g
         wrqg==
X-Gm-Message-State: APjAAAUU4+UF58wau65Bjz/YlOkJ3Pcjv5Yt8btaG/gQ/E09mFzxRO5V
        ynixXdhLRONvK7oopF2uO/I=
X-Google-Smtp-Source: APXvYqyPsxE4hTdhuVvAeZeeXMwMOSa2Ky6foSm54t8aKY0myZ8PEB3c9JWJ4q5Pz8BQl/NoSc417Q==
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr22840869lji.84.1565762948784;
        Tue, 13 Aug 2019 23:09:08 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:08 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 06/15] ASoC: sun4i-i2s: Add functions for RX and TX channel enables
Date:   Wed, 14 Aug 2019 08:08:45 +0200
Message-Id: <20190814060854.26345-7-codekipper@gmail.com>
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

Newer SoCs like the H6 have the channel enable bits in a different
position to what is on the H3. As we will eventually add multi-
channel support then create function calls as opposed to regmap
fields to add support for different devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 4a748747ccd7..ad2ff83deeb7 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -172,6 +172,8 @@ struct sun4i_i2s_quirks {
 	int	(*set_format)(struct sun4i_i2s *, unsigned int);
 	void	(*set_txchanoffset)(const struct sun4i_i2s *, int);
 	void	(*set_rxchanoffset)(const struct sun4i_i2s *);
+	void	(*set_txchanen)(const struct sun4i_i2s *, int, int);
+	void	(*set_rxchanen)(const struct sun4i_i2s *, int);
 };
 
 struct sun4i_i2s {
@@ -444,6 +446,25 @@ static void sun8i_i2s_set_rxchanoffset(const struct sun4i_i2s *i2s)
 			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
 }
 
+static void sun8i_i2s_set_txchanen(const struct sun4i_i2s *i2s, int output,
+				   int channel)
+{
+	if (output >= 0 && output < 4) {
+		regmap_update_bits(i2s->regmap,
+				   SUN8I_I2S_TX_CHAN_SEL_REG + (output * 4),
+				   SUN8I_I2S_TX_CHAN_EN_MASK,
+				   SUN8I_I2S_TX_CHAN_EN(channel));
+	}
+}
+
+static void sun8i_i2s_set_rxchanen(const struct sun4i_i2s *i2s, int channel)
+{
+	regmap_update_bits(i2s->regmap,
+			   SUN8I_I2S_RX_CHAN_SEL_REG,
+			   SUN8I_I2S_TX_CHAN_EN_MASK,
+			   SUN8I_I2S_TX_CHAN_EN(channel));
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -479,10 +500,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	regmap_field_write(i2s->field_rxchansel,
 			   SUN4I_I2S_CHAN_SEL(params_channels(params)));
 
-	if (i2s->variant->has_chsel_tx_chen)
-		regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-				   SUN8I_I2S_TX_CHAN_EN_MASK,
-				   SUN8I_I2S_TX_CHAN_EN(channels));
+	if (i2s->variant->set_txchanen)
+		i2s->variant->set_txchanen(i2s, 0, channels);
+
+	if (i2s->variant->set_rxchanen)
+		i2s->variant->set_rxchanen(i2s, channels);
 
 	switch (params_physical_width(params)) {
 	case 16:
@@ -1098,6 +1120,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.set_format		= sun8i_i2s_set_format,
 	.set_txchanoffset	= sun8i_i2s_set_txchanoffset,
 	.set_rxchanoffset	= sun8i_i2s_set_rxchanoffset,
+	.set_txchanen		= sun8i_i2s_set_txchanen,
+	.set_rxchanen		= sun8i_i2s_set_rxchanen,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
-- 
2.22.0

