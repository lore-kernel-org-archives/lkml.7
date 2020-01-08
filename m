Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FFC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993532075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578499153;
	bh=M8Efk+Kl/y4LUkh97tx1+ikISIgGhyF/L7v9YGJuQpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Zu7To3Ch8CWRsvh/NPGxrO0xCRJUiqmp1YD1QZsCJ77oMaJdhGoKHZZubSGEBQQLb
	 z8S3PTQW/r5wyxw1CW+SDSz/b7UFurqBXA7O+hNlKt/203q7fdIrYKk1jS7NcNPXpI
	 mFCwkiHhdNmsJzMF8SXvQQvlWoKO2CCHi6JA1v+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAHP7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:59:12 -0500
Received: from foss.arm.com ([217.140.110.172]:46698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgAHP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:59:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C05F328;
        Wed,  8 Jan 2020 07:59:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 178C73F534;
        Wed,  8 Jan 2020 07:59:09 -0800 (PST)
Date:   Wed, 08 Jan 2020 15:59:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: Applied "spi: rspi: Add support for GPIO chip selects" to the spi tree
In-Reply-To: <20200102133822.29346-7-geert+renesas@glider.be>
Message-Id: <applied-20200102133822.29346-7-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rspi: Add support for GPIO chip selects

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From 144d8f9781e60d89dfd614210d2cedbefbba8885 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 2 Jan 2020 14:38:22 +0100
Subject: [PATCH] spi: rspi: Add support for GPIO chip selects

Add support for GPIO chip selects using GPIO descriptors.  As the RSPI
controller always drives a native chip select when performing a
transfer, at least one native chip select must be left unused.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20200102133822.29346-7-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 2f5a856a9319..85575d45901c 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -242,6 +242,7 @@ struct spi_ops {
 	u16 mode_bits;
 	u16 flags;
 	u16 fifo_size;
+	u8 num_hw_ss;
 };
 
 /*
@@ -934,7 +935,8 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 		rspi->spcmd |= SPCMD_CPHA;
 
 	/* Configure slave signal to assert */
-	rspi->spcmd |= SPCMD_SSLA(spi->chip_select);
+	rspi->spcmd |= SPCMD_SSLA(spi->cs_gpiod ? rspi->ctlr->unused_native_cs
+						: spi->chip_select);
 
 	/* CMOS output mode and MOSI signal from previous transfer */
 	rspi->sppcr = 0;
@@ -1123,6 +1125,7 @@ static const struct spi_ops rspi_ops = {
 	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,
+	.num_hw_ss =		2,
 };
 
 static const struct spi_ops rspi_rz_ops = {
@@ -1131,6 +1134,7 @@ static const struct spi_ops rspi_rz_ops = {
 	.mode_bits =		SPI_CPHA | SPI_CPOL | SPI_LOOP,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		8,	/* 8 for TX, 32 for RX */
+	.num_hw_ss =		1,
 };
 
 static const struct spi_ops qspi_ops = {
@@ -1141,6 +1145,7 @@ static const struct spi_ops qspi_ops = {
 				SPI_RX_DUAL | SPI_RX_QUAD,
 	.flags =		SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX,
 	.fifo_size =		32,
+	.num_hw_ss =		1,
 };
 
 #ifdef CONFIG_OF
@@ -1256,6 +1261,8 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = ops->mode_bits;
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->max_native_cs = rspi->ops->num_hw_ss;
 
 	ret = platform_get_irq_byname_optional(pdev, "rx");
 	if (ret < 0) {
-- 
2.20.1

