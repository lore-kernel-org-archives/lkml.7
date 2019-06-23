Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5977C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A879120665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfFWN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:28:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfFWN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2X5-0001lD-Pw; Sun, 23 Jun 2019 15:27:47 +0200
Message-Id: <20190623132435.821728550@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:59 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 19/29] x86/hpet: Use cached channel data
References: <20190623132340.463097504@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of rereading the HPET registers over and over use the information
which was cached in hpet_enable().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/hpet.c |   41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -24,6 +24,7 @@ struct hpet_dev {
 
 struct hpet_channel {
 	unsigned int			num;
+	unsigned int			irq;
 	unsigned int			boot_cfg;
 };
 
@@ -52,7 +53,6 @@ u8					hpet_blockid; /* OS timer block n
 bool					hpet_msi_disable;
 
 #ifdef CONFIG_PCI_MSI
-static unsigned int			hpet_num_timers;
 static struct hpet_dev			*hpet_devs;
 static DEFINE_PER_CPU(struct hpet_dev *, cpu_hpet_dev);
 static struct irq_domain		*hpet_domain;
@@ -189,19 +189,15 @@ do {								\
 
 static void hpet_reserve_msi_timers(struct hpet_data *hd);
 
-static void __init hpet_reserve_platform_timers(unsigned int id)
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
+	hd.hd_address		= hpet_virt_address;
+	hd.hd_nirqs		= hpet_base.nr_channels;
 	hpet_reserve_timer(&hd, 0);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
@@ -216,10 +212,8 @@ static void __init hpet_reserve_platform
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < nrtimers; timer++, i++) {
-		hd.hd_irq[i] = (readl(&timer->hpet_config) &
-			Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
-	}
+	for (i = 2; i < hpet_base.nr_channels; i++)
+		hd.hd_irq[i] = hpet_base.channels[i].irq;
 
 	hpet_reserve_msi_timers(&hd);
 
@@ -227,7 +221,7 @@ static void __init hpet_reserve_platform
 
 }
 #else
-static void hpet_reserve_platform_timers(unsigned int id) { }
+static inline void hpet_reserve_platform_timers(void) { }
 #endif
 
 /* Common HPET functions */
@@ -569,7 +563,7 @@ static struct hpet_dev *hpet_get_unused_
 	if (!hpet_devs)
 		return NULL;
 
-	for (i = 0; i < hpet_num_timers; i++) {
+	for (i = 0; i < hpet_base.nr_channels; i++) {
 		struct hpet_dev *hdev = &hpet_devs[i];
 
 		if (!(hdev->flags & HPET_DEV_VALID))
@@ -612,7 +606,6 @@ static int hpet_cpuhp_dead(unsigned int
 
 static void __init hpet_msi_capability_lookup(unsigned int start_timer)
 {
-	unsigned int id;
 	unsigned int num_timers;
 	unsigned int num_timers_used = 0;
 	int i, irq;
@@ -622,10 +615,8 @@ static void __init hpet_msi_capability_l
 
 	if (boot_cpu_has(X86_FEATURE_ARAT))
 		return;
-	id = hpet_readl(HPET_ID);
 
-	num_timers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT);
-	num_timers++; /* Value read out starts from 0 */
+	num_timers = hpet_base.nr_channels;
 	hpet_print_config();
 
 	hpet_domain = hpet_create_irq_domain(hpet_blockid);
@@ -636,11 +627,9 @@ static void __init hpet_msi_capability_l
 	if (!hpet_devs)
 		return;
 
-	hpet_num_timers = num_timers;
-
 	for (i = start_timer; i < num_timers - RESERVE_TIMERS; i++) {
 		struct hpet_dev *hdev = &hpet_devs[num_timers_used];
-		unsigned int cfg = hpet_readl(HPET_Tn_CFG(i));
+		unsigned int cfg = hpet_base.channels[i].boot_cfg;
 
 		/* Only consider HPET timer with MSI support */
 		if (!(cfg & HPET_TN_FSB_CAP))
@@ -676,7 +665,7 @@ static void __init hpet_reserve_msi_time
 	if (!hpet_devs)
 		return;
 
-	for (i = 0; i < hpet_num_timers; i++) {
+	for (i = 0; i < hpet_base.nr_channels; i++) {
 		struct hpet_dev *hdev = &hpet_devs[i];
 
 		if (!(hdev->flags & HPET_DEV_VALID))
@@ -869,7 +858,7 @@ static bool __init hpet_counting(void)
  */
 int __init hpet_enable(void)
 {
-	u32 hpet_period, cfg, id;
+	u32 hpet_period, cfg, id, irq;
 	unsigned int i, channels;
 	struct hpet_channel *hc;
 	u64 freq;
@@ -940,6 +929,8 @@ int __init hpet_enable(void)
 
 		cfg = hpet_readl(HPET_Tn_CFG(i));
 		hc->boot_cfg = cfg;
+		irq = (cfg & Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
+		hc->irq = irq;
 
 		cfg &= ~(HPET_TN_ENABLE | HPET_TN_LEVEL | HPET_TN_FSB);
 		hpet_writel(cfg, HPET_Tn_CFG(i));
@@ -993,7 +984,7 @@ static __init int hpet_late_init(void)
 	else
 		hpet_msi_capability_lookup(0);
 
-	hpet_reserve_platform_timers(hpet_readl(HPET_ID));
+	hpet_reserve_platform_timers();
 	hpet_print_config();
 
 	if (hpet_msi_disable)


