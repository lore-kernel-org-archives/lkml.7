Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BA9C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181021530
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFWN1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33405 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfFWN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:40 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wv-0001j3-2g; Sun, 23 Jun 2019 15:27:37 +0200
Message-Id: <20190623132434.140411339@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:42 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 02/29] x86/hpet: Replace printk(KERN...) with pr_...()
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And sanitize the format strings while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -20,6 +20,9 @@
 #include <asm/hpet.h>
 #include <asm/time.h>
 
+#undef  pr_fmt
+#define pr_fmt(fmt) "hpet: " fmt
+
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
 #define HPET_DEV_USED_BIT		2
@@ -137,31 +140,28 @@ EXPORT_SYMBOL_GPL(is_hpet_enabled);
 static void _hpet_print_config(const char *function, int line)
 {
 	u32 i, timers, l, h;
-	printk(KERN_INFO "hpet: %s(%d):\n", function, line);
+	pr_info("%s(%d):\n", function, line);
 	l = hpet_readl(HPET_ID);
 	h = hpet_readl(HPET_PERIOD);
 	timers = ((l & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
-	printk(KERN_INFO "hpet: ID: 0x%x, PERIOD: 0x%x\n", l, h);
+	pr_info("ID: 0x%x, PERIOD: 0x%x\n", l, h);
 	l = hpet_readl(HPET_CFG);
 	h = hpet_readl(HPET_STATUS);
-	printk(KERN_INFO "hpet: CFG: 0x%x, STATUS: 0x%x\n", l, h);
+	pr_info("CFG: 0x%x, STATUS: 0x%x\n", l, h);
 	l = hpet_readl(HPET_COUNTER);
 	h = hpet_readl(HPET_COUNTER+4);
-	printk(KERN_INFO "hpet: COUNTER_l: 0x%x, COUNTER_h: 0x%x\n", l, h);
+	pr_info("COUNTER_l: 0x%x, COUNTER_h: 0x%x\n", l, h);
 
 	for (i = 0; i < timers; i++) {
 		l = hpet_readl(HPET_Tn_CFG(i));
 		h = hpet_readl(HPET_Tn_CFG(i)+4);
-		printk(KERN_INFO "hpet: T%d: CFG_l: 0x%x, CFG_h: 0x%x\n",
-		       i, l, h);
+		pr_info("T%d: CFG_l: 0x%x, CFG_h: 0x%x\n", i, l, h);
 		l = hpet_readl(HPET_Tn_CMP(i));
 		h = hpet_readl(HPET_Tn_CMP(i)+4);
-		printk(KERN_INFO "hpet: T%d: CMP_l: 0x%x, CMP_h: 0x%x\n",
-		       i, l, h);
+		pr_info("T%d: CMP_l: 0x%x, CMP_h: 0x%x\n", i, l, h);
 		l = hpet_readl(HPET_Tn_ROUTE(i));
 		h = hpet_readl(HPET_Tn_ROUTE(i)+4);
-		printk(KERN_INFO "hpet: T%d ROUTE_l: 0x%x, ROUTE_h: 0x%x\n",
-		       i, l, h);
+		pr_info("T%d ROUTE_l: 0x%x, ROUTE_h: 0x%x\n", i, l, h);
 	}
 }
 
@@ -287,7 +287,7 @@ static void hpet_legacy_clockevent_regis
 	clockevents_config_and_register(&hpet_clockevent, hpet_freq,
 					HPET_MIN_PROG_DELTA, 0x7FFFFFFF);
 	global_clock_event = &hpet_clockevent;
-	printk(KERN_DEBUG "hpet clockevent registered\n");
+	pr_debug("Clockevent registered\n");
 }
 
 static int hpet_set_periodic(struct clock_event_device *evt, int timer)
@@ -520,8 +520,7 @@ static irqreturn_t hpet_interrupt_handle
 	struct clock_event_device *hevt = &dev->evt;
 
 	if (!hevt->event_handler) {
-		printk(KERN_INFO "Spurious HPET timer interrupt on HPET timer %d\n",
-				dev->num);
+		pr_info("Spurious interrupt HPET timer %d\n", dev->num);
 		return IRQ_HANDLED;
 	}
 
@@ -541,8 +540,7 @@ static int hpet_setup_irq(struct hpet_de
 	irq_set_affinity(dev->irq, cpumask_of(dev->cpu));
 	enable_irq(dev->irq);
 
-	printk(KERN_DEBUG "hpet: %s irq %d for MSI\n",
-			 dev->name, dev->irq);
+	pr_debug("%s irq %d for MSI\n", dev->name, dev->irq);
 
 	return 0;
 }
@@ -638,7 +636,7 @@ static void hpet_msi_capability_lookup(u
 			break;
 	}
 
-	printk(KERN_INFO "HPET: %d timers in total, %d timers will be used for per-cpu timer\n",
+	pr_info("%d channels of %d reserved for per-cpu timers\n",
 		num_timers, num_timers_used);
 }
 
@@ -856,8 +854,7 @@ static int hpet_clocksource_register(voi
 	} while ((now - start) < 200000UL);
 
 	if (t1 == hpet_readl(HPET_COUNTER)) {
-		printk(KERN_WARNING
-		       "HPET counter not counting. HPET disabled\n");
+		pr_warn("Counter not counting. HPET disabled\n");
 		return -ENODEV;
 	}
 
@@ -903,9 +900,7 @@ int __init hpet_enable(void)
 	 */
 	for (i = 0; hpet_readl(HPET_CFG) == 0xFFFFFFFF; i++) {
 		if (i == 1000) {
-			printk(KERN_WARNING
-			       "HPET config register value = 0xFFFFFFFF. "
-			       "Disabling HPET\n");
+			pr_warn("Config register invalid. Disabling HPET\n");
 			goto out_nohpet;
 		}
 	}
@@ -949,7 +944,7 @@ int __init hpet_enable(void)
 	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
 	hpet_writel(cfg, HPET_CFG);
 	if (cfg)
-		pr_warn("Unrecognized bits %#x set in global cfg\n", cfg);
+		pr_warn("Global config: Unknown bits %#x\n", cfg);
 
 	for (i = 0; i <= last; ++i) {
 		cfg = hpet_readl(HPET_Tn_CFG(i));
@@ -961,8 +956,7 @@ int __init hpet_enable(void)
 			 | HPET_TN_64BIT_CAP | HPET_TN_32BIT | HPET_TN_ROUTE
 			 | HPET_TN_FSB | HPET_TN_FSB_CAP);
 		if (cfg)
-			pr_warn("Unrecognized bits %#x set in cfg#%u\n",
-				cfg, i);
+			pr_warn("Channel #%u config: Unknown bits %#x\n", i, cfg);
 	}
 	hpet_print_config();
 
@@ -1290,8 +1284,7 @@ static void hpet_rtc_timer_reinit(void)
 		if (hpet_rtc_flags & RTC_PIE)
 			hpet_pie_count += lost_ints;
 		if (printk_ratelimit())
-			printk(KERN_WARNING "hpet1: lost %d rtc interrupts\n",
-				lost_ints);
+			pr_warn("Lost %d RTC interrupts\n", lost_ints);
 	}
 }
 


