Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF720854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCRPji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:39:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:3163 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfCRPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:39:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 08:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="153416287"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2019 08:39:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7F00FA; Mon, 18 Mar 2019 17:39:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: idma64: Use actual device for DMA transfers
Date:   Mon, 18 Mar 2019 18:39:30 +0300
Message-Id: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel IOMMU, when enabled, tries to find the domain of the device,
assuming it's a PCI one, during DMA operations, such as mapping or
unmapping. Since we are splitting the actual PCI device to couple of
children via MFD framework (see drivers/mfd/intel-lpss.c for details),
the DMA device appears to be a platform one, and thus not an actual one
that performs DMA. In a such situation IOMMU can't find or allocate
a proper domain for its operations. As a result, all DMA operations are
failed.

In order to fix this, supply parent of the platform device
to the DMA engine framework and fix filter functions accordingly.

We may rely on the fact that parent is a real PCI device, because no
other configuration is present in the wild.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/idma64.c              | 6 ++++--
 drivers/dma/idma64.h              | 2 ++
 drivers/spi/spi-pxa2xx.c          | 7 +------
 drivers/tty/serial/8250/8250_dw.c | 4 ++--
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 0baf9797cc09..83796a33dc16 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -592,7 +592,7 @@ static int idma64_probe(struct idma64_chip *chip)
 	idma64->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	idma64->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
-	idma64->dma.dev = chip->dev;
+	idma64->dma.dev = chip->sysdev;
 
 	dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
 
@@ -632,6 +632,7 @@ static int idma64_platform_probe(struct platform_device *pdev)
 {
 	struct idma64_chip *chip;
 	struct device *dev = &pdev->dev;
+	struct device *sysdev = dev->parent;
 	struct resource *mem;
 	int ret;
 
@@ -648,11 +649,12 @@ static int idma64_platform_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
-	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
 	if (ret)
 		return ret;
 
 	chip->dev = dev;
+	chip->sysdev = sysdev;
 
 	ret = idma64_probe(chip);
 	if (ret)
diff --git a/drivers/dma/idma64.h b/drivers/dma/idma64.h
index 6b816878e5e7..baa32e1425de 100644
--- a/drivers/dma/idma64.h
+++ b/drivers/dma/idma64.h
@@ -216,12 +216,14 @@ static inline void idma64_writel(struct idma64 *idma64, int offset, u32 value)
 /**
  * struct idma64_chip - representation of iDMA 64-bit controller hardware
  * @dev:		struct device of the DMA controller
+ * @sysdev:		struct device of the physical device that does DMA
  * @irq:		irq line
  * @regs:		memory mapped I/O space
  * @idma64:		struct idma64 that is filed by idma64_probe()
  */
 struct idma64_chip {
 	struct device	*dev;
+	struct device	*sysdev;
 	int		irq;
 	void __iomem	*regs;
 	struct idma64	*idma64;
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b6ddba833d02..5ea70f7d12e7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1487,12 +1487,7 @@ static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
 
 static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 {
-	struct device *dev = param;
-
-	if (dev != chan->device->dev->parent)
-		return false;
-
-	return true;
+	return param == chan->device->dev;
 }
 
 #endif /* CONFIG_PCI */
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d31b975dd3fd..284e8d052fc3 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -365,7 +365,7 @@ static bool dw8250_fallback_dma_filter(struct dma_chan *chan, void *param)
 
 static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 {
-	return param == chan->device->dev->parent;
+	return param == chan->device->dev;
 }
 
 /*
@@ -434,7 +434,7 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 		data->uart_16550_compatible = true;
 	}
 
-	/* Platforms with iDMA */
+	/* Platforms with iDMA 64-bit */
 	if (platform_get_resource_byname(to_platform_device(p->dev),
 					 IORESOURCE_MEM, "lpss_priv")) {
 		data->dma.rx_param = p->dev->parent;
-- 
2.20.1

