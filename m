Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC5C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2BC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfEOPLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:11:53 -0400
Received: from relay.sw.ru ([185.231.240.75]:36726 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbfEOPLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:11:51 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hQvZ2-0001XF-8q; Wed, 15 May 2019 18:11:28 +0300
Subject: [PATCH RFC 2/5] mm: Extend copy_vma()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        alexander.h.duyck@linux.intel.com, ira.weiny@intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, keescook@chromium.org,
        hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 15 May 2019 18:11:27 +0300
Message-ID: <155793308777.13922.13297821989540731131.stgit@localhost.localdomain>
In-Reply-To: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares the function to copy a vma between
two processes. Two new arguments are introduced.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/mm.h |    4 ++--
 mm/mmap.c          |   33 ++++++++++++++++++++++++---------
 mm/mremap.c        |    4 ++--
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0e8834ac32b7..afe07e4a76f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2329,8 +2329,8 @@ extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
-	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	struct mm_struct *, unsigned long addr, unsigned long len,
+	pgoff_t pgoff, bool *need_rmap_locks, bool clear_flags_ctx);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/mm/mmap.c b/mm/mmap.c
index 9cf52bdb22a8..46266f6825ae 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3194,19 +3194,21 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 }
 
 /*
- * Copy the vma structure to a new location in the same mm,
- * prior to moving page table entries, to effect an mremap move.
+ * Copy the vma structure to new location in the same vma
+ * prior to moving page table entries, to effect an mremap move;
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
-	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+				struct mm_struct *mm, unsigned long addr,
+				unsigned long len, pgoff_t pgoff,
+				bool *need_rmap_locks, bool clear_flags_ctx)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
-	struct mm_struct *mm = vma->vm_mm;
+	struct vm_userfaultfd_ctx uctx;
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma = true;
+	unsigned long flags;
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
@@ -3219,15 +3221,25 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
-	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx);
+
+	uctx = vma->vm_userfaultfd_ctx;
+	flags = vma->vm_flags;
+	if (clear_flags_ctx) {
+		uctx = NULL_VM_UFFD_CTX;
+		flags &= ~(VM_UFFD_MISSING | VM_UFFD_WP | VM_MERGEABLE |
+			   VM_LOCKED | VM_LOCKONFAULT | VM_WIPEONFORK |
+			   VM_DONTCOPY);
+	}
+
+	new_vma = vma_merge(mm, prev, addr, addr + len, flags, vma->anon_vma,
+			    vma->vm_file, pgoff, vma_policy(vma), uctx);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
 		 */
 		if (unlikely(vma_start >= new_vma->vm_start &&
-			     vma_start < new_vma->vm_end)) {
+			     vma_start < new_vma->vm_end) &&
+			     vma->vm_mm == mm) {
 			/*
 			 * The only way we can get a vma_merge with
 			 * self during an mremap is if the vma hasn't
@@ -3248,6 +3260,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
 			goto out;
+		new_vma->vm_mm = mm;
+		new_vma->vm_flags = flags;
+		new_vma->vm_userfaultfd_ctx = uctx;
 		new_vma->vm_start = addr;
 		new_vma->vm_end = addr + len;
 		new_vma->vm_pgoff = pgoff;
diff --git a/mm/mremap.c b/mm/mremap.c
index 37b5b2ad91be..9a96cfc28675 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -352,8 +352,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		return err;
 
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
-	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+	new_vma = copy_vma(&vma, mm, new_addr, new_len, new_pgoff,
+			   &need_rmap_locks, false);
 	if (!new_vma)
 		return -ENOMEM;
 

