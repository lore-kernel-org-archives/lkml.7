Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61D3C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3620684
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfDNQDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:03:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43324 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfDNQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:03:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhaz-0002iV-RZ; Sun, 14 Apr 2019 18:03:07 +0200
Message-Id: <20190414160145.632513987@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 17:59:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 23/32] x86/irq/32: Define IRQ_STACK_SIZE
References: <20190414155936.679808307@linutronix.de>
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


