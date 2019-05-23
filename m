Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD01C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DA920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfEWAlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:41:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49605 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWAlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:41:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbn5-0002DR-Cc; Wed, 22 May 2019 18:41:03 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbn3-0005Z3-3p; Wed, 22 May 2019 18:41:03 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:38:58 -0500
Message-Id: <20190523003916.20726-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbn3-0005Z3-3p;;;mid=<20190523003916.20726-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/mFtuCeYmZ6sjASsj8ExTzTB6G8c9SFJc=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 08/26] signal: Remove task parameter from force_sigsegv
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function force_sigsegv is always called on the current task
so passing in current is redundant and not passing in current
makes this fact obvious.

This also makes it clear force_sigsegv always calls force_sig
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arc/kernel/process.c      | 2 +-
 arch/ia64/kernel/signal.c      | 6 +++---
 arch/nios2/kernel/signal.c     | 2 +-
 arch/sparc/kernel/signal32.c   | 4 ++--
 arch/sparc/kernel/signal_64.c  | 2 +-
 arch/um/kernel/skas/mmu.c      | 2 +-
 arch/um/kernel/trap.c          | 2 +-
 arch/unicore32/kernel/signal.c | 2 +-
 fs/exec.c                      | 2 +-
 include/linux/sched/signal.h   | 2 +-
 kernel/rseq.c                  | 2 +-
 kernel/signal.c                | 6 ++++--
 12 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 641c364fc232..725e556678a4 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -313,7 +313,7 @@ int elf_check_arch(const struct elf32_hdr *x)
 	eflags = x->e_flags;
 	if ((eflags & EF_ARC_OSABI_MSK) != EF_ARC_OSABI_CURRENT) {
 		pr_err("ABI mismatch - you need newer toolchain\n");
-		force_sigsegv(SIGSEGV, current);
+		force_sigsegv(SIGSEGV);
 		return 0;
 	}
 
diff --git a/arch/ia64/kernel/signal.c b/arch/ia64/kernel/signal.c
index 6062fd14e34e..518cceb5d4af 100644
--- a/arch/ia64/kernel/signal.c
+++ b/arch/ia64/kernel/signal.c
@@ -257,7 +257,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
 			 */
 			check_sp = (new_sp - sizeof(*frame)) & -STACK_ALIGN;
 			if (!likely(on_sig_stack(check_sp))) {
-				force_sigsegv(ksig->sig, current);
+				force_sigsegv(ksig->sig);
 				return 1;
 			}
 		}
@@ -265,7 +265,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
 	frame = (void __user *) ((new_sp - sizeof(*frame)) & -STACK_ALIGN);
 
 	if (!access_ok(frame, sizeof(*frame))) {
-		force_sigsegv(ksig->sig, current);
+		force_sigsegv(ksig->sig);
 		return 1;
 	}
 
@@ -282,7 +282,7 @@ setup_frame(struct ksignal *ksig, sigset_t *set, struct sigscratch *scr)
 	err |= setup_sigcontext(&frame->sc, set, scr);
 
 	if (unlikely(err)) {
-		force_sigsegv(ksig->sig, current);
+		force_sigsegv(ksig->sig);
 		return 1;
 	}
 
diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
index 4a81876b6086..9bf38531b189 100644
--- a/arch/nios2/kernel/signal.c
+++ b/arch/nios2/kernel/signal.c
@@ -211,7 +211,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	return 0;
 
 give_sigsegv:
-	force_sigsegv(ksig->sig, current);
+	force_sigsegv(ksig->sig);
 	return -EFAULT;
 }
 
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index e800ce13cc6e..fb431d47a532 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -375,7 +375,7 @@ static int setup_frame32(struct ksignal *ksig, struct pt_regs *regs,
 			pr_info("%s[%d] bad frame in setup_frame32: %08lx TPC %08lx O7 %08lx\n",
 				current->comm, current->pid, (unsigned long)sf,
 				regs->tpc, regs->u_regs[UREG_I7]);
-		force_sigsegv(ksig->sig, current);
+		force_sigsegv(ksig->sig);
 		return -EINVAL;
 	}
 
@@ -509,7 +509,7 @@ static int setup_rt_frame32(struct ksignal *ksig, struct pt_regs *regs,
 			pr_info("%s[%d] bad frame in setup_rt_frame32: %08lx TPC %08lx O7 %08lx\n",
 				current->comm, current->pid, (unsigned long)sf,
 				regs->tpc, regs->u_regs[UREG_I7]);
-		force_sigsegv(ksig->sig, current);
+		force_sigsegv(ksig->sig);
 		return -EINVAL;
 	}
 
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index ca70787efd8e..9d50190cf312 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -374,7 +374,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 			pr_info("%s[%d] bad frame in setup_rt_frame: %016lx TPC %016lx O7 %016lx\n",
 				current->comm, current->pid, (unsigned long)sf,
 				regs->tpc, regs->u_regs[UREG_I7]);
-		force_sigsegv(ksig->sig, current);
+		force_sigsegv(ksig->sig);
 		return -EINVAL;
 	}
 
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 7a1f2a936fd1..29e7f5f9f188 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -119,7 +119,7 @@ void uml_setup_stubs(struct mm_struct *mm)
 	return;
 
 out:
-	force_sigsegv(SIGSEGV, current);
+	force_sigsegv(SIGSEGV);
 }
 
 void arch_exit_mmap(struct mm_struct *mm)
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 0e8b6158f224..646059402ab3 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -169,7 +169,7 @@ static void bad_segv(struct faultinfo fi, unsigned long ip)
 
 void fatal_sigsegv(void)
 {
-	force_sigsegv(SIGSEGV, current);
+	force_sigsegv(SIGSEGV);
 	do_signal(&current->thread.regs);
 	/*
 	 * This is to tell gcc that we're not returning - do_signal
diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
index 63be04809d40..75f27dc68bd0 100644
--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -386,7 +386,7 @@ static void do_signal(struct pt_regs *regs, int syscall)
 					regs->UCreg_pc = KERN_RESTART_CODE;
 				} else {
 					regs->UCreg_sp += 4;
-					force_sigsegv(0, current);
+					force_sigsegv(0);
 				}
 		}
 		if (regs->UCreg_00 == -ERESTARTNOHAND ||
diff --git a/fs/exec.c b/fs/exec.c
index d88584ebf07f..f5568e45d521 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1662,7 +1662,7 @@ int search_binary_handler(struct linux_binprm *bprm)
 		if (retval < 0 && !bprm->mm) {
 			/* we got to flush_old_exec() and failed after it */
 			read_unlock(&binfmt_lock);
-			force_sigsegv(SIGSEGV, current);
+			force_sigsegv(SIGSEGV);
 			return retval;
 		}
 		if (retval != -ENOEXEC || !bprm->file) {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index c68ca81db0a1..8af3101da782 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -325,7 +325,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey);
 int force_sig_ptrace_errno_trap(int errno, void __user *addr);
 
 extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
-extern void force_sigsegv(int sig, struct task_struct *p);
+extern void force_sigsegv(int sig);
 extern int force_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp);
 extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9424ee90589e..e1aa3ebee291 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -277,7 +277,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 
 error:
 	sig = ksig ? ksig->sig : 0;
-	force_sigsegv(sig, t);
+	force_sigsegv(sig);
 }
 
 #ifdef CONFIG_DEBUG_RSEQ
diff --git a/kernel/signal.c b/kernel/signal.c
index 39a3eca5ce22..f7669d240ce4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1607,8 +1607,10 @@ EXPORT_SYMBOL(force_sig);
  * the problem was already a SIGSEGV, we'll want to
  * make sure we don't even try to deliver the signal..
  */
-void force_sigsegv(int sig, struct task_struct *p)
+void force_sigsegv(int sig)
 {
+	struct task_struct *p = current;
+
 	if (sig == SIGSEGV) {
 		unsigned long flags;
 		spin_lock_irqsave(&p->sighand->siglock, flags);
@@ -2717,7 +2719,7 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
 void signal_setup_done(int failed, struct ksignal *ksig, int stepping)
 {
 	if (failed)
-		force_sigsegv(ksig->sig, current);
+		force_sigsegv(ksig->sig);
 	else
 		signal_delivered(ksig, stepping);
 }
-- 
2.21.0

