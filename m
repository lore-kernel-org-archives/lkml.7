Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8553C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A6E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iVk2JW1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfDQOIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:08:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfDQOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:08:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE7Qvv3933359
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:07:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE7Qvv3933359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510047;
        bh=NoZanfyR8WwJhZG+UCXalE3OEJtQOLuZzR0IgZ3CkEQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iVk2JW1LqubL0qYAxGeFCosTumI/WbRDvRBBPeucWkmDMLYhacrnWd8BHQVI41x8o
         4oVbgFs6pI/LauqPbN5RFtIsCZCO3kZ3i0nljaR0sqYk5Cedx96pJQcBJfnJKnR0sc
         HpXGsh+f6C8ja6/9fabJDWRVJlA6zAwS0nztaZ7gMj5P2I7+KbeaV9rMZgo0O6/wtr
         F0mLdA5xTgNaKeROPpQ4TgnezoPIhjEAagnIxD0LQt1w+uUllx02MSKAl2IDpTH6wO
         dEXawAaMU6ha/0tCmbwyTvJ0pUVtqOV64zzd7QgGwWB4cFq6KgeRQrkAvRNGwZiaYN
         SSGSJ7lT+xf7A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE7PJ03933351;
        Wed, 17 Apr 2019 07:07:25 -0700
Date:   Wed, 17 Apr 2019 07:07:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-8f34c5b5afce91d171bb0802631197484cb69b8b@git.kernel.org>
Cc:     corbet@lwn.net, dave.hansen@linux.intel.com, bhe@redhat.com,
        mingo@redhat.com, cai@lca.pw, douly.fnst@cn.fujitsu.com,
        x86@kernel.org, jpoimboe@redhat.com, nstange@suse.de,
        tglx@linutronix.de, bp@suse.de, luto@kernel.org,
        peterz@infradead.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        mingo@kernel.org, sean.j.christopherson@intel.com,
        kirill.shutemov@linux.intel.com, linux@dominikbrodowski.net,
        hpa@zytor.com
Reply-To: douly.fnst@cn.fujitsu.com, luto@kernel.org, x86@kernel.org,
          tglx@linutronix.de, jpoimboe@redhat.com, nstange@suse.de,
          bp@suse.de, mingo@redhat.com, corbet@lwn.net, bhe@redhat.com,
          dave.hansen@linux.intel.com, cai@lca.pw,
          sean.j.christopherson@intel.com, kirill.shutemov@linux.intel.com,
          mingo@kernel.org, hpa@zytor.com, linux@dominikbrodowski.net,
          linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
          peterz@infradead.org, konrad.wilk@oracle.com
In-Reply-To: <20190414160144.331772825@linutronix.de>
References: <20190414160144.331772825@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/exceptions: Make IST index zero based
Git-Commit-ID: 8f34c5b5afce91d171bb0802631197484cb69b8b
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

Commit-ID:  8f34c5b5afce91d171bb0802631197484cb69b8b
Gitweb:     https://git.kernel.org/tip/8f34c5b5afce91d171bb0802631197484cb69b8b
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:45 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:48:00 +0200

x86/exceptions: Make IST index zero based

The defines for the exception stack (IST) array in the TSS are using the
SDM convention IST1 - IST7. That causes all sorts of code to subtract 1 for
array indices related to IST. That's confusing at best and does not provide
any value.

Make the indices zero based and fixup the usage sites. The only code which
needs to adjust the 0 based index is the interrupt descriptor setup which
needs to add 1 now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-doc@vger.kernel.org
Cc: Nicolai Stange <nstange@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qian Cai <cai@lca.pw>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.331772825@linutronix.de
---
 Documentation/x86/kernel-stacks      |  8 ++++----
 arch/x86/entry/entry_64.S            |  4 ++--
 arch/x86/include/asm/page_64_types.h | 13 ++++++++-----
 arch/x86/kernel/cpu/common.c         |  4 ++--
 arch/x86/kernel/dumpstack_64.c       | 14 +++++++-------
 arch/x86/kernel/idt.c                | 15 +++++++++------
 arch/x86/kernel/irq_64.c             |  2 +-
 arch/x86/mm/fault.c                  |  2 +-
 8 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/Documentation/x86/kernel-stacks b/Documentation/x86/kernel-stacks
index 9a0aa4d3a866..1b04596caea9 100644
--- a/Documentation/x86/kernel-stacks
+++ b/Documentation/x86/kernel-stacks
@@ -59,7 +59,7 @@ If that assumption is ever broken then the stacks will become corrupt.
 
 The currently assigned IST stacks are :-
 
-* DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
+* ESTACK_DF.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for interrupt 8 - Double Fault Exception (#DF).
 
@@ -68,7 +68,7 @@ The currently assigned IST stacks are :-
   Using a separate stack allows the kernel to recover from it well enough
   in many cases to still output an oops.
 
-* NMI_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
+* ESTACK_NMI.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for non-maskable interrupts (NMI).
 
@@ -76,7 +76,7 @@ The currently assigned IST stacks are :-
   middle of switching stacks.  Using IST for NMI events avoids making
   assumptions about the previous state of the kernel stack.
 
-* DEBUG_STACK.  DEBUG_STKSZ
+* ESTACK_DB.  DEBUG_STKSZ
 
   Used for hardware debug interrupts (interrupt 1) and for software
   debug interrupts (INT3).
@@ -86,7 +86,7 @@ The currently assigned IST stacks are :-
   avoids making assumptions about the previous state of the kernel
   stack.
 
-* MCE_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
+* ESTACK_MCE.  EXCEPTION_STKSZ (PAGE_SIZE).
 
   Used for interrupt 18 - Machine Check Exception (#MC).
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..fd0a50452cb3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -841,7 +841,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 /*
  * Exception entry points.
  */
-#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
+#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
 /**
  * idtentry - Generate an IDT entry stub
@@ -1129,7 +1129,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
-idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
+idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=ESTACK_DB
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index bcd8c0518604..6ab2c54c1bf9 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -24,11 +24,14 @@
 #define IRQ_STACK_ORDER (2 + KASAN_STACK_ORDER)
 #define IRQ_STACK_SIZE (PAGE_SIZE << IRQ_STACK_ORDER)
 
-#define DOUBLEFAULT_STACK 1
-#define NMI_STACK 2
-#define DEBUG_STACK 3
-#define MCE_STACK 4
-#define N_EXCEPTION_STACKS 4  /* hw limit: 7 */
+/*
+ * The index for the tss.ist[] array. The hardware limit is 7 entries.
+ */
+#define	ESTACK_DF		0
+#define	ESTACK_NMI		1
+#define	ESTACK_DB		2
+#define	ESTACK_MCE		3
+#define	N_EXCEPTION_STACKS	4
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..0e4cb718fc4a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -516,7 +516,7 @@ DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
  */
 static const unsigned int exception_stack_sizes[N_EXCEPTION_STACKS] = {
 	  [0 ... N_EXCEPTION_STACKS - 1]	= EXCEPTION_STKSZ,
-	  [DEBUG_STACK - 1]			= DEBUG_STKSZ
+	  [ESTACK_DB]				= DEBUG_STKSZ
 };
 #endif
 
@@ -1760,7 +1760,7 @@ void cpu_init(void)
 			estacks += exception_stack_sizes[v];
 			oist->ist[v] = t->x86_tss.ist[v] =
 					(unsigned long)estacks;
-			if (v == DEBUG_STACK-1)
+			if (v == ESTACK_DB)
 				per_cpu(debug_stack_addr, cpu) = (unsigned long)estacks;
 		}
 	}
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 90f0fa88cbb3..455b47ef9250 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -18,16 +18,16 @@
 
 #include <asm/stacktrace.h>
 
-static char *exception_stack_names[N_EXCEPTION_STACKS] = {
-		[ DOUBLEFAULT_STACK-1	]	= "#DF",
-		[ NMI_STACK-1		]	= "NMI",
-		[ DEBUG_STACK-1		]	= "#DB",
-		[ MCE_STACK-1		]	= "#MC",
+static const char *exception_stack_names[N_EXCEPTION_STACKS] = {
+		[ ESTACK_DF	]	= "#DF",
+		[ ESTACK_NMI	]	= "NMI",
+		[ ESTACK_DB	]	= "#DB",
+		[ ESTACK_MCE	]	= "#MC",
 };
 
-static unsigned long exception_stack_sizes[N_EXCEPTION_STACKS] = {
+static const unsigned long exception_stack_sizes[N_EXCEPTION_STACKS] = {
 	[0 ... N_EXCEPTION_STACKS - 1]		= EXCEPTION_STKSZ,
-	[DEBUG_STACK - 1]			= DEBUG_STKSZ
+	[ESTACK_DB]				= DEBUG_STKSZ
 };
 
 const char *stack_type_name(enum stack_type type)
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 2877606e97de..2188f734ec61 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -41,9 +41,12 @@ struct idt_data {
 #define SYSG(_vector, _addr)				\
 	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL3, __KERNEL_CS)
 
-/* Interrupt gate with interrupt stack */
+/*
+ * Interrupt gate with interrupt stack. The _ist index is the index in
+ * the tss.ist[] array, but for the descriptor it needs to start at 1.
+ */
 #define ISTG(_vector, _addr, _ist)			\
-	G(_vector, _addr, _ist, GATE_INTERRUPT, DPL0, __KERNEL_CS)
+	G(_vector, _addr, _ist + 1, GATE_INTERRUPT, DPL0, __KERNEL_CS)
 
 /* Task gate */
 #define TSKG(_vector, _gdt)				\
@@ -180,11 +183,11 @@ gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
  * cpu_init() when the TSS has been initialized.
  */
 static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	debug,		DEBUG_STACK),
-	ISTG(X86_TRAP_NMI,	nmi,		NMI_STACK),
-	ISTG(X86_TRAP_DF,	double_fault,	DOUBLEFAULT_STACK),
+	ISTG(X86_TRAP_DB,	debug,		ESTACK_DB),
+	ISTG(X86_TRAP_NMI,	nmi,		ESTACK_NMI),
+	ISTG(X86_TRAP_DF,	double_fault,	ESTACK_DF),
 #ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	&machine_check,	MCE_STACK),
+	ISTG(X86_TRAP_MC,	&machine_check,	ESTACK_MCE),
 #endif
 };
 
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index cf200466d5c8..182e8b245e06 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -61,7 +61,7 @@ static inline void stack_overflow_check(struct pt_regs *regs)
 		return;
 
 	oist = this_cpu_ptr(&orig_ist);
-	estack_top = (u64)oist->ist[DEBUG_STACK];
+	estack_top = (u64)oist->ist[ESTACK_DB];
 	estack_bottom = estack_top - DEBUG_STKSZ + STACK_MARGIN;
 	if (regs->sp >= estack_bottom && regs->sp <= estack_top)
 		return;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 667f1da36208..0524e1d74f24 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -793,7 +793,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_vmalloc_addr((void *)address) &&
 	    (((unsigned long)tsk->stack - 1 - address < PAGE_SIZE) ||
 	     address - ((unsigned long)tsk->stack + THREAD_SIZE) < PAGE_SIZE)) {
-		unsigned long stack = this_cpu_read(orig_ist.ist[DOUBLEFAULT_STACK]) - sizeof(void *);
+		unsigned long stack = this_cpu_read(orig_ist.ist[ESTACK_DF]) - sizeof(void *);
 		/*
 		 * We're likely to be running with very little stack space
 		 * left.  It's plausible that we'd hit this condition but
