Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F40C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61A320C01
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfGNQUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 12:20:51 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:49318 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfGNQUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 12:20:51 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D483072CA65;
        Sun, 14 Jul 2019 19:20:47 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id A66A07CCE3A; Sun, 14 Jul 2019 19:20:47 +0300 (MSK)
Date:   Sun, 14 Jul 2019 19:20:47 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Anatoly Pugachev <matorola@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clone: fix CLONE_PIDFD support
Message-ID: <20190714162047.GB10389@altlinux.org>
References: <20190714120206.GC6773@altlinux.org>
 <20190714121724.mwg2t3di6goha7yq@brauner.io>
 <20190714141007.GA9131@altlinux.org>
 <20190714142304.3uihy4vepmxgdqha@brauner.io>
 <20190714161449.GA10389@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714161449.GA10389@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of clone3 syscall accidentally broke CLONE_PIDFD
support in traditional clone syscall on compat x86 and those
architectures that use do_fork to implement clone syscall.

This bug was found by strace test suite.

Link: https://strace.io/logs/strace/2019-07-12
Fixes: 7f192e3cd316 ("fork: add clone3")
Bisected-and-tested-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/x86/ia32/sys_ia32.c   |  4 ++++
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 17 +++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index 64a6c952091e..21790307121e 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -239,6 +239,7 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 {
 	struct kernel_clone_args args = {
 		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
 		.child_tid	= child_tidptr,
 		.parent_tid	= parent_tidptr,
 		.exit_signal	= (clone_flags & CSIGNAL),
@@ -246,5 +247,8 @@ COMPAT_SYSCALL_DEFINE5(x86_clone, unsigned long, clone_flags,
 		.tls		= tls_val,
 	};
 
+	if (!legacy_clone_args_valid(&args))
+		return -EINVAL;
+
 	return _do_fork(&args);
 }
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 109a0df5af39..0497091e40c1 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -89,6 +89,7 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern long _do_fork(struct kernel_clone_args *kargs);
+extern bool legacy_clone_args_valid(const struct kernel_clone_args *kargs);
 extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 8f3e2d97d771..ef1e05a68827 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2406,6 +2406,16 @@ long _do_fork(struct kernel_clone_args *args)
 	return nr;
 }
 
+bool legacy_clone_args_valid(const struct kernel_clone_args *kargs)
+{
+	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
+	if ((kargs->flags & CLONE_PIDFD) &&
+	    (kargs->flags & CLONE_PARENT_SETTID))
+		return false;
+
+	return true;
+}
+
 #ifndef CONFIG_HAVE_COPY_THREAD_TLS
 /* For compatibility with architectures that call do_fork directly rather than
  * using the syscall entry points below. */
@@ -2417,6 +2427,7 @@ long do_fork(unsigned long clone_flags,
 {
 	struct kernel_clone_args args = {
 		.flags		= (clone_flags & ~CSIGNAL),
+		.pidfd		= parent_tidptr,
 		.child_tid	= child_tidptr,
 		.parent_tid	= parent_tidptr,
 		.exit_signal	= (clone_flags & CSIGNAL),
@@ -2424,6 +2435,9 @@ long do_fork(unsigned long clone_flags,
 		.stack_size	= stack_size,
 	};
 
+	if (!legacy_clone_args_valid(&args))
+		return -EINVAL;
+
 	return _do_fork(&args);
 }
 #endif
@@ -2505,8 +2519,7 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 		.tls		= tls,
 	};
 
-	/* clone(CLONE_PIDFD) uses parent_tidptr to return a pidfd */
-	if ((clone_flags & CLONE_PIDFD) && (clone_flags & CLONE_PARENT_SETTID))
+	if (!legacy_clone_args_valid(&args))
 		return -EINVAL;
 
 	return _do_fork(&args);
-- 
ldv
