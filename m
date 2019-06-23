Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D001C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D044520665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfFWN2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33552 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfFWN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X8-0001mU-IQ; Sun, 23 Jun 2019 15:27:50 +0200
Message-Id: <20190623132436.185851116@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:03 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 23/29] x86/hpet: Move clockevents into channels
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of allocating yet another data structure, move the clock event data
into the channel structure. This allows further consolidation of the
reservation code and the reuse of the cached boot config to replace the
extra flags in the clockevent data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/hpet.h |    6 -
 arch/x86/kernel/apic/msi.c  |    4 -
 arch/x86/kernel/hpet.c      |  139 ++++++++++++++++++--------------------------
 3 files changed, 64 insertions(+), 85 deletions(-)

--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -75,15 +75,15 @@ extern unsigned int hpet_readl(unsigned
 extern void force_hpet_resume(void);
 
 struct irq_data;
-struct hpet_dev;
+struct hpet_channel;
 struct irq_domain;
 
 extern void hpet_msi_unmask(struct irq_data *data);
 extern void hpet_msi_mask(struct irq_data *data);
-extern void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg);
+extern void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg);
 extern struct irq_domain *hpet_create_irq_domain(int hpet_id);
 extern int hpet_assign_irq(struct irq_domain *domain,
-			   struct hpet_dev *dev, int dev_num);
+			   struct hpet_channel *hc, int dev_num);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -373,14 +373,14 @@ struct irq_domain *hpet_create_irq_domai
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
 
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -13,15 +13,6 @@
 #undef  pr_fmt
 #define pr_fmt(fmt) "hpet: " fmt
 
-struct hpet_dev {
-	struct clock_event_device	evt;
-	unsigned int			num;
-	int				cpu;
-	unsigned int			irq;
-	unsigned int			flags;
-	char				name[10];
-};
-
 enum hpet_mode {
 	HPET_MODE_UNUSED,
 	HPET_MODE_LEGACY,
@@ -30,14 +21,19 @@ enum hpet_mode {
 };
 
 struct hpet_channel {
+	struct clock_event_device	evt;
 	unsigned int			num;
+	unsigned int			cpu;
 	unsigned int			irq;
 	enum hpet_mode			mode;
+	unsigned int			flags;
 	unsigned int			boot_cfg;
+	char				name[10];
 };
 
 struct hpet_base {
 	unsigned int			nr_channels;
+	unsigned int			nr_clockevents;
 	unsigned int			boot_cfg;
 	struct hpet_channel		*channels;
 };
@@ -61,8 +57,7 @@ u8					hpet_blockid; /* OS timer block n
 bool					hpet_msi_disable;
 
 #ifdef CONFIG_PCI_MSI
-static struct hpet_dev			*hpet_devs;
-static DEFINE_PER_CPU(struct hpet_dev *, cpu_hpet_dev);
+static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
 static struct irq_domain		*hpet_domain;
 #endif
 
@@ -79,9 +74,9 @@ static bool				hpet_verbose;
 static struct clock_event_device	hpet_clockevent;
 
 static inline
-struct hpet_dev *clockevent_to_channel(struct clock_event_device *evt)
+struct hpet_channel *clockevent_to_channel(struct clock_event_device *evt)
 {
-	return container_of(evt, struct hpet_dev, evt);
+	return container_of(evt, struct hpet_channel, evt);
 }
 
 inline unsigned int hpet_readl(unsigned int a)
@@ -460,10 +455,9 @@ static struct clock_event_device hpet_cl
 
 void hpet_msi_unmask(struct irq_data *data)
 {
-	struct hpet_dev *hc = irq_data_get_irq_handler_data(data);
+	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
-	/* unmask it */
 	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg |= HPET_TN_ENABLE | HPET_TN_FSB;
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
@@ -471,16 +465,15 @@ void hpet_msi_unmask(struct irq_data *da
 
 void hpet_msi_mask(struct irq_data *data)
 {
-	struct hpet_dev *hc = irq_data_get_irq_handler_data(data);
+	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
-	/* mask it */
 	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg &= ~(HPET_TN_ENABLE | HPET_TN_FSB);
 	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_write(struct hpet_dev *hc, struct msi_msg *msg)
+void hpet_msi_write(struct hpet_channel *hc, struct msi_msg *msg)
 {
 	hpet_writel(msg->data, HPET_Tn_ROUTE(hc->num));
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
@@ -503,7 +496,7 @@ static int hpet_msi_set_periodic(struct
 
 static int hpet_msi_resume(struct clock_event_device *evt)
 {
-	struct hpet_dev *hc = clockevent_to_channel(evt);
+	struct hpet_channel *hc = clockevent_to_channel(evt);
 	struct irq_data *data = irq_get_irq_data(hc->irq);
 	struct msi_msg msg;
 
@@ -522,7 +515,7 @@ static int hpet_msi_next_event(unsigned
 
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 {
-	struct hpet_dev *hc = data;
+	struct hpet_channel *hc = data;
 	struct clock_event_device *evt = &hc->evt;
 
 	if (!evt->event_handler) {
@@ -534,24 +527,23 @@ static irqreturn_t hpet_interrupt_handle
 	return IRQ_HANDLED;
 }
 
-static int hpet_setup_irq(struct hpet_dev *dev)
+static int hpet_setup_irq(struct hpet_channel *hc)
 {
-
-	if (request_irq(dev->irq, hpet_interrupt_handler,
+	if (request_irq(hc->irq, hpet_interrupt_handler,
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
 
-	pr_debug("%s irq %d for MSI\n", dev->name, dev->irq);
+	pr_debug("%s irq %u for MSI\n", hc->name, hc->irq);
 
 	return 0;
 }
 
-static void init_one_hpet_msi_clockevent(struct hpet_dev *hc, int cpu)
+static void init_one_hpet_msi_clockevent(struct hpet_channel *hc, int cpu)
 {
 	struct clock_event_device *evt = &hc->evt;
 
@@ -559,7 +551,7 @@ static void init_one_hpet_msi_clockevent
 		return;
 
 	hc->cpu = cpu;
-	per_cpu(cpu_hpet_dev, cpu) = hc;
+	per_cpu(cpu_hpet_channel, cpu) = hc;
 	evt->name = hc->name;
 	hpet_setup_irq(hc);
 	evt->irq = hc->irq;
@@ -581,15 +573,12 @@ static void init_one_hpet_msi_clockevent
 					0x7FFFFFFF);
 }
 
-static struct hpet_dev *hpet_get_unused_timer(void)
+static struct hpet_channel *hpet_get_unused_clockevent(void)
 {
 	int i;
 
-	if (!hpet_devs)
-		return NULL;
-
 	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_dev *hc = &hpet_devs[i];
+		struct hpet_channel *hc = hpet_base.channels + i;
 
 		if (!(hc->flags & HPET_DEV_VALID))
 			continue;
@@ -603,7 +592,7 @@ static struct hpet_dev *hpet_get_unused_
 
 static int hpet_cpuhp_online(unsigned int cpu)
 {
-	struct hpet_dev *hc = hpet_get_unused_timer();
+	struct hpet_channel *hc = hpet_get_unused_clockevent();
 
 	if (hc)
 		init_one_hpet_msi_clockevent(hc, cpu);
@@ -612,59 +601,47 @@ static int hpet_cpuhp_online(unsigned in
 
 static int hpet_cpuhp_dead(unsigned int cpu)
 {
-	struct hpet_dev *hc = per_cpu(cpu_hpet_dev, cpu);
+	struct hpet_channel *hc = per_cpu(cpu_hpet_channel, cpu);
 
 	if (!hc)
 		return 0;
 	free_irq(hc->irq, hc);
 	hc->flags &= ~HPET_DEV_USED;
-	per_cpu(cpu_hpet_dev, cpu) = NULL;
+	per_cpu(cpu_hpet_channel, cpu) = NULL;
 	return 0;
 }
 
-#ifdef CONFIG_HPET
-/* Reserve at least one timer for userspace (/dev/hpet) */
-#define RESERVE_TIMERS 1
-#else
-#define RESERVE_TIMERS 0
-#endif
-
-static void __init hpet_msi_capability_lookup(unsigned int start_timer)
+static void __init hpet_select_clockevents(void)
 {
-	unsigned int num_timers;
-	unsigned int num_timers_used = 0;
-	int i, irq;
+	unsigned int i;
 
-	if (hpet_msi_disable)
-		return;
+	hpet_base.nr_clockevents = 0;
 
-	if (boot_cpu_has(X86_FEATURE_ARAT))
+	/* No point if MSI is disabled or CPU has an Always Runing APIC Timer */
+	if (hpet_msi_disable || boot_cpu_has(X86_FEATURE_ARAT))
 		return;
 
-	num_timers = hpet_base.nr_channels;
 	hpet_print_config();
 
 	hpet_domain = hpet_create_irq_domain(hpet_blockid);
 	if (!hpet_domain)
 		return;
 
-	hpet_devs = kcalloc(num_timers, sizeof(struct hpet_dev), GFP_KERNEL);
-	if (!hpet_devs)
-		return;
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
+		int irq;
 
-	for (i = start_timer; i < num_timers - RESERVE_TIMERS; i++) {
-		struct hpet_dev *hc = &hpet_devs[num_timers_used];
-		unsigned int cfg = hpet_base.channels[i].boot_cfg;
+		if (hc->mode != HPET_MODE_UNUSED)
+			continue;
 
-		/* Only consider HPET timer with MSI support */
-		if (!(cfg & HPET_TN_FSB_CAP))
+		/* Only consider HPET channel with MSI support */
+		if (!(hc->boot_cfg & HPET_TN_FSB_CAP))
 			continue;
 
 		hc->flags = 0;
-		if (cfg & HPET_TN_PERIODIC_CAP)
+		if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
 			hc->flags |= HPET_DEV_PERI_CAP;
 		sprintf(hc->name, "hpet%d", i);
-		hc->num = i;
 
 		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
 		if (irq <= 0)
@@ -673,13 +650,14 @@ static void __init hpet_msi_capability_l
 		hc->irq = irq;
 		hc->flags |= HPET_DEV_FSB_CAP;
 		hc->flags |= HPET_DEV_VALID;
-		num_timers_used++;
-		if (num_timers_used == num_possible_cpus())
+		hc->mode = HPET_MODE_CLOCKEVT;
+
+		if (++hpet_base.nr_clockevents == num_possible_cpus())
 			break;
 	}
 
 	pr_info("%d channels of %d reserved for per-cpu timers\n",
-		num_timers, num_timers_used);
+		hpet_base.nr_channels, hpet_base.nr_clockevents);
 }
 
 #ifdef CONFIG_HPET
@@ -687,11 +665,8 @@ static void __init hpet_reserve_msi_time
 {
 	int i;
 
-	if (!hpet_devs)
-		return;
-
 	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_dev *hc = &hpet_devs[i];
+		struct hpet_channel *hc = hpet_base.channels + i;
 
 		if (!(hc->flags & HPET_DEV_VALID))
 			continue;
@@ -704,7 +679,7 @@ static void __init hpet_reserve_msi_time
 
 #else
 
-static inline void hpet_msi_capability_lookup(unsigned int start_timer) { }
+static inline void hpet_select_clockevents(void) { }
 
 #ifdef CONFIG_HPET
 static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
@@ -991,6 +966,16 @@ int __init hpet_enable(void)
 /*
  * The late initialization runs after the PCI quirks have been invoked
  * which might have detected a system on which the HPET can be enforced.
+ *
+ * Also, the MSI machinery is not working yet when the HPET is initialized
+ * early.
+ *
+ * If the HPET is enabled, then:
+ *
+ *  1) Reserve one channel for /dev/hpet if CONFIG_HPET=y
+ *  2) Reserve up to num_possible_cpus() channels as per CPU clockevents
+ *  3) Setup /dev/hpet if CONFIG_HPET=y
+ *  4) Register hotplug callbacks when clockevents are available
  */
 static __init int hpet_late_init(void)
 {
@@ -1007,18 +992,12 @@ static __init int hpet_late_init(void)
 	if (!hpet_virt_address)
 		return -ENODEV;
 
-	if (hpet_readl(HPET_ID) & HPET_ID_LEGSUP)
-		hpet_msi_capability_lookup(2);
-	else
-		hpet_msi_capability_lookup(0);
-
+	hpet_select_device_channel();
+	hpet_select_clockevents();
 	hpet_reserve_platform_timers();
 	hpet_print_config();
 
-	if (hpet_msi_disable)
-		return 0;
-
-	if (boot_cpu_has(X86_FEATURE_ARAT))
+	if (!hpet_base.nr_clockevents)
 		return 0;
 
 	ret = cpuhp_setup_state(CPUHP_AP_X86_HPET_ONLINE, "x86/hpet:online",


