Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D98DC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611A620679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfFWN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfFWN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:54 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X9-0001ml-OR; Sun, 23 Jun 2019 15:27:51 +0200
Message-Id: <20190623132436.368141247@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 25/29] x86/hpet: Wrap legacy clockevent in hpet_channel
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For HPET channel 0 there exist two clockevent structures right now:
  - the static hpet_clockevent
  - the clockevent in channel 0 storage

The goal is to use the clockevent in the channel storage, remove the static
variable and share code with the MSI implementation.

As a first step wrap the legacy clockevent into a hpet_channel struct and
convert the users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -66,7 +66,7 @@ bool					boot_hpet_disable;
 bool					hpet_force_user;
 static bool				hpet_verbose;
 
-static struct clock_event_device	hpet_clockevent;
+static struct hpet_channel		hpet_channel0;
 
 static inline
 struct hpet_channel *clockevent_to_channel(struct clock_event_device *evt)
@@ -294,7 +294,7 @@ static void hpet_enable_legacy_int(void)
 	hpet_legacy_int_enabled = true;
 }
 
-static void hpet_legacy_clockevent_register(void)
+static void hpet_legacy_clockevent_register(struct hpet_channel *hc)
 {
 	/* Start HPET legacy interrupts */
 	hpet_enable_legacy_int();
@@ -303,10 +303,10 @@ static void hpet_legacy_clockevent_regis
 	 * Start HPET with the boot CPU's cpumask and make it global after
 	 * the IO_APIC has been initialized.
 	 */
-	hpet_clockevent.cpumask = cpumask_of(boot_cpu_data.cpu_index);
-	clockevents_config_and_register(&hpet_clockevent, hpet_freq,
+	hc->evt.cpumask = cpumask_of(boot_cpu_data.cpu_index);
+	clockevents_config_and_register(&hc->evt, hpet_freq,
 					HPET_MIN_PROG_DELTA, 0x7FFFFFFF);
-	global_clock_event = &hpet_clockevent;
+	global_clock_event = &hc->evt;
 	pr_debug("Clockevent registered\n");
 }
 
@@ -433,19 +433,21 @@ static int hpet_legacy_next_event(unsign
 }
 
 /*
- * The HPET clock event device
+ * The HPET clock event device wrapped in a channel for conversion
  */
-static struct clock_event_device hpet_clockevent = {
-	.name			= "hpet",
-	.features		= CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_ONESHOT,
-	.set_state_periodic	= hpet_legacy_set_periodic,
-	.set_state_oneshot	= hpet_legacy_set_oneshot,
-	.set_state_shutdown	= hpet_legacy_shutdown,
-	.tick_resume		= hpet_legacy_resume,
-	.set_next_event		= hpet_legacy_next_event,
-	.irq			= 0,
-	.rating			= 50,
+static struct hpet_channel hpet_channel0 = {
+	.evt = {
+		.name			= "hpet",
+		.features		= CLOCK_EVT_FEAT_PERIODIC |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_periodic	= hpet_legacy_set_periodic,
+		.set_state_oneshot	= hpet_legacy_set_oneshot,
+		.set_state_shutdown	= hpet_legacy_shutdown,
+		.tick_resume		= hpet_legacy_resume,
+		.set_next_event		= hpet_legacy_next_event,
+		.irq			= 0,
+		.rating			= 50,
+	}
 };
 
 /*
@@ -916,7 +918,7 @@ int __init hpet_enable(void)
 	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
-		hpet_legacy_clockevent_register();
+		hpet_legacy_clockevent_register(&hpet_channel0);
 		hpet_base.channels[0].mode = HPET_MODE_LEGACY;
 		if (IS_ENABLED(CONFIG_HPET_EMULATE_RTC))
 			hpet_base.channels[1].mode = HPET_MODE_LEGACY;
@@ -1101,10 +1103,11 @@ int hpet_rtc_timer_init(void)
 		return 0;
 
 	if (!hpet_default_delta) {
+		struct clock_event_device *evt = &hpet_channel0.evt;
 		uint64_t clc;
 
-		clc = (uint64_t) hpet_clockevent.mult * NSEC_PER_SEC;
-		clc >>= hpet_clockevent.shift + DEFAULT_RTC_SHIFT;
+		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
+		clc >>= evt->shift + DEFAULT_RTC_SHIFT;
 		hpet_default_delta = clc;
 	}
 
@@ -1198,9 +1201,11 @@ int hpet_set_periodic_freq(unsigned long
 	if (freq <= DEFAULT_RTC_INT_FREQ) {
 		hpet_pie_limit = DEFAULT_RTC_INT_FREQ / freq;
 	} else {
-		clc = (uint64_t) hpet_clockevent.mult * NSEC_PER_SEC;
+		struct clock_event_device *evt = &hpet_channel0.evt;
+
+		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
 		do_div(clc, freq);
-		clc >>= hpet_clockevent.shift;
+		clc >>= evt->shift;
 		hpet_pie_delta = clc;
 		hpet_pie_limit = 0;
 	}


