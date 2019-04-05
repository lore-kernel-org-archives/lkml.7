Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72DF2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfDEPMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:12:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48932 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbfDEPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:22 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUy-0005u2-8m; Fri, 05 Apr 2019 17:11:20 +0200
Message-Id: <20190405150930.308710267@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:19 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 21/29] x86/irq/32: Define IRQ_STACK_SIZE
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit IRQ_STACK_SIZE is the same as THREAD_SIZE.

To allow sharing struct irq_stack with 32-bit, define IRQ_STACK_SIZE for
32-bit and use of for struct irq_stack.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/page_32_types.h |    2 ++
 arch/x86/include/asm/processor.h     |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -22,6 +22,8 @@
 #define THREAD_SIZE_ORDER	1
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
+#define IRQ_STACK_SIZE		THREAD_SIZE
+
 #define N_EXCEPTION_STACKS	1
 
 #ifdef CONFIG_X86_PAE
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -422,8 +422,8 @@ DECLARE_PER_CPU_ALIGNED(struct stack_can
  * per-CPU IRQ handling stacks
  */
 struct irq_stack {
-	u32                     stack[THREAD_SIZE/sizeof(u32)];
-} __aligned(THREAD_SIZE);
+	u32			stack[IRQ_STACK_SIZE / sizeof(u32)];
+} __aligned(IRQ_STACK_SIZE);
 
 DECLARE_PER_CPU(struct irq_stack *, hardirq_stack);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack);


