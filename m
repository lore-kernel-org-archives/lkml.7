Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54384C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A80D20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558324405;
	bh=Lhoj44BvwCBT7Vq/+HvISGR7LjJbw/9Kq0Vm/LmiWTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OmVRIqWIW3e6xZelq2U6mqJn0jyGmJvQA5X5fmS4d454JXF4LTmQPYoMq+DE7H6W9
	 s3otzOjlav5Xu7Udz1M7h2AnZn0Yw/e80eDg8jCsM+81uuBQ0y1GJH6e4Lr5wNksPD
	 2zCDYAMYrYCZptLywITZrcIkq+qPepzjrU4LAM4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfETDxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:53:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfETDxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:53:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so6070042pgi.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 20:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89p7CoU4S9UFAIEQ4qQeLvyukcRmWZty6wgd/XamBhs=;
        b=Caux5HDngteXa5fZ7XLnDhpQOpZUHg9z6OGEBD9kplxhqTCkOkn0nPKyDUnZvR7BEZ
         hmroxWZ/B5nvgDPgtZNqJsSKb9b48wpHzo1a47mUlARGD2Jq4O84JWPUNl0x8PEJR+XV
         8BtzmWqjjyfomQd+a360QgYlvk6RLWze4t749nG67Rk4F65CS66g/47rULD44Uf+xKIl
         yoFtR9BmF8S2IJxiXuzRUxDzPObzJ+fjAJZSKvoLXNHnVgNVbLwHjr9jOWUkcA/fm6GD
         zdoHvjTRxs+QnEL/Ly5U+ix/mbq4UGyaHh0a9JDcAaojR+ydrDC6a853uXcm9G0k69il
         R1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=89p7CoU4S9UFAIEQ4qQeLvyukcRmWZty6wgd/XamBhs=;
        b=GPShbnt3vef6VB2qxFMbTAomwBOSS97EIz4lHY04trWyeO7YpmKO8d1ZCadoUwGgEZ
         HF0W2i9X8etuH7kZd4RML3D+bO3xJx2lXk3NVQKRIhzT+Go+6RaUfgHnb7wyY5JmiOA2
         f1cRPVWZJNAZiCpXU96mPw3mRPJni8ZZToRlbj3z+HBvbHunO6RYhAJ1tjhTQuPEJ7lI
         ScZUdc7a27KaLlasPjmNelEPBbzs2VDIHgasVE8FW7XaVLW1PvjrBfemqPmtFVD+DiOJ
         YToJ4kg5xpfli5GWoc3egRBwIxxBT1zkIG9gnTE0xD55hw4vuUf989OuqlXqLJGxpwKb
         ny4A==
X-Gm-Message-State: APjAAAWziwlLubx/5oMURBiEx8e5BSino1Af+Jh8UDsGv3XVHhuMgnoG
        b93no+PNk+dn92eWtnexIHk=
X-Google-Smtp-Source: APXvYqxd8/hhxsSgSvvNWTVzT+1zlZvV711Jl/ozMiRJDFxhSFYMXe5yIGw6TiA9hGerZo479aN1pg==
X-Received: by 2002:a62:82c1:: with SMTP id w184mr47287418pfd.171.1558324402213;
        Sun, 19 May 2019 20:53:22 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x66sm3312779pfx.139.2019.05.19.20.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 20:53:21 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 4/7] mm: factor out madvise's core functionality
Date:   Mon, 20 May 2019 12:52:51 +0900
Message-Id: <20190520035254.57579-5-minchan@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520035254.57579-1-minchan@kernel.org>
References: <20190520035254.57579-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch factor out madvise's core functionality so that upcoming
patch can reuse it without duplication.

It shouldn't change any behavior.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 168 +++++++++++++++++++++++++++------------------------
 1 file changed, 89 insertions(+), 79 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9a6698b56845..119e82e1f065 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -742,7 +742,8 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 	return 0;
 }
 
-static long madvise_dontneed_free(struct vm_area_struct *vma,
+static long madvise_dontneed_free(struct task_struct *tsk,
+				  struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
 				  int behavior)
@@ -754,8 +755,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	if (!userfaultfd_remove(vma, start, end)) {
 		*prev = NULL; /* mmap_sem has been dropped, prev is stale */
 
-		down_read(&current->mm->mmap_sem);
-		vma = find_vma(current->mm, start);
+		down_read(&tsk->mm->mmap_sem);
+		vma = find_vma(tsk->mm, start);
 		if (!vma)
 			return -ENOMEM;
 		if (start < vma->vm_start) {
@@ -802,7 +803,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
  * Application wants to free up the pages and associated backing store.
  * This is effectively punching a hole into the middle of a file.
  */
-static long madvise_remove(struct vm_area_struct *vma,
+static long madvise_remove(struct task_struct *tsk,
+				struct vm_area_struct *vma,
 				struct vm_area_struct **prev,
 				unsigned long start, unsigned long end)
 {
@@ -836,13 +838,13 @@ static long madvise_remove(struct vm_area_struct *vma,
 	get_file(f);
 	if (userfaultfd_remove(vma, start, end)) {
 		/* mmap_sem was not released by userfaultfd_remove() */
-		up_read(&current->mm->mmap_sem);
+		up_read(&tsk->mm->mmap_sem);
 	}
 	error = vfs_fallocate(f,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				offset, end - start);
 	fput(f);
-	down_read(&current->mm->mmap_sem);
+	down_read(&tsk->mm->mmap_sem);
 	return error;
 }
 
@@ -916,12 +918,13 @@ static int madvise_inject_error(int behavior,
 #endif
 
 static long
-madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
-		unsigned long start, unsigned long end, int behavior)
+madvise_vma(struct task_struct *tsk, struct vm_area_struct *vma,
+		struct vm_area_struct **prev, unsigned long start,
+		unsigned long end, int behavior)
 {
 	switch (behavior) {
 	case MADV_REMOVE:
-		return madvise_remove(vma, prev, start, end);
+		return madvise_remove(tsk, vma, prev, start, end);
 	case MADV_WILLNEED:
 		return madvise_willneed(vma, prev, start, end);
 	case MADV_COOL:
@@ -930,7 +933,8 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		return madvise_cold(vma, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
-		return madvise_dontneed_free(vma, prev, start, end, behavior);
+		return madvise_dontneed_free(tsk, vma, prev, start,
+						end, behavior);
 	default:
 		return madvise_behavior(vma, prev, start, end, behavior);
 	}
@@ -974,68 +978,8 @@ madvise_behavior_valid(int behavior)
 	}
 }
 
-/*
- * The madvise(2) system call.
- *
- * Applications can use madvise() to advise the kernel how it should
- * handle paging I/O in this VM area.  The idea is to help the kernel
- * use appropriate read-ahead and caching techniques.  The information
- * provided is advisory only, and can be safely disregarded by the
- * kernel without affecting the correct operation of the application.
- *
- * behavior values:
- *  MADV_NORMAL - the default behavior is to read clusters.  This
- *		results in some read-ahead and read-behind.
- *  MADV_RANDOM - the system should read the minimum amount of data
- *		on any access, since it is unlikely that the appli-
- *		cation will need more than what it asks for.
- *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
- *		once, so they can be aggressively read ahead, and
- *		can be freed soon after they are accessed.
- *  MADV_WILLNEED - the application is notifying the system to read
- *		some pages ahead.
- *  MADV_DONTNEED - the application is finished with the given range,
- *		so the kernel can free resources associated with it.
- *  MADV_FREE - the application marks pages in the given range as lazy free,
- *		where actual purges are postponed until memory pressure happens.
- *  MADV_REMOVE - the application wants to free up the given range of
- *		pages and associated backing store.
- *  MADV_DONTFORK - omit this area from child's address space when forking:
- *		typically, to avoid COWing pages pinned by get_user_pages().
- *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
- *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
- *              range after a fork.
- *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
- *  MADV_HWPOISON - trigger memory error handler as if the given memory range
- *		were corrupted by unrecoverable hardware memory failure.
- *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
- *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
- *		this area with pages of identical content from other such areas.
- *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
- *  MADV_HUGEPAGE - the application wants to back the given range by transparent
- *		huge pages in the future. Existing pages might be coalesced and
- *		new pages might be allocated as THP.
- *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
- *		transparent huge pages so the existing pages will not be
- *		coalesced into THP and new pages will not be allocated as THP.
- *  MADV_DONTDUMP - the application wants to prevent pages in the given range
- *		from being included in its core dump.
- *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
- *
- * return values:
- *  zero    - success
- *  -EINVAL - start + len < 0, start is not page-aligned,
- *		"behavior" is not a valid value, or application
- *		is attempting to release locked or shared pages,
- *		or the specified address range includes file, Huge TLB,
- *		MAP_SHARED or VMPFNMAP range.
- *  -ENOMEM - addresses in the specified range are not currently
- *		mapped, or are outside the AS of the process.
- *  -EIO    - an I/O error occurred while paging in data.
- *  -EBADF  - map exists, but area maps something that isn't a file.
- *  -EAGAIN - a kernel resource was temporarily unavailable.
- */
-SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
+static int madvise_core(struct task_struct *tsk, unsigned long start,
+			size_t len_in, int behavior)
 {
 	unsigned long end, tmp;
 	struct vm_area_struct *vma, *prev;
@@ -1071,10 +1015,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 
 	write = madvise_need_mmap_write(behavior);
 	if (write) {
-		if (down_write_killable(&current->mm->mmap_sem))
+		if (down_write_killable(&tsk->mm->mmap_sem))
 			return -EINTR;
 	} else {
-		down_read(&current->mm->mmap_sem);
+		down_read(&tsk->mm->mmap_sem);
 	}
 
 	/*
@@ -1082,7 +1026,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	 * ranges, just ignore them, but return -ENOMEM at the end.
 	 * - different from the way of handling in mlock etc.
 	 */
-	vma = find_vma_prev(current->mm, start, &prev);
+	vma = find_vma_prev(tsk->mm, start, &prev);
 	if (vma && start > vma->vm_start)
 		prev = vma;
 
@@ -1107,7 +1051,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, tmp, behavior);
+		error = madvise_vma(tsk, vma, &prev, start, tmp, behavior);
 		if (error)
 			goto out;
 		start = tmp;
@@ -1119,14 +1063,80 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 		if (prev)
 			vma = prev->vm_next;
 		else	/* madvise_remove dropped mmap_sem */
-			vma = find_vma(current->mm, start);
+			vma = find_vma(tsk->mm, start);
 	}
 out:
 	blk_finish_plug(&plug);
 	if (write)
-		up_write(&current->mm->mmap_sem);
+		up_write(&tsk->mm->mmap_sem);
 	else
-		up_read(&current->mm->mmap_sem);
+		up_read(&tsk->mm->mmap_sem);
 
 	return error;
 }
+
+/*
+ * The madvise(2) system call.
+ *
+ * Applications can use madvise() to advise the kernel how it should
+ * handle paging I/O in this VM area.  The idea is to help the kernel
+ * use appropriate read-ahead and caching techniques.  The information
+ * provided is advisory only, and can be safely disregarded by the
+ * kernel without affecting the correct operation of the application.
+ *
+ * behavior values:
+ *  MADV_NORMAL - the default behavior is to read clusters.  This
+ *		results in some read-ahead and read-behind.
+ *  MADV_RANDOM - the system should read the minimum amount of data
+ *		on any access, since it is unlikely that the appli-
+ *		cation will need more than what it asks for.
+ *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
+ *		once, so they can be aggressively read ahead, and
+ *		can be freed soon after they are accessed.
+ *  MADV_WILLNEED - the application is notifying the system to read
+ *		some pages ahead.
+ *  MADV_DONTNEED - the application is finished with the given range,
+ *		so the kernel can free resources associated with it.
+ *  MADV_FREE - the application marks pages in the given range as lazy free,
+ *		where actual purges are postponed until memory pressure happens.
+ *  MADV_REMOVE - the application wants to free up the given range of
+ *		pages and associated backing store.
+ *  MADV_DONTFORK - omit this area from child's address space when forking:
+ *		typically, to avoid COWing pages pinned by get_user_pages().
+ *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
+ *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
+ *              range after a fork.
+ *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
+ *  MADV_HWPOISON - trigger memory error handler as if the given memory range
+ *		were corrupted by unrecoverable hardware memory failure.
+ *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
+ *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
+ *		this area with pages of identical content from other such areas.
+ *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
+ *  MADV_HUGEPAGE - the application wants to back the given range by transparent
+ *		huge pages in the future. Existing pages might be coalesced and
+ *		new pages might be allocated as THP.
+ *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
+ *		transparent huge pages so the existing pages will not be
+ *		coalesced into THP and new pages will not be allocated as THP.
+ *  MADV_DONTDUMP - the application wants to prevent pages in the given range
+ *		from being included in its core dump.
+ *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
+ *
+ * return values:
+ *  zero    - success
+ *  -EINVAL - start + len < 0, start is not page-aligned,
+ *		"behavior" is not a valid value, or application
+ *		is attempting to release locked or shared pages,
+ *		or the specified address range includes file, Huge TLB,
+ *		MAP_SHARED or VMPFNMAP range.
+ *  -ENOMEM - addresses in the specified range are not currently
+ *		mapped, or are outside the AS of the process.
+ *  -EIO    - an I/O error occurred while paging in data.
+ *  -EBADF  - map exists, but area maps something that isn't a file.
+ *  -EAGAIN - a kernel resource was temporarily unavailable.
+ */
+SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
+{
+	return madvise_core(current, start, len_in, behavior);
+}
-- 
2.21.0.1020.gf2820cf01a-goog

