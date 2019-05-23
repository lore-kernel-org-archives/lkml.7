Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7388C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B198521019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbfEWKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:24:35 -0400
Received: from foss.arm.com ([217.140.101.70]:42666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfEWKYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:24:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3157341;
        Thu, 23 May 2019 03:24:33 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (unknown [10.1.39.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82FE63F718;
        Thu, 23 May 2019 03:24:31 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marc.zyngier@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Nadav Amit <namit@vmware.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 2/4] arm64/mm: wire up CONFIG_ARCH_HAS_SET_DIRECT_MAP
Date:   Thu, 23 May 2019 11:22:54 +0100
Message-Id: <20190523102256.29168-3-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523102256.29168-1-ard.biesheuvel@arm.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the special helper functions to manipulate aliases of vmalloc
regions in the linear map.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cacheflush.h |  3 ++
 arch/arm64/mm/pageattr.c            | 48 ++++++++++++++++----
 mm/vmalloc.c                        | 11 -----
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ca9c175fb949..4ab32180eabd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -26,6 +26,7 @@ config ARM64
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SETUP_DMA_OPS
+	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 19844211a4e6..b9ee5510067f 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -187,4 +187,7 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 
 int set_memory_valid(unsigned long addr, int numpages, int enable);
 
+int set_direct_map_invalid_noflush(struct page *page);
+int set_direct_map_default_noflush(struct page *page);
+
 #endif
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 6cd645edcf35..9c6b9039ec8f 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -159,17 +159,48 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 					__pgprot(PTE_VALID));
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
+int set_direct_map_invalid_noflush(struct page *page)
+{
+	struct page_change_data data = {
+		.set_mask = __pgprot(0),
+		.clear_mask = __pgprot(PTE_VALID),
+	};
+
+	if (!rodata_full)
+		return 0;
+
+	return apply_to_page_range(&init_mm,
+				   (unsigned long)page_address(page),
+				   PAGE_SIZE, change_page_range, &data);
+}
+
+int set_direct_map_default_noflush(struct page *page)
+{
+	struct page_change_data data = {
+		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
+		.clear_mask = __pgprot(PTE_RDONLY),
+	};
+
+	if (!rodata_full)
+		return 0;
+
+	return apply_to_page_range(&init_mm,
+				   (unsigned long)page_address(page),
+				   PAGE_SIZE, change_page_range, &data);
+}
+
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
+	if (!debug_pagealloc_enabled() && !rodata_full)
+		return;
+
 	set_memory_valid((unsigned long)page_address(page), numpages, enable);
 }
-#ifdef CONFIG_HIBERNATION
+
 /*
- * When built with CONFIG_DEBUG_PAGEALLOC and CONFIG_HIBERNATION, this function
- * is used to determine if a linear map page has been marked as not-valid by
- * CONFIG_DEBUG_PAGEALLOC. Walk the page table and check the PTE_VALID bit.
- * This is based on kern_addr_valid(), which almost does what we need.
+ * This function is used to determine if a linear map page has been marked as
+ * not-valid. Walk the page table and check the PTE_VALID bit. This is based
+ * on kern_addr_valid(), which almost does what we need.
  *
  * Because this is only called on the kernel linear map,  p?d_sect() implies
  * p?d_present(). When debug_pagealloc is enabled, sections mappings are
@@ -183,6 +214,9 @@ bool kernel_page_present(struct page *page)
 	pte_t *ptep;
 	unsigned long addr = (unsigned long)page_address(page);
 
+	if (!debug_pagealloc_enabled() && !rodata_full)
+		return true;
+
 	pgdp = pgd_offset_k(addr);
 	if (pgd_none(READ_ONCE(*pgdp)))
 		return false;
@@ -204,5 +238,3 @@ bool kernel_page_present(struct page *page)
 	ptep = pte_offset_kernel(pmdp, addr);
 	return pte_valid(READ_ONCE(*ptep));
 }
-#endif /* CONFIG_HIBERNATION */
-#endif /* CONFIG_DEBUG_PAGEALLOC */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 233af6936c93..1135dd8f2665 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2128,17 +2128,6 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
 	int i;
 
-	/*
-	 * The below block can be removed when all architectures that have
-	 * direct map permissions also have set_direct_map_() implementations.
-	 * This is concerned with resetting the direct map any an vm alias with
-	 * execute permissions, without leaving a RW+X window.
-	 */
-	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		set_memory_nx(addr, area->nr_pages);
-		set_memory_rw(addr, area->nr_pages);
-	}
-
 	remove_vm_area(area->addr);
 
 	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
-- 
2.17.1

