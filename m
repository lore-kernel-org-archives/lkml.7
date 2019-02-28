Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D33C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA30F218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfB1Sck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:32:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732645AbfB1Sci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:32:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2508416A3;
        Thu, 28 Feb 2019 10:32:38 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DDEE3F5C1;
        Thu, 28 Feb 2019 10:32:34 -0800 (PST)
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
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using ptrace_syscall_enter hook
Date:   Thu, 28 Feb 2019 18:32:17 +0000
Message-Id: <20190228183220.15626-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228183220.15626-1-sudeep.holla@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a new hook ptrace_syscall_enter that can be called from
syscall entry code and it handles PTRACE_SYSEMU in generic code, we
can do some cleanup using the same in syscall_trace_enter.

Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
in syscall_slow_exit_work seems unnecessary. Let's remove the same.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/x86/entry/common.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7bc105f47d21..36457c1f87d2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -70,22 +70,16 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	struct thread_info *ti = current_thread_info();
 	unsigned long ret = 0;
-	bool emulated = false;
 	u32 work;
 
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 		BUG_ON(regs != task_pt_regs(current));
 
-	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
-
-	if (unlikely(work & _TIF_SYSCALL_EMU))
-		emulated = true;
-
-	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
-	    tracehook_report_syscall_entry(regs))
+	if (unlikely(ptrace_syscall_enter(regs)))
 		return -1L;
 
-	if (emulated)
+	work = READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
+	if ((work & _TIF_SYSCALL_TRACE) && tracehook_report_syscall_entry(regs))
 		return -1L;
 
 #ifdef CONFIG_SECCOMP
@@ -227,15 +221,7 @@ static void syscall_slow_exit_work(struct pt_regs *regs, u32 cached_flags)
 	if (cached_flags & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, regs->ax);
 
-	/*
-	 * If TIF_SYSCALL_EMU is set, we only get here because of
-	 * TIF_SINGLESTEP (i.e. this is PTRACE_SYSEMU_SINGLESTEP).
-	 * We already reported this syscall instruction in
-	 * syscall_trace_enter().
-	 */
-	step = unlikely(
-		(cached_flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU))
-		== _TIF_SINGLESTEP);
+	step = unlikely((cached_flags & _TIF_SINGLESTEP));
 	if (step || cached_flags & _TIF_SYSCALL_TRACE)
 		tracehook_report_syscall_exit(regs, step);
 }
-- 
2.17.1

