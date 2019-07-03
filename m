Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A97C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13CE218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Be40DoFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfGCIUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:20:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfGCIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:20:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x638JcrY3200976
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 01:19:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x638JcrY3200976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562141979;
        bh=B6PIY7KBbT2HB3Y8nVFBHvV5wtcYb87XXi6rwKLB9gw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Be40DoFbkPnPbjRulCtM6aeyFgfdE5dOj7fPX92ZPNq/48WOQkl1imSwxfgwAIuRe
         GE+rUXblDkQRXQJ8fLlSpMkvRWlYa/vwX5ZdRJmyMsD0teBoilkcCXSnlnAsj8MAeZ
         D1TmxmXuhQE+5gCqV3wDfX2rR70GWz2HMKzN4t7+VOPMMxv9iCdD6pB/IG3jKqRQXN
         87rwhIiQZaxP3X1bjCLHtfnUS3+KsWp09kSIjsNouom/vsM5HPkn81YEwMvVQpihjN
         9R1An5SDgckNPN+8wD/LKtuvdZRT/isCC5pkv4MUJk3VwMJ1jsIeKDJr5vZSJR9lfD
         UswfVeZaeGC9Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x638Jath3200970;
        Wed, 3 Jul 2019 01:19:36 -0700
Date:   Wed, 3 Jul 2019 01:19:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f8a8fe61fec8006575699559ead88b0b833d5cad@git.kernel.org>
Cc:     tglx@linutronix.de, jbeulich@suse.com, mingo@kernel.org,
        jan.kiszka@siemens.com, marc.zyngier@arm.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          jan.kiszka@siemens.com, marc.zyngier@arm.com, mingo@kernel.org,
          jbeulich@suse.com, tglx@linutronix.de
In-Reply-To: <20190628111440.550568228@linutronix.de>
References: <20190628111440.550568228@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/irq: Seperate unused system vectors from
 spurious entry again
Git-Commit-ID: f8a8fe61fec8006575699559ead88b0b833d5cad
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

Commit-ID:  f8a8fe61fec8006575699559ead88b0b833d5cad
Gitweb:     https://git.kernel.org/tip/f8a8fe61fec8006575699559ead88b0b833d5cad
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 28 Jun 2019 13:11:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 10:12:31 +0200

x86/irq: Seperate unused system vectors from spurious entry again

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
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jan Beulich <jbeulich@suse.com>
Link: https://lkml.kernel.org/r/20190628111440.550568228@linutronix.de

---
 arch/x86/entry/entry_32.S     | 24 ++++++++++++++++++++++++
 arch/x86/entry/entry_64.S     | 30 ++++++++++++++++++++++++++----
 arch/x86/include/asm/hw_irq.h |  2 ++
 arch/x86/kernel/apic/apic.c   | 33 ++++++++++++++++++++++-----------
 arch/x86/kernel/idt.c         |  3 ++-
 5 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7b23431be5cb..44c6e6f54bf7 100644
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 20e45d9b4e15..6d835991bb23 100644
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
@@ -571,10 +583,20 @@ _ASM_NOKPROBE(interrupt_entry)
 
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
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 626e1ac6516e..cbd97e22d2f3 100644
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
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 29fd50840b55..a5241b209ea5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2068,21 +2068,32 @@ __visible void __irq_entry smp_spurious_interrupt(struct pt_regs *regs)
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
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 6d8917875f44..cc4444cb3898 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -320,7 +320,8 @@ void __init idt_setup_apic_and_irq_gates(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
 		set_bit(i, system_vectors);
-		set_intr_gate(i, spurious_interrupt);
+		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
+		set_intr_gate(i, entry);
 	}
 #endif
 }
