Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC242C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E99E2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uvDlfiOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF0Xx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:53:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:53:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNrDri504093
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:53:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNrDri504093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679593;
        bh=M7OLZtoXqkX116sgY2OYa+CbJ/v63CPCmrFPqmZ0fto=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uvDlfiObCOLzM7/4jtUe0HKjVhebvVIaU6nevVbx0J3Rr2phytxvXLR6P7lyUhI+s
         3ENExzQllEorfHWt9k+K+lPl/9JuL7q5Qe71mJ7IhMjzTvi6WchvRUKzh6XCwhtwKI
         oYTXX1+WzFf9VLPbBx1cKrHkdrJ0JOTEsY/W4wbbTa4kGsP5snd29ctE4yxT3Djilu
         k5vZvVxlkaRYTwLnsxJERJJag26INwddq/vx63KHuwFh4irDHeWngF/Bls4QAh1mV4
         azM6dd77lOtn/jpwwdtqyX0CqOlETkTg/RkYPQp9hOxspO/hE+ngT/IxBHkBY5H3nM
         v8YTTemOcFbfA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNrCt4504086;
        Thu, 27 Jun 2019 16:53:12 -0700
Date:   Thu, 27 Jun 2019 16:53:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-49adaa60fa75a04457d30f38321378cdc3547212@git.kernel.org>
Cc:     ashok.raj@intel.com, eranian@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ravi.v.shankar@intel.com, andi.kleen@intel.com, hpa@zytor.com,
        ricardo.neri-calderon@linux.intel.com,
        Suravee.Suthikulpanit@amd.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: ravi.v.shankar@intel.com, Suravee.Suthikulpanit@amd.com,
          ricardo.neri-calderon@linux.intel.com, andi.kleen@intel.com,
          hpa@zytor.com, ashok.raj@intel.com, eranian@google.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190623132436.646565913@linutronix.de>
References: <20190623132436.646565913@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Use common init for legacy clockevent
Git-Commit-ID: 49adaa60fa75a04457d30f38321378cdc3547212
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

Commit-ID:  49adaa60fa75a04457d30f38321378cdc3547212
Gitweb:     https://git.kernel.org/tip/49adaa60fa75a04457d30f38321378cdc3547212
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:08 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:27 +0200

x86/hpet: Use common init for legacy clockevent

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
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132436.646565913@linutronix.de

---
 arch/x86/kernel/hpet.c | 87 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 80497fe5354c..35633e577d21 100644
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
 static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
 	unsigned int channel = clockevent_to_channel(evt)->num;
@@ -430,23 +417,57 @@ static void hpet_init_clockevent(struct hpet_channel *hc, unsigned int rating)
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
-		.set_state_periodic	= hpet_clkevt_set_state_periodic,
-		.set_state_oneshot	= hpet_clkevt_set_state_oneshot,
-		.set_state_shutdown	= hpet_clkevt_set_state_shutdown,
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
+	 * unconditionally forever on the legacy channel 0. Removing the
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
+	hc->evt.set_state_periodic	= hpet_clkevt_set_state_periodic;
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
