Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C28C32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 10:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E5E207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 10:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAAKHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 05:07:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52286 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAKHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 05:07:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1imauH-0004Oz-GT; Wed, 01 Jan 2020 11:07:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DA3FF1C19B0;
        Wed,  1 Jan 2020 11:07:12 +0100 (CET)
Date:   Wed, 01 Jan 2020 10:07:12 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Cleanup do_general_protection()
Cc:     Borislav Petkov <bp@suse.de>, Jann Horn <jannh@google.com>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157787323274.30329.10602804082016510286.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     36209766cede1fe9d39f3d3418d93bbf71ad21c4
Gitweb:        https://git.kernel.org/tip/36209766cede1fe9d39f3d3418d93bbf71ad21c4
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 31 Dec 2019 17:15:35 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 31 Dec 2019 17:29:29 +01:00

x86/traps: Cleanup do_general_protection()

Hoist the user_mode() case up because it is less code and can be dealt
with up-front like the other special cases UMIP and vm86.

This saves an indentation level for the kernel-mode #GP case and allows
to "unfold" the code more so that it is more readable.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/traps.c | 79 ++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 2afd7d8..ca395ad 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -567,7 +567,10 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
+	enum kernel_gp_hint hint = GP_NO_HINT;
 	struct task_struct *tsk;
+	unsigned long gp_addr;
+	int ret;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
 	cond_local_irq_enable(regs);
@@ -584,58 +587,56 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
 	}
 
 	tsk = current;
-	if (!user_mode(regs)) {
-		enum kernel_gp_hint hint = GP_NO_HINT;
-		unsigned long gp_addr;
-
-		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
-			return;
 
+	if (user_mode(regs)) {
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
-		/*
-		 * To be potentially processing a kprobe fault and to
-		 * trust the result from kprobe_running(), we have to
-		 * be non-preemptible.
-		 */
-		if (!preemptible() && kprobe_running() &&
-		    kprobe_fault_handler(regs, X86_TRAP_GP))
-			return;
+		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
+		force_sig(SIGSEGV);
 
-		if (notify_die(DIE_GPF, desc, regs, error_code,
-			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
-			return;
+		return;
+	}
 
-		if (error_code)
-			snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
-		else
-			hint = get_kernel_gp_address(regs, &gp_addr);
+	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
+		return;
 
-		if (hint != GP_NO_HINT)
-			snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-				 (hint == GP_NON_CANONICAL) ?
-				 "probably for non-canonical address" :
-				 "maybe for address",
-				 gp_addr);
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = X86_TRAP_GP;
 
-		/*
-		 * KASAN is interested only in the non-canonical case, clear it
-		 * otherwise.
-		 */
-		if (hint != GP_NON_CANONICAL)
-			gp_addr = 0;
+	/*
+	 * To be potentially processing a kprobe fault and to trust the result
+	 * from kprobe_running(), we have to be non-preemptible.
+	 */
+	if (!preemptible() &&
+	    kprobe_running() &&
+	    kprobe_fault_handler(regs, X86_TRAP_GP))
+		return;
 
-		die_addr(desc, regs, error_code, gp_addr);
+	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);
+	if (ret == NOTIFY_STOP)
 		return;
-	}
 
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = X86_TRAP_GP;
+	if (error_code)
+		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
+	else
+		hint = get_kernel_gp_address(regs, &gp_addr);
+
+	if (hint != GP_NO_HINT)
+		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
+			 (hint == GP_NON_CANONICAL) ? "probably for non-canonical address"
+						    : "maybe for address",
+			 gp_addr);
+
+	/*
+	 * KASAN is interested only in the non-canonical case, clear it
+	 * otherwise.
+	 */
+	if (hint != GP_NON_CANONICAL)
+		gp_addr = 0;
 
-	show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
+	die_addr(desc, regs, error_code, gp_addr);
 
-	force_sig(SIGSEGV);
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
