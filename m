Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BC4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5136218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfB1Scn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:32:43 -0500
Received: from foss.arm.com ([217.140.101.70]:52948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732645AbfB1Scl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:32:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34012174E;
        Thu, 28 Feb 2019 10:32:41 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63F233F5C1;
        Thu, 28 Feb 2019 10:32:38 -0800 (PST)
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
Subject: [PATCH 4/6] powerpc: use common ptrace_syscall_enter hook to handle _TIF_SYSCALL_EMU
Date:   Thu, 28 Feb 2019 18:32:18 +0000
Message-Id: <20190228183220.15626-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228183220.15626-1-sudeep.holla@arm.com>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a new hook ptrace_syscall_enter that can be called from
syscall entry code and it handles PTRACE_SYSEMU in generic code, we
can do some cleanup using the same in do_syscall_trace_enter.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/powerpc/kernel/ptrace.c | 50 ++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index cb7e1439cafb..978cd2aac29e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3264,37 +3264,31 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 flags;
 
-	user_exit();
-
-	flags = READ_ONCE(current_thread_info()->flags) &
-		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
+	if (unlikely(ptrace_syscall_enter(regs))) {
+		/*
+		 * A nonzero return code from tracehook_report_syscall_entry()
+		 * tells us to prevent the syscall execution, but we are not
+		 * going to execute it anyway.
+		 *
+		 * Returning -1 will skip the syscall execution. We want to
+		 * avoid clobbering any registers, so we don't goto the skip
+		 * label below.
+		 */
+		return -1;
+	}
 
-	if (flags) {
-		int rc = tracehook_report_syscall_entry(regs);
+	user_exit();
 
-		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
-			/*
-			 * A nonzero return code from
-			 * tracehook_report_syscall_entry() tells us to prevent
-			 * the syscall execution, but we are not going to
-			 * execute it anyway.
-			 *
-			 * Returning -1 will skip the syscall execution. We want
-			 * to avoid clobbering any registers, so we don't goto
-			 * the skip label below.
-			 */
-			return -1;
-		}
+	flags = READ_ONCE(current_thread_info()->flags) & _TIF_SYSCALL_TRACE;
 
-		if (rc) {
-			/*
-			 * The tracer decided to abort the syscall. Note that
-			 * the tracer may also just change regs->gpr[0] to an
-			 * invalid syscall number, that is handled below on the
-			 * exit path.
-			 */
-			goto skip;
-		}
+	if (flags && tracehook_report_syscall_entry(regs)) {
+		/*
+		 * The tracer decided to abort the syscall. Note that
+		 * the tracer may also just change regs->gpr[0] to an
+		 * invalid syscall number, that is handled below on the
+		 * exit path.
+		 */
+		goto skip;
 	}
 
 	/* Run seccomp after ptrace; allow it to set gpr[3]. */
-- 
2.17.1

