Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D21C0044D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBA82068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfLDIex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfLDIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:48 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6K-0005G1-3Y; Wed, 04 Dec 2019 09:33:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B47C11C2657;
        Wed,  4 Dec 2019 09:33:35 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] arm/ftrace: Use __patch_text()
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ard.biesheuvel@linaro.org, james.morse@arm.com, rabin@rab.in,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191113092636.GG4131@hirez.programming.kicks-ass.net>
References: <20191113092636.GG4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <157544841563.21853.2859696202562513480.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     5a735583b764750726621b0396d03e4782911b77
Gitweb:        https://git.kernel.org/tip/5a735583b764750726621b0396d03e4782911b77
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 15 Oct 2019 21:07:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:25 +01:00

arm/ftrace: Use __patch_text()

Instead of flipping text protection, use the patch_text infrastructure
that uses a fixmap alias where required.

This removes the last user of set_all_modules_text_*().

Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: ard.biesheuvel@linaro.org
Cc: james.morse@arm.com
Cc: rabin@rab.in
Link: https://lkml.kernel.org/r/20191113092636.GG4131@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/kernel/Makefile |  4 ++--
 arch/arm/kernel/ftrace.c | 10 ++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 8cad594..a885172 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -49,8 +49,8 @@ obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_ARM_ARCH_TIMER)	+= arch_timer.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
-obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o
-obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o
+obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index bda949f..2a5ff69 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -22,6 +22,7 @@
 #include <asm/ftrace.h>
 #include <asm/insn.h>
 #include <asm/set_memory.h>
+#include <asm/patch.h>
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define	NOP		0xf85deb04	/* pop.w {lr} */
@@ -35,9 +36,7 @@ static int __ftrace_modify_code(void *data)
 {
 	int *command = data;
 
-	set_kernel_text_rw();
 	ftrace_modify_all_code(*command);
-	set_kernel_text_ro();
 
 	return 0;
 }
@@ -59,13 +58,11 @@ static unsigned long adjust_address(struct dyn_ftrace *rec, unsigned long addr)
 
 int ftrace_arch_code_modify_prepare(void)
 {
-	set_all_modules_text_rw();
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void)
 {
-	set_all_modules_text_ro();
 	/* Make sure any TLB misses during machine stop are cleared. */
 	flush_tlb_all();
 	return 0;
@@ -97,10 +94,7 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 			return -EINVAL;
 	}
 
-	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
-		return -EPERM;
-
-	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
+	__patch_text((void *)pc, new);
 
 	return 0;
 }
