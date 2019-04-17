Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1770820872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V3kFFrFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfDQOXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:23:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57965 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbfDQOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:23:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HENZfs3936224
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:23:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HENZfs3936224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555511016;
        bh=lCu953eArxweLjUbgOciGrTaDhPj673WF1FWDJ2Cyuc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=V3kFFrFJZ2PIaBL6fwIN6j4K+16QECN8Md4gCFgLDO/NVeiRPYxAHMBy4KQTfI/pI
         6sdkj8sIz7c4ICr/Wo6hTf74ONFpd6LJtI83i6TdhE1XdAcsnY0J7yWzVjC4wc0DlI
         yv7k/XLMPWQKnL20Nnu51yD7rRv/Q2EDZ+mWquIHOtwXH82adoUuzh/XU/579onDkU
         vbh+eK8SpNVCZ2HBCzJ3q72svdJbLyCkmtJW+Ciz8y1C2LqipOJniKX4vo1OmyyNeV
         YVVQeF1OISA1SQy+wnzkxqpeSm7+yBPuiIppfuG8gB4fIbIRgFfamkCJ2Sis9Qe2qb
         pOHd4ZgLrXeyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HENZBN3936221;
        Wed, 17 Apr 2019 07:23:35 -0700
Date:   Wed, 17 Apr 2019 07:23:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-117ed45485413b1977bfc638c32bf5b01d53c62b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, luto@kernel.org,
        bp@suse.de, mingo@redhat.com, sean.j.christopherson@intel.com,
        jpoimboe@redhat.com, mingo@kernel.org, x86@kernel.org,
        hpa@zytor.com, nstange@suse.de
Reply-To: mingo@redhat.com, bp@suse.de, sean.j.christopherson@intel.com,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          tglx@linutronix.de, x86@kernel.org, hpa@zytor.com,
          nstange@suse.de, jpoimboe@redhat.com, mingo@kernel.org
In-Reply-To: <20190414160146.466354762@linutronix.de>
References: <20190414160146.466354762@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/64: Remove stack overflow debug code
Git-Commit-ID: 117ed45485413b1977bfc638c32bf5b01d53c62b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  117ed45485413b1977bfc638c32bf5b01d53c62b
Gitweb:     https://git.kernel.org/tip/117ed45485413b1977bfc638c32bf5b01d53c62b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 18:00:08 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:41:48 +0200

x86/irq/64: Remove stack overflow debug code

All stack types on x86 64-bit have guard pages now.

So there is no point in executing probabilistic overflow checks as the
guard pages are a accurate and reliable overflow prevention.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160146.466354762@linutronix.de
---
 arch/x86/Kconfig         |  2 +-
 arch/x86/kernel/irq_64.c | 56 ------------------------------------------------
 2 files changed, 1 insertion(+), 57 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ad92419be19..fd06614b09a7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,6 +14,7 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
+	select HAVE_DEBUG_STACKOVERFLOW
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
 
@@ -138,7 +139,6 @@ config X86
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index f107eb2021f6..6bf6517a05bb 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,64 +26,8 @@
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
 DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
-int sysctl_panic_on_stackoverflow;
-
-/*
- * Probabilistic stack overflow check:
- *
- * Regular device interrupts can enter on the following stacks:
- *
- * - User stack
- *
- * - Kernel task stack
- *
- * - Interrupt stack if a device driver reenables interrupts
- *   which should only happen in really old drivers.
- *
- * - Debug IST stack
- *
- * All other contexts are invalid.
- */
-static inline void stack_overflow_check(struct pt_regs *regs)
-{
-#ifdef CONFIG_DEBUG_STACKOVERFLOW
-#define STACK_MARGIN	128
-	u64 irq_stack_top, irq_stack_bottom, estack_top, estack_bottom;
-	u64 curbase = (u64)task_stack_page(current);
-	struct cea_exception_stacks *estacks;
-
-	if (user_mode(regs))
-		return;
-
-	if (regs->sp >= curbase + sizeof(struct pt_regs) + STACK_MARGIN &&
-	    regs->sp <= curbase + THREAD_SIZE)
-		return;
-
-	irq_stack_top = (u64)__this_cpu_read(hardirq_stack_ptr);
-	irq_stack_bottom = irq_stack_top - IRQ_STACK_SIZE + STACK_MARGIN;
-	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
-		return;
-
-	estacks = __this_cpu_read(cea_exception_stacks);
-	estack_top = CEA_ESTACK_TOP(estacks, DB);
-	estack_bottom = CEA_ESTACK_BOT(estacks, DB) + STACK_MARGIN;
-	if (regs->sp >= estack_bottom && regs->sp <= estack_top)
-		return;
-
-	WARN_ONCE(1, "do_IRQ(): %s has overflown the kernel stack (cur:%Lx,sp:%lx, irq stack:%Lx-%Lx, exception stack: %Lx-%Lx, ip:%pF)\n",
-		current->comm, curbase, regs->sp,
-		irq_stack_bottom, irq_stack_top,
-		estack_bottom, estack_top, (void *)regs->ip);
-
-	if (sysctl_panic_on_stackoverflow)
-		panic("low stack detected by irq handler - check messages\n");
-#endif
-}
-
 bool handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
-	stack_overflow_check(regs);
-
 	if (IS_ERR_OR_NULL(desc))
 		return false;
 
