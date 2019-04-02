Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FEC2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfDBOHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:07:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:40735 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfDBOHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:07:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 07:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,300,1549958400"; 
   d="scan'208";a="158035996"
Received: from fyin-dev2.sh.intel.com ([10.239.154.72])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2019 07:07:29 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-kernel@vger.kernel.org, len.brown@intel.com
Cc:     shuo.liu@intel.com, di.zhang@intel.com
Subject: [PATCH] ACPI / processor_idle: use dead loop instead of io port access for wait
Date:   Tue,  2 Apr 2019 22:03:43 +0800
Message-Id: <20190402140343.8117-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function acpi_idle_do_entry(), we do an io port access to guarantee
hardware behavior. But it could trigger unnecessary trap to HV for
virtualization environemnt.

From the comments of this part of code, we could use busy wait instead
of io port access to guarantee hardware behavior and avoid unnecessary
trap to HV.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 drivers/acpi/processor_idle.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index abb559cd28d7..dcc447e59885 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -68,6 +68,8 @@ struct cpuidle_driver acpi_idle_driver = {
 };
 
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
+static struct timespec64 dummy_delta = {0L, 0L};
+
 static
 DEFINE_PER_CPU(struct acpi_processor_cx * [CPUIDLE_STATE_MAX], acpi_cstate);
 
@@ -77,6 +79,18 @@ static int disabled_by_idle_boot_param(void)
 		boot_option_idle_override == IDLE_HALT;
 }
 
+static void dummy_wait(void)
+{
+	struct timespec64 now, target;
+
+	ktime_get_real_ts64(&now);
+	target = timespec64_add(now, dummy_delta);
+
+	do {
+		ktime_get_real_ts64(&now);
+	} while (timespec64_compare(&now, &target) < 0);
+}
+
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
@@ -664,8 +678,12 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		/* Dummy wait op - must do something useless after P_LVL2 read
 		   because chipsets cannot guarantee that STPCLK# signal
-		   gets asserted in time to freeze execution properly. */
-		inl(acpi_gbl_FADT.xpm_timer_block.address);
+		   gets asserted in time to freeze execution properly.
+
+		   Previously, we do io port access here which could trigger
+		   unnecessary trap to HV for virtualization env. We use dead loop
+		   here to avoid the impact to virtualization env. */
+		dummy_wait();
 	}
 }
 
@@ -687,7 +705,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			inb(cx->address);
 			/* See comment in acpi_idle_do_entry() */
-			inl(acpi_gbl_FADT.xpm_timer_block.address);
+			dummy_wait();
 		} else
 			return -ENODEV;
 	}
@@ -906,6 +924,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 {
 	acpi_status status;
 	static int first_run;
+	struct timespec64 ts0, ts1;
 
 	if (first_run)
 		return;
@@ -916,6 +935,13 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 			  max_cstate);
 	first_run++;
 
+	/* profiling the time used for dummy wait op */
+	ktime_get_real_ts64(&ts0);
+	inl(acpi_gbl_FADT.xpm_timer_block.address);
+	ktime_get_real_ts64(&ts1);
+
+	dummy_delta = timespec64_sub(ts1, ts0);
+
 	if (acpi_gbl_FADT.cst_control && !nocst) {
 		status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
 					    acpi_gbl_FADT.cst_control, 8);
@@ -924,6 +950,7 @@ static inline void acpi_processor_cstate_first_run_checks(void)
 					"Notifying BIOS of _CST ability failed"));
 	}
 }
+
 #else
 
 static inline int disabled_by_idle_boot_param(void) { return 0; }
-- 
2.17.1

