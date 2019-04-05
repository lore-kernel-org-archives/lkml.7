Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A4C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D913B21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfDEPLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbfDEPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:19 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQUv-0005tW-1F; Fri, 05 Apr 2019 17:11:17 +0200
Message-Id: <20190405150929.938480649@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:15 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V2 17/29] x86/exceptions: Disconnect IST index and stack order
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entry order of the TSS.IST array and the order of the stack
storage/mapping are not required to be the same.

With the upcoming split of the debug stack this is going to fall apart as
the number of TSS.IST array entries stays the same while the actual stacks
are increasing.

Make them separate so that code like dumpstack can just utilize the mapping
order. The IST index is solely required for the actual TSS.IST array
initialization.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S             |    2 +-
 arch/x86/include/asm/cpu_entry_area.h |   11 +++++++++++
 arch/x86/include/asm/page_64_types.h  |    9 ++++-----
 arch/x86/include/asm/stacktrace.h     |    2 ++
 arch/x86/kernel/cpu/common.c          |   10 +++++-----
 arch/x86/kernel/idt.c                 |    8 ++++----
 6 files changed, 27 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1129,7 +1129,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 	hv_stimer0_callback_vector hv_stimer0_vector_handler
 #endif /* CONFIG_HYPERV */
 
-idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=ISTACK_DB
+idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -34,6 +34,17 @@ struct cea_exception_stacks {
 	ESTACKS_MEMBERS(0)
 };
 
+/*
+ * The exception stack ordering in [cea_]exception_stacks
+ */
+enum exception_stack_ordering {
+	ISTACK_DF,
+	ISTACK_NMI,
+	ISTACK_DB,
+	ISTACK_MCE,
+	N_EXCEPTION_STACKS
+};
+
 #define CEA_ESTACK_TOP(ceastp, st)			\
 	((unsigned long)&(ceastp)->st## _stack_guard)
 
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -28,11 +28,10 @@
 /*
  * The index for the tss.ist[] array. The hardware limit is 7 entries.
  */
-#define	ISTACK_DF		0
-#define	ISTACK_NMI		1
-#define	ISTACK_DB		2
-#define	ISTACK_MCE		3
-#define	N_EXCEPTION_STACKS	4
+#define	IST_INDEX_DF		0
+#define	IST_INDEX_NMI		1
+#define	IST_INDEX_DB		2
+#define	IST_INDEX_MCE		3
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -9,6 +9,8 @@
 
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
+
+#include <asm/cpu_entry_area.h>
 #include <asm/switch_to.h>
 
 enum stack_type {
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1731,11 +1731,11 @@ void cpu_init(void)
 	 * set up and load the per-CPU TSS
 	 */
 	if (!t->x86_tss.ist[0]) {
-		t->x86_tss.ist[ISTACK_DF] = __this_cpu_ist_top_va(DF);
-		t->x86_tss.ist[ISTACK_NMI] = __this_cpu_ist_top_va(NMI);
-		t->x86_tss.ist[ISTACK_DB] = __this_cpu_ist_top_va(DB);
-		t->x86_tss.ist[ISTACK_MCE] = __this_cpu_ist_top_va(MCE);
-		per_cpu(debug_stack_addr, cpu) = t->x86_tss.ist[ISTACK_DB];
+		t->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
+		t->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
+		t->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
+		t->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+		per_cpu(debug_stack_addr, cpu) = t->x86_tss.ist[IST_INDEX_DB];
 	}
 
 	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -183,11 +183,11 @@ gate_desc debug_idt_table[IDT_ENTRIES] _
  * cpu_init() when the TSS has been initialized.
  */
 static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	debug,		ISTACK_DB),
-	ISTG(X86_TRAP_NMI,	nmi,		ISTACK_NMI),
-	ISTG(X86_TRAP_DF,	double_fault,	ISTACK_DF),
+	ISTG(X86_TRAP_DB,	debug,		IST_INDEX_DB),
+	ISTG(X86_TRAP_NMI,	nmi,		IST_INDEX_NMI),
+	ISTG(X86_TRAP_DF,	double_fault,	IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	&machine_check,	ISTACK_MCE),
+	ISTG(X86_TRAP_MC,	&machine_check,	IST_INDEX_MCE),
 #endif
 };
 


