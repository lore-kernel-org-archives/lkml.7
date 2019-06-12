Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F9C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B7D215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501872AbfFLO23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:28:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:43592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437660AbfFLO21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:28:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D542B026;
        Wed, 12 Jun 2019 14:28:26 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, gorcunov@gmail.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [RFC PATCH] binfmt_elf: Protect mm_struct access with mmap_sem
Date:   Wed, 12 Jun 2019 16:28:11 +0200
Message-Id: <20190612142811.24894-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_extend_vma assumes the caller holds mmap_sem as a reader (explained
in expand_downwards()). The path when we are extending the stack VMA to
accomodate argv[] pointers happens without the lock.

I was not able to cause an mm_struct corruption but
BUG_ON(!rwsem_is_locked(&mm->mmap_sem)) in find_extend_vma could be
triggered as

    # <bigfile xargs echo
    xargs: echo: terminated by signal 11

(bigfile needs to have more than RLIMIT_STACK / sizeof(char *) rows)

Other accesses to mm_struct in exec path are protected by mmap_sem, so
conservatively, protect also this one. Besides that, explain why we omit
mm_struct.arg_lock in the exec(2) path.

Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---

When I was attempting to reduce usage of mmap_sem I came across this
unprotected access and increased number of its holders :-/

I'm not sure whether there is a real concurrent writer at this early
stages (I considered khugepaged especially as setup_arg_pages invokes
khugepaged_enter_vma_merge but we're lucky because khugepaged skips it
because of VM_STACK_INCOMPLETE_SETUP).

A nicer approach would perhaps be to do all this exec setup when the
mm_struct is still not exposed via current->mm (and hence no need to
synchronize via mmap_sem). But I didn't look enough into binfmt specific
whether it is even doable and worth it.

So I'm sending this for a discussion.

 fs/binfmt_elf.c | 10 +++++++++-
 fs/exec.c       |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8264b468f283..48e169760a9c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -299,7 +299,11 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	 * Grow the stack manually; some architectures have a limit on how
 	 * far ahead a user-space access may be in order to grow the stack.
 	 */
+	if (down_read_killable(&current->mm->mmap_sem))
+		return -EINTR;
 	vma = find_extend_vma(current->mm, bprm->p);
+	up_read(&current->mm->mmap_sem);
+
 	if (!vma)
 		return -EFAULT;
 
@@ -1123,11 +1127,15 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
 
+	/*
+	 * Don't take mm->arg_lock. The concurrent change might happen only
+	 * from prctl_set_mm but after de_thread we are certainly alone here.
+	 */
 	retval = create_elf_tables(bprm, &loc->elf_ex,
 			  load_addr, interp_load_addr);
 	if (retval < 0)
 		goto out;
-	/* N.B. passed_fileno might not be initialized? */
+
 	current->mm->end_code = end_code;
 	current->mm->start_code = start_code;
 	current->mm->start_data = start_data;
diff --git a/fs/exec.c b/fs/exec.c
index 89a500bb897a..d5b55c92019a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -212,7 +212,8 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 
 	/*
 	 * We are doing an exec().  'current' is the process
-	 * doing the exec and bprm->mm is the new process's mm.
+	 * doing the exec and bprm->mm is the new process's mm that is not
+	 * shared yet, so no synchronization on mmap_sem.
 	 */
 	ret = get_user_pages_remote(current, bprm->mm, pos, 1, gup_flags,
 			&page, NULL, NULL);
-- 
2.21.0

