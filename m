Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6FC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3E622BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BLtebhQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbfGYOXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:23:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfGYOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:23:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEMwoJ1037619
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:22:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEMwoJ1037619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064579;
        bh=2GGKD9DmK3esCnQfagGCoJUXSNY32b8u/gtgZucQkgQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BLtebhQIBX4Pk4RqKkN+FajoXvw7xFcVzZpebgt2SiBX4ssfHuj6n39EBhbZCzsNt
         uKdLGJwQrxhN//G0+m1WI85kmzxK1fzxyrodkxI9sm9kPLkQh3VAlqGo2hoM4HsCVR
         6tL7lTHL1QX8jp0yO8nsZQSHgOnZ5FRz0usEvItUnQHqBLAeBAGSfEyJxy/8Zks3/r
         hpzylmE2aSM1uwHL25FirM3n6g9+wZgrF2/XfDuoNWwG/wSdlrF5jLIjnNKphEel/q
         BempxkqemvpdmlDr/rImvGPi5veiqDgNkJKKqxxPjyXaSDzKaAthiizpdsnmo4RCc8
         Mt27do4awOjDQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEMwvu1037616;
        Thu, 25 Jul 2019 07:22:58 -0700
Date:   Thu, 25 Jul 2019 07:22:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-cc8bf191378c1da8ad2b99cf470ee70193ace84e@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190722105219.158847694@linutronix.de>
References: <20190722105219.158847694@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Make apic_pending_intr_clear() more robust
Git-Commit-ID: cc8bf191378c1da8ad2b99cf470ee70193ace84e
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

Commit-ID:  cc8bf191378c1da8ad2b99cf470ee70193ace84e
Gitweb:     https://git.kernel.org/tip/cc8bf191378c1da8ad2b99cf470ee70193ace84e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:09 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:56 +0200

x86/apic: Make apic_pending_intr_clear() more robust

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
     impossible and the chance that more than a few bits are set is close
     to zero.

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.158847694@linutronix.de

---
 arch/x86/kernel/apic/apic.c | 107 ++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 621992de49ee..fe30d1854a4e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1453,54 +1453,72 @@ static void lapic_setup_esr(void)
 			oldvalue, value);
 }
 
-static void apic_pending_intr_clear(void)
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
 {
-	long long max_loops = cpu_khz ? cpu_khz : 1000000;
-	unsigned long long tsc = 0, ntsc;
-	unsigned int queued;
-	unsigned long value;
-	int i, j, acked = 0;
+	int i, bit;
+
+	/* Read the IRRs */
+	for (i = 0; i < APIC_IR_REGS; i++)
+		irr->regs[i] = apic_read(APIC_IRR + i * 0x10);
+
+	/* Read the ISRs */
+	for (i = 0; i < APIC_IR_REGS; i++)
+		isr->regs[i] = apic_read(APIC_ISR + i * 0x10);
 
-	if (boot_cpu_has(X86_FEATURE_TSC))
-		tsc = rdtsc();
 	/*
-	 * After a crash, we no longer service the interrupts and a pending
-	 * interrupt from previous kernel might still have ISR bit set.
-	 *
-	 * Most probably by now CPU has serviced that pending interrupt and
-	 * it might not have done the ack_APIC_irq() because it thought,
-	 * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
-	 * does not clear the ISR bit and cpu thinks it has already serivced
-	 * the interrupt. Hence a vector might get locked. It was noticed
-	 * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
+	 * If the ISR map is not empty. ACK the APIC and run another round
+	 * to verify whether a pending IRR has been unblocked and turned
+	 * into a ISR.
 	 */
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
+static void apic_pending_intr_clear(void)
+{
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
@@ -1576,6 +1594,7 @@ static void setup_local_APIC(void)
 	value |= 0x10;
 	apic_write(APIC_TASKPRI, value);
 
+	/* Clear eventually stale ISR/IRR bits */
 	apic_pending_intr_clear();
 
 	/*
