Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440E1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A1E21909
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127414;
	bh=bH+Z5rRck1duTmUy5wuooyvQub6vGQuxQ6k5LuOND30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iqry8NguQTMpKANicgTxuPiNJr5nCFnukdiy259gvx1Jx2FNovbJ3qyCK6lfHhRbD
	 +AaziMz8vg9rUIGc9tvNDSBQjg0c4akSg242iLHeB8HEFayjZE7ZI8uXfpffo+6mQQ
	 k35lIudsca5D1lW6VlcDk5vxuTNkpcVmc/W4fHbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391800AbfDXRgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391535AbfDXRgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:49 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3861D21903;
        Wed, 24 Apr 2019 17:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127407;
        bh=bH+Z5rRck1duTmUy5wuooyvQub6vGQuxQ6k5LuOND30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Irxj5y9RykMFd8ZVGvgoQLcjTyGvoUk8mPbyR8SFvECk5+mhQs/XjKCnFgWhgebsf
         XhqcPfYT7x0+p7r8g59DWWk7hK3QlKLPyBDH3zlm3fDkHq0KQjnwwxidf4pDkcr3Ed
         b7pbM7G3AiEKW88Tr4t5U58Tdfua35/5VQ6a1QUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 081/115] coredump: fix race condition between mmget_not_zero()/get_task_mm() and core dumping
Date:   Wed, 24 Apr 2019 19:10:17 +0200
Message-Id: <20190424170929.708793092@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

commit 04f5866e41fb70690e28397487d8bd8eea7d712a upstream.

The core dumping code has always run without holding the mmap_sem for
writing, despite that is the only way to ensure that the entire vma
layout will not change from under it.  Only using some signal
serialization on the processes belonging to the mm is not nearly enough.
This was pointed out earlier.  For example in Hugh's post from Jul 2017:

  https://lkml.kernel.org/r/alpine.LSU.2.11.1707191716030.2055@eggly.anvils

  "Not strictly relevant here, but a related note: I was very surprised
   to discover, only quite recently, how handle_mm_fault() may be called
   without down_read(mmap_sem) - when core dumping. That seems a
   misguided optimization to me, which would also be nice to correct"

In particular because the growsdown and growsup can move the
vm_start/vm_end the various loops the core dump does around the vma will
not be consistent if page faults can happen concurrently.

Pretty much all users calling mmget_not_zero()/get_task_mm() and then
taking the mmap_sem had the potential to introduce unexpected side
effects in the core dumping code.

Adding mmap_sem for writing around the ->core_dump invocation is a
viable long term fix, but it requires removing all copy user and page
faults and to replace them with get_dump_page() for all binary formats
which is not suitable as a short term fix.

For the time being this solution manually covers the places that can
confuse the core dump either by altering the vma layout or the vma flags
while it runs.  Once ->core_dump runs under mmap_sem for writing the
function mmget_still_valid() can be dropped.

Allowing mmap_sem protected sections to run in parallel with the
coredump provides some minor parallelism advantage to the swapoff code
(which seems to be safe enough by never mangling any vma field and can
keep doing swapins in parallel to the core dumping) and to some other
corner case.

In order to facilitate the backporting I added "Fixes: 86039bd3b4e6"
however the side effect of this same race condition in /proc/pid/mem
should be reproducible since before 2.6.12-rc2 so I couldn't add any
other "Fixes:" because there's no hash beyond the git genesis commit.

Because find_extend_vma() is the only location outside of the process
context that could modify the "mm" structures under mmap_sem for
reading, by adding the mmget_still_valid() check to it, all other cases
that take the mmap_sem for reading don't need the new check after
mmget_not_zero()/get_task_mm().  The expand_stack() in page fault
context also doesn't need the new check, because all tasks under core
dumping are frozen.

Link: http://lkml.kernel.org/r/20190325224949.11068-1-aarcange@redhat.com
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: Jann Horn <jannh@google.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Jann Horn <jannh@google.com>
Acked-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_main.c |    3 +++
 fs/proc/task_mmu.c                    |   18 ++++++++++++++++++
 fs/userfaultfd.c                      |    9 +++++++++
 include/linux/sched/mm.h              |   21 +++++++++++++++++++++
 mm/mmap.c                             |    7 ++++++-
 5 files changed, 57 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -992,6 +992,8 @@ void uverbs_user_mmap_disassociate(struc
 		 * will only be one mm, so no big deal.
 		 */
 		down_write(&mm->mmap_sem);
+		if (!mmget_still_valid(mm))
+			goto skip_mm;
 		mutex_lock(&ufile->umap_lock);
 		list_for_each_entry_safe (priv, next_priv, &ufile->umaps,
 					  list) {
@@ -1006,6 +1008,7 @@ void uverbs_user_mmap_disassociate(struc
 			vma->vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
 		}
 		mutex_unlock(&ufile->umap_lock);
+	skip_mm:
 		up_write(&mm->mmap_sem);
 		mmput(mm);
 	}
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1141,6 +1141,24 @@ static ssize_t clear_refs_write(struct f
 					count = -EINTR;
 					goto out_mm;
 				}
+				/*
+				 * Avoid to modify vma->vm_flags
+				 * without locked ops while the
+				 * coredump reads the vm_flags.
+				 */
+				if (!mmget_still_valid(mm)) {
+					/*
+					 * Silently return "count"
+					 * like if get_task_mm()
+					 * failed. FIXME: should this
+					 * function have returned
+					 * -ESRCH if get_task_mm()
+					 * failed like if
+					 * get_proc_task() fails?
+					 */
+					up_write(&mm->mmap_sem);
+					goto out_mm;
+				}
 				for (vma = mm->mmap; vma; vma = vma->vm_next) {
 					vma->vm_flags &= ~VM_SOFTDIRTY;
 					vma_set_page_prot(vma);
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -629,6 +629,8 @@ static void userfaultfd_event_wait_compl
 
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		down_write(&mm->mmap_sem);
+		/* no task can run (and in turn coredump) yet */
+		VM_WARN_ON(!mmget_still_valid(mm));
 		for (vma = mm->mmap; vma; vma = vma->vm_next)
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
@@ -883,6 +885,8 @@ static int userfaultfd_release(struct in
 	 * taking the mmap_sem for writing.
 	 */
 	down_write(&mm->mmap_sem);
+	if (!mmget_still_valid(mm))
+		goto skip_mm;
 	prev = NULL;
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		cond_resched();
@@ -905,6 +909,7 @@ static int userfaultfd_release(struct in
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
+skip_mm:
 	up_write(&mm->mmap_sem);
 	mmput(mm);
 wakeup:
@@ -1333,6 +1338,8 @@ static int userfaultfd_register(struct u
 		goto out;
 
 	down_write(&mm->mmap_sem);
+	if (!mmget_still_valid(mm))
+		goto out_unlock;
 	vma = find_vma_prev(mm, start, &prev);
 	if (!vma)
 		goto out_unlock;
@@ -1520,6 +1527,8 @@ static int userfaultfd_unregister(struct
 		goto out;
 
 	down_write(&mm->mmap_sem);
+	if (!mmget_still_valid(mm))
+		goto out_unlock;
 	vma = find_vma_prev(mm, start, &prev);
 	if (!vma)
 		goto out_unlock;
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,27 @@ static inline void mmdrop(struct mm_stru
 		__mmdrop(mm);
 }
 
+/*
+ * This has to be called after a get_task_mm()/mmget_not_zero()
+ * followed by taking the mmap_sem for writing before modifying the
+ * vmas or anything the coredump pretends not to change from under it.
+ *
+ * NOTE: find_extend_vma() called from GUP context is the only place
+ * that can modify the "mm" (notably the vm_start/end) under mmap_sem
+ * for reading and outside the context of the process, so it is also
+ * the only case that holds the mmap_sem for reading that must call
+ * this function. Generally if the mmap_sem is hold for reading
+ * there's no need of this check after get_task_mm()/mmget_not_zero().
+ *
+ * This function can be obsoleted and the check can be removed, after
+ * the coredump code will hold the mmap_sem for writing before
+ * invoking the ->core_dump methods.
+ */
+static inline bool mmget_still_valid(struct mm_struct *mm)
+{
+	return likely(!mm->core_state);
+}
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pkeys.h>
 #include <linux/oom.h>
+#include <linux/sched/mm.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -2526,7 +2527,8 @@ find_extend_vma(struct mm_struct *mm, un
 	vma = find_vma_prev(mm, addr, &prev);
 	if (vma && (vma->vm_start <= addr))
 		return vma;
-	if (!prev || expand_stack(prev, addr))
+	/* don't alter vm_end if the coredump is running */
+	if (!prev || !mmget_still_valid(mm) || expand_stack(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED)
 		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
@@ -2552,6 +2554,9 @@ find_extend_vma(struct mm_struct *mm, un
 		return vma;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		return NULL;
+	/* don't alter vm_start if the coredump is running */
+	if (!mmget_still_valid(mm))
+		return NULL;
 	start = vma->vm_start;
 	if (expand_stack(vma, addr))
 		return NULL;


