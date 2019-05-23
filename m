Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2FAC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12432173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfEWAnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:43:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49778 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfEWAnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:43:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp6-0002Kv-MP; Wed, 22 May 2019 18:43:08 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnR-0005Z3-V0; Wed, 22 May 2019 18:41:27 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:04 -0500
Message-Id: <20190523003916.20726-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnR-0005Z3-V0;;;mid=<20190523003916.20726-15-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX198nWOmUK3Py8VI44L4UWTcum7rWXYlsGU=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 14/26] signal/riscv: Remove tsk parameter from do_trap
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The do_trap function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that do_trap calls force_sig_fault
on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/riscv/include/asm/bug.h | 2 +-
 arch/riscv/kernel/traps.c    | 7 ++++---
 arch/riscv/mm/fault.c        | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 52a1fbdeab3b..f1390914ba7a 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -94,7 +94,7 @@ struct task_struct;
 
 extern void die(struct pt_regs *regs, const char *str);
 extern void do_trap(struct pt_regs *regs, int signo, int code,
-	unsigned long addr, struct task_struct *tsk);
+	unsigned long addr);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3d1a651dc54c..71445a928c1b 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -63,9 +63,10 @@ void die(struct pt_regs *regs, const char *str)
 		do_exit(SIGSEGV);
 }
 
-void do_trap(struct pt_regs *regs, int signo, int code,
-	unsigned long addr, struct task_struct *tsk)
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
+	struct task_struct *tsk = current;
+
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -82,7 +83,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	unsigned long addr, const char *str)
 {
 	if (user_mode(regs)) {
-		do_trap(regs, signo, code, addr, current);
+		do_trap(regs, signo, code, addr);
 	} else {
 		if (!fixup_exception(regs))
 			die(regs, str);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index cec8be9e2d6a..0a0081d9b766 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -181,7 +181,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	up_read(&mm->mmap_sem);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
-		do_trap(regs, SIGSEGV, code, addr, tsk);
+		do_trap(regs, SIGSEGV, code, addr);
 		return;
 	}
 
@@ -217,7 +217,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
 		goto no_context;
-	do_trap(regs, SIGBUS, BUS_ADRERR, addr, tsk);
+	do_trap(regs, SIGBUS, BUS_ADRERR, addr);
 	return;
 
 vmalloc_fault:
@@ -231,7 +231,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 
 		/* User mode accesses just cause a SIGSEGV */
 		if (user_mode(regs))
-			return do_trap(regs, SIGSEGV, code, addr, tsk);
+			return do_trap(regs, SIGSEGV, code, addr);
 
 		/*
 		 * Synchronize this task's top level page-table
-- 
2.21.0

