Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742872171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xt6KpU1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfB1N7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:59:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41262 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732416AbfB1N7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:59:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25so17199938ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FA47iBYE1/jKqUXLlbljtr1jgxnROrzBgQH0oOLCPjk=;
        b=xt6KpU1G9lmV1j8e10sBfnzKKNq34qFfGySFP/7hgcLyp1k0oI7awNlqSc5ZB4hBPm
         9kKDXb6ErSS26McY9/gBlFxZRRVJElzgwdWOrvx3xkARZgCxFraDG3kVhxkOGXsWybqf
         fOZnbwG/oWpxQyIfumUSqnR1Ed7wzOnxrL9TGRCNR8TwaxM/yWXwnS6NkisSdGEYUJyp
         OcJmBpQX6yNWydSWVEQOVgrPQ3Qn/5v/OR5WT4R+hJ+jjoH40dd2yrjG664sI3Mn0IwU
         wR0wxJITZUUQym0Y31vITo/WBeUIpGs9HQG1COvZN4D8FMucqACS2juk7vR8NmXsV55j
         QbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FA47iBYE1/jKqUXLlbljtr1jgxnROrzBgQH0oOLCPjk=;
        b=tUr+CksW8gNzwv5vGyTBwtT+rHW0tq/QDKtY7l0KEi5SZwq6Q9j+MBFjN2osA7CZSn
         owXl9sEp7tLVV0ERJf9y/q4Z2mRL9I+4+SPdZ7l3LRusJvCY891akanK+A6wdmESMGab
         cELt8i8UoWvxu44kNEHchTngxIFmVc+qdnIf8oWPk0B1xxothTDs+zwizvvpihxP82e6
         +7WAJqD4QJCvhJE/v1raFRZ9g50wkUw0rgzQQr4jheppLE6WhBUy8je8hb83LM3lXZ7w
         SZ2uIZ/3cAgvzsXLkc6nHCwaI0p+le72YHOWbus3hSM2WmP39eRThplvHpRLqmltc0UN
         bfaQ==
X-Gm-Message-State: AHQUAub+PPNvYh269TmwkPvYU4cfu3uUwmJSgDcdqWCI3xzVhvIeVacX
        APDtWpoGMcvDZHZsy7vjSyAzfQ==
X-Google-Smtp-Source: AHgI3Ia5N0tWMr+1rxIh3kePdQxvG+xtPG7wKv9iWaNFa1EY39c1DCNuTvsuCpd2X+rYVZhocWIphA==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr4438726ljg.29.1551362371517;
        Thu, 28 Feb 2019 05:59:31 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v20sm4090265ljv.83.2019.02.28.05.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:59:30 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Subject: [PATCH 4/7] ARM/ARM64: cpuidle: Let back-end init ops take the driver as input
Date:   Thu, 28 Feb 2019 14:59:16 +0100
Message-Id: <20190228135919.3747-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228135919.3747-1-ulf.hansson@linaro.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow arch back-end init ops to operate on the cpuidle driver for the
corresponding CPU, let's pass along a pointer to the struct cpuidle_driver*
and forward it the relevant layers of callbacks for ARM/ARM64.

Following changes for the PSCI firmware driver starts making use of this.

Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/include/asm/cpuidle.h   | 4 ++--
 arch/arm/kernel/cpuidle.c        | 5 +++--
 arch/arm64/include/asm/cpu_ops.h | 4 +++-
 arch/arm64/include/asm/cpuidle.h | 6 ++++--
 arch/arm64/kernel/cpuidle.c      | 6 +++---
 drivers/cpuidle/cpuidle-arm.c    | 2 +-
 drivers/firmware/psci/psci.c     | 7 ++++---
 drivers/soc/qcom/spm.c           | 3 ++-
 include/linux/psci.h             | 4 +++-
 9 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 6b2ff7243b4b..bee0a7847733 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -32,7 +32,7 @@ struct device_node;
 
 struct cpuidle_ops {
 	int (*suspend)(unsigned long arg);
-	int (*init)(struct device_node *, int cpu);
+	int (*init)(struct cpuidle_driver *, struct device_node *, int cpu);
 };
 
 struct of_cpuidle_method {
@@ -47,6 +47,6 @@ struct of_cpuidle_method {
 
 extern int arm_cpuidle_suspend(int index);
 
-extern int arm_cpuidle_init(int cpu);
+extern int arm_cpuidle_init(struct cpuidle_driver *drv, int cpu);
 
 #endif
diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
index fda5579123a8..43778c9b373d 100644
--- a/arch/arm/kernel/cpuidle.c
+++ b/arch/arm/kernel/cpuidle.c
@@ -122,6 +122,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
 
 /**
  * arm_cpuidle_init() - Initialize cpuidle_ops for a specific cpu
+ * @drv: the drv to be initialized
  * @cpu: the cpu to be initialized
  *
  * Initialize the cpuidle ops with the device for the cpu and then call
@@ -137,7 +138,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
  *  -ENXIO if the HW reports a failure or a misconfiguration,
  *  -ENOMEM if the HW report an memory allocation failure 
  */
-int __init arm_cpuidle_init(int cpu)
+int __init arm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
 {
 	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
 	int ret;
@@ -147,7 +148,7 @@ int __init arm_cpuidle_init(int cpu)
 
 	ret = arm_cpuidle_read_ops(cpu_node, cpu);
 	if (!ret)
-		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
+		ret = cpuidle_ops[cpu].init(drv, cpu_node, cpu);
 
 	of_node_put(cpu_node);
 
diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index 8f03446cf89f..8db870c29f1b 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/threads.h>
 
+struct cpuidle_driver;
+
 /**
  * struct cpu_operations - Callback operations for hotplugging CPUs.
  *
@@ -58,7 +60,7 @@ struct cpu_operations {
 	int		(*cpu_kill)(unsigned int cpu);
 #endif
 #ifdef CONFIG_CPU_IDLE
-	int		(*cpu_init_idle)(unsigned int);
+	int		(*cpu_init_idle)(struct cpuidle_driver *, unsigned int);
 	int		(*cpu_suspend)(unsigned long);
 #endif
 };
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 3c5ddb429ea2..3fd3efb61649 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -4,11 +4,13 @@
 
 #include <asm/proc-fns.h>
 
+struct cpuidle_driver;
+
 #ifdef CONFIG_CPU_IDLE
-extern int arm_cpuidle_init(unsigned int cpu);
+extern int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu);
 extern int arm_cpuidle_suspend(int index);
 #else
-static inline int arm_cpuidle_init(unsigned int cpu)
+static inline int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index f2d13810daa8..aaf9dc5cb87a 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -18,13 +18,13 @@
 #include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
 
-int arm_cpuidle_init(unsigned int cpu)
+int arm_cpuidle_init(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	int ret = -EOPNOTSUPP;
 
 	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_suspend &&
 			cpu_ops[cpu]->cpu_init_idle)
-		ret = cpu_ops[cpu]->cpu_init_idle(cpu);
+		ret = cpu_ops[cpu]->cpu_init_idle(drv, cpu);
 
 	return ret;
 }
@@ -51,7 +51,7 @@ int arm_cpuidle_suspend(int index)
 
 int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
-	return arm_cpuidle_init(cpu);
+	return arm_cpuidle_init(NULL, cpu);
 }
 
 int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 3a407a3ef22b..39413973b21d 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -106,7 +106,7 @@ static int __init arm_idle_init_cpu(int cpu)
 	 * Call arch CPU operations in order to initialize
 	 * idle states suspend back-end specific data
 	 */
-	ret = arm_cpuidle_init(cpu);
+	ret = arm_cpuidle_init(drv, cpu);
 
 	/*
 	 * Allow the initialization to continue for other CPUs, if the reported
diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 9788bfc1cf8b..d50b46a0528f 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -287,7 +287,8 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
-static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
+static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, int cpu)
 {
 	int i, ret = 0, count = 0;
 	u32 *psci_states;
@@ -375,7 +376,7 @@ static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
 }
 #endif
 
-int psci_cpu_init_idle(unsigned int cpu)
+int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
 {
 	struct device_node *cpu_node;
 	int ret;
@@ -394,7 +395,7 @@ int psci_cpu_init_idle(unsigned int cpu)
 	if (!cpu_node)
 		return -ENODEV;
 
-	ret = psci_dt_cpu_init_idle(cpu_node, cpu);
+	ret = psci_dt_cpu_init_idle(drv, cpu_node, cpu);
 
 	of_node_put(cpu_node);
 
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 53807e839664..6e967f0a8608 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -208,7 +208,8 @@ static const struct of_device_id qcom_idle_state_match[] __initconst = {
 	{ },
 };
 
-static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
+static int __init qcom_cpuidle_init(struct cpuidle_driver *drv,
+			struct device_node *cpu_node, int cpu)
 {
 	const struct of_device_id *match_id;
 	struct device_node *state_node;
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 8b1b3b5935ab..4f29a3bff379 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -20,9 +20,11 @@
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
 
+struct cpuidle_driver;
+
 bool psci_tos_resident_on(int cpu);
 
-int psci_cpu_init_idle(unsigned int cpu);
+int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu);
 int psci_cpu_suspend_enter(unsigned long index);
 
 enum psci_conduit {
-- 
2.17.1

