Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8322C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD45120818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfEOQ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:29:03 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:59389 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfEOQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:29:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E5A0C3F9CD;
        Wed, 15 May 2019 18:28:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LKUIXh2AJKhb; Wed, 15 May 2019 18:28:59 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 181213F50A;
        Wed, 15 May 2019 18:28:58 +0200 (CEST)
Date:   Wed, 15 May 2019 18:28:58 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Message-ID: <20190515162858.GB17162@sx9>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
 <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lauretniu,

> I think that any recent kernel will do, so I'd say your current branch 
> should be fine.

The kernel oopses with "unable to handle kernel paging request at virtual
address 000aba0b" in hcd_alloc_coherent via usb_hcd_map_urb_for_dma. This
relates to patch 2/3 that I didn't quite understand, where

-	retval = dma_declare_coherent_memory(dev, mem->start,
-					 mem->start - mem->parent->start,
-					 resource_size(mem));

becomes

+	retval = gen_pool_add_virt(hcd->localmem_pool,
+				   (unsigned long)mem->start -
+					mem->parent->start,
+				   mem->start, resource_size(mem),

so that arguments two and three switch places. Given

int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
				dma_addr_t device_addr, size_t size);

and

int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, phys_addr_t phys
		 size_t size, int nid)

it seems that the device address (dma_addr_t device_addr) now becomes a
virtual address (unsigned long virt). Is that intended?

My corresponding patch is below for reference. I applied your 1/3 patch
to test it.

Fredrik

diff --git a/drivers/usb/host/ohci-ps2.c b/drivers/usb/host/ohci-ps2.c
--- a/drivers/usb/host/ohci-ps2.c
+++ b/drivers/usb/host/ohci-ps2.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/usb.h>
@@ -92,12 +93,12 @@ static irqreturn_t ohci_ps2_irq(struct usb_hcd *hcd)
 	return ohci_irq(hcd); /* Call normal IRQ handler. */
 }
 
-static int iopheap_alloc_coherent(struct platform_device *pdev,
-	size_t size, int flags)
+static int iopheap_alloc_coherent(struct platform_device *pdev, size_t size)
 {
 	struct device *dev = &pdev->dev;
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ps2_hcd *ps2priv = hcd_to_priv(hcd);
+	int err;
 
 	if (ps2priv->iop_dma_addr != 0)
 		return 0;
@@ -112,28 +113,37 @@ static int iopheap_alloc_coherent(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	if (dma_declare_coherent_memory(dev,
-			iop_bus_to_phys(ps2priv->iop_dma_addr),
-			ps2priv->iop_dma_addr, size, flags)) {
-		dev_err(dev, "dma_declare_coherent_memory failed\n");
-		iop_free(ps2priv->iop_dma_addr);
-		ps2priv->iop_dma_addr = 0;
-		return -ENOMEM;
+	hcd->localmem_pool = devm_gen_pool_create(dev,
+		PAGE_SHIFT, dev_to_node(dev), DRV_NAME);
+	if (IS_ERR(hcd->localmem_pool)) {
+		err = PTR_ERR(hcd->localmem_pool);
+		goto out_err;
+	}
+
+	err = gen_pool_add_virt(hcd->localmem_pool, ps2priv->iop_dma_addr,
+		iop_bus_to_phys(ps2priv->iop_dma_addr), size, dev_to_node(dev));
+	if (err < 0) {
+		dev_err(dev, "gen_pool_add_virt failed with %d\n", err);
+		goto out_err;
 	}
 
 	return 0;
+
+out_err:
+	iop_free(ps2priv->iop_dma_addr);
+	ps2priv->iop_dma_addr = 0;
+
+	return err;
 }
 
 static void iopheap_free_coherent(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ps2_hcd *ps2priv = hcd_to_priv(hcd);
 
 	if (ps2priv->iop_dma_addr == 0)
 		return;
 
-	dma_release_declared_memory(dev);
 	iop_free(ps2priv->iop_dma_addr);
 	ps2priv->iop_dma_addr = 0;
 }
@@ -177,8 +187,7 @@ static int ohci_hcd_ps2_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = iopheap_alloc_coherent(pdev,
-		DMA_BUFFER_SIZE, DMA_MEMORY_EXCLUSIVE);
+	ret = iopheap_alloc_coherent(pdev, DMA_BUFFER_SIZE);
 	if (ret != 0)
 		goto err_alloc_coherent;
 
