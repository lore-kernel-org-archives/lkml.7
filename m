Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7AEC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15212086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 09:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Srh27hRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfF2Jk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 05:40:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2Jk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 05:40:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5T9eFN41205664
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 29 Jun 2019 02:40:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5T9eFN41205664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561801216;
        bh=I1MdbWNoSFKVgWvSh0HN/d8554BKyri7YL8G+n+ur+A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Srh27hRgD3GqlQINHegeGN1Flg57/lBG3WetmzHrsHl6I3lnl6h0O4qngzkX2TKz+
         XHh6IXht5iAZwjZwXDi9OYcqU75jg53DUKZwfXpAQ8cvqvDzdOHwRZkm5DucXBlkNu
         tqqoam07I/bc5XiTKzcHKv7GTv/k/DMvcO5ocHySloWfgx3/AaK0PGMC5ztjDRwrHE
         iGnbGAMj1wZ9K2iQb5d8y28dmxOtuiXpOxTlDwT+wVMFo69Jlmvb2j7V+to4+MAT/o
         jPi8gEm8Gi4wAhJkZ3zuhcDpOw7MTusy1dvQBAqm1ho7Zl1c/ZqyhaRVAw73nDe37Y
         LkQjLRe7h07nQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5T9eF2g1205661;
        Sat, 29 Jun 2019 02:40:15 -0700
Date:   Sat, 29 Jun 2019 02:40:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c8c4076723daca08bf35ccd68f22ea1c6219e207@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        drake@endlessm.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, drake@endlessm.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190628072307.24678-1-drake@endlessm.com>
References: <20190628072307.24678-1-drake@endlessm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/timer: Skip PIT initialization on modern
 chipsets
Git-Commit-ID: c8c4076723daca08bf35ccd68f22ea1c6219e207
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

Commit-ID:  c8c4076723daca08bf35ccd68f22ea1c6219e207
Gitweb:     https://git.kernel.org/tip/c8c4076723daca08bf35ccd68f22ea1c6219e207
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 28 Jun 2019 15:23:07 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 29 Jun 2019 11:35:35 +0200

x86/timer: Skip PIT initialization on modern chipsets

Recent Intel chipsets including Skylake and ApolloLake have a special
ITSSPRC register which allows the 8254 PIT to be gated.  When gated, the
8254 registers can still be programmed as normal, but there are no IRQ0
timer interrupts.

Some products such as the Connex L1430 and exone go Rugged E11 use this
register to ship with the PIT gated by default. This causes Linux to fail
to boot:

  Kernel panic - not syncing: IO-APIC + timer doesn't work! Boot with
  apic=debug and send a report.

The panic happens before the framebuffer is initialized, so to the user, it
appears as an early boot hang on a black screen.

Affected products typically have a BIOS option that can be used to enable
the 8254 and make Linux work (Chipset -> South Cluster Configuration ->
Miscellaneous Configuration -> 8254 Clock Gating), however it would be best
to make Linux support the no-8254 case.

Modern sytems allow to discover the TSC and local APIC timer frequencies,
so the calibration against the PIT is not required. These systems have
always running timers and the local APIC timer works also in deep power
states.

So the setup of the PIT including the IO-APIC timer interrupt delivery
checks are a pointless exercise.

Skip the PIT setup and the IO-APIC timer interrupt checks on these systems,
which avoids the panic caused by non ticking PITs and also speeds up the
boot process.

Thanks to Daniel for providing the changelog, initial analysis of the
problem and testing against a variety of machines.

Reported-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Drake <drake@endlessm.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: linux@endlessm.com
Cc: rafael.j.wysocki@intel.com
Cc: hdegoede@redhat.com
Link: https://lkml.kernel.org/r/20190628072307.24678-1-drake@endlessm.com

---
 arch/x86/include/asm/apic.h    |  2 ++
 arch/x86/include/asm/time.h    |  1 +
 arch/x86/kernel/apic/apic.c    | 27 +++++++++++++++++++++++++++
 arch/x86/kernel/apic/io_apic.c |  4 ++++
 arch/x86/kernel/i8253.c        | 25 ++++++++++++++++++++++++-
 arch/x86/kernel/time.c         |  7 +++++--
 6 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index c986e32b5a48..693a0ad56019 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -173,6 +173,7 @@ extern void lapic_assign_system_vectors(void);
 extern void lapic_assign_legacy_vector(unsigned int isairq, bool replace);
 extern void lapic_online(void);
 extern void lapic_offline(void);
+extern bool apic_needs_pit(void);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
@@ -186,6 +187,7 @@ static inline void init_bsp_APIC(void) { }
 static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
+static inline bool apic_needs_pit(void) { return true; }
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index cef818b16045..8ac563abb567 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -7,6 +7,7 @@
 
 extern void hpet_time_init(void);
 extern void time_init(void);
+extern bool pit_timer_init(void);
 
 extern struct clock_event_device *global_clock_event;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index dc4ed655dbbb..29fd50840b55 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -820,6 +820,33 @@ static int __init lapic_init_clockevent(void)
 	return 0;
 }
 
+bool __init apic_needs_pit(void)
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
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 53aa234a6803..1bb864798800 100644
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
@@ -2083,6 +2084,9 @@ static inline void __init check_timer(void)
 	unsigned long flags;
 	int no_pin1 = 0;
 
+	if (!global_clock_event)
+		return;
+
 	local_irq_save(flags);
 
 	/*
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 0d307a657abb..2b7999a1a50a 100644
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
+{
+	if (!IS_ENABLED(CONFIG_X86_TSC) || !boot_cpu_has(X86_FEATURE_TSC))
+		return true;
+
+	/* This also returns true when APIC is disabled */
+	return apic_needs_pit();
+}
+
+bool __init pit_timer_init(void)
 {
+	if (!use_pit())
+		return false;
+
 	clockevent_i8253_init(true);
 	global_clock_event = &i8253_clockevent;
+	return true;
 }
 
 #ifndef CONFIG_X86_64
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 0e14f6c0d35e..07c0e960b3f3 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -82,8 +82,11 @@ static void __init setup_default_timer_irq(void)
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
 
