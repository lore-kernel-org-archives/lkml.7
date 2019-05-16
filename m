Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA7C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF7820848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfEPLuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:50:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44416 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfEPLt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:49:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A77782001F2;
        Thu, 16 May 2019 13:49:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 998B7200061;
        Thu, 16 May 2019 13:49:56 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 19A7F205CD;
        Thu, 16 May 2019 13:49:56 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v4 3/3] usb: host: ohci-tmio: init genalloc for local memory
Date:   Thu, 16 May 2019 14:47:21 +0300
Message-Id: <20190516114721.27694-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516114721.27694-1-laurentiu.tudor@nxp.com>
References: <20190516114721.27694-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

In preparation for dropping the existing "coherent" dma mem declaration
APIs, replace the current dma_declare_coherent_memory() based mechanism
with the creation of a genalloc pool that will be used in the OHCI
subsystem as replacement for the DMA APIs.

For context, see thread here: https://lkml.org/lkml/2019/4/22/357

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/usb/host/ohci-tmio.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index f88a0370659f..1c39099b9870 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -30,6 +30,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
 #include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -188,6 +189,7 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	struct resource *config = platform_get_resource(dev, IORESOURCE_MEM, 1);
 	struct resource *sram = platform_get_resource(dev, IORESOURCE_MEM, 2);
 	int irq = platform_get_irq(dev, 0);
+	void __iomem *local_mem;
 	struct tmio_hcd *tmio;
 	struct ohci_hcd *ohci;
 	struct usb_hcd *hcd;
@@ -224,11 +226,6 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 		goto err_ioremap_regs;
 	}
 
-	ret = dma_declare_coherent_memory(&dev->dev, sram->start, sram->start,
-				resource_size(sram));
-	if (ret)
-		goto err_dma_declare;
-
 	if (cell->enable) {
 		ret = cell->enable(dev);
 		if (ret)
@@ -239,6 +236,28 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	ohci = hcd_to_ohci(hcd);
 	ohci_hcd_init(ohci);
 
+	hcd->localmem_pool = devm_gen_pool_create(&dev->dev, PAGE_SHIFT,
+						  dev_to_node(&dev->dev),
+						  "ohci-sm501");
+	if (IS_ERR(hcd->localmem_pool)) {
+		ret = PTR_ERR(hcd->localmem_pool);
+		goto err_enable;
+	}
+
+	local_mem = devm_ioremap(&dev->dev, sram->start, resource_size(sram));
+	if (!local_mem) {
+		ret = -ENOMEM;
+		goto err_enable;
+	}
+
+	ret = gen_pool_add_virt(hcd->localmem_pool, (unsigned long)local_mem,
+				sram->start, resource_size(sram),
+				dev_to_node(&dev->dev));
+	if (ret < 0) {
+		dev_err(&dev->dev, "failed to add to pool: %d\n", ret);
+		goto err_enable;
+	}
+
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret)
 		goto err_add_hcd;
@@ -254,8 +273,6 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	if (cell->disable)
 		cell->disable(dev);
 err_enable:
-	dma_release_declared_memory(&dev->dev);
-err_dma_declare:
 	iounmap(hcd->regs);
 err_ioremap_regs:
 	iounmap(tmio->ccr);
@@ -276,7 +293,6 @@ static int ohci_hcd_tmio_drv_remove(struct platform_device *dev)
 	tmio_stop_hc(dev);
 	if (cell->disable)
 		cell->disable(dev);
-	dma_release_declared_memory(&dev->dev);
 	iounmap(hcd->regs);
 	iounmap(tmio->ccr);
 	usb_put_hcd(hcd);
-- 
2.17.1

