Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B412084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 02:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfFTCWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 22:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfFTCWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 22:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11A0C81F01;
        Thu, 20 Jun 2019 02:22:41 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6B151001E69;
        Thu, 20 Jun 2019 02:22:27 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 11/25] mm: merge parameters for change_protection()
Date:   Thu, 20 Jun 2019 10:19:54 +0800
Message-Id: <20190620022008.19172-12-peterx@redhat.com>
In-Reply-To: <20190620022008.19172-1-peterx@redhat.com>
References: <20190620022008.19172-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 02:22:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change_protection() was used by either the NUMA or mprotect() code,
there's one parameter for each of the callers (dirty_accountable and
prot_numa).  Further, these parameters are passed along the calls:

  - change_protection_range()
  - change_p4d_range()
  - change_pud_range()
  - change_pmd_range()
  - ...

Now we introduce a flag for change_protect() and all these helpers to
replace these parameters.  Then we can avoid passing multiple parameters
multiple times along the way.

More importantly, it'll greatly simplify the work if we want to
introduce any new parameters to change_protection().  In the follow up
patches, a new parameter for userfaultfd write protection will be
introduced.

No functional change at all.

Reviewed-by: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h |  2 +-
 include/linux/mm.h      | 14 +++++++++++++-
 mm/huge_memory.c        |  3 ++-
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 29 ++++++++++++++++-------------
 5 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c150c21d..a81a6ed609ac 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -46,7 +46,7 @@ extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			 pmd_t *old_pmd, pmd_t *new_pmd);
 extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, pgprot_t newprot,
-			int prot_numa);
+			unsigned long cp_flags);
 vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
 vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
 enum transparent_hugepage_flag {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dcaca899e4a8..a93ac1c37940 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1708,9 +1708,21 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
 		bool need_rmap_locks);
+
+/*
+ * Flags used by change_protection().  For now we make it a bitmap so
+ * that we can pass in multiple flags just like parameters.  However
+ * for now all the callers are only use one of the flags at the same
+ * time.
+ */
+/* Whether we should allow dirty bit accounting */
+#define  MM_CP_DIRTY_ACCT                  (1UL << 0)
+/* Whether this protection change is for NUMA hints */
+#define  MM_CP_PROT_NUMA                   (1UL << 1)
+
 extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
-			      int dirty_accountable, int prot_numa);
+			      unsigned long cp_flags);
 extern int mprotect_fixup(struct vm_area_struct *vma,
 			  struct vm_area_struct **pprev, unsigned long start,
 			  unsigned long end, unsigned long newflags);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9a6b32..b7149a0acac1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1903,13 +1903,14 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
  *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
  */
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, pgprot_t newprot, int prot_numa)
+		unsigned long addr, pgprot_t newprot, unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
 	pmd_t entry;
 	bool preserve_write;
 	int ret;
+	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 
 	ptl = __pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 01600d80ae01..dea6a49573e3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -575,7 +575,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 {
 	int nr_updated;
 
-	nr_updated = change_protection(vma, addr, end, PAGE_NONE, 0, 1);
+	nr_updated = change_protection(vma, addr, end, PAGE_NONE, MM_CP_PROT_NUMA);
 	if (nr_updated)
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index bf38dfbbb4b4..ae9caa4c6562 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -37,12 +37,14 @@
 
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
-		int dirty_accountable, int prot_numa)
+		unsigned long cp_flags)
 {
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
 	unsigned long pages = 0;
 	int target_node = NUMA_NO_NODE;
+	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
+	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
 
 	/*
 	 * Can be called with only the mmap_sem for reading by
@@ -163,7 +165,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -195,7 +197,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-						newprot, prot_numa);
+							      newprot, cp_flags);
 
 				if (nr_ptes) {
 					if (nr_ptes == HPAGE_PMD_NR) {
@@ -210,7 +212,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			/* fall through, the trans huge pmd just split */
 		}
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					      cp_flags);
 		pages += this_pages;
 next:
 		cond_resched();
@@ -226,7 +228,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -238,7 +240,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					  cp_flags);
 	} while (pud++, addr = next, addr != end);
 
 	return pages;
@@ -246,7 +248,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, unsigned long cp_flags)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -258,7 +260,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					  cp_flags);
 	} while (p4d++, addr = next, addr != end);
 
 	return pages;
@@ -266,7 +268,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 
 static unsigned long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
-		int dirty_accountable, int prot_numa)
+		unsigned long cp_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -283,7 +285,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+					  cp_flags);
 	} while (pgd++, addr = next, addr != end);
 
 	/* Only flush the TLB if we actually modified any entries: */
@@ -296,14 +298,15 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 
 unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
-		       int dirty_accountable, int prot_numa)
+		       unsigned long cp_flags)
 {
 	unsigned long pages;
 
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
 	else
-		pages = change_protection_range(vma, start, end, newprot, dirty_accountable, prot_numa);
+		pages = change_protection_range(vma, start, end, newprot,
+						cp_flags);
 
 	return pages;
 }
@@ -431,7 +434,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	vma_set_page_prot(vma);
 
 	change_protection(vma, start, end, vma->vm_page_prot,
-			  dirty_accountable, 0);
+			  dirty_accountable ? MM_CP_DIRTY_ACCT : 0);
 
 	/*
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
-- 
2.21.0

