Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9370CC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7885520896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406514AbfFKUXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:23:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42393 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406489AbfFKUXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:23:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hanJA-0007e5-Hf; Tue, 11 Jun 2019 14:23:52 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hanJ0-0004Mt-F4; Tue, 11 Jun 2019 14:23:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jann Horn <jannh@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
Date:   Tue, 11 Jun 2019 15:23:27 -0500
Message-ID: <87d0jj6fcw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hanJ0-0004Mt-F4;;;mid=<87d0jj6fcw.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX189A/VSwxzSPDX2+S4ja+GoE9kSbIKyFe0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] Minor ptrace fixes for v5.2-rc5
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD:f6581f5b55141a95657ef5742cf6a6bfa20a109f ptrace: restore smp_rmb() in __ptrace_may_access()

This is just two very minor fixes.  Preventing ptrace from reading
unitialized kernel memory found twice by syzkaller, and restoring a
missing smp_rmb in ptrace_may_access and commening it so it is not
removed by accident again.

Apologies for being a little slow about getting this to you, I am still
figuring out how to develop with a little baby in the house.


Eric W. Biederman (1):
      signal/ptrace: Don't leak unitialized kernel memory with PTRACE_PEEK_SIGINFO

Jann Horn (1):
      ptrace: restore smp_rmb() in __ptrace_may_access()

 kernel/cred.c   |  9 +++++++++
 kernel/ptrace.c | 20 ++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..07e069d00696 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -450,6 +450,15 @@ int commit_creds(struct cred *new)
 		if (task->mm)
 			set_dumpable(task->mm, suid_dumpable);
 		task->pdeath_signal = 0;
+		/*
+		 * If a task drops privileges and becomes nondumpable,
+		 * the dumpability change must become visible before
+		 * the credential change; otherwise, a __ptrace_may_access()
+		 * racing with this change may be able to attach to a task it
+		 * shouldn't be able to attach to (as if the task had dropped
+		 * privileges without becoming nondumpable).
+		 * Pairs with a read barrier in __ptrace_may_access().
+		 */
 		smp_wmb();
 	}
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..c9b4646ad375 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -323,6 +323,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	return -EPERM;
 ok:
 	rcu_read_unlock();
+	/*
+	 * If a task drops privileges and becomes nondumpable (through a syscall
+	 * like setresuid()) while we are trying to access it, we must ensure
+	 * that the dumpability is read after the credentials; otherwise,
+	 * we may be able to attach to a task that we shouldn't be able to
+	 * attach to (as if the task had dropped privileges without becoming
+	 * nondumpable).
+	 * Pairs with a write barrier in commit_creds().
+	 */
+	smp_rmb();
 	mm = task->mm;
 	if (mm &&
 	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
@@ -704,6 +714,10 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 	if (arg.nr < 0)
 		return -EINVAL;
 
+	/* Ensure arg.off fits in an unsigned long */
+	if (arg.off > ULONG_MAX)
+		return 0;
+
 	if (arg.flags & PTRACE_PEEKSIGINFO_SHARED)
 		pending = &child->signal->shared_pending;
 	else
@@ -711,18 +725,20 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 
 	for (i = 0; i < arg.nr; ) {
 		kernel_siginfo_t info;
-		s32 off = arg.off + i;
+		unsigned long off = arg.off + i;
+		bool found = false;
 
 		spin_lock_irq(&child->sighand->siglock);
 		list_for_each_entry(q, &pending->list, list) {
 			if (!off--) {
+				found = true;
 				copy_siginfo(&info, &q->info);
 				break;
 			}
 		}
 		spin_unlock_irq(&child->sighand->siglock);
 
-		if (off >= 0) /* beyond the end of the list */
+		if (!found) /* beyond the end of the list */
 			break;
 
 #ifdef CONFIG_COMPAT



Eric
