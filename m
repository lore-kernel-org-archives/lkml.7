Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA20C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC3E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfEUExk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:53:40 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:60643 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEUExi (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 21 May 2019 00:53:38 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:53:37 +0200
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 05:53:06 +0100
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, mhocko@kernel.org,
        mgorman@techsingularity.net, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 05/14] mm: remove some BUG checks wrt mmap_sem
Date:   Mon, 20 May 2019 21:52:33 -0700
Message-Id: <20190521045242.24378-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190521045242.24378-1-dave@stgolabs.net>
References: <20190521045242.24378-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a collection of hacks that shamelessly remove
mmap_sem state checks in order to not have to teach file_operations
about range locking; for thp and huge pagecache: By dropping the
rwsem_is_locked checks in zap_pmd_range() and zap_pud_range() we can
avoid having to teach file_operations about mmrange. For example in
xfs: iomap_dio_rw() is called by .read_iter file callbacks.

We also avoid mmap_sem trylock in vm_insert_page(): The rules to
this function state that mmap_sem must be acquired by the caller:

- for write if used in f_op->mmap() (by far the most common case)
- for read if used from vma_op->fault()(with VM_MIXEDMAP)

The only exception is:
  mmap_vmcore()
   remap_vmalloc_range_partial()
      mmap_vmcore()

But there is no concurrency here, thus mmap_sem is not held.
After auditing the kernel, the following drivers use the fault
path and correctly set VM_MIXEDMAP):

.fault = etnaviv_gem_fault
.fault = udl_gem_fault
tegra_bo_fault()

As such, drop the reader trylock BUG_ON() for the common case.
This avoids having file_operations know about mmranges, as
mmap_sem is held during, mmap() for example.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/huge_mm.h | 2 --
 mm/memory.c             | 2 --
 mm/mmap.c               | 4 ++--
 mm/pagewalk.c           | 3 ---
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c150c21d..a4a9cfa78d8f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -194,7 +194,6 @@ static inline int is_swap_pmd(pmd_t pmd)
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_mm->mmap_sem), vma);
 	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
@@ -203,7 +202,6 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 		struct vm_area_struct *vma)
 {
-	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_mm->mmap_sem), vma);
 	if (pud_trans_huge(*pud) || pud_devmap(*pud))
 		return __pud_trans_huge_lock(pud, vma);
 	else
diff --git a/mm/memory.c b/mm/memory.c
index 9516c95108a1..73971f859035 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1212,7 +1212,6 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
@@ -1519,7 +1518,6 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 	if (!page_count(page))
 		return -EINVAL;
 	if (!(vma->vm_flags & VM_MIXEDMAP)) {
-		BUG_ON(down_read_trylock(&vma->vm_mm->mmap_sem));
 		BUG_ON(vma->vm_flags & VM_PFNMAP);
 		vma->vm_flags |= VM_MIXEDMAP;
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index af228ae3508d..a03ded49f9eb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3466,7 +3466,7 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
 		 * The LSB of head.next can't change from under us
 		 * because we hold the mm_all_locks_mutex.
 		 */
-		down_write_nest_lock(&anon_vma->root->rwsem, &mm->mmap_sem);
+		down_write(&mm->mmap_sem);
 		/*
 		 * We can safely modify head.next after taking the
 		 * anon_vma->root->rwsem. If some other vma in this mm shares
@@ -3496,7 +3496,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
 		 */
 		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
 			BUG();
-		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_sem);
+		down_write(&mm->mmap_sem);
 	}
 }
 
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c3084ff2569d..6246acf17054 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -303,8 +303,6 @@ int walk_page_range(unsigned long start, unsigned long end,
 	if (!walk->mm)
 		return -EINVAL;
 
-	VM_BUG_ON_MM(!rwsem_is_locked(&walk->mm->mmap_sem), walk->mm);
-
 	vma = find_vma(walk->mm, start);
 	do {
 		if (!vma) { /* after the last vma */
@@ -346,7 +344,6 @@ int walk_page_vma(struct vm_area_struct *vma, struct mm_walk *walk)
 	if (!walk->mm)
 		return -EINVAL;
 
-	VM_BUG_ON(!rwsem_is_locked(&walk->mm->mmap_sem));
 	VM_BUG_ON(!vma);
 	walk->vma = vma;
 	err = walk_page_test(vma->vm_start, vma->vm_end, walk);
-- 
2.16.4

