Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3748FC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA9820B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406941AbfHIMya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:54:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57036 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:54:29 -0400
Received: from p200300ddd71876457e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7645:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hw4PN-0007B1-GO; Fri, 09 Aug 2019 14:54:13 +0200
Date:   Fri, 9 Aug 2019 14:54:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] x86/apic: Handle missing global clockevent gracefully
In-Reply-To: <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com>
Message-ID: <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com> <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de> <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de> <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com> <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de> <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com> <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com> <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de> <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com>
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

Some newer machines do not advertise legacy timers. The kernel can handle
that situation if the TSC and the CPU frequency are enumerated by CPUID or
MSRs and the CPU supports TSC deadline timer. If the CPU does not support
TSC deadline timer the local APIC timer frequency has to be known as well.

Some Ryzens machines do not advertize legacy timers, but there is no
reliable way to determine the bus frequency which feeds the local APIC
timer when the machine allows overclocking of that frequency.

As there is no legacy timer the local APIC timer calibration crashes due to
a NULL pointer dereference when accessing the not installed global clock
event device.

Switch the calibration loop to a non interrupt based one, which polls
either TSC (frequency known) or jiffies. The latter requires a global
clockevent. As the machines which do not have a global clockevent installed
have a known TSC frequency this is a non issue. For older machines where
TSC frequency is not known, there is no known case where the legacy timers
do not exist as that would have been reported long ago.

Reported-by: Daniel Drake <drake@endlessm.com>
Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

Note: Only lightly tested, but of course not on an affected machine.

      If that works reliably, then this needs some exhaustive testing
      on a wide range of systems so we can risk backports to stable
      kernels.

---
 arch/x86/kernel/apic/apic.c |   70 +++++++++++++++++++++++++++++++++-----------
 include/linux/acpi_pmtmr.h  |   10 ++++++
 2 files changed, 64 insertions(+), 16 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -851,7 +851,8 @@ bool __init apic_needs_pit(void)
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
-	void (*real_handler)(struct clock_event_device *dev);
+	u64 tsc_perj = 0, tsc_start = 0;
+	unsigned long jif_start;
 	unsigned long deltaj;
 	long delta, deltatsc;
 	int pm_referenced = 0;
@@ -878,29 +879,65 @@ static int __init calibrate_APIC_clock(v
 	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
 		    "calibrating APIC timer ...\n");
 
-	local_irq_disable();
-
-	/* Replace the global interrupt handler */
-	real_handler = global_clock_event->event_handler;
-	global_clock_event->event_handler = lapic_cal_handler;
+	/*
+	 * There are platforms w/o global clockevent devices. Instead of
+	 * making the calibration conditional on that, use a polling based
+	 * approach everywhere.
+	 */
 
+	local_irq_disable();
 	/*
 	 * Setup the APIC counter to maximum. There is no way the lapic
 	 * can underflow in the 100ms detection time frame
 	 */
 	__setup_APIC_LVTT(0xffffffff, 0, 0);
 
-	/* Let the interrupts run */
-	local_irq_enable();
+	/*
+	 * Methods to terminate the calibration loop:
+	 *  1) Global clockevent if available (jiffies)
+	 *  2) TSC if available and frequency is known
+	 */
+	jif_start = READ_ONCE(jiffies);
+
+	if (tsc_khz) {
+		tsc_start = rdtsc();
+		tsc_perj = div_u64((u64)tsc_khz * 1000, HZ);
+	}
+
+	while (lapic_cal_loops <= LAPIC_CAL_LOOPS) {
+		/*
+		 * Enable interrupts so the tick can fire, if a global
+		 * clockevent device is available
+		 */
+		local_irq_enable();
 
-	while (lapic_cal_loops <= LAPIC_CAL_LOOPS)
-		cpu_relax();
+		/* Wait for a tick to elapse */
+		while (1) {
+			if (tsc_khz) {
+				u64 tsc_now = rdtsc();
+				if ((tsc_now - tsc_start) >= tsc_perj) {
+					tsc_start += tsc_perj;
+					break;
+				}
+			} else {
+				unsigned long jif_now = READ_ONCE(jiffies);
+
+				if (time_after(jif_now, jif_start)) {
+					jif_start = jif_now;
+					break;
+				}
+			}
+			cpu_relax();
+		}
+
+		/* Invoke the calibration routine */
+		local_irq_disable();
+		lapic_cal_handler(NULL);
+		local_irq_enable();
+	}
 
 	local_irq_disable();
 
-	/* Restore the real event handler */
-	global_clock_event->event_handler = real_handler;
-
 	/* Build delta t1-t2 as apic timer counts down */
 	delta = lapic_cal_t1 - lapic_cal_t2;
 	apic_printk(APIC_VERBOSE, "... lapic delta = %ld\n", delta);
@@ -943,10 +980,11 @@ static int __init calibrate_APIC_clock(v
 	levt->features &= ~CLOCK_EVT_FEAT_DUMMY;
 
 	/*
-	 * PM timer calibration failed or not turned on
-	 * so lets try APIC timer based calibration
+	 * PM timer calibration failed or not turned on so lets try APIC
+	 * timer based calibration, if a global clockevent device is
+	 * available.
 	 */
-	if (!pm_referenced) {
+	if (!pm_referenced && global_clock_event) {
 		apic_printk(APIC_VERBOSE, "... verify APIC timer\n");
 
 		/*
--- a/include/linux/acpi_pmtmr.h
+++ b/include/linux/acpi_pmtmr.h
@@ -18,6 +18,11 @@
 extern u32 acpi_pm_read_verified(void);
 extern u32 pmtmr_ioport;
 
+static inline bool acpi_pm_timer_available(void)
+{
+	return pmtmr_ioport != 0;
+}
+
 static inline u32 acpi_pm_read_early(void)
 {
 	if (!pmtmr_ioport)
@@ -28,6 +33,11 @@ static inline u32 acpi_pm_read_early(voi
 
 #else
 
+static inline bool acpi_pm_timer_available(void)
+{
+	return false;
+}
+
 static inline u32 acpi_pm_read_early(void)
 {
 	return 0;
