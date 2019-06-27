Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00F1C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788BC2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfF0OHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:07:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56131 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0OHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:07:02 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgV39-0005i9-N2; Thu, 27 Jun 2019 16:06:55 +0200
Date:   Thu, 27 Jun 2019 16:06:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        hdegoede@redhat.com, david.e.box@linux.intel.com,
        linux@endlessm.com, rafael.j.wysocki@intel.com, x86@kernel.org
Subject: Re: No 8254 PIT & no HPET on new Intel N3350 platforms causes kernel
 panic during early boot
In-Reply-To: <20190627085419.27854-1-drake@endlessm.com>
Message-ID: <alpine.DEB.2.21.1906271546010.32342@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1904031206440.1967@nanos.tec.linutronix.de> <20190627085419.27854-1-drake@endlessm.com>
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

Daniel,

On Thu, 27 Jun 2019, Daniel Drake wrote:
> Picking up this issue again after a break!
> 
> We made some progress last time on reducing PIT usage in the TSC
> calibration code, but we still have the bigger issue to resolve:
> IO-APIC code panicing when the PIT isn't ticking.

Yeah. I was busy with other stuff and simply forgot.

> Being more conservative, how about something like this?
>  
> +	/*
> +	 * Record if the timer was in working state before we do any
> +	 * IO-APIC setup.
> +	 */
> +	if (nr_legacy_irqs())
> +		timer_was_working = timer_irq_works();

Nah. That extra timer works thing is just another bandaid.

What I had in mind is something like the below. That's on top of

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic

Be warned. It's neither compiled nor tested, so keep a fire extinguisher
handy. If it explodes you own the pieces.

/me goes off to find icecream 

Thanks,

	tglx

8<-----------------
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -173,6 +173,7 @@ extern void lapic_assign_system_vectors(
 extern void lapic_assign_legacy_vector(unsigned int isairq, bool replace);
 extern void lapic_online(void);
 extern void lapic_offline(void);
+extern bool apic_needs_pit(void);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
@@ -186,6 +187,7 @@ static inline void init_bsp_APIC(void) {
 static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
+static inline bool apic_needs_pit(void) { return true; }
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -7,6 +7,7 @@
 
 extern void hpet_time_init(void);
 extern void time_init(void);
+extern bool pit_timer_init(void);
 
 extern struct clock_event_device *global_clock_event;
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -820,6 +820,33 @@ static int __init lapic_init_clockevent(
 	return 0;
 }
 
+bool __init apic_and_tsc_needs_pit(void)
+{
+	/*
+	 * If the frequencies are not known, PIT is required for both TSC
+	 * and apic timer calibration.
+	 */
+	if (!tsc_khz || !cpu_khz)
+		return true;
+
+	/* Is there an APIC at all? */
+	if (!boot_cpu_has(X86_FEATURE_APIC))
+		return true;
+
+	/* Deadline timer is based on TSC so no further PIT action required */
+	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		return false;
+
+	/* APIC timer disabled? */
+	if (disable_apic_timer)
+		return true;
+	/*
+	 * The APIC timer frequency is known already, no PIT calibration
+	 * required. If unknown, let the PIT be initialized.
+	 */
+	return lapic_timer_period == 0;
+}
+
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -58,6 +58,7 @@
 #include <asm/acpi.h>
 #include <asm/dma.h>
 #include <asm/timer.h>
+#include <asm/time.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
 #include <asm/irq_remapping.h>
@@ -2083,6 +2084,9 @@ static inline void __init check_timer(vo
 	unsigned long flags;
 	int no_pin1 = 0;
 
+	if (!global_clock_event)
+		return;
+
 	local_irq_save(flags);
 
 	/*
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/i8253.h>
 
+#include <asm/apic.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 #include <asm/smp.h>
@@ -18,10 +19,32 @@
  */
 struct clock_event_device *global_clock_event;
 
-void __init setup_pit_timer(void)
+/*
+ * Modern chipsets can disable the PIT clock which makes it unusable. It
+ * would be possible to enable the clock but the registers are chipset
+ * specific and not discoverable. Avoid the whack a mole game.
+ *
+ * These platforms have discoverable TSC/CPU frequencies but this also
+ * requires to know the local APIC timer frequency as it normally is
+ * calibrated against the PIT interrupt.
+ */
+static bool __init use_pit(void)
 {
+	if (!IS_ENABLED(CONFIG_X86_TSC) || !boot_cpu_has(X86_FEATURE_TSC))
+		return true;
+
+	/* This also returns true when APIC is disabled */
+	return apic_needs_pit();
+}
+
+bool __init pit_timer_init(void)
+{
+	if (!use_pit())
+		return false;
+
 	clockevent_i8253_init(true);
 	global_clock_event = &i8253_clockevent;
+	return true;
 }
 
 #ifndef CONFIG_X86_64
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -82,8 +82,11 @@ static void __init setup_default_timer_i
 /* Default timer init function */
 void __init hpet_time_init(void)
 {
-	if (!hpet_enable())
-		setup_pit_timer();
+	if (!hpet_enable()) {
+		if (!pit_timer_init())
+			return;
+	}
+
 	setup_default_timer_irq();
 }
 
