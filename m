Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A559AC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA421736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfDSXHL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:07:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:40396 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDSXHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:07:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 16:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,371,1549958400"; 
   d="scan'208";a="225062133"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2019 16:07:09 -0700
Date:   Fri, 19 Apr 2019 16:09:49 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Drake <drake@endlessm.com>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, rjw@rjwysocki.net,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: Detecting x86 LAPIC timer frequency from CPUID data
Message-ID: <20190419160949.0af9dd09@jacob-builder>
In-Reply-To: <alpine.DEB.2.21.1904192251230.3174@nanos.tec.linutronix.de>
References: <20190419083533.32388-1-drake@endlessm.com>
        <alpine.DEB.2.21.1904191042180.3174@nanos.tec.linutronix.de>
        <20190419135037.5bf5750e@jacob-builder>
        <alpine.DEB.2.21.1904192251230.3174@nanos.tec.linutronix.de>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 22:52:01 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 19 Apr 2019, Jacob Pan wrote:
> > On Fri, 19 Apr 2019 10:57:10 +0200 (CEST)
> > Thomas Gleixner <tglx@linutronix.de> wrote:  
> > > On Fri, 19 Apr 2019, Daniel Drake wrote:  
> > > > 0x7FFFFF vs 0x7FFFFFFF, is that intentional?    
> > > 
> > > I don't think so. Looks like a failed copy and paste. Cc'ed
> > > Jacob, he might know.
> > >   
> > At the time of v2.6.35 both places use 0x7FFFFF. But later this
> > patch increased the latter to 0x7FFFFFFF but forgot the first part.
> > So I guess it is not exactly a failed copy and paste.
> > 
> > commit 4aed89d6b515b9185351706ca95cd712c9d8d6a3
> > Author: Pierre Tardy <pierre.tardy@intel.com>
> > Date:   Thu Jan 6 16:23:29 2011 +0100
> > 
> >     x86, lapic-timer: Increase the max_delta to 31 bits  
> 
> Indeed. Thanks for digging that up!
> 
> 	tglx

How about a fix like this? I should have taken your advice 9 years ago
to avoid duplicated code :)
https://lkml.org/lkml/2010/5/11/499

From 18450bb67e09f5b472f1ed313d7f87a983cb0ac1 Mon Sep 17 00:00:00 2001
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Date: Fri, 19 Apr 2019 15:56:06 -0700
Subject: [PATCH] x86/apic: Fix duplicated lapic timer calculation

Local APIC timer clockevent parameters can be calculated based on
platform specific methods. However the code is mostly duplicated
with the interrupt based calibration. This causes further updates
prone to mistakes.

Fixes: 4aed89d ("x86, lapic-timer: Increase the max_delta to 31 bits")

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/apic/apic.c | 46
++++++++++++++++++++++++++------------------- 1 file changed, 27
insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b7bcdd7..b2ef91c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -802,6 +802,24 @@ calibrate_by_pmtimer(long deltapm, long *delta,
long *deltatsc) return 0;
 }
 
+static int __init calculate_lapic_clockevent(void)
+{
+	if (!lapic_timer_frequency)
+		return -1;
+
+	/* Calculate the scaled math multiplication factor */
+	lapic_clockevent.mult =
div_sc(lapic_timer_frequency/APIC_DIVISOR,
+					TICK_NSEC,
lapic_clockevent.shift);
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
 		apic_printk(APIC_VERBOSE, "lapic timer already
calibrated %d\n", lapic_timer_frequency);
-		lapic_clockevent.mult =
div_sc(lapic_timer_frequency/APIC_DIVISOR,
-					TICK_NSEC,
lapic_clockevent.shift);
-		lapic_clockevent.max_delta_ns =
-			clockevent_delta2ns(0x7FFFFF,
&lapic_clockevent);
-		lapic_clockevent.max_delta_ticks = 0x7FFFFF;
-		lapic_clockevent.min_delta_ns =
-			clockevent_delta2ns(0xF, &lapic_clockevent);
-		lapic_clockevent.min_delta_ticks = 0xF;
+		/*
+		 * Newer platforms provide early calibration methods
must have always
+		 * running local APIC timers, no need for boradcast
timer.
+		 */
 		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_DUMMY;
+
 		return 0;
 	}
 
@@ -869,17 +886,8 @@ static int __init calibrate_APIC_clock(void)
 	pm_referenced = !calibrate_by_pmtimer(lapic_cal_pm2 -
lapic_cal_pm1, &delta, &deltatsc);
 
-	/* Calculate the scaled math multiplication factor */
-	lapic_clockevent.mult = div_sc(delta, TICK_NSEC *
LAPIC_CAL_LOOPS,
-				       lapic_clockevent.shift);
-	lapic_clockevent.max_delta_ns =
-		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
-	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;
-	lapic_clockevent.min_delta_ns =
-		clockevent_delta2ns(0xF, &lapic_clockevent);
-	lapic_clockevent.min_delta_ticks = 0xF;
-
 	lapic_timer_frequency = (delta * APIC_DIVISOR) /
LAPIC_CAL_LOOPS;
+	calculate_lapic_clockevent();
 
 	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %u\n",
lapic_clockevent.mult);
-- 
2.7.4

