Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E44C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E3A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfDASPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:15:16 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:40478 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfDASPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:15:15 -0400
Received: from localhost.localdomain (85-76-9-223-nat.elisa-mobile.fi [85.76.9.223])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id ABA4CB00A4;
        Mon,  1 Apr 2019 21:15:13 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] drivers: firmware: psci: add support for warm reset
Date:   Mon,  1 Apr 2019 21:14:43 +0300
Message-Id: <20190401181443.6459-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

Add support for warm reset using SYSTEM_RESET2 introduced in PSCI
1.1 specification.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/firmware/psci.c   | 25 +++++++++++++++++++++++++
 include/uapi/linux/psci.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d03274..1d95b5f6d403 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -73,6 +73,7 @@ enum psci_function {
 	PSCI_FN_CPU_ON,
 	PSCI_FN_CPU_OFF,
 	PSCI_FN_MIGRATE,
+	PSCI_FN_SYSTEM_RESET2,
 	PSCI_FN_MAX,
 };
 
@@ -256,6 +257,14 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 }
 
+static void psci_sys_reset2(enum reboot_mode reboot_mode, const char *cmd)
+{
+	if (reboot_mode == REBOOT_WARM)
+		invoke_psci_fn(psci_function_id[PSCI_FN_SYSTEM_RESET2], 0, 0, 0);
+	else
+		psci_sys_reset(reboot_mode, cmd);
+}
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -564,6 +573,20 @@ static void __init psci_0_2_set_functions(void)
 	pm_power_off = psci_sys_poweroff;
 }
 
+static void __init psci_1_1_set_functions(void)
+{
+	int sys_reset2;
+	int feature;
+
+	sys_reset2 = PSCI_FN_NATIVE(1_1, SYSTEM_RESET2);
+	feature	= psci_features(sys_reset2);
+
+	if (feature != PSCI_RET_NOT_SUPPORTED) {
+		psci_function_id[PSCI_FN_SYSTEM_RESET2] = sys_reset2;
+		arm_pm_restart = psci_sys_reset2;
+	}
+}
+
 /*
  * Probe function for PSCI firmware versions >= 0.2
  */
@@ -588,6 +611,8 @@ static int __init psci_probe(void)
 		psci_init_smccc();
 		psci_init_cpu_suspend();
 		psci_init_system_suspend();
+		if (PSCI_VERSION_MINOR(ver) >= 1)
+			psci_1_1_set_functions();
 	}
 
 	return 0;
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe380da..f36e616c3b3f 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -52,6 +52,9 @@
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 
+#define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
+#define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
+
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
 #define PSCI_0_2_POWER_STATE_ID_SHIFT		0
-- 
2.17.0

