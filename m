Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5535C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1BB218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfDEPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:13:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48835 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731445AbfDEPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:08 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUj-0005qs-F8; Fri, 05 Apr 2019 17:11:05 +0200
Message-Id: <20190405150928.596372581@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 02/29] x86/dumpstack: Fix off-by-one errors in stack
 identification
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

The get_stack_info() function is off-by-one when checking whether an
address is on a IRQ stack or a IST stack.  This prevents a overflowed IRQ
or IST stack from being dumped properly.

[ tglx: Do the same for 32-bit ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>

---
 arch/x86/kernel/dumpstack_32.c |    4 ++--
 arch/x86/kernel/dumpstack_64.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -41,7 +41,7 @@ static bool in_hardirq_stack(unsigned lo
 	 * This is a software stack, so 'end' can be a valid stack pointer.
 	 * It just means the stack is empty.
 	 */
-	if (stack <= begin || stack > end)
+	if (stack < begin || stack > end)
 		return false;
 
 	info->type	= STACK_TYPE_IRQ;
@@ -66,7 +66,7 @@ static bool in_softirq_stack(unsigned lo
 	 * This is a software stack, so 'end' can be a valid stack pointer.
 	 * It just means the stack is empty.
 	 */
-	if (stack <= begin || stack > end)
+	if (stack < begin || stack > end)
 		return false;
 
 	info->type	= STACK_TYPE_SOFTIRQ;
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -65,7 +65,7 @@ static bool in_exception_stack(unsigned
 		begin = end - (exception_stack_sizes[k] / sizeof(long));
 		regs  = (struct pt_regs *)end - 1;
 
-		if (stack <= begin || stack >= end)
+		if (stack < begin || stack >= end)
 			continue;
 
 		info->type	= STACK_TYPE_EXCEPTION + k;
@@ -88,7 +88,7 @@ static bool in_irq_stack(unsigned long *
 	 * This is a software stack, so 'end' can be a valid stack pointer.
 	 * It just means the stack is empty.
 	 */
-	if (stack <= begin || stack > end)
+	if (stack < begin || stack >= end)
 		return false;
 
 	info->type	= STACK_TYPE_IRQ;


