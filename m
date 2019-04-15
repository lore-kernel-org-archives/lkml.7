Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C282C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D907A2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfDOLs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:48:27 -0400
Received: from foss.arm.com ([217.140.101.70]:32990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfDOLs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:48:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF6AE80D;
        Mon, 15 Apr 2019 04:48:26 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB69A3F706;
        Mon, 15 Apr 2019 04:48:24 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4] firmware/psci: add support for SYSTEM_RESET2
Date:   Mon, 15 Apr 2019 12:47:46 +0100
Message-Id: <20190415114746.32753-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
where the semantics are described by the PSCI specification itself as
well as vendor-specific resets. Currently only system warm reset
semantics is defined as part of architectural resets by the specification.

This patch implements support for SYSTEM_RESET2 by making using of
reboot_mode passed by the reboot infrastructure in the kernel.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci/psci.c | 24 +++++++++++++++++++++++-
 include/uapi/linux/psci.h    |  2 ++
 2 files changed, 25 insertions(+), 1 deletion(-)

v3->v4:
	- Rebased on linux-pm -next tree
	- Added Aaro Koskinen tested-by

v2->v3:
	- Added else condition so that if SYSTEM_RESET2 fails, it ends
	  up doing a system halt
	- Wrap single statement if..else with braces because of presence
	  of multiple line comment

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index eabd01383cd6..fe090ef43d28 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)

 static u32 psci_cpu_suspend_feature;
+static bool psci_system_reset2_supported;

 static inline bool psci_has_ext_power_state(void)
 {
@@ -258,7 +259,17 @@ static int get_set_conduit_method(struct device_node *np)

 static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 {
-	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
+	    psci_system_reset2_supported) {
+		/*
+		 * reset_type[31] = 0 (architectural)
+		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
+		 * cookie = 0 (ignored by the implementation)
+		 */
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
+	} else {
+		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
+	}
 }

 static void psci_sys_poweroff(void)
@@ -460,6 +471,16 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };

+static void __init psci_init_system_reset2(void)
+{
+	int ret;
+
+	ret = psci_features(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2));
+
+	if (ret != PSCI_RET_NOT_SUPPORTED)
+		psci_system_reset2_supported = true;
+}
+
 static void __init psci_init_system_suspend(void)
 {
 	int ret;
@@ -597,6 +618,7 @@ static int __init psci_probe(void)
 		psci_init_smccc();
 		psci_init_cpu_suspend();
 		psci_init_system_suspend();
+		psci_init_system_reset2();
 	}

 	return 0;
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index 581f72085c33..2fcad1dd0b0e 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -50,8 +50,10 @@
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
 #define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
+#define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)

 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
+#define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)

 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
--
2.17.1

