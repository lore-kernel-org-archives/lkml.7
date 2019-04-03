Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EADC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C0B2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDCSwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:52:01 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:47134 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCSwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:52:01 -0400
Received: from localhost.localdomain (85-76-9-223-nat.elisa-mobile.fi [85.76.9.223])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id E14A440087;
        Wed,  3 Apr 2019 21:51:58 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH v2] drivers: firmware: psci: add support for warm reset
Date:   Wed,  3 Apr 2019 21:51:23 +0300
Message-Id: <20190403185123.15873-1-aaro.koskinen@iki.fi>
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

	v2: Added #define PSCI_1_1_SYSTEM_RESET_WARM. 
	    Refactored psci_probe.

	v1: https://marc.info/?l=linux-arm-kernel&m=155431514204495&w=2

 drivers/firmware/psci.c   | 42 ++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/psci.h |  6 ++++++
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d03274..004a394de2c3 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -73,6 +73,7 @@ enum psci_function {
 	PSCI_FN_CPU_ON,
 	PSCI_FN_CPU_OFF,
 	PSCI_FN_MIGRATE,
+	PSCI_FN_SYSTEM_RESET2,
 	PSCI_FN_MAX,
 };
 
@@ -256,6 +257,15 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 }
 
+static void psci_sys_reset2(enum reboot_mode reboot_mode, const char *cmd)
+{
+	if (reboot_mode == REBOOT_WARM)
+		invoke_psci_fn(psci_function_id[PSCI_FN_SYSTEM_RESET2],
+			       PSCI_1_1_SYSTEM_RESET_WARM, 0, 0);
+	else
+		psci_sys_reset(reboot_mode, cmd);
+}
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -564,6 +574,20 @@ static void __init psci_0_2_set_functions(void)
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
@@ -584,11 +608,19 @@ static int __init psci_probe(void)
 
 	psci_init_migrate();
 
-	if (PSCI_VERSION_MAJOR(ver) >= 1) {
-		psci_init_smccc();
-		psci_init_cpu_suspend();
-		psci_init_system_suspend();
-	}
+	if (ver < PSCI_VERSION(1, 0))
+		return 0;
+
+	/* PSCI 1.0 setup */
+	psci_init_smccc();
+	psci_init_cpu_suspend();
+	psci_init_system_suspend();
+
+	if (ver < PSCI_VERSION(1, 1))
+		return 0;
+
+	/* PSCI 1.1 setup */
+	psci_1_1_set_functions();
 
 	return 0;
 }
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe380da..bf5a90c05e79 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -52,6 +52,12 @@
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 
+#define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)
+#define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)
+
+/* PSCI v1.1 parameter values for SYSTEM_RESET2 */
+#define PSCI_1_1_SYSTEM_RESET_WARM		0
+
 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
 #define PSCI_0_2_POWER_STATE_ID_SHIFT		0
-- 
2.17.0

