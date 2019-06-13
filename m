Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A99C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321E521743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFMPcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:32:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:45242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbfFMKr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:47:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C775AE4B;
        Thu, 13 Jun 2019 10:47:25 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     mkoutny@suse.com
Cc:     gorcunov@gmail.com, ktkhai@virtuozzo.com, ldufour@linux.ibm.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v2] binfmt_elf: Protect mm_struct access with mmap_sem
Date:   Thu, 13 Jun 2019 12:47:15 +0200
Message-Id: <20190613104715.22367-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612142811.24894-1-mkoutny@suse.com>
References: <20190612142811.24894-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_extend_vma assumes the caller holds mmap_sem as a reader (explained
in expand_downwards()). The path when we are extending the stack VMA to
accommodate argv[] pointers happens without the lock.

I was not able to cause an mm_struct corruption but an inserted
BUG_ON(!rwsem_is_locked(&mm->mmap_sem)) in find_extend_vma could be
triggered as

    # <bigfile xargs echo
    xargs: echo: terminated by signal 11

(bigfile needs to have more than RLIMIT_STACK / sizeof(char *) rows)

Other accesses to mm_struct in exec path are protected by mmap_sem, so
conservatively, protect also this one.
Besides that, explain in comments why we omit mm_struct.arg_lock in the
exec(2) path and drop an obsolete comment about removed passed_fileno.

v2: Updated changelog

Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
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

