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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37A1C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95C12084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+zuhJDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfHNGKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:10:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39072 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfHNGJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:09:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id x4so11572555ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 23:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05luO0el08+ksQzcW4RTEqUT7Ds3M01UtKJnSKZS1CI=;
        b=A+zuhJDGf+WT+Ot0CNMAkUD7+SOWysTa2Ly11PvI1hlDTVlD1HpP8d3h6wTV9G3bE8
         FLhZBNYQxeXa1j0KgS0UXPKTFBH53afq422IOj6cub+vwQBiz5FsfczsQXawQ0r4mOyn
         Da4X1NxE5bspTPUucZ5xMxUwcvvKQFi6BtGW5mDtLV91qNyZz/4yTbcdy4MpKHCXfLdZ
         Q3qldDXLiie62cym73HYA0wwyWg93sUxLaNcGumZgKqxkdj0KkIaG+uA5jgUnICzLcnV
         8GLxI+v1pSxXIGQz9ztRhoKsIOYw91FZYoXHR6F9GaiGvRAgh3U/N7VsRqti+cS904gq
         Htkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05luO0el08+ksQzcW4RTEqUT7Ds3M01UtKJnSKZS1CI=;
        b=JLBTSh//cvDR6tZU5ZPJyPNzvOuA6Nxk+8IDIlkFWbyoAlWsEPQo8ZlJW5VpzAX0du
         mSYcrSJBgJZg8c0ZWY3lABhyEMgk3QJvI3AlrJCvmDEP1kbifyBcdVn+QnHRuvVQCTKA
         OKs4iB7gpoBg1XWcj6zAc/ek6mjyTKBZlZAMb96GvU+ukwZ/1c2mOnNMALEvFuLAYI9F
         1jTZ97AlCCThNd+yU7tAki1um6rr53QvsSwI7d7wJipiY3Z8VRUNkbdqoJLCh4J2IaZH
         cJR+K+H8tgKSS+6CH+26mbhMSoS+dPGl/Bf1I3K6RO2O8jHcquNYD8hpY8TxNlun7Otu
         iE8g==
X-Gm-Message-State: APjAAAUIfFK+SPkvQsZTWjjF4PBy5NQ+G9fcS1QAzqryx87RjGwfs0uz
        xjBkkNIeUUJnkEDnxZzuB8U=
X-Google-Smtp-Source: APXvYqwa2QE/MzggVT+SxSReZtwaVjTUt6MgdTVwN4bjTZtThH/Dm274tKDTRtDX5F1nP2l0VTh3jQ==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr24254402lji.64.1565762947367;
        Tue, 13 Aug 2019 23:09:07 -0700 (PDT)
Received: from localhost.localdomain (c213-102-74-69.bredband.comhem.se. [213.102.74.69])
        by smtp.gmail.com with ESMTPSA id s10sm3124235ljm.35.2019.08.13.23.09.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 23:09:06 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v5 05/15] ASoC: sun4i-i2s: Add functions for RX and TX channel offsets
Date:   Wed, 14 Aug 2019 08:08:44 +0200
Message-Id: <20190814060854.26345-6-codekipper@gmail.com>
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

Newer SoCs like the H6 have the channel offset bits in a different
position to what is on the H3. As we will eventually add multi-
channel support then create function calls as opposed to regmap
fields to add support for different devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 3553c17318b0..4a748747ccd7 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -112,7 +112,7 @@
 #define SUN8I_I2S_TX_CHAN_MAP_REG	0x44
 #define SUN8I_I2S_TX_CHAN_SEL_REG	0x34
 #define SUN8I_I2S_TX_CHAN_OFFSET_MASK		GENMASK(13, 12)
-#define SUN8I_I2S_TX_CHAN_OFFSET(offset)	(offset << 12)
+#define SUN8I_I2S_TX_CHAN_OFFSET(offset)	((offset) << 12)
 #define SUN8I_I2S_TX_CHAN_EN_MASK		GENMASK(11, 4)
 #define SUN8I_I2S_TX_CHAN_EN(num_chan)		(((1 << num_chan) - 1) << 4)
 
@@ -170,6 +170,8 @@ struct sun4i_i2s_quirks {
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
 	int	(*set_format)(struct sun4i_i2s *, unsigned int);
+	void	(*set_txchanoffset)(const struct sun4i_i2s *, int);
+	void	(*set_rxchanoffset)(const struct sun4i_i2s *);
 };
 
 struct sun4i_i2s {
@@ -424,6 +426,24 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
 	return (width - 8) / 4 + 1;
 }
 
+static void sun8i_i2s_set_txchanoffset(const struct sun4i_i2s *i2s, int output)
+{
+	if (output >= 0 && output < 4) {
+		regmap_update_bits(i2s->regmap,
+				   SUN8I_I2S_TX_CHAN_SEL_REG + (output * 4),
+				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
+	}
+}
+
+static void sun8i_i2s_set_rxchanoffset(const struct sun4i_i2s *i2s)
+{
+	regmap_update_bits(i2s->regmap,
+			   SUN8I_I2S_RX_CHAN_SEL_REG,
+			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -1076,6 +1096,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_format		= sun8i_i2s_set_format,
+	.set_txchanoffset	= sun8i_i2s_set_txchanoffset,
+	.set_rxchanoffset	= sun8i_i2s_set_rxchanoffset,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
-- 
2.22.0

