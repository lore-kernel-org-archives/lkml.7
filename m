Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45544C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD7E2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfDZEyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:54:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZEyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:54:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0755A81DFE;
        Fri, 26 Apr 2019 04:54:05 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B896194A0;
        Fri, 26 Apr 2019 04:53:59 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 14/27] userfaultfd: wp: handle COW properly for uffd-wp
Date:   Fri, 26 Apr 2019 12:51:38 +0800
Message-Id: <20190426045151.19556-15-peterx@redhat.com>
In-Reply-To: <20190426045151.19556-1-peterx@redhat.com>
References: <20190426045151.19556-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 26 Apr 2019 04:54:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows uffd-wp to support write-protected pages for COW.

For example, the uffd write-protected PTE could also be write-protected
by other usages like COW or zero pages.  When that happens, we can't
simply set the write bit in the PTE since otherwise it'll change the
content of every single reference to the page.  Instead, we should do
the COW first if necessary, then handle the uffd-wp fault.

To correctly copy the page, we'll also need to carry over the
_PAGE_UFFD_WP bit if it was set in the original PTE.

For huge PMDs, we just simply split the huge PMDs where we want to
resolve an uffd-wp page fault always.  That matches what we do with
general huge PMD write protections.  In that way, we resolved the huge
PMD copy-on-write issue into PTE copy-on-write.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c   |  5 ++++-
 mm/mprotect.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ab98a1eb4702..965d974bb9bd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2299,7 +2299,10 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		if (pte_uffd_wp(vmf->orig_pte))
+			entry = pte_mkuffd_wp(entry);
+		else
+			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
 		 * pte with the new entry. This will avoid a race condition
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 732d9b6d1d21..1f40662182f8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -73,18 +73,18 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	flush_tlb_batched_pending(vma->vm_mm);
 	arch_enter_lazy_mmu_mode();
 	do {
+retry_pte:
 		oldpte = *pte;
 		if (pte_present(oldpte)) {
 			pte_t ptent;
 			bool preserve_write = prot_numa && pte_write(oldpte);
+			struct page *page;
 
 			/*
 			 * Avoid trapping faults against the zero or KSM
 			 * pages. See similar comment in change_huge_pmd.
 			 */
 			if (prot_numa) {
-				struct page *page;
-
 				page = vm_normal_page(vma, addr, oldpte);
 				if (!page || PageKsm(page))
 					continue;
@@ -114,6 +114,45 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 					continue;
 			}
 
+			/*
+			 * Detect whether we'll need to COW before
+			 * resolving an uffd-wp fault.  Note that this
+			 * includes detection of the zero page (where
+			 * page==NULL)
+			 */
+			if (uffd_wp_resolve) {
+				struct vm_fault vmf = {
+					.vma = vma,
+					.address = addr & PAGE_MASK,
+					.orig_pte = oldpte,
+					.pmd = pmd,
+					.pte = pte,
+					.ptl = ptl,
+				};
+				vm_fault_t ret;
+
+				/* If the fault is resolved already, skip */
+				if (!pte_uffd_wp(*pte))
+					continue;
+
+				arch_leave_lazy_mmu_mode();
+				/* With PTE lock held */
+				ret = do_wp_page_cont(&vmf);
+				if (ret != VM_FAULT_WRITE && ret != 0)
+					/* Probably OOM */
+					return pages;
+				pte = pte_offset_map_lock(vma->vm_mm, pmd,
+							  addr, &ptl);
+				arch_enter_lazy_mmu_mode();
+				if (ret == 0 || !pte_present(*pte))
+					/*
+					 * This PTE could have been modified
+					 * during or after COW before taking
+					 * the lock; retry.
+					 */
+					goto retry_pte;
+			}
+
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
 			ptent = pte_modify(oldpte, newprot);
 			if (preserve_write)
@@ -183,6 +222,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	unsigned long pages = 0;
 	unsigned long nr_huge_updates = 0;
 	struct mmu_notifier_range range;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	range.start = 0;
 
@@ -202,7 +242,16 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		}
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
+			/*
+			 * When resolving an userfaultfd write
+			 * protection fault, it's not easy to identify
+			 * whether a THP is shared with others and
+			 * whether we'll need to do copy-on-write, so
+			 * just split it always for now to simply the
+			 * procedure.  And that's the policy too for
+			 * general THP write-protect in af9e4d5f2de2.
+			 */
+			if (next - addr != HPAGE_PMD_SIZE || uffd_wp_resolve) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-- 
2.17.1

