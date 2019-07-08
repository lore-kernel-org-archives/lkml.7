Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FFC606A8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AFF20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfGHJWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:22:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfGHJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:22:48 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkPr8-0004po-0y; Mon, 08 Jul 2019 11:22:42 +0200
Date:   Mon, 08 Jul 2019 09:05:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/timers for 5.3-rc1
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
Message-ID: <156257673796.14831.2745414267646810295.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-timers-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-for-linus

up to:  e44252f4fe79: x86/hpet: Use channel for legacy clockevent storage

A rather large series consolidating the HPET code, which was triggered by
the attempt to bolt HPET NMI watchdog support on to the existing maze with
the usual duct tape and super glue approach.

This mainly removes two separate partially redundant storage layers and
consolidates them into a single one which provides a consistent view of the
different HPET channels and their usage and allows to integrate HPET NMI
watchdog support (if it turns out to be feasible) in a non intrusive way.

Thanks,

	tglx

------------------>
Ingo Molnar (5):
      x86/hpet: Remove not required includes
      x86/hpet: Make naming consistent
      x86/hpet: Clean up comments
      x86/hpet: Coding style cleanup
      x86/hpet: Rename variables to prepare for switching to channels

Thomas Gleixner (24):
      x86/hpet: Simplify CPU online code
      x86/hpet: Replace printk(KERN...) with pr_...()
      x86/hpet: Restructure init code
      x86/hpet: Remove pointless x86-64 specific #include
      x86/hpet: Remove unused parameter from hpet_next_event()
      x86/hpet: Remove the unused hpet_msi_read() function
      x86/hpet: Mark init functions __init
      x86/hpet: Sanitize stub functions
      x86/hpet: Move static and global variables to one place
      x86/hpet: Shuffle code around for readability sake
      x86/hpet: Separate counter check out of clocksource register code
      x86/hpet: Simplify counter validation
      x86/hpet: Decapitalize and rename EVT_TO_HPET_DEV
      x86/hpet: Introduce struct hpet_base and struct hpet_channel
      x86/hpet: Use cached channel data
      x86/hpet: Add mode information to struct hpet_channel
      x86/hpet: Add function to select a /dev/hpet channel
      x86/hpet: Move clockevents into channels
      x86/hpet: Use cached info instead of extra flags
      x86/hpet: Wrap legacy clockevent in hpet_channel
      x86/hpet: Consolidate clockevent functions
      x86/hpet: Carve out shareable parts of init_one_hpet_msi_clockevent()
      x86/hpet: Use common init for legacy clockevent
      x86/hpet: Use channel for legacy clockevent storage


 arch/x86/include/asm/hpet.h |   7 +-
 arch/x86/kernel/apic/msi.c  |   4 +-
 arch/x86/kernel/hpet.c      | 935 ++++++++++++++++++++------------------------
 3 files changed, 427 insertions(+), 519 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 67385d56d4f4..6352dee37cda 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -75,16 +75,15 @@ extern unsigned int hpet_readl(unsigned int a);
 extern void force_hpet_resume(void);
 
 struct irq_data;
-struct hpet_dev;
+struct hpet_channel;
 struct irq_domain;
 
 extern void hpet_msi_unmask(struct irq_data *data);
 extern void hpet_msi_mask(struct irq_data *data);
-extern void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg);
-extern void hpet_msi_read(struct hpet_dev *hdev, struct msi_msg *msg);
+extern void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg);
 extern struct irq_domain *hpet_create_irq_domain(int hpet_id);
 extern int hpet_assign_irq(struct irq_domain *domain,
-			   struct hpet_dev *dev, int dev_num);
+			   struct hpet_channel *hc, int dev_num);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index dad0dd759de2..7f7533462474 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -370,14 +370,14 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
 	return d;
 }
 
-int hpet_assign_irq(struct irq_domain *domain, struct hpet_dev *dev,
+int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
 		    int dev_num)
 {
 	struct irq_alloc_info info;
 
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_HPET;
-	info.hpet_data = dev;
+	info.hpet_data = hc;
 	info.hpet_id = hpet_dev_id(domain);
 	info.hpet_index = dev_num;
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index a0573f2e7763..c43e96a938d0 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1,32 +1,44 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/i8253.h>
-#include <linux/slab.h>
 #include <linux/hpet.h>
-#include <linux/init.h>
 #include <linux/cpu.h>
-#include <linux/pm.h>
-#include <linux/io.h>
+#include <linux/irq.h>
 
-#include <asm/cpufeature.h>
-#include <asm/irqdomain.h>
-#include <asm/fixmap.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 
-#define HPET_MASK			CLOCKSOURCE_MASK(32)
+#undef  pr_fmt
+#define pr_fmt(fmt) "hpet: " fmt
 
-#define HPET_DEV_USED_BIT		2
-#define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
-#define HPET_DEV_VALID			0x8
-#define HPET_DEV_FSB_CAP		0x1000
-#define HPET_DEV_PERI_CAP		0x2000
+enum hpet_mode {
+	HPET_MODE_UNUSED,
+	HPET_MODE_LEGACY,
+	HPET_MODE_CLOCKEVT,
+	HPET_MODE_DEVICE,
+};
+
+struct hpet_channel {
+	struct clock_event_device	evt;
+	unsigned int			num;
+	unsigned int			cpu;
+	unsigned int			irq;
+	unsigned int			in_use;
+	enum hpet_mode			mode;
+	unsigned int			boot_cfg;
+	char				name[10];
+};
+
+struct hpet_base {
+	unsigned int			nr_channels;
+	unsigned int			nr_clockevents;
+	unsigned int			boot_cfg;
+	struct hpet_channel		*channels;
+};
+
+#define HPET_MASK			CLOCKSOURCE_MASK(32)
 
 #define HPET_MIN_CYCLES			128
 #define HPET_MIN_PROG_DELTA		(HPET_MIN_CYCLES + (HPET_MIN_CYCLES >> 1))
@@ -39,22 +51,25 @@ u8					hpet_blockid; /* OS timer block num */
 bool					hpet_msi_disable;
 
 #ifdef CONFIG_PCI_MSI
-static unsigned int			hpet_num_timers;
+static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
+static struct irq_domain		*hpet_domain;
 #endif
+
 static void __iomem			*hpet_virt_address;
 
-struct hpet_dev {
-	struct clock_event_device	evt;
-	unsigned int			num;
-	int				cpu;
-	unsigned int			irq;
-	unsigned int			flags;
-	char				name[10];
-};
+static struct hpet_base			hpet_base;
+
+static bool				hpet_legacy_int_enabled;
+static unsigned long			hpet_freq;
 
-static inline struct hpet_dev *EVT_TO_HPET_DEV(struct clock_event_device *evtdev)
+bool					boot_hpet_disable;
+bool					hpet_force_user;
+static bool				hpet_verbose;
+
+static inline
+struct hpet_channel *clockevent_to_channel(struct clock_event_device *evt)
 {
-	return container_of(evtdev, struct hpet_dev, evt);
+	return container_of(evt, struct hpet_channel, evt);
 }
 
 inline unsigned int hpet_readl(unsigned int a)
@@ -67,10 +82,6 @@ static inline void hpet_writel(unsigned int d, unsigned int a)
 	writel(d, hpet_virt_address + a);
 }
 
-#ifdef CONFIG_X86_64
-#include <asm/pgtable.h>
-#endif
-
 static inline void hpet_set_mapping(void)
 {
 	hpet_virt_address = ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
@@ -85,10 +96,6 @@ static inline void hpet_clear_mapping(void)
 /*
  * HPET command line enable / disable
  */
-bool boot_hpet_disable;
-bool hpet_force_user;
-static bool hpet_verbose;
-
 static int __init hpet_setup(char *str)
 {
 	while (str) {
@@ -120,13 +127,8 @@ static inline int is_hpet_capable(void)
 	return !boot_hpet_disable && hpet_address;
 }
 
-/*
- * HPET timer interrupt enable / disable
- */
-static bool hpet_legacy_int_enabled;
-
 /**
- * is_hpet_enabled - check whether the hpet timer interrupt is enabled
+ * is_hpet_enabled - Check whether the legacy HPET timer interrupt is enabled
  */
 int is_hpet_enabled(void)
 {
@@ -136,32 +138,36 @@ EXPORT_SYMBOL_GPL(is_hpet_enabled);
 
 static void _hpet_print_config(const char *function, int line)
 {
-	u32 i, timers, l, h;
-	printk(KERN_INFO "hpet: %s(%d):\n", function, line);
-	l = hpet_readl(HPET_ID);
-	h = hpet_readl(HPET_PERIOD);
-	timers = ((l & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
-	printk(KERN_INFO "hpet: ID: 0x%x, PERIOD: 0x%x\n", l, h);
-	l = hpet_readl(HPET_CFG);
-	h = hpet_readl(HPET_STATUS);
-	printk(KERN_INFO "hpet: CFG: 0x%x, STATUS: 0x%x\n", l, h);
+	u32 i, id, period, cfg, status, channels, l, h;
+
+	pr_info("%s(%d):\n", function, line);
+
+	id = hpet_readl(HPET_ID);
+	period = hpet_readl(HPET_PERIOD);
+	pr_info("ID: 0x%x, PERIOD: 0x%x\n", id, period);
+
+	cfg = hpet_readl(HPET_CFG);
+	status = hpet_readl(HPET_STATUS);
+	pr_info("CFG: 0x%x, STATUS: 0x%x\n", cfg, status);
+
 	l = hpet_readl(HPET_COUNTER);
 	h = hpet_readl(HPET_COUNTER+4);
-	printk(KERN_INFO "hpet: COUNTER_l: 0x%x, COUNTER_h: 0x%x\n", l, h);
+	pr_info("COUNTER_l: 0x%x, COUNTER_h: 0x%x\n", l, h);
+
+	channels = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
 
-	for (i = 0; i < timers; i++) {
+	for (i = 0; i < channels; i++) {
 		l = hpet_readl(HPET_Tn_CFG(i));
 		h = hpet_readl(HPET_Tn_CFG(i)+4);
-		printk(KERN_INFO "hpet: T%d: CFG_l: 0x%x, CFG_h: 0x%x\n",
-		       i, l, h);
+		pr_info("T%d: CFG_l: 0x%x, CFG_h: 0x%x\n", i, l, h);
+
 		l = hpet_readl(HPET_Tn_CMP(i));
 		h = hpet_readl(HPET_Tn_CMP(i)+4);
-		printk(KERN_INFO "hpet: T%d: CMP_l: 0x%x, CMP_h: 0x%x\n",
-		       i, l, h);
+		pr_info("T%d: CMP_l: 0x%x, CMP_h: 0x%x\n", i, l, h);
+
 		l = hpet_readl(HPET_Tn_ROUTE(i));
 		h = hpet_readl(HPET_Tn_ROUTE(i)+4);
-		printk(KERN_INFO "hpet: T%d ROUTE_l: 0x%x, ROUTE_h: 0x%x\n",
-		       i, l, h);
+		pr_info("T%d ROUTE_l: 0x%x, ROUTE_h: 0x%x\n", i, l, h);
 	}
 }
 
@@ -172,31 +178,20 @@ do {								\
 } while (0)
 
 /*
- * When the hpet driver (/dev/hpet) is enabled, we need to reserve
+ * When the HPET driver (/dev/hpet) is enabled, we need to reserve
  * timer 0 and timer 1 in case of RTC emulation.
  */
 #ifdef CONFIG_HPET
 
-static void hpet_reserve_msi_timers(struct hpet_data *hd);
-
-static void hpet_reserve_platform_timers(unsigned int id)
+static void __init hpet_reserve_platform_timers(void)
 {
-	struct hpet __iomem *hpet = hpet_virt_address;
-	struct hpet_timer __iomem *timer = &hpet->hpet_timers[2];
-	unsigned int nrtimers, i;
 	struct hpet_data hd;
-
-	nrtimers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
+	unsigned int i;
 
 	memset(&hd, 0, sizeof(hd));
 	hd.hd_phys_address	= hpet_address;
-	hd.hd_address		= hpet;
-	hd.hd_nirqs		= nrtimers;
-	hpet_reserve_timer(&hd, 0);
-
-#ifdef CONFIG_HPET_EMULATE_RTC
-	hpet_reserve_timer(&hd, 1);
-#endif
+	hd.hd_address		= hpet_virt_address;
+	hd.hd_nirqs		= hpet_base.nr_channels;
 
 	/*
 	 * NOTE that hd_irq[] reflects IOAPIC input pins (LEGACY_8254
@@ -206,30 +201,52 @@ static void hpet_reserve_platform_timers(unsigned int id)
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < nrtimers; timer++, i++) {
-		hd.hd_irq[i] = (readl(&timer->hpet_config) &
-			Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
-	}
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
+
+		if (i >= 2)
+			hd.hd_irq[i] = hc->irq;
 
-	hpet_reserve_msi_timers(&hd);
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
 
 	hpet_alloc(&hd);
+}
 
+static void __init hpet_select_device_channel(void)
+{
+	int i;
+
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
+
+		/* Associate the first unused channel to /dev/hpet */
+		if (hc->mode == HPET_MODE_UNUSED) {
+			hc->mode = HPET_MODE_DEVICE;
+			return;
+		}
+	}
 }
+
 #else
-static void hpet_reserve_platform_timers(unsigned int id) { }
+static inline void hpet_reserve_platform_timers(void) { }
+static inline void hpet_select_device_channel(void) {}
 #endif
 
-/*
- * Common hpet info
- */
-static unsigned long hpet_freq;
-
-static struct clock_event_device hpet_clockevent;
-
+/* Common HPET functions */
 static void hpet_stop_counter(void)
 {
 	u32 cfg = hpet_readl(HPET_CFG);
+
 	cfg &= ~HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 }
@@ -243,6 +260,7 @@ static void hpet_reset_counter(void)
 static void hpet_start_counter(void)
 {
 	unsigned int cfg = hpet_readl(HPET_CFG);
+
 	cfg |= HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 }
@@ -274,24 +292,9 @@ static void hpet_enable_legacy_int(void)
 	hpet_legacy_int_enabled = true;
 }
 
-static void hpet_legacy_clockevent_register(void)
-{
-	/* Start HPET legacy interrupts */
-	hpet_enable_legacy_int();
-
-	/*
-	 * Start hpet with the boot cpu mask and make it
-	 * global after the IO_APIC has been initialized.
-	 */
-	hpet_clockevent.cpumask = cpumask_of(boot_cpu_data.cpu_index);
-	clockevents_config_and_register(&hpet_clockevent, hpet_freq,
-					HPET_MIN_PROG_DELTA, 0x7FFFFFFF);
-	global_clock_event = &hpet_clockevent;
-	printk(KERN_DEBUG "hpet clockevent registered\n");
-}
-
-static int hpet_set_periodic(struct clock_event_device *evt, int timer)
+static int hpet_clkevt_set_state_periodic(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg, cmp, now;
 	uint64_t delta;
 
@@ -300,11 +303,11 @@ static int hpet_set_periodic(struct clock_event_device *evt, int timer)
 	delta >>= evt->shift;
 	now = hpet_readl(HPET_COUNTER);
 	cmp = now + (unsigned int)delta;
-	cfg = hpet_readl(HPET_Tn_CFG(timer));
+	cfg = hpet_readl(HPET_Tn_CFG(channel));
 	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
 	       HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_Tn_CFG(timer));
-	hpet_writel(cmp, HPET_Tn_CMP(timer));
+	hpet_writel(cfg, HPET_Tn_CFG(channel));
+	hpet_writel(cmp, HPET_Tn_CMP(channel));
 	udelay(1);
 	/*
 	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
@@ -313,52 +316,55 @@ static int hpet_set_periodic(struct clock_event_device *evt, int timer)
 	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
 	 * Publication # 24674)
 	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(timer));
+	hpet_writel((unsigned int)delta, HPET_Tn_CMP(channel));
 	hpet_start_counter();
 	hpet_print_config();
 
 	return 0;
 }
 
-static int hpet_set_oneshot(struct clock_event_device *evt, int timer)
+static int hpet_clkevt_set_state_oneshot(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg;
 
-	cfg = hpet_readl(HPET_Tn_CFG(timer));
+	cfg = hpet_readl(HPET_Tn_CFG(channel));
 	cfg &= ~HPET_TN_PERIODIC;
 	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_Tn_CFG(timer));
+	hpet_writel(cfg, HPET_Tn_CFG(channel));
 
 	return 0;
 }
 
-static int hpet_shutdown(struct clock_event_device *evt, int timer)
+static int hpet_clkevt_set_state_shutdown(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg;
 
-	cfg = hpet_readl(HPET_Tn_CFG(timer));
+	cfg = hpet_readl(HPET_Tn_CFG(channel));
 	cfg &= ~HPET_TN_ENABLE;
-	hpet_writel(cfg, HPET_Tn_CFG(timer));
+	hpet_writel(cfg, HPET_Tn_CFG(channel));
 
 	return 0;
 }
 
-static int hpet_resume(struct clock_event_device *evt)
+static int hpet_clkevt_legacy_resume(struct clock_event_device *evt)
 {
 	hpet_enable_legacy_int();
 	hpet_print_config();
 	return 0;
 }
 
-static int hpet_next_event(unsigned long delta,
-			   struct clock_event_device *evt, int timer)
+static int
+hpet_clkevt_set_next_event(unsigned long delta, struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	u32 cnt;
 	s32 res;
 
 	cnt = hpet_readl(HPET_COUNTER);
 	cnt += (u32) delta;
-	hpet_writel(cnt, HPET_Tn_CMP(timer));
+	hpet_writel(cnt, HPET_Tn_CMP(channel));
 
 	/*
 	 * HPETs are a complete disaster. The compare register is
@@ -387,360 +393,250 @@ static int hpet_next_event(unsigned long delta,
 	return res < HPET_MIN_CYCLES ? -ETIME : 0;
 }
 
-static int hpet_legacy_shutdown(struct clock_event_device *evt)
+static void hpet_init_clockevent(struct hpet_channel *hc, unsigned int rating)
 {
-	return hpet_shutdown(evt, 0);
-}
+	struct clock_event_device *evt = &hc->evt;
 
-static int hpet_legacy_set_oneshot(struct clock_event_device *evt)
-{
-	return hpet_set_oneshot(evt, 0);
-}
+	evt->rating		= rating;
+	evt->irq		= hc->irq;
+	evt->name		= hc->name;
+	evt->cpumask		= cpumask_of(hc->cpu);
+	evt->set_state_oneshot	= hpet_clkevt_set_state_oneshot;
+	evt->set_next_event	= hpet_clkevt_set_next_event;
+	evt->set_state_shutdown	= hpet_clkevt_set_state_shutdown;
 
-static int hpet_legacy_set_periodic(struct clock_event_device *evt)
-{
-	return hpet_set_periodic(evt, 0);
+	evt->features = CLOCK_EVT_FEAT_ONESHOT;
+	if (hc->boot_cfg & HPET_TN_PERIODIC) {
+		evt->features		|= CLOCK_EVT_FEAT_PERIODIC;
+		evt->set_state_periodic	= hpet_clkevt_set_state_periodic;
+	}
 }
 
-static int hpet_legacy_resume(struct clock_event_device *evt)
+static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 {
-	return hpet_resume(evt);
-}
+	/*
+	 * Start HPET with the boot CPU's cpumask and make it global after
+	 * the IO_APIC has been initialized.
+	 */
+	hc->cpu = boot_cpu_data.cpu_index;
+	strncpy(hc->name, "hpet", sizeof(hc->name));
+	hpet_init_clockevent(hc, 50);
 
-static int hpet_legacy_next_event(unsigned long delta,
-			struct clock_event_device *evt)
-{
-	return hpet_next_event(delta, evt, 0);
-}
+	hc->evt.tick_resume	= hpet_clkevt_legacy_resume;
 
-/*
- * The hpet clock event device
- */
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
-};
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
  */
 #ifdef CONFIG_PCI_MSI
 
-static DEFINE_PER_CPU(struct hpet_dev *, cpu_hpet_dev);
-static struct hpet_dev	*hpet_devs;
-static struct irq_domain *hpet_domain;
-
 void hpet_msi_unmask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
+	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
-	/* unmask it */
-	cfg = hpet_readl(HPET_Tn_CFG(hdev->num));
+	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg |= HPET_TN_ENABLE | HPET_TN_FSB;
-	hpet_writel(cfg, HPET_Tn_CFG(hdev->num));
+	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
 void hpet_msi_mask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
+	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
-	/* mask it */
-	cfg = hpet_readl(HPET_Tn_CFG(hdev->num));
+	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg &= ~(HPET_TN_ENABLE | HPET_TN_FSB);
-	hpet_writel(cfg, HPET_Tn_CFG(hdev->num));
-}
-
-void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg)
-{
-	hpet_writel(msg->data, HPET_Tn_ROUTE(hdev->num));
-	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hdev->num) + 4);
+	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_read(struct hpet_dev *hdev, struct msi_msg *msg)
+void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
 {
-	msg->data = hpet_readl(HPET_Tn_ROUTE(hdev->num));
-	msg->address_lo = hpet_readl(HPET_Tn_ROUTE(hdev->num) + 4);
-	msg->address_hi = 0;
+	hpet_writel(msg->data, HPET_Tn_ROUTE(hc->num));
+	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
-static int hpet_msi_shutdown(struct clock_event_device *evt)
+static int hpet_clkevt_msi_resume(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_shutdown(evt, hdev->num);
-}
-
-static int hpet_msi_set_oneshot(struct clock_event_device *evt)
-{
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_set_oneshot(evt, hdev->num);
-}
-
-static int hpet_msi_set_periodic(struct clock_event_device *evt)
-{
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-
-	return hpet_set_periodic(evt, hdev->num);
-}
-
-static int hpet_msi_resume(struct clock_event_device *evt)
-{
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-	struct irq_data *data = irq_get_irq_data(hdev->irq);
+	struct hpet_channel *hc = clockevent_to_channel(evt);
+	struct irq_data *data = irq_get_irq_data(hc->irq);
 	struct msi_msg msg;
 
 	/* Restore the MSI msg and unmask the interrupt */
 	irq_chip_compose_msi_msg(data, &msg);
-	hpet_msi_write(hdev, &msg);
+	hpet_msi_write(hc, &msg);
 	hpet_msi_unmask(data);
 	return 0;
 }
 
-static int hpet_msi_next_event(unsigned long delta,
-				struct clock_event_device *evt)
-{
-	struct hpet_dev *hdev = EVT_TO_HPET_DEV(evt);
-	return hpet_next_event(delta, evt, hdev->num);
-}
-
-static irqreturn_t hpet_interrupt_handler(int irq, void *data)
+static irqreturn_t hpet_msi_interrupt_handler(int irq, void *data)
 {
-	struct hpet_dev *dev = (struct hpet_dev *)data;
-	struct clock_event_device *hevt = &dev->evt;
+	struct hpet_channel *hc = data;
+	struct clock_event_device *evt = &hc->evt;
 
-	if (!hevt->event_handler) {
-		printk(KERN_INFO "Spurious HPET timer interrupt on HPET timer %d\n",
-				dev->num);
+	if (!evt->event_handler) {
+		pr_info("Spurious interrupt HPET channel %d\n", hc->num);
 		return IRQ_HANDLED;
 	}
 
-	hevt->event_handler(hevt);
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
-static int hpet_setup_irq(struct hpet_dev *dev)
+static int hpet_setup_msi_irq(struct hpet_channel *hc)
 {
-
-	if (request_irq(dev->irq, hpet_interrupt_handler,
+	if (request_irq(hc->irq, hpet_msi_interrupt_handler,
 			IRQF_TIMER | IRQF_NOBALANCING,
-			dev->name, dev))
+			hc->name, hc))
 		return -1;
 
-	disable_irq(dev->irq);
-	irq_set_affinity(dev->irq, cpumask_of(dev->cpu));
-	enable_irq(dev->irq);
+	disable_irq(hc->irq);
+	irq_set_affinity(hc->irq, cpumask_of(hc->cpu));
+	enable_irq(hc->irq);
 
-	printk(KERN_DEBUG "hpet: %s irq %d for MSI\n",
-			 dev->name, dev->irq);
+	pr_debug("%s irq %u for MSI\n", hc->name, hc->irq);
 
 	return 0;
 }
 
-/* This should be called in specific @cpu */
-static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
+/* Invoked from the hotplug callback on @cpu */
+static void init_one_hpet_msi_clockevent(struct hpet_channel *hc, int cpu)
 {
-	struct clock_event_device *evt = &hdev->evt;
-
-	WARN_ON(cpu != smp_processor_id());
-	if (!(hdev->flags & HPET_DEV_VALID))
-		return;
-
-	hdev->cpu = cpu;
-	per_cpu(cpu_hpet_dev, cpu) = hdev;
-	evt->name = hdev->name;
-	hpet_setup_irq(hdev);
-	evt->irq = hdev->irq;
+	struct clock_event_device *evt = &hc->evt;
 
-	evt->rating = 110;
-	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	if (hdev->flags & HPET_DEV_PERI_CAP) {
-		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
-		evt->set_state_periodic = hpet_msi_set_periodic;
-	}
+	hc->cpu = cpu;
+	per_cpu(cpu_hpet_channel, cpu) = hc;
+	hpet_setup_msi_irq(hc);
 
-	evt->set_state_shutdown = hpet_msi_shutdown;
-	evt->set_state_oneshot = hpet_msi_set_oneshot;
-	evt->tick_resume = hpet_msi_resume;
-	evt->set_next_event = hpet_msi_next_event;
-	evt->cpumask = cpumask_of(hdev->cpu);
+	hpet_init_clockevent(hc, 110);
+	evt->tick_resume = hpet_clkevt_msi_resume;
 
 	clockevents_config_and_register(evt, hpet_freq, HPET_MIN_PROG_DELTA,
 					0x7FFFFFFF);
 }
 
-#ifdef CONFIG_HPET
-/* Reserve at least one timer for userspace (/dev/hpet) */
-#define RESERVE_TIMERS 1
-#else
-#define RESERVE_TIMERS 0
-#endif
-
-static void hpet_msi_capability_lookup(unsigned int start_timer)
+static struct hpet_channel *hpet_get_unused_clockevent(void)
 {
-	unsigned int id;
-	unsigned int num_timers;
-	unsigned int num_timers_used = 0;
-	int i, irq;
-
-	if (hpet_msi_disable)
-		return;
-
-	if (boot_cpu_has(X86_FEATURE_ARAT))
-		return;
-	id = hpet_readl(HPET_ID);
-
-	num_timers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT);
-	num_timers++; /* Value read out starts from 0 */
-	hpet_print_config();
-
-	hpet_domain = hpet_create_irq_domain(hpet_blockid);
-	if (!hpet_domain)
-		return;
-
-	hpet_devs = kcalloc(num_timers, sizeof(struct hpet_dev), GFP_KERNEL);
-	if (!hpet_devs)
-		return;
-
-	hpet_num_timers = num_timers;
-
-	for (i = start_timer; i < num_timers - RESERVE_TIMERS; i++) {
-		struct hpet_dev *hdev = &hpet_devs[num_timers_used];
-		unsigned int cfg = hpet_readl(HPET_Tn_CFG(i));
-
-		/* Only consider HPET timer with MSI support */
-		if (!(cfg & HPET_TN_FSB_CAP))
-			continue;
+	int i;
 
-		hdev->flags = 0;
-		if (cfg & HPET_TN_PERIODIC_CAP)
-			hdev->flags |= HPET_DEV_PERI_CAP;
-		sprintf(hdev->name, "hpet%d", i);
-		hdev->num = i;
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
 
-		irq = hpet_assign_irq(hpet_domain, hdev, hdev->num);
-		if (irq <= 0)
+		if (hc->mode != HPET_MODE_CLOCKEVT || hc->in_use)
 			continue;
-
-		hdev->irq = irq;
-		hdev->flags |= HPET_DEV_FSB_CAP;
-		hdev->flags |= HPET_DEV_VALID;
-		num_timers_used++;
-		if (num_timers_used == num_possible_cpus())
-			break;
+		hc->in_use = 1;
+		return hc;
 	}
-
-	printk(KERN_INFO "HPET: %d timers in total, %d timers will be used for per-cpu timer\n",
-		num_timers, num_timers_used);
+	return NULL;
 }
 
-#ifdef CONFIG_HPET
-static void hpet_reserve_msi_timers(struct hpet_data *hd)
+static int hpet_cpuhp_online(unsigned int cpu)
 {
-	int i;
-
-	if (!hpet_devs)
-		return;
+	struct hpet_channel *hc = hpet_get_unused_clockevent();
 
-	for (i = 0; i < hpet_num_timers; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
+	if (hc)
+		init_one_hpet_msi_clockevent(hc, cpu);
+	return 0;
+}
 
-		if (!(hdev->flags & HPET_DEV_VALID))
-			continue;
+static int hpet_cpuhp_dead(unsigned int cpu)
+{
+	struct hpet_channel *hc = per_cpu(cpu_hpet_channel, cpu);
 
-		hd->hd_irq[hdev->num] = hdev->irq;
-		hpet_reserve_timer(hd, hdev->num);
-	}
+	if (!hc)
+		return 0;
+	free_irq(hc->irq, hc);
+	hc->in_use = 0;
+	per_cpu(cpu_hpet_channel, cpu) = NULL;
+	return 0;
 }
-#endif
 
-static struct hpet_dev *hpet_get_unused_timer(void)
+static void __init hpet_select_clockevents(void)
 {
-	int i;
+	unsigned int i;
 
-	if (!hpet_devs)
-		return NULL;
+	hpet_base.nr_clockevents = 0;
 
-	for (i = 0; i < hpet_num_timers; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
+	/* No point if MSI is disabled or CPU has an Always Runing APIC Timer */
+	if (hpet_msi_disable || boot_cpu_has(X86_FEATURE_ARAT))
+		return;
 
-		if (!(hdev->flags & HPET_DEV_VALID))
-			continue;
-		if (test_and_set_bit(HPET_DEV_USED_BIT,
-			(unsigned long *)&hdev->flags))
-			continue;
-		return hdev;
-	}
-	return NULL;
-}
+	hpet_print_config();
 
-struct hpet_work_struct {
-	struct delayed_work work;
-	struct completion complete;
-};
+	hpet_domain = hpet_create_irq_domain(hpet_blockid);
+	if (!hpet_domain)
+		return;
 
-static void hpet_work(struct work_struct *w)
-{
-	struct hpet_dev *hdev;
-	int cpu = smp_processor_id();
-	struct hpet_work_struct *hpet_work;
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
+		int irq;
 
-	hpet_work = container_of(w, struct hpet_work_struct, work.work);
+		if (hc->mode != HPET_MODE_UNUSED)
+			continue;
 
-	hdev = hpet_get_unused_timer();
-	if (hdev)
-		init_one_hpet_msi_clockevent(hdev, cpu);
+		/* Only consider HPET channel with MSI support */
+		if (!(hc->boot_cfg & HPET_TN_FSB_CAP))
+			continue;
 
-	complete(&hpet_work->complete);
-}
+		sprintf(hc->name, "hpet%d", i);
 
-static int hpet_cpuhp_online(unsigned int cpu)
-{
-	struct hpet_work_struct work;
-
-	INIT_DELAYED_WORK_ONSTACK(&work.work, hpet_work);
-	init_completion(&work.complete);
-	/* FIXME: add schedule_work_on() */
-	schedule_delayed_work_on(cpu, &work.work, 0);
-	wait_for_completion(&work.complete);
-	destroy_delayed_work_on_stack(&work.work);
-	return 0;
-}
+		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
+		if (irq <= 0)
+			continue;
 
-static int hpet_cpuhp_dead(unsigned int cpu)
-{
-	struct hpet_dev *hdev = per_cpu(cpu_hpet_dev, cpu);
+		hc->irq = irq;
+		hc->mode = HPET_MODE_CLOCKEVT;
 
-	if (!hdev)
-		return 0;
-	free_irq(hdev->irq, hdev);
-	hdev->flags &= ~HPET_DEV_USED;
-	per_cpu(cpu_hpet_dev, cpu) = NULL;
-	return 0;
-}
-#else
+		if (++hpet_base.nr_clockevents == num_possible_cpus())
+			break;
+	}
 
-static void hpet_msi_capability_lookup(unsigned int start_timer)
-{
-	return;
+	pr_info("%d channels of %d reserved for per-cpu timers\n",
+		hpet_base.nr_channels, hpet_base.nr_clockevents);
 }
 
-#ifdef CONFIG_HPET
-static void hpet_reserve_msi_timers(struct hpet_data *hd)
-{
-	return;
-}
-#endif
+#else
+
+static inline void hpet_select_clockevents(void) { }
 
 #define hpet_cpuhp_online	NULL
 #define hpet_cpuhp_dead		NULL
@@ -754,10 +650,10 @@ static void hpet_reserve_msi_timers(struct hpet_data *hd)
 /*
  * Reading the HPET counter is a very slow operation. If a large number of
  * CPUs are trying to access the HPET counter simultaneously, it can cause
- * massive delay and slow down system performance dramatically. This may
+ * massive delays and slow down system performance dramatically. This may
  * happen when HPET is the default clock source instead of TSC. For a
  * really large system with hundreds of CPUs, the slowdown may be so
- * severe that it may actually crash the system because of a NMI watchdog
+ * severe, that it can actually crash the system because of a NMI watchdog
  * soft lockup, for example.
  *
  * If multiple CPUs are trying to access the HPET counter at the same time,
@@ -766,10 +662,9 @@ static void hpet_reserve_msi_timers(struct hpet_data *hd)
  *
  * This special feature is only enabled on x86-64 systems. It is unlikely
  * that 32-bit x86 systems will have enough CPUs to require this feature
- * with its associated locking overhead. And we also need 64-bit atomic
- * read.
+ * with its associated locking overhead. We also need 64-bit atomic read.
  *
- * The lock and the hpet value are stored together and can be read in a
+ * The lock and the HPET value are stored together and can be read in a
  * single atomic 64-bit read. It is explicitly assumed that arch_spinlock_t
  * is 32 bits in size.
  */
@@ -858,15 +753,40 @@ static struct clocksource clocksource_hpet = {
 	.resume		= hpet_resume_counter,
 };
 
-static int hpet_clocksource_register(void)
+/*
+ * AMD SB700 based systems with spread spectrum enabled use a SMM based
+ * HPET emulation to provide proper frequency setting.
+ *
+ * On such systems the SMM code is initialized with the first HPET register
+ * access and takes some time to complete. During this time the config
+ * register reads 0xffffffff. We check for max 1000 loops whether the
+ * config register reads a non-0xffffffff value to make sure that the
+ * HPET is up and running before we proceed any further.
+ *
+ * A counting loop is safe, as the HPET access takes thousands of CPU cycles.
+ *
+ * On non-SB700 based machines this check is only done once and has no
+ * side effects.
+ */
+static bool __init hpet_cfg_working(void)
 {
-	u64 start, now;
-	u64 t1;
+	int i;
+
+	for (i = 0; i < 1000; i++) {
+		if (hpet_readl(HPET_CFG) != 0xFFFFFFFF)
+			return true;
+	}
+
+	pr_warn("Config register invalid. Disabling HPET\n");
+	return false;
+}
+
+static bool __init hpet_counting(void)
+{
+	u64 start, now, t1;
 
-	/* Start the counter */
 	hpet_restart_counter();
 
-	/* Verify whether hpet counter works */
 	t1 = hpet_readl(HPET_COUNTER);
 	start = rdtsc();
 
@@ -877,30 +797,24 @@ static int hpet_clocksource_register(void)
 	 * 1 GHz == 200us
 	 */
 	do {
-		rep_nop();
+		if (t1 != hpet_readl(HPET_COUNTER))
+			return true;
 		now = rdtsc();
 	} while ((now - start) < 200000UL);
 
-	if (t1 == hpet_readl(HPET_COUNTER)) {
-		printk(KERN_WARNING
-		       "HPET counter not counting. HPET disabled\n");
-		return -ENODEV;
-	}
-
-	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
-	return 0;
+	pr_warn("Counter not counting. HPET disabled\n");
+	return false;
 }
 
-static u32 *hpet_boot_cfg;
-
 /**
  * hpet_enable - Try to setup the HPET timer. Returns 1 on success.
  */
 int __init hpet_enable(void)
 {
-	u32 hpet_period, cfg, id;
+	u32 hpet_period, cfg, id, irq;
+	unsigned int i, channels;
+	struct hpet_channel *hc;
 	u64 freq;
-	unsigned int i, last;
 
 	if (!is_hpet_capable())
 		return 0;
@@ -909,40 +823,22 @@ int __init hpet_enable(void)
 	if (!hpet_virt_address)
 		return 0;
 
+	/* Validate that the config register is working */
+	if (!hpet_cfg_working())
+		goto out_nohpet;
+
+	/* Validate that the counter is counting */
+	if (!hpet_counting())
+		goto out_nohpet;
+
 	/*
 	 * Read the period and check for a sane value:
 	 */
 	hpet_period = hpet_readl(HPET_PERIOD);
-
-	/*
-	 * AMD SB700 based systems with spread spectrum enabled use a
-	 * SMM based HPET emulation to provide proper frequency
-	 * setting. The SMM code is initialized with the first HPET
-	 * register access and takes some time to complete. During
-	 * this time the config register reads 0xffffffff. We check
-	 * for max. 1000 loops whether the config register reads a non
-	 * 0xffffffff value to make sure that HPET is up and running
-	 * before we go further. A counting loop is safe, as the HPET
-	 * access takes thousands of CPU cycles. On non SB700 based
-	 * machines this check is only done once and has no side
-	 * effects.
-	 */
-	for (i = 0; hpet_readl(HPET_CFG) == 0xFFFFFFFF; i++) {
-		if (i == 1000) {
-			printk(KERN_WARNING
-			       "HPET config register value = 0xFFFFFFFF. "
-			       "Disabling HPET\n");
-			goto out_nohpet;
-		}
-	}
-
 	if (hpet_period < HPET_MIN_PERIOD || hpet_period > HPET_MAX_PERIOD)
 		goto out_nohpet;
 
-	/*
-	 * The period is a femto seconds value. Convert it to a
-	 * frequency.
-	 */
+	/* The period is a femtoseconds value. Convert it to a frequency. */
 	freq = FSEC_PER_SEC;
 	do_div(freq, hpet_period);
 	hpet_freq = freq;
@@ -954,72 +850,90 @@ int __init hpet_enable(void)
 	id = hpet_readl(HPET_ID);
 	hpet_print_config();
 
-	last = (id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT;
+	/* This is the HPET channel number which is zero based */
+	channels = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
 
-#ifdef CONFIG_HPET_EMULATE_RTC
 	/*
 	 * The legacy routing mode needs at least two channels, tick timer
 	 * and the rtc emulation channel.
 	 */
-	if (!last)
+	if (IS_ENABLED(CONFIG_HPET_EMULATE_RTC) && channels < 2)
 		goto out_nohpet;
-#endif
 
+	hc = kcalloc(channels, sizeof(*hc), GFP_KERNEL);
+	if (!hc) {
+		pr_warn("Disabling HPET.\n");
+		goto out_nohpet;
+	}
+	hpet_base.channels = hc;
+	hpet_base.nr_channels = channels;
+
+	/* Read, store and sanitize the global configuration */
 	cfg = hpet_readl(HPET_CFG);
-	hpet_boot_cfg = kmalloc_array(last + 2, sizeof(*hpet_boot_cfg),
-				      GFP_KERNEL);
-	if (hpet_boot_cfg)
-		*hpet_boot_cfg = cfg;
-	else
-		pr_warn("HPET initial state will not be saved\n");
+	hpet_base.boot_cfg = cfg;
 	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
 	hpet_writel(cfg, HPET_CFG);
 	if (cfg)
-		pr_warn("Unrecognized bits %#x set in global cfg\n", cfg);
+		pr_warn("Global config: Unknown bits %#x\n", cfg);
+
+	/* Read, store and sanitize the per channel configuration */
+	for (i = 0; i < channels; i++, hc++) {
+		hc->num = i;
 
-	for (i = 0; i <= last; ++i) {
 		cfg = hpet_readl(HPET_Tn_CFG(i));
-		if (hpet_boot_cfg)
-			hpet_boot_cfg[i + 1] = cfg;
+		hc->boot_cfg = cfg;
+		irq = (cfg & Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
+		hc->irq = irq;
+
 		cfg &= ~(HPET_TN_ENABLE | HPET_TN_LEVEL | HPET_TN_FSB);
 		hpet_writel(cfg, HPET_Tn_CFG(i));
+
 		cfg &= ~(HPET_TN_PERIODIC | HPET_TN_PERIODIC_CAP
 			 | HPET_TN_64BIT_CAP | HPET_TN_32BIT | HPET_TN_ROUTE
 			 | HPET_TN_FSB | HPET_TN_FSB_CAP);
 		if (cfg)
-			pr_warn("Unrecognized bits %#x set in cfg#%u\n",
-				cfg, i);
+			pr_warn("Channel #%u config: Unknown bits %#x\n", i, cfg);
 	}
 	hpet_print_config();
 
-	if (hpet_clocksource_register())
-		goto out_nohpet;
+	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
 
 	if (id & HPET_ID_LEGSUP) {
-		hpet_legacy_clockevent_register();
+		hpet_legacy_clockevent_register(&hpet_base.channels[0]);
+		hpet_base.channels[0].mode = HPET_MODE_LEGACY;
+		if (IS_ENABLED(CONFIG_HPET_EMULATE_RTC))
+			hpet_base.channels[1].mode = HPET_MODE_LEGACY;
 		return 1;
 	}
 	return 0;
 
 out_nohpet:
+	kfree(hpet_base.channels);
+	hpet_base.channels = NULL;
+	hpet_base.nr_channels = 0;
 	hpet_clear_mapping();
 	hpet_address = 0;
 	return 0;
 }
 
 /*
- * Needs to be late, as the reserve_timer code calls kalloc !
+ * The late initialization runs after the PCI quirks have been invoked
+ * which might have detected a system on which the HPET can be enforced.
+ *
+ * Also, the MSI machinery is not working yet when the HPET is initialized
+ * early.
  *
- * Not a problem on i386 as hpet_enable is called from late_time_init,
- * but on x86_64 it is necessary !
+ * If the HPET is enabled, then:
+ *
+ *  1) Reserve one channel for /dev/hpet if CONFIG_HPET=y
+ *  2) Reserve up to num_possible_cpus() channels as per CPU clockevents
+ *  3) Setup /dev/hpet if CONFIG_HPET=y
+ *  4) Register hotplug callbacks when clockevents are available
  */
 static __init int hpet_late_init(void)
 {
 	int ret;
 
-	if (boot_hpet_disable)
-		return -ENODEV;
-
 	if (!hpet_address) {
 		if (!force_hpet_address)
 			return -ENODEV;
@@ -1031,21 +945,14 @@ static __init int hpet_late_init(void)
 	if (!hpet_virt_address)
 		return -ENODEV;
 
-	if (hpet_readl(HPET_ID) & HPET_ID_LEGSUP)
-		hpet_msi_capability_lookup(2);
-	else
-		hpet_msi_capability_lookup(0);
-
-	hpet_reserve_platform_timers(hpet_readl(HPET_ID));
+	hpet_select_device_channel();
+	hpet_select_clockevents();
+	hpet_reserve_platform_timers();
 	hpet_print_config();
 
-	if (hpet_msi_disable)
+	if (!hpet_base.nr_clockevents)
 		return 0;
 
-	if (boot_cpu_has(X86_FEATURE_ARAT))
-		return 0;
-
-	/* This notifier should be called after workqueue is ready */
 	ret = cpuhp_setup_state(CPUHP_AP_X86_HPET_ONLINE, "x86/hpet:online",
 				hpet_cpuhp_online, NULL);
 	if (ret)
@@ -1064,47 +971,47 @@ fs_initcall(hpet_late_init);
 
 void hpet_disable(void)
 {
-	if (is_hpet_capable() && hpet_virt_address) {
-		unsigned int cfg = hpet_readl(HPET_CFG), id, last;
-
-		if (hpet_boot_cfg)
-			cfg = *hpet_boot_cfg;
-		else if (hpet_legacy_int_enabled) {
-			cfg &= ~HPET_CFG_LEGACY;
-			hpet_legacy_int_enabled = false;
-		}
-		cfg &= ~HPET_CFG_ENABLE;
-		hpet_writel(cfg, HPET_CFG);
+	unsigned int i;
+	u32 cfg;
 
-		if (!hpet_boot_cfg)
-			return;
+	if (!is_hpet_capable() || !hpet_virt_address)
+		return;
 
-		id = hpet_readl(HPET_ID);
-		last = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT);
+	/* Restore boot configuration with the enable bit cleared */
+	cfg = hpet_base.boot_cfg;
+	cfg &= ~HPET_CFG_ENABLE;
+	hpet_writel(cfg, HPET_CFG);
 
-		for (id = 0; id <= last; ++id)
-			hpet_writel(hpet_boot_cfg[id + 1], HPET_Tn_CFG(id));
+	/* Restore the channel boot configuration */
+	for (i = 0; i < hpet_base.nr_channels; i++)
+		hpet_writel(hpet_base.channels[i].boot_cfg, HPET_Tn_CFG(i));
 
-		if (*hpet_boot_cfg & HPET_CFG_ENABLE)
-			hpet_writel(*hpet_boot_cfg, HPET_CFG);
-	}
+	/* If the HPET was enabled at boot time, reenable it */
+	if (hpet_base.boot_cfg & HPET_CFG_ENABLE)
+		hpet_writel(hpet_base.boot_cfg, HPET_CFG);
 }
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
-/* HPET in LegacyReplacement Mode eats up RTC interrupt line. When, HPET
+/*
+ * HPET in LegacyReplacement mode eats up the RTC interrupt line. When HPET
  * is enabled, we support RTC interrupt functionality in software.
+ *
  * RTC has 3 kinds of interrupts:
- * 1) Update Interrupt - generate an interrupt, every sec, when RTC clock
- *    is updated
- * 2) Alarm Interrupt - generate an interrupt at a specific time of day
- * 3) Periodic Interrupt - generate periodic interrupt, with frequencies
- *    2Hz-8192Hz (2Hz-64Hz for non-root user) (all freqs in powers of 2)
- * (1) and (2) above are implemented using polling at a frequency of
- * 64 Hz. The exact frequency is a tradeoff between accuracy and interrupt
- * overhead. (DEFAULT_RTC_INT_FREQ)
- * For (3), we use interrupts at 64Hz or user specified periodic
- * frequency, whichever is higher.
+ *
+ *  1) Update Interrupt - generate an interrupt, every second, when the
+ *     RTC clock is updated
+ *  2) Alarm Interrupt - generate an interrupt at a specific time of day
+ *  3) Periodic Interrupt - generate periodic interrupt, with frequencies
+ *     2Hz-8192Hz (2Hz-64Hz for non-root user) (all frequencies in powers of 2)
+ *
+ * (1) and (2) above are implemented using polling at a frequency of 64 Hz:
+ * DEFAULT_RTC_INT_FREQ.
+ *
+ * The exact frequency is a tradeoff between accuracy and interrupt overhead.
+ *
+ * For (3), we use interrupts at 64 Hz, or the user specified periodic frequency,
+ * if it's higher.
  */
 #include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
@@ -1125,7 +1032,7 @@ static unsigned long hpet_pie_limit;
 static rtc_irq_handler irq_handler;
 
 /*
- * Check that the hpet counter c1 is ahead of the c2
+ * Check that the HPET counter c1 is ahead of c2
  */
 static inline int hpet_cnt_ahead(u32 c1, u32 c2)
 {
@@ -1163,8 +1070,8 @@ void hpet_unregister_irq_handler(rtc_irq_handler handler)
 EXPORT_SYMBOL_GPL(hpet_unregister_irq_handler);
 
 /*
- * Timer 1 for RTC emulation. We use one shot mode, as periodic mode
- * is not supported by all HPET implementations for timer 1.
+ * Channel 1 for RTC emulation. We use one shot mode, as periodic mode
+ * is not supported by all HPET implementations for channel 1.
  *
  * hpet_rtc_timer_init() is called when the rtc is initialized.
  */
@@ -1177,10 +1084,11 @@ int hpet_rtc_timer_init(void)
 		return 0;
 
 	if (!hpet_default_delta) {
+		struct clock_event_device *evt = &hpet_base.channels[0].evt;
 		uint64_t clc;
 
-		clc = (uint64_t) hpet_clockevent.mult * NSEC_PER_SEC;
-		clc >>= hpet_clockevent.shift + DEFAULT_RTC_SHIFT;
+		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
+		clc >>= evt->shift + DEFAULT_RTC_SHIFT;
 		hpet_default_delta = clc;
 	}
 
@@ -1209,6 +1117,7 @@ EXPORT_SYMBOL_GPL(hpet_rtc_timer_init);
 static void hpet_disable_rtc_channel(void)
 {
 	u32 cfg = hpet_readl(HPET_T1_CFG);
+
 	cfg &= ~HPET_TN_ENABLE;
 	hpet_writel(cfg, HPET_T1_CFG);
 }
@@ -1250,8 +1159,7 @@ int hpet_set_rtc_irq_bit(unsigned long bit_mask)
 }
 EXPORT_SYMBOL_GPL(hpet_set_rtc_irq_bit);
 
-int hpet_set_alarm_time(unsigned char hrs, unsigned char min,
-			unsigned char sec)
+int hpet_set_alarm_time(unsigned char hrs, unsigned char min, unsigned char sec)
 {
 	if (!is_hpet_enabled())
 		return 0;
@@ -1271,15 +1179,18 @@ int hpet_set_periodic_freq(unsigned long freq)
 	if (!is_hpet_enabled())
 		return 0;
 
-	if (freq <= DEFAULT_RTC_INT_FREQ)
+	if (freq <= DEFAULT_RTC_INT_FREQ) {
 		hpet_pie_limit = DEFAULT_RTC_INT_FREQ / freq;
-	else {
-		clc = (uint64_t) hpet_clockevent.mult * NSEC_PER_SEC;
+	} else {
+		struct clock_event_device *evt = &hpet_base.channels[0].evt;
+
+		clc = (uint64_t) evt->mult * NSEC_PER_SEC;
 		do_div(clc, freq);
-		clc >>= hpet_clockevent.shift;
+		clc >>= evt->shift;
 		hpet_pie_delta = clc;
 		hpet_pie_limit = 0;
 	}
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(hpet_set_periodic_freq);
@@ -1317,8 +1228,7 @@ static void hpet_rtc_timer_reinit(void)
 		if (hpet_rtc_flags & RTC_PIE)
 			hpet_pie_count += lost_ints;
 		if (printk_ratelimit())
-			printk(KERN_WARNING "hpet1: lost %d rtc interrupts\n",
-				lost_ints);
+			pr_warn("Lost %d RTC interrupts\n", lost_ints);
 	}
 }
 
@@ -1340,8 +1250,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 		hpet_prev_update_sec = curr_time.tm_sec;
 	}
 
-	if (hpet_rtc_flags & RTC_PIE &&
-	    ++hpet_pie_count >= hpet_pie_limit) {
+	if (hpet_rtc_flags & RTC_PIE && ++hpet_pie_count >= hpet_pie_limit) {
 		rtc_int_flag |= RTC_PF;
 		hpet_pie_count = 0;
 	}
@@ -1350,7 +1259,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 	    (curr_time.tm_sec == hpet_alarm_time.tm_sec) &&
 	    (curr_time.tm_min == hpet_alarm_time.tm_min) &&
 	    (curr_time.tm_hour == hpet_alarm_time.tm_hour))
-			rtc_int_flag |= RTC_AF;
+		rtc_int_flag |= RTC_AF;
 
 	if (rtc_int_flag) {
 		rtc_int_flag |= (RTC_IRQF | (RTC_NUM_INTS << 8));

