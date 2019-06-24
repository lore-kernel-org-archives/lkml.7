Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36173C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075B02133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfFXNrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:47:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfFXNrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:47:07 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfPIq-0003An-PU; Mon, 24 Jun 2019 15:46:36 +0200
Date:   Mon, 24 Jun 2019 15:46:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Beulich <jbeulich@suse.com>
Subject: Re: x86: Spurious vectors not handled robustly
In-Reply-To: <alpine.DEB.2.21.1906241236390.32342@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906241541290.32342@nanos.tec.linutronix.de>
References: <e525108f-3749-4e1d-1ac2-0d0a2655f15f@siemens.com> <alpine.DEB.2.21.1906241204430.32342@nanos.tec.linutronix.de> <1565f016-4e3b-fa89-62e5-fc77594ee5aa@siemens.com> <alpine.DEB.2.21.1906241236390.32342@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Thomas Gleixner wrote:
> On Mon, 24 Jun 2019, Jan Kiszka wrote:
> > On 24.06.19 12:09, Thomas Gleixner wrote:
> > > If it is a vectored one it _IS_ acked.
> > > 
> > >          inc_irq_stat(irq_spurious_count);
> > > 
> > >   	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
> > >          pr_info("spurious APIC interrupt through vector %02x on CPU#%d, "
> > >                  "should never happen.\n", vector, smp_processor_id());
> > > 
> > > and the vector through which that comes is printed correctly, unless
> > > regs->orig_ax is hosed.
> > 
> > ...which is exactly the case: Since that commit, all unused vectors share the
> > same entry point, spurious_interrupt, see idt_setup_apic_and_irq_gates(). And
> > that entry point sets orig_ax to ~0xff.
> 
> Bah. Of course I did not look at that ...
> 
> /me goes back to stare at the code.

The patch below should fix it. It's quick tested on 64bit (without inducing
a spurious vector) and compile tested on 32bit.

Can you please give it a try with your failure case?

Thanks,

	tglx

8<----------------
Subject: x86/irq: Seperate unused system vectors from spurious entry again
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 24 Jun 2019 13:34:06 +0200

Quite some time ago the interrupt entry stubs for unused vectors in the
system vector range got removed and directly mapped to the spurious
interrupt vector entry point.

Sounds reasonable, but it's subtly broken. The spurious interrupt vector
entry point pushes vector number 0xFF on the stack which makes the whole
logic in smp_spurious_interrupt() pointless.

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
the IDT management would be way larger and convoluted. The array is
straight forward and simple.

Do not route the spurious entries through common_interrupt and do_IRQ() as
the original code did. Route it to smp_spurious_interrupt() which evaluates
the vector number and acts accordingly now that the real vector numbers are
handed in.

Fixes: 2414e021ac8d ("x86: Avoid building unused IRQ entry stubs")
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/entry/entry_32.S     |   24 ++++++++++++++++++++++++
 arch/x86/entry/entry_64.S     |   30 ++++++++++++++++++++++++++----
 arch/x86/include/asm/hw_irq.h |    2 ++
 arch/x86/kernel/idt.c         |    3 ++-
 4 files changed, 54 insertions(+), 5 deletions(-)

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
+	jmp	common_spurious_vector
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
 #define VECTOR_RETRIGGERED	((void *)~0UL)
 
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
