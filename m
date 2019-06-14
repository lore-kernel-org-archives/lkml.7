Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4117AC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C67F20665
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpKlmYjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfFNKJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:09:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfFNKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g4CAW3NudoykJFfkyn65GSdlgF0nSBFHfKWtyc/R7zQ=; b=rpKlmYjP9iaaORVtk2izSDRgnx
        iiULshu26x21YLnj8XoijsDDszNVdO9baSchFQoszy8Bx80J6GMpPXV1pnVzlwz+a9ce2nKimnIM8
        gQ/ycF5NS5S2PF9PXYnHu+mZWbPxQ7riyURH+Zs4Gk2n7hjjkrNIaHELt+218z8r6WVKq2FExmfq6
        jYfcwrYPu51cPdFT1O0RmH2StkJXtyH2+G7JXjyuChIrnqpBxrVYZ2xJCNv2B0ScGjTAboU63Y6BM
        cRb7bvEBXLynnZXolRSjwYyHyyMy2h6YOfrda82TODR9G8g+KN04DPh7Gh+1uwOWeG2+jOXET9Fdy
        WCk8Fprg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbj9L-0007uf-AT; Fri, 14 Jun 2019 10:09:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: use the generic remapping allocator for coherent DMA allocations
Date:   Fri, 14 Jun 2019 12:09:28 +0200
Message-Id: <20190614100928.9791-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614100928.9791-1-hch@lst.de>
References: <20190614100928.9791-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the code that sets up uncached PTEs with the generic vmap based
remapping code.  It also provides an atomic pool for allocations from
non-blocking context, which we not properly supported by the existing
nds32 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/Kconfig      |   2 +
 arch/nds32/kernel/dma.c | 325 ++--------------------------------------
 2 files changed, 13 insertions(+), 314 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 3299e287a477..643ea6b4bfa2 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -7,12 +7,14 @@
 config NDS32
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_WANT_FRAME_POINTERS if FTRACE
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index d0dbd4fe9645..490e3720d694 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -3,327 +3,13 @@
 
 #include <linux/types.h>
 #include <linux/mm.h>
-#include <linux/string.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/io.h>
 #include <linux/cache.h>
 #include <linux/highmem.h>
-#include <linux/slab.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/proc-fns.h>
 
-/*
- * This is the page table (2MB) covering uncached, DMA consistent allocations
- */
-static pte_t *consistent_pte;
-static DEFINE_RAW_SPINLOCK(consistent_lock);
-
-/*
- * VM region handling support.
- *
- * This should become something generic, handling VM region allocations for
- * vmalloc and similar (ioremap, module space, etc).
- *
- * I envisage vmalloc()'s supporting vm_struct becoming:
- *
- *  struct vm_struct {
- *    struct vm_region	region;
- *    unsigned long	flags;
- *    struct page	**pages;
- *    unsigned int	nr_pages;
- *    unsigned long	phys_addr;
- *  };
- *
- * get_vm_area() would then call vm_region_alloc with an appropriate
- * struct vm_region head (eg):
- *
- *  struct vm_region vmalloc_head = {
- *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
- *	.vm_start	= VMALLOC_START,
- *	.vm_end		= VMALLOC_END,
- *  };
- *
- * However, vmalloc_head.vm_start is variable (typically, it is dependent on
- * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
- * would have to initialise this each time prior to calling vm_region_alloc().
- */
-struct arch_vm_region {
-	struct list_head vm_list;
-	unsigned long vm_start;
-	unsigned long vm_end;
-	struct page *vm_pages;
-};
-
-static struct arch_vm_region consistent_head = {
-	.vm_list = LIST_HEAD_INIT(consistent_head.vm_list),
-	.vm_start = CONSISTENT_BASE,
-	.vm_end = CONSISTENT_END,
-};
-
-static struct arch_vm_region *vm_region_alloc(struct arch_vm_region *head,
-					      size_t size, int gfp)
-{
-	unsigned long addr = head->vm_start, end = head->vm_end - size;
-	unsigned long flags;
-	struct arch_vm_region *c, *new;
-
-	new = kmalloc(sizeof(struct arch_vm_region), gfp);
-	if (!new)
-		goto out;
-
-	raw_spin_lock_irqsave(&consistent_lock, flags);
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if ((addr + size) < addr)
-			goto nospc;
-		if ((addr + size) <= c->vm_start)
-			goto found;
-		addr = c->vm_end;
-		if (addr > end)
-			goto nospc;
-	}
-
-found:
-	/*
-	 * Insert this entry _before_ the one we found.
-	 */
-	list_add_tail(&new->vm_list, &c->vm_list);
-	new->vm_start = addr;
-	new->vm_end = addr + size;
-
-	raw_spin_unlock_irqrestore(&consistent_lock, flags);
-	return new;
-
-nospc:
-	raw_spin_unlock_irqrestore(&consistent_lock, flags);
-	kfree(new);
-out:
-	return NULL;
-}
-
-static struct arch_vm_region *vm_region_find(struct arch_vm_region *head,
-					     unsigned long addr)
-{
-	struct arch_vm_region *c;
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if (c->vm_start == addr)
-			goto out;
-	}
-	c = NULL;
-out:
-	return c;
-}
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t gfp, unsigned long attrs)
-{
-	struct page *page;
-	struct arch_vm_region *c;
-	unsigned long order;
-	u64 mask = ~0ULL, limit;
-	pgprot_t prot = pgprot_noncached(PAGE_KERNEL);
-
-	if (!consistent_pte) {
-		pr_err("%s: not initialized\n", __func__);
-		dump_stack();
-		return NULL;
-	}
-
-	if (dev) {
-		mask = dev->coherent_dma_mask;
-
-		/*
-		 * Sanity check the DMA mask - it must be non-zero, and
-		 * must be able to be satisfied by a DMA allocation.
-		 */
-		if (mask == 0) {
-			dev_warn(dev, "coherent DMA mask is unset\n");
-			goto no_page;
-		}
-
-	}
-
-	/*
-	 * Sanity check the allocation size.
-	 */
-	size = PAGE_ALIGN(size);
-	limit = (mask + 1) & ~mask;
-	if ((limit && size >= limit) ||
-	    size >= (CONSISTENT_END - CONSISTENT_BASE)) {
-		pr_warn("coherent allocation too big "
-			"(requested %#x mask %#llx)\n", size, mask);
-		goto no_page;
-	}
-
-	order = get_order(size);
-
-	if (mask != 0xffffffff)
-		gfp |= GFP_DMA;
-
-	page = alloc_pages(gfp, order);
-	if (!page)
-		goto no_page;
-
-	/*
-	 * Invalidate any data that might be lurking in the
-	 * kernel direct-mapped region for device DMA.
-	 */
-	{
-		unsigned long kaddr = (unsigned long)page_address(page);
-		memset(page_address(page), 0, size);
-		cpu_dma_wbinval_range(kaddr, kaddr + size);
-	}
-
-	/*
-	 * Allocate a virtual address in the consistent mapping region.
-	 */
-	c = vm_region_alloc(&consistent_head, size,
-			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
-	if (c) {
-		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
-		struct page *end = page + (1 << order);
-
-		c->vm_pages = page;
-
-		/*
-		 * Set the "dma handle"
-		 */
-		*handle = page_to_phys(page);
-
-		do {
-			BUG_ON(!pte_none(*pte));
-
-			/*
-			 * x86 does not mark the pages reserved...
-			 */
-			SetPageReserved(page);
-			set_pte(pte, mk_pte(page, prot));
-			page++;
-			pte++;
-		} while (size -= PAGE_SIZE);
-
-		/*
-		 * Free the otherwise unused pages.
-		 */
-		while (page < end) {
-			__free_page(page);
-			page++;
-		}
-
-		return (void *)c->vm_start;
-	}
-
-	if (page)
-		__free_pages(page, order);
-no_page:
-	*handle = ~0;
-	return NULL;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
-{
-	struct arch_vm_region *c;
-	unsigned long flags, addr;
-	pte_t *ptep;
-
-	size = PAGE_ALIGN(size);
-
-	raw_spin_lock_irqsave(&consistent_lock, flags);
-
-	c = vm_region_find(&consistent_head, (unsigned long)cpu_addr);
-	if (!c)
-		goto no_area;
-
-	if ((c->vm_end - c->vm_start) != size) {
-		pr_err("%s: freeing wrong coherent size (%ld != %d)\n",
-		       __func__, c->vm_end - c->vm_start, size);
-		dump_stack();
-		size = c->vm_end - c->vm_start;
-	}
-
-	ptep = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
-	addr = c->vm_start;
-	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-		unsigned long pfn;
-
-		ptep++;
-		addr += PAGE_SIZE;
-
-		if (!pte_none(pte) && pte_present(pte)) {
-			pfn = pte_pfn(pte);
-
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-
-				/*
-				 * x86 does not mark the pages reserved...
-				 */
-				ClearPageReserved(page);
-
-				__free_page(page);
-				continue;
-			}
-		}
-
-		pr_crit("%s: bad page in kernel page table\n", __func__);
-	} while (size -= PAGE_SIZE);
-
-	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-
-	list_del(&c->vm_list);
-
-	raw_spin_unlock_irqrestore(&consistent_lock, flags);
-
-	kfree(c);
-	return;
-
-no_area:
-	raw_spin_unlock_irqrestore(&consistent_lock, flags);
-	pr_err("%s: trying to free invalid coherent area: %p\n",
-	       __func__, cpu_addr);
-	dump_stack();
-}
-
-/*
- * Initialise the consistent memory allocation.
- */
-static int __init consistent_init(void)
-{
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte;
-	int ret = 0;
-
-	do {
-		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
-		pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
-		if (!pmd) {
-			pr_err("%s: no pmd tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-		/* The first level mapping may be created in somewhere.
-		 * It's not necessary to warn here. */
-		/* WARN_ON(!pmd_none(*pmd)); */
-
-		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
-		if (!pte) {
-			ret = -ENOMEM;
-			break;
-		}
-
-		consistent_pte = pte;
-	} while (0);
-
-	return ret;
-}
-
-core_initcall(consistent_init);
-
 static inline void cache_op(phys_addr_t paddr, size_t size,
 		void (*fn)(unsigned long start, unsigned long end))
 {
@@ -389,3 +75,14 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		BUG();
 	}
 }
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	cache_op(page_to_phys(page), size, cpu_dma_wbinval_range);
+}
+
+static int __init atomic_pool_init(void)
+{
+	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
+}
+postcore_initcall(atomic_pool_init);
-- 
2.20.1

