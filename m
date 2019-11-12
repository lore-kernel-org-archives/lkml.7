Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF86C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F6420818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKLOtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:49:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34589 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:49:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUXTs-0004jL-Vg; Tue, 12 Nov 2019 15:49:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 54BB21C0084;
        Tue, 12 Nov 2019 15:49:20 +0100 (CET)
Date:   Tue, 12 Nov 2019 14:49:19 -0000
From:   "tip-bot2 for Rahul Tanwar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/init: Allow DT configured systems to disable RTC
 at boot time
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb84d9152ce0c1c09896ff4987e691a0715cb02df=2E15706?=
 =?utf-8?q?93058=2Egit=2Erahul=2Etanwar=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3Cb84d9152ce0c1c09896ff4987e691a0715cb02df=2E157069?=
 =?utf-8?q?3058=2Egit=2Erahul=2Etanwar=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <157357015991.29376.16358106600464439915.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     c311ed6183f4fd137bb8451ef77f4011c225ddaf
Gitweb:        https://git.kernel.org/tip/c311ed6183f4fd137bb8451ef77f4011c225ddaf
Author:        Rahul Tanwar <rahul.tanwar@linux.intel.com>
AuthorDate:    Thu, 10 Oct 2019 17:28:56 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Nov 2019 15:46:53 +01:00

x86/init: Allow DT configured systems to disable RTC at boot time

Systems which do not support RTC run into boot problems as the kernel
assumes the availability of the RTC by default.

On device tree configured systems the availability of the RTC can be
detected by querying the corresponding device tree node.

Implement a wallclock init function to query the device tree and disable
RTC if the RTC is marked as not available in the corresponding node.

[ tglx: Rewrote changelog and comments. Added proper __init(const)
  	annotations. ]

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/b84d9152ce0c1c09896ff4987e691a0715cb02df.1570693058.git.rahul.tanwar@linux.intel.com
---
 arch/x86/kernel/x86_init.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 18a799c..ce89430 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -31,6 +31,28 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
+static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+static __init void get_rtc_noop(struct timespec64 *now) { }
+
+static __initconst const struct of_device_id of_cmos_match[] = {
+	{ .compatible = "motorola,mc146818" },
+	{}
+};
+
+/*
+ * Allow devicetree configured systems to disable the RTC by setting the
+ * corresponding DT node's status property to disabled. Code is optimized
+ * out for CONFIG_OF=n builds.
+ */
+static __init void x86_wallclock_init(void)
+{
+	struct device_node *node = of_find_matching_node(NULL, of_cmos_match);
+
+	if (node && !of_device_is_available(node)) {
+		x86_platform.get_wallclock = get_rtc_noop;
+		x86_platform.set_wallclock = set_rtc_noop;
+	}
+}
 
 /*
  * The platform setup functions are preset with the default functions
@@ -73,7 +95,7 @@ struct x86_init_ops x86_init __initdata = {
 	.timers = {
 		.setup_percpu_clockev	= setup_boot_APIC_clock,
 		.timer_init		= hpet_time_init,
-		.wallclock_init		= x86_init_noop,
+		.wallclock_init		= x86_wallclock_init,
 	},
 
 	.iommu = {
