Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C2C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FFB218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfGDQeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfGDQeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gI-0005es-CL; Thu, 04 Jul 2019 18:33:58 +0200
Message-Id: <20190704155608.636478018@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:51:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 04/25] x86/apic: Make apic_pending_intr_clear() more robust
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In course of developing shorthand based IPI support issues with the
function which tries to clear eventually pending ISR bits in the local APIC
were observed.

  1) O-day testing triggered the WARN_ON() in apic_pending_intr_clear().

     This warning is emitted when the function fails to clear pending ISR
     bits or observes pending IRR bits which are not delivered to the CPU
     after the stale ISR bit(s) are ACK'ed.

     Unfortunately the function only emits a WARN_ON() and fails to dump
     the IRR/ISR content. That's useless for debugging.

     Feng added spot on debug printk's which revealed that the stale IRR
     bit belonged to the APIC timer interrupt vector, but adding ad hoc
     debug code does not help with sporadic failures in the field.

     Rework the loop so the full IRR/ISR contents are saved and on failure
     dumped.

  2) The loop termination logic is interesting at best.

     If the machine has no TSC or cpu_khz is not known yet it tries 1
     million times to ack stale IRR/ISR bits. What?

     With TSC it uses the TSC to calculate the loop termination. It takes a
     timestamp at entry and terminates the loop when:

     	  (rdtsc() - start_timestamp) >= (cpu_hkz << 10)

     That's roughly one second.

     Both methods are problematic. The APIC has 256 vectors, which means
     that in theory max. 256 IRR/ISR bits can be set. In practice this is
     impossible as the first 32 vectors are reserved and not affected and
     the chance that more than a few bits are set is close to zero.

     With the pure loop based approach the 1 million retries are complete
     overkill.

     With TSC this can terminate too early in a guest which is running on a
     heavily loaded host even with only a couple of IRR/ISR bits set. The
     reason is that after acknowledging the highest priority ISR bit,
     pending IRRs must get serviced first before the next round of
     acknowledge can take place as the APIC (real and virtualized) does not
     honour EOI without a preceeding interrupt on the CPU. And every APIC
     read/write takes a VMEXIT if the APIC is virtualized. While trying to
     reproduce the issue 0-day reported it was observed that the guest was
     scheduled out long enough under heavy load that it terminated after 8
     iterations.

     Make the loop terminate after 512 iterations. That's plenty enough
     in any case and does not take endless time to complete.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |  111 +++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 46 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1424,54 +1424,72 @@ static void lapic_setup_esr(void)
 			oldvalue, value);
 }
 
+#define APIC_IR_REGS		APIC_ISR_NR
+#define APIC_IR_BITS		(APIC_IR_REGS * 32)
+#define APIC_IR_MAPSIZE		(APIC_IR_BITS / BITS_PER_LONG)
+
+union apic_ir {
+	unsigned long	map[APIC_IR_MAPSIZE];
+	u32		regs[APIC_IR_REGS];
+};
+
+static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
+{
+	int i, bit;
+
+	/* Read the IRRs */
+	for (i = 0; i < APIC_IR_REGS; i++)
+		irr->regs[i] = apic_read(APIC_IRR + i * 0x10);
+
+	/* Read the ISRs */
+	for (i = 0; i < APIC_IR_REGS; i++)
+		isr->regs[i] = apic_read(APIC_ISR + i * 0x10);
+
+	/*
+	 * If the ISR map is not empty. ACK the APIC and run another round
+	 * to verify whether a pending IRR has been unblocked and turned
+	 * into a ISR.
+	 */
+	if (!bitmap_empty(isr->map, APIC_IR_BITS)) {
+		/*
+		 * There can be multiple ISR bits set when a high priority
+		 * interrupt preempted a lower priority one. Issue an ACK
+		 * per set bit.
+		 */
+		for_each_set_bit(bit, isr->map, APIC_IR_BITS)
+			ack_APIC_irq();
+		return true;
+	}
+
+	return !bitmap_empty(irr->map, APIC_IR_BITS);
+}
+
+/*
+ * After a crash, we no longer service the interrupts and a pending
+ * interrupt from previous kernel might still have ISR bit set.
+ *
+ * Most probably by now the CPU has serviced that pending interrupt and it
+ * might not have done the ack_APIC_irq() because it thought, interrupt
+ * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
+ * the ISR bit and cpu thinks it has already serivced the interrupt. Hence
+ * a vector might get locked. It was noticed for timer irq (vector
+ * 0x31). Issue an extra EOI to clear ISR.
+ *
+ * If there are pending IRR bits they turn into ISR bits after a higher
+ * priority ISR bit has been acked.
+ */
 static void apic_pending_intr_clear(void)
 {
-	long long max_loops = cpu_khz ? cpu_khz : 1000000;
-	unsigned long long tsc = 0, ntsc;
-	unsigned int queued;
-	unsigned long value;
-	int i, j, acked = 0;
-
-	if (boot_cpu_has(X86_FEATURE_TSC))
-		tsc = rdtsc();
-	/*
-	 * After a crash, we no longer service the interrupts and a pending
-	 * interrupt from previous kernel might still have ISR bit set.
-	 *
-	 * Most probably by now CPU has serviced that pending interrupt and
-	 * it might not have done the ack_APIC_irq() because it thought,
-	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
-	 * does not clear the ISR bit and cpu thinks it has already serivced
-	 * the interrupt. Hence a vector might get locked. It was noticed
-	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
-	 */
-	do {
-		queued = 0;
-		for (i = APIC_ISR_NR - 1; i >= 0; i--)
-			queued |= apic_read(APIC_IRR + i*0x10);
-
-		for (i = APIC_ISR_NR - 1; i >= 0; i--) {
-			value = apic_read(APIC_ISR + i*0x10);
-			for_each_set_bit(j, &value, 32) {
-				ack_APIC_irq();
-				acked++;
-			}
-		}
-		if (acked > 256) {
-			pr_err("LAPIC pending interrupts after %d EOI\n", acked);
-			break;
-		}
-		if (queued) {
-			if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
-				ntsc = rdtsc();
-				max_loops = (long long)cpu_khz << 10;
-				max_loops -= ntsc - tsc;
-			} else {
-				max_loops--;
-			}
-		}
-	} while (queued && max_loops > 0);
-	WARN_ON(max_loops <= 0);
+	union apic_ir irr, isr;
+	unsigned int i;
+
+	/* 512 loops are way oversized and give the APIC a chance to obey. */
+	for (i = 0; i < 512; i++) {
+		if (!apic_check_and_ack(&irr, &isr))
+			return;
+	}
+	/* Dump the IRR/ISR content if that failed */
+	pr_warn("APIC: Stale IRR: %256pb ISR: %256pb\n", irr.map, isr.map);
 }
 
 /**
@@ -1544,6 +1562,7 @@ static void setup_local_APIC(void)
 	value &= ~APIC_TPRI_MASK;
 	apic_write(APIC_TASKPRI, value);
 
+	/* Clear eventually stale ISR/IRR bits */
 	apic_pending_intr_clear();
 
 	/*


