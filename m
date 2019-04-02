Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF7FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9802133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfDBNmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:42:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43716 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731542AbfDBNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:12 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe4-0002oJ-6Y; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004xZ-U6; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Jerome Glisse" <jglisse@redhat.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Michal Hocko" <mhocko@suse.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.495820026@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 88/99] mm: migration: fix migration of huge PMD
 shared pages
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 017b1660df89f5fb4bfe66c34e35f7d2031100c7 upstream.

The page migration code employs try_to_unmap() to try and unmap the source
page.  This is accomplished by using rmap_walk to find all vmas where the
page is mapped.  This search stops when page mapcount is zero.  For shared
PMD huge pages, the page map count is always 1 no matter the number of
mappings.  Shared mappings are tracked via the reference count of the PMD
page.  Therefore, try_to_unmap stops prematurely and does not completely
unmap all mappings of the source page.

This problem can result is data corruption as writes to the original
source page can happen after contents of the page are copied to the target
page.  Hence, data is lost.

This problem was originally seen as DB corruption of shared global areas
after a huge page was soft offlined due to ECC memory errors.  DB
developers noticed they could reproduce the issue by (hotplug) offlining
memory used to back huge pages.  A simple testcase can reproduce the
problem by creating a shared PMD mapping (note that this must be at least
PUD_SIZE in size and PUD_SIZE aligned (1GB on x86)), and using
migrate_pages() to migrate process pages between nodes while continually
writing to the huge pages being migrated.

To fix, have the try_to_unmap_one routine check for huge PMD sharing by
calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a shared
mapping it will be 'unshared' which removes the page table entry and drops
the reference on the PMD page.  After this, flush caches and TLB.

mmu notifiers are called before locking page tables, but we can not be
sure of PMD sharing until page tables are locked.  Therefore, check for
the possibility of PMD sharing before locking so that notifiers can
prepare for the worst possible case.

Link: http://lkml.kernel.org/r/20180823205917.16297-2-mike.kravetz@oracle.com
[mike.kravetz@oracle.com: make _range_in_vma() a static inline]
  Link: http://lkml.kernel.org/r/6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com
Fixes: 39dde65c9940 ("shared page table for hugetlb page")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported from 4.4 to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/hugetlb.h | 14 +++++++++++
 include/linux/mm.h      |  6 +++++
 mm/hugetlb.c            | 37 +++++++++++++++++++++++++--
 mm/rmap.c               | 56 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 2 deletions(-)

--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -97,6 +97,8 @@ pte_t *huge_pte_alloc(struct mm_struct *
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr);
 int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep);
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end);
 struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
 			      int write);
 struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
@@ -124,6 +126,18 @@ static inline unsigned long hugetlb_tota
 	return 0;
 }
 
+static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr,
+						pte_t *ptep)
+{
+	return 0;
+}
+
+static inline void adjust_range_if_pmd_sharing_possible(
+				struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
+
 #define follow_hugetlb_page(m,v,p,vs,a,b,i,w)	({ BUG(); 0; })
 #define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1947,6 +1947,12 @@ static inline struct vm_area_struct *fin
 	return vma;
 }
 
+static inline bool range_in_vma(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end)
+{
+	return (vma && vma->vm_start <= start && end <= vma->vm_end);
+}
+
 #ifdef CONFIG_MMU
 pgprot_t vm_get_page_prot(unsigned long vm_flags);
 #else
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3657,13 +3657,41 @@ static int vma_shareable(struct vm_area_
 	/*
 	 * check on proper vm_flags and page table alignment
 	 */
-	if (vma->vm_flags & VM_MAYSHARE &&
-	    vma->vm_start <= base && end <= vma->vm_end)
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
 		return 1;
 	return 0;
 }
 
 /*
+ * Determine if start,end range within vma could be mapped by shared pmd.
+ * If yes, adjust start and end to cover range associated with possible
+ * shared pmd mappings.
+ */
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+	unsigned long check_addr = *start;
+
+	if (!(vma->vm_flags & VM_MAYSHARE))
+		return;
+
+	for (check_addr = *start; check_addr < *end; check_addr += PUD_SIZE) {
+		unsigned long a_start = check_addr & PUD_MASK;
+		unsigned long a_end = a_start + PUD_SIZE;
+
+		/*
+		 * If sharing is possible, adjust start/end if necessary.
+		 */
+		if (range_in_vma(vma, a_start, a_end)) {
+			if (a_start < *start)
+				*start = a_start;
+			if (a_end > *end)
+				*end = a_end;
+		}
+	}
+}
+
+/*
  * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
  * and returns the corresponding pte. While this is not necessary for the
  * !shared pmd case because we can allocate the pmd later as well, it makes the
@@ -3751,6 +3779,11 @@ pte_t *huge_pmd_share(struct mm_struct *
 {
 	return NULL;
 }
+
+void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
 #define want_pmd_share()	(0)
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1195,12 +1195,41 @@ static int try_to_unmap_one(struct page
 	pte_t pteval;
 	spinlock_t *ptl;
 	int ret = SWAP_AGAIN;
+	unsigned long sh_address;
+	bool pmd_sharing_possible = false;
+	unsigned long spmd_start, spmd_end;
 	enum ttu_flags flags = (enum ttu_flags)arg;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
 		goto out;
 
+	/*
+	 * Only use the range_start/end mmu notifiers if huge pmd sharing
+	 * is possible.  In the normal case, mmu_notifier_invalidate_page
+	 * is sufficient as we only unmap a page.  However, if we unshare
+	 * a pmd, we will unmap a PUD_SIZE range.
+	 */
+	if (PageHuge(page)) {
+		spmd_start = address;
+		spmd_end = spmd_start + vma_mmu_pagesize(vma);
+
+		/*
+		 * Check if pmd sharing is possible.  If possible, we could
+		 * unmap a PUD_SIZE range.  spmd_start/spmd_end will be
+		 * modified if sharing is possible.
+		 */
+		adjust_range_if_pmd_sharing_possible(vma, &spmd_start,
+								&spmd_end);
+		if (spmd_end - spmd_start != vma_mmu_pagesize(vma)) {
+			sh_address = address;
+
+			pmd_sharing_possible = true;
+			mmu_notifier_invalidate_range_start(vma->vm_mm,
+							spmd_start, spmd_end);
+		}
+	}
+
 	pte = page_check_address(page, mm, address, &ptl, 0);
 	if (!pte)
 		goto out;
@@ -1227,6 +1256,30 @@ static int try_to_unmap_one(struct page
 		}
   	}
 
+	/*
+	 * Call huge_pmd_unshare to potentially unshare a huge pmd.  Pass
+	 * sh_address as it will be modified if unsharing is successful.
+	 */
+	if (PageHuge(page) && huge_pmd_unshare(mm, &sh_address, pte)) {
+		/*
+		 * huge_pmd_unshare unmapped an entire PMD page.  There is
+		 * no way of knowing exactly which PMDs may be cached for
+		 * this mm, so flush them all.  spmd_start/spmd_end cover
+		 * this PUD_SIZE range.
+		 */
+		flush_cache_range(vma, spmd_start, spmd_end);
+		flush_tlb_range(vma, spmd_start, spmd_end);
+
+		/*
+		 * The ref count of the PMD page was dropped which is part
+		 * of the way map counting is done for shared PMDs.  When
+		 * there is no other sharing, huge_pmd_unshare returns false
+		 * and we will unmap the actual page and drop map count
+		 * to zero.
+		 */
+		goto out_unmap;
+	}
+
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
@@ -1309,6 +1362,9 @@ out_unmap:
 	if (ret != SWAP_FAIL && ret != SWAP_MLOCK && !(flags & TTU_MUNLOCK))
 		mmu_notifier_invalidate_page(mm, address);
 out:
+	if (pmd_sharing_possible)
+		mmu_notifier_invalidate_range_end(vma->vm_mm,
+							spmd_start, spmd_end);
 	return ret;
 }
 

