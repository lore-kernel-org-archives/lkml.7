Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD575C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954352084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfDCTeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:34:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfDCTdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A06813088B61;
        Wed,  3 Apr 2019 19:33:39 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C2A56012C;
        Wed,  3 Apr 2019 19:33:37 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 08/12] mm/hmm: mirror hugetlbfs (snapshoting, faulting and DMA mapping) v3
Date:   Wed,  3 Apr 2019 15:33:14 -0400
Message-Id: <20190403193318.16478-9-jglisse@redhat.com>
In-Reply-To: <20190403193318.16478-1-jglisse@redhat.com>
References: <20190403193318.16478-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 03 Apr 2019 19:33:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

HMM mirror is a device driver helpers to mirror range of virtual address.
It means that the process jobs running on the device can access the same
virtual address as the CPU threads of that process. This patch adds support
for hugetlbfs mapping (ie range of virtual address that are mmap of a
hugetlbfs).

Changes since v2:
    - Use hmm_range_page_size() where we can.
Changes since v1:
    - improved commit message
    - squashed: Arnd Bergmann: fix unused variable warnings

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/hmm.h |  27 +++++++++-
 mm/hmm.c            | 123 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 134 insertions(+), 16 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index dee2f8953b2e..e5834082de60 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -181,10 +181,31 @@ struct hmm_range {
 	const uint64_t		*values;
 	uint64_t		default_flags;
 	uint64_t		pfn_flags_mask;
+	uint8_t			page_shift;
 	uint8_t			pfn_shift;
 	bool			valid;
 };
 
+/*
+ * hmm_range_page_shift() - return the page shift for the range
+ * @range: range being queried
+ * Returns: page shift (page size = 1 << page shift) for the range
+ */
+static inline unsigned hmm_range_page_shift(const struct hmm_range *range)
+{
+	return range->page_shift;
+}
+
+/*
+ * hmm_range_page_size() - return the page size for the range
+ * @range: range being queried
+ * Returns: page size for the range in bytes
+ */
+static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
+{
+	return 1UL << hmm_range_page_shift(range);
+}
+
 /*
  * hmm_range_wait_until_valid() - wait for range to be valid
  * @range: range affected by invalidation to wait on
@@ -424,7 +445,8 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
 int hmm_range_register(struct hmm_range *range,
 		       struct mm_struct *mm,
 		       unsigned long start,
-		       unsigned long end);
+		       unsigned long end,
+		       unsigned page_shift);
 void hmm_range_unregister(struct hmm_range *range);
 long hmm_range_snapshot(struct hmm_range *range);
 long hmm_range_fault(struct hmm_range *range, bool block);
@@ -462,7 +484,8 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 	range->pfn_flags_mask = -1UL;
 
 	ret = hmm_range_register(range, range->vma->vm_mm,
-				 range->start, range->end);
+				 range->start, range->end,
+				 PAGE_SHIFT);
 	if (ret)
 		return (int)ret;
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 0e21d3594ab6..9140cee24d36 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -391,11 +391,13 @@ static int hmm_vma_walk_hole_(unsigned long addr, unsigned long end,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	uint64_t *pfns = range->pfns;
-	unsigned long i;
+	unsigned long i, page_size;
 
 	hmm_vma_walk->last = addr;
-	i = (addr - range->start) >> PAGE_SHIFT;
-	for (; addr < end; addr += PAGE_SIZE, i++) {
+	page_size = hmm_range_page_size(range);
+	i = (addr - range->start) >> range->page_shift;
+
+	for (; addr < end; addr += page_size, i++) {
 		pfns[i] = range->values[HMM_PFN_NONE];
 		if (fault || write_fault) {
 			int ret;
@@ -707,6 +709,69 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	return 0;
 }
 
+static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
+				      unsigned long start, unsigned long end,
+				      struct mm_walk *walk)
+{
+#ifdef CONFIG_HUGETLB_PAGE
+	unsigned long addr = start, i, pfn, mask, size, pfn_inc;
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
+	struct vm_area_struct *vma = walk->vma;
+	struct hstate *h = hstate_vma(vma);
+	uint64_t orig_pfn, cpu_flags;
+	bool fault, write_fault;
+	spinlock_t *ptl;
+	pte_t entry;
+	int ret = 0;
+
+	size = 1UL << huge_page_shift(h);
+	mask = size - 1;
+	if (range->page_shift != PAGE_SHIFT) {
+		/* Make sure we are looking at full page. */
+		if (start & mask)
+			return -EINVAL;
+		if (end < (start + size))
+			return -EINVAL;
+		pfn_inc = size >> PAGE_SHIFT;
+	} else {
+		pfn_inc = 1;
+		size = PAGE_SIZE;
+	}
+
+
+	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
+	entry = huge_ptep_get(pte);
+
+	i = (start - range->start) >> range->page_shift;
+	orig_pfn = range->pfns[i];
+	range->pfns[i] = range->values[HMM_PFN_NONE];
+	cpu_flags = pte_to_hmm_pfn_flags(range, entry);
+	fault = write_fault = false;
+	hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
+			   &fault, &write_fault);
+	if (fault || write_fault) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	pfn = pte_pfn(entry) + (start & mask);
+	for (; addr < end; addr += size, i++, pfn += pfn_inc)
+		range->pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
+	hmm_vma_walk->last = end;
+
+unlock:
+	spin_unlock(ptl);
+
+	if (ret == -ENOENT)
+		return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
+
+	return ret;
+#else /* CONFIG_HUGETLB_PAGE */
+	return -EINVAL;
+#endif
+}
+
 static void hmm_pfns_clear(struct hmm_range *range,
 			   uint64_t *pfns,
 			   unsigned long addr,
@@ -730,6 +795,7 @@ static void hmm_pfns_special(struct hmm_range *range)
  * @mm: the mm struct for the range of virtual address
  * @start: start virtual address (inclusive)
  * @end: end virtual address (exclusive)
+ * @page_shift: expect page shift for the range
  * Returns 0 on success, -EFAULT if the address space is no longer valid
  *
  * Track updates to the CPU page table see include/linux/hmm.h
@@ -737,16 +803,20 @@ static void hmm_pfns_special(struct hmm_range *range)
 int hmm_range_register(struct hmm_range *range,
 		       struct mm_struct *mm,
 		       unsigned long start,
-		       unsigned long end)
+		       unsigned long end,
+		       unsigned page_shift)
 {
-	range->start = start & PAGE_MASK;
-	range->end = end & PAGE_MASK;
+	unsigned long mask = ((1UL << page_shift) - 1UL);
+
 	range->valid = false;
 	range->hmm = NULL;
 
-	if (range->start >= range->end)
+	if ((start & mask) || (end & mask))
+		return -EINVAL;
+	if (start >= end)
 		return -EINVAL;
 
+	range->page_shift = page_shift;
 	range->start = start;
 	range->end = end;
 
@@ -816,6 +886,7 @@ EXPORT_SYMBOL(hmm_range_unregister);
  */
 long hmm_range_snapshot(struct hmm_range *range)
 {
+	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	unsigned long start = range->start, end;
 	struct hmm_vma_walk hmm_vma_walk;
 	struct hmm *hmm = range->hmm;
@@ -832,15 +903,26 @@ long hmm_range_snapshot(struct hmm_range *range)
 			return -EAGAIN;
 
 		vma = find_vma(hmm->mm, start);
-		if (vma == NULL || (vma->vm_flags & VM_SPECIAL))
+		if (vma == NULL || (vma->vm_flags & device_vma))
 			return -EFAULT;
 
-		/* FIXME support hugetlb fs/dax */
-		if (is_vm_hugetlb_page(vma) || vma_is_dax(vma)) {
+		/* FIXME support dax */
+		if (vma_is_dax(vma)) {
 			hmm_pfns_special(range);
 			return -EINVAL;
 		}
 
+		if (is_vm_hugetlb_page(vma)) {
+			struct hstate *h = hstate_vma(vma);
+
+			if (huge_page_shift(h) != range->page_shift &&
+			    range->page_shift != PAGE_SHIFT)
+				return -EINVAL;
+		} else {
+			if (range->page_shift != PAGE_SHIFT)
+				return -EINVAL;
+		}
+
 		if (!(vma->vm_flags & VM_READ)) {
 			/*
 			 * If vma do not allow read access, then assume that it
@@ -866,6 +948,7 @@ long hmm_range_snapshot(struct hmm_range *range)
 		mm_walk.hugetlb_entry = NULL;
 		mm_walk.pmd_entry = hmm_vma_walk_pmd;
 		mm_walk.pte_hole = hmm_vma_walk_hole;
+		mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
 
 		walk_page_range(start, end, &mm_walk);
 		start = end;
@@ -884,7 +967,7 @@ EXPORT_SYMBOL(hmm_range_snapshot);
  *          then one of the following values may be returned:
  *
  *           -EINVAL  invalid arguments or mm or virtual address are in an
- *                    invalid vma (ie either hugetlbfs or device file vma).
+ *                    invalid vma (for instance device file vma).
  *           -ENOMEM: Out of memory.
  *           -EPERM:  Invalid permission (for instance asking for write and
  *                    range is read only).
@@ -905,6 +988,7 @@ EXPORT_SYMBOL(hmm_range_snapshot);
  */
 long hmm_range_fault(struct hmm_range *range, bool block)
 {
+	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
 	unsigned long start = range->start, end;
 	struct hmm_vma_walk hmm_vma_walk;
 	struct hmm *hmm = range->hmm;
@@ -924,15 +1008,25 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 		}
 
 		vma = find_vma(hmm->mm, start);
-		if (vma == NULL || (vma->vm_flags & VM_SPECIAL))
+		if (vma == NULL || (vma->vm_flags & device_vma))
 			return -EFAULT;
 
-		/* FIXME support hugetlb fs/dax */
-		if (is_vm_hugetlb_page(vma) || vma_is_dax(vma)) {
+		/* FIXME support dax */
+		if (vma_is_dax(vma)) {
 			hmm_pfns_special(range);
 			return -EINVAL;
 		}
 
+		if (is_vm_hugetlb_page(vma)) {
+			if (huge_page_shift(hstate_vma(vma)) !=
+			    range->page_shift &&
+			    range->page_shift != PAGE_SHIFT)
+				return -EINVAL;
+		} else {
+			if (range->page_shift != PAGE_SHIFT)
+				return -EINVAL;
+		}
+
 		if (!(vma->vm_flags & VM_READ)) {
 			/*
 			 * If vma do not allow read access, then assume that it
@@ -959,6 +1053,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 		mm_walk.hugetlb_entry = NULL;
 		mm_walk.pmd_entry = hmm_vma_walk_pmd;
 		mm_walk.pte_hole = hmm_vma_walk_hole;
+		mm_walk.hugetlb_entry = hmm_vma_walk_hugetlb_entry;
 
 		do {
 			ret = walk_page_range(start, end, &mm_walk);
-- 
2.17.2

