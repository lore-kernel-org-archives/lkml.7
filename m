Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11210C282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D7B21871
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfEWAnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:43:24 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60238 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfEWAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:43:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbpA-0004H8-5y; Wed, 22 May 2019 18:43:12 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnY-0005Z3-C9; Wed, 22 May 2019 18:41:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:06 -0500
Message-Id: <20190523003916.20726-17-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnY-0005Z3-C9;;;mid=<20190523003916.20726-17-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DU0GZ9Kh8Uxq96KL7LRdVwgLDFTxyl7M=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 16/26] signal/arm: Remove tsk parameter from ptrace_break
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ptrace_break function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that ptrace_break calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/include/asm/traps.h | 2 +-
 arch/arm/kernel/ptrace.c     | 6 +++---
 arch/arm/kernel/traps.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index a00288d75ee6..172b08ff3760 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -30,7 +30,7 @@ static inline int __in_irqentry_text(unsigned long ptr)
 
 extern void __init early_trap_init(void *);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
-extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
+extern void ptrace_break(struct pt_regs *regs);
 
 extern void *vectors_page;
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 6fa5b6387556..f9cbd08a9075 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -201,15 +201,15 @@ void ptrace_disable(struct task_struct *child)
 /*
  * Handle hitting a breakpoint.
  */
-void ptrace_break(struct task_struct *tsk, struct pt_regs *regs)
+void ptrace_break(struct pt_regs *regs)
 {
 	force_sig_fault(SIGTRAP, TRAP_BRKPT,
-			(void __user *)instruction_pointer(regs), tsk);
+			(void __user *)instruction_pointer(regs), current);
 }
 
 static int break_trap(struct pt_regs *regs, unsigned int instr)
 {
-	ptrace_break(current, regs);
+	ptrace_break(regs);
 	return 0;
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 33af097c454b..288989c7355d 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -606,7 +606,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 
 	case NR(breakpoint): /* SWI BREAK_POINT */
 		regs->ARM_pc -= thumb_mode(regs) ? 2 : 4;
-		ptrace_break(current, regs);
+		ptrace_break(regs);
 		return regs->ARM_r0;
 
 	/*
-- 
2.21.0

