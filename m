Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B89C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F942218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfDEPLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48885 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbfDEPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:14 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUr-0005sQ-BT; Fri, 05 Apr 2019 17:11:13 +0200
Message-Id: <20190405150929.574147028@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 13/29] x86/irq/64: Use cpu entry area instead of orig_ist
References: <20190405150658.237064784@linutronix.de>
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
 arch/x86/kernel/irq_64.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
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
 
@@ -43,10 +45,9 @@ static inline void stack_overflow_check(
 {
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 #define STACK_MARGIN	128
-	struct orig_ist *oist;
-	u64 irq_stack_top, irq_stack_bottom;
-	u64 estack_top, estack_bottom;
+	u64 irq_stack_top, irq_stack_bottom, estack_top, estack_bottom;
 	u64 curbase = (u64)task_stack_page(current);
+	struct cea_exception_stacks *estacks;
 
 	if (user_mode(regs))
 		return;
@@ -60,9 +61,9 @@ static inline void stack_overflow_check(
 	if (regs->sp >= irq_stack_bottom && regs->sp <= irq_stack_top)
 		return;
 
-	oist = this_cpu_ptr(&orig_ist);
-	estack_top = (u64)oist->ist[ISTACK_DB];
-	estack_bottom = estack_top - DEBUG_STKSZ + STACK_MARGIN;
+	estacks = __this_cpu_read(cea_exception_stacks);
+	estack_top = CEA_ESTACK_TOP(estacks, DB);
+	estack_bottom = CEA_ESTACK_BOT(estacks, DB) + STACK_MARGIN;
 	if (regs->sp >= estack_bottom && regs->sp <= estack_top)
 		return;
 


