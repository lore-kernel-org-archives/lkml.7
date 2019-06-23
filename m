Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B95C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DE820665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfFWN1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wv-0001j6-K7; Sun, 23 Jun 2019 15:27:37 +0200
Message-Id: <20190623132434.247842972@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:43 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 03/29] x86/hpet: Restructure init code
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory change for further consolidation, restructure the HPET
init code so it becomes more readable. Fix up misleading and stale comments
and rename variables so they actually make sense.

No intended functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   81 ++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -45,6 +45,7 @@ bool					hpet_msi_disable;
 static unsigned int			hpet_num_timers;
 #endif
 static void __iomem			*hpet_virt_address;
+static u32				*hpet_boot_cfg;
 
 struct hpet_dev {
 	struct clock_event_device	evt;
@@ -862,7 +863,34 @@ static int hpet_clocksource_register(voi
 	return 0;
 }
 
-static u32 *hpet_boot_cfg;
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
+{
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
 
 /**
  * hpet_enable - Try to setup the HPET timer. Returns 1 on success.
@@ -870,8 +898,8 @@ static u32 *hpet_boot_cfg;
 int __init hpet_enable(void)
 {
 	u32 hpet_period, cfg, id;
+	unsigned int i, channels;
 	u64 freq;
-	unsigned int i, last;
 
 	if (!is_hpet_capable())
 		return 0;
@@ -880,38 +908,18 @@ int __init hpet_enable(void)
 	if (!hpet_virt_address)
 		return 0;
 
+	/* Validate that the config register is working */
+	if (!hpet_cfg_working())
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
-			pr_warn("Config register invalid. Disabling HPET\n");
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
@@ -923,19 +931,21 @@ int __init hpet_enable(void)
 	id = hpet_readl(HPET_ID);
 	hpet_print_config();
 
-	last = (id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT;
+	/* This is the HPET channel number which is zero based */
+	channels = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 	/*
 	 * The legacy routing mode needs at least two channels, tick timer
 	 * and the rtc emulation channel.
 	 */
-	if (!last)
+	if (channels < 2)
 		goto out_nohpet;
 #endif
 
 	cfg = hpet_readl(HPET_CFG);
-	hpet_boot_cfg = kmalloc_array(last + 2, sizeof(*hpet_boot_cfg),
+	/* Allocate entries for the global and the channel configurations */
+	hpet_boot_cfg = kmalloc_array(channels + 1, sizeof(*hpet_boot_cfg),
 				      GFP_KERNEL);
 	if (hpet_boot_cfg)
 		*hpet_boot_cfg = cfg;
@@ -946,7 +956,7 @@ int __init hpet_enable(void)
 	if (cfg)
 		pr_warn("Global config: Unknown bits %#x\n", cfg);
 
-	for (i = 0; i <= last; ++i) {
+	for (i = 0; i < channels; ++i) {
 		cfg = hpet_readl(HPET_Tn_CFG(i));
 		if (hpet_boot_cfg)
 			hpet_boot_cfg[i + 1] = cfg;
@@ -976,18 +986,13 @@ int __init hpet_enable(void)
 }
 
 /*
- * Needs to be late, as the reserve_timer code calls kalloc !
- *
- * Not a problem on i386 as hpet_enable is called from late_time_init,
- * but on x86_64 it is necessary !
+ * The late initialization runs after the PCI quirks have been invoked
+ * which might have detected a system on which the HPET can be enforced.
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


