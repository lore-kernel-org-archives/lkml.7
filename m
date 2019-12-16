Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D41207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576497982;
	bh=m3qySB6d4BQ73/f7D37dsjzb1n7u1E1K+xkG1Eh5ias=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=W2a1DBU457jr/jaDexbj/VlLqboUewoC2WRlMiefO+1EDX/dGOLXjdOzPX4XrcbQd
	 eoktHV1uPTCAMVAvPFdKQa8ZcZC9Pj6Ej+Z8IvMXRYsgeT6tTr5RFpw+I9fDQuGrof
	 P0yii3td8sjvgrGzD6VoxucpolJmg+gLLaHDpY1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfLPMGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:06:21 -0500
Received: from foss.arm.com ([217.140.110.172]:52620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfLPMGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:06:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79CD1063;
        Mon, 16 Dec 2019 04:06:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 676D43F719;
        Mon, 16 Dec 2019 04:06:18 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:06:17 +0000
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
Subject: Applied "spi: bcm2835: Release the DMA channel if probe fails after dma_init" to the spi tree
In-Reply-To: <20191212135550.4634-3-peter.ujfalusi@ti.com>
Message-Id: <applied-20191212135550.4634-3-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: bcm2835: Release the DMA channel if probe fails after dma_init

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

From 666224b43b4bd4612ce3b758c038f9bc5c5e3fcb Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Dec 2019 15:55:43 +0200
Subject: [PATCH] spi: bcm2835: Release the DMA channel if probe fails after
 dma_init

The DMA channel was not released if either devm_request_irq() or
devm_spi_register_controller() failed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/20191212135550.4634-3-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fb61a620effc..662d55e9f21d 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1327,20 +1327,22 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not request IRQ: %d\n", err);
-		goto out_clk_disable;
+		goto out_dma_release;
 	}
 
 	err = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI controller: %d\n",
 			err);
-		goto out_clk_disable;
+		goto out_dma_release;
 	}
 
 	bcm2835_debugfs_create(bs, dev_name(&pdev->dev));
 
 	return 0;
 
+out_dma_release:
+	bcm2835_dma_release(ctlr, bs);
 out_clk_disable:
 	clk_disable_unprepare(bs->clk);
 out_controller_put:
-- 
2.20.1

