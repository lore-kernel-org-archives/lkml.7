Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C7C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D3820815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HI1kDQRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF0Xul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:50:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0Xul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:50:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNoP3i503618
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:50:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNoP3i503618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679426;
        bh=0NqLkfcISBhc/k5BDMm3VpbTkboYyzQJ3BBzqvL3SVk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HI1kDQRnK/dHZuK6SVNENkzHEjGwca5xRFeOXoB5/cfH9RciIDPKhre9A9YimYgap
         LKPUNbor2FOFVwENP3x3t/zQmBLcdp6UOBBITl/zjvD8ObMmikWA8CiKdKoulZYpsb
         Da73DlkeEml02Ug5DhONZ+09jHChNIrbg3pvUiahn0zvELsr4KdrMA0+Xg6RlM0rfE
         enrVNHXQQnzrwq+abjTO+nlPifI7gHRusG0aTKTHzImZd3IXW2xZC9nh1HAKzio9ub
         lwggUPnTEHgqAsdaJyiZ44QOpt/bDyqPDNiK5IvxuBCh9XLTrLr9Vi9hMe6HTIpyfH
         vH8RAQQtHejdg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNoPdn503615;
        Thu, 27 Jun 2019 16:50:25 -0700
Date:   Thu, 27 Jun 2019 16:50:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-45e0a415634600e608188480bc355b20344f9e3f@git.kernel.org>
Cc:     andi.kleen@intel.com, ricardo.neri-calderon@linux.intel.com,
        eranian@google.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        ravi.v.shankar@intel.com, tglx@linutronix.de,
        Suravee.Suthikulpanit@amd.com, peterz@infradead.org,
        ashok.raj@intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, ashok.raj@intel.com, peterz@infradead.org,
          tglx@linutronix.de, Suravee.Suthikulpanit@amd.com,
          andi.kleen@intel.com, ravi.v.shankar@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          eranian@google.com, ricardo.neri-calderon@linux.intel.com
In-Reply-To: <20190623132436.277510163@linutronix.de>
References: <20190623132436.277510163@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Use cached info instead of extra flags
Git-Commit-ID: 45e0a415634600e608188480bc355b20344f9e3f
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

Commit-ID:  45e0a415634600e608188480bc355b20344f9e3f
Gitweb:     https://git.kernel.org/tip/45e0a415634600e608188480bc355b20344f9e3f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:04 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:25 +0200

x86/hpet: Use cached info instead of extra flags

Now that HPET clockevent support is integrated into the channel data, reuse
the cached boot configuration instead of copying the same information into
a flags field.

This also allows to consolidate the reservation code into one place, which
can now solely depend on the mode information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132436.277510163@linutronix.de

---
 arch/x86/kernel/hpet.c | 76 +++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 7f76f07138a6..985a2246d20c 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -25,8 +25,8 @@ struct hpet_channel {
 	unsigned int			num;
 	unsigned int			cpu;
 	unsigned int			irq;
+	unsigned int			in_use;
 	enum hpet_mode			mode;
-	unsigned int			flags;
 	unsigned int			boot_cfg;
 	char				name[10];
 };
@@ -40,12 +40,6 @@ struct hpet_base {
 
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
-#define HPET_DEV_USED_BIT		2
-#define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
-#define HPET_DEV_VALID			0x8
-#define HPET_DEV_FSB_CAP		0x1000
-#define HPET_DEV_PERI_CAP		0x2000
-
 #define HPET_MIN_CYCLES			128
 #define HPET_MIN_PROG_DELTA		(HPET_MIN_CYCLES + (HPET_MIN_CYCLES >> 1))
 
@@ -62,6 +56,7 @@ static struct irq_domain		*hpet_domain;
 #endif
 
 static void __iomem			*hpet_virt_address;
+
 static struct hpet_base			hpet_base;
 
 static bool				hpet_legacy_int_enabled;
@@ -190,8 +185,6 @@ do {								\
  */
 #ifdef CONFIG_HPET
 
-static void hpet_reserve_msi_timers(struct hpet_data *hd);
-
 static void __init hpet_reserve_platform_timers(void)
 {
 	struct hpet_data hd;
@@ -201,11 +194,6 @@ static void __init hpet_reserve_platform_timers(void)
 	hd.hd_phys_address	= hpet_address;
 	hd.hd_address		= hpet_virt_address;
 	hd.hd_nirqs		= hpet_base.nr_channels;
-	hpet_reserve_timer(&hd, 0);
-
-#ifdef CONFIG_HPET_EMULATE_RTC
-	hpet_reserve_timer(&hd, 1);
-#endif
 
 	/*
 	 * NOTE that hd_irq[] reflects IOAPIC input pins (LEGACY_8254
@@ -215,13 +203,25 @@ static void __init hpet_reserve_platform_timers(void)
 	hd.hd_irq[0] = HPET_LEGACY_8254;
 	hd.hd_irq[1] = HPET_LEGACY_RTC;
 
-	for (i = 2; i < hpet_base.nr_channels; i++)
-		hd.hd_irq[i] = hpet_base.channels[i].irq;
+	for (i = 0; i < hpet_base.nr_channels; i++) {
+		struct hpet_channel *hc = hpet_base.channels + i;
 
-	hpet_reserve_msi_timers(&hd);
+		if (i >= 2)
+			hd.hd_irq[i] = hc->irq;
 
-	hpet_alloc(&hd);
+		switch (hc->mode) {
+		case HPET_MODE_UNUSED:
+		case HPET_MODE_DEVICE:
+			hc->mode = HPET_MODE_DEVICE;
+			break;
+		case HPET_MODE_CLOCKEVT:
+		case HPET_MODE_LEGACY:
+			hpet_reserve_timer(&hd, hc->num);
+			break;
+		}
+	}
 
+	hpet_alloc(&hd);
 }
 
 static void __init hpet_select_device_channel(void)
@@ -543,13 +543,11 @@ static int hpet_setup_irq(struct hpet_channel *hc)
 	return 0;
 }
 
+/* Invoked from the hotplug callback on @cpu */
 static void init_one_hpet_msi_clockevent(struct hpet_channel *hc, int cpu)
 {
 	struct clock_event_device *evt = &hc->evt;
 
-	if (!(hc->flags & HPET_DEV_VALID))
-		return;
-
 	hc->cpu = cpu;
 	per_cpu(cpu_hpet_channel, cpu) = hc;
 	evt->name = hc->name;
@@ -558,7 +556,7 @@ static void init_one_hpet_msi_clockevent(struct hpet_channel *hc, int cpu)
 
 	evt->rating = 110;
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	if (hc->flags & HPET_DEV_PERI_CAP) {
+	if (hc->boot_cfg & HPET_TN_PERIODIC) {
 		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
 		evt->set_state_periodic = hpet_msi_set_periodic;
 	}
@@ -580,11 +578,9 @@ static struct hpet_channel *hpet_get_unused_clockevent(void)
 	for (i = 0; i < hpet_base.nr_channels; i++) {
 		struct hpet_channel *hc = hpet_base.channels + i;
 
-		if (!(hc->flags & HPET_DEV_VALID))
-			continue;
-		if (test_and_set_bit(HPET_DEV_USED_BIT,
-			(unsigned long *)&hc->flags))
+		if (hc->mode != HPET_MODE_CLOCKEVT || hc->in_use)
 			continue;
+		hc->in_use = 1;
 		return hc;
 	}
 	return NULL;
@@ -606,7 +602,7 @@ static int hpet_cpuhp_dead(unsigned int cpu)
 	if (!hc)
 		return 0;
 	free_irq(hc->irq, hc);
-	hc->flags &= ~HPET_DEV_USED;
+	hc->in_use = 0;
 	per_cpu(cpu_hpet_channel, cpu) = NULL;
 	return 0;
 }
@@ -638,9 +634,6 @@ static void __init hpet_select_clockevents(void)
 		if (!(hc->boot_cfg & HPET_TN_FSB_CAP))
 			continue;
 
-		hc->flags = 0;
-		if (hc->boot_cfg & HPET_TN_PERIODIC_CAP)
-			hc->flags |= HPET_DEV_PERI_CAP;
 		sprintf(hc->name, "hpet%d", i);
 
 		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
@@ -648,8 +641,6 @@ static void __init hpet_select_clockevents(void)
 			continue;
 
 		hc->irq = irq;
-		hc->flags |= HPET_DEV_FSB_CAP;
-		hc->flags |= HPET_DEV_VALID;
 		hc->mode = HPET_MODE_CLOCKEVT;
 
 		if (++hpet_base.nr_clockevents == num_possible_cpus())
@@ -660,31 +651,10 @@ static void __init hpet_select_clockevents(void)
 		hpet_base.nr_channels, hpet_base.nr_clockevents);
 }
 
-#ifdef CONFIG_HPET
-static void __init hpet_reserve_msi_timers(struct hpet_data *hd)
-{
-	int i;
-
-	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_channel *hc = hpet_base.channels + i;
-
-		if (!(hc->flags & HPET_DEV_VALID))
-			continue;
-
-		hd->hd_irq[hc->num] = hc->irq;
-		hpet_reserve_timer(hd, hc->num);
-	}
-}
-#endif
-
 #else
 
 static inline void hpet_select_clockevents(void) { }
 
-#ifdef CONFIG_HPET
-static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
-#endif
-
 #define hpet_cpuhp_online	NULL
 #define hpet_cpuhp_dead		NULL
 
