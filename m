Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA23BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963C320863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfEVO2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:28:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42224 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbfEVO14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:27:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 29B851A002A;
        Wed, 22 May 2019 16:27:53 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C2061A000F;
        Wed, 22 May 2019 16:27:53 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FD43205ED;
        Wed, 22 May 2019 16:27:52 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v6 2/5] USB: use genalloc for USB HCs with local memory
Date:   Wed, 22 May 2019 17:27:45 +0300
Message-Id: <20190522142748.10078-3-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522142748.10078-1-laurentiu.tudor@nxp.com>
References: <20190522142748.10078-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

For HCs that have local memory, replace the current DMA API usage
with a genalloc generic allocator to manage the mappings for these
devices. To help users, introduce a new HCD API,
usb_hcd_setup_local_mem() that will setup up the genalloc backing
up the device local memory. It will be used in subsequent patches.
This is in preparation for dropping the existing "coherent" dma
mem declaration APIs. Current implementation was relying on a short
circuit in the DMA API that in the end, was acting as an allocator
for these type of devices.

For context, see thread here: https://lkml.org/lkml/2019/4/22/357

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Tested-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/usb/core/buffer.c   |  9 +++++++++
 drivers/usb/core/hcd.c      | 36 ++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c | 23 ++++++++++++++++++-----
 drivers/usb/host/ohci-mem.c | 35 +++++++++++++++++++++++++++++++----
 drivers/usb/host/ohci.h     |  2 ++
 include/linux/usb/hcd.h     |  5 +++++
 6 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index f641342cdec0..d2064ad7ad14 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/genalloc.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
@@ -124,6 +125,9 @@ void *hcd_buffer_alloc(
 	if (size == 0)
 		return NULL;
 
+	if (hcd->localmem_pool)
+		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
+
 	/* some USB hosts just use PIO */
 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
 	    (!is_device_dma_capable(bus->sysdev) &&
@@ -152,6 +156,11 @@ void hcd_buffer_free(
 	if (!addr)
 		return;
 
+	if (hcd->localmem_pool) {
+		gen_pool_free(hcd->localmem_pool, (unsigned long)addr, size);
+		return;
+	}
+
 	if (!IS_ENABLED(CONFIG_HAS_DMA) ||
 	    (!is_device_dma_capable(bus->sysdev) &&
 	     !(hcd->driver->flags & HCD_LOCAL_MEM))) {
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 94d22551fc1b..1aad11f4142c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -29,6 +29,8 @@
 #include <linux/workqueue.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
 
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
@@ -3039,6 +3041,40 @@ usb_hcd_platform_shutdown(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(usb_hcd_platform_shutdown);
 
+int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
+			    dma_addr_t dma, size_t size)
+{
+	int err;
+	void __iomem *local_mem;
+
+	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, PAGE_SHIFT,
+						  dev_to_node(hcd->self.sysdev),
+						  dev_name(hcd->self.sysdev));
+	if (IS_ERR(hcd->localmem_pool))
+		return PTR_ERR(hcd->localmem_pool);
+
+	local_mem = devm_memremap(hcd->self.sysdev, phys_addr,
+				  size, MEMREMAP_WC);
+	if (!local_mem)
+		return -ENOMEM;
+
+	/*
+	 * Here we pass a dma_addr_t but the arg type is a phys_addr_t.
+	 * It's not backed by system memory and thus there's no kernel mapping
+	 * for it.
+	 */
+	err = gen_pool_add_virt(hcd->localmem_pool, (unsigned long)local_mem,
+				dma, size, dev_to_node(hcd->self.sysdev));
+	if (err < 0) {
+		dev_err(hcd->self.sysdev, "gen_pool_add_virt failed with %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_hcd_setup_local_mem);
+
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_USB_MON)
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 210181fd98d2..b200b19b44fa 100644
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
+	if (hcd->localmem_pool)
+		ohci->hcca = gen_pool_dma_alloc(hcd->localmem_pool,
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
+		if (hcd->localmem_pool)
+			gen_pool_free(hcd->localmem_pool,
+				      (unsigned long)ohci->hcca,
+				      sizeof(*ohci->hcca));
+		else
+			dma_free_coherent(hcd->self.controller,
+					  sizeof(*ohci->hcca),
+					  ohci->hcca, ohci->hcca_dma);
 		ohci->hcca = NULL;
 		ohci->hcca_dma = 0;
 	}
diff --git a/drivers/usb/host/ohci-mem.c b/drivers/usb/host/ohci-mem.c
index 3965ac0341eb..4afe27cc7e46 100644
--- a/drivers/usb/host/ohci-mem.c
+++ b/drivers/usb/host/ohci-mem.c
@@ -36,6 +36,13 @@ static void ohci_hcd_init (struct ohci_hcd *ohci)
 
 static int ohci_mem_init (struct ohci_hcd *ohci)
 {
+	/*
+	 * HCs with local memory allocate from localmem_pool so there's
+	 * no need to create the below dma pools.
+	 */
+	if (ohci_to_hcd(ohci)->localmem_pool)
+		return 0;
+
 	ohci->td_cache = dma_pool_create ("ohci_td",
 		ohci_to_hcd(ohci)->self.controller,
 		sizeof (struct td),
@@ -84,8 +91,12 @@ td_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 {
 	dma_addr_t	dma;
 	struct td	*td;
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 
-	td = dma_pool_zalloc (hc->td_cache, mem_flags, &dma);
+	if (hcd->localmem_pool)
+		td = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*td), &dma);
+	else
+		td = dma_pool_zalloc(hc->td_cache, mem_flags, &dma);
 	if (td) {
 		/* in case hc fetches it, make it look dead */
 		td->hwNextTD = cpu_to_hc32 (hc, dma);
@@ -99,6 +110,7 @@ static void
 td_free (struct ohci_hcd *hc, struct td *td)
 {
 	struct td	**prev = &hc->td_hash [TD_HASH_FUNC (td->td_dma)];
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 
 	while (*prev && *prev != td)
 		prev = &(*prev)->td_hash;
@@ -106,7 +118,12 @@ td_free (struct ohci_hcd *hc, struct td *td)
 		*prev = td->td_hash;
 	else if ((td->hwINFO & cpu_to_hc32(hc, TD_DONE)) != 0)
 		ohci_dbg (hc, "no hash for td %p\n", td);
-	dma_pool_free (hc->td_cache, td, td->td_dma);
+
+	if (hcd->localmem_pool)
+		gen_pool_free(hcd->localmem_pool, (unsigned long)td,
+			      sizeof(*td));
+	else
+		dma_pool_free(hc->td_cache, td, td->td_dma);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -117,8 +134,12 @@ ed_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 {
 	dma_addr_t	dma;
 	struct ed	*ed;
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 
-	ed = dma_pool_zalloc (hc->ed_cache, mem_flags, &dma);
+	if (hcd->localmem_pool)
+		ed = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*ed), &dma);
+	else
+		ed = dma_pool_zalloc(hc->ed_cache, mem_flags, &dma);
 	if (ed) {
 		INIT_LIST_HEAD (&ed->td_list);
 		ed->dma = dma;
@@ -129,6 +150,12 @@ ed_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 static void
 ed_free (struct ohci_hcd *hc, struct ed *ed)
 {
-	dma_pool_free (hc->ed_cache, ed, ed->dma);
+	struct usb_hcd	*hcd = ohci_to_hcd(hc);
+
+	if (hcd->localmem_pool)
+		gen_pool_free(hcd->localmem_pool, (unsigned long)ed,
+			      sizeof(*ed));
+	else
+		dma_pool_free(hc->ed_cache, ed, ed->dma);
 }
 
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index ef4813bfc5bf..b015b00774b2 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -385,6 +385,8 @@ struct ohci_hcd {
 
 	/*
 	 * memory management for queue data structures
+	 *
+	 * @td_cache and @ed_cache are %NULL if &usb_hcd.localmem_pool is used.
 	 */
 	struct dma_pool		*td_cache;
 	struct dma_pool		*ed_cache;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index bb57b5af4700..127560a4bfa0 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -216,6 +216,9 @@ struct usb_hcd {
 #define	HC_IS_RUNNING(state) ((state) & __ACTIVE)
 #define	HC_IS_SUSPENDED(state) ((state) & __SUSPEND)
 
+	/* memory pool for HCs having local memory, or %NULL */
+	struct gen_pool         *localmem_pool;
+
 	/* more shared queuing code would be good; it should support
 	 * smarter scheduling, handle transaction translators, etc;
 	 * input size of periodic table to an interrupt scheduler.
@@ -461,6 +464,8 @@ extern int usb_add_hcd(struct usb_hcd *hcd,
 		unsigned int irqnum, unsigned long irqflags);
 extern void usb_remove_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
+int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
+			    dma_addr_t dma, size_t size);
 
 struct platform_device;
 extern void usb_hcd_platform_shutdown(struct platform_device *dev);
-- 
2.17.1

