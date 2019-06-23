Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58615C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81C220840
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFWN1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33475 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfFWN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X3-0001kf-29; Sun, 23 Jun 2019 15:27:45 +0200
Message-Id: <20190623132435.454138339@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:55 +0200
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
Subject: [patch 15/29] x86/hpet: Make naming consistent
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Use 'evt' for clockevents pointers and capitalize HPET in comments.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -121,7 +121,7 @@ static inline int is_hpet_capable(void)
 }
 
 /**
- * is_hpet_enabled - check whether the hpet timer interrupt is enabled
+ * is_hpet_enabled - Check whether the legacy HPET timer interrupt is enabled
  */
 int is_hpet_enabled(void)
 {
@@ -164,7 +164,7 @@ do {								\
 } while (0)
 
 /*
- * When the hpet driver (/dev/hpet) is enabled, we need to reserve
+ * When the HPET driver (/dev/hpet) is enabled, we need to reserve
  * timer 0 and timer 1 in case of RTC emulation.
  */
 #ifdef CONFIG_HPET
@@ -212,7 +212,7 @@ static void __init hpet_reserve_platform
 static void hpet_reserve_platform_timers(unsigned int id) { }
 #endif
 
-/* Common hpet functions */
+/* Common HPET functions */
 static void hpet_stop_counter(void)
 {
 	u32 cfg = hpet_readl(HPET_CFG);
@@ -266,7 +266,7 @@ static void hpet_legacy_clockevent_regis
 	hpet_enable_legacy_int();
 
 	/*
-	 * Start hpet with the boot cpu mask and make it
+	 * Start HPET with the boot cpu mask and make it
 	 * global after the IO_APIC has been initialized.
 	 */
 	hpet_clockevent.cpumask = cpumask_of(boot_cpu_data.cpu_index);
@@ -399,7 +399,7 @@ static int hpet_legacy_next_event(unsign
 }
 
 /*
- * The hpet clock event device
+ * The HPET clock event device
  */
 static struct clock_event_device hpet_clockevent = {
 	.name			= "hpet",
@@ -484,14 +484,14 @@ static int hpet_msi_next_event(unsigned
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 {
 	struct hpet_dev *dev = data;
-	struct clock_event_device *hevt = &dev->evt;
+	struct clock_event_device *evt = &dev->evt;
 
-	if (!hevt->event_handler) {
+	if (!evt->event_handler) {
 		pr_info("Spurious interrupt HPET timer %d\n", dev->num);
 		return IRQ_HANDLED;
 	}
 
-	hevt->event_handler(hevt);
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
@@ -703,7 +703,7 @@ static inline void hpet_reserve_msi_time
  * with its associated locking overhead. And we also need 64-bit atomic
  * read.
  *
- * The lock and the hpet value are stored together and can be read in a
+ * The lock and the HPET value are stored together and can be read in a
  * single atomic 64-bit read. It is explicitly assumed that arch_spinlock_t
  * is 32 bits in size.
  */
@@ -1053,7 +1053,7 @@ static unsigned long hpet_pie_limit;
 static rtc_irq_handler irq_handler;
 
 /*
- * Check that the hpet counter c1 is ahead of the c2
+ * Check that the HPET counter c1 is ahead of the c2
  */
 static inline int hpet_cnt_ahead(u32 c1, u32 c2)
 {


