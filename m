Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF1C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60F208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r4Z4dOuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfHNOD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:03:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfHNODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OnB2aFi9jernLfeJN8ohC84xz7kH7vzGEDzqV1C1Fx0=; b=r4Z4dOuyC70Etv8ifKSuvtoq0A
        Gj1wG3AMnNfIZkhK3ZLSprm5/PT0eB0Pbq2IT6n24Hmn80vHNxq1zOtuF1U3CHSTGGN4Om9N8X40v
        4lZtwTUCmuCX0H+p9dsbPdtRPSaf+0jnS4FlrSRlQ2JpQP+DMF424VQR5jxPp61q1tWq3z9f99K0q
        e4t7rr2h+S+2dL5ZGZj4+dW7skdTOla9DJ9eAmaTp5/W2XTswytTcS4RWxV7ALR3gORYD0UnEvZsG
        izakcRKVQEHkmvlSaDA2O75EQQ8bCSfwCcx1jd/VED2Mr3Z2wuUuPS8ELu+JBrpeedq2svtRUGrvM
        M+Kew6VQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxtsX-00013E-Pd; Wed, 14 Aug 2019 14:03:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <monstr@monstr.eu>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] microblaze/nommu: use the generic uncached segment support
Date:   Wed, 14 Aug 2019 16:03:47 +0200
Message-Id: <20190814140348.3339-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814140348.3339-1-hch@lst.de>
References: <20190814140348.3339-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop providing our own arch alloc/free hooks for nommu platforms and
just expose the segment offset and use the generic dma-direct
allocator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/Kconfig         |  2 +
 arch/microblaze/mm/consistent.c | 93 +++++++++++++++------------------
 2 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d411de05b628..a0d749c309f3 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -5,9 +5,11 @@ config MICROBLAZE
 	select ARCH_NO_SWAP
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_DMA_COHERENT_TO_PFN if MMU
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_UNCACHED_SEGMENT if !MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index bc7042209c57..1a859e8b58c2 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -42,21 +42,48 @@
 #include <asm/cpuinfo.h>
 #include <asm/tlbflush.h>
 
-#ifndef CONFIG_MMU
-/* I have to use dcache values because I can't relate on ram size */
-# define UNCACHED_SHADOW_MASK (cpuinfo.dcache_high - cpuinfo.dcache_base + 1)
-#endif
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	phys_addr_t paddr = page_to_phys(page);
+
+	flush_dcache_range(paddr, paddr + size);
+}
 
+#ifndef CONFIG_MMU
 /*
- * Consistent memory allocators. Used for DMA devices that want to
- * share uncached memory with the processor core.
- * My crufty no-MMU approach is simple. In the HW platform we can optionally
- * mirror the DDR up above the processor cacheable region.  So, memory accessed
- * in this mirror region will not be cached.  It's alloced from the same
- * pool as normal memory, but the handle we return is shifted up into the
- * uncached region.  This will no doubt cause big problems if memory allocated
- * here is not also freed properly. -- JW
+ * Consistent memory allocators. Used for DMA devices that want to share
+ * uncached memory with the processor core.  My crufty no-MMU approach is
+ * simple.  In the HW platform we can optionally mirror the DDR up above the
+ * processor cacheable region.  So, memory accessed in this mirror region will
+ * not be cached.  It's alloced from the same pool as normal memory, but the
+ * handle we return is shifted up into the uncached region.  This will no doubt
+ * cause big problems if memory allocated here is not also freed properly. -- JW
+ *
+ * I have to use dcache values because I can't relate on ram size:
  */
+#ifdef CONFIG_XILINX_UNCACHED_SHADOW
+#define UNCACHED_SHADOW_MASK (cpuinfo.dcache_high - cpuinfo.dcache_base + 1)
+#else
+#define UNCACHED_SHADOW_MASK 0
+#endif /* CONFIG_XILINX_UNCACHED_SHADOW */
+
+void *uncached_kernel_address(void *ptr)
+{
+	unsigned long addr = (unsigned long)ptr;
+
+	addr |= UNCACHED_SHADOW_MASK;
+	if (addr > cpuinfo.dcache_base && addr < cpuinfo.dcache_high)
+		pr_warn("ERROR: Your cache coherent area is CACHED!!!\n");
+	return (void *)addr;
+}
+
+void *cached_kernel_address(void *ptr)
+{
+	unsigned long addr = (unsigned long)ptr;
+
+	return (void *)(addr & ~UNCACHED_SHADOW_MASK);
+}
+#else /* CONFIG_MMU */
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
@@ -64,12 +91,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	void *ret;
 	unsigned int i, err = 0;
 	struct page *page, *end;
-
-#ifdef CONFIG_MMU
 	phys_addr_t pa;
 	struct vm_struct *area;
 	unsigned long va;
-#endif
 
 	if (in_interrupt())
 		BUG();
@@ -86,26 +110,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * we need to ensure that there are no cachelines in use,
 	 * or worse dirty in this area.
 	 */
-	flush_dcache_range(virt_to_phys((void *)vaddr),
-					virt_to_phys((void *)vaddr) + size);
-
-#ifndef CONFIG_MMU
-	ret = (void *)vaddr;
-	/*
-	 * Here's the magic!  Note if the uncached shadow is not implemented,
-	 * it's up to the calling code to also test that condition and make
-	 * other arranegments, such as manually flushing the cache and so on.
-	 */
-# ifdef CONFIG_XILINX_UNCACHED_SHADOW
-	ret = (void *)((unsigned) ret | UNCACHED_SHADOW_MASK);
-# endif
-	if ((unsigned int)ret > cpuinfo.dcache_base &&
-				(unsigned int)ret < cpuinfo.dcache_high)
-		pr_warn("ERROR: Your cache coherent area is CACHED!!!\n");
+	arch_dma_prep_coherent(virt_to_page((unsigned long)vaddr), size);
 
-	/* dma_handle is same as physical (shadowed) address */
-	*dma_handle = (dma_addr_t)ret;
-#else
 	/* Allocate some common virtual space to map the new pages. */
 	area = get_vm_area(size, VM_ALLOC);
 	if (!area) {
@@ -117,7 +123,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	/* This gives us the real physical address of the first page. */
 	*dma_handle = pa = __virt_to_phys(vaddr);
-#endif
 
 	/*
 	 * free wasted pages.  We skip the first page since we know
@@ -131,10 +136,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	split_page(page, order);
 
 	for (i = 0; i < size && err == 0; i += PAGE_SIZE) {
-#ifdef CONFIG_MMU
 		/* MS: This is the whole magic - use cache inhibit pages */
 		err = map_page(va + i, pa + i, _PAGE_KERNEL | _PAGE_NO_CACHE);
-#endif
 
 		SetPageReserved(page);
 		page++;
@@ -154,7 +157,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	return ret;
 }
 
-#ifdef CONFIG_MMU
 static pte_t *consistent_virt_to_pte(void *vaddr)
 {
 	unsigned long addr = (unsigned long)vaddr;
@@ -172,7 +174,6 @@ long arch_dma_coherent_to_pfn(struct device *dev, void *vaddr,
 
 	return pte_pfn(*ptep);
 }
-#endif
 
 /*
  * free page(s) as defined by the above mapping.
@@ -187,18 +188,6 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 
 	size = PAGE_ALIGN(size);
 
-#ifndef CONFIG_MMU
-	/* Clear SHADOW_MASK bit in address, and free as per usual */
-# ifdef CONFIG_XILINX_UNCACHED_SHADOW
-	vaddr = (void *)((unsigned)vaddr & ~UNCACHED_SHADOW_MASK);
-# endif
-	page = virt_to_page(vaddr);
-
-	do {
-		__free_reserved_page(page);
-		page++;
-	} while (size -= PAGE_SIZE);
-#else
 	do {
 		pte_t *ptep = consistent_virt_to_pte(vaddr);
 		unsigned long pfn;
@@ -216,5 +205,5 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 
 	/* flush tlb */
 	flush_tlb_all();
-#endif
 }
+#endif /* CONFIG_MMU */
-- 
2.20.1

