Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C269C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C36218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfCTPX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:23:56 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:12345 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbfCTPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:23:54 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 20 Mar 2019 08:23:48 -0700
Received: from fedoratest.localdomain (unknown [10.30.24.114])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6F7FB4199D;
        Wed, 20 Mar 2019 08:23:49 -0700 (PDT)
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/3] mm: Add write-protect and clean utilities for address space ranges
Date:   Wed, 20 Mar 2019 16:23:15 +0100
Message-ID: <20190320152315.82758-4-thellstrom@vmware.com>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20190320152315.82758-1-thellstrom@vmware.com>
References: <20190320152315.82758-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-002.vmware.com: thellstrom@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two utilities to a) write-protect and b) clean all ptes pointing into
a range of an address space
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
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/linux/mm.h  |   9 +-
 mm/Makefile         |   2 +-
 mm/apply_as_range.c | 257 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+), 2 deletions(-)
 create mode 100644 mm/apply_as_range.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7dd4ddd6efb..62f24dd0bfa0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2642,7 +2642,14 @@ struct pfn_range_apply {
 };
 extern int apply_to_pfn_range(struct pfn_range_apply *closure,
 			      unsigned long address, unsigned long size);
-
+unsigned long apply_as_wrprotect(struct address_space *mapping,
+				 pgoff_t first_index, pgoff_t nr);
+unsigned long apply_as_clean(struct address_space *mapping,
+			     pgoff_t first_index, pgoff_t nr,
+			     pgoff_t bitmap_pgoff,
+			     unsigned long *bitmap,
+			     pgoff_t *start,
+			     pgoff_t *end);
 #ifdef CONFIG_PAGE_POISONING
 extern bool page_poisoning_enabled(void);
 extern void kernel_poison_pages(struct page *page, int numpages, int enable);
diff --git a/mm/Makefile b/mm/Makefile
index d210cc9d6f80..a94b78f12692 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -39,7 +39,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o mmu_context.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o $(mmu-y)
+			   debug.o apply_as_range.o $(mmu-y)
 
 obj-y += init-mm.o
 obj-y += memblock.o
diff --git a/mm/apply_as_range.c b/mm/apply_as_range.c
new file mode 100644
index 000000000000..9f03e272ebd0
--- /dev/null
+++ b/mm/apply_as_range.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/hugetlb.h>
+#include <linux/bitops.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+/**
+ * struct apply_as - Closure structure for apply_as_range
+ * @base: struct pfn_range_apply we derive from
+ * @start: Address of first modified pte
+ * @end: Address of last modified pte + 1
+ * @total: Total number of modified ptes
+ * @vma: Pointer to the struct vm_area_struct we're currently operating on
+ * @flush_cache: Whether to call a cache flush before modifying a pte
+ * @flush_tlb: Whether to flush the tlb after modifying a pte
+ */
+struct apply_as {
+	struct pfn_range_apply base;
+	unsigned long start, end;
+	unsigned long total;
+	const struct vm_area_struct *vma;
+	u32 flush_cache : 1;
+	u32 flush_tlb : 1;
+};
+
+/**
+ * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
+ * @pte: Pointer to the pte
+ * @token: Page table token, see apply_to_pfn_range()
+ * @addr: The virtual page address
+ * @closure: Pointer to a struct pfn_range_apply embedded in a
+ * struct apply_as
+ *
+ * The function write-protects a pte and records the range in
+ * virtual address space of touched ptes for efficient TLB flushes.
+ *
+ * Return: Always zero.
+ */
+static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
+			      unsigned long addr,
+			      struct pfn_range_apply *closure)
+{
+	struct apply_as *aas = container_of(closure, typeof(*aas), base);
+
+	if (pte_write(*pte)) {
+		set_pte_at(closure->mm, addr, pte, pte_wrprotect(*pte));
+		aas->total++;
+		if (addr < aas->start)
+			aas->start = addr;
+		if (addr + PAGE_SIZE > aas->end)
+			aas->end = addr + PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+/**
+ * struct apply_as_clean - Closure structure for apply_as_clean
+ * @base: struct apply_as we derive from
+ * @bitmap_pgoff: Address_space Page offset of the first bit in @bitmap
+ * @bitmap: Bitmap with one bit for each page offset in the address_space range
+ * covered.
+ * @start: Address_space page offset of first modified pte
+ * @end: Address_space page offset of last modified pte
+ */
+struct apply_as_clean {
+	struct apply_as base;
+	pgoff_t bitmap_pgoff;
+	unsigned long *bitmap;
+	pgoff_t start, end;
+};
+
+/**
+ * apply_pt_clean - Leaf pte callback to clean a pte
+ * @pte: Pointer to the pte
+ * @token: Page table token, see apply_to_pfn_range()
+ * @addr: The virtual page address
+ * @closure: Pointer to a struct pfn_range_apply embedded in a
+ * struct apply_as_clean
+ *
+ * The function cleans a pte and records the range in
+ * virtual address space of touched ptes for efficient TLB flushes.
+ * It also records dirty ptes in a bitmap representing page offsets
+ * in the address_space, as well as the first and last of the bits
+ * touched.
+ *
+ * Return: Always zero.
+ */
+static int apply_pt_clean(pte_t *pte, pgtable_t token,
+			  unsigned long addr,
+			  struct pfn_range_apply *closure)
+{
+	struct apply_as *aas = container_of(closure, typeof(*aas), base);
+	struct apply_as_clean *clean = container_of(aas, typeof(*clean), base);
+
+	if (pte_dirty(*pte)) {
+		pgoff_t pgoff = ((addr - aas->vma->vm_start) >> PAGE_SHIFT) +
+			aas->vma->vm_pgoff - clean->bitmap_pgoff;
+
+		set_pte_at(closure->mm, addr, pte, pte_mkclean(*pte));
+		aas->total++;
+		if (addr < aas->start)
+			aas->start = addr;
+		if (addr + PAGE_SIZE > aas->end)
+			aas->end = addr + PAGE_SIZE;
+
+		__set_bit(pgoff, clean->bitmap);
+		clean->start = min(clean->start, pgoff);
+		clean->end = max(clean->end, pgoff + 1);
+	}
+
+	return 0;
+}
+
+/**
+ * apply_as_range - Apply a pte callback to all PTEs pointing into a range
+ * of an address_space.
+ * @mapping: Pointer to the struct address_space
+ * @aas: Closure structure
+ * @first_index: First page offset in the address_space
+ * @nr: Number of incremental page offsets to cover
+ *
+ * Return: Number of ptes touched. Note that this number might be larger
+ * than @nr if there are overlapping vmas
+ */
+static unsigned long apply_as_range(struct address_space *mapping,
+				    struct apply_as *aas,
+				    pgoff_t first_index, pgoff_t nr)
+{
+	struct vm_area_struct *vma;
+	pgoff_t vba, vea, cba, cea;
+	unsigned long start_addr, end_addr;
+
+	/* FIXME: Is a read lock sufficient here? */
+	down_write(&mapping->i_mmap_rwsem);
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
+		first_index + nr - 1) {
+		aas->base.mm = vma->vm_mm;
+
+		/* Clip to the vma */
+		vba = vma->vm_pgoff;
+		vea = vba + vma_pages(vma);
+		cba = first_index;
+		cba = max(cba, vba);
+		cea = first_index + nr;
+		cea = min(cea, vea);
+
+		/* Translate to virtual address */
+		start_addr = ((cba - vba) << PAGE_SHIFT) + vma->vm_start;
+		end_addr = ((cea - vba) << PAGE_SHIFT) + vma->vm_start;
+
+		/*
+		 * TODO: Should caches be flushed individually on demand
+		 * in the leaf-pte callbacks instead? That is, how
+		 * costly are inter-core interrupts in an SMP system?
+		 */
+		if (aas->flush_cache)
+			flush_cache_range(vma, start_addr, end_addr);
+		aas->start = end_addr;
+		aas->end = start_addr;
+		aas->vma = vma;
+
+		/* Should not error since aas->base.alloc == 0 */
+		WARN_ON(apply_to_pfn_range(&aas->base, start_addr,
+					   end_addr - start_addr));
+		if (aas->flush_tlb && aas->end > aas->start)
+			flush_tlb_range(vma, aas->start, aas->end);
+	}
+	up_write(&mapping->i_mmap_rwsem);
+
+	return aas->total;
+}
+
+/**
+ * apply_as_wrprotect - Write-protect all ptes in an address_space range
+ * @mapping: The address_space we want to write protect
+ * @first_index: The first page offset in the range
+ * @nr: Number of incremental page offsets to cover
+ *
+ * Return: The number of ptes actually write-protected. Note that
+ * already write-protected ptes are not counted.
+ */
+unsigned long apply_as_wrprotect(struct address_space *mapping,
+				 pgoff_t first_index, pgoff_t nr)
+{
+	struct apply_as aas = {
+		.base = {
+			.alloc = 0,
+			.ptefn = apply_pt_wrprotect,
+		},
+		.total = 0,
+		.flush_cache = 1,
+		.flush_tlb = 1
+	};
+
+	return apply_as_range(mapping, &aas, first_index, nr);
+}
+EXPORT_SYMBOL(apply_as_wrprotect);
+
+/**
+ * apply_as_clean - Clean all ptes in an address_space range
+ * @mapping: The address_space we want to clean
+ * @first_index: The first page offset in the range
+ * @nr: Number of incremental page offsets to cover
+ * @bitmap_pgoff: The page offset of the first bit in @bitmap
+ * @bitmap: Pointer to a bitmap of at least @nr bits. The bitmap needs to
+ * cover the whole range @first_index..@first_index + @nr.
+ * @start: Pointer to page offset of the first set bit in @bitmap, or if
+ * none set the value pointed to should be @bitmap_pgoff + @nr. The value
+ * is modified as new bits are set by the function.
+ * @end: Page offset of the last set bit in @bitmap + 1 or @bitmap_pgoff if
+ * none set. The value is modified as new bets are set by the function.
+ *
+ * Note: When this function returns there is no guarantee that a CPU has
+ * not already dirtied new ptes. However it will not clean any ptes not
+ * reported in the bitmap.
+ *
+ * If a caller needs to make sure all dirty ptes are picked up and none
+ * additional are added, it first needs to write-protect the address-space
+ * range and make sure new writers are blocked in page_mkwrite() or
+ * pfn_mkwrite(). And then after a TLB flush following the write-protection
+ * pick upp all dirty bits.
+ *
+ * Return: The number of dirty ptes actually cleaned.
+ */
+unsigned long apply_as_clean(struct address_space *mapping,
+			     pgoff_t first_index, pgoff_t nr,
+			     pgoff_t bitmap_pgoff,
+			     unsigned long *bitmap,
+			     pgoff_t *start,
+			     pgoff_t *end)
+{
+	struct apply_as_clean clean = {
+		.base = {
+			.base = {
+				.alloc = 0,
+				.ptefn = apply_pt_clean,
+			},
+			.total = 0,
+			.flush_cache = 0,
+			.flush_tlb = 1,
+		},
+		.bitmap_pgoff = bitmap_pgoff,
+		.bitmap = bitmap,
+		.start = *start,
+		.end = *end,
+	};
+	unsigned long ret = apply_as_range(mapping, &clean.base, first_index,
+					   nr);
+
+	*start = clean.start;
+	*end = clean.end;
+	return ret;
+}
+EXPORT_SYMBOL(apply_as_clean);
-- 
2.19.0.rc1

