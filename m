Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D33C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609B8218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387558AbfB1Sch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:32:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732645AbfB1Scf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:32:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C37C81684;
        Thu, 28 Feb 2019 10:32:34 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F38093F5C1;
        Thu, 28 Feb 2019 10:32:31 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>
Subject: [PATCH 2/6] ptrace: introduce ptrace_syscall_enter to consolidate PTRACE_SYSEMU handling
Date:   Thu, 28 Feb 2019 18:32:16 +0000
Message-Id: <20190228183220.15626-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228183220.15626-1-sudeep.holla@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently each architecture handles PTRACE_SYSEMU in very similar way.
It's completely arch independent and can be handled in the code helping
to consolidate PTRACE_SYSEMU handling.

Let's introduce a hook 'ptrace_syscall_enter' that arch specific syscall
entry code can call.

Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/ptrace.h |  1 +
 kernel/ptrace.c        | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index edb9b040c94c..e30f51e3363e 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -407,6 +407,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
 #endif
 
+extern long ptrace_syscall_enter(struct pt_regs *regs);
 extern int task_current_syscall(struct task_struct *target, long *callno,
 				unsigned long args[6], unsigned int maxargs,
 				unsigned long *sp, unsigned long *pc);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 4fa3b7f4c3c7..6724eaf98e79 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -29,6 +29,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/cn_proc.h>
 #include <linux/compat.h>
+#include <linux/tracehook.h>
 
 /*
  * Access another process' address space via ptrace.
@@ -557,6 +558,21 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
 	return 0;
 }
 
+/*
+ * Hook to check and report for PTRACE_SYSEMU, can be called from arch
+ * arch syscall entry code
+ */
+long ptrace_syscall_enter(struct pt_regs *regs)
+{
+#ifdef TIF_SYSCALL_EMU
+	if (test_thread_flag(TIF_SYSCALL_EMU)) {
+		if (tracehook_report_syscall_entry(regs));
+		return -1L;
+	}
+#endif
+	return 0;
+}
+
 /*
  * Detach all tasks we were using ptrace on. Called with tasklist held
  * for writing.
-- 
2.17.1

