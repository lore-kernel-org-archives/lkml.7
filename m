Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A268218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfDEPLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48837 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbfDEPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUk-0005r4-MS; Fri, 05 Apr 2019 17:11:06 +0200
Message-Id: <20190405150928.775570131@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 04/29] x86/irq/64: Sanitize the top/bottom confusion
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 stacks go top to bottom, but the stack overflow check uses it the
other way round, which is just confusing. Clean it up and sanitize the
warning string a bit.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/irq_64.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -42,7 +42,7 @@ int sysctl_panic_on_stackoverflow;
 static inline void stack_overflow_check(struct pt_regs *regs)
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-#define STACK_TOP_MARGIN	128
+#define STACK_MARGIN	128
 	struct orig_ist *oist;
 	u64 irq_stack_top, irq_stack_bottom;
 	u64 estack_top, estack_bottom;
@@ -51,25 +51,25 @@ static inline void stack_overflow_check(
 	if (user_mode(regs))
 		return;
 
-	if (regs->sp >= curbase + sizeof(struct pt_regs) + STACK_TOP_MARGIN &&
+	if (regs->sp >= curbase + sizeof(struct pt_regs) + STACK_MARGIN &&
 	    regs->sp <= curbase + THREAD_SIZE)
 		return;
 
-	irq_stack_bottom = (u64)__this_cpu_read(irq_stack_ptr);
-	irq_stack_top = irq_stack_bottom - IRQ_STACK_SIZE + STACK_TOP_MARGIN;
-	if (regs->sp >= irq_stack_top && regs->sp <= irq_stack_bottom)
+	irq_stack_top = (u64)__this_cpu_read(irq_stack_ptr);
+	irq_stack_bottom = irq_stack_top - IRQ_STACK_SIZE + STACK_MARGIN;
+	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
 		return;
 
 	oist = this_cpu_ptr(&orig_ist);
-	estack_bottom = (u64)oist->ist[DEBUG_STACK];
-	estack_top = estack_bottom - DEBUG_STKSZ + STACK_TOP_MARGIN;
-	if (regs->sp >= estack_top && regs->sp <= estack_bottom)
+	estack_top = (u64)oist->ist[DEBUG_STACK];
+	estack_bottom = estack_top - DEBUG_STKSZ + STACK_MARGIN;
+	if (regs->sp >= estack_bottom && regs->sp <= estack_top)
 		return;
 
-	WARN_ONCE(1, "do_IRQ(): %s has overflown the kernel stack (cur:%Lx,sp:%lx,irq stk top-bottom:%Lx-%Lx,exception stk top-bottom:%Lx-%Lx,ip:%pF)\n",
+	WARN_ONCE(1, "do_IRQ(): %s has overflown the kernel stack (cur:%Lx,sp:%lx, irq stack:%Lx-%Lx, exception stack: %Lx-%Lx, ip:%pF)\n",
 		current->comm, curbase, regs->sp,
-		irq_stack_top, irq_stack_bottom,
-		estack_top, estack_bottom, (void *)regs->ip);
+		irq_stack_bottom, irq_stack_top,
+		estack_bottom, estack_top, (void *)regs->ip);
 
 	if (sysctl_panic_on_stackoverflow)
 		panic("low stack detected by irq handler - check messages\n");


