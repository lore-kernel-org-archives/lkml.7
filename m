Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC68CC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC7720578
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rycszufd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfHSKhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:37:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:37:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7JAb5ER4099971
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 03:37:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7JAb5ER4099971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566211025;
        bh=P49+CNkmzKUSRKl8iOJpThtm2TN5njwQRkXDFnqtE6w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rycszufdP3vDsu0/f8WC7G99VxthMx1yzYqZ+jdpM75MeaS5o4nX3IdTbBb7URMXQ
         RJ9taUbYrlL3T/ro4CzDCFbrgdjxwKyEm8wFuwPT2iOF67Xh7sxV1z5R+6GwpmHxAj
         wNvY8iPFw9H8RBrMw90coH6n4m7EOA6ogAmcGS5XjEF9t0Axb1Z6yHzHaxFtGFn7cq
         GvtyKpVXEG7XYnT59vX8xmNZ/RH3R0ghzCqbYIE0QTA7/pEf45cC5FDp2TX3pJMqbT
         OrD2lUP1niXnbhSmHcDhF+Ps9GYIstofYgia1c2PLOJZaFjQuK7K199MSX5c2o+a5w
         AGI1MAo0rW8kg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7JAb4co4099968;
        Mon, 19 Aug 2019 03:37:04 -0700
Date:   Mon, 19 Aug 2019 03:37:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f897e60a12f0b9146357780d317879bce2a877dc@git.kernel.org>
Cc:     drake@endlessm.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jslaby@suse.cz
Reply-To: mingo@kernel.org, drake@endlessm.com, jslaby@suse.cz,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic: Handle missing global clockevent
 gracefully
Git-Commit-ID: f897e60a12f0b9146357780d317879bce2a877dc
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

Commit-ID:  f897e60a12f0b9146357780d317879bce2a877dc
Gitweb:     https://git.kernel.org/tip/f897e60a12f0b9146357780d317879bce2a877dc
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 9 Aug 2019 14:54:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 19 Aug 2019 12:34:07 +0200

x86/apic: Handle missing global clockevent gracefully

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
either TSC (if frequency is known) or jiffies. The latter requires a global
clockevent. As the machines which do not have a global clockevent installed
have a known TSC frequency this is a non issue. For older machines where
TSC frequency is not known, there is no known case where the legacy timers
do not exist as that would have been reported long ago.

Reported-by: Daniel Drake <drake@endlessm.com>
Reported-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Drake <drake@endlessm.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de
Link: http://bugzilla.opensuse.org/show_bug.cgi?id=1142926#c12
---
 arch/x86/kernel/apic/apic.c | 68 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f5291362da1a..aa5495d0f478 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -722,7 +722,7 @@ static __initdata unsigned long lapic_cal_pm1, lapic_cal_pm2;
 static __initdata unsigned long lapic_cal_j1, lapic_cal_j2;
 
 /*
- * Temporary interrupt handler.
+ * Temporary interrupt handler and polled calibration function.
  */
 static void __init lapic_cal_handler(struct clock_event_device *dev)
 {
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
@@ -878,28 +879,64 @@ static int __init calibrate_APIC_clock(void)
 	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
 		    "calibrating APIC timer ...\n");
 
+	/*
+	 * There are platforms w/o global clockevent devices. Instead of
+	 * making the calibration conditional on that, use a polling based
+	 * approach everywhere.
+	 */
 	local_irq_disable();
 
-	/* Replace the global interrupt handler */
-	real_handler = global_clock_event->event_handler;
-	global_clock_event->event_handler = lapic_cal_handler;
-
 	/*
 	 * Setup the APIC counter to maximum. There is no way the lapic
 	 * can underflow in the 100ms detection time frame
 	 */
 	__setup_APIC_LVTT(0xffffffff, 0, 0);
 
-	/* Let the interrupts run */
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
+	/*
+	 * Enable interrupts so the tick can fire, if a global
+	 * clockevent device is available
+	 */
 	local_irq_enable();
 
-	while (lapic_cal_loops <= LAPIC_CAL_LOOPS)
-		cpu_relax();
+	while (lapic_cal_loops <= LAPIC_CAL_LOOPS) {
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
 
-	local_irq_disable();
+				if (time_after(jif_now, jif_start)) {
+					jif_start = jif_now;
+					break;
+				}
+			}
+			cpu_relax();
+		}
 
-	/* Restore the real event handler */
-	global_clock_event->event_handler = real_handler;
+		/* Invoke the calibration routine */
+		local_irq_disable();
+		lapic_cal_handler(NULL);
+		local_irq_enable();
+	}
+
+	local_irq_disable();
 
 	/* Build delta t1-t2 as apic timer counts down */
 	delta = lapic_cal_t1 - lapic_cal_t2;
@@ -943,10 +980,11 @@ static int __init calibrate_APIC_clock(void)
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
