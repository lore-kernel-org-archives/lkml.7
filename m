Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798DC5B576
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1448D20815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rC85mDy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfF0Xt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:49:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0XtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:49:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNk9T5502982
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:46:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNk9T5502982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679170;
        bh=GLiZ6oeTiNCm4IhwvOqm952elaz/4nSzRiT6lsznGcY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rC85mDy6jQhRSO+6dfgarf5ftBy8q3LrGPX63Jj4y38DGw9E2qyhZhFC4wX4hIKCZ
         oUNtW4Im8pfrvta8TcqMtb7MQSOSCLN2sfkdZWiihv9DjPVI387XTS2cOPpFCJMPQf
         XZx1pErt1CsGqIWaRsVHtSRn0pTsLdvb5HoLdS+UxUoGSew1RKzVFXv4TvTYy9zhe5
         9Tw860PavqdjUp5PxiqgueUVtBoBPMScQDtm12z7YtvtGwC218szWE4QI0CcJfaBDK
         Cf0J054keBrltGiDIk9gp9zE87Yxapkcelr9Rh3sEi8EDUdWr2zYAJraCA1GCtgaWx
         tg6zB8xYN8DMg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNk9DE502979;
        Thu, 27 Jun 2019 16:46:09 -0700
Date:   Thu, 27 Jun 2019 16:46:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e37f0881e9d9ec8b12f242cc2b78d93259aa7f0f@git.kernel.org>
Cc:     eranian@google.com, mingo@kernel.org,
        ricardo.neri-calderon@linux.intel.com, andi.kleen@intel.com,
        ashok.raj@intel.com, peterz@infradead.org, hpa@zytor.com,
        ravi.v.shankar@intel.com, tglx@linutronix.de,
        Suravee.Suthikulpanit@amd.com, linux-kernel@vger.kernel.org
Reply-To: eranian@google.com, ricardo.neri-calderon@linux.intel.com,
          mingo@kernel.org, ashok.raj@intel.com, andi.kleen@intel.com,
          tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
          Suravee.Suthikulpanit@amd.com
In-Reply-To: <20190623132435.728456320@linutronix.de>
References: <20190623132435.728456320@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Introduce struct hpet_base and struct
 hpet_channel
Git-Commit-ID: e37f0881e9d9ec8b12f242cc2b78d93259aa7f0f
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

Commit-ID:  e37f0881e9d9ec8b12f242cc2b78d93259aa7f0f
Gitweb:     https://git.kernel.org/tip/e37f0881e9d9ec8b12f242cc2b78d93259aa7f0f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:21 +0200

x86/hpet: Introduce struct hpet_base and struct hpet_channel

Introduce new data structures to replace the ad hoc collection of separate
variables and pointers.

Replace the boot configuration store and restore as a first step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132435.728456320@linutronix.de

---
 arch/x86/kernel/hpet.c | 82 +++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index ed2d556f2c96..59a81d7fd05b 100644
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
+	unsigned int i;
+	u32 cfg;
 
-		if (!hpet_boot_cfg)
-			return;
+	if (!is_hpet_capable() || !hpet_virt_address)
+		return;
 
-		id = hpet_readl(HPET_ID);
-		last = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT);
+	/* Restore boot configuration with the enable bit cleared */
+	cfg = hpet_base.boot_cfg;
+	cfg &= ~HPET_CFG_ENABLE;
+	hpet_writel(cfg, HPET_CFG);
 
-		for (id = 0; id <= last; ++id)
-			hpet_writel(hpet_boot_cfg[id + 1], HPET_Tn_CFG(id));
+	/* Restore the channel boot configuration */
+	for (i = 0; i < hpet_base.nr_channels; i++)
+		hpet_writel(hpet_base.channels[i].boot_cfg, HPET_Tn_CFG(i));
 
-		if (*hpet_boot_cfg & HPET_CFG_ENABLE)
-			hpet_writel(*hpet_boot_cfg, HPET_CFG);
-	}
+	/* If the HPET was enabled at boot time, reenable it */
+	if (hpet_base.boot_cfg & HPET_CFG_ENABLE)
+		hpet_writel(hpet_base.boot_cfg, HPET_CFG);
 }
 
 #ifdef CONFIG_HPET_EMULATE_RTC
