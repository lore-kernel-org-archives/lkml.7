Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94723C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6373C212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfFXM7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:59:22 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:11206 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfFXM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:59:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 840FE3F669;
        Mon, 24 Jun 2019 14:59:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1ArtfnyGGGGw; Mon, 24 Jun 2019 14:59:18 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 32B2C3F4E9;
        Mon, 24 Jun 2019 14:59:17 +0200 (CEST)
Date:   Mon, 24 Jun 2019 14:59:16 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, laurentiu.tudor@nxp.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190624125916.GA2516@sx9>
References: <20190605214622.GA22254@roeck-us.net>
 <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9>
 <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
 <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
 <20190614142816.GA2574@sx9>
 <20190624063515.GA3296@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624063515.GA3296@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> Can you send me the patch formally so that I can queue it up for the
> dma-mapping tree?

That patch would be detrimental to local memory devices, as previously
discussed, so I would like to suggest a much better approach, as shown below,
where allocations are aligned as required but not necessarily much more than
that.

Fredrik

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -3014,7 +3014,7 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
 	int err;
 	void __iomem *local_mem;
 
-	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, PAGE_SHIFT,
+	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, 4,
 						  dev_to_node(hcd->self.sysdev),
 						  dev_name(hcd->self.sysdev));
 	if (IS_ERR(hcd->localmem_pool))
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -507,9 +507,9 @@ static int ohci_init (struct ohci_hcd *ohci)
 	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	if (hcd->localmem_pool)
-		ohci->hcca = gen_pool_dma_alloc(hcd->localmem_pool,
+		ohci->hcca = gen_pool_dma_alloc_align(hcd->localmem_pool,
 						sizeof(*ohci->hcca),
-						&ohci->hcca_dma);
+						&ohci->hcca_dma, 256);
 	else
 		ohci->hcca = dma_alloc_coherent(hcd->self.controller,
 						sizeof(*ohci->hcca),
diff --git a/drivers/usb/host/ohci-mem.c b/drivers/usb/host/ohci-mem.c
--- a/drivers/usb/host/ohci-mem.c
+++ b/drivers/usb/host/ohci-mem.c
@@ -94,7 +94,8 @@ td_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 
 	if (hcd->localmem_pool)
-		td = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*td), &dma);
+		td = gen_pool_dma_zalloc_align(hcd->localmem_pool,
+				sizeof(*td), &dma, 32);
 	else
 		td = dma_pool_zalloc(hc->td_cache, mem_flags, &dma);
 	if (td) {
@@ -137,7 +138,8 @@ ed_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 
 	if (hcd->localmem_pool)
-		ed = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*ed), &dma);
+		ed = gen_pool_dma_zalloc_align(hcd->localmem_pool,
+				sizeof(*ed), &dma, 16);
 	else
 		ed = dma_pool_zalloc(hc->ed_cache, mem_flags, &dma);
 	if (ed) {
diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -121,7 +121,15 @@ extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
 		genpool_algo_t algo, void *data);
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
-void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
+extern void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data);
+extern void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align);
+extern void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
+extern void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data);
+extern void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
 extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
diff --git a/lib/genalloc.c b/lib/genalloc.c
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -347,13 +347,33 @@ EXPORT_SYMBOL(gen_pool_alloc_algo);
  * Return: virtual address of the allocated memory, or %NULL on failure
  */
 void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
+{
+	return gen_pool_dma_alloc_algo(pool, size, dma, pool->algo, pool->data);
+}
+EXPORT_SYMBOL(gen_pool_dma_alloc);
+
+/**
+ * gen_pool_dma_alloc_algo - allocate special memory from the pool for DMA
+ * usage with the given pool algorithm
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: dma-view physical address return value.  Use NULL if unneeded.
+ * @algo: algorithm passed from caller
+ * @data: data passed to algorithm
+ *
+ * Allocate the requested number of bytes from the specified pool. Uses the
+ * given pool allocation function. Can not be used in NMI handler on
+ * architectures without NMI-safe cmpxchg implementation.
+ */
+void *gen_pool_dma_alloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data)
 {
 	unsigned long vaddr;
 
 	if (!pool)
 		return NULL;
 
-	vaddr = gen_pool_alloc(pool, size);
+	vaddr = gen_pool_alloc_algo(pool, size, algo, data);
 	if (!vaddr)
 		return NULL;
 
@@ -362,7 +382,31 @@ void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 
 	return (void *)vaddr;
 }
-EXPORT_SYMBOL(gen_pool_dma_alloc);
+EXPORT_SYMBOL(gen_pool_dma_alloc_algo);
+
+/**
+ * gen_pool_dma_zalloc_align - allocate special from the pool for DMA usage
+ * with the given alignment
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: dma-view physical address return value.  Use %NULL if unneeded.
+ * @align: alignment in bytes for starting address
+ *
+ * Allocate the requested number bytes from the specified pool, with the given
+ * alignment restriction. Can not be used in NMI handler on architectures
+ * without NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated memory, or %NULL on failure
+ */
+void *gen_pool_dma_alloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align)
+{
+	struct genpool_data_align data = { .align = align };
+
+	return gen_pool_dma_alloc_algo(pool, size, dma,
+			gen_pool_first_fit_align, &data);
+}
+EXPORT_SYMBOL(gen_pool_dma_alloc_align);
 
 /**
  * gen_pool_dma_zalloc - allocate special zeroed memory from the pool for
@@ -380,14 +424,60 @@ EXPORT_SYMBOL(gen_pool_dma_alloc);
  */
 void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 {
-	void *vaddr = gen_pool_dma_alloc(pool, size, dma);
+	return gen_pool_dma_zalloc_algo(pool, size, dma, pool->algo, pool->data);
+}
+EXPORT_SYMBOL(gen_pool_dma_zalloc);
+
+/**
+ * gen_pool_dma_zalloc_algo - allocate special zeroed memory from the pool for
+ * DMA usage with the given pool algorithm
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: dma-view physical address return value.  Use %NULL if unneeded.
+ * @algo: algorithm passed from caller
+ * @data: data passed to algorithm
+ *
+ * Allocate the requested number of zeroed bytes from the specified pool. Uses
+ * the pool allocation function. Can not be used in NMI handler on
+ * architectures without NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated zeroed memory, or %NULL on failure
+ */
+void *gen_pool_dma_zalloc_algo(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, genpool_algo_t algo, void *data)
+{
+	void *vaddr = gen_pool_dma_alloc_algo(pool, size, dma, algo, data);
 
 	if (vaddr)
 		memset(vaddr, 0, size);
 
 	return vaddr;
 }
-EXPORT_SYMBOL(gen_pool_dma_zalloc);
+EXPORT_SYMBOL(gen_pool_dma_zalloc_algo);
+
+/**
+ * gen_pool_dma_zalloc_align - allocate special zeroed memory from the pool for
+ * DMA usage with the given alignment
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: dma-view physical address return value.  Use %NULL if unneeded.
+ * @align: alignment in bytes for starting address
+ *
+ * Allocate the requested number of zeroed bytes from the specified pool,
+ * with the given alignment restriction. Can not be used in NMI handler on
+ * architectures without NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated zeroed memory, or %NULL on failure
+ */
+void *gen_pool_dma_zalloc_align(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma, int align)
+{
+	struct genpool_data_align data = { .align = align };
+
+	return gen_pool_dma_zalloc_algo(pool, size, dma,
+			gen_pool_first_fit_align, &data);
+}
+EXPORT_SYMBOL(gen_pool_dma_zalloc_align);
 
 /**
  * gen_pool_free - free allocated special memory back to the pool
