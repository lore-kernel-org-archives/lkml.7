Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87EEC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FE121744
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfFWN15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33482 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfFWN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X3-0001kj-KY; Sun, 23 Jun 2019 15:27:45 +0200
Message-Id: <20190623132435.545653922@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:56 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [patch 16/29] x86/hpet: Clean up comments
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -266,8 +266,8 @@ static void hpet_legacy_clockevent_regis
 	hpet_enable_legacy_int();
 
 	/*
-	 * Start HPET with the boot cpu mask and make it
-	 * global after the IO_APIC has been initialized.
+	 * Start HPET with the boot CPU's cpumask and make it global after
+	 * the IO_APIC has been initialized.
 	 */
 	hpet_clockevent.cpumask = cpumask_of(boot_cpu_data.cpu_index);
 	clockevents_config_and_register(&hpet_clockevent, hpet_freq,
@@ -688,10 +688,10 @@ static inline void hpet_reserve_msi_time
 /*
  * Reading the HPET counter is a very slow operation. If a large number of
  * CPUs are trying to access the HPET counter simultaneously, it can cause
- * massive delay and slow down system performance dramatically. This may
+ * massive delays and slow down system performance dramatically. This may
  * happen when HPET is the default clock source instead of TSC. For a
  * really large system with hundreds of CPUs, the slowdown may be so
- * severe that it may actually crash the system because of a NMI watchdog
+ * severe, that it can actually crash the system because of a NMI watchdog
  * soft lockup, for example.
  *
  * If multiple CPUs are trying to access the HPET counter at the same time,
@@ -700,8 +700,7 @@ static inline void hpet_reserve_msi_time
  *
  * This special feature is only enabled on x86-64 systems. It is unlikely
  * that 32-bit x86 systems will have enough CPUs to require this feature
- * with its associated locking overhead. And we also need 64-bit atomic
- * read.
+ * with its associated locking overhead. We also need 64-bit atomic read.
  *
  * The lock and the HPET value are stored together and can be read in a
  * single atomic 64-bit read. It is explicitly assumed that arch_spinlock_t
@@ -1020,19 +1019,25 @@ void hpet_disable(void)
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
-/* HPET in LegacyReplacement Mode eats up RTC interrupt line. When, HPET
+/*
+ * HPET in LegacyReplacement mode eats up the RTC interrupt line. When HPET
  * is enabled, we support RTC interrupt functionality in software.
+ *
  * RTC has 3 kinds of interrupts:
- * 1) Update Interrupt - generate an interrupt, every sec, when RTC clock
- *    is updated
- * 2) Alarm Interrupt - generate an interrupt at a specific time of day
- * 3) Periodic Interrupt - generate periodic interrupt, with frequencies
- *    2Hz-8192Hz (2Hz-64Hz for non-root user) (all freqs in powers of 2)
- * (1) and (2) above are implemented using polling at a frequency of
- * 64 Hz. The exact frequency is a tradeoff between accuracy and interrupt
- * overhead. (DEFAULT_RTC_INT_FREQ)
- * For (3), we use interrupts at 64Hz or user specified periodic
- * frequency, whichever is higher.
+ *
+ *  1) Update Interrupt - generate an interrupt, every second, when the
+ *     RTC clock is updated
+ *  2) Alarm Interrupt - generate an interrupt at a specific time of day
+ *  3) Periodic Interrupt - generate periodic interrupt, with frequencies
+ *     2Hz-8192Hz (2Hz-64Hz for non-root user) (all frequencies in powers of 2)
+ *
+ * (1) and (2) above are implemented using polling at a frequency of 64 Hz:
+ * DEFAULT_RTC_INT_FREQ.
+ *
+ * The exact frequency is a tradeoff between accuracy and interrupt overhead.
+ *
+ * For (3), we use interrupts at 64 Hz, or the user specified periodic frequency,
+ * if it's higher.
  */
 #include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
@@ -1053,7 +1058,7 @@ static unsigned long hpet_pie_limit;
 static rtc_irq_handler irq_handler;
 
 /*
- * Check that the HPET counter c1 is ahead of the c2
+ * Check that the HPET counter c1 is ahead of c2
  */
 static inline int hpet_cnt_ahead(u32 c1, u32 c2)
 {


