Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B852C48BE4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099BD20665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfFWN2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33558 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfFWN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X9-0001mh-5l; Sun, 23 Jun 2019 15:27:51 +0200
Message-Id: <20190623132436.277510163@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 24/29] x86/hpet: Use cached info instead of extra flags
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that HPET clockevent support is integrated into the channel data, reuse
the cached boot configuration instead of copying the same information into
a flags field.

This also allows to consolidate the reservation code into one place, which
can now solely depend on the mode information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   76 ++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -25,8 +25,8 @@ struct hpet_channel {
 	unsigned int			num;
 	unsigned int			cpu;
 	unsigned int			irq;
+	unsigned int			inuse;
 	enum hpet_mode			mode;
-	unsigned int			flags;
 	unsigned int			boot_cfg;
 	char				name[10];
 };
@@ -40,12 +40,6 @@ struct hpet_base {
 
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
-#define HPET_DEV_USED_BIT		2
-#define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
-#define HPET_DEV_VALID			0x8
-#define HPET_DEV_FSB_CAP		0x1000
-#define HPET_DEV_PERI_CAP		0x2000
-
 #define HPET_MIN_CYCLES			128
 #define HPET_MIN_PROG_DELTA		(HPET_MIN_CYCLES + (HPET_MIN_CYCLES >> 1))
 
@@ -62,6 +56,7 @@ static struct irq_domain		*hpet_domain;
 #endif
 
 static void __iomem			*hpet_virt_address;
+
 static struct hpet_base			hpet_base;
 
 static bool				hpet_legacy_int_enabled;
@@ -190,8 +185,6 @@ do {								\
  */
 #ifdef CONFIG_HPET
 
-static void hpet_reserve_msi_timers(struct hpet_data *hd);
-
 static void __init hpet_reserve_platform_timers(void)
 {
 	struct hpet_data hd;
@@ -201,11 +194,6 @@ static void __init hpet_reserve_platform
 	hd.hd_phys_address	= hpet_address;
 	hd.hd_address		= hpet_virt_address;
 	hd.hd_nirqs		= hpet_base.nr_channels;
-	hpet_reserve_timer(&hd, 0);
-
-#ifdef CONFIG_HPET_EMULATE_RTC
-	hpet_reserve_timer(&hd, 1);
-#endif
 
 	/*
 	 * NOTE that hd_irq[] reflects IOAPIC input pins (LEGACY_8254
@@ -215,13 +203,25 @@ static void __init hpet_reserve_platform
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < hpet_base.nr_channels; i++)
-		hd.hd_irq[i] = hpet_base.channels[i].irq;
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
 
-	hpet_reserve_msi_timers(&hd);
+		if (i >= 2)
+			hd.hd_irq[i] = hc->irq;
 
-	hpet_alloc(&hd);
+		switch (hc->mode) {
+		case HPET_MODE_UNUSED:
+		case HPET_MODE_DEVICE:
+			hc->mode = HPET_MODE_DEVICE;
+			break;
+		case HPET_MODE_CLOCKEVT:
+		case HPET_MODE_LEGACY:
+			hpet_reserve_timer(&hd, hc->num);
+			break;
+		}
+	}
 
+	hpet_alloc(&hd);
 }
 
 static void __init hpet_select_device_channel(void)
@@ -543,13 +543,11 @@ static int hpet_setup_irq(struct hpet_ch
 	return 0;
 }
 
+/* Invoked from the hotplug callback on @cpu */
 static void init_one_hpet_msi_clockevent(struct hpet_channel *hc, int cpu)
 {
 	struct clock_event_device *evt = &hc->evt;
 
-	if (!(hc->flags & HPET_DEV_VALID))
-		return;
-
 	hc->cpu = cpu;
 	per_cpu(cpu_hpet_channel, cpu) = hc;
 	evt->name = hc->name;
@@ -558,7 +556,7 @@ static void init_one_hpet_msi_clockevent
 
 	evt->rating = 110;
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	if (hc->flags & HPET_DEV_PERI_CAP) {
+	if (hc->boot_cfg & HPET_TN_PERIODIC) {
 		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
 		evt->set_state_periodic = hpet_msi_set_periodic;
 	}
@@ -580,11 +578,9 @@ static struct hpet_channel *hpet_get_unu
 	for (i = 0; i < hpet_base.nr_channels; i++) {
 		struct hpet_channel *hc = hpet_base.channels + i;
 
-		if (!(hc->flags & HPET_DEV_VALID))
-			continue;
-		if (test_and_set_bit(HPET_DEV_USED_BIT,
-			(unsigned long *)&hc->flags))
+		if (hc->mode != HPET_MODE_CLOCKEVT || hc->inuse)
 			continue;
+		hc->inuse = 1;
 		return hc;
 	}
 	return NULL;
@@ -606,7 +602,7 @@ static int hpet_cpuhp_dead(unsigned int
 	if (!hc)
 		return 0;
 	free_irq(hc->irq, hc);
-	hc->flags &= ~HPET_DEV_USED;
+	hc->inuse = 0;
 	per_cpu(cpu_hpet_channel, cpu) = NULL;
 	return 0;
 }
@@ -638,9 +634,6 @@ static void __init hpet_select_clockeven
 		if (!(hc->boot_cfg & HPET_TN_FSB_CAP))
 			continue;
 
-		hc->flags = 0;
-		if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
-			hc->flags |= HPET_DEV_PERI_CAP;
 		sprintf(hc->name, "hpet%d", i);
 
 		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
@@ -648,8 +641,6 @@ static void __init hpet_select_clockeven
 			continue;
 
 		hc->irq = irq;
-		hc->flags |= HPET_DEV_FSB_CAP;
-		hc->flags |= HPET_DEV_VALID;
 		hc->mode = HPET_MODE_CLOCKEVT;
 
 		if (++hpet_base.nr_clockevents == num_possible_cpus())
@@ -660,31 +651,10 @@ static void __init hpet_select_clockeven
 		hpet_base.nr_channels, hpet_base.nr_clockevents);
 }
 
-#ifdef CONFIG_HPET
-static void __init hpet_reserve_msi_timers(struct hpet_data *hd)
-{
-	int i;
-
-	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_channel *hc = hpet_base.channels + i;
-
-		if (!(hc->flags & HPET_DEV_VALID))
-			continue;
-
-		hd->hd_irq[hc->num] = hc->irq;
-		hpet_reserve_timer(hd, hc->num);
-	}
-}
-#endif
-
 #else
 
 static inline void hpet_select_clockevents(void) { }
 
-#ifdef CONFIG_HPET
-static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
-#endif
-
 #define hpet_cpuhp_online	NULL
 #define hpet_cpuhp_dead		NULL
 


