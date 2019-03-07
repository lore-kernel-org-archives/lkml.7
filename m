Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB7BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698F320840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lucaceresoli.net header.i=@lucaceresoli.net header.b="LupqCHjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCGVpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:45:39 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:41516 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbfCGVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lucaceresoli.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rsh6BhT6oukTkXVwHMyJA5fk2HrJW5LY1ddIEavTgPI=; b=LupqCHjZg1lu9shiLM2pzmx9aS
        aXpaW9oeWOOV+rlF9pMECEMspDCiBTekUyJiH6BxzwcKCnmljzYIPouudf7TC13pebG+ybaS2YC0p
        /JYBiT/mZbc07zCOPgnOxkjHlwnfSmR/BAool3FLvkvc+DyRnw8hOsbRugQZWZyRkqxQ=;
Received: from [88.147.86.226] (port=35048 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1h20pW-0017NM-PW; Thu, 07 Mar 2019 22:45:31 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: axi-i2s: let both capture and playback be optional
Date:   Thu,  7 Mar 2019 22:44:55 +0100
Message-Id: <20190307214456.16445-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the capture and playback channels are optional in the axi_i2s IP
block. Reflect this in the driver by enabling only the channel(s) that
have a DMA.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 sound/soc/adi/axi-i2s.c | 68 +++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
index 4c23381727a1..273c543e8ff3 100644
--- a/sound/soc/adi/axi-i2s.c
+++ b/sound/soc/adi/axi-i2s.c
@@ -43,6 +43,9 @@ struct axi_i2s {
 	struct clk *clk;
 	struct clk *clk_ref;
 
+	bool   has_capture;
+	bool   has_playback;
+
 	struct snd_soc_dai_driver dai_driver;
 
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
@@ -136,8 +139,10 @@ static int axi_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
-	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
-		&i2s->capture_dma_data);
+	snd_soc_dai_init_dma_data(
+		dai,
+		i2s->has_playback ? &i2s->playback_dma_data : NULL,
+		i2s->has_capture  ? &i2s->capture_dma_data  : NULL);
 
 	return 0;
 }
@@ -151,18 +156,6 @@ static const struct snd_soc_dai_ops axi_i2s_dai_ops = {
 
 static struct snd_soc_dai_driver axi_i2s_dai = {
 	.probe = axi_i2s_dai_probe,
-	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE,
-	},
-	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE,
-	},
 	.ops = &axi_i2s_dai_ops,
 	.symmetric_rates = 1,
 };
@@ -178,6 +171,19 @@ static const struct regmap_config axi_i2s_regmap_config = {
 	.max_register = AXI_I2S_REG_STATUS,
 };
 
+static void axi_i2s_parse_of(struct axi_i2s *i2s, const struct device_node *np)
+{
+	struct property *dma_names;
+	const char *dma_name;
+
+	of_property_for_each_string(np, "dma-names", dma_names, dma_name) {
+		if (strcmp(dma_name, "rx") == 0)
+			i2s->has_capture = true;
+		if (strcmp(dma_name, "tx") == 0)
+			i2s->has_playback = true;
+	}
+}
+
 static int axi_i2s_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -191,6 +197,8 @@ static int axi_i2s_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2s);
 
+	axi_i2s_parse_of(i2s, pdev->dev.of_node);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
@@ -213,13 +221,29 @@ static int axi_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	i2s->playback_dma_data.addr = res->start + AXI_I2S_REG_TX_FIFO;
-	i2s->playback_dma_data.addr_width = 4;
-	i2s->playback_dma_data.maxburst = 1;
+	if (i2s->has_playback) {
+		axi_i2s_dai.playback.channels_min = 2;
+		axi_i2s_dai.playback.channels_max = 2;
+		axi_i2s_dai.playback.rates = SNDRV_PCM_RATE_KNOT;
+		axi_i2s_dai.playback.formats =
+			SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE;
+
+		i2s->playback_dma_data.addr = res->start + AXI_I2S_REG_TX_FIFO;
+		i2s->playback_dma_data.addr_width = 4;
+		i2s->playback_dma_data.maxburst = 1;
+	}
+
+	if (i2s->has_capture) {
+		axi_i2s_dai.capture.channels_min = 2;
+		axi_i2s_dai.capture.channels_max = 2;
+		axi_i2s_dai.capture.rates = SNDRV_PCM_RATE_KNOT;
+		axi_i2s_dai.capture.formats =
+			SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_U32_LE;
 
-	i2s->capture_dma_data.addr = res->start + AXI_I2S_REG_RX_FIFO;
-	i2s->capture_dma_data.addr_width = 4;
-	i2s->capture_dma_data.maxburst = 1;
+		i2s->capture_dma_data.addr = res->start + AXI_I2S_REG_RX_FIFO;
+		i2s->capture_dma_data.addr_width = 4;
+		i2s->capture_dma_data.maxburst = 1;
+	}
 
 	i2s->ratnum.num = clk_get_rate(i2s->clk_ref) / 2 / AXI_I2S_BITS_PER_FRAME;
 	i2s->ratnum.den_step = 1;
@@ -240,6 +264,10 @@ static int axi_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
+	dev_info(&pdev->dev, "probed, capture %s, playback %s\n",
+		 i2s->has_capture ? "enabled" : "disabled",
+		 i2s->has_playback ? "enabled" : "disabled");
+
 	return 0;
 
 err_clk_disable:
-- 
2.17.1

