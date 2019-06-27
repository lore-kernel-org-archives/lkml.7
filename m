Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759ACC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3323A2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tpFIce9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF0Xfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:35:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:35:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNZWuS499356
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:35:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNZWuS499356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561678533;
        bh=GDD0RD3D8tBGOCeEmdiqAPpilifxpwWw21JHgW1m+bM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=tpFIce9ve2zzdx3KvU0tECWWWGtofYAmYhn4VTRqFdd/48OrnUdXiJQF9FNIrTZWs
         Tv5mWRUreckJgc6AEg0ZBhcRoL1nfOG6WNSRbJ8vc+WqxO4nltQDfSg0z6Iu+G9r+u
         nKfCKOWlltYt3//ti+ZZ/XrSiwv7IdHNSh1EbpDfuhqbXpTIH+KwijSAvgft1Ddteb
         RAEwx+J3rnYAwe35ld0SpcGTnGdSQfUuyRzB0lIcODOdH0+8vz+trrrri3FRDVFWWX
         hL6AOs49yneKPZdjEuHWet/wea4YtIGJZjBQlVxdS+Mxx3dKueDHRNZW6k0PsD7fT2
         TvdH4NDgDnX+Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNZVSA499353;
        Thu, 27 Jun 2019 16:35:31 -0700
Date:   Thu, 27 Jun 2019 16:35:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9b0b28de837a3a59b409613d15e90d5569938945@git.kernel.org>
Cc:     andi.kleen@intel.com, Suravee.Suthikulpanit@amd.com,
        ravi.v.shankar@intel.com, mingo@kernel.org, ashok.raj@intel.com,
        ricardo.neri-calderon@linux.intel.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        eranian@google.com
Reply-To: linux-kernel@vger.kernel.org, eranian@google.com,
          peterz@infradead.org, mingo@kernel.org, ravi.v.shankar@intel.com,
          Suravee.Suthikulpanit@amd.com, ashok.raj@intel.com,
          andi.kleen@intel.com, hpa@zytor.com, tglx@linutronix.de,
          ricardo.neri-calderon@linux.intel.com
In-Reply-To: <20190623132434.247842972@linutronix.de>
References: <20190623132434.247842972@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Restructure init code
Git-Commit-ID: 9b0b28de837a3a59b409613d15e90d5569938945
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

Commit-ID:  9b0b28de837a3a59b409613d15e90d5569938945
Gitweb:     https://git.kernel.org/tip/9b0b28de837a3a59b409613d15e90d5569938945
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:23:43 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:15 +0200

x86/hpet: Restructure init code

As a preparatory change for further consolidation, restructure the HPET
init code so it becomes more readable. Fix up misleading and stale comments
and rename variables so they actually make sense.

No intended functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132434.247842972@linutronix.de

---
 arch/x86/kernel/hpet.c | 81 +++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index cf3dbf43e548..daa97e14296b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -45,6 +45,7 @@ bool					hpet_msi_disable;
 static unsigned int			hpet_num_timers;
 #endif
 static void __iomem			*hpet_virt_address;
+static u32				*hpet_boot_cfg;
 
 struct hpet_dev {
 	struct clock_event_device	evt;
@@ -862,7 +863,34 @@ static int hpet_clocksource_register(void)
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
@@ -976,18 +986,13 @@ out_nohpet:
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
