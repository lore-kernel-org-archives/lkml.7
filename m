Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46855C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0665E20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECdGhCwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfB1OAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:00:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44739 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbfB1N72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id q128so17180460ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GI6XZmnxcYO/CY+bl29qXuso3VQMluSDkZvmK3rltbA=;
        b=ECdGhCwn8eiyl27bdwu/8OOk2JAEI2UoSPCIsVrC3N7eNNOSfQ2l/na89v/Lm9AwVD
         0V8Ojda8kJ9Xlal+TeCeQ0r4Tbt0Bp7IF0Yd636JSJwcRZBKt7ZLUKJ2eYulJMrEIb6a
         Q9Whg3t6AB0qxd+TdYsJoI4h3g3BloVn1eflb5M1XEnTH9xs32iAJSF/a5cxFtY74Skn
         AcGhFatt+MNORl3p4bmUcp33sVPH3FkJiLX1emaeYI1Fvme3AK/VIpMi3eG7XqGGHwub
         bRcYjUIaZWfG9uL5VhlxW+UTrO7KDaTWU2F1T3Amxetd7eWoeNUJhf0qbm0ODJR5Nil1
         Tf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GI6XZmnxcYO/CY+bl29qXuso3VQMluSDkZvmK3rltbA=;
        b=g0k26CHXRnXwugPeIx/YhotHMyqTWHegs3ftQmZ0McnzCm88tDwA0SWSM/a8UjA/ea
         TnSMd60SnLSpay+b8EDxiwhU5V3yaJnL2D8Zus7pEHEdbW2R+vOMlJsM/pDVR3qyCRKo
         olDBkEf93rINuTT4/Ogy/trDxyjavxIQ1HR2CStwcGEleeoe2QHk03uVxrU/p16urhdR
         TojtGQe1/DNKgwj+XH1wDqtCga8oKU6X7VD39GFxOvcWZGCFCt8UAyc7iJnIvv2Ge8zq
         /DQu6/P6SBW3S4UH212SqcNw9xCwlpkCI5oaZPnHfclwqEHoBwi6T9Q+ZQOzEqJ1pFtw
         1Dzw==
X-Gm-Message-State: APjAAAXJ2YuGYKW5gZ1zLe8nZ7zr8elYcJrAv3O4gw7KMhotXrB4frg6
        00KCwJdNSe+d17Gi2WUhVV/vew==
X-Google-Smtp-Source: AHgI3IbeIXk8Cl8KhHC8bomqccjeVUdmfRBg8eJwL/dSo1Ys7nWisrbAqtKKDv+6q3D0f/fTDczaGw==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr4832648ljg.34.1551362365801;
        Thu, 28 Feb 2019 05:59:25 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:25 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] drivers: firmware: psci: Move psci to separate directory
Date:   Thu, 28 Feb 2019 14:59:13 +0100
Message-Id: <20190228135919.3747-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228135919.3747-1-ulf.hansson@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some following changes extends the PSCI driver with some additional new
files.  Let's avoid to continue cluttering the toplevel firmware directory
and first move the PSCI files into a PSCI sub-directory.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/Kconfig                   | 15 +--------------
 drivers/firmware/Makefile                  |  3 +--
 drivers/firmware/psci/Kconfig              | 13 +++++++++++++
 drivers/firmware/psci/Makefile             |  4 ++++
 drivers/firmware/{ => psci}/psci.c         |  0
 drivers/firmware/{ => psci}/psci_checker.c |  0
 6 files changed, 19 insertions(+), 16 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (100%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index f754578414f0..e1385f47d4ac 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -5,20 +5,6 @@
 
 menu "Firmware Drivers"
 
-config ARM_PSCI_FW
-	bool
-
-config ARM_PSCI_CHECKER
-	bool "ARM PSCI checker"
-	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
-	help
-	  Run the PSCI checker during startup. This checks that hotplug and
-	  suspend operations work correctly when using PSCI.
-
-	  The torture tests may interfere with the PSCI checker by turning CPUs
-	  on and off through hotplug, so for now torture tests and PSCI checker
-	  are mutually exclusive.
-
 config ARM_SCMI_PROTOCOL
 	bool "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
@@ -270,6 +256,7 @@ config TI_SCI_PROTOCOL
 config HAVE_ARM_SMCCC
 	bool
 
+source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 80feb635120f..9a3909a22682 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -2,8 +2,6 @@
 #
 # Makefile for the linux kernel.
 #
-obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
-obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
@@ -25,6 +23,7 @@ CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQU
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL)	+= arm_scmi/
+obj-y				+= psci/
 obj-y				+= broadcom/
 obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
new file mode 100644
index 000000000000..26a3b32bf7ab
--- /dev/null
+++ b/drivers/firmware/psci/Kconfig
@@ -0,0 +1,13 @@
+config ARM_PSCI_FW
+	bool
+
+config ARM_PSCI_CHECKER
+	bool "ARM PSCI checker"
+	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
+	help
+	  Run the PSCI checker during startup. This checks that hotplug and
+	  suspend operations work correctly when using PSCI.
+
+	  The torture tests may interfere with the PSCI checker by turning CPUs
+	  on and off through hotplug, so for now torture tests and PSCI checker
+	  are mutually exclusive.
diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
new file mode 100644
index 000000000000..1956b882470f
--- /dev/null
+++ b/drivers/firmware/psci/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci/psci.c
similarity index 100%
rename from drivers/firmware/psci.c
rename to drivers/firmware/psci/psci.c
diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci/psci_checker.c
similarity index 100%
rename from drivers/firmware/psci_checker.c
rename to drivers/firmware/psci/psci_checker.c
-- 
2.17.1

