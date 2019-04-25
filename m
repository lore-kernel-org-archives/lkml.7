Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7ED20678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WE23i7qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfDYS6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:58:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52655 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:58:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3PIw7N03249921
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Apr 2019 11:58:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3PIw7N03249921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556218688;
        bh=Rm+yBZl2P3ydJgMvbUeWPGGJNHoS26focdtDma/OW+8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WE23i7qtVot8wThMqddT9Kd4x/dKIlGqFmTk1oBcwcGEmCeUZKe5t3Jlx9f6+g6aw
         ssb/IdknrNSmKYDpKHCvuq+y2/7v7EggzYeRLrnpdQx9N5mcY4+zh1ksxwfUEQNAW7
         hBXHiq703pXsHlyCDfp8ORoZLnkWTOatLv93nAhjxjfRcjhdPnGzL2ITqJs3rIcuBR
         V2TXIF51ADCkFf5oSMEIjA9IKDPvxiRhbI1eRgI4mpcxtuw/wH3OfZMz23+sZD3Ek8
         S0QvIMO2aV9KfdAjFJlHapLzcU4D+3qo8xoMWyHhX5lW1ImEXyU7N/ncZFdZyuAZtx
         Lyy8EQtZ5xrfA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3PIw7wm3249918;
        Thu, 25 Apr 2019 11:58:07 -0700
Date:   Thu, 25 Apr 2019 11:58:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jacob Pan <tipbot@zytor.com>
Message-ID: <tip-6eb4f08293e971cb1b7b867c7fe994c244b91460@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com,
        lenb@kernel.org, mingo@kernel.org, hpa@zytor.com,
        drake@endlessm.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          jacob.jun.pan@linux.intel.com, lenb@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, drake@endlessm.com
In-Reply-To: <1556213272-63568-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556213272-63568-1-git-send-email-jacob.jun.pan@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Unify duplicated local apic timer
 clockevent initialization
Git-Commit-ID: 6eb4f08293e971cb1b7b867c7fe994c244b91460
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

Commit-ID:  6eb4f08293e971cb1b7b867c7fe994c244b91460
Gitweb:     https://git.kernel.org/tip/6eb4f08293e971cb1b7b867c7fe994c244b91460
Author:     Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate: Thu, 25 Apr 2019 10:27:52 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Apr 2019 20:54:21 +0200

x86/apic: Unify duplicated local apic timer clockevent initialization

Local APIC timer clockevent parameters can be calculated based on platform
specific methods. However the code is mostly duplicated with the interrupt
based calibration. The commit which increased the max_delta parameter
updated only one place and made the implementations diverge.

Unify it to prevent further damage.

[ tglx: Rename function to lapic_init_clockevent() and adjust changelog a bit ]

Fixes: 4aed89d6b515 ("x86, lapic-timer: Increase the max_delta to 31 bits")
Reported-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Link: https://lkml.kernel.org/r/1556213272-63568-1-git-send-email-jacob.jun.pan@linux.intel.com
---
 arch/x86/kernel/apic/apic.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b7bcdd781651..ab6af775f06c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -802,6 +802,24 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	return 0;
 }
 
+static int __init lapic_init_clockevent(void)
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
@@ -810,25 +828,21 @@ static int __init calibrate_APIC_clock(void)
 	long delta, deltatsc;
 	int pm_referenced = 0;
 
-	/**
-	 * check if lapic timer has already been calibrated by platform
-	 * specific routine, such as tsc calibration code. if so, we just fill
+	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		return 0;
+
+	/*
+	 * Check if lapic timer has already been calibrated by platform
+	 * specific routine, such as tsc calibration code. If so just fill
 	 * in the clockevent structure and return.
 	 */
-
-	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER)) {
-		return 0;
-	} else if (lapic_timer_frequency) {
+	if (!lapic_init_clockevent()) {
 		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-				lapic_timer_frequency);
-		lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
-					TICK_NSEC, lapic_clockevent.shift);
-		lapic_clockevent.max_delta_ns =
-			clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
-		lapic_clockevent.max_delta_ticks = 0x7FFFFF;
-		lapic_clockevent.min_delta_ns =
-			clockevent_delta2ns(0xF, &lapic_clockevent);
-		lapic_clockevent.min_delta_ticks = 0xF;
+			    lapic_timer_frequency);
+		/*
+		 * Direct calibration methods must have an always running
+		 * local APIC timer, no need for broadcast timer.
+		 */
 		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_DUMMY;
 		return 0;
 	}
@@ -869,17 +883,8 @@ static int __init calibrate_APIC_clock(void)
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
+	lapic_init_clockevent();
 
 	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
