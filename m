Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D95C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F40214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="L1uUn8Vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfJJMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:43:33 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:12422 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733231AbfJJMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:43:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 48B8C3F3EC;
        Thu, 10 Oct 2019 14:43:29 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=L1uUn8Vq;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eu1PcXy3zyMA; Thu, 10 Oct 2019 14:43:28 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id B89E33F398;
        Thu, 10 Oct 2019 14:43:23 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 673F2361101;
        Thu, 10 Oct 2019 14:43:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570711403; bh=/wVfwfmLGDeISfky//VgvqJ5/Afbf3E4DEhWjfnBZl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1uUn8VqmxhpVWiESBsf/X6VJR3APjuVPlVzyi0RjomS5tCWn3U2I9nLWGQQmMQVW
         CN/nimG6RwhVTE6WWe7wbVX5UaxtACUsxvZ7AkdGdDyvtt1r5aF7xr3C7TYb5ECo+0
         OflR0lFr01MKh7j9XzXIQmyonS/4bKSsFUIV6mW0=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: [PATCH v5 4/8] mm: Add write-protect and clean utilities for address space ranges
Date:   Thu, 10 Oct 2019 14:43:10 +0200
Message-Id: <20191010124314.40067-5-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010124314.40067-1-thomas_os@shipmail.org>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Add two utilities to 1) write-protect and 2) clean all ptes pointing into
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
 include/linux/mm.h         |  13 +-
 mm/Kconfig                 |   3 +
 mm/Makefile                |   1 +
 mm/mapping_dirty_helpers.c | 312 +++++++++++++++++++++++++++++++++++++
 4 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 mm/mapping_dirty_helpers.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc292273e6ba..4bc93477375e 100644
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
 
+#ifdef CONFIG_MAPPING_DIRTY_HELPERS
+unsigned long clean_record_shared_mapping_range(struct address_space *mapping,
+						pgoff_t first_index, pgoff_t nr,
+						pgoff_t bitmap_pgoff,
+						unsigned long *bitmap,
+						pgoff_t *start,
+						pgoff_t *end);
+
+unsigned long wp_shared_mapping_range(struct address_space *mapping,
+				      pgoff_t first_index, pgoff_t nr);
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index a5dae9a7eb51..550f7aceb679 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -736,4 +736,7 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config MAPPING_DIRTY_HELPERS
+        bool
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index d996846697ef..1937cc251883 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
+obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
new file mode 100644
index 000000000000..799b9154b48f
--- /dev/null
+++ b/mm/mapping_dirty_helpers.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pagewalk.h>
+#include <linux/hugetlb.h>
+#include <linux/bitops.h>
+#include <linux/mmu_notifier.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+/**
+ * struct wp_walk - Private struct for pagetable walk callbacks
+ * @range: Range for mmu notifiers
+ * @tlbflush_start: Address of first modified pte
+ * @tlbflush_end: Address of last modified pte + 1
+ * @total: Total number of modified ptes
+ */
+struct wp_walk {
+	struct mmu_notifier_range range;
+	unsigned long tlbflush_start;
+	unsigned long tlbflush_end;
+	unsigned long total;
+};
+
+/**
+ * wp_pte - Write-protect a pte
+ * @pte: Pointer to the pte
+ * @addr: The virtual page address
+ * @walk: pagetable walk callback argument
+ *
+ * The function write-protects a pte and records the range in
+ * virtual address space of touched ptes for efficient range TLB flushes.
+ */
+static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
+		  struct mm_walk *walk)
+{
+	struct wp_walk *wpwalk = walk->private;
+	pte_t ptent = *pte;
+
+	if (pte_write(ptent)) {
+		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
+
+		ptent = pte_wrprotect(old_pte);
+		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
+		wpwalk->total++;
+		wpwalk->tlbflush_start = min(wpwalk->tlbflush_start, addr);
+		wpwalk->tlbflush_end = max(wpwalk->tlbflush_end,
+					   addr + PAGE_SIZE);
+	}
+
+	return 0;
+}
+
+/**
+ * struct clean_walk - Private struct for the clean_record_pte function.
+ * @base: struct wp_walk we derive from
+ * @bitmap_pgoff: Address_space Page offset of the first bit in @bitmap
+ * @bitmap: Bitmap with one bit for each page offset in the address_space range
+ * covered.
+ * @start: Address_space page offset of first modified pte relative
+ * to @bitmap_pgoff
+ * @end: Address_space page offset of last modified pte relative
+ * to @bitmap_pgoff
+ */
+struct clean_walk {
+	struct wp_walk base;
+	pgoff_t bitmap_pgoff;
+	unsigned long *bitmap;
+	pgoff_t start;
+	pgoff_t end;
+};
+
+#define to_clean_walk(_wpwalk) container_of(_wpwalk, struct clean_walk, base)
+
+/**
+ * clean_record_pte - Clean a pte and record its address space offset in a
+ * bitmap
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
+static int clean_record_pte(pte_t *pte, unsigned long addr,
+			    unsigned long end, struct mm_walk *walk)
+{
+	struct wp_walk *wpwalk = walk->private;
+	struct clean_walk *cwalk = to_clean_walk(wpwalk);
+	pte_t ptent = *pte;
+
+	if (pte_dirty(ptent)) {
+		pgoff_t pgoff = ((addr - walk->vma->vm_start) >> PAGE_SHIFT) +
+			walk->vma->vm_pgoff - cwalk->bitmap_pgoff;
+		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
+
+		ptent = pte_mkclean(old_pte);
+		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
+
+		wpwalk->total++;
+		wpwalk->tlbflush_start = min(wpwalk->tlbflush_start, addr);
+		wpwalk->tlbflush_end = max(wpwalk->tlbflush_end,
+					   addr + PAGE_SIZE);
+
+		__set_bit(pgoff, cwalk->bitmap);
+		cwalk->start = min(cwalk->start, pgoff);
+		cwalk->end = max(cwalk->end, pgoff + 1);
+	}
+
+	return 0;
+}
+
+/* wp_clean_pmd_entry - The pagewalk pmd callback. */
+static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
+			      struct mm_walk *walk)
+{
+	/* Dirty-tracking should be handled on the pte level */
+	pmd_t pmdval = pmd_read_atomic(pmd);
+
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
+
+	return 0;
+}
+
+/* wp_clean_pud_entry - The pagewalk pud callback. */
+static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
+			      struct mm_walk *walk)
+{
+	/* Dirty-tracking should be handled on the pte level */
+	pud_t pudval = READ_ONCE(*pud);
+
+	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
+
+	return 0;
+}
+
+/*
+ * wp_clean_pre_vma - The pagewalk pre_vma callback.
+ *
+ * The pre_vma callback performs the cache flush, stages the tlb flush
+ * and calls the necessary mmu notifiers.
+ */
+static int wp_clean_pre_vma(unsigned long start, unsigned long end,
+			    struct mm_walk *walk)
+{
+	struct wp_walk *wpwalk = walk->private;
+
+	wpwalk->tlbflush_start = end;
+	wpwalk->tlbflush_end = start;
+
+	mmu_notifier_range_init(&wpwalk->range, MMU_NOTIFY_PROTECTION_PAGE, 0,
+				walk->vma, walk->mm, start, end);
+	mmu_notifier_invalidate_range_start(&wpwalk->range);
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
+ * wp_clean_post_vma - The pagewalk post_vma callback.
+ *
+ * The post_vma callback performs the tlb flush and calls necessary mmu
+ * notifiers.
+ */
+static void wp_clean_post_vma(struct mm_walk *walk)
+{
+	struct wp_walk *wpwalk = walk->private;
+
+	if (wpwalk->tlbflush_end > wpwalk->tlbflush_start)
+		flush_tlb_range(walk->vma, wpwalk->tlbflush_start,
+				wpwalk->tlbflush_end);
+
+	mmu_notifier_invalidate_range_end(&wpwalk->range);
+	dec_tlb_flush_pending(walk->mm);
+}
+
+/*
+ * wp_clean_test_walk - The pagewalk test_walk callback.
+ *
+ * Won't perform dirty-tracking on COW, read-only or HUGETLB vmas.
+ */
+static int wp_clean_test_walk(unsigned long start, unsigned long end,
+			      struct mm_walk *walk)
+{
+	unsigned long vm_flags = READ_ONCE(walk->vma->vm_flags);
+
+	/* Skip non-applicable VMAs */
+	if ((vm_flags & (VM_SHARED | VM_MAYWRITE | VM_HUGETLB)) !=
+	    (VM_SHARED | VM_MAYWRITE))
+		return 1;
+
+	return 0;
+}
+
+static const struct mm_walk_ops clean_walk_ops = {
+	.pte_entry = clean_record_pte,
+	.pmd_entry = wp_clean_pmd_entry,
+	.pud_entry = wp_clean_pud_entry,
+	.test_walk = wp_clean_test_walk,
+	.pre_vma = wp_clean_pre_vma,
+	.post_vma = wp_clean_post_vma
+};
+
+static const struct mm_walk_ops wp_walk_ops = {
+	.pte_entry = wp_pte,
+	.pmd_entry = wp_clean_pmd_entry,
+	.pud_entry = wp_clean_pud_entry,
+	.test_walk = wp_clean_test_walk,
+	.pre_vma = wp_clean_pre_vma,
+	.post_vma = wp_clean_post_vma
+};
+
+/**
+ * wp_shared_mapping_range - Write-protect all ptes in an address space range
+ * @mapping: The address_space we want to write protect
+ * @first_index: The first page offset in the range
+ * @nr: Number of incremental page offsets to cover
+ *
+ * Note: This function currently skips transhuge page-table entries, since
+ * it's intended for dirty-tracking on the PTE level. It will warn on
+ * encountering transhuge write-enabled entries, though, and can easily be
+ * extended to handle them as well.
+ *
+ * Return: The number of ptes actually write-protected. Note that
+ * already write-protected ptes are not counted.
+ */
+unsigned long wp_shared_mapping_range(struct address_space *mapping,
+				      pgoff_t first_index, pgoff_t nr)
+{
+	struct wp_walk wpwalk = { .total = 0 };
+
+	i_mmap_lock_read(mapping);
+	WARN_ON(walk_page_mapping(mapping, first_index, nr, &wp_walk_ops,
+				  &wpwalk));
+	i_mmap_unlock_read(mapping);
+
+	return wpwalk.total;
+}
+EXPORT_SYMBOL_GPL(wp_shared_mapping_range);
+
+/**
+ * clean_record_shared_mapping_range - Clean and record all ptes in an
+ * address space range
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
+ * reported in the bitmap. The guarantees are as follows:
+ * a) All ptes dirty when the function starts executing will end up recorded
+ *    in the bitmap.
+ * b) All ptes dirtied after that will either remain dirty, be recorded in the
+ *    bitmap or both.
+ *
+ * If a caller needs to make sure all dirty ptes are picked up and none
+ * additional are added, it first needs to write-protect the address-space
+ * range and make sure new writers are blocked in page_mkwrite() or
+ * pfn_mkwrite(). And then after a TLB flush following the write-protection
+ * pick up all dirty bits.
+ *
+ * Note: This function currently skips transhuge page-table entries, since
+ * it's intended for dirty-tracking on the PTE level. It will warn on
+ * encountering transhuge dirty entries, though, and can easily be extended
+ * to handle them as well.
+ *
+ * Return: The number of dirty ptes actually cleaned.
+ */
+unsigned long clean_record_shared_mapping_range(struct address_space *mapping,
+						pgoff_t first_index, pgoff_t nr,
+						pgoff_t bitmap_pgoff,
+						unsigned long *bitmap,
+						pgoff_t *start,
+						pgoff_t *end)
+{
+	bool none_set = (*start >= *end);
+	struct clean_walk cwalk = {
+		.base = { .total = 0 },
+		.bitmap_pgoff = bitmap_pgoff,
+		.bitmap = bitmap,
+		.start = none_set ? nr : *start,
+		.end = none_set ? 0 : *end,
+	};
+
+	i_mmap_lock_read(mapping);
+	WARN_ON(walk_page_mapping(mapping, first_index, nr, &clean_walk_ops,
+				  &cwalk.base));
+	i_mmap_unlock_read(mapping);
+
+	*start = cwalk.start;
+	*end = cwalk.end;
+
+	return cwalk.base.total;
+}
+EXPORT_SYMBOL_GPL(clean_record_shared_mapping_range);
-- 
2.21.0

