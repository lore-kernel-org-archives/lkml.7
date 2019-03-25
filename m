Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D4BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3080B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfCYOkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:40:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbfCYOkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:40:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CA2866964;
        Mon, 25 Mar 2019 14:40:22 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 443361001DC8;
        Mon, 25 Mar 2019 14:40:21 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 09/11] mm/hmm: allow to mirror vma of a file on a DAX backed filesystem v2
Date:   Mon, 25 Mar 2019 10:40:09 -0400
Message-Id: <20190325144011.10560-10-jglisse@redhat.com>
In-Reply-To: <20190325144011.10560-1-jglisse@redhat.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 25 Mar 2019 14:40:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

HMM mirror is a device driver helpers to mirror range of virtual address.
It means that the process jobs running on the device can access the same
virtual address as the CPU threads of that process. This patch adds support
for mirroring mapping of file that are on a DAX block device (ie range of
virtual address that is an mmap of a file in a filesystem on a DAX block
device). There is no reason to not support such case when mirroring virtual
address on a device.

Note that unlike GUP code we do not take page reference hence when we
back-off we have nothing to undo.

Changes since v1:
    - improved commit message
    - squashed: Arnd Bergmann: fix unused variable warning in hmm_vma_walk_pud

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 mm/hmm.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 111 insertions(+), 21 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 64a33770813b..ce33151c6832 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -325,6 +325,7 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
 
 struct hmm_vma_walk {
 	struct hmm_range	*range;
+	struct dev_pagemap	*pgmap;
 	unsigned long		last;
 	bool			fault;
 	bool			block;
@@ -499,6 +500,15 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
+static inline uint64_t pud_to_hmm_pfn_flags(struct hmm_range *range, pud_t pud)
+{
+	if (!pud_present(pud))
+		return 0;
+	return pud_write(pud) ? range->flags[HMM_PFN_VALID] |
+				range->flags[HMM_PFN_WRITE] :
+				range->flags[HMM_PFN_VALID];
+}
+
 static int hmm_vma_handle_pmd(struct mm_walk *walk,
 			      unsigned long addr,
 			      unsigned long end,
@@ -520,8 +530,19 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
 
 	pfn = pmd_pfn(pmd) + pte_index(addr);
-	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
+	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
+		if (pmd_devmap(pmd)) {
+			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
+					      hmm_vma_walk->pgmap);
+			if (unlikely(!hmm_vma_walk->pgmap))
+				return -EBUSY;
+		}
 		pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
+	}
+	if (hmm_vma_walk->pgmap) {
+		put_dev_pagemap(hmm_vma_walk->pgmap);
+		hmm_vma_walk->pgmap = NULL;
+	}
 	hmm_vma_walk->last = end;
 	return 0;
 }
@@ -608,10 +629,24 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	if (fault || write_fault)
 		goto fault;
 
+	if (pte_devmap(pte)) {
+		hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
+					      hmm_vma_walk->pgmap);
+		if (unlikely(!hmm_vma_walk->pgmap))
+			return -EBUSY;
+	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
+		*pfn = range->values[HMM_PFN_SPECIAL];
+		return -EFAULT;
+	}
+
 	*pfn = hmm_pfn_from_pfn(range, pte_pfn(pte)) | cpu_flags;
 	return 0;
 
 fault:
+	if (hmm_vma_walk->pgmap) {
+		put_dev_pagemap(hmm_vma_walk->pgmap);
+		hmm_vma_walk->pgmap = NULL;
+	}
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
@@ -699,12 +734,83 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			return r;
 		}
 	}
+	if (hmm_vma_walk->pgmap) {
+		put_dev_pagemap(hmm_vma_walk->pgmap);
+		hmm_vma_walk->pgmap = NULL;
+	}
 	pte_unmap(ptep - 1);
 
 	hmm_vma_walk->last = addr;
 	return 0;
 }
 
+static int hmm_vma_walk_pud(pud_t *pudp,
+			    unsigned long start,
+			    unsigned long end,
+			    struct mm_walk *walk)
+{
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+	unsigned long addr = start, next;
+	pmd_t *pmdp;
+	pud_t pud;
+	int ret;
+
+again:
+	pud = READ_ONCE(*pudp);
+	if (pud_none(pud))
+		return hmm_vma_walk_hole(start, end, walk);
+
+	if (pud_huge(pud) && pud_devmap(pud)) {
+		unsigned long i, npages, pfn;
+		uint64_t *pfns, cpu_flags;
+		bool fault, write_fault;
+
+		if (!pud_present(pud))
+			return hmm_vma_walk_hole(start, end, walk);
+
+		i = (addr - range->start) >> PAGE_SHIFT;
+		npages = (end - addr) >> PAGE_SHIFT;
+		pfns = &range->pfns[i];
+
+		cpu_flags = pud_to_hmm_pfn_flags(range, pud);
+		hmm_range_need_fault(hmm_vma_walk, pfns, npages,
+				     cpu_flags, &fault, &write_fault);
+		if (fault || write_fault)
+			return hmm_vma_walk_hole_(addr, end, fault,
+						write_fault, walk);
+
+		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+		for (i = 0; i < npages; ++i, ++pfn) {
+			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
+					      hmm_vma_walk->pgmap);
+			if (unlikely(!hmm_vma_walk->pgmap))
+				return -EBUSY;
+			pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
+		}
+		if (hmm_vma_walk->pgmap) {
+			put_dev_pagemap(hmm_vma_walk->pgmap);
+			hmm_vma_walk->pgmap = NULL;
+		}
+		hmm_vma_walk->last = end;
+		return 0;
+	}
+
+	split_huge_pud(walk->vma, pudp, addr);
+	if (pud_none(*pudp))
+		goto again;
+
+	pmdp = pmd_offset(pudp, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		ret = hmm_vma_walk_pmd(pmdp, addr, next, walk);
+		if (ret)
+			return ret;
+	} while (pmdp++, addr = next, addr != end);
+
+	return 0;
+}
+
 static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				      unsigned long start, unsigned long end,
 				      struct mm_walk *walk)
@@ -777,14 +883,6 @@ static void hmm_pfns_clear(struct hmm_range *range,
 		*pfns = range->values[HMM_PFN_NONE];
 }
 
-static void hmm_pfns_special(struct hmm_range *range)
-{
-	unsigned long addr = range->start, i = 0;
-
-	for (; addr < range->end; addr += PAGE_SIZE, i++)
-		range->pfns[i] = range->values[HMM_PFN_SPECIAL];
-}
-
 /*
  * hmm_range_register() - start tracking change to CPU page table over a range
  * @range: range
@@ -902,12 +1000,6 @@ long hmm_range_snapshot(struct hmm_range *range)
 		if (vma == NULL || (vma->vm_flags & device_vma))
 			return -EFAULT;
 
-		/* FIXME support dax */
-		if (vma_is_dax(vma)) {
-			hmm_pfns_special(range);
-			return -EINVAL;
-		}
-
 		if (is_vm_hugetlb_page(vma)) {
 			struct hstate *h = hstate_vma(vma);
 
@@ -931,6 +1023,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 		}
 
 		range->vma = vma;
+		hmm_vma_walk.pgmap = NULL;
 		hmm_vma_walk.last = start;
 		hmm_vma_walk.fault = false;
 		hmm_vma_walk.range = range;
@@ -942,6 +1035,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 		mm_walk.pte_entry = NULL;
 		mm_walk.test_walk = NULL;
 		mm_walk.hugetlb_entry = NULL;
+		mm_walk.pud_entry = hmm_vma_walk_pud;
 		mm_walk.pmd_entry = hmm_vma_walk_pmd;
 		mm_walk.pte_hole = hmm_vma_walk_hole;
 		mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
@@ -1007,12 +1101,6 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 		if (vma == NULL || (vma->vm_flags & device_vma))
 			return -EFAULT;
 
-		/* FIXME support dax */
-		if (vma_is_dax(vma)) {
-			hmm_pfns_special(range);
-			return -EINVAL;
-		}
-
 		if (is_vm_hugetlb_page(vma)) {
 			if (huge_page_shift(hstate_vma(vma)) !=
 			    range->page_shift &&
@@ -1035,6 +1123,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 		}
 
 		range->vma = vma;
+		hmm_vma_walk.pgmap = NULL;
 		hmm_vma_walk.last = start;
 		hmm_vma_walk.fault = true;
 		hmm_vma_walk.block = block;
@@ -1047,6 +1136,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 		mm_walk.pte_entry = NULL;
 		mm_walk.test_walk = NULL;
 		mm_walk.hugetlb_entry = NULL;
+		mm_walk.pud_entry = hmm_vma_walk_pud;
 		mm_walk.pmd_entry = hmm_vma_walk_pmd;
 		mm_walk.pte_hole = hmm_vma_walk_hole;
 		mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
-- 
2.17.2

