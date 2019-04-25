Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83783C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA43206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfDYRZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:25:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:2315 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDYRZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:25:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 10:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="138811082"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 25 Apr 2019 10:25:11 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Len Brown <lenb@kernel.org>, X86 Kernel <x86@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH] x86/apic: Fix duplicated lapic timer calculation
Date:   Thu, 25 Apr 2019 10:27:52 -0700
Message-Id: <1556213272-63568-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local APIC timer clockevent parameters can be calculated based on
platform specific methods. However the code is mostly duplicated
with the interrupt based calibration. This causes further updates
prone to mistakes. The commit below only did partial update of the
duplicated code.

Fixes: 4aed89d ("x86, lapic-timer: Increase the max_delta to 31 bits")

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Drake <drake@endlessm.com>
---
 arch/x86/kernel/apic/apic.c | 46 ++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b7bcdd7..4dc40c6 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -802,6 +802,24 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	return 0;
 }
 
+static int __init calculate_lapic_clockevent(void)
+{
+	if (!lapic_timer_frequency)
+		return -1;
+
+	/* Calculate the scaled math multiplication factor */
+	lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
+					TICK_NSEC, lapic_clockevent.shift);
+	lapic_clockevent.max_delta_ns =
+		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
+	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;
+	lapic_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xF, &lapic_clockevent);
+	lapic_clockevent.min_delta_ticks = 0xF;
+
+	return 0;
+}
+
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
@@ -818,18 +836,17 @@ static int __init calibrate_APIC_clock(void)
 
 	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER)) {
 		return 0;
-	} else if (lapic_timer_frequency) {
+	}
+
+	if (!calculate_lapic_clockevent()) {
 		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
 				lapic_timer_frequency);
-		lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
-					TICK_NSEC, lapic_clockevent.shift);
-		lapic_clockevent.max_delta_ns =
-			clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
-		lapic_clockevent.max_delta_ticks = 0x7FFFFF;
-		lapic_clockevent.min_delta_ns =
-			clockevent_delta2ns(0xF, &lapic_clockevent);
-		lapic_clockevent.min_delta_ticks = 0xF;
+		/*
+		 * Platforms provide direct calibration methods must have always
+		 * running local APIC timers, no need for boradcast timer.
+		 */
 		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_DUMMY;
+
 		return 0;
 	}
 
@@ -869,17 +886,8 @@ static int __init calibrate_APIC_clock(void)
 	pm_referenced = !calibrate_by_pmtimer(lapic_cal_pm2 - lapic_cal_pm1,
 					&delta, &deltatsc);
 
-	/* Calculate the scaled math multiplication factor */
-	lapic_clockevent.mult = div_sc(delta, TICK_NSEC * LAPIC_CAL_LOOPS,
-				       lapic_clockevent.shift);
-	lapic_clockevent.max_delta_ns =
-		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
-	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;
-	lapic_clockevent.min_delta_ns =
-		clockevent_delta2ns(0xF, &lapic_clockevent);
-	lapic_clockevent.min_delta_ticks = 0xF;
-
 	lapic_timer_frequency = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
+	calculate_lapic_clockevent();
 
 	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
-- 
2.7.4

