Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E18BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6BB204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWMTEcyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfDSTOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34219 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfDSTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id c6so2278086wrm.1;
        Fri, 19 Apr 2019 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVM3scnTgs2IQkEMAAfq9yJRu6ngnARGM49TDVLenVA=;
        b=DWMTEcyzNWH/FMMheV28CFOQute8yMYoKlrl3FMEp3n1ki2JJcYDc4jseQEcjZy472
         MXpaXnfUA7HeUHY/OAexdTaUm5hNKRHBLmp1PmPtLMbBwyenSv2HuS4VX3+0LRhueD7B
         3D4oGjwRratIk2khPgqF5arvDvcq9HfmIBPE5NvdIBFe0pFiDIfCGpeM/mBKQGcMQAiy
         5dHEwR/yssUPTVhX//epxw/uwoRl43viNTi/W007Ie46wI/Slnt7NNIy18Bb6kQyCvaS
         m9zMhNOhP3EkUeXMtxR86r1e76QUZt61an02c439kwszvNXmjVbThjhAVr4GDbCUffqK
         J++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVM3scnTgs2IQkEMAAfq9yJRu6ngnARGM49TDVLenVA=;
        b=kLtMREzCTh98F2kpQ6HqaMrp1hL49h4yrzk8T6YojliuzvO67ldXEL35fHoKY6b4gN
         L55WaIbP7sKUnCOmfvfCZ3cdjP8/XL7YABWoxY0CkTBScYv8+N2ZPbNcopgtxRYggvNC
         UUizVRYFob1q4ea/JiecV9sYsIFH2Mjb0TWB3uZ9R915iCXvUhYG/nCuMIWqYgjD/eAO
         Rd8oWX+Wv1uE1vF1EEMbUIAQz/J5C8ttyGYC01GFX1w5ZjirwloieQS7CrBt6o64U4Kz
         /kZb99nptwlBsKBe1VaxoNbai0b6LpNxTdcJnC28aYQw0Hsv/kWO9vRr0/f0sSgpB2Eb
         44zA==
X-Gm-Message-State: APjAAAX8IKPEw3GzhW0gTcCuXyAKeAXeVC6m2dtsXaEFs99Gzo7ik+8p
        GOA7vAtMWJMYPKQcH32IPAA=
X-Google-Smtp-Source: APXvYqy5181QHaD6yrquflT4EtdVXCqq7ShuMm/sqJtoI/XvqBTYh+CtBc45wy+FlX6DSPUb2UXlLw==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr3966604wrm.207.1555701259628;
        Fri, 19 Apr 2019 12:14:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id z18sm8131149wrr.90.2019.04.19.12.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:14:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/5] ASoC: sun4i-spdif: Add support for H6 SoC
Date:   Fri, 19 Apr 2019 21:17:27 +0200
Message-Id: <20190419191730.9437-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419191730.9437-1-peron.clem@gmail.com>
References: <20190419191730.9437-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 has a different mapping for the fifo register controller.

Actually only the fifo tx flush bit is used.

Add a new quirk to know the correct fifo tx flush bit.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b4af4aabead1..19e4bf9caa24 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -75,6 +75,18 @@
 	#define SUN4I_SPDIF_FCTL_RXOM(v)		((v) << 0)
 	#define SUN4I_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
 
+#define SUN50I_H6_SPDIF_FCTL (0x14)
+	#define SUN50I_H6_SPDIF_FCTL_HUB_EN		BIT(31)
+	#define SUN50I_H6_SPDIF_FCTL_FTX		BIT(30)
+	#define SUN50I_H6_SPDIF_FCTL_FRX		BIT(29)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL(v)		((v) << 12)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL_MASK		GENMASK(19, 12)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL(v)		((v) << 4)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL_MASK		GENMASK(10, 4)
+	#define SUN50I_H6_SPDIF_FCTL_TXIM		BIT(2)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM(v)		((v) << 0)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
+
 #define SUN4I_SPDIF_FSTA	(0x18)
 	#define SUN4I_SPDIF_FSTA_TXE			BIT(14)
 	#define SUN4I_SPDIF_FSTA_TXECNTSHT		(8)
@@ -169,16 +181,25 @@ struct sun4i_spdif_dev {
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	const struct sun4i_spdif_quirks *quirks;
+};
+
+struct sun4i_spdif_quirks {
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	unsigned int reg_fctl_ftx;	/* TX FIFO flush bitmask */
+	bool has_reset;
 };
 
 static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
 {
+	const struct sun4i_spdif_quirks *quirks = host->quirks;
+
 	/* soft reset SPDIF */
 	regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
 
 	/* flush TX FIFO */
 	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
-			   SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
+			   quirks->reg_fctl_ftx, quirks->reg_fctl_ftx);
 
 	/* clear TX counter */
 	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
@@ -405,22 +426,26 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
-struct sun4i_spdif_quirks {
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 };
 
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
 };
 
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
+	.has_reset	= true,
+};
+
+static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks = {
+	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN50I_H6_SPDIF_FCTL_FTX,
 	.has_reset	= true,
 };
 
@@ -437,6 +462,10 @@ static const struct of_device_id sun4i_spdif_of_match[] = {
 		.compatible = "allwinner,sun8i-h3-spdif",
 		.data = &sun8i_h3_spdif_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-spdif",
+		.data = &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
@@ -501,6 +530,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
+	host->quirks = quirks;
 
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 						&sun4i_spdif_regmap_config);
-- 
2.17.1

