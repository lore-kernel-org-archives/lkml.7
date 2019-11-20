Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210C0208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574270289;
	bh=74MQo8uTJrD5w1g4U3XnjkFNVMJHleB9EPewvE2uqeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=SC2lUm7VVUjHKFGcWilswA6b+YNDk5NQp8dSUYS1DyO9S3HxGwv/ZGbFQjcWrvRLV
	 Hf6DoEgr/ZNQ6r3AfPTlpnhppgw1A3TwD1YQNUTWYDe1X7/KtTL7lfJ2yQqBN/hVA3
	 9y4MHWVT9Q/3yhmmLMZdRgENgHsIfJiOGMo+1GKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfKTRSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:18:08 -0500
Received: from foss.arm.com ([217.140.110.172]:43292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbfKTRSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF7781045;
        Wed, 20 Nov 2019 09:18:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 199333F703;
        Wed, 20 Nov 2019 09:18:05 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:18:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh+dt@kernel.org
Subject: Applied "ASoC: pcm3168a: Update the RST gpio handling to align with documentation" to the asoc tree
In-Reply-To: <20191120131753.6831-3-peter.ujfalusi@ti.com>
Message-Id: <applied-20191120131753.6831-3-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3168a: Update the RST gpio handling to align with documentation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 4ec48e7cbe6e70352c802b5cb172b00ebd8af8e0 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 20 Nov 2019 15:17:53 +0200
Subject: [PATCH] ASoC: pcm3168a: Update the RST gpio handling to align with
 documentation

The RST (reset-gpios) is low active so the driver must handle it
accordingly.

Add comments to explain clearly how the line is used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191120131753.6831-3-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index f3475134b519..9711fab296eb 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -707,11 +707,15 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 	dev_set_drvdata(dev, pcm3168a);
 
 	/*
-	 * Request the RST gpio line as non exclusive as the same reset line
-	 * might be connected to multiple pcm3168a codec
+	 * Request the reset (connected to RST pin) gpio line as non exclusive
+	 * as the same reset line might be connected to multiple pcm3168a codec
+	 *
+	 * The RST is low active, we want the GPIO line to be high initially, so
+	 * request the initial level to LOW which in practice means DEASSERTED:
+	 * The deasserted level of GPIO_ACTIVE_LOW is HIGH.
 	 */
-	pcm3168a->gpio_rst = devm_gpiod_get_optional(dev, "rst",
-						GPIOD_OUT_HIGH |
+	pcm3168a->gpio_rst = devm_gpiod_get_optional(dev, "reset",
+						GPIOD_OUT_LOW |
 						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(pcm3168a->gpio_rst)) {
 		ret = PTR_ERR(pcm3168a->gpio_rst);
@@ -814,7 +818,13 @@ void pcm3168a_remove(struct device *dev)
 {
 	struct pcm3168a_priv *pcm3168a = dev_get_drvdata(dev);
 
-	gpiod_set_value_cansleep(pcm3168a->gpio_rst, 0);
+	/*
+	 * The RST is low active, we want the GPIO line to be low when the
+	 * driver is removed, so set level to 1 which in practice means
+	 * ASSERTED:
+	 * The asserted level of GPIO_ACTIVE_LOW is LOW.
+	 */
+	gpiod_set_value_cansleep(pcm3168a->gpio_rst, 1);
 	pm_runtime_disable(dev);
 #ifndef CONFIG_PM
 	pcm3168a_disable(dev);
-- 
2.20.1

