Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37C6C282DE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DC92175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbfEXBRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:17:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:42236 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731632AbfEXBQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:16:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 18:16:35 -0700
X-ExtLoop1: 1
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by fmsmga008.fm.intel.com with ESMTP; 23 May 2019 18:16:34 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC PATCH v4 04/21] x86/hpet: Add hpet_set_comparator() for periodic and one-shot modes
Date:   Thu, 23 May 2019 18:16:06 -0700
Message-Id: <1558660583-28561-5-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of setting the timer period directly in hpet_set_periodic(), add a
new helper function hpet_set_comparator() that only sets the accumulator
and comparator. hpet_set_periodic() will only prepare the timer for
periodic mode and leave the expiration programming to
hpet_set_comparator().

This new function can also be used by other components (e.g., the HPET-
based hardlockup detector) which also need to configure HPET timers. Thus,
add its declaration into the hpet header file.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Originally-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h |  1 +
 arch/x86/kernel/hpet.c      | 57 +++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index f132fbf984d4..e7098740f5ee 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -102,6 +102,7 @@ extern int hpet_rtc_timer_init(void);
 extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
 extern int hpet_register_irq_handler(rtc_irq_handler handler);
 extern void hpet_unregister_irq_handler(rtc_irq_handler handler);
+extern void hpet_set_comparator(int num, unsigned int cmp, unsigned int period);
 
 #endif /* CONFIG_HPET_EMULATE_RTC */
 
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 5e86e024c489..1723d55219e8 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -290,6 +290,47 @@ static void hpet_legacy_clockevent_register(void)
 	printk(KERN_DEBUG "hpet clockevent registered\n");
 }
 
+/**
+ * hpet_set_comparator() - Helper function for setting comparator register
+ * @num:	The timer ID
+ * @cmp:	The value to be written to the comparator/accumulator
+ * @period:	The value to be written to the period (0 = oneshot mode)
+ *
+ * Helper function for updating comparator, accumulator and period values.
+ *
+ * In periodic mode, HPET needs HPET_TN_SETVAL to be set before writing
+ * to the Tn_CMP to update the accumulator. Then, HPET needs a second
+ * write (with HPET_TN_SETVAL cleared) to Tn_CMP to set the period.
+ * The HPET_TN_SETVAL bit is automatically cleared after the first write.
+ *
+ * For one-shot mode, HPET_TN_SETVAL does not need to be set.
+ *
+ * See the following documents:
+ *   - Intel IA-PC HPET (High Precision Event Timers) Specification
+ *   - AMD-8111 HyperTransport I/O Hub Data Sheet, Publication # 24674
+ */
+void hpet_set_comparator(int num, unsigned int cmp, unsigned int period)
+{
+	if (period) {
+		unsigned int v = hpet_readl(HPET_Tn_CFG(num));
+
+		hpet_writel(v | HPET_TN_SETVAL, HPET_Tn_CFG(num));
+	}
+
+	hpet_writel(cmp, HPET_Tn_CMP(num));
+
+	if (!period)
+		return;
+
+	/*
+	 * This delay is seldom used: never in one-shot mode and in periodic
+	 * only when reprogramming the timer.
+	 */
+	udelay(1);
+	hpet_writel(period, HPET_Tn_CMP(num));
+}
+EXPORT_SYMBOL_GPL(hpet_set_comparator);
+
 static int hpet_set_periodic(struct clock_event_device *evt, int timer)
 {
 	unsigned int cfg, cmp, now;
@@ -301,19 +342,11 @@ static int hpet_set_periodic(struct clock_event_device *evt, int timer)
 	now = hpet_readl(HPET_COUNTER);
 	cmp = now + (unsigned int)delta;
 	cfg = hpet_readl(HPET_Tn_CFG(timer));
-	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
-	       HPET_TN_32BIT;
+	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_32BIT;
 	hpet_writel(cfg, HPET_Tn_CFG(timer));
-	hpet_writel(cmp, HPET_Tn_CMP(timer));
-	udelay(1);
-	/*
-	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
-	 * cleared) to T0_CMP to set the period. The HPET_TN_SETVAL
-	 * bit is automatically cleared after the first write.
-	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
-	 * Publication # 24674)
-	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(timer));
+
+	hpet_set_comparator(timer, cmp, (unsigned int)delta);
+
 	hpet_start_counter();
 	hpet_print_config();
 
-- 
2.17.1

