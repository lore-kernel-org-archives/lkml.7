Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7E8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15AC215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="cgxmalYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfF1HXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:23:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32958 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfF1HXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:23:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so2528175pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os6v5kxtSuFGC4hWnx1bRsUEHIFTKlc8OCduBbhaPm8=;
        b=cgxmalYA3m0se7S5ZkRgMFsHy01zaDo8RPMlYPoPzZZt8vqkX3fUsFsVpagNskdwwA
         6AXzRQsti2n5+bwPP575z/6YSTZj692BdzDlsYSMRRkwBcAhHQo8jzh3Be0OfMM+c+jg
         QMrRY/55FtB2Rn50Im3oLfSI6MDyvxU/vfg9OBlJfTGmmpXnQFaOoVuuJm3udMLfchPy
         DH4/0TRHFqLk3AuGOXeeN5ohA2hjawJKoWp0XhbYenohegoXtjdLFz93QIlPBbKGozn6
         IUSQnsP4N+85/uGr34BdUOHN7fjojIAnLDv1SJQ3H1VprJZt6OpGkWtSg2c35qvnNXlj
         aPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os6v5kxtSuFGC4hWnx1bRsUEHIFTKlc8OCduBbhaPm8=;
        b=MyBaTtwvCwx1eJI7sMyrVJVXtHlgwC3FzKQw+VGuhk9AVyM2IRiR+hBxWCe4TTaYSM
         CiQQbw71Xcks87UQetxhhbV+8EH8VjWCoDk4OuTQI/mTVfsR5Uh86gM37VT92M5J0xf/
         l6qeaOBrz5clXyhT1Q3t7BReBeEuTJwd7Xu/Z/sZPd51Tzf6Y9KtrWgzjfoLCPWO3kf/
         fKRT1yiaGXcMwmBQHSt2Ld3ed2V1xIHPIhixYD+GdlW3eGgeGllhQKxw8mnURTlWHoYF
         iOuijpmHj4ZGaj6NvIjcU7cVscD+4WAaq6np0SMgdkqd0isSWpJ1IV+mzzahjuohAGNp
         sXTQ==
X-Gm-Message-State: APjAAAUa9KumpGJca+eDgCjcRwcGEcqFyoXCwuzTGKi7f5/LhN2sSrMU
        x5PKSZe5qeXhEiuLrxlFg35WtA==
X-Google-Smtp-Source: APXvYqzganMyJRutz4rpFprnFFiPY+I1s6OJkAj0J8Sh9Z2tYuJ3OQ20cFAPi6QF0vddU9N9JYhOeQ==
X-Received: by 2002:a63:24c1:: with SMTP id k184mr8075062pgk.120.1561706593310;
        Fri, 28 Jun 2019 00:23:13 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id a25sm1240386pfn.1.2019.06.28.00.23.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 00:23:12 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        hdegoede@redhat.com
Subject: [PATCH] x86: skip PIT initialization on modern chipsets
Date:   Fri, 28 Jun 2019 15:23:07 +0800
Message-Id: <20190628072307.24678-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Recent Intel chipsets including Skylake and ApolloLake have
a special ITSSPRC register which allows the 8254 PIT to be gated.
When gated, the 8254 registers can still be programmed as normal, but
there are no IRQ0 timer interrupts.

Some products such as the Connex L1430 and exone go Rugged E11
use this register to ship with the PIT gated by default. This causes
Linux to fail to boot:
  Kernel panic - not syncing: IO-APIC + timer doesn't work! Boot with
  apic=debug and send a report.

The panic happens before the framebuffer is initialized, so to the user,
it appears as an early boot hang on a black screen.

Affected products typically have a BIOS option that can be used
to enable the 8254 and make Linux work (Chipset -> South Cluster
Configuration -> Miscellaneous Configuration -> 8254 Clock Gating),
however it would be best to make Linux support the no-8254 case.

Detect modern setups where we have no need for the PIT (e.g. where
we already know the TSC and LAPIC timer frequencies, so no need
to calibrate them against the PIT), and skip initialization PIT in
such cases.

Skip the IO-APIC timer-checking code when we don't have a PIT
to test against (this was causing the panic).

Tested-by: Daniel Drake <drake@endlessm.com>
---
 arch/x86/include/asm/apic.h    |  2 ++
 arch/x86/include/asm/time.h    |  1 +
 arch/x86/kernel/apic/apic.c    | 27 +++++++++++++++++++++++++++
 arch/x86/kernel/apic/io_apic.c |  4 ++++
 arch/x86/kernel/i8253.c        | 25 ++++++++++++++++++++++++-
 arch/x86/kernel/time.c         |  7 +++++--
 6 files changed, 63 insertions(+), 3 deletions(-)

Thomas, please add your sign off before pushing.

Depends on commits in tip.git x86/apic
  x86/tsc: Use CPUID.0x16 to calculate missing crystal frequency
  x86/apic: Rename 'lapic_timer_frequency' to 'lapic_timer_period'
  x86/tsc: Set LAPIC timer period to crystal clock frequency

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 71026eba9ba4..3e66b82454ce 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -175,6 +175,7 @@ extern void lapic_assign_system_vectors(void);
 extern void lapic_assign_legacy_vector(unsigned int isairq, bool replace);
 extern void lapic_online(void);
 extern void lapic_offline(void);
+extern bool apic_needs_pit(void);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
@@ -188,6 +189,7 @@ static inline void init_bsp_APIC(void) { }
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
index 8956072f677d..abe67c3ae071 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -821,6 +821,33 @@ static int __init lapic_init_clockevent(void)
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
 
-- 
2.20.1

