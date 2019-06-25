Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0989C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EE120656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfFYLYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:24:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41871 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbfFYLYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:24:43 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfjYy-0004rW-2D; Tue, 25 Jun 2019 13:24:36 +0200
Message-Id: <20190625112405.945005272@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 13:13:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [patch 5/5] x86/irq: Seperate unused system vectors from spurious
 entry again
References: <20190625111353.863718167@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite some time ago the interrupt entry stubs for unused vectors in the
system vector range got removed and directly mapped to the spurious
interrupt vector entry point.

Sounds reasonable, but it's subtly broken. The spurious interrupt vector
entry point pushes vector number 0xFF on the stack which makes the whole
logic in __smp_spurious_interrupt() pointless.

As a consequence any spurious interrupt which comes from a vector != 0xFF
is treated as a real spurious interrupt (vector 0xFF) and not
acknowledged. That subsequently stalls all interrupt vectors of equal and
lower priority, which brings the system to a grinding halt.

This can happen because even on 64-bit the system vector space is not
guaranteed to be fully populated. A full compile time handling of the
unused vectors is not possible because quite some of them are conditonally
populated at runtime.

Bring the entry stubs back, which wastes 160 bytes if all stubs are unused,
but gains the proper handling back. There is no point to selectively spare
some of the stubs which are known at compile time as the required code in
the IDT management would be way larger and convoluted.

Do not route the spurious entries through common_interrupt and do_IRQ() as
the original code did. Route it to smp_spurious_interrupt() which evaluates
the vector number and acts accordingly now that the real vector numbers are
handed in.

Fixup the pr_warn so the actual spurious vector (0xff) is clearly
distiguished from the other vectors and also note for the vectored case
whether it was pending in the ISR or not.

 "Spurious APIC interrupt (vector 0xFF) on CPU#0, should never happen."
 "Spurious interrupt vector 0xed on CPU#1. Acked."
 "Spurious interrupt vector 0xee on CPU#1. Not pending!."

Fixes: 2414e021ac8d ("x86: Avoid building unused IRQ entry stubs")
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/entry/entry_32.S     |   24 ++++++++++++++++++++++++
 arch/x86/entry/entry_64.S     |   30 ++++++++++++++++++++++++++----
 arch/x86/include/asm/hw_irq.h |    2 ++
 arch/x86/kernel/apic/apic.c   |   33 ++++++++++++++++++++++-----------
 arch/x86/kernel/idt.c         |    3 ++-
 5 files changed, 76 insertions(+), 16 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1104,6 +1104,30 @@ ENTRY(irq_entries_start)
     .endr
 END(irq_entries_start)
 
+#ifdef CONFIG_X86_LOCAL_APIC
+	.align 8
+ENTRY(spurious_entries_start)
+    vector=FIRST_SYSTEM_VECTOR
+    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
+    vector=vector+1
+	jmp	common_spurious
+	.align	8
+    .endr
+END(spurious_entries_start)
+
+common_spurious:
+	ASM_CLAC
+	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
+	SAVE_ALL switch_stacks=1
+	ENCODE_FRAME_POINTER
+	TRACE_IRQS_OFF
+	movl	%esp, %eax
+	call	smp_spurious_interrupt
+	jmp	ret_from_intr
+ENDPROC(common_interrupt)
+#endif
+
 /*
  * the CPU automatically disables interrupts when executing an IRQ vector,
  * so IRQ-flags tracing has to follow that:
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -375,6 +375,18 @@ ENTRY(irq_entries_start)
     .endr
 END(irq_entries_start)
 
+	.align 8
+ENTRY(spurious_entries_start)
+    vector=FIRST_SYSTEM_VECTOR
+    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+	UNWIND_HINT_IRET_REGS
+	pushq	$(~vector+0x80)			/* Note: always in signed byte range */
+	jmp	common_spurious
+	.align	8
+	vector=vector+1
+    .endr
+END(spurious_entries_start)
+
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
 	pushq %rax
@@ -571,10 +583,20 @@ END(interrupt_entry)
 
 /* Interrupt entry/exit. */
 
-	/*
-	 * The interrupt stubs push (~vector+0x80) onto the stack and
-	 * then jump to common_interrupt.
-	 */
+/*
+ * The interrupt stubs push (~vector+0x80) onto the stack and
+ * then jump to common_spurious/interrupt.
+ */
+common_spurious:
+	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
+	call	interrupt_entry
+	UNWIND_HINT_REGS indirect=1
+	call	smp_spurious_interrupt		/* rdi points to pt_regs */
+	jmp	ret_from_intr
+END(common_spurious)
+_ASM_NOKPROBE(common_spurious)
+
+/* common_interrupt is a hotpath. Align it */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
 common_interrupt:
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -150,6 +150,8 @@ extern char irq_entries_start[];
 #define trace_irq_entries_start irq_entries_start
 #endif
 
+extern char spurious_entries_start[];
+
 #define VECTOR_UNUSED		NULL
 #define VECTOR_SHUTDOWN		((void *)~0UL)
 #define VECTOR_RETRIGGERED	((void *)~1UL)
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2040,21 +2040,32 @@ void __init register_lapic_address(unsig
 	entering_irq();
 	trace_spurious_apic_entry(vector);
 
+	inc_irq_stat(irq_spurious_count);
+
+	/*
+	 * If this is a spurious interrupt then do not acknowledge
+	 */
+	if (vector == SPURIOUS_APIC_VECTOR) {
+		/* See SDM vol 3 */
+		pr_info("Spurious APIC interrupt (vector 0xFF) on CPU#%d, should never happen.\n",
+			smp_processor_id());
+		goto out;
+	}
+
 	/*
-	 * Check if this really is a spurious interrupt and ACK it
-	 * if it is a vectored one.  Just in case...
-	 * Spurious interrupts should not be ACKed.
+	 * If it is a vectored one, verify it's set in the ISR. If set,
+	 * acknowledge it.
 	 */
 	v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
-	if (v & (1 << (vector & 0x1f)))
+	if (v & (1 << (vector & 0x1f))) {
+		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
+			vector, smp_processor_id());
 		ack_APIC_irq();
-
-	inc_irq_stat(irq_spurious_count);
-
-	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
-	pr_info("spurious APIC interrupt through vector %02x on CPU#%d, "
-		"should never happen.\n", vector, smp_processor_id());
-
+	} else {
+		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
+			vector, smp_processor_id());
+	}
+out:
 	trace_spurious_apic_exit(vector);
 	exiting_irq();
 }
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -319,7 +319,8 @@ void __init idt_setup_apic_and_irq_gates
 #ifdef CONFIG_X86_LOCAL_APIC
 	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
 		set_bit(i, system_vectors);
-		set_intr_gate(i, spurious_interrupt);
+		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
+		set_intr_gate(i, entry);
 	}
 #endif
 }


