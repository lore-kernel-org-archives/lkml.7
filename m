Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B364FC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74530208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fYanVgHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF0XjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:39:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0XjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNYkfG499224
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:34:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNYkfG499224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678487;
        bh=4zh2A0ju8nvmprth77/9ulfUQhf61S0lkDS16uIQ+2w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fYanVgHS1kF62oK2oZw+ogtLlnuY3gsGDM8o8MVnw4c/VrYFG1z9XwnoMBZg+y4YE
         NQfvzTryLna8+qQckPQlJq3ZnMAQ40MaMrL5g5QEazUZKFb0S5XlSQIDZIH0OI7v2e
         WyM3xwmEsvlWIRBf68QUfvz1m+4dM4lcssBrwdkZ6dxEbguhgxpKBuTR0Rv4pjlshE
         utNe4c9rpqdcQKgFlqSceJTrBqcf6ph62ZxcYY/9oGplgyD78iufTCq4xqm7NJxC92
         VvYkOiFwplZbxA1UD8zHMoknV0iK0bfG80DqMh8zxGFINFlc8fGHYmBhEiZ2K+7zZm
         g749Yl/PofBMQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNYjpi499221;
        Thu, 27 Jun 2019 16:34:45 -0700
Date:   Thu, 27 Jun 2019 16:34:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-46e5b64fdeb49e6f95b875fa4702cedf6c37188d@git.kernel.org>
Cc:     tglx@linutronix.de, eranian@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, ricardo.neri-calderon@linux.intel.com,
        ashok.raj@intel.com, Suravee.Suthikulpanit@amd.com,
        ravi.v.shankar@intel.com, hpa@zytor.com, andi.kleen@intel.com
Reply-To: ravi.v.shankar@intel.com, ricardo.neri-calderon@linux.intel.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, Suravee.Suthikulpanit@amd.com,
          ashok.raj@intel.com, hpa@zytor.com, andi.kleen@intel.com,
          tglx@linutronix.de, eranian@google.com
In-Reply-To: <20190623132434.140411339@linutronix.de>
References: <20190623132434.140411339@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Replace printk(KERN...) with pr_...()
Git-Commit-ID: 46e5b64fdeb49e6f95b875fa4702cedf6c37188d
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

Commit-ID:  46e5b64fdeb49e6f95b875fa4702cedf6c37188d
Gitweb:     https://git.kernel.org/tip/46e5b64fdeb49e6f95b875fa4702cedf6c37188d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:42 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:15 +0200

x86/hpet: Replace printk(KERN...) with pr_...()

And sanitize the format strings while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.140411339@linutronix.de

---
 arch/x86/kernel/hpet.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index a6aa22677768..cf3dbf43e548 100644
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
 
@@ -287,7 +287,7 @@ static void hpet_legacy_clockevent_register(void)
 	clockevents_config_and_register(&hpet_clockevent, hpet_freq,
 					HPET_MIN_PROG_DELTA, 0x7FFFFFFF);
 	global_clock_event = &hpet_clockevent;
-	printk(KERN_DEBUG "hpet clockevent registered\n");
+	pr_debug("Clockevent registered\n");
 }
 
 static int hpet_set_periodic(struct clock_event_device *evt, int timer)
@@ -520,8 +520,7 @@ static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 	struct clock_event_device *hevt = &dev->evt;
 
 	if (!hevt->event_handler) {
-		printk(KERN_INFO "Spurious HPET timer interrupt on HPET timer %d\n",
-				dev->num);
+		pr_info("Spurious interrupt HPET timer %d\n", dev->num);
 		return IRQ_HANDLED;
 	}
 
@@ -541,8 +540,7 @@ static int hpet_setup_irq(struct hpet_dev *dev)
 	irq_set_affinity(dev->irq, cpumask_of(dev->cpu));
 	enable_irq(dev->irq);
 
-	printk(KERN_DEBUG "hpet: %s irq %d for MSI\n",
-			 dev->name, dev->irq);
+	pr_debug("%s irq %d for MSI\n", dev->name, dev->irq);
 
 	return 0;
 }
@@ -638,7 +636,7 @@ static void hpet_msi_capability_lookup(unsigned int start_timer)
 			break;
 	}
 
-	printk(KERN_INFO "HPET: %d timers in total, %d timers will be used for per-cpu timer\n",
+	pr_info("%d channels of %d reserved for per-cpu timers\n",
 		num_timers, num_timers_used);
 }
 
@@ -856,8 +854,7 @@ static int hpet_clocksource_register(void)
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
 
