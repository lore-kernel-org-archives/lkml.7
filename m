Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAB92086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbfCaWLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:11:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbfCaWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:26 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAiem-0004qD-31; Mon, 01 Apr 2019 00:10:24 +0200
Message-Id: <20190331215134.837052834@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
Subject: [patch 01/14] x86/irq/64: Limit IST stack overflow check to #DB stack
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

37fe6a42b343 ("x86: Check stack overflow in detail") added a broad check
for the full exception stack area, i.e. it considers the full exception
stack are as valid.

That's wrong in two aspects:

 1) It does not check the individual areas one by one

 2) #DF, NMI and #MCE are not enabling interrupts which means that a
    regular device interrupt cannot happen in their context. In fact if a
    device interrupt hits one of those IST stacks that's a bug because some
    code path enabled interrupts while handling the exception.

Limit the check to the #DB stack and consider all other IST stacks as
'overflow' or invalid.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
---
 arch/x86/kernel/irq_64.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,9 +26,18 @@ int sysctl_panic_on_stackoverflow;
 /*
  * Probabilistic stack overflow check:
  *
- * Only check the stack in process context, because everything else
- * runs on the big interrupt stacks. Checking reliably is too expensive,
- * so we just check from interrupts.
+ * Regular device interrupts can enter on the following stacks:
+ *
+ * - User stack
+ *
+ * - Kernel task stack
+ *
+ * - Interrupt stack if a device driver reenables interrupt
+ *   which should only happen in really old drivers.
+ *
+ * - Debug IST stack
+ *
+ * All other contexts are invalid.
  */
 static inline void stack_overflow_check(struct pt_regs *regs)
 {
@@ -53,8 +62,8 @@ static inline void stack_overflow_check(
 		return;
 
 	oist = this_cpu_ptr(&orig_ist);
-	estack_top = (u64)oist->ist[0] - EXCEPTION_STKSZ + STACK_TOP_MARGIN;
-	estack_bottom = (u64)oist->ist[N_EXCEPTION_STACKS - 1];
+	estack_bottom = (u64)oist->ist[DEBUG_STACK];
+	estack_top = estack_bottom - DEBUG_STKSZ + STACK_TOP_MARGIN;
 	if (regs->sp >= estack_top && regs->sp <= estack_bottom)
 		return;
 


