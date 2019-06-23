Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5D5C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A288A20679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfFWN2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33537 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfFWN1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:52 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X7-0001ld-Lb; Sun, 23 Jun 2019 15:27:49 +0200
Message-Id: <20190623132436.093113681@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [patch 22/29] x86/hpet: Rename variables to prepare for switching to
 channels
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

struct hpet_dev is gone with the next change as the clockevent storage
moves into struct hpet_channel. So the variable name hdev will not make
sense anymore. Ditto for timer vs. channel and similar details.

Doing the rename in the change makes the patch harder to review. Doing it
afterward is problematic vs. tracking down issues.  Doing it upfront is the
easiest solution as it does not change functionality.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |  124 ++++++++++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -315,7 +315,7 @@ static void hpet_legacy_clockevent_regis
 	pr_debug("Clockevent registered\n");
 }
 
-static int hpet_set_periodic(struct clock_event_device *evt, int timer)
+static int hpet_set_periodic(struct clock_event_device *evt, int channel)
 {
 	unsigned int cfg, cmp, now;
 	uint64_t delta;
@@ -325,11 +325,11 @@ static int hpet_set_periodic(struct cloc
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
@@ -338,32 +338,32 @@ static int hpet_set_periodic(struct cloc
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
+static int hpet_set_oneshot(struct clock_event_device *evt, int channel)
 {
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
+static int hpet_shutdown(struct clock_event_device *evt, int channel)
 {
 	unsigned int cfg;
 
-	cfg = hpet_readl(HPET_Tn_CFG(timer));
+	cfg = hpet_readl(HPET_Tn_CFG(channel));
 	cfg &= ~HPET_TN_ENABLE;
-	hpet_writel(cfg, HPET_Tn_CFG(timer));
+	hpet_writel(cfg, HPET_Tn_CFG(channel));
 
 	return 0;
 }
@@ -460,30 +460,30 @@ static struct clock_event_device hpet_cl
 
 void hpet_msi_unmask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
+	struct hpet_dev *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* unmask it */
-	cfg = hpet_readl(HPET_Tn_CFG(hdev->num));
+	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg |= HPET_TN_ENABLE | HPET_TN_FSB;
-	hpet_writel(cfg, HPET_Tn_CFG(hdev->num));
+	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
 void hpet_msi_mask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
+	struct hpet_dev *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* mask it */
-	cfg = hpet_readl(HPET_Tn_CFG(hdev->num));
+	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg &= ~(HPET_TN_ENABLE | HPET_TN_FSB);
-	hpet_writel(cfg, HPET_Tn_CFG(hdev->num));
+	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg)
+void hpet_msi_write(struct hpet_dev *hc, struct msi_msg *msg)
 {
-	hpet_writel(msg->data, HPET_Tn_ROUTE(hdev->num));
-	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hdev->num) + 4);
+	hpet_writel(msg->data, HPET_Tn_ROUTE(hc->num));
+	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
 static int hpet_msi_shutdown(struct clock_event_device *evt)
@@ -503,13 +503,13 @@ static int hpet_msi_set_periodic(struct
 
 static int hpet_msi_resume(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = clockevent_to_channel(evt);
-	struct irq_data *data = irq_get_irq_data(hdev->irq);
+	struct hpet_dev *hc = clockevent_to_channel(evt);
+	struct irq_data *data = irq_get_irq_data(hc->irq);
 	struct msi_msg msg;
 
 	/* Restore the MSI msg and unmask the interrupt */
 	irq_chip_compose_msi_msg(data, &msg);
-	hpet_msi_write(hdev, &msg);
+	hpet_msi_write(hc, &msg);
 	hpet_msi_unmask(data);
 	return 0;
 }
@@ -522,11 +522,11 @@ static int hpet_msi_next_event(unsigned
 
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 {
-	struct hpet_dev *dev = data;
-	struct clock_event_device *evt = &dev->evt;
+	struct hpet_dev *hc = data;
+	struct clock_event_device *evt = &hc->evt;
 
 	if (!evt->event_handler) {
-		pr_info("Spurious interrupt HPET timer %d\n", dev->num);
+		pr_info("Spurious interrupt HPET channel %d\n", hc->num);
 		return IRQ_HANDLED;
 	}
 
@@ -551,22 +551,22 @@ static int hpet_setup_irq(struct hpet_de
 	return 0;
 }
 
-static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
+static void init_one_hpet_msi_clockevent(struct hpet_dev *hc, int cpu)
 {
-	struct clock_event_device *evt = &hdev->evt;
+	struct clock_event_device *evt = &hc->evt;
 
-	if (!(hdev->flags & HPET_DEV_VALID))
+	if (!(hc->flags & HPET_DEV_VALID))
 		return;
 
-	hdev->cpu = cpu;
-	per_cpu(cpu_hpet_dev, cpu) = hdev;
-	evt->name = hdev->name;
-	hpet_setup_irq(hdev);
-	evt->irq = hdev->irq;
+	hc->cpu = cpu;
+	per_cpu(cpu_hpet_dev, cpu) = hc;
+	evt->name = hc->name;
+	hpet_setup_irq(hc);
+	evt->irq = hc->irq;
 
 	evt->rating = 110;
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	if (hdev->flags & HPET_DEV_PERI_CAP) {
+	if (hc->flags & HPET_DEV_PERI_CAP) {
 		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
 		evt->set_state_periodic = hpet_msi_set_periodic;
 	}
@@ -575,7 +575,7 @@ static void init_one_hpet_msi_clockevent
 	evt->set_state_oneshot = hpet_msi_set_oneshot;
 	evt->tick_resume = hpet_msi_resume;
 	evt->set_next_event = hpet_msi_next_event;
-	evt->cpumask = cpumask_of(hdev->cpu);
+	evt->cpumask = cpumask_of(hc->cpu);
 
 	clockevents_config_and_register(evt, hpet_freq, HPET_MIN_PROG_DELTA,
 					0x7FFFFFFF);
@@ -589,35 +589,35 @@ static struct hpet_dev *hpet_get_unused_
 		return NULL;
 
 	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
+		struct hpet_dev *hc = &hpet_devs[i];
 
-		if (!(hdev->flags & HPET_DEV_VALID))
+		if (!(hc->flags & HPET_DEV_VALID))
 			continue;
 		if (test_and_set_bit(HPET_DEV_USED_BIT,
-			(unsigned long *)&hdev->flags))
+			(unsigned long *)&hc->flags))
 			continue;
-		return hdev;
+		return hc;
 	}
 	return NULL;
 }
 
 static int hpet_cpuhp_online(unsigned int cpu)
 {
-	struct hpet_dev *hdev = hpet_get_unused_timer();
+	struct hpet_dev *hc = hpet_get_unused_timer();
 
-	if (hdev)
-		init_one_hpet_msi_clockevent(hdev, cpu);
+	if (hc)
+		init_one_hpet_msi_clockevent(hc, cpu);
 	return 0;
 }
 
 static int hpet_cpuhp_dead(unsigned int cpu)
 {
-	struct hpet_dev *hdev = per_cpu(cpu_hpet_dev, cpu);
+	struct hpet_dev *hc = per_cpu(cpu_hpet_dev, cpu);
 
-	if (!hdev)
+	if (!hc)
 		return 0;
-	free_irq(hdev->irq, hdev);
-	hdev->flags &= ~HPET_DEV_USED;
+	free_irq(hc->irq, hc);
+	hc->flags &= ~HPET_DEV_USED;
 	per_cpu(cpu_hpet_dev, cpu) = NULL;
 	return 0;
 }
@@ -653,26 +653,26 @@ static void __init hpet_msi_capability_l
 		return;
 
 	for (i = start_timer; i < num_timers - RESERVE_TIMERS; i++) {
-		struct hpet_dev *hdev = &hpet_devs[num_timers_used];
+		struct hpet_dev *hc = &hpet_devs[num_timers_used];
 		unsigned int cfg = hpet_base.channels[i].boot_cfg;
 
 		/* Only consider HPET timer with MSI support */
 		if (!(cfg & HPET_TN_FSB_CAP))
 			continue;
 
-		hdev->flags = 0;
+		hc->flags = 0;
 		if (cfg & HPET_TN_PERIODIC_CAP)
-			hdev->flags |= HPET_DEV_PERI_CAP;
-		sprintf(hdev->name, "hpet%d", i);
-		hdev->num = i;
+			hc->flags |= HPET_DEV_PERI_CAP;
+		sprintf(hc->name, "hpet%d", i);
+		hc->num = i;
 
-		irq = hpet_assign_irq(hpet_domain, hdev, hdev->num);
+		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
 		if (irq <= 0)
 			continue;
 
-		hdev->irq = irq;
-		hdev->flags |= HPET_DEV_FSB_CAP;
-		hdev->flags |= HPET_DEV_VALID;
+		hc->irq = irq;
+		hc->flags |= HPET_DEV_FSB_CAP;
+		hc->flags |= HPET_DEV_VALID;
 		num_timers_used++;
 		if (num_timers_used == num_possible_cpus())
 			break;
@@ -691,13 +691,13 @@ static void __init hpet_reserve_msi_time
 		return;
 
 	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
+		struct hpet_dev *hc = &hpet_devs[i];
 
-		if (!(hdev->flags & HPET_DEV_VALID))
+		if (!(hc->flags & HPET_DEV_VALID))
 			continue;
 
-		hd->hd_irq[hdev->num] = hdev->irq;
-		hpet_reserve_timer(hd, hdev->num);
+		hd->hd_irq[hc->num] = hc->irq;
+		hpet_reserve_timer(hd, hc->num);
 	}
 }
 #endif
@@ -1138,8 +1138,8 @@ void hpet_unregister_irq_handler(rtc_irq
 EXPORT_SYMBOL_GPL(hpet_unregister_irq_handler);
 
 /*
- * Timer 1 for RTC emulation. We use one shot mode, as periodic mode
- * is not supported by all HPET implementations for timer 1.
+ * Channel 1 for RTC emulation. We use one shot mode, as periodic mode
+ * is not supported by all HPET implementations for channel 1.
  *
  * hpet_rtc_timer_init() is called when the rtc is initialized.
  */


