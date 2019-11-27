Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBFC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678AF20678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfK0ITj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:19:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43960 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfK0ITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:19:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZsXq-0002Qs-P0; Wed, 27 Nov 2019 09:19:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0C90D1C1E71;
        Wed, 27 Nov 2019 09:19:30 +0100 (CET)
Date:   Wed, 27 Nov 2019 08:19:29 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/traps: Disentangle the 32-bit and 64-bit
 doublefault code
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157484276997.21853.6533072564160468139.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     93efbde2c331004d8053f04b4bf0ca3e630b474a
Gitweb:        https://git.kernel.org/tip/93efbde2c331004d8053f04b4bf0ca3e630b474a
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 22:12:38 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00

x86/traps: Disentangle the 32-bit and 64-bit doublefault code

The 64-bit doublefault handler is much nicer than the 32-bit one.
As a first step toward unifying them, make the 64-bit handler
self-contained.  This should have no effect no functional effect
except in the odd case of x86_64 with CONFIG_DOUBLEFAULT=n in which
case it will change the logging a bit.

This also gets rid of CONFIG_DOUBLEFAULT configurability on 64-bit
kernels.  It didn't do anything useful -- CONFIG_DOUBLEFAULT=n
didn't actually disable doublefault handling on x86_64.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig.debug           |  2 +-
 arch/x86/include/asm/processor.h |  1 -
 arch/x86/kernel/doublefault.c    | 11 -----------
 arch/x86/kernel/traps.c          | 12 +++---------
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 409c00f..c4eab8e 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -117,7 +117,7 @@ config DEBUG_WX
 
 config DOUBLEFAULT
 	default y
-	bool "Enable doublefault exception handler" if EXPERT
+	bool "Enable doublefault exception handler" if EXPERT && X86_32
 	---help---
 	  This option allows trapping of rare doublefault exceptions that
 	  would otherwise cause a system to silently reboot. Disabling this
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index e51afbb..f6c6300 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -997,7 +997,6 @@ bool xen_set_default_idle(void);
 #endif
 
 void stop_this_cpu(void *dummy);
-void df_debug(struct pt_regs *regs, long error_code);
 void microcode_check(void);
 
 enum l1tf_mitigations {
diff --git a/arch/x86/kernel/doublefault.c b/arch/x86/kernel/doublefault.c
index 0d6c657..0b3c616 100644
--- a/arch/x86/kernel/doublefault.c
+++ b/arch/x86/kernel/doublefault.c
@@ -72,15 +72,4 @@ struct x86_hw_tss doublefault_tss __cacheline_aligned = {
 	.__cr3		= __pa_nodebug(swapper_pg_dir),
 };
 
-/* dummy for do_double_fault() call */
-void df_debug(struct pt_regs *regs, long error_code) {}
-
-#else /* !CONFIG_X86_32 */
-
-void df_debug(struct pt_regs *regs, long error_code)
-{
-	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
-	show_regs(regs);
-	panic("Machine halted.");
-}
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c903121..76381b0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -411,15 +411,9 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
 		handle_stack_overflow("kernel stack overflow (double-fault)", regs, cr2);
 #endif
 
-#ifdef CONFIG_DOUBLEFAULT
-	df_debug(regs, error_code);
-#endif
-	/*
-	 * This is always a kernel trap and never fixable (and thus must
-	 * never return).
-	 */
-	for (;;)
-		die(str, regs, error_code);
+	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
+	show_regs(regs);
+	panic("Machine halted.");
 }
 #endif
 
