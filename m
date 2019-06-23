Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD997C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1BD20679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFWN2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33595 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfFWN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:56 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2XB-0001nO-VL; Sun, 23 Jun 2019 15:27:54 +0200
Message-Id: <20190623132436.646565913@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:08 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 28/29] x86/hpet: Use common init for legacy clockevent
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the static initialization of the legacy clockevent with runtime
initialization utilizing the common init function as the last preparatory
step to switch the legacy clockevent over to the channel 0 storage in
hpet_base.

This comes with a twist. The static clockevent initializer has selected
support for periodic and oneshot mode unconditionally whether the HPET
config advertised periodic mode or not. Even the pre clockevents code did
this. But....

Using the conditional in hpet_init_clockevent() makes at least Qemu and one
hardware machine fail to boot.  There are two issues which cause the boot
failure:

 #1 After the timer delivery test in IOAPIC and the IOAPIC setup the next
    interrupt is not delivered despite the HPET channel being programmed
    correctly. Reprogramming the HPET after switching to IOAPIC makes it
    work again. After fixing this, the next issue surfaces:

 #2 Due to the unconditional periodic mode 'availability' the Local APIC
    timer calibration can hijack the global clockevents event handler
    without causing damage. Using oneshot at this stage makes if hang
    because the HPET does not get reprogrammed due to the handler
    hijacking. Duh, stupid me!

Both issues require major surgery and especially the kick HPET again after
enabling IOAPIC results in really nasty hackery.  This 'assume periodic
works' magic has survived since HPET support got added, so it's
questionable whether this should be fixed. Both Qemu and the failing
hardware machine support periodic mode despite the fact that both don't
advertise it in the configuration register and both need that extra kick
after switching to IOAPIC. Seems to be a feature...

Keep the 'assume periodic works' magic around and add a big fat comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   87 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -66,6 +66,9 @@ bool					boot_hpet_disable;
 bool					hpet_force_user;
 static bool				hpet_verbose;
 
+/*
+ * The HPET clock event device wrapped in a channel for conversion
+ */
 static struct hpet_channel		hpet_channel0;
 
 static inline
@@ -294,22 +297,6 @@ static void hpet_enable_legacy_int(void)
 	hpet_legacy_int_enabled = true;
 }
 
-static void hpet_legacy_clockevent_register(struct hpet_channel *hc)
-{
-	/* Start HPET legacy interrupts */
-	hpet_enable_legacy_int();
-
-	/*
-	 * Start HPET with the boot CPU's cpumask and make it global after
-	 * the IO_APIC has been initialized.
-	 */
-	hc->evt.cpumask = cpumask_of(boot_cpu_data.cpu_index);
-	clockevents_config_and_register(&hc->evt, hpet_freq,
-					HPET_MIN_PROG_DELTA, 0x7FFFFFFF);
-	global_clock_event = &hc->evt;
-	pr_debug("Clockevent registered\n");
-}
-
 static int hpet_clkevt_set_periodic(struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
@@ -430,23 +417,57 @@ static void hpet_init_clockevent(struct
 	}
 }
 
-/*
- * The HPET clock event device wrapped in a channel for conversion
- */
-static struct hpet_channel hpet_channel0 = {
-	.evt = {
-		.name			= "hpet",
-		.features		= CLOCK_EVT_FEAT_PERIODIC |
-					  CLOCK_EVT_FEAT_ONESHOT,
-		.set_state_periodic	= hpet_clkevt_set_periodic,
-		.set_state_oneshot	= hpet_clkevt_set_oneshot,
-		.set_state_shutdown	= hpet_clkevt_shutdown,
-		.tick_resume		= hpet_clkevt_legacy_resume,
-		.set_next_event		= hpet_clkevt_set_next_event,
-		.irq			= 0,
-		.rating			= 50,
-	}
-};
+static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
+{
+	/*
+	 * Start HPET with the boot CPU's cpumask and make it global after
+	 * the IO_APIC has been initialized.
+	 */
+	hc->cpu = boot_cpu_data.cpu_index;
+	strncpy(hc->name, "hpet", sizeof(hc->name));
+	hpet_init_clockevent(hc, 50);
+
+	hc->evt.tick_resume	= hpet_clkevt_legacy_resume;
+
+	/*
+	 * Legacy horrors and sins from the past. HPET used periodic mode
+	 * unconditionally for ever on the legacy channel 0. Removing the
+	 * below hack and using the conditional in hpet_init_clockevent()
+	 * makes at least Qemu and one hardware machine fail to boot.
+	 * There are two issues which cause the boot failure:
+	 *
+	 * #1 After the timer delivery test in IOAPIC and the IOAPIC setup
+	 *    the next interrupt is not delivered despite the HPET channel
+	 *    being programmed correctly. Reprogramming the HPET after
+	 *    switching to IOAPIC makes it work again. After fixing this,
+	 *    the next issue surfaces:
+	 *
+	 * #2 Due to the unconditional periodic mode availability the Local
+	 *    APIC timer calibration can hijack the global clockevents
+	 *    event handler without causing damage. Using oneshot at this
+	 *    stage makes if hang because the HPET does not get
+	 *    reprogrammed due to the handler hijacking. Duh, stupid me!
+	 *
+	 * Both issues require major surgery and especially the kick HPET
+	 * again after enabling IOAPIC results in really nasty hackery.
+	 * This 'assume periodic works' magic has survived since HPET
+	 * support got added, so it's questionable whether this should be
+	 * fixed. Both Qemu and the failing hardware machine support
+	 * periodic mode despite the fact that both don't advertise it in
+	 * the configuration register and both need that extra kick after
+	 * switching to IOAPIC. Seems to be a feature...
+	 */
+	hc->evt.features		|= CLOCK_EVT_FEAT_PERIODIC;
+	hc->evt.set_state_periodic	= hpet_clkevt_set_periodic;
+
+	/* Start HPET legacy interrupts */
+	hpet_enable_legacy_int();
+
+	clockevents_config_and_register(&hc->evt, hpet_freq,
+					HPET_MIN_PROG_DELTA, 0x7FFFFFFF);
+	global_clock_event = &hc->evt;
+	pr_debug("Clockevent registered\n");
+}
 
 /*
  * HPET MSI Support


