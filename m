Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DFC04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2121670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfD3RFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:05:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfD3RFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:05:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F8FA15A2;
        Tue, 30 Apr 2019 10:05:40 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0258C3F5C1;
        Tue, 30 Apr 2019 10:05:37 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 4/4] arm64: ptrace: add support for syscall emulation
Date:   Tue, 30 Apr 2019 18:05:20 +0100
Message-Id: <20190430170520.29470-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430170520.29470-1-sudeep.holla@arm.com>
References: <20190430170520.29470-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on arm64.
We don't need any special handling for PTRACE_SYSEMU_SINGLESTEP.

It's quite difficult to generalize handling PTRACE_SYSEMU cross
architectures and avoid calls to tracehook_report_syscall_entry twice.
Different architecture have different mechanism to indicate NO_SYSCALL
and trying to generalise adds more code for no gain.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 5 ++++-
 arch/arm64/kernel/ptrace.c           | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

Hi Will,

While I agree with your idea of consolidation of PTRACE_SYSEMU handling
to core, it's quite a lot of change to do that, though it may be simple
and confusing with indirection from arch code to core.

Regards,
Sudeep

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index eb3ef73e07cf..c285d1ce7186 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -75,6 +75,7 @@ void arch_release_task_struct(struct task_struct *tsk);
  *  TIF_SYSCALL_TRACE	- syscall trace active
  *  TIF_SYSCALL_TRACEPOINT - syscall tracepoint for ftrace
  *  TIF_SYSCALL_AUDIT	- syscall auditing
+ *  TIF_SYSCALL_EMU     - syscall emulation active
  *  TIF_SECOMP		- syscall secure computing
  *  TIF_SIGPENDING	- signal pending
  *  TIF_NEED_RESCHED	- rescheduling necessary
@@ -91,6 +92,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SYSCALL_AUDIT	9
 #define TIF_SYSCALL_TRACEPOINT	10
 #define TIF_SECCOMP		11
+#define TIF_SYSCALL_EMU		12
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -109,6 +111,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 #define _TIF_32BIT		(1 << TIF_32BIT)
@@ -120,7 +123,7 @@ void arch_release_task_struct(struct task_struct *tsk);

 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
-				 _TIF_NOHZ)
+				 _TIF_NOHZ | _TIF_SYSCALL_EMU)

 #define INIT_THREAD_INFO(tsk)						\
 {									\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b82e0a9b3da3..9353355cb91a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1819,8 +1819,12 @@ static void tracehook_report_syscall(struct pt_regs *regs,

 int syscall_trace_enter(struct pt_regs *regs)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
+	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
+		test_thread_flag(TIF_SYSCALL_EMU)) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+		if (!in_syscall(regs) || test_thread_flag(TIF_SYSCALL_EMU))
+			return -1;
+	}

 	/* Do the secure computing after ptrace; failures should be fast. */
 	if (secure_computing(NULL) == -1)
--
2.17.1

