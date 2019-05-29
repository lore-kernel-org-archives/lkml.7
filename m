Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34844C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B10F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfE2K3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:29:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51944 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfE2K2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:28:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A7B42003F5;
        Wed, 29 May 2019 12:28:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B9872003E8;
        Wed, 29 May 2019 12:28:53 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E0403205E4;
        Wed, 29 May 2019 12:28:52 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v7 5/5] USB: drop HCD_LOCAL_MEM flag
Date:   Wed, 29 May 2019 13:28:43 +0300
Message-Id: <20190529102843.13174-6-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

With the addition of the local memory allocator, the HCD_LOCAL_MEM
flag can be dropped and the checks against it replaced with a check
for the localmem_pool ptr being initialized.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Tested-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/usb/core/buffer.c      |  8 +++-----
 drivers/usb/core/hcd.c         | 15 ++++++---------
 drivers/usb/host/ehci-hcd.c    |  2 +-
 drivers/usb/host/fotg210-hcd.c |  2 +-
 drivers/usb/host/ohci-hcd.c    |  2 +-
 drivers/usb/host/ohci-sm501.c  |  5 +++--
 drivers/usb/host/ohci-tmio.c   |  2 +-
 drivers/usb/host/uhci-hcd.c    |  2 +-
 include/linux/usb/hcd.h        |  1 -
 9 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index d2064ad7ad14..1359b78a624e 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -68,7 +68,7 @@ int hcd_buffer_create(struct usb_hcd *hcd)
 
 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
 	    (!is_device_dma_capable(hcd->self.sysdev) &&
-	     !(hcd->driver->flags & HCD_LOCAL_MEM)))
+	     !hcd->localmem_pool))
 		return 0;
 
 	for (i = 0; i < HCD_BUFFER_POOLS; i++) {
@@ -130,8 +130,7 @@ void *hcd_buffer_alloc(
 
 	/* some USB hosts just use PIO */
 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
-	    (!is_device_dma_capable(bus->sysdev) &&
-	     !(hcd->driver->flags & HCD_LOCAL_MEM))) {
+	    !is_device_dma_capable(bus->sysdev)) {
 		*dma = ~(dma_addr_t) 0;
 		return kmalloc(size, mem_flags);
 	}
@@ -162,8 +161,7 @@ void hcd_buffer_free(
 	}
 
 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
-	    (!is_device_dma_capable(bus->sysdev) &&
-	     !(hcd->driver->flags & HCD_LOCAL_MEM))) {
+	    !is_device_dma_capable(bus->sysdev)) {
 		kfree(addr);
 		return;
 	}
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 29b96e5e8621..fe631d18c1ed 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1347,14 +1347,14 @@ EXPORT_SYMBOL_GPL(usb_hcd_unlink_urb_from_ep);
  * using regular system memory - like pci devices doing bus mastering.
  *
  * To support host controllers with limited dma capabilities we provide dma
- * bounce buffers. This feature can be enabled using the HCD_LOCAL_MEM flag.
+ * bounce buffers. This feature can be enabled by initializing
+ * hcd->localmem_pool using usb_hcd_setup_local_mem().
  * For this to work properly the host controller code must first use the
  * function dma_declare_coherent_memory() to point out which memory area
  * that should be used for dma allocations.
  *
- * The HCD_LOCAL_MEM flag then tells the usb code to allocate all data for
- * dma using dma_alloc_coherent() which in turn allocates from the memory
- * area pointed out with dma_declare_coherent_memory().
+ * The initialized hcd->localmem_pool then tells the usb code to allocate all
+ * data for dma using the genalloc API.
  *
  * So, to summarize...
  *
@@ -1364,9 +1364,6 @@ EXPORT_SYMBOL_GPL(usb_hcd_unlink_urb_from_ep);
  *   (a) "normal" kernel memory is no good, and
  *   (b) there's not enough to share
  *
- * - The only *portable* hook for such stuff in the
- *   DMA framework is dma_declare_coherent_memory()
- *
  * - So we use that, even though the primary requirement
  *   is that the memory be "local" (hence addressable
  *   by that device), not "coherent".
@@ -1533,7 +1530,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 						urb->setup_dma))
 				return -EAGAIN;
 			urb->transfer_flags |= URB_SETUP_MAP_SINGLE;
-		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
+		} else if (hcd->localmem_pool) {
 			ret = hcd_alloc_coherent(
 					urb->dev->bus, mem_flags,
 					&urb->setup_dma,
@@ -1603,7 +1600,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 				else
 					urb->transfer_flags |= URB_DMA_MAP_SINGLE;
 			}
-		} else if (hcd->driver->flags & HCD_LOCAL_MEM) {
+		} else if (hcd->localmem_pool) {
 			ret = hcd_alloc_coherent(
 					urb->dev->bus, mem_flags,
 					&urb->transfer_dma,
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index cdafa97f632d..9da7e22848c9 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -559,7 +559,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	ehci->command = temp;
 
 	/* Accept arbitrarily long scatter-gather lists */
-	if (!(hcd->driver->flags & HCD_LOCAL_MEM))
+	if (!hcd->localmem_pool)
 		hcd->self.sg_tablesize = ~0;
 
 	/* Prepare for unlinking active QHs */
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 0da68df259c8..5d74ff61fa4c 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -4995,7 +4995,7 @@ static int hcd_fotg210_init(struct usb_hcd *hcd)
 	fotg210->command = temp;
 
 	/* Accept arbitrarily long scatter-gather lists */
-	if (!(hcd->driver->flags & HCD_LOCAL_MEM))
+	if (!hcd->localmem_pool)
 		hcd->self.sg_tablesize = ~0;
 	return 0;
 }
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index b200b19b44fa..5801858d867e 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -448,7 +448,7 @@ static int ohci_init (struct ohci_hcd *ohci)
 	struct usb_hcd *hcd = ohci_to_hcd(ohci);
 
 	/* Accept arbitrarily long scatter-gather lists */
-	if (!(hcd->driver->flags & HCD_LOCAL_MEM))
+	if (!hcd->localmem_pool)
 		hcd->self.sg_tablesize = ~0;
 
 	if (distrust_firmware)
diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index b710e100aec9..c158cda9e4b9 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -49,7 +49,7 @@ static const struct hc_driver ohci_sm501_hc_driver = {
 	 * generic hardware linkage
 	 */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY | HCD_LOCAL_MEM,
+	.flags =		HCD_USB11 | HCD_MEMORY,
 
 	/*
 	 * basic lifecycle operations
@@ -153,7 +153,8 @@ static int ohci_hcd_sm501_drv_probe(struct platform_device *pdev)
 	 * fine. This is however not always the case - buffers may be allocated
 	 * using kmalloc() - so the usb core needs to be told that it must copy
 	 * data into our local memory if the buffers happen to be placed in
-	 * regular memory. The HCD_LOCAL_MEM flag does just that.
+	 * regular memory. A non-null hcd->localmem_pool initialized by the
+	 * the call to usb_hcd_setup_local_mem() below does just that.
 	 */
 
 	if (usb_hcd_setup_local_mem(hcd, mem->start,
diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index 3b84ce0c3f29..d5a293a707b6 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -153,7 +153,7 @@ static const struct hc_driver ohci_tmio_hc_driver = {
 
 	/* generic hardware linkage */
 	.irq =			ohci_irq,
-	.flags =		HCD_USB11 | HCD_MEMORY | HCD_LOCAL_MEM,
+	.flags =		HCD_USB11 | HCD_MEMORY,
 
 	/* basic lifecycle operations */
 	.start =		ohci_tmio_start,
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index 98deb5f64268..03bc59755123 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -581,7 +581,7 @@ static int uhci_start(struct usb_hcd *hcd)
 
 	hcd->uses_new_polling = 1;
 	/* Accept arbitrarily long scatter-gather lists */
-	if (!(hcd->driver->flags & HCD_LOCAL_MEM))
+	if (!hcd->localmem_pool)
 		hcd->self.sg_tablesize = ~0;
 
 	spin_lock_init(&uhci->lock);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 127560a4bfa0..bab27ccc8ff5 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -256,7 +256,6 @@ struct hc_driver {
 
 	int	flags;
 #define	HCD_MEMORY	0x0001		/* HC regs use memory (else I/O) */
-#define	HCD_LOCAL_MEM	0x0002		/* HC needs local memory */
 #define	HCD_SHARED	0x0004		/* Two (or more) usb_hcds share HW */
 #define	HCD_USB11	0x0010		/* USB 1.1 */
 #define	HCD_USB2	0x0020		/* USB 2.0 */
-- 
2.17.1

