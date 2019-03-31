Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7709AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484D82086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfCaWLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:11:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57619 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbfCaWKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:32 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAier-0004rF-VP; Mon, 01 Apr 2019 00:10:30 +0200
Message-Id: <20190331215135.667707146@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 10/14] x86/irq/64: Use cpu entry area instead of orig_ist
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The orig_ist[] array is a shadow copy of the IST array in the TSS. The
reason why it exists is that older kernels used two TSS variants with
different pointers into the debug stack. orig_ist[] contains the real
starting points.

There is no point anymore to do so because the same information can be
retrieved using the base address of the cpu entry area mapping and the
offsets of the various exception stacks.

No functional change. Preparation for removing orig_ist.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/irq_64.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -18,6 +18,8 @@
 #include <linux/uaccess.h>
 #include <linux/smp.h>
 #include <linux/sched/task_stack.h>
+
+#include <asm/cpu_entry_area.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
@@ -42,11 +44,12 @@ int sysctl_panic_on_stackoverflow;
 static inline void stack_overflow_check(struct pt_regs *regs)
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
+
 #define STACK_TOP_MARGIN	128
-	struct orig_ist *oist;
-	u64 irq_stack_top, irq_stack_bottom;
-	u64 estack_top, estack_bottom;
+
+	u64 irq_stack_top, irq_stack_bottom, estack_top, estack_bottom;
 	u64 curbase = (u64)task_stack_page(current);
+	struct cea_exception_stacks *estacks;
 
 	if (user_mode(regs))
 		return;
@@ -61,9 +64,10 @@ static inline void stack_overflow_check(
 	if (regs->sp >= irq_stack_top && regs->sp <= irq_stack_bottom)
 		return;
 
-	oist = this_cpu_ptr(&orig_ist);
-	estack_bottom = (u64)oist->ist[DEBUG_STACK];
-	estack_top = estack_bottom - DEBUG_STKSZ + STACK_TOP_MARGIN;
+	estacks = __this_cpu_read(cea_exception_stacks);
+	estack_top = (u64)estacks->DB_stack;
+	estack_bottom = estack_top + sizeof(estacks->DB_stack);
+	estack_top += STACK_TOP_MARGIN;
 	if (regs->sp >= estack_top && regs->sp <= estack_bottom)
 		return;
 


