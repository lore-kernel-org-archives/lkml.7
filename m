Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79EDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04CD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfDBKTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:19:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfDBKTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:19:49 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBGWA-000233-N2; Tue, 02 Apr 2019 12:19:46 +0200
Date:   Tue, 2 Apr 2019 12:19:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
In-Reply-To: <20190331215136.039902969@linutronix.de>
Message-ID: <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de>
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

The table is filled at compile time with nasty macro magic and for the
!KASAN case the interesting page descriptors exactly fit into a single
cache line. Just the last guard page descriptor is in the next cacheline,
but that should not be accessed in the regular case.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/dumpstack_64.c |   97 +++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 31 deletions(-)

--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -48,50 +48,85 @@ const char *stack_type_name(enum stack_t
 	return NULL;
 }
 
-struct estack_layout {
-	unsigned int	begin;
-	unsigned int	end;
+#define ESTACK_S(st)						\
+	(offsetof(struct cea_exception_stacks, st## _stack))
+
+#define ESTACK_E(st)							\
+	(offsetof(struct cea_exception_stacks, st## _stack_guard))
+
+#define PAGENR(offs)	((offs) / PAGE_SIZE)
+#define PAGERANGE(st)	PAGENR(ESTACK_S(st)) ... PAGENR(ESTACK_E(st) - 1)
+
+#if EXCEPTION_STKSZ == PAGE_SIZE
+# define CONDRANGE(st)	PAGENR(ESTACK_S(st))
+#else
+# define CONDRANGE(st)	PAGERANGE(st)
+#endif
+
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
+#define ESTACK_PAGE(ist, est) {				\
+	.offs	= ESTACK_S(est),			\
+	.size	= ESTACK_E(est) - ESTACK_S(est),	\
+	.type	= STACK_TYPE_EXCEPTION + ist,		\
 	}
 
-static const struct estack_layout layout[N_EXCEPTION_STACKS] = {
-	[ DOUBLEFAULT_IST	]	= ESTACK_ENTRY(DF),
-	[ NMI_IST		]	= ESTACK_ENTRY(NMI),
-	[ DEBUG_IST		]	= ESTACK_ENTRY(DB),
-	[ MCE_IST		]	= ESTACK_ENTRY(MCE),
+#define ESTACK_PAGES	(sizeof(struct cea_exception_stacks) / PAGE_SIZE)
+
+/*
+ * Array of exception stack page descriptors. If the stack is larger than
+ * PAGE_SIZE, all pages covering a particular stack will have the same
+ * info.
+ */
+static const struct estack_pages estack_pages[ESTACK_PAGES] ____cacheline_aligned = {
+	[CONDRANGE(DF)]		= ESTACK_PAGE(DOUBLEFAULT_IST, DF),
+	[CONDRANGE(NMI)]	= ESTACK_PAGE(NMI_IST, NMI),
+	[PAGERANGE(DB)]		= ESTACK_PAGE(DEBUG_IST, DB),
+	[CONDRANGE(MCE)]	= ESTACK_PAGE(MCE_IST, MCE),
 };
 
 static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long estacks, begin, end, stk = (unsigned long)stack;
+	unsigned long begin, end, stk = (unsigned long)stack;
+	const struct estack_pages *ep;
 	struct pt_regs *regs;
 	unsigned int k;
 
 	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
 
-	estacks = (unsigned long)__this_cpu_read(cea_exception_stacks);
-
-	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
-		begin = estacks + layout[k].begin;
-		end   = estacks + layout[k].end;
-		regs  = (struct pt_regs *)end - 1;
-
-		if (stk <= begin || stk >= end)
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
+	if (stk <= begin || stk >= end)
+		return false;
+
+	/* Calc page offset from start of exception stacks */
+	k = (stk - begin) >> PAGE_SHIFT;
+	/* Lookup the page descriptor */
+	ep = &estack_pages[k];
+	/* Guard page? */
+	if (unlikely(!ep->size))
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
