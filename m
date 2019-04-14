Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D57C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEC92084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfDNQDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:03:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDNQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:03:07 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhay-0002hF-8p; Sun, 14 Apr 2019 18:03:04 +0200
Message-Id: <20190414160145.543320386@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 17:59:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 22/32] x86/dumpstack/64: Speedup in_exception_stack()
References: <20190414155936.679808307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of in_exception_stack() iterates over the
exception stacks array. Most of the time this is an useless exercise, but
even for the actual use cases (perf and ftrace) it takes at least 2
iterations to get to the NMI stack.

As the exception stacks and the guard pages are page aligned the loop can
be avoided completely.

Add a initial check whether the stack pointer is inside the full exception
stack area and leave early if not.

Create a lookup table which describes the stack area. The table index is
the page offset from the beginning of the exception stacks. So for any
given stack pointer the page offset is computed and a lookup in the
description table is performed. If it is inside a guard page, return. If
not, use the descriptor to fill in the info structure.

The table is filled at compile time and for the !KASAN case the interesting
page descriptors exactly fit into a single cache line. Just the last guard
page descriptor is in the next cacheline, but that should not be accessed
in the regular case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
V2: Simplify the macro maze
---
 arch/x86/kernel/dumpstack_64.c |   90 +++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 35 deletions(-)

--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -50,52 +50,72 @@ const char *stack_type_name(enum stack_t
 	return NULL;
 }
 
-struct estack_layout {
-	unsigned int	begin;
-	unsigned int	end;
+/**
+ * struct estack_pages - Page descriptor for exception stacks
+ * @offs:	Offset from the start of the exception stack area
+ * @size:	Size of the exception stack
+ * @type:	Type to store in the stack_info struct
+ */
+struct estack_pages {
+	u32	offs;
+	u16	size;
+	u16	type;
 };
 
-#define	ESTACK_ENTRY(x)	{						  \
-	.begin	= offsetof(struct cea_exception_stacks, x## _stack),	  \
-	.end	= offsetof(struct cea_exception_stacks, x## _stack_guard) \
-	}
-
-static const struct estack_layout layout[] = {
-	[ ESTACK_DF	]	= ESTACK_ENTRY(DF),
-	[ ESTACK_NMI	]	= ESTACK_ENTRY(NMI),
-	[ ESTACK_DB2	]	= { .begin = 0, .end = 0},
-	[ ESTACK_DB1	]	= ESTACK_ENTRY(DB1),
-	[ ESTACK_DB	]	= ESTACK_ENTRY(DB),
-	[ ESTACK_MCE	]	= ESTACK_ENTRY(MCE),
+#define EPAGERANGE(st)							\
+	[PFN_DOWN(CEA_ESTACK_OFFS(st)) ...				\
+	 PFN_DOWN(CEA_ESTACK_OFFS(st) + CEA_ESTACK_SIZE(st) - 1)] = {	\
+		.offs	= CEA_ESTACK_OFFS(st),				\
+		.size	= CEA_ESTACK_SIZE(st),				\
+		.type	= STACK_TYPE_EXCEPTION + ESTACK_ ##st, }
+
+/*
+ * Array of exception stack page descriptors. If the stack is larger than
+ * PAGE_SIZE, all pages covering a particular stack will have the same
+ * info. The guard pages including the not mapped DB2 stack are zeroed
+ * out.
+ */
+static const
+struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
+	EPAGERANGE(DF),
+	EPAGERANGE(NMI),
+	EPAGERANGE(DB1),
+	EPAGERANGE(DB),
+	EPAGERANGE(MCE),
 };
 
 static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long estacks, begin, end, stk = (unsigned long)stack;
+	unsigned long begin, end, stk = (unsigned long)stack;
+	const struct estack_pages *ep;
 	struct pt_regs *regs;
 	unsigned int k;
 
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
-	estacks = (unsigned long)__this_cpu_read(cea_exception_stacks);
-
-	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
-		begin = estacks + layout[k].begin;
-		end   = estacks + layout[k].end;
-		regs  = (struct pt_regs *)end - 1;
-
-		if (stk < begin || stk >= end)
-			continue;
-
-		info->type	= STACK_TYPE_EXCEPTION + k;
-		info->begin	= (unsigned long *)begin;
-		info->end	= (unsigned long *)end;
-		info->next_sp	= (unsigned long *)regs->sp;
-
-		return true;
-	}
-
-	return false;
+	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
+	end = begin + sizeof(struct cea_exception_stacks);
+	/* Bail if @stack is outside the exception stack area. */
+	if (stk < begin || stk >= end)
+		return false;
+
+	/* Calc page offset from start of exception stacks */
+	k = (stk - begin) >> PAGE_SHIFT;
+	/* Lookup the page descriptor */
+	ep = &estack_pages[k];
+	/* Guard page? */
+	if (!ep->size)
+		return false;
+
+	begin += (unsigned long)ep->offs;
+	end = begin + (unsigned long)ep->size;
+	regs = (struct pt_regs *)end - 1;
+
+	info->type	= ep->type;
+	info->begin	= (unsigned long *)begin;
+	info->end	= (unsigned long *)end;
+	info->next_sp	= (unsigned long *)regs->sp;
+	return true;
 }
 
 static bool in_irq_stack(unsigned long *stack, struct stack_info *info)


