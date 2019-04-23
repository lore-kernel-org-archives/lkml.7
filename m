Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B785C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF73220811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="GlEoWK9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfDWFEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:04:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46464 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWFEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:04:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id o7so4633789pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 22:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cq9SP6pEbkoal2PE9KzLdz7lVdX/TGPd0facXgR0s7k=;
        b=GlEoWK9iM8C1gtC25Dx9AgJU2JkRr/sw/aNLNRL8GXKLj0VrkMdPpYELF2/c3onhof
         XsarAxl+poUttuN7ZgCfJS3PJKtYKNv7Ir4lLcdUki9sfwFt+KO8pUp1ChpO7ICsAtbV
         JzFicL09o6/gHz/9EcYupqnd7Ib3EZ3SXCwfJrm0PO/aYru7JRieXNtcRd/czmWK9GcP
         NbscSauub6WjWW12xoe4tUZhn8UIBuJOV5NDPX/QKjvqS/ZGsLeqpc2hwFOq5Sk+lmCQ
         qIRoI2zTmJr8lzoLEPvBosRoPQtDPPhAkolZuBLfUA3+FD9+QZa+38GywMxL7TBPSk7H
         RCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cq9SP6pEbkoal2PE9KzLdz7lVdX/TGPd0facXgR0s7k=;
        b=lG3vliuBv0iYOCZQ+LH1UxJ5ac/IpuAI1GnFRSrZJenFglrEvAFuzkpRw0UIURyMQr
         eP7uJYgx2m0j1B/jMoGx01zOXtnx/GrESR0OaD7ETD8Pp0qKM9Fpd6oBmGqrRQrT9faE
         8IKaZdBX2uhTkZOcxX9z1ypA7xOdzIs8D/OZ9V4FLpcjgCtC5npN1ymyqIeDh3f6pLdc
         q0sJHGrz/H0eS1FiCdU/POvFDHyGAeC8EY9bilEr9F3BLw9n17R4o8D3f0w9lQJ1e8YI
         lEgV8dP9wdIhLM7kNTeAZ2dzYkteaaHi3lH2c/ORq9k2Nn08+nW3CPFkw5veCOUtKyZT
         zo1A==
X-Gm-Message-State: APjAAAXvXpyhzZwfPFwPoevP4I/t4Gkq2Be2oBtvpHxOq59boXrUxqva
        cSVsYxrL/EHaAJPSwidnoKS+5g==
X-Google-Smtp-Source: APXvYqyb0A+RISSHfDXO7XZjPgL7NfFal/JNpshswrX9XkVs349FkcK1y0MWEcWWhrQwsdFVcZkAgQ==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr24853685plp.179.1555995840988;
        Mon, 22 Apr 2019 22:04:00 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id f71sm25880669pfc.109.2019.04.22.22.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 22:04:00 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com,
        linux@endlessm.com, hdegoede@redhat.com
Subject: [PATCH 1/2] x86/time: check usability of IRQ0 PIT timer
Date:   Tue, 23 Apr 2019 13:03:53 +0800
Message-Id: <20190423050354.8025-1-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern Intel SoCs now include a special ITSSPRC register that can be
used to "gate" the PIT such that IRQ0 interrupts do not fire.

With Intel Apollo Lake we are starting to see consumer products that
have a BIOS option to apply this (defaulting to gated). Some such
products also lack the HPET ACPI table, so there is no HPET either.

At this point, Linux needs to stop assuming that the IRQ0 timer is
available.

Move APIC code to check IRQ0 to time.c, then check and record the IRQ0
PIT timer usability after it is set up. If it does not produce any
interrupts, unregister the clock event source.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Link: https://lkml.kernel.org/r/CAD8Lp45fedoPLnK=UmUhhtkjy5u2h04sYKrx3U+m04U6FpVZ4A@mail.gmail.com
---
 arch/x86/include/asm/time.h    |   2 +
 arch/x86/kernel/apic/io_apic.c | 101 ++++---------------------------
 arch/x86/kernel/i8253.c        |   6 ++
 arch/x86/kernel/time.c         | 106 ++++++++++++++++++++++++++++++++-
 drivers/clocksource/i8253.c    |   6 ++
 include/linux/clockchips.h     |   3 +
 include/linux/i8253.h          |   2 +
 kernel/time/tick-internal.h    |   2 -
 8 files changed, 134 insertions(+), 94 deletions(-)

diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
index cef818b16045..e6e00d18b39f 100644
--- a/arch/x86/include/asm/time.h
+++ b/arch/x86/include/asm/time.h
@@ -10,4 +10,6 @@ extern void time_init(void);
 
 extern struct clock_event_device *global_clock_event;
 
+extern bool irq0_timer_works(void);
+
 #endif /* _ASM_X86_TIME_H */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 53aa234a6803..ae46da48c07b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -57,6 +57,7 @@
 #include <asm/proto.h>
 #include <asm/acpi.h>
 #include <asm/dma.h>
+#include <asm/time.h>
 #include <asm/timer.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
@@ -1573,92 +1574,6 @@ void __init setup_ioapic_ids_from_mpc(void)
 }
 #endif
 
-int no_timer_check __initdata;
-
-static int __init notimercheck(char *s)
-{
-	no_timer_check = 1;
-	return 1;
-}
-__setup("no_timer_check", notimercheck);
-
-static void __init delay_with_tsc(void)
-{
-	unsigned long long start, now;
-	unsigned long end = jiffies + 4;
-
-	start = rdtsc();
-
-	/*
-	 * We don't know the TSC frequency yet, but waiting for
-	 * 40000000000/HZ TSC cycles is safe:
-	 * 4 GHz == 10 jiffies
-	 * 1 GHz == 40 jiffies
-	 */
-	do {
-		rep_nop();
-		now = rdtsc();
-	} while ((now - start) < 40000000000ULL / HZ &&
-		time_before_eq(jiffies, end));
-}
-
-static void __init delay_without_tsc(void)
-{
-	unsigned long end = jiffies + 4;
-	int band = 1;
-
-	/*
-	 * We don't know any frequency yet, but waiting for
-	 * 40940000000/HZ cycles is safe:
-	 * 4 GHz == 10 jiffies
-	 * 1 GHz == 40 jiffies
-	 * 1 << 1 + 1 << 2 +...+ 1 << 11 = 4094
-	 */
-	do {
-		__delay(((1U << band++) * 10000000UL) / HZ);
-	} while (band < 12 && time_before_eq(jiffies, end));
-}
-
-/*
- * There is a nasty bug in some older SMP boards, their mptable lies
- * about the timer IRQ. We do the following to work around the situation:
- *
- *	- timer IRQ defaults to IO-APIC IRQ
- *	- if this function detects that timer IRQs are defunct, then we fall
- *	  back to ISA timer IRQs
- */
-static int __init timer_irq_works(void)
-{
-	unsigned long t1 = jiffies;
-	unsigned long flags;
-
-	if (no_timer_check)
-		return 1;
-
-	local_save_flags(flags);
-	local_irq_enable();
-
-	if (boot_cpu_has(X86_FEATURE_TSC))
-		delay_with_tsc();
-	else
-		delay_without_tsc();
-
-	local_irq_restore(flags);
-
-	/*
-	 * Expect a few ticks at least, to be sure some possible
-	 * glue logic does not lock up after one or two first
-	 * ticks in a non-ExtINT mode.  Also the local APIC
-	 * might have cached one ExtINT interrupt.  Finally, at
-	 * least one tick may be lost due to delays.
-	 */
-
-	/* jiffies wrap? */
-	if (time_after(jiffies, t1 + 4))
-		return 1;
-	return 0;
-}
-
 /*
  * In the SMP+IOAPIC case it might happen that there are an unspecified
  * number of pending IRQ events unhandled. These cases are very rare,
@@ -2066,6 +1981,12 @@ static int mp_alloc_timer_irq(int ioapic, int pin)
 }
 
 /*
+ * In the SMP+IOAPIC case it might happen that there are an unspecified
+ * number of pending IRQ events unhandled. These cases are very rare,
+ * so we 'resend' these IRQs via IPIs, to the same CPU. It's much
+ * better to do it this way as thus we do not have to be aware of
+ * 'pending' interrupts in the IRQ path, except at this point.
+ *
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
  * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
@@ -2145,7 +2066,7 @@ static inline void __init check_timer(void)
 		}
 		irq_domain_deactivate_irq(irq_data);
 		irq_domain_activate_irq(irq_data, false);
-		if (timer_irq_works()) {
+		if (irq0_timer_works()) {
 			if (disable_timer_pin_1 > 0)
 				clear_IO_APIC_pin(0, pin1);
 			goto out;
@@ -2168,7 +2089,7 @@ static inline void __init check_timer(void)
 		irq_domain_deactivate_irq(irq_data);
 		irq_domain_activate_irq(irq_data, false);
 		legacy_pic->unmask(0);
-		if (timer_irq_works()) {
+		if (irq0_timer_works()) {
 			apic_printk(APIC_QUIET, KERN_INFO "....... works.\n");
 			goto out;
 		}
@@ -2188,7 +2109,7 @@ static inline void __init check_timer(void)
 	apic_write(APIC_LVT0, APIC_DM_FIXED | cfg->vector);	/* Fixed mode */
 	legacy_pic->unmask(0);
 
-	if (timer_irq_works()) {
+	if (irq0_timer_works()) {
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
@@ -2206,7 +2127,7 @@ static inline void __init check_timer(void)
 
 	unlock_ExtINT_logic();
 
-	if (timer_irq_works()) {
+	if (irq0_timer_works()) {
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 0d307a657abb..0115ebff38f5 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -24,6 +24,12 @@ void __init setup_pit_timer(void)
 	global_clock_event = &i8253_clockevent;
 }
 
+void __init remove_pit_timer(void)
+{
+	clockevent_i8253_exit();
+	global_clock_event = NULL;
+}
+
 #ifndef CONFIG_X86_64
 static int __init init_pit_clocksource(void)
 {
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 0e14f6c0d35e..abf634d391eb 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -25,6 +25,15 @@
 #include <asm/hpet.h>
 #include <asm/time.h>
 
+int no_timer_check __initdata;
+
+static int __init notimercheck(char *s)
+{
+	no_timer_check = 1;
+	return 1;
+}
+__setup("no_timer_check", notimercheck);
+
 #ifdef CONFIG_X86_64
 __visible volatile unsigned long jiffies __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 #endif
@@ -54,6 +63,77 @@ unsigned long profile_pc(struct pt_regs *regs)
 }
 EXPORT_SYMBOL(profile_pc);
 
+static void __init delay_with_tsc(void)
+{
+	unsigned long long start, now;
+	unsigned long end = jiffies + 4;
+
+	start = rdtsc();
+
+	/*
+	 * We don't know the TSC frequency yet, but waiting for
+	 * 40000000000/HZ TSC cycles is safe:
+	 * 4 GHz == 10 jiffies
+	 * 1 GHz == 40 jiffies
+	 */
+	do {
+		rep_nop();
+		now = rdtsc();
+	} while ((now - start) < 40000000000ULL / HZ &&
+		time_before_eq(jiffies, end));
+}
+
+static void __init delay_without_tsc(void)
+{
+	unsigned long end = jiffies + 4;
+	int band = 1;
+
+	/*
+	 * We don't know any frequency yet, but waiting for
+	 * 40940000000/HZ cycles is safe:
+	 * 4 GHz == 10 jiffies
+	 * 1 GHz == 40 jiffies
+	 * 1 << 1 + 1 << 2 +...+ 1 << 11 = 4094
+	 */
+	do {
+		__delay(((1U << band++) * 10000000UL) / HZ);
+	} while (band < 12 && time_before_eq(jiffies, end));
+}
+
+/*
+ * Test if the IRQ0 timer is working by delaying a short while and
+ * checking that jiffies has incremented.
+ */
+bool __init irq0_timer_works(void)
+{
+	unsigned long t1 = jiffies;
+	unsigned long flags;
+
+	if (no_timer_check)
+		return true;
+
+	local_save_flags(flags);
+	local_irq_enable();
+
+	if (boot_cpu_has(X86_FEATURE_TSC))
+		delay_with_tsc();
+	else
+		delay_without_tsc();
+
+	local_irq_restore(flags);
+
+	/*
+	 * Expect a few ticks at least, to be sure some possible
+	 * glue logic does not lock up after one or two first
+	 * ticks in a non-ExtINT mode.  Also the local APIC
+	 * might have cached one ExtINT interrupt.  Finally, at
+	 * least one tick may be lost due to delays.
+	 */
+
+	/* jiffies wrap? */
+	return time_after(jiffies, t1 + 4);
+}
+
 /*
  * Default timer interrupt handler for PIT/HPET
  */
@@ -79,12 +159,34 @@ static void __init setup_default_timer_irq(void)
 		pr_info("Failed to register legacy timer interrupt\n");
 }
 
+static void __init remove_default_timer_irq(void)
+{
+	remove_irq(0, &irq0);
+}
+
 /* Default timer init function */
 void __init hpet_time_init(void)
 {
-	if (!hpet_enable())
-		setup_pit_timer();
+	if (hpet_enable()) {
+		setup_default_timer_irq();
+		return;
+	}
+
+	/* Fall back on legacy 8253 PIT */
+	setup_pit_timer();
 	setup_default_timer_irq();
+
+	/*
+	 * Intel SoCs like ApolloLake, Skylake and newer can have
+	 * their PIT "gated" by the BIOS such that IRQ0 does not
+	 * tick. Check for that situation here.
+	 */
+	if (!irq0_timer_works()) {
+		pr_info("HPET is not available, and 8253 timer is not working. "
+			"Continuing without IRQ0 timer.\n");
+		remove_default_timer_irq();
+		remove_pit_timer();
+	}
 }
 
 static __init void x86_late_time_init(void)
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index d4350bb10b83..4ca4bb44f6dd 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -193,4 +193,10 @@ void __init clockevent_i8253_init(bool oneshot)
 	clockevents_config_and_register(&i8253_clockevent, PIT_TICK_RATE,
 					0xF, 0x7FFF);
 }
+
+void __init clockevent_i8253_exit(void)
+{
+	clockevents_switch_state(&i8253_clockevent, CLOCK_EVT_STATE_DETACHED);
+	clockevents_unbind_device(&i8253_clockevent, smp_processor_id());
+}
 #endif
diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 8ae9a95ebf5b..c54d20272e8c 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -187,6 +187,9 @@ extern void clockevents_config_and_register(struct clock_event_device *dev,
 					    u32 freq, unsigned long min_delta,
 					    unsigned long max_delta);
 
+extern void clockevents_switch_state(struct clock_event_device *dev,
+				     enum clock_event_state state);
+
 extern int clockevents_update_freq(struct clock_event_device *ce, u32 freq);
 
 static inline void
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f6f834..55e620eabd36 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -24,7 +24,9 @@ extern raw_spinlock_t i8253_lock;
 extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
+extern void clockevent_i8253_exit(void);
 
 extern void setup_pit_timer(void);
+extern void remove_pit_timer(void);
 
 #endif /* __LINUX_I8253_H */
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index e277284c2831..00a74a8fd8f2 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -51,8 +51,6 @@ static inline void clockevent_set_state(struct clock_event_device *dev,
 extern void clockevents_shutdown(struct clock_event_device *dev);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
-extern void clockevents_switch_state(struct clock_event_device *dev,
-				     enum clock_event_state state);
 extern int clockevents_program_event(struct clock_event_device *dev,
 				     ktime_t expires, bool force);
 extern void clockevents_handle_noop(struct clock_event_device *dev);
-- 
2.19.1

