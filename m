Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005FCC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8620B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PqFDaURQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF0XuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:50:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0XuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:50:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNkpEl503019
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:46:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNkpEl503019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679213;
        bh=xU0Hg5ZNYgEEbybxxMs12dKLCgHm0S9z86kkddPXLdg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PqFDaURQ9Hyc5AdDMPrNcSVQQ/AbM7R1MI+pgCAOkX/EeStt4s12YeynDLJs5/188
         9i+M/f8xkNY3LZmshiF9HncP0xTXbr2+l/+04WYtar39UQuJtUimUMLt7yUQKveht9
         32avslPygldkgW+jlQ+5BLAP2DwinkAc7RTcu2eNfhGhoqaV7p5z0UPAF8+xgA/eXr
         YEIXIugFgsg9tGn8X3Ph3XNk6KeGkjadGyJt7Lh+l2sUD7aubnuSaYsMJmzSJjOIEt
         wcH8jmmSiejHvPAZFicjB/iUFUbKYAy4sH8AayepmJMa+kVlMCRwpEqSigCy2c59AN
         miYXYRL7hjdsg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNko3q503016;
        Thu, 27 Jun 2019 16:46:50 -0700
Date:   Thu, 27 Jun 2019 16:46:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2460d5878ad69c178f9ff1cc3eee9f09b017e15f@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, andi.kleen@intel.com,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        ricardo.neri-calderon@linux.intel.com, mingo@kernel.org,
        ravi.v.shankar@intel.com, Suravee.Suthikulpanit@amd.com,
        peterz@infradead.org, eranian@google.com
Reply-To: andi.kleen@intel.com, ravi.v.shankar@intel.com,
          Suravee.Suthikulpanit@amd.com, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          ricardo.neri-calderon@linux.intel.com, eranian@google.com,
          ashok.raj@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190623132435.821728550@linutronix.de>
References: <20190623132435.821728550@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Use cached channel data
Git-Commit-ID: 2460d5878ad69c178f9ff1cc3eee9f09b017e15f
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

Commit-ID:  2460d5878ad69c178f9ff1cc3eee9f09b017e15f
Gitweb:     https://git.kernel.org/tip/2460d5878ad69c178f9ff1cc3eee9f09b017e15f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:22 +0200

x86/hpet: Use cached channel data

Instead of rereading the HPET registers over and over use the information
which was cached in hpet_enable().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132435.821728550@linutronix.de

---
 arch/x86/kernel/hpet.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 59a81d7fd05b..8711f1fdef8f 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -24,6 +24,7 @@ struct hpet_dev {
 
 struct hpet_channel {
 	unsigned int			num;
+	unsigned int			irq;
 	unsigned int			boot_cfg;
 };
 
@@ -52,7 +53,6 @@ u8					hpet_blockid; /* OS timer block num */
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
@@ -216,10 +212,8 @@ static void __init hpet_reserve_platform_timers(unsigned int id)
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < nrtimers; timer++, i++) {
-		hd.hd_irq[i] = (readl(&timer->hpet_config) &
-			Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
-	}
+	for (i = 2; i < hpet_base.nr_channels; i++)
+		hd.hd_irq[i] = hpet_base.channels[i].irq;
 
 	hpet_reserve_msi_timers(&hd);
 
@@ -227,7 +221,7 @@ static void __init hpet_reserve_platform_timers(unsigned int id)
 
 }
 #else
-static void hpet_reserve_platform_timers(unsigned int id) { }
+static inline void hpet_reserve_platform_timers(void) { }
 #endif
 
 /* Common HPET functions */
@@ -569,7 +563,7 @@ static struct hpet_dev *hpet_get_unused_timer(void)
 	if (!hpet_devs)
 		return NULL;
 
-	for (i = 0; i < hpet_num_timers; i++) {
+	for (i = 0; i < hpet_base.nr_channels; i++) {
 		struct hpet_dev *hdev = &hpet_devs[i];
 
 		if (!(hdev->flags & HPET_DEV_VALID))
@@ -612,7 +606,6 @@ static int hpet_cpuhp_dead(unsigned int cpu)
 
 static void __init hpet_msi_capability_lookup(unsigned int start_timer)
 {
-	unsigned int id;
 	unsigned int num_timers;
 	unsigned int num_timers_used = 0;
 	int i, irq;
@@ -622,10 +615,8 @@ static void __init hpet_msi_capability_lookup(unsigned int start_timer)
 
 	if (boot_cpu_has(X86_FEATURE_ARAT))
 		return;
-	id = hpet_readl(HPET_ID);
 
-	num_timers = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT);
-	num_timers++; /* Value read out starts from 0 */
+	num_timers = hpet_base.nr_channels;
 	hpet_print_config();
 
 	hpet_domain = hpet_create_irq_domain(hpet_blockid);
@@ -636,11 +627,9 @@ static void __init hpet_msi_capability_lookup(unsigned int start_timer)
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
@@ -676,7 +665,7 @@ static void __init hpet_reserve_msi_timers(struct hpet_data *hd)
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
