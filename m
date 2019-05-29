Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE30C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0C220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfE2K26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:28:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51894 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfE2K2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:28:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5290E200296;
        Wed, 29 May 2019 12:28:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41A1B2003F2;
        Wed, 29 May 2019 12:28:52 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B6867205E4;
        Wed, 29 May 2019 12:28:51 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local memory
Date:   Wed, 29 May 2019 13:28:41 +0300
Message-Id: <20190529102843.13174-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
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
 drivers/usb/host/ohci-sm501.c | 47 +++++++++++++++--------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index c26228c25f99..b710e100aec9 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -110,40 +110,18 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	/* The sm501 chip is equipped with local memory that may be used
-	 * by on-chip devices such as the video controller and the usb host.
-	 * This driver uses dma_declare_coherent_memory() to make sure
-	 * usb allocations with dma_alloc_coherent() allocate from
-	 * this local memory. The dma_handle returned by dma_alloc_coherent()
-	 * will be an offset starting from 0 for the first local memory byte.
-	 *
-	 * So as long as data is allocated using dma_alloc_coherent() all is
-	 * fine. This is however not always the case - buffers may be allocated
-	 * using kmalloc() - so the usb core needs to be told that it must copy
-	 * data into our local memory if the buffers happen to be placed in
-	 * regular memory. The HCD_LOCAL_MEM flag does just that.
-	 */
-
-	retval = dma_declare_coherent_memory(dev, mem->start,
-					 mem->start - mem->parent->start,
-					 resource_size(mem));
-	if (retval) {
-		dev_err(dev, "cannot declare coherent memory\n");
-		goto err1;
-	}
-
 	/* allocate, reserve and remap resources for registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(dev, "no resource definition for registers\n");
 		retval = -ENOENT;
-		goto err2;
+		goto err1;
 	}
 
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		retval = -ENOMEM;
-		goto err2;
+		goto err1;
 	}
 
 	hcd->rsrc_start = res->start;
@@ -164,6 +142,24 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
+	/* The sm501 chip is equipped with local memory that may be used
+	 * by on-chip devices such as the video controller and the usb host.
+	 * This driver uses genalloc so that usb allocations with
+	 * gen_pool_dma_alloc() allocate from this local memory. The dma_handle
+	 * returned by gen_pool_dma_alloc() will be an offset starting from 0
+	 * for the first local memory byte.
+	 *
+	 * So as long as data is allocated using gen_pool_dma_alloc() all is
+	 * fine. This is however not always the case - buffers may be allocated
+	 * using kmalloc() - so the usb core needs to be told that it must copy
+	 * data into our local memory if the buffers happen to be placed in
+	 * regular memory. The HCD_LOCAL_MEM flag does just that.
+	 */
+
+	if (usb_hcd_setup_local_mem(hcd, mem->start,
+				    mem->start - mem->parent->start,
+				    resource_size(mem)) < 0)
+		goto err5;
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval)
 		goto err5;
@@ -181,8 +177,6 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err3:
 	usb_put_hcd(hcd);
-err2:
-	dma_release_declared_memory(dev);
 err1:
 	release_mem_region(mem->start, resource_size(mem));
 err0:
@@ -197,7 +191,6 @@ static int ohci_hcd_sm501_drv_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
-	dma_release_declared_memory(&pdev->dev);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (mem)
 		release_mem_region(mem->start, resource_size(mem));
-- 
2.17.1

