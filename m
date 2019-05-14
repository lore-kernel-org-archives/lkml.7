Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DCFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfENOiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:38:18 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49652 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfENOiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:38:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BDB961A0125;
        Tue, 14 May 2019 16:38:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B1A931A00C2;
        Tue, 14 May 2019 16:38:12 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2190E2061C;
        Tue, 14 May 2019 16:38:12 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH v2 3/3] usb: host: ohci-tmio: init genalloc for local memory
Date:   Tue, 14 May 2019 17:38:07 +0300
Message-Id: <20190514143807.7745-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
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
 drivers/usb/host/ohci-tmio.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index f88a0370659f..34869382618f 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -30,6 +30,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
 #include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -224,11 +225,6 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
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
@@ -239,6 +235,20 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	ohci = hcd_to_ohci(hcd);
 	ohci_hcd_init(ohci);
 
+	hcd->localmem_pool = devm_gen_pool_create(&dev->dev, PAGE_SHIFT,
+						  dev_to_node(&dev->dev),
+						  "ohci-sm501");
+	if (IS_ERR(hcd->localmem_pool)) {
+		ret = PTR_ERR(hcd->localmem_pool);
+		goto err_enable;
+	}
+	ret = gen_pool_add_virt(hcd->localmem_pool, sram->start, sram->start,
+				resource_size(sram), dev_to_node(&dev->dev));
+	if (ret < 0) {
+		dev_err(&dev->dev, "failed to add to pool: %d\n", ret);
+		goto err_enable;
+	}
+
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret)
 		goto err_add_hcd;
@@ -254,8 +264,6 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	if (cell->disable)
 		cell->disable(dev);
 err_enable:
-	dma_release_declared_memory(&dev->dev);
-err_dma_declare:
 	iounmap(hcd->regs);
 err_ioremap_regs:
 	iounmap(tmio->ccr);
@@ -276,7 +284,6 @@ static int ohci_hcd_tmio_drv_remove(struct platform_device *dev)
 	tmio_stop_hc(dev);
 	if (cell->disable)
 		cell->disable(dev);
-	dma_release_declared_memory(&dev->dev);
 	iounmap(hcd->regs);
 	iounmap(tmio->ccr);
 	usb_put_hcd(hcd);
-- 
2.17.1

