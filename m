Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8724DC04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A4D2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfEJO5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:57:06 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49918 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJO4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:56:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E09702001BD;
        Fri, 10 May 2019 16:56:50 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE5352001B1;
        Fri, 10 May 2019 16:56:50 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 70B14205ED;
        Fri, 10 May 2019 16:56:50 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [RFC PATCH 1/3] ohci-hcd: use genalloc for USB HCs with local memory
Date:   Fri, 10 May 2019 17:56:44 +0300
Message-Id: <20190510145646.10078-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510145646.10078-1-laurentiu.tudor@nxp.com>
References: <20190510145646.10078-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

For HCs that have local memory, replace the current DMA API usage
with a genalloc generic allocator to manage the mappings for these
devices.
This is in preparation for dropping the existing "coherent" dma
mem declaration APIs. Current implementation was relying on a short
circuit in the DMA API that in the end, was acting as an allocator
for these type of devices.

For context, see thread here: https://lkml.org/lkml/2019/4/22/357

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/usb/host/ohci-hcd.c | 23 ++++++++++++++++++-----
 drivers/usb/host/ohci.h     |  3 +++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 210181fd98d2..c739d55901b3 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -40,6 +40,7 @@
 #include <linux/dmapool.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
+#include <linux/genalloc.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -505,8 +506,15 @@ static int ohci_init (struct ohci_hcd *ohci)
 	timer_setup(&ohci->io_watchdog, io_watchdog_func, 0);
 	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
-	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
-			sizeof(*ohci->hcca), &ohci->hcca_dma, GFP_KERNEL);
+	if (hcd->driver->flags & HCD_LOCAL_MEM)
+		ohci->hcca = gen_pool_dma_alloc(ohci->localmem_pool,
+						sizeof(*ohci->hcca),
+						&ohci->hcca_dma);
+	else
+		ohci->hcca = dma_alloc_coherent(hcd->self.controller,
+						sizeof(*ohci->hcca),
+						&ohci->hcca_dma,
+						GFP_KERNEL);
 	if (!ohci->hcca)
 		return -ENOMEM;
 
@@ -990,9 +998,14 @@ static void ohci_stop (struct usb_hcd *hcd)
 	remove_debug_files (ohci);
 	ohci_mem_cleanup (ohci);
 	if (ohci->hcca) {
-		dma_free_coherent (hcd->self.controller,
-				sizeof *ohci->hcca,
-				ohci->hcca, ohci->hcca_dma);
+		if (hcd->driver->flags & HCD_LOCAL_MEM)
+			gen_pool_free(ohci->localmem_pool,
+				      (unsigned long)ohci->hcca,
+				      sizeof(*ohci->hcca));
+		else
+			dma_free_coherent(hcd->self.controller,
+					  sizeof(*ohci->hcca),
+					  ohci->hcca, ohci->hcca_dma);
 		ohci->hcca = NULL;
 		ohci->hcca_dma = 0;
 	}
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index ef4813bfc5bf..cd196172c6fd 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -367,6 +367,9 @@ struct ohci_hcd {
 	 */
 	struct ohci_regs __iomem *regs;
 
+	/* allocator for HCs having local memory */
+	struct gen_pool         *localmem_pool;
+
 	/*
 	 * main memory used to communicate with the HC (dma-consistent).
 	 * hcd adds to schedule for a live hc any time, but removals finish
-- 
2.17.1

