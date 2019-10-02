Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BEBECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061AA21D80
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="OuuLqXYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfJBNr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:47:57 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:37464 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfJBNrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:47:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 870673F5C7;
        Wed,  2 Oct 2019 15:47:44 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=OuuLqXYF;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wG_Sy2dRkw6V; Wed,  2 Oct 2019 15:47:40 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 4D9543F536;
        Wed,  2 Oct 2019 15:47:40 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 0439F3604FE;
        Wed,  2 Oct 2019 15:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570024060; bh=1Dcdq1pS8CY3EbjhHaX6/ZmBSMc4b9v0nJ3lxZNu35I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OuuLqXYF1DZGSoDT15QZyva+I1jURaTVUAtRObf+NuxPnGAyhNfnL5qwR57iXH7HL
         vOAJQkdkYAGf1KLN3jdUd3yYftZ+LgnoYyt39hQOAQ7uUMCVcaFErxjgHG2B/LZxxX
         WiE/wd541svJTninIbn9aE34xCI9iZMytfii+fhE=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 3/7] mm: Add write-protect and clean utilities for address space ranges
Date:   Wed,  2 Oct 2019 15:47:26 +0200
Message-Id: <20191002134730.40985-4-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002134730.40985-1-thomas_os@shipmail.org>
References: <20191002134730.40985-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Add two utilities to a) write-protect and b) clean all ptes pointing into
a range of an address space.
The utilities are intended to aid in tracking dirty pages (either
driver-allocated system memory or pci device memory).
The write-protect utility should be used in conjunction with
page_mkwrite() and pfn_mkwrite() to trigger write page-faults on page
accesses. Typically one would want to use this on sparse accesses into
large memory regions. The clean utility should be used to utilize
hardware dirtying functionality and avoid the overhead of page-faults,
typically on large accesses into small memory regions.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/linux/mm.h    |  13 +-
 mm/Kconfig            |   3 +
 mm/Makefile           |   1 +
 mm/as_dirty_helpers.c | 315 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 mm/as_dirty_helpers.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc292273e6ba..4a9b02f7f91c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2637,7 +2637,6 @@ typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
 
-
 #ifdef CONFIG_PAGE_POISONING
 extern bool page_poisoning_enabled(void);
 extern void kernel_poison_pages(struct page *page, int numpages, int enable);
@@ -2878,5 +2877,17 @@ static inline int pages_identical(struct page *page1, struct page *page2)
 	return !memcmp_pages(page1, page2);
 }
 
+#ifdef CONFIG_AS_DIRTY_HELPERS
+unsigned long as_dirty_clean(struct address_space *mapping,
+			     pgoff_t first_index, pgoff_t nr,
+			     pgoff_t bitmap_pgoff,
+			     unsigned long *bitmap,
+			     pgoff_t *start,
+			     pgoff_t *end);
+
+unsigned long as_dirty_wrprotect(struct address_space *mapping,
+				 pgoff_t first_index, pgoff_t nr);
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index a5dae9a7eb51..7a0538fe507f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -736,4 +736,7 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config AS_DIRTY_HELPERS
+        bool
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d996846697ef..828bf4278c9d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
+obj-$(CONFIG_AS_DIRTY_HELPERS) += as_dirty_helpers.o
diff --git a/mm/as_dirty_helpers.c b/mm/as_dirty_helpers.c
new file mode 100644
index 000000000000..2cbf23a86fb4
--- /dev/null
+++ b/mm/as_dirty_helpers.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pagewalk.h>
+#include <linux/hugetlb.h>
+#include <linux/bitops.h>
+#include <linux/mmu_notifier.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+/**
+ * struct as_dirty_walk - Private struct for pagetable walk callbacks
+ * @range: Range for mmu notifiers
+ * @tlbflush_start: Address of first modified pte
+ * @tlbflush_end: Address of last modified pte + 1
+ * @total: Total number of modified ptes
+ * @wrprotect: Whether this is a write-protect or a clean operation
+ */
+struct as_dirty_walk {
+	struct mmu_notifier_range range;
+	unsigned long tlbflush_start;
+	unsigned long tlbflush_end;
+	unsigned long total;
+	unsigned int wrprotect;
+};
+
+/**
+ * as_dirty_pte_wrprotect - Write-protect a pte
+ * @pte: Pointer to the pte
+ * @addr: The virtual page address
+ * @walk: pagetable walk callback argument
+ *
+ * The function write-protects a pte and records the range in
+ * virtual address space of touched ptes for efficient range TLB flushes.
+ */
+static void as_dirty_pte_wrprotect(pte_t *pte, unsigned long addr,
+				   struct mm_walk *walk)
+{
+	struct as_dirty_walk *adw = walk->private;
+	pte_t ptent = *pte;
+
+	if (pte_write(ptent)) {
+		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
+
+		ptent = pte_wrprotect(old_pte);
+		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
+		adw->total++;
+		adw->tlbflush_start = min(adw->tlbflush_start, addr);
+		adw->tlbflush_end = max(adw->tlbflush_end, addr + PAGE_SIZE);
+	}
+}
+
+/**
+ * struct as_dirty_walk_clean - Private struct for the as_dirty_walk_clean
+ * function.
+ * @base: struct as_dirty_walk we derive from
+ * @bitmap_pgoff: Address_space Page offset of the first bit in @bitmap
+ * @bitmap: Bitmap with one bit for each page offset in the address_space range
+ * covered.
+ * @start: Address_space page offset of first modified pte relative
+ * to @bitmap_pgoff
+ * @end: Address_space page offset of last modified pte relative
+ * to @bitmap_pgoff
+ */
+struct as_dirty_walk_clean {
+	struct as_dirty_walk base;
+	pgoff_t bitmap_pgoff;
+	unsigned long *bitmap;
+	pgoff_t start;
+	pgoff_t end;
+};
+
+#define to_as_dirty_walk_clean(_adw)			\
+	container_of(_adw, struct as_dirty_walk_clean, base)
+
+/**
+ * as_dirty_pte_clean - Clean a pte
+ * @pte: Pointer to the pte
+ * @addr: The virtual page address
+ * @walk: pagetable walk callback argument
+ *
+ * The function cleans a pte and records the range in
+ * virtual address space of touched ptes for efficient TLB flushes.
+ * It also records dirty ptes in a bitmap representing page offsets
+ * in the address_space, as well as the first and last of the bits
+ * touched.
+ */
+static void as_dirty_pte_clean(pte_t *pte, unsigned long addr,
+			       struct mm_walk *walk)
+{
+	struct as_dirty_walk *adw = walk->private;
+	struct as_dirty_walk_clean *clean = to_as_dirty_walk_clean(adw);
+	pte_t ptent = *pte;
+
+	if (pte_dirty(ptent)) {
+		pgoff_t pgoff = ((addr - walk->vma->vm_start) >> PAGE_SHIFT) +
+			walk->vma->vm_pgoff - clean->bitmap_pgoff;
+		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
+
+		ptent = pte_mkclean(old_pte);
+		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
+
+		adw->total++;
+		adw->tlbflush_start = min(adw->tlbflush_start, addr);
+		adw->tlbflush_end = max(adw->tlbflush_end, addr + PAGE_SIZE);
+
+		__set_bit(pgoff, clean->bitmap);
+		clean->start = min(clean->start, pgoff);
+		clean->end = max(clean->end, pgoff + 1);
+	}
+}
+
+/*
+ * as_dirty_pmd_entry - The pagewalk pmd callback.
+ *
+ * Loops over ptes and calls the appropriate PTE callback.
+ * The pmd callback is needed to take the page-table lock and to
+ * avoid unnecessarily splitting huge pmd entries.
+ */
+static int as_dirty_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
+			      struct mm_walk *walk)
+{
+	struct mm_struct *mm = walk->mm;
+	struct as_dirty_walk *adw = walk->private;
+	pte_t *pte;
+	spinlock_t *ptl;
+
+	/* Ignore huge pmds. Dirty tracking is done on the PTE level! */
+	if (pmd_trans_unstable(pmd))
+		return 0;
+
+	pte = (mm == &init_mm) ?
+		pte_offset_kernel(pmd, addr) :
+		pte_offset_map_lock(mm, pmd, addr, &ptl);
+
+	arch_enter_lazy_mmu_mode();
+
+	do {
+		if (adw->wrprotect)
+			as_dirty_pte_wrprotect(pte++, addr, walk);
+		else
+			as_dirty_pte_clean(pte++, addr, walk);
+	} while (addr += PAGE_SIZE, addr != end);
+
+	arch_leave_lazy_mmu_mode();
+
+	if (mm != &init_mm)
+		pte_unmap_unlock(pte - 1, ptl);
+
+	return 0;
+}
+
+/*
+ * as_dirty_pud_entry - The pagewalk pud callback.
+ *
+ * The pud callback is needed solely to avoid unnecessarily splitting huge
+ * pud entries.
+ */
+static int as_dirty_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
+			      struct mm_walk *walk)
+{
+	/* Ignore huge puds. Dirty tracking is done on the PTE level. */
+	return 0;
+}
+
+/*
+ * as_dirty_pre_vma - The pagewalk pre_vma callback.
+ *
+ * The pre_vma callback performs the cache flush, stages the tlb flush
+ * and calls the necessary mmu notifiers.
+ */
+static int as_dirty_pre_vma(unsigned long start, unsigned long end,
+			    struct mm_walk *walk)
+{
+	struct as_dirty_walk *adw = walk->private;
+
+	adw->tlbflush_start = end;
+	adw->tlbflush_end = start;
+
+	mmu_notifier_range_init(&adw->range, MMU_NOTIFY_PROTECTION_PAGE, 0,
+				walk->vma, walk->mm, start, end);
+	mmu_notifier_invalidate_range_start(&adw->range);
+	flush_cache_range(walk->vma, start, end);
+
+	/*
+	 * We're not using tlb_gather_mmu() since typically
+	 * only a small subrange of PTEs are affected, whereas
+	 * tlb_gather_mmu() records the full range.
+	 */
+	inc_tlb_flush_pending(walk->mm);
+
+	return 0;
+}
+
+/*
+ * as_dirty_post_vma - The pagewalk post_vma callback.
+ *
+ * The post_vma callback performs the tlb flush and calls necessary mmu
+ * notifiers.
+ */
+static void as_dirty_post_vma(struct mm_walk *walk)
+{
+	struct as_dirty_walk *adw = walk->private;
+
+	if (adw->tlbflush_end > adw->tlbflush_start)
+		flush_tlb_range(walk->vma, adw->tlbflush_start,
+				adw->tlbflush_end);
+
+	mmu_notifier_invalidate_range_end(&adw->range);
+	dec_tlb_flush_pending(walk->mm);
+}
+
+/*
+ * as_dirty_test_walk - The pagewalk test_walk callback.
+ *
+ * Won't perform dirty-tracking on COW, read-only or HUGETLB vmas.
+ */
+static int as_dirty_test_walk(unsigned long start, unsigned long end,
+			      struct mm_walk *walk)
+{
+	/* Skip non-applicable VMAs */
+	if ((walk->vma->vm_flags & (VM_SHARED | VM_WRITE | VM_HUGETLB)) !=
+	    (VM_SHARED | VM_WRITE))
+		return 1;
+
+	return 0;
+}
+
+static const struct mm_walk_ops walk_ops = {
+		.pmd_entry = as_dirty_pmd_entry,
+		.pud_entry = as_dirty_pud_entry,
+		.test_walk = as_dirty_test_walk,
+		.pre_vma = as_dirty_pre_vma,
+		.post_vma = as_dirty_post_vma
+};
+
+/**
+ * as_dirty_wrprotect - Write-protect all ptes in an address_space range
+ * @mapping: The address_space we want to write protect
+ * @first_index: The first page offset in the range
+ * @nr: Number of incremental page offsets to cover
+ *
+ * Return: The number of ptes actually write-protected. Note that
+ * already write-protected ptes are not counted.
+ */
+unsigned long as_dirty_wrprotect(struct address_space *mapping,
+				 pgoff_t first_index, pgoff_t nr)
+{
+	struct as_dirty_walk adw = { .total = 0,
+				     .wrprotect = 1};
+
+	i_mmap_lock_read(mapping);
+	WARN_ON(walk_page_mapping(mapping, first_index, nr, &walk_ops, &adw));
+	i_mmap_unlock_read(mapping);
+
+	return adw.total;
+}
+EXPORT_SYMBOL_GPL(as_dirty_wrprotect);
+
+/**
+ * as_dirty_clean - Clean all ptes in an address_space range
+ * @mapping: The address_space we want to clean
+ * @first_index: The first page offset in the range
+ * @nr: Number of incremental page offsets to cover
+ * @bitmap_pgoff: The page offset of the first bit in @bitmap
+ * @bitmap: Pointer to a bitmap of at least @nr bits. The bitmap needs to
+ * cover the whole range @first_index..@first_index + @nr.
+ * @start: Pointer to number of the first set bit in @bitmap.
+ * is modified as new bits are set by the function.
+ * @end: Pointer to the number of the last set bit in @bitmap.
+ * none set. The value is modified as new bits are set by the function.
+ *
+ * Note: When this function returns there is no guarantee that a CPU has
+ * not already dirtied new ptes. However it will not clean any ptes not
+ * reported in the bitmap.
+ *
+ * If a caller needs to make sure all dirty ptes are picked up and none
+ * additional are added, it first needs to write-protect the address-space
+ * range and make sure new writers are blocked in page_mkwrite() or
+ * pfn_mkwrite(). And then after a TLB flush following the write-protection
+ * pick up all dirty bits.
+ *
+ * WARNING: This function should only be used for address spaces whose
+ * vmas are marked VM_IO and that do not contain huge pages.
+ * To avoid interference with COW'd pages, vmas not marked VM_SHARED are
+ * simply skipped.
+ *
+ * Return: The number of dirty ptes actually cleaned.
+ */
+unsigned long as_dirty_clean(struct address_space *mapping,
+			     pgoff_t first_index, pgoff_t nr,
+			     pgoff_t bitmap_pgoff,
+			     unsigned long *bitmap,
+			     pgoff_t *start,
+			     pgoff_t *end)
+{
+	bool none_set = (*start >= *end);
+	struct as_dirty_walk_clean clean = {
+		.base = { .total = 0,
+			  .wrprotect = 0},
+		.bitmap_pgoff = bitmap_pgoff,
+		.bitmap = bitmap,
+		.start = none_set ? nr : *start,
+		.end = none_set ? 0 : *end,
+	};
+
+	i_mmap_lock_read(mapping);
+	WARN_ON(walk_page_mapping(mapping, first_index, nr, &walk_ops,
+				  &clean.base));
+	i_mmap_unlock_read(mapping);
+
+	*start = clean.start;
+	*end = clean.end;
+
+	return clean.base.total;
+}
+EXPORT_SYMBOL_GPL(as_dirty_clean);
-- 
2.20.1

