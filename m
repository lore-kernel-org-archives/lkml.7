Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED1DC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE85F216E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFWN2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfFWN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:55 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2XA-0001mx-LA; Sun, 23 Jun 2019 15:27:52 +0200
Message-Id: <20190623132436.461437795@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:24:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 26/29] x86/hpet: Consolidate clockevent functions
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the legacy clockevent is wrapped in a hpet_channel struct most
clockevent functions can be shared between the legacy and the MSI based
clockevents.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   92 +++++++++++++------------------------------------
 1 file changed, 25 insertions(+), 67 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -310,8 +310,9 @@ static void hpet_legacy_clockevent_regis
 	pr_debug("Clockevent registered\n");
 }
 
-static int hpet_set_periodic(struct clock_event_device *evt, int channel)
+static int hpet_clkevt_set_periodic(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg, cmp, now;
 	uint64_t delta;
 
@@ -340,8 +341,9 @@ static int hpet_set_periodic(struct cloc
 	return 0;
 }
 
-static int hpet_set_oneshot(struct clock_event_device *evt, int channel)
+static int hpet_clkevt_set_oneshot(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg;
 
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
@@ -352,8 +354,9 @@ static int hpet_set_oneshot(struct clock
 	return 0;
 }
 
-static int hpet_shutdown(struct clock_event_device *evt, int channel)
+static int hpet_clkevt_shutdown(struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	unsigned int cfg;
 
 	cfg = hpet_readl(HPET_Tn_CFG(channel));
@@ -363,15 +366,17 @@ static int hpet_shutdown(struct clock_ev
 	return 0;
 }
 
-static int hpet_resume(struct clock_event_device *evt)
+static int hpet_clkevt_legacy_resume(struct clock_event_device *evt)
 {
 	hpet_enable_legacy_int();
 	hpet_print_config();
 	return 0;
 }
 
-static int hpet_next_event(unsigned long delta, int channel)
+static int
+hpet_clkevt_set_next_event(unsigned long delta, struct clock_event_device *evt)
 {
+	unsigned int channel = clockevent_to_channel(evt)->num;
 	u32 cnt;
 	s32 res;
 
@@ -406,32 +411,6 @@ static int hpet_next_event(unsigned long
 	return res < HPET_MIN_CYCLES ? -ETIME : 0;
 }
 
-static int hpet_legacy_shutdown(struct clock_event_device *evt)
-{
-	return hpet_shutdown(evt, 0);
-}
-
-static int hpet_legacy_set_oneshot(struct clock_event_device *evt)
-{
-	return hpet_set_oneshot(evt, 0);
-}
-
-static int hpet_legacy_set_periodic(struct clock_event_device *evt)
-{
-	return hpet_set_periodic(evt, 0);
-}
-
-static int hpet_legacy_resume(struct clock_event_device *evt)
-{
-	return hpet_resume(evt);
-}
-
-static int hpet_legacy_next_event(unsigned long delta,
-				  struct clock_event_device *evt)
-{
-	return hpet_next_event(delta, 0);
-}
-
 /*
  * The HPET clock event device wrapped in a channel for conversion
  */
@@ -440,11 +419,11 @@ static struct hpet_channel hpet_channel0
 		.name			= "hpet",
 		.features		= CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT,
-		.set_state_periodic	= hpet_legacy_set_periodic,
-		.set_state_oneshot	= hpet_legacy_set_oneshot,
-		.set_state_shutdown	= hpet_legacy_shutdown,
-		.tick_resume		= hpet_legacy_resume,
-		.set_next_event		= hpet_legacy_next_event,
+		.set_state_periodic	= hpet_clkevt_set_periodic,
+		.set_state_oneshot	= hpet_clkevt_set_oneshot,
+		.set_state_shutdown	= hpet_clkevt_shutdown,
+		.tick_resume		= hpet_clkevt_legacy_resume,
+		.set_next_event		= hpet_clkevt_set_next_event,
 		.irq			= 0,
 		.rating			= 50,
 	}
@@ -481,22 +460,7 @@ void hpet_msi_write(struct hpet_channel
 	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
-static int hpet_msi_shutdown(struct clock_event_device *evt)
-{
-	return hpet_shutdown(evt, clockevent_to_channel(evt)->num);
-}
-
-static int hpet_msi_set_oneshot(struct clock_event_device *evt)
-{
-	return hpet_set_oneshot(evt, clockevent_to_channel(evt)->num);
-}
-
-static int hpet_msi_set_periodic(struct clock_event_device *evt)
-{
-	return hpet_set_periodic(evt, clockevent_to_channel(evt)->num);
-}
-
-static int hpet_msi_resume(struct clock_event_device *evt)
+static int hpet_clkevt_msi_resume(struct clock_event_device *evt)
 {
 	struct hpet_channel *hc = clockevent_to_channel(evt);
 	struct irq_data *data = irq_get_irq_data(hc->irq);
@@ -509,13 +473,7 @@ static int hpet_msi_resume(struct clock_
 	return 0;
 }
 
-static int hpet_msi_next_event(unsigned long delta,
-			       struct clock_event_device *evt)
-{
-	return hpet_next_event(delta, clockevent_to_channel(evt)->num);
-}
-
-static irqreturn_t hpet_interrupt_handler(int irq, void *data)
+static irqreturn_t hpet_msi_interrupt_handler(int irq, void *data)
 {
 	struct hpet_channel *hc = data;
 	struct clock_event_device *evt = &hc->evt;
@@ -529,9 +487,9 @@ static irqreturn_t hpet_interrupt_handle
 	return IRQ_HANDLED;
 }
 
-static int hpet_setup_irq(struct hpet_channel *hc)
+static int hpet_setup_msi_irq(struct hpet_channel *hc)
 {
-	if (request_irq(hc->irq, hpet_interrupt_handler,
+	if (request_irq(hc->irq, hpet_msi_interrupt_handler,
 			IRQF_TIMER | IRQF_NOBALANCING,
 			hc->name, hc))
 		return -1;
@@ -553,20 +511,20 @@ static void init_one_hpet_msi_clockevent
 	hc->cpu = cpu;
 	per_cpu(cpu_hpet_channel, cpu) = hc;
 	evt->name = hc->name;
-	hpet_setup_irq(hc);
+	hpet_setup_msi_irq(hc);
 	evt->irq = hc->irq;
 
 	evt->rating = 110;
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
 	if (hc->boot_cfg & HPET_TN_PERIODIC) {
 		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
-		evt->set_state_periodic = hpet_msi_set_periodic;
+		evt->set_state_periodic = hpet_clkevt_set_periodic;
 	}
 
-	evt->set_state_shutdown = hpet_msi_shutdown;
-	evt->set_state_oneshot = hpet_msi_set_oneshot;
-	evt->tick_resume = hpet_msi_resume;
-	evt->set_next_event = hpet_msi_next_event;
+	evt->set_state_shutdown = hpet_clkevt_shutdown;
+	evt->set_state_oneshot = hpet_clkevt_set_oneshot;
+	evt->set_next_event = hpet_clkevt_set_next_event;
+	evt->tick_resume = hpet_clkevt_msi_resume;
 	evt->cpumask = cpumask_of(hc->cpu);
 
 	clockevents_config_and_register(evt, hpet_freq, HPET_MIN_PROG_DELTA,


