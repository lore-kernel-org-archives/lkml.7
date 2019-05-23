Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F44C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E005A20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfEWJGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:06:36 -0400
Received: from foss.arm.com ([217.140.101.70]:40732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfEWJGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:06:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A6F1A78;
        Thu, 23 May 2019 02:06:34 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD7EC3F575;
        Thu, 23 May 2019 02:06:31 -0700 (PDT)
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
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v4 1/4] ptrace: move clearing of TIF_SYSCALL_EMU flag to core
Date:   Thu, 23 May 2019 10:06:15 +0100
Message-Id: <20190523090618.13410-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523090618.13410-1-sudeep.holla@arm.com>
References: <20190523090618.13410-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the TIF_SYSCALL_EMU is set in ptrace_resume independent of any
architecture, currently only powerpc and x86 unset the TIF_SYSCALL_EMU
flag in ptrace_disable which gets called from ptrace_detach.

Let's move the clearing of TIF_SYSCALL_EMU flag to __ptrace_unlink
which gets executed from ptrace_detach and also keep it along with
or close to clearing of TIF_SYSCALL_TRACE.

Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/powerpc/kernel/ptrace.c | 1 -
 arch/x86/kernel/ptrace.c     | 3 ---
 kernel/ptrace.c              | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 684b0b315c32..8c92febf5f44 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2521,7 +2521,6 @@ void ptrace_disable(struct task_struct *child)
 {
 	/* make sure the single step bit is not set. */
 	user_disable_single_step(child);
-	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 }
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4b8ee05dd6ad..45792dbd2443 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -746,9 +746,6 @@ static int ioperm_get(struct task_struct *target,
 void ptrace_disable(struct task_struct *child)
 {
 	user_disable_single_step(child);
-#ifdef TIF_SYSCALL_EMU
-	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
-#endif
 }
 
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..16c7fc1eabcf 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -117,6 +117,9 @@ void __ptrace_unlink(struct task_struct *child)
 	BUG_ON(!child->ptrace);
 
 	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+#ifdef TIF_SYSCALL_EMU
+	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+#endif
 
 	child->parent = child->real_parent;
 	list_del_init(&child->ptrace_entry);
-- 
2.17.1

