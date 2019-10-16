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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D8BECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E23D2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJD0Y8fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbfJPHHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:07:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36792 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389242AbfJPHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:07:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so22815609ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxDmBN8xjRHLwjCrJVEkKzUtkBzzYQgLKNmxBNYk6Lk=;
        b=mJD0Y8fakTfV82mrGHxCoBR8AE4xJv6jTGnyRdffnT3gp8w5fy8thy7oRDclKCdlla
         9AKy2bnASj/sE5hke5dqFXtvW7zM260aK7qraQkvSRmMbE3qohdSyOgif3XtAsjpgL9U
         qQogQrSc2/Lngg0Mq/odTr+eGg+gm5xaIJwcIRKs4K/+zPRr+L6Mv9SIDgbtkWJfw6AR
         e622onDA+2WGpBrRXKKoDwnghIA2tO5jUJPZYBMzz91m3lO7t4XCgGkm3+cKhzhtOkaA
         9h1miXyTVi6KvzyaWYfBk3bsBykMkC0+hU7bBluJU3FRdvfiT6TPpzTpOLf7+csf/s1d
         uHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxDmBN8xjRHLwjCrJVEkKzUtkBzzYQgLKNmxBNYk6Lk=;
        b=DY5oQ3MZQn4cDnuf/y4k3v59e2xhk0q6FCoZBW9555LLh/ERbzeh++fueeGs0qGZwq
         0M2MUX89zoPlW+1aJjurArOQMhBDCQheYEzpz0mDKh6pTHhL4SLn5QQvqx6MOSzFvW0E
         qkURtsKC4sj8lbTOK+eIEkjLpf3msXCpVvmXE/ILv0F2V/XBL78WKkouow6mKvsoTXcO
         +ruyYrhKf8qLR3KWknKXW+g09jsh95ZCqdo/7PlTDkgDiut+gHKi9fH87J+Qts2je+/Z
         zEjCCcCtlt5cOm87+2hYhv33NPevGdPS8CyLMwDCW6+x8GQOKOZsa+2eAVcqNqHNRNJz
         OaeA==
X-Gm-Message-State: APjAAAWj7zfPiYY5c/oXp8LfPXLBlIsN8MRuckOFZRKALepoLZbYtNcb
        UHzSU7M3XWD153DxxtpGUBw=
X-Google-Smtp-Source: APXvYqzFJq0X14+N0B33ZyE/bD1IVOERGHXz7HXUP3dLkoHMUCclXOJf/F7lmiWKgsFUVqC3O42ZPQ==
X-Received: by 2002:a2e:8204:: with SMTP id w4mr25118019ljg.212.1571209665267;
        Wed, 16 Oct 2019 00:07:45 -0700 (PDT)
Received: from localhost.localdomain (c213-102-65-51.bredband.comhem.se. [213.102.65.51])
        by smtp.gmail.com with ESMTPSA id j191sm1361493lfj.49.2019.10.16.00.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:07:44 -0700 (PDT)
From:   codekipper@gmail.com
To:     mripard@kernel.org, wens@csie.org, linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v6 2/7] ASoC: sun4i-i2s: Add functions for RX and TX channel offsets
Date:   Wed, 16 Oct 2019 09:07:35 +0200
Message-Id: <20191016070740.121435-3-codekipper@gmail.com>
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

Newer SoCs like the H6 have the channel offset bits in a different
position to what is on the H3. As we will eventually add multi-
channel support then create function calls as opposed to regmap
fields to add support for different devices.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f1a80973c450..875567881f30 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -157,6 +157,8 @@ struct sun4i_i2s_quirks {
 	int	(*set_chan_cfg)(const struct sun4i_i2s *,
 				const struct snd_pcm_hw_params *);
 	int	(*set_fmt)(struct sun4i_i2s *, unsigned int);
+	void	(*set_txchanoffset)(const struct sun4i_i2s *, int);
+	void	(*set_rxchanoffset)(const struct sun4i_i2s *);
 };
 
 struct sun4i_i2s {
@@ -467,6 +469,23 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	return 0;
 }
 
+static void sun8i_i2s_set_txchanoffset(const struct sun4i_i2s *i2s, int output)
+{
+	if (output >= 0 && output < 4)
+		regmap_update_bits(i2s->regmap,
+				   SUN8I_I2S_TX_CHAN_SEL_REG + (output * 4),
+				   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
+				   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
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
@@ -661,12 +680,10 @@ static int sun8i_i2s_set_soc_fmt(struct sun4i_i2s *i2s,
 
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
 			   SUN8I_I2S_CTRL_MODE_MASK, mode);
-	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
-			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
-	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
-			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
-			   SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
+	if (i2s->variant->set_txchanoffset)
+		i2s->variant->set_txchanoffset(i2s, 0);
+	if (i2s->variant->set_rxchanoffset)
+		i2s->variant->set_rxchanoffset(i2s);
 
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -1136,6 +1153,8 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
 	.set_fmt		= sun8i_i2s_set_soc_fmt,
+	.set_txchanoffset	= sun8i_i2s_set_txchanoffset,
+	.set_rxchanoffset	= sun8i_i2s_set_rxchanoffset,
 };
 
 static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
-- 
2.23.0

