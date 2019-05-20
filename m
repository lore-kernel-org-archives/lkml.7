Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F16C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEFF20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392300AbfETPmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:42:13 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:51333 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388878AbfETPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:42:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3D67E3F7AC;
        Mon, 20 May 2019 17:42:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m4YrvbgMd1na; Mon, 20 May 2019 17:41:58 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 251973F7F2;
        Mon, 20 May 2019 17:41:56 +0200 (CEST)
Date:   Mon, 20 May 2019 17:41:56 +0200
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
Message-ID: <20190520154156.GA3664@sx9>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
 <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com>
 <20190515162858.GB17162@sx9>
 <ed63c117-610c-ea49-f45e-727be220745f@nxp.com>
 <20190516151548.GB53952@sx9>
 <5fa97254-3038-6fe7-a7e7-a267262049c6@nxp.com>
 <20190517174159.GA32450@sx9>
 <3c8897e9-218e-3fff-1735-816ffd30e908@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c8897e9-218e-3fff-1735-816ffd30e908@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

> Wow, that's excellent news! Thanks a lot for looking into this.

You are welcome!

> Are you ok if I add your Signed-Off-by and maybe also Tested-by in the 
> first patch of the series?

Yes, but I have two comments:

1. ohci_mem_init() allocates two DMA pools that are no longer relevant, so
   it seems appropriate to assign NULL to ohci->td_cache and ohci->ed_cache,
   and document this exception in struct ohci_hcd. Unless something more
   elegant can be done, of course.

2. A device address is supplied as phys_addr_t phys to gen_pool_add_virt().
   This seems to work in this particular DMA application, but there will be
   problems if someone does phys_to_virt() or suchlike. Can this be improved
   or clearly explained? gen_pool_virt_to_phys() searches in address ranges,
   for example, so it appears the implementation uses phys quite carefully.

> As a side note, I plan to add a new HCD function and name it something 
> like hcd_setup_local_mem() that would take care of setting up the 
> genalloc for drivers.

Good! Then I suppose the HCD_LOCAL_MEM assignment can be removed from the
drivers too? Like this one:

	ohci_ps2_hc_driver.flags |= HCD_LOCAL_MEM;

Regarding the previous HCD IRQ question, lib/genalloc.c says that

	It is safe to use the allocator in NMI handlers and other special
	unblockable contexts that could otherwise deadlock on locks.  This
	is implemented by using atomic operations and retries on any
	conflicts.  The disadvantage is that there may be livelocks in
	extreme cases.  For better scalability, one allocator can be used
	for each CPU.

so it appears to be good enough for USB purposes.

> Yes, I think it would make sense to put the new API in a distinct patch. 
> I think we can either include it in the next version of the patch series 
> or you can submit separately and I'll mention it as dependency for this 
> patch series, however you prefer.

Please find the patch below and if possible include it in your patch series.

Fredrik

lib/genalloc.c: Add gen_pool_dma_zalloc() for zeroed DMA allocations

gen_pool_dma_zalloc() is a zeroed memory variant of gen_pool_dma_alloc().
Document return values of both, and indicate NULL as a "%NULL" constant.

Signed-off-by: Fredrik Noring <noring@nocrew.org>

--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -121,6 +121,8 @@ extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
 		genpool_algo_t algo, void *data);
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
+extern void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size,
+		dma_addr_t *dma);
 extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
 extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -337,12 +337,14 @@ EXPORT_SYMBOL(gen_pool_alloc_algo);
  * gen_pool_dma_alloc - allocate special memory from the pool for DMA usage
  * @pool: pool to allocate from
  * @size: number of bytes to allocate from the pool
- * @dma: dma-view physical address return value.  Use NULL if unneeded.
+ * @dma: dma-view physical address return value.  Use %NULL if unneeded.
  *
  * Allocate the requested number of bytes from the specified pool.
  * Uses the pool allocation function (with first-fit algorithm by default).
  * Can not be used in NMI handler on architectures without
  * NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated memory, or %NULL on failure
  */
 void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 {
@@ -362,6 +364,30 @@ void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
 }
 EXPORT_SYMBOL(gen_pool_dma_alloc);
 
+/**
+ * gen_pool_dma_zalloc - allocate special zeroed memory from the pool for DMA usage
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ * @dma: dma-view physical address return value.  Use %NULL if unneeded.
+ *
+ * Allocate the requested number of zeroed bytes from the specified pool.
+ * Uses the pool allocation function (with first-fit algorithm by default).
+ * Can not be used in NMI handler on architectures without
+ * NMI-safe cmpxchg implementation.
+ *
+ * Return: virtual address of the allocated zeroed memory, or %NULL on failure
+ */
+void *gen_pool_dma_zalloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
+{
+	void *vaddr = gen_pool_dma_alloc(pool, size, dma);
+
+	if (vaddr)
+		memset(vaddr, 0, size);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(gen_pool_dma_zalloc);
+
 /**
  * gen_pool_free - free allocated special memory back to the pool
  * @pool: pool to free to
