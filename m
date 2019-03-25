Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4849C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6979A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553515445;
	bh=MVM211rV+yax6c0hxpuEVbi2EKQBvbztknxmup9RQ7A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DT7VuXLP/Asue049iWi94/b5FPvwFNJh6t0hDHSmBic981nrwSbU8+vlMHL9wtZpn
	 yIl1moiPQdE4r96VOalgsLbXS/+r6Dx7eI+JplM0Xmxd6O1wzTVbPHDRN8Mzimex/P
	 7sfgOiqFyf0ibPAQuXzQ+k5GueGxajbs+FLomLlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbfCYMEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730839AbfCYMED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:04:03 -0400
Received: from localhost.localdomain (unknown [115.199.178.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6CA20850;
        Mon, 25 Mar 2019 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553515442;
        bh=MVM211rV+yax6c0hxpuEVbi2EKQBvbztknxmup9RQ7A=;
        h=From:To:Cc:Subject:Date:From;
        b=kd0Z+xY+7JRx0p5W4H7jOsXhKg8kADczikj6RP1wpfAVo1VeR/bGYyP1pgHENQ89g
         CUhmtt7cEE/x8dKMxDpLfwwPmFumPfRAMVhRf7NsexnFIOFJGdYvvvBExExwP3RzZI
         2wgKjMMySUttVOPlsOaslp9d/MZTuX91GVEMMdX0=
From:   guoren@kernel.org
To:     arnd@arndb.de, ldv@altlinux.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com, strace-devel@lists.strace.io
Subject: [PATCH] csky: Update syscall_trace_enter/exit implementation
Date:   Mon, 25 Mar 2019 20:03:39 +0800
Message-Id: <1553515419-1797-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Previous syscall_trace implementation couldn't support AUDITSYSCALL and
SYSCALL_TRACEPOINTS. Now we redesign it to support audit_syscall
and syscall_tracepoints just like other archs'.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig                   |  2 ++
 arch/csky/include/asm/syscall.h     |  2 ++
 arch/csky/include/asm/thread_info.h | 25 ++++++++-----------
 arch/csky/include/asm/unistd.h      |  2 ++
 arch/csky/include/uapi/asm/ptrace.h |  5 ++++
 arch/csky/kernel/entry.S            | 21 +++++++---------
 arch/csky/kernel/ptrace.c           | 50 +++++++++++++++++--------------------
 7 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 114cb2f..55048020 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -28,6 +28,7 @@ config CSKY
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
@@ -39,6 +40,7 @@ config CSKY
 	select HAVE_PERF_EVENTS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
+	select HAVE_SYSCALL_TRACEPOINTS
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index d637445..bc484c9 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -8,6 +8,8 @@
 #include <abi/regdef.h>
 #include <uapi/linux/audit.h>
 
+extern void *sys_call_table[];
+
 static inline int
 syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 0e9d035..207a932 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -51,29 +51,26 @@ static inline struct thread_info *current_thread_info(void)
 
 #endif /* !__ASSEMBLY__ */
 
-/* entry.S relies on these definitions!
- * bits 0-5 are tested at every exception exit
- */
 #define TIF_SIGPENDING		0	/* signal pending */
 #define TIF_NOTIFY_RESUME	1       /* callback before returning to user */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_SYSCALL_TRACE	5	/* syscall trace active */
-#define TIF_DELAYED_TRACE	14	/* single step a syscall */
+#define TIF_SYSCALL_TRACEPOINT	6       /* syscall tracepoint instrumentation */
+#define TIF_SYSCALL_AUDIT	7	/* syscall auditing */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
-#define TIF_FREEZE		19	/* thread is freezing for suspend */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
 #define TIF_SECCOMP		21	/* secure computing */
 
-#define _TIF_SIGPENDING         (1 << TIF_SIGPENDING)
-#define _TIF_NOTIFY_RESUME      (1 << TIF_NOTIFY_RESUME)
-#define _TIF_NEED_RESCHED       (1 << TIF_NEED_RESCHED)
-#define _TIF_SYSCALL_TRACE      (1 << TIF_SYSCALL_TRACE)
-#define _TIF_DELAYED_TRACE	(1 << TIF_DELAYED_TRACE)
-#define _TIF_POLLING_NRFLAG     (1 << TIF_POLLING_NRFLAG)
+#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
+#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
-#define _TIF_FREEZE             (1 << TIF_FREEZE)
-#define _TIF_RESTORE_SIGMASK    (1 << TIF_RESTORE_SIGMASK)
-#define _TIF_SECCOMP            (1 << TIF_SECCOMP)
+#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
+#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 
 #endif	/* _ASM_CSKY_THREAD_INFO_H */
diff --git a/arch/csky/include/asm/unistd.h b/arch/csky/include/asm/unistd.h
index 2844874..da7a182 100644
--- a/arch/csky/include/asm/unistd.h
+++ b/arch/csky/include/asm/unistd.h
@@ -2,3 +2,5 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <uapi/asm/unistd.h>
+
+#define NR_syscalls (__NR_syscalls)
diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
index a4eaa8d..9bf5b1a 100644
--- a/arch/csky/include/uapi/asm/ptrace.h
+++ b/arch/csky/include/uapi/asm/ptrace.h
@@ -62,6 +62,11 @@ struct user_fp {
 #define instruction_pointer(regs) ((regs)->pc)
 #define profile_pc(regs) instruction_pointer(regs)
 
+static inline unsigned long regs_return_value(struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _CSKY_PTRACE_H */
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 5137ed9..ebd1957 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -136,8 +136,8 @@ ENTRY(csky_systemcall)
 	bmaski  r10, THREAD_SHIFT
 	andn    r9, r10
 	ldw     r8, (r9, TINFO_FLAGS)
-	btsti   r8, TIF_SYSCALL_TRACE
-	bt      1f
+	andi	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
+	bt      csky_syscall_trace
 #if defined(__CSKYABIV2__)
 	subi    sp, 8
 	stw  	r5, (sp, 0x4)
@@ -150,10 +150,9 @@ ENTRY(csky_systemcall)
 	stw     a0, (sp, LSAVE_A0)      /* Save return value */
 	jmpi    ret_from_exception
 
-1:
-	movi	a0, 0                   /* enter system call */
-	mov	a1, sp                  /* sp = pt_regs pointer */
-	jbsr	syscall_trace
+csky_syscall_trace:
+	mov	a0, sp                  /* sp = pt_regs pointer */
+	jbsr	syscall_trace_enter
 	/* Prepare args before do system call */
 	ldw	a0, (sp, LSAVE_A0)
 	ldw	a1, (sp, LSAVE_A1)
@@ -173,9 +172,8 @@ ENTRY(csky_systemcall)
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
-	movi    a0, 1                   /* leave system call */
-	mov     a1, sp                  /* right now, sp --> pt_regs */
-	jbsr    syscall_trace
+	mov     a0, sp                  /* right now, sp --> pt_regs */
+	jbsr    syscall_trace_exit
 	br	ret_from_exception
 
 ENTRY(ret_from_kernel_thread)
@@ -193,9 +191,8 @@ ENTRY(ret_from_fork)
 	movi	r11_sig, 1
 	btsti	r8, TIF_SYSCALL_TRACE
 	bf	3f
-	movi	a0, 1
-	mov	a1, sp			/* sp = pt_regs pointer */
-	jbsr	syscall_trace
+	mov	a0, sp			/* sp = pt_regs pointer */
+	jbsr	syscall_trace_exit
 3:
 	jbsr	ret_from_exception
 
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index f2f12ff..91bc74b 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
+#include <linux/audit.h>
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -11,6 +12,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
+#include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <linux/user.h>
 
@@ -22,6 +24,9 @@
 
 #include <abi/regdef.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 /* sets the trace bits. */
 #define TRACE_MODE_SI      (1 << 14)
 #define TRACE_MODE_RUN     0
@@ -207,35 +212,26 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-/*
- * If process's system calls is traces, do some corresponding handles in this
- * function before entering system call function and after exiting system call
- * function.
- */
-asmlinkage void syscall_trace(int why, struct pt_regs *regs)
+asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 {
-	long saved_why;
-	/*
-	 * Save saved_why, why is used to denote syscall entry/exit;
-	 * why = 0:entry, why = 1: exit
-	 */
-	saved_why = regs->regs[SYSTRACE_SAVENUM];
-	regs->regs[SYSTRACE_SAVENUM] = why;
-
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0));
-
-	/*
-	 * this isn't the same as continuing with a signal, but it will do
-	 * for normal use.  strace only continues with a signal if the
-	 * stopping signal is not SIGTRAP.  -brl
-	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_entry(regs);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, syscall_get_nr(current, regs));
+
+	audit_syscall_entry(regs_syscallid(regs), regs->a0, regs->a1, regs->a2, regs->a3);
+}
+
+asmlinkage void syscall_trace_exit(struct pt_regs *regs)
+{
+	audit_syscall_exit(regs);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, 0);
 
-	regs->regs[SYSTRACE_SAVENUM] = saved_why;
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 }
 
 extern void show_stack(struct task_struct *task, unsigned long *stack);
-- 
2.7.4

