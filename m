Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6112DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F87720720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgAHUag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:30:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51620 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAHUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:30:36 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipHyH-0004Sb-Lp; Wed, 08 Jan 2020 21:30:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 095071C2CD8;
        Wed,  8 Jan 2020 21:30:29 +0100 (CET)
Date:   Wed, 08 Jan 2020 20:30:28 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86: Remove force_iret()
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        Oleg Nesterov <oleg@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191219115812.102620-1-brgerst@gmail.com>
References: <20191219115812.102620-1-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <157851542886.30329.11477399027279492843.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     2b10906f2d25515bba58070b8183babc89063597
Gitweb:        https://git.kernel.org/tip/2b10906f2d25515bba58070b8183babc89063597
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 19 Dec 2019 06:58:12 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Jan 2020 19:40:51 +01:00

x86: Remove force_iret()

force_iret() was originally intended to prevent the return to user mode with
the SYSRET or SYSEXIT instructions, in cases where the register state could
have been changed to be incompatible with those instructions.  The entry code
has been significantly reworked since then, and register state is validated
before SYSRET or SYSEXIT are used.  force_iret() no longer serves its original
purpose and can be eliminated.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lkml.kernel.org/r/20191219115812.102620-1-brgerst@gmail.com
---
 arch/x86/ia32/ia32_signal.c        |  2 --
 arch/x86/include/asm/ptrace.h      | 16 ----------------
 arch/x86/include/asm/thread_info.h |  9 ---------
 arch/x86/kernel/process_32.c       |  1 -
 arch/x86/kernel/process_64.c       |  1 -
 arch/x86/kernel/signal.c           |  2 --
 arch/x86/kernel/vm86_32.c          |  1 -
 7 files changed, 32 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 30416d7..a3aefe9 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -114,8 +114,6 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 
 	err |= fpu__restore_sig(buf, 1);
 
-	force_iret();
-
 	return err;
 }
 
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5057a8e..78897a8 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -339,22 +339,6 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
 
 #define ARCH_HAS_USER_SINGLE_STEP_REPORT
 
-/*
- * When hitting ptrace_stop(), we cannot return using SYSRET because
- * that does not restore the full CPU state, only a minimal set.  The
- * ptracer can change arbitrary register values, which is usually okay
- * because the usual ptrace stops run off the signal delivery path which
- * forces IRET; however, ptrace_event() stops happen in arbitrary places
- * in the kernel and don't force IRET path.
- *
- * So force IRET path after a ptrace stop.
- */
-#define arch_ptrace_stop_needed(code, info)				\
-({									\
-	force_iret();							\
-	false;								\
-})
-
 struct user_desc;
 extern int do_get_thread_area(struct task_struct *p, int idx,
 			      struct user_desc __user *info);
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d779366..cf43279 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -239,15 +239,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
-/*
- * Force syscall return via IRET by making it look as if there was
- * some work pending. IRET is our most capable (but slowest) syscall
- * return path, which is able to restore modified SS, CS and certain
- * EFLAGS values that other (fast) syscall return instructions
- * are not able to restore properly.
- */
-#define force_iret() set_thread_flag(TIF_NOTIFY_RESUME)
-
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 323499f..5052ced 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -124,7 +124,6 @@ start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 	regs->ip		= new_ip;
 	regs->sp		= new_sp;
 	regs->flags		= X86_EFLAGS_IF;
-	force_iret();
 }
 EXPORT_SYMBOL_GPL(start_thread);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 506d668..ffd4978 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -394,7 +394,6 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 	regs->cs		= _cs;
 	regs->ss		= _ss;
 	regs->flags		= X86_EFLAGS_IF;
-	force_iret();
 }
 
 void
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 8eb7193..8a29573 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -151,8 +151,6 @@ static int restore_sigcontext(struct pt_regs *regs,
 
 	err |= fpu__restore_sig(buf, IS_ENABLED(CONFIG_X86_32));
 
-	force_iret();
-
 	return err;
 }
 
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index a76c12b..91d5545 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -381,7 +381,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 		mark_screen_rdonly(tsk->mm);
 
 	memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
-	force_iret();
 	return regs->ax;
 }
 
