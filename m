Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B94C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFA12177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KWB7cHyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfDQOQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:16:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38985 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:16:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEGbRE3934999
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:16:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEGbRE3934999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510598;
        bh=yyQ4CgaRCPawlQD5KB50ZnrQVhJH2BMTTkYjoM58KBg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KWB7cHyk9NbWUV/SAMGRCapv1cql6ftiAxFV9UlXSY++gu8FxjGBuJ0OPacMsBZq9
         ev0ByHKAmanbJvTDD4UpF/8oyA0PSYHeG9B6UKFXS+xMR2yid2E6v5qI2a26ADfTdu
         Vb2/u+QlJB4AuZVqNR4tFlmbxIbiD32A7wsI1C3XpsF/Qu6rd5Vm+bPLn3wjm5weod
         /5vTM9T2f/GnIr0NPAW9ihRlSdLdDmcIdcT4OFYVD1GQUqr0b1xgxJvboIEMRsAoqe
         s23xEU99RD8tSYK8I7FJE8vNPWK4e7iOCX5VVacHpdyAfOsre9WpYRqdCn91TAqloC
         c5AwOl7ydCMvg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEGbEj3934995;
        Wed, 17 Apr 2019 07:16:37 -0700
Date:   Wed, 17 Apr 2019 07:16:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c450c8f532b63475b30e29bc600c25ab0a4ab282@git.kernel.org>
Cc:     x86@kernel.org, sean.j.christopherson@intel.com,
        tglx@linutronix.de, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jpoimboe@redhat.com, mingo@redhat.com, bp@suse.de
Reply-To: mingo@redhat.com, jpoimboe@redhat.com, mingo@kernel.org,
          bp@suse.de, x86@kernel.org, tglx@linutronix.de,
          sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
          luto@kernel.org, hpa@zytor.com
In-Reply-To: <20190414160145.543320386@linutronix.de>
References: <20190414160145.543320386@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/dumpstack/64: Speedup in_exception_stack()
Git-Commit-ID: c450c8f532b63475b30e29bc600c25ab0a4ab282
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c450c8f532b63475b30e29bc600c25ab0a4ab282
Gitweb:     https://git.kernel.org/tip/c450c8f532b63475b30e29bc600c25ab0a4ab282
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:58 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:16:57 +0200

x86/dumpstack/64: Speedup in_exception_stack()

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.543320386@linutronix.de
---
 arch/x86/kernel/dumpstack_64.c | 82 ++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index fca97bd3d8ae..f356d3ea0c70 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -50,52 +50,72 @@ const char *stack_type_name(enum stack_type type)
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
+#define EPAGERANGE(st)							\
+	[PFN_DOWN(CEA_ESTACK_OFFS(st)) ...				\
+	 PFN_DOWN(CEA_ESTACK_OFFS(st) + CEA_ESTACK_SIZE(st) - 1)] = {	\
+		.offs	= CEA_ESTACK_OFFS(st),				\
+		.size	= CEA_ESTACK_SIZE(st),				\
+		.type	= STACK_TYPE_EXCEPTION + ESTACK_ ##st, }
 
-static const struct estack_layout layout[] = {
-	[ ESTACK_DF	]	= ESTACK_ENTRY(DF),
-	[ ESTACK_NMI	]	= ESTACK_ENTRY(NMI),
-	[ ESTACK_DB2	]	= { .begin = 0, .end = 0},
-	[ ESTACK_DB1	]	= ESTACK_ENTRY(DB1),
-	[ ESTACK_DB	]	= ESTACK_ENTRY(DB),
-	[ ESTACK_MCE	]	= ESTACK_ENTRY(MCE),
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
+	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
+	end = begin + sizeof(struct cea_exception_stacks);
+	/* Bail if @stack is outside the exception stack area. */
+	if (stk < begin || stk >= end)
+		return false;
 
-		if (stk < begin || stk >= end)
-			continue;
+	/* Calc page offset from start of exception stacks */
+	k = (stk - begin) >> PAGE_SHIFT;
+	/* Lookup the page descriptor */
+	ep = &estack_pages[k];
+	/* Guard page? */
+	if (!ep->size)
+		return false;
 
-		info->type	= STACK_TYPE_EXCEPTION + k;
-		info->begin	= (unsigned long *)begin;
-		info->end	= (unsigned long *)end;
-		info->next_sp	= (unsigned long *)regs->sp;
+	begin += (unsigned long)ep->offs;
+	end = begin + (unsigned long)ep->size;
+	regs = (struct pt_regs *)end - 1;
 
-		return true;
-	}
-
-	return false;
+	info->type	= ep->type;
+	info->begin	= (unsigned long *)begin;
+	info->end	= (unsigned long *)end;
+	info->next_sp	= (unsigned long *)regs->sp;
+	return true;
 }
 
 static bool in_irq_stack(unsigned long *stack, struct stack_info *info)
