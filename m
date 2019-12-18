Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A27DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E56A24650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699543;
	bh=YyT3NJ4YyOYjOmvTZNqmxU2XNLGcMGTc2Xb3hLbbNTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UKYvAbLBEI0Kra9TWKHFUOtD2VYgBLjfS0GW476uS3frMUhYcZudHurflpf89bcN+
	 NyVTGu+kufQ4mpMAfrU5sEHiuuzUsmGlrQKzYbID99GMjCo9B3DIrzDwjgHQF8q84s
	 XK14Si6Fwx43U6pfAjM6AIolEjnAyKT1Iidhdg0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfLRUFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:05:42 -0500
Received: from foss.arm.com ([217.140.110.172]:59280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLRUFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:05:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8369611FB;
        Wed, 18 Dec 2019 12:05:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3F263F67D;
        Wed, 18 Dec 2019 12:05:39 -0800 (PST)
Date:   Wed, 18 Dec 2019 20:05:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-fifo: improve depth handling" to the asoc tree
In-Reply-To: <20191218172420.1199117-4-jbrunet@baylibre.com>
Message-Id: <applied-20191218172420.1199117-4-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: axg-fifo: improve depth handling

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 23b89e1d62c75f2c1985449e968886e8a97860c0 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 18 Dec 2019 18:24:19 +0100
Subject: [PATCH] ASoC: meson: axg-fifo: improve depth handling

Let the fifo driver parse the fifo depth from DT. Eventually all DT should
have this property. Until it is actually the case, default to 256 bytes if
the property is missing. 256 bytes is the size of the smallest fifo on the
supported SoCs.

On the supported SoC, fifo A is usually bigger than the other ones.  With
depth known, we can improve the usage of the fifo and adapt the setup of
request threshold.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20191218172420.1199117-4-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.c  | 19 +++++++++++++++++--
 sound/soc/meson/axg-fifo.h  |  1 +
 sound/soc/meson/axg-frddr.c | 13 ++++---------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 4365086c9a31..c2742a02d866 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -132,8 +132,7 @@ int axg_fifo_pcm_hw_params(struct snd_soc_component *component,
 	 * - Half the fifo size
 	 * - Half the period size
 	 */
-	threshold = min(period / 2,
-			(unsigned int)AXG_FIFO_MIN_DEPTH / 2);
+	threshold = min(period / 2, fifo->depth / 2);
 
 	/*
 	 * With the threshold in bytes, register value is:
@@ -320,6 +319,7 @@ int axg_fifo_probe(struct platform_device *pdev)
 	const struct axg_fifo_match_data *data;
 	struct axg_fifo *fifo;
 	void __iomem *regs;
+	int ret;
 
 	data = of_device_get_match_data(dev);
 	if (!data) {
@@ -370,6 +370,21 @@ int axg_fifo_probe(struct platform_device *pdev)
 	if (IS_ERR(fifo->field_threshold))
 		return PTR_ERR(fifo->field_threshold);
 
+	ret = of_property_read_u32(dev->of_node, "amlogic,fifo-depth",
+				   &fifo->depth);
+	if (ret) {
+		/* Error out for anything but a missing property */
+		if (ret != -EINVAL)
+			return ret;
+		/*
+		 * If the property is missing, it might be because of an old
+		 * DT. In such case, assume the smallest known fifo depth
+		 */
+		fifo->depth = 256;
+		dev_warn(dev, "fifo depth not found, assume %u bytes\n",
+			 fifo->depth);
+	}
+
 	return devm_snd_soc_register_component(dev, data->component_drv,
 					       data->dai_drv, 1);
 }
diff --git a/sound/soc/meson/axg-fifo.h b/sound/soc/meson/axg-fifo.h
index c442195ba191..521b54e98fd3 100644
--- a/sound/soc/meson/axg-fifo.h
+++ b/sound/soc/meson/axg-fifo.h
@@ -68,6 +68,7 @@ struct axg_fifo {
 	struct clk *pclk;
 	struct reset_control *arb;
 	struct regmap_field *field_threshold;
+	unsigned int depth;
 	int irq;
 };
 
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index df104303351f..c3ae8ac30745 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -50,7 +50,7 @@ static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
-	unsigned int fifo_depth;
+	unsigned int val;
 	int ret;
 
 	/* Enable pclk to access registers and clock the fifo ip */
@@ -61,15 +61,10 @@ static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
 	/* Apply single buffer mode to the interface */
 	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_FRDDR_PP_MODE, 0);
 
-	/*
-	 * TODO: We could adapt the fifo depth and the fifo threshold
-	 * depending on the expected memory throughput and lantencies
-	 * For now, we'll just use the same values as the vendor kernel
-	 * Depth and threshold are zero based.
-	 */
-	fifo_depth = AXG_FIFO_MIN_CNT - 1;
+	/* Use all fifo depth */
+	val = (fifo->depth / AXG_FIFO_BURST) - 1;
 	regmap_update_bits(fifo->map, FIFO_CTRL1, CTRL1_FRDDR_DEPTH_MASK,
-			   CTRL1_FRDDR_DEPTH(fifo_depth));
+			   CTRL1_FRDDR_DEPTH(val));
 
 	return 0;
 }
-- 
2.20.1

