Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E1C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C122173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfEWAnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:43:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49798 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfEWAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:43:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp9-0002LU-FG; Wed, 22 May 2019 18:43:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnt-0005Z3-U1; Wed, 22 May 2019 18:41:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:10 -0500
Message-Id: <20190523003916.20726-21-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnt-0005Z3-U1;;;mid=<20190523003916.20726-21-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19KdgrQc7rlmHrDBNAdCyqjcTisuFCTvhk=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 20/26] signal: Use force_sig_fault_to_task for the two calls that don't deliver to current
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing the task parameter from force_sig_fault
introduce force_sig_fault_to_task and use it for the two cases where
it matters.

On mips force_fcr31_sig calls force_sig_fault and is called on either
the current task, or a task that is suspended and is being switched to
by the scheduler.  This is safe because the task being switched to by
the scheduler is guaranteed to be suspended.  This ensures that
task->sighand is stable while the signal is delivered to it.

On parisc user_enable_single_step calls force_sig_fault and is in turn
called by ptrace_request.  The function ptrace_request always calls
user_enable_single_step on a child that is stopped for tracing.  The
child being traced and not reaped ensures that child->sighand is not
NULL, and that the child will not change child->sighand.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/kernel/traps.c     |  2 +-
 arch/parisc/kernel/ptrace.c  |  6 +++---
 include/linux/sched/signal.h |  4 ++++
 kernel/signal.c              | 12 +++++++++++-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a6031b045b95..62df48b6fb46 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -733,7 +733,7 @@ void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 	else if (fcr31 & FPU_CSR_INE_X)
 		si_code = FPE_FLTRES;
 
-	force_sig_fault(SIGFPE, si_code, fault_addr, tsk);
+	force_sig_fault_to_task(SIGFPE, si_code, fault_addr, tsk);
 }
 
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index a3d2fb4e6dd2..f642ba378ffa 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -88,9 +88,9 @@ void user_enable_single_step(struct task_struct *task)
 		ptrace_disable(task);
 		/* Don't wake up the task, but let the
 		   parent know something happened. */
-		force_sig_fault(SIGTRAP, TRAP_TRACE,
-				(void __user *) (task_regs(task)->iaoq[0] & ~3),
-				task);
+		force_sig_fault_to_task(SIGTRAP, TRAP_TRACE,
+					(void __user *) (task_regs(task)->iaoq[0] & ~3),
+					task);
 		/* notify_parent(task, SIGCHLD); */
 		return;
 	}
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 4178bb1f7709..507af66a1fc8 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -307,6 +307,10 @@ static inline void kernel_signal_stop(void)
 # define ___ARCH_SI_IA64(_a1, _a2, _a3)
 #endif
 
+int force_sig_fault_to_task(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t);
 int force_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
diff --git a/kernel/signal.c b/kernel/signal.c
index 398489facf9f..e420489ac4c9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1620,7 +1620,7 @@ void force_sigsegv(int sig)
 	force_sig(SIGSEGV);
 }
 
-int force_sig_fault(int sig, int code, void __user *addr
+int force_sig_fault_to_task(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
 	, struct task_struct *t)
@@ -1643,6 +1643,16 @@ int force_sig_fault(int sig, int code, void __user *addr
 	return force_sig_info(info.si_signo, &info, t);
 }
 
+int force_sig_fault(int sig, int code, void __user *addr
+	___ARCH_SI_TRAPNO(int trapno)
+	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
+	, struct task_struct *t)
+{
+	return force_sig_fault_to_task(sig, code, addr
+				       ___ARCH_SI_TRAPNO(trapno)
+				       ___ARCH_SI_IA64(imm, flags, isr), t);
+}
+
 int send_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_TRAPNO(int trapno)
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
-- 
2.21.0

