Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C116C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E972464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLFNyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:54:35 -0500
Received: from foss.arm.com ([217.140.110.172]:44886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfLFNyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 661AD1FB;
        Fri,  6 Dec 2019 05:54:30 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A598D3F718;
        Fri,  6 Dec 2019 05:54:27 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v16 16/25] mm: pagewalk: Add 'depth' parameter to pte_hole
Date:   Fri,  6 Dec 2019 13:53:07 +0000
Message-Id: <20191206135316.47703-17-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191206135316.47703-1-steven.price@arm.com>
References: <20191206135316.47703-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pte_hole() callback is called at multiple levels of the page tables.
Code dumping the kernel page tables needs to know what at what depth
the missing entry is. Add this is an extra parameter to pte_hole().
When the depth isn't know (e.g. processing a vma) then -1 is passed.

The depth that is reported is the actual level where the entry is
missing (ignoring any folding that is in place), i.e. any levels where
PTRS_PER_P?D is set to 1 are ignored.

Note that depth starts at 0 for a PGD so that PUD/PMD/PTE retain their
natural numbers as levels 2/3/4.

Tested-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 fs/proc/task_mmu.c       |  4 ++--
 include/linux/pagewalk.h |  7 +++++--
 mm/hmm.c                 |  8 ++++----
 mm/migrate.c             |  5 +++--
 mm/mincore.c             |  1 +
 mm/pagewalk.c            | 31 +++++++++++++++++++++++++------
 6 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9442631fd4af..3ba9ae83bff5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -505,7 +505,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 
 #ifdef CONFIG_SHMEM
 static int smaps_pte_hole(unsigned long addr, unsigned long end,
-		struct mm_walk *walk)
+			  __always_unused int depth, struct mm_walk *walk)
 {
 	struct mem_size_stats *mss = walk->private;
 
@@ -1282,7 +1282,7 @@ static int add_to_pagemap(unsigned long addr, pagemap_entry_t *pme,
 }
 
 static int pagemap_pte_hole(unsigned long start, unsigned long end,
-				struct mm_walk *walk)
+			    __always_unused int depth, struct mm_walk *walk)
 {
 	struct pagemapread *pm = walk->private;
 	unsigned long addr = start;
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 84ac77620bfc..c33b47358e9f 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -17,7 +17,10 @@ struct mm_walk;
  *			split_huge_page() instead of handling it explicitly.
  * @pte_entry:		if set, called for each non-empty PTE (lowest-level)
  *			entry
- * @pte_hole:		if set, called for each hole at all levels
+ * @pte_hole:		if set, called for each hole at all levels,
+ *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD
+ *			4:PTE. Any folded depths (where PTRS_PER_P?D is equal
+ *			to 1) are skipped.
  * @hugetlb_entry:	if set, called for each hugetlb entry
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
@@ -48,7 +51,7 @@ struct mm_walk_ops {
 	int (*pte_entry)(pte_t *pte, unsigned long addr,
 			 unsigned long next, struct mm_walk *walk);
 	int (*pte_hole)(unsigned long addr, unsigned long next,
-			struct mm_walk *walk);
+			int depth, struct mm_walk *walk);
 	int (*hugetlb_entry)(pte_t *pte, unsigned long hmask,
 			     unsigned long addr, unsigned long next,
 			     struct mm_walk *walk);
diff --git a/mm/hmm.c b/mm/hmm.c
index d379cb6496ae..981f9f8614f2 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -186,7 +186,7 @@ static void hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 }
 
 static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
-			     struct mm_walk *walk)
+			     __always_unused int depth, struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -380,7 +380,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 again:
 	pmd = READ_ONCE(*pmdp);
 	if (pmd_none(pmd))
-		return hmm_vma_walk_hole(start, end, walk);
+		return hmm_vma_walk_hole(start, end, -1, walk);
 
 	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
 		bool fault, write_fault;
@@ -482,7 +482,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 again:
 	pud = READ_ONCE(*pudp);
 	if (pud_none(pud))
-		return hmm_vma_walk_hole(start, end, walk);
+		return hmm_vma_walk_hole(start, end, -1, walk);
 
 	if (pud_huge(pud) && pud_devmap(pud)) {
 		unsigned long i, npages, pfn;
@@ -490,7 +490,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		bool fault, write_fault;
 
 		if (!pud_present(pud))
-			return hmm_vma_walk_hole(start, end, walk);
+			return hmm_vma_walk_hole(start, end, -1, walk);
 
 		i = (addr - range->start) >> PAGE_SHIFT;
 		npages = (end - addr) >> PAGE_SHIFT;
diff --git a/mm/migrate.c b/mm/migrate.c
index eae1565285e3..616cd1ed04dd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2119,6 +2119,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 #ifdef CONFIG_DEVICE_PRIVATE
 static int migrate_vma_collect_hole(unsigned long start,
 				    unsigned long end,
+				    __always_unused int depth,
 				    struct mm_walk *walk)
 {
 	struct migrate_vma *migrate = walk->private;
@@ -2163,7 +2164,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 again:
 	if (pmd_none(*pmdp))
-		return migrate_vma_collect_hole(start, end, walk);
+		return migrate_vma_collect_hole(start, end, -1, walk);
 
 	if (pmd_trans_huge(*pmdp)) {
 		struct page *page;
@@ -2196,7 +2197,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				return migrate_vma_collect_skip(start, end,
 								walk);
 			if (pmd_none(*pmdp))
-				return migrate_vma_collect_hole(start, end,
+				return migrate_vma_collect_hole(start, end, -1,
 								walk);
 		}
 	}
diff --git a/mm/mincore.c b/mm/mincore.c
index 49b6fa2f6aa1..0e6dd9948f1a 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -112,6 +112,7 @@ static int __mincore_unmapped_range(unsigned long addr, unsigned long end,
 }
 
 static int mincore_unmapped_range(unsigned long addr, unsigned long end,
+				   __always_unused int depth,
 				   struct mm_walk *walk)
 {
 	walk->private += __mincore_unmapped_range(addr, end,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 83ab6c1ebf9b..7e13f2f5f4c5 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -4,6 +4,22 @@
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
 
+/*
+ * We want to know the real level where a entry is located ignoring any
+ * folding of levels which may be happening. For example if p4d is folded then
+ * a missing entry found at level 1 (p4d) is actually at level 0 (pgd).
+ */
+static int real_depth(int depth)
+{
+	if (depth == 3 && PTRS_PER_PMD == 1)
+		depth = 2;
+	if (depth == 2 && PTRS_PER_PUD == 1)
+		depth = 1;
+	if (depth == 1 && PTRS_PER_P4D == 1)
+		depth = 0;
+	return depth;
+}
+
 static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
@@ -37,6 +53,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
+	int depth = real_depth(3);
 
 	if (ops->test_pmd) {
 		err = ops->test_pmd(addr, end, pmd_offset(pud, 0UL), walk);
@@ -52,7 +69,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
-				err = ops->pte_hole(addr, next, walk);
+				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
 			continue;
@@ -96,6 +113,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
+	int depth = real_depth(2);
 
 	if (ops->test_pud) {
 		err = ops->test_pud(addr, end, pud_offset(p4d, 0UL), walk);
@@ -111,7 +129,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
-				err = ops->pte_hole(addr, next, walk);
+				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
 			continue;
@@ -147,6 +165,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
 	int err = 0;
+	int depth = real_depth(1);
 
 	if (ops->test_p4d) {
 		err = ops->test_p4d(addr, end, p4d_offset(pgd, 0UL), walk);
@@ -161,7 +180,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
 			if (ops->pte_hole)
-				err = ops->pte_hole(addr, next, walk);
+				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
 			continue;
@@ -193,7 +212,7 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
 			if (ops->pte_hole)
-				err = ops->pte_hole(addr, next, walk);
+				err = ops->pte_hole(addr, next, 0, walk);
 			if (err)
 				break;
 			continue;
@@ -240,7 +259,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
 		if (pte)
 			err = ops->hugetlb_entry(pte, hmask, addr, next, walk);
 		else if (ops->pte_hole)
-			err = ops->pte_hole(addr, next, walk);
+			err = ops->pte_hole(addr, next, -1, walk);
 
 		if (err)
 			break;
@@ -284,7 +303,7 @@ static int walk_page_test(unsigned long start, unsigned long end,
 	if (vma->vm_flags & VM_PFNMAP) {
 		int err = 1;
 		if (ops->pte_hole)
-			err = ops->pte_hole(start, end, walk);
+			err = ops->pte_hole(start, end, -1, walk);
 		return err ? err : 1;
 	}
 	return 0;
-- 
2.20.1

