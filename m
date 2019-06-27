Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C65C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAA3216FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Gp9afMZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfF0Xy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:54:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF0Xy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:54:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNp8pZ503927
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:51:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNp8pZ503927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679469;
        bh=UW2q1thB4WH8Ub/6H0GOGkuVc9HkFpHf+OxMixQ3Xrc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Gp9afMZfVItRmjFc6AQHQ0piujnpMPdiInciawv/Z6y/Y1H6DkUwddUkoQInMhpgy
         s8MiSQHU3atSBWPPTmxlOViFTmA1Px0hCQp60SF55cGX+cALZw3/xe701z6L6drc60
         UWrsLCqBGHnXCgPpqs17WLGiK0JpJ8RNbUqF/rYj9fQxjWObgrrpAr9O7gq1zbCPGm
         Hqxh9eJZOBJ/0Re+TBYC8rl2jaojLYCpPf4Ml/VIE6IF/rjCBP9cWPN7x+r7Gc23ur
         qAfowo+91aQrt2xmMvGoGtPzlT1dfVLdvmLfSLfVNuCkEnLtuqgSoClrRccCOplzqC
         rPxTkbMyHeEiA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNp77L503919;
        Thu, 27 Jun 2019 16:51:07 -0700
Date:   Thu, 27 Jun 2019 16:51:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-18e84a2dff00c3c817161a105332cd3fc7592648@git.kernel.org>
Cc:     eranian@google.com, mingo@kernel.org, ashok.raj@intel.com,
        linux-kernel@vger.kernel.org, Suravee.Suthikulpanit@amd.com,
        peterz@infradead.org, ricardo.neri-calderon@linux.intel.com,
        andi.kleen@intel.com, ravi.v.shankar@intel.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: hpa@zytor.com, andi.kleen@intel.com, tglx@linutronix.de,
          ravi.v.shankar@intel.com, Suravee.Suthikulpanit@amd.com,
          linux-kernel@vger.kernel.org,
          ricardo.neri-calderon@linux.intel.com, peterz@infradead.org,
          eranian@google.com, mingo@kernel.org, ashok.raj@intel.com
In-Reply-To: <20190623132436.368141247@linutronix.de>
References: <20190623132436.368141247@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Wrap legacy clockevent in hpet_channel
Git-Commit-ID: 18e84a2dff00c3c817161a105332cd3fc7592648
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

Commit-ID:  18e84a2dff00c3c817161a105332cd3fc7592648
Gitweb:     https://git.kernel.org/tip/18e84a2dff00c3c817161a105332cd3fc7592648
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:05 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:25 +0200

x86/hpet: Wrap legacy clockevent in hpet_channel

For HPET channel 0 there exist two clockevent structures right now:
  - the static hpet_clockevent
  - the clockevent in channel 0 storage

The goal is to use the clockevent in the channel storage, remove the static
variable and share code with the MSI implementation.

As a first step wrap the legacy clockevent into a hpet_channel struct and
convert the users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132436.368141247@linutronix.de

---
 arch/x86/kernel/hpet.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 985a2246d20c..19e3ac81c3b9 100644
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
@@ -303,10 +303,10 @@ static void hpet_legacy_clockevent_register(void)
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
 
@@ -433,19 +433,21 @@ static int hpet_legacy_next_event(unsigned long delta,
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
 
@@ -1198,9 +1201,11 @@ int hpet_set_periodic_freq(unsigned long freq)
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
