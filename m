Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B6C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAD020679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfFWN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfFWN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X5-0001l5-2s; Sun, 23 Jun 2019 15:27:47 +0200
Message-Id: <20190623132435.728456320@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:58 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 18/29] x86/hpet: Introduce struct hpet_base and struct
 hpet_channel
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new data structures to replace the ad hoc collection of separate
variables and pointers.

Replace the boot configuration store and restore as a first step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   84 ++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 35 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -22,6 +22,17 @@ struct hpet_dev {
 	char				name[10];
 };
 
+struct hpet_channel {
+	unsigned int			num;
+	unsigned int			boot_cfg;
+};
+
+struct hpet_base {
+	unsigned int			nr_channels;
+	unsigned int			boot_cfg;
+	struct hpet_channel		*channels;
+};
+
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
 #define HPET_DEV_USED_BIT		2
@@ -48,7 +59,7 @@ static struct irq_domain		*hpet_domain;
 #endif
 
 static void __iomem			*hpet_virt_address;
-static u32				*hpet_boot_cfg;
+static struct hpet_base			hpet_base;
 
 static bool				hpet_legacy_int_enabled;
 static unsigned long			hpet_freq;
@@ -860,6 +871,7 @@ int __init hpet_enable(void)
 {
 	u32 hpet_period, cfg, id;
 	unsigned int i, channels;
+	struct hpet_channel *hc;
 	u64 freq;
 
 	if (!is_hpet_capable())
@@ -899,34 +911,39 @@ int __init hpet_enable(void)
 	/* This is the HPET channel number which is zero based */
 	channels = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
 
-#ifdef CONFIG_HPET_EMULATE_RTC
 	/*
 	 * The legacy routing mode needs at least two channels, tick timer
 	 * and the rtc emulation channel.
 	 */
-	if (channels < 2)
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
-	/* Allocate entries for the global and the channel configurations */
-	hpet_boot_cfg = kmalloc_array(channels + 1, sizeof(*hpet_boot_cfg),
-				      GFP_KERNEL);
-	if (hpet_boot_cfg)
-		*hpet_boot_cfg = cfg;
-	else
-		pr_warn("HPET initial state will not be saved\n");
+	hpet_base.boot_cfg = cfg;
 	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
 	hpet_writel(cfg, HPET_CFG);
 	if (cfg)
 		pr_warn("Global config: Unknown bits %#x\n", cfg);
 
-	for (i = 0; i < channels; ++i) {
+	/* Read, store and sanitize the per channel configuration */
+	for (i = 0; i < channels; i++, hc++) {
+		hc->num = i;
+
 		cfg = hpet_readl(HPET_Tn_CFG(i));
-		if (hpet_boot_cfg)
-			hpet_boot_cfg[i + 1] = cfg;
+		hc->boot_cfg = cfg;
+
 		cfg &= ~(HPET_TN_ENABLE | HPET_TN_LEVEL | HPET_TN_FSB);
 		hpet_writel(cfg, HPET_Tn_CFG(i));
+
 		cfg &= ~(HPET_TN_PERIODIC | HPET_TN_PERIODIC_CAP
 			 | HPET_TN_64BIT_CAP | HPET_TN_32BIT | HPET_TN_ROUTE
 			 | HPET_TN_FSB | HPET_TN_FSB_CAP);
@@ -944,6 +961,9 @@ int __init hpet_enable(void)
 	return 0;
 
 out_nohpet:
+	kfree(hpet_base.channels);
+	hpet_base.channels = NULL;
+	hpet_base.nr_channels = 0;
 	hpet_clear_mapping();
 	hpet_address = 0;
 	return 0;
@@ -1000,30 +1020,24 @@ fs_initcall(hpet_late_init);
 
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
-
-		if (!hpet_boot_cfg)
-			return;
+	unsigned int i;
+	u32 cfg;
 
-		id = hpet_readl(HPET_ID);
-		last = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT);
+	if (!is_hpet_capable() || !hpet_virt_address)
+		return;
 
-		for (id = 0; id <= last; ++id)
-			hpet_writel(hpet_boot_cfg[id + 1], HPET_Tn_CFG(id));
+	/* Restore boot configuration with the enable bit cleared */
+	cfg = hpet_base.boot_cfg;
+	cfg &= ~HPET_CFG_ENABLE;
+	hpet_writel(cfg, HPET_CFG);
 
-		if (*hpet_boot_cfg & HPET_CFG_ENABLE)
-			hpet_writel(*hpet_boot_cfg, HPET_CFG);
-	}
+	/* Restore the channel boot configuration */
+	for (i = 0; i < hpet_base.nr_channels; i++)
+		hpet_writel(hpet_base.channels[i].boot_cfg, HPET_Tn_CFG(i));
+
+	/* If the HPET was enabled at boot time, reenable it */
+	if (hpet_base.boot_cfg & HPET_CFG_ENABLE)
+		hpet_writel(hpet_base.boot_cfg, HPET_CFG);
 }
 
 #ifdef CONFIG_HPET_EMULATE_RTC


