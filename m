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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0389C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE33271A9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAgRJox6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfFCRrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:47:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34604 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfFCRrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id j24so17105128ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dU3J6vSB6rrSmznGSHAJH8TKN9OO1b+UvKtsB3mqw0=;
        b=OAgRJox6KpAoi7IKo7tD5dHGkky2hlNqvyaujK1utMnRUoKiedl7nyAASuM24/Aiki
         st5JKW5/rZbJzL5D3hJLlU31T1de7hW7gWJA4sNI8DrwYMnEKV86vvz8FDfdo3urs2OE
         xDpZOKVjmBjCSFOSE2XBv2LKIBgrIbli6DGARQ9LTg/eEEuD0Kjed5FawfT/L3xoGmNm
         2hIdMzfl2Yj+N/UqaGcv5LT6TMtSiFyz4PqY4ZzytQIsldhU3oPnolntRK6bi0cYaZhw
         59BQiDH1aa9L0oLybmLCjP0YoKUGMQIQtigs7bFEvtS7e2ldBqQFmgUEYIolSV/nsHEQ
         HJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dU3J6vSB6rrSmznGSHAJH8TKN9OO1b+UvKtsB3mqw0=;
        b=UOvh4gCaj9wEndcsMli3G+nW7IGJPDjqDt7k3kyhjIDDQl2PTH1kXx+NOqipOGc/bL
         D5Ncw0EXpkNb+oW6UnlJETy1Jt1KuOkQzdA+FqXMzpXxCakfNTw6f8gpTOY+S/cow7XB
         SncuB7Dmx7PnxH56Kha0NfMFgn7/3QKcN+xOz5Z6l+mcJmOozX3Fdf2zqhpt2vm+AHaO
         KDdUEJD8rw3XjWPbv5SwHwZtYXToVbONQN+nRdqbIAco4sLlmey/ne7fTC49cuihX5bt
         uldoR3DedzNmx3kft5QRAsFXBUCUhrxdPmZY+sngzMoCP3vnFz/zc1S35BvnnHtTPo2j
         SKAw==
X-Gm-Message-State: APjAAAV6iKCvrECeyj56FWR46oL26rCgR5LWnlvgafe+hBhT9KBN/FVk
        tGKOzOh5TUOZEAPEHeSz8Ic=
X-Google-Smtp-Source: APXvYqwROrB7Vb+pbcTPCi0P/yuE7aA4w2nDEZebnoQXexL+Iy3qCA6eOa42yRSvYnC8WznFmmt7LQ==
X-Received: by 2002:a2e:2f12:: with SMTP id v18mr14171586ljv.196.1559584063684;
        Mon, 03 Jun 2019 10:47:43 -0700 (PDT)
Received: from localhost.localdomain ([188.150.253.81])
        by smtp.gmail.com with ESMTPSA id n7sm2803532lfi.68.2019.06.03.10.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:42 -0700 (PDT)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
Date:   Mon,  3 Jun 2019 19:47:32 +0200
Message-Id: <20190603174735.21002-7-codekipper@gmail.com>
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

The i2s block supports multi-lane i2s output however this functionality
is only possible in earlier SoCs where the pins are exposed and for
the i2s block used for HDMI audio on the later SoCs.

To enable this functionality, an optional property has been added to
the bindings.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 44 ++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index bca73b3c0d74..75217fb52bfa 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -23,7 +23,7 @@
 
 #define SUN4I_I2S_CTRL_REG		0x00
 #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
-#define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + (sdo))
+#define SUN4I_I2S_CTRL_SDO_EN(lines)		(((1 << lines) - 1) << 8)
 #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
 #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
 #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
@@ -355,14 +355,23 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	int sr, wss, channels;
 	u32 width;
+	int lines;
 
 	channels = params_channels(params);
-	if (channels != 2) {
+	if ((channels > dai->driver->playback.channels_max) ||
+		(channels < dai->driver->playback.channels_min)) {
 		dev_err(dai->dev, "Unsupported number of channels: %d\n",
 			channels);
 		return -EINVAL;
 	}
 
+	lines = (channels + 1) / 2;
+
+	/* Enable the required output lines */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_SDO_EN_MASK,
+			   SUN4I_I2S_CTRL_SDO_EN(lines));
+
 	if (i2s->variant->is_h3_i2s_based) {
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
 				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
@@ -373,8 +382,19 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Map the channels for playback and capture */
-	regmap_field_write(i2s->field_txchanmap, 0x76543210);
 	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
+	regmap_field_write(i2s->field_txchanmap, 0x10);
+	if (i2s->variant->is_h3_i2s_based) {
+		if (channels > 2)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
+		if (channels > 4)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
+		if (channels > 6)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
+	}
 
 	/* Configure the channels */
 	regmap_field_write(i2s->field_txchansel,
@@ -1057,9 +1077,10 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
+	struct snd_soc_dai_driver *soc_dai;
 	struct resource *res;
 	void __iomem *regs;
-	int irq, ret;
+	int irq, ret, val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1126,6 +1147,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
 	i2s->capture_dma_data.maxburst = 8;
 
+	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
+			       sizeof(*soc_dai), GFP_KERNEL);
+	if (!soc_dai) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "allwinner,playback-channels", &val)) {
+		if (val >= 2 && val <= 8)
+			soc_dai->playback.channels_max = val;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
@@ -1135,7 +1169,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+					      soc_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
-- 
2.21.0

