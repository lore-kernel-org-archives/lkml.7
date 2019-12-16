Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA0FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EF121775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576497966;
	bh=kHUYqVqzYd7Qi5YUjoIc9ZrL9hmKNkcB72iqQnrimN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=q5GfMxGEG5cS/m47Wl/9qGduaD89NvDBRNu/+fvy9ZtsUO2cftaZ/wFf8mUqpKYVZ
	 bs0hKMGDD6Zf473m3RUDasnBBLrXDb7f5OBDtDRkYS8UjlDgKDL74WnlfQTe1cIJDv
	 YKDiwvwMFwapnWG7Pd3yRGXUANc27P8qduZUwp0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfLPMGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:06:05 -0500
Received: from foss.arm.com ([217.140.110.172]:52476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfLPMGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:06:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A947D1063;
        Mon, 16 Dec 2019 04:06:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9F513F719;
        Mon, 16 Dec 2019 04:06:02 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:06:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alexandre.torgue@st.com, baohua@kernel.org, broonie@kernel.org,
        f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        nsaenzjulienne@suse.de, rjui@broadcom.com, sbranden@broadcom.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, vkoul@kernel.org
Subject: Applied "spi: stm32-qspi: Use dma_request_chan() instead dma_request_slave_channel()" to the spi tree
In-Reply-To: <20191212135550.4634-9-peter.ujfalusi@ti.com>
Message-Id: <applied-20191212135550.4634-9-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32-qspi: Use dma_request_chan() instead dma_request_slave_channel()

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

From 658606ff4cf680ca97380f6ed7295722b0e991b2 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Dec 2019 15:55:49 +0200
Subject: [PATCH] spi: stm32-qspi: Use dma_request_chan() instead
 dma_request_slave_channel()

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191212135550.4634-9-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 4e726929bb4f..4ef569b47aa6 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -470,10 +470,11 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
+static int stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 {
 	struct dma_slave_config dma_cfg;
 	struct device *dev = qspi->dev;
+	int ret = 0;
 
 	memset(&dma_cfg, 0, sizeof(dma_cfg));
 
@@ -484,8 +485,13 @@ static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 	dma_cfg.src_maxburst = 4;
 	dma_cfg.dst_maxburst = 4;
 
-	qspi->dma_chrx = dma_request_slave_channel(dev, "rx");
-	if (qspi->dma_chrx) {
+	qspi->dma_chrx = dma_request_chan(dev, "rx");
+	if (IS_ERR(qspi->dma_chrx)) {
+		ret = PTR_ERR(qspi->dma_chrx);
+		qspi->dma_chrx = NULL;
+		if (ret == -EPROBE_DEFER)
+			goto out;
+	} else {
 		if (dmaengine_slave_config(qspi->dma_chrx, &dma_cfg)) {
 			dev_err(dev, "dma rx config failed\n");
 			dma_release_channel(qspi->dma_chrx);
@@ -493,8 +499,11 @@ static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 		}
 	}
 
-	qspi->dma_chtx = dma_request_slave_channel(dev, "tx");
-	if (qspi->dma_chtx) {
+	qspi->dma_chtx = dma_request_chan(dev, "tx");
+	if (IS_ERR(qspi->dma_chtx)) {
+		ret = PTR_ERR(qspi->dma_chtx);
+		qspi->dma_chtx = NULL;
+	} else {
 		if (dmaengine_slave_config(qspi->dma_chtx, &dma_cfg)) {
 			dev_err(dev, "dma tx config failed\n");
 			dma_release_channel(qspi->dma_chtx);
@@ -502,7 +511,13 @@ static void stm32_qspi_dma_setup(struct stm32_qspi *qspi)
 		}
 	}
 
+out:
 	init_completion(&qspi->dma_completion);
+
+	if (ret != -EPROBE_DEFER)
+		ret = 0;
+
+	return ret;
 }
 
 static void stm32_qspi_dma_free(struct stm32_qspi *qspi)
@@ -608,7 +623,10 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 	qspi->dev = dev;
 	platform_set_drvdata(pdev, qspi);
-	stm32_qspi_dma_setup(qspi);
+	ret = stm32_qspi_dma_setup(qspi);
+	if (ret)
+		goto err;
+
 	mutex_init(&qspi->lock);
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
-- 
2.20.1

