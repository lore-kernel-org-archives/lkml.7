Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A55C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6086220652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100066;
	bh=UrUdY3htt2uLO4vYCHCd8aGmfEbM3Tw+iyZJf2diBbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aMNFzguoE5VKo8E/3/DpNUTBTdYwgapajVwpQPuxDTT0gihfBmvHiAZ/Jn3JzO3e9
	 p+Pb3N3NFb27exTqB66IzrxwrbcDjHmQQAfhX9a8FSmZvWH1AIo+nv3OTNRdvQW0Yg
	 9ois+QvZf1zhmEsj6PDqT/h7YlGP52A5UlL7fXb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfFIRF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388881AbfFIRF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:05:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A806A207E0;
        Sun,  9 Jun 2019 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099955;
        bh=UrUdY3htt2uLO4vYCHCd8aGmfEbM3Tw+iyZJf2diBbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqGQ6UP8aUawLzOaBA4z6wMnAP+jvvJUEGi9R8Ee8KZmm8A1GxgL5XtFD8Jb2+6Rd
         nUmM1N4dX9y0/Wrzlh4HPTnhN6xBsb16Tp/mk4oiErZIimP5VAEWJJM+10kNVrxVTT
         04Io3ldj1+R+kdN+0FKdCZGrtGnBEnUWhqrvMFbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 224/241] userfaultfd: dont pin the user memory in userfaultfd_file_create()
Date:   Sun,  9 Jun 2019 18:42:46 +0200
Message-Id: <20190609164155.163544955@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

commit d2005e3f41d4f9299e2df6a967c8beb5086967a9 upstream.

userfaultfd_file_create() increments mm->mm_users; this means that the
memory won't be unmapped/freed if mm owner exits/execs, and UFFDIO_COPY
after that can populate the orphaned mm more.

Change userfaultfd_file_create() and userfaultfd_ctx_put() to use
mm->mm_count to pin mm_struct.  This means that
atomic_inc_not_zero(mm->mm_users) is needed when we are going to
actually play with this memory.  Except handle_userfault() path doesn't
need this, the caller must already have a reference.

The patch adds the new trivial helper, mmget_not_zero(), it can have
more users.

Link: http://lkml.kernel.org/r/20160516172254.GA8595@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/userfaultfd.c      |   41 ++++++++++++++++++++++++++++-------------
 include/linux/sched.h |    7 ++++++-
 2 files changed, 34 insertions(+), 14 deletions(-)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -137,7 +137,7 @@ static void userfaultfd_ctx_put(struct u
 		VM_BUG_ON(waitqueue_active(&ctx->fault_wqh));
 		VM_BUG_ON(spin_is_locked(&ctx->fd_wqh.lock));
 		VM_BUG_ON(waitqueue_active(&ctx->fd_wqh));
-		mmput(ctx->mm);
+		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
 	}
 }
@@ -434,6 +434,9 @@ static int userfaultfd_release(struct in
 
 	ACCESS_ONCE(ctx->released) = true;
 
+	if (!mmget_not_zero(mm))
+		goto wakeup;
+
 	/*
 	 * Flush page faults out of all CPUs. NOTE: all page faults
 	 * must be retried without returning VM_FAULT_SIGBUS if
@@ -466,7 +469,8 @@ static int userfaultfd_release(struct in
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
 	up_write(&mm->mmap_sem);
-
+	mmput(mm);
+wakeup:
 	/*
 	 * After no new page faults can wait on this fault_*wqh, flush
 	 * the last page faults that may have been already waiting on
@@ -760,10 +764,12 @@ static int userfaultfd_register(struct u
 	start = uffdio_register.range.start;
 	end = start + uffdio_register.range.len;
 
+	ret = -ENOMEM;
+	if (!mmget_not_zero(mm))
+		goto out;
+
 	down_write(&mm->mmap_sem);
 	vma = find_vma_prev(mm, start, &prev);
-
-	ret = -ENOMEM;
 	if (!vma)
 		goto out_unlock;
 
@@ -864,6 +870,7 @@ static int userfaultfd_register(struct u
 	} while (vma && vma->vm_start < end);
 out_unlock:
 	up_write(&mm->mmap_sem);
+	mmput(mm);
 	if (!ret) {
 		/*
 		 * Now that we scanned all vmas we can already tell
@@ -902,10 +909,12 @@ static int userfaultfd_unregister(struct
 	start = uffdio_unregister.start;
 	end = start + uffdio_unregister.len;
 
+	ret = -ENOMEM;
+	if (!mmget_not_zero(mm))
+		goto out;
+
 	down_write(&mm->mmap_sem);
 	vma = find_vma_prev(mm, start, &prev);
-
-	ret = -ENOMEM;
 	if (!vma)
 		goto out_unlock;
 
@@ -998,6 +1007,7 @@ static int userfaultfd_unregister(struct
 	} while (vma && vma->vm_start < end);
 out_unlock:
 	up_write(&mm->mmap_sem);
+	mmput(mm);
 out:
 	return ret;
 }
@@ -1067,9 +1077,11 @@ static int userfaultfd_copy(struct userf
 		goto out;
 	if (uffdio_copy.mode & ~UFFDIO_COPY_MODE_DONTWAKE)
 		goto out;
-
-	ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
-			   uffdio_copy.len);
+	if (mmget_not_zero(ctx->mm)) {
+		ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
+				   uffdio_copy.len);
+		mmput(ctx->mm);
+	}
 	if (unlikely(put_user(ret, &user_uffdio_copy->copy)))
 		return -EFAULT;
 	if (ret < 0)
@@ -1110,8 +1122,11 @@ static int userfaultfd_zeropage(struct u
 	if (uffdio_zeropage.mode & ~UFFDIO_ZEROPAGE_MODE_DONTWAKE)
 		goto out;
 
-	ret = mfill_zeropage(ctx->mm, uffdio_zeropage.range.start,
-			     uffdio_zeropage.range.len);
+	if (mmget_not_zero(ctx->mm)) {
+		ret = mfill_zeropage(ctx->mm, uffdio_zeropage.range.start,
+				     uffdio_zeropage.range.len);
+		mmput(ctx->mm);
+	}
 	if (unlikely(put_user(ret, &user_uffdio_zeropage->zeropage)))
 		return -EFAULT;
 	if (ret < 0)
@@ -1289,12 +1304,12 @@ static struct file *userfaultfd_file_cre
 	ctx->released = false;
 	ctx->mm = current->mm;
 	/* prevent the mm struct to be freed */
-	atomic_inc(&ctx->mm->mm_users);
+	atomic_inc(&ctx->mm->mm_count);
 
 	file = anon_inode_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
 				  O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS));
 	if (IS_ERR(file)) {
-		mmput(ctx->mm);
+		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
 	}
 out:
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2614,12 +2614,17 @@ extern struct mm_struct * mm_alloc(void)
 
 /* mmdrop drops the mm and the page tables */
 extern void __mmdrop(struct mm_struct *);
-static inline void mmdrop(struct mm_struct * mm)
+static inline void mmdrop(struct mm_struct *mm)
 {
 	if (unlikely(atomic_dec_and_test(&mm->mm_count)))
 		__mmdrop(mm);
 }
 
+static inline bool mmget_not_zero(struct mm_struct *mm)
+{
+	return atomic_inc_not_zero(&mm->mm_users);
+}
+
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
 /* Grab a reference to a task's mm, if it is not already going away */


