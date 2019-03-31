Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3026BC10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075A020882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfCaWKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:10:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57623 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbfCaWKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:33 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAies-0004rM-PY; Mon, 01 Apr 2019 00:10:30 +0200
Message-Id: <20190331215135.770217379@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:31 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 11/14] x86/dumpstack/64: Use cpu_entry_area instead of orig_ist
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/dumpstack_64.c |   39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -16,6 +16,7 @@
 #include <linux/bug.h>
 #include <linux/nmi.h>
 
+#include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
 
 static const char *exception_stack_names[N_EXCEPTION_STACKS] = {
@@ -25,11 +26,6 @@ static const char *exception_stack_names
 		[ MCE_IST		]	= "#MC",
 };
 
-static const unsigned long exception_stack_sizes[N_EXCEPTION_STACKS] = {
-	[0 ... N_EXCEPTION_STACKS - 1]		= EXCEPTION_STKSZ,
-	[DEBUG_IST]				= DEBUG_STKSZ
-};
-
 const char *stack_type_name(enum stack_type type)
 {
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
@@ -52,25 +48,44 @@ const char *stack_type_name(enum stack_t
 	return NULL;
 }
 
+struct estack_layout {
+	unsigned int	begin;
+	unsigned int	end;
+};
+
+#define	ESTACK_ENTRY(x)	{						  \
+	.begin	= offsetof(struct cea_exception_stacks, x## _stack),	  \
+	.end	= offsetof(struct cea_exception_stacks, x## _stack_guard) \
+	}
+
+static const struct estack_layout layout[N_EXCEPTION_STACKS] = {
+	[ DOUBLEFAULT_IST	]	= ESTACK_ENTRY(DF),
+	[ NMI_IST		]	= ESTACK_ENTRY(NMI),
+	[ DEBUG_IST		]	= ESTACK_ENTRY(DB),
+	[ MCE_IST		]	= ESTACK_ENTRY(MCE),
+};
+
 static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin, *end;
+	unsigned long estacks, begin, end, stk = (unsigned long)stack;
 	struct pt_regs *regs;
-	unsigned k;
+	unsigned int k;
 
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
+	estacks = (unsigned long)__this_cpu_read(cea_exception_stacks);
+
 	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
-		end   = (unsigned long *)raw_cpu_ptr(&orig_ist)->ist[k];
-		begin = end - (exception_stack_sizes[k] / sizeof(long));
+		begin = estacks + layout[k].begin;
+		end   = estacks + layout[k].end;
 		regs  = (struct pt_regs *)end - 1;
 
-		if (stack <= begin || stack >= end)
+		if (stk <= begin || stk >= end)
 			continue;
 
 		info->type	= STACK_TYPE_EXCEPTION + k;
-		info->begin	= begin;
-		info->end	= end;
+		info->begin	= (unsigned long *)begin;
+		info->end	= (unsigned long *)end;
 		info->next_sp	= (unsigned long *)regs->sp;
 
 		return true;


