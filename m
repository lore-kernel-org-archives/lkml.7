Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9A7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A954B2189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfH0J0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:26:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:64884 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfH0J0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:26:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 02:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="331763708"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga004.jf.intel.com with ESMTP; 27 Aug 2019 02:26:31 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, x86@kernel.org
Cc:     andriy.shevchenko@intel.com, alan@linux.intel.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        chuanhua.lei@linux.intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 1/1] x86/init: Noop get/set wallclock when platform doesn't support RTC
Date:   Tue, 27 Aug 2019 17:26:21 +0800
Message-Id: <199d34bc514d4fbf2058a862918dc6a71390c48f.1566895445.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1566895445.git.rahul.tanwar@linux.intel.com>
References: <cover.1566895445.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1566895445.git.rahul.tanwar@linux.intel.com>
References: <cover.1566895445.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use wallclock_init() op to detect platforms which does not support RTC and
noop get/set wallclock ops for such platforms.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 arch/x86/kernel/x86_init.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 1bef687faf22..88c120710d5d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -31,6 +31,30 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
+static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+static void get_rtc_noop(struct timespec64 *now) { }
+
+static const struct of_device_id of_cmos_match[] = {
+	{ .compatible = "motorola,mc146818" },
+	{}
+};
+
+void x86_wallclock_init(void)
+{
+	struct device_node *node;
+
+	node = of_find_matching_node(NULL, of_cmos_match);
+	if (node && !of_device_is_available(node)) {
+		/*
+		 * Some products do not support RTC as persistent clock source. This can be
+		 * optionally indicated by having status property as disabled in the
+		 * corresponding DT node. Override get/set wallclock routines to noops for
+		 * such products.
+		 */
+		x86_platform.get_wallclock = get_rtc_noop;
+		x86_platform.set_wallclock = set_rtc_noop;
+	}
+}
 
 /*
  * The platform setup functions are preset with the default functions
@@ -73,7 +97,7 @@ struct x86_init_ops x86_init __initdata = {
 	.timers = {
 		.setup_percpu_clockev	= setup_boot_APIC_clock,
 		.timer_init		= hpet_time_init,
-		.wallclock_init		= x86_init_noop,
+		.wallclock_init		= x86_wallclock_init,
 	},
 
 	.iommu = {
-- 
2.11.0

