Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD7BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3E720872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cVNxR3Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfDQOUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:20:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56985 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbfDQOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:20:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEIfGu3935492
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:18:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEIfGu3935492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510722;
        bh=z4RUN2z+mkQ1VjzMNA0vYEJawBo92Yz1HRqahcDVVZE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cVNxR3Np2THwGvHfzmV7MYc85OWtKP7P/IX36MuQ9dWYYd7YXs1XgMVQG/r6LJ9FV
         4QabP4rZCwQN18A2y2kfug3ids+IC1oQD7ovAfSyC3nTVSbjVWlDh35HAbw34VOu7m
         nw0rkxbbzqshej4vnzRr5Hk47F55CYr/cy4zXzPaFWWo04OOXMW89QzaQ4LyC9zLbD
         7RxXVkYLU9TgKbIyBeXUQCxhw81dwLy1z3tqnKcA6otK8oED7OHPMgS6ocbXAEsmJH
         JGE0AaB3rxaI/1L+qFo/AJcLh4VWb4Bs1vGqEc4Ng3D+F/H6AJ6pY+sz5U2KhQNKz+
         2a3UZ6YK4DrbQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEIfP63935489;
        Wed, 17 Apr 2019 07:18:41 -0700
Date:   Wed, 17 Apr 2019 07:18:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a754fe2b76d1d6bce7069657bba975034f3ad961@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, bp@suse.de,
        dave.hansen@linux.intel.com, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, jkosina@suse.cz, mingo@redhat.com,
        ndesaulniers@google.com, nstange@suse.de, tglx@linutronix.de,
        jgross@suse.com, jpoimboe@redhat.com, x86@kernel.org,
        sean.j.christopherson@intel.com, akpm@linux-foundation.org,
        luto@kernel.org
Reply-To: akpm@linux-foundation.org, luto@kernel.org,
          sean.j.christopherson@intel.com, tglx@linutronix.de,
          jgross@suse.com, jpoimboe@redhat.com, x86@kernel.org,
          jkosina@suse.cz, mingo@redhat.com, ndesaulniers@google.com,
          nstange@suse.de, vbabka@suse.cz, linux-kernel@vger.kernel.org,
          dave.hansen@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
          bp@suse.de
In-Reply-To: <20190414160145.824805922@linutronix.de>
References: <20190414160145.824805922@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/32: Rename hard/softirq_stack to
 hard/softirq_stack_ptr
Git-Commit-ID: a754fe2b76d1d6bce7069657bba975034f3ad961
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

Commit-ID:  a754fe2b76d1d6bce7069657bba975034f3ad961
Gitweb:     https://git.kernel.org/tip/a754fe2b76d1d6bce7069657bba975034f3ad961
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 18:00:01 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:24:18 +0200

x86/irq/32: Rename hard/softirq_stack to hard/softirq_stack_ptr

The percpu storage holds a pointer to the stack not the stack
itself. Rename it before sharing struct irq_stack with 64-bit.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.824805922@linutronix.de
---
 arch/x86/include/asm/processor.h |  4 ++--
 arch/x86/kernel/dumpstack_32.c   |  4 ++--
 arch/x86/kernel/irq_32.c         | 19 ++++++++++---------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ff3f469ab2d4..0b7d866a1ad5 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -425,8 +425,8 @@ struct irq_stack {
 	char			stack[IRQ_STACK_SIZE];
 } __aligned(IRQ_STACK_SIZE);
 
-DECLARE_PER_CPU(struct irq_stack *, hardirq_stack);
-DECLARE_PER_CPU(struct irq_stack *, softirq_stack);
+DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* X86_64 */
 
 extern unsigned int fpu_kernel_xstate_size;
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index d305440ebe9c..64a59d726639 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -34,7 +34,7 @@ const char *stack_type_name(enum stack_type type)
 
 static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack);
+	unsigned long *begin = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
@@ -59,7 +59,7 @@ static bool in_hardirq_stack(unsigned long *stack, struct stack_info *info)
 
 static bool in_softirq_stack(unsigned long *stack, struct stack_info *info)
 {
-	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack);
+	unsigned long *begin = (unsigned long *)this_cpu_read(softirq_stack_ptr);
 	unsigned long *end   = begin + (THREAD_SIZE / sizeof(long));
 
 	/*
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index 95600a99ae93..f37489c806fa 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -51,8 +51,8 @@ static inline int check_stack_overflow(void) { return 0; }
 static inline void print_stack_overflow(void) { }
 #endif
 
-DEFINE_PER_CPU(struct irq_stack *, hardirq_stack);
-DEFINE_PER_CPU(struct irq_stack *, softirq_stack);
+DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
+DEFINE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 
 static void call_on_stack(void *func, void *stack)
 {
@@ -76,7 +76,7 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 	u32 *isp, *prev_esp, arg1;
 
 	curstk = (struct irq_stack *) current_stack();
-	irqstk = __this_cpu_read(hardirq_stack);
+	irqstk = __this_cpu_read(hardirq_stack_ptr);
 
 	/*
 	 * this is where we switch to the IRQ stack. However, if we are
@@ -113,21 +113,22 @@ void irq_ctx_init(int cpu)
 {
 	struct irq_stack *irqstk;
 
-	if (per_cpu(hardirq_stack, cpu))
+	if (per_cpu(hardirq_stack_ptr, cpu))
 		return;
 
 	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
 					       THREADINFO_GFP,
 					       THREAD_SIZE_ORDER));
-	per_cpu(hardirq_stack, cpu) = irqstk;
+	per_cpu(hardirq_stack_ptr, cpu) = irqstk;
 
 	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
 					       THREADINFO_GFP,
 					       THREAD_SIZE_ORDER));
-	per_cpu(softirq_stack, cpu) = irqstk;
+	per_cpu(softirq_stack_ptr, cpu) = irqstk;
 
-	printk(KERN_DEBUG "CPU %u irqstacks, hard=%p soft=%p\n",
-	       cpu, per_cpu(hardirq_stack, cpu),  per_cpu(softirq_stack, cpu));
+	pr_debug("CPU %u irqstacks, hard=%p soft=%p\n",
+		 cpu, per_cpu(hardirq_stack_ptr, cpu),
+		 per_cpu(softirq_stack_ptr, cpu));
 }
 
 void do_softirq_own_stack(void)
@@ -135,7 +136,7 @@ void do_softirq_own_stack(void)
 	struct irq_stack *irqstk;
 	u32 *isp, *prev_esp;
 
-	irqstk = __this_cpu_read(softirq_stack);
+	irqstk = __this_cpu_read(softirq_stack_ptr);
 
 	/* build the stack frame on the softirq stack */
 	isp = (u32 *) ((char *)irqstk + sizeof(*irqstk));
