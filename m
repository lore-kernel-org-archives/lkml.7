Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CF8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E6C206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqnbcHTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfLDPjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:39:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39194 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfLDPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:39:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so194834wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PcXlPnuNEwyWXH2XgGE5Q5jgxvOX+q8H8fhmAnCIWmg=;
        b=jqnbcHTkmt3hcolbu8/YNVm9C3o1ArMylzkLPSo9kU195c7OKo9p4BaA/B4U5RXlk3
         TumLh87fZfgxPAeEAFVrPIV5Emy0iEF2t9wkXM4jpez5JC6PrQKrdmW34JNngrPagOkM
         6LA+yjjTNLpztFIbtXh873PeINBrtdmSwZ1DCOVFRez3X3Fc3huTsVtTY3GctKsWBgPZ
         sek5VtwpG49TQjsuiEcxlsrTzCHep0JVH3kSXIDPIKgooDekiCc73wxQwY9IUzyrNtOR
         lTQwz7nqQPGZhF4ScTOdljchpQA5Ap6SxP3i1IOhdVeLALlvyKLJjQyufVp70a9xdSQg
         7EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PcXlPnuNEwyWXH2XgGE5Q5jgxvOX+q8H8fhmAnCIWmg=;
        b=s4Ill2fwqIwaljCCUcvueVdoIi9heISbO3DbFjXR2bHNuZH2jDn3NurlKQq2BKlOOY
         ZUjs9QJThVVZrVU8oLjJsbRMpnPfsrUzew7OPnsG3Oa+5u2I6tvBRwYIjSzph7Axgz9s
         9R4JX+8cW3zCeRHwoJw08TXOatVFx+C0ur4gjHPs4c6DV2tOWrfz3H0Z3k9GCilI1BGv
         QbM36jYYxZ2AhqOWzye+suKfp8Gc4QU0xpo57i7VKMMxnCuXBl0opjf+Q6T9vnG/Y4E1
         uvZ/9efmATmJjcES9Qkep34mIZtoS2XMHoRdhXp33zTnSvcxX0Qbhw0RNmh/cTuQ3cpw
         Ex9g==
X-Gm-Message-State: APjAAAVwfkLGRkIMv4RpILzB5kavJER9q6f2+jw2v1rZPczxeIxkGkm7
        DL0T6en9BX6dWJuYzGW2NWdObQ==
X-Google-Smtp-Source: APXvYqyo9tXlnnnSnVN5M9NLII/FANpfdeo1gwkTMjrgGv9yuKWrpFgHYVqsvQWKLSQK1wDljrr2lQ==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr143442wmg.66.1575473988499;
        Wed, 04 Dec 2019 07:39:48 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:a551:321a:c21f:1f92])
        by smtp.gmail.com with ESMTPSA id f1sm8631311wrp.93.2019.12.04.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:39:47 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/4] thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
Date:   Wed,  4 Dec 2019 16:39:29 +0100
Message-Id: <20191204153930.9128-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204153930.9128-1-daniel.lezcano@linaro.org>
References: <20191204153930.9128-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu idle cooling device offers a new method to cool down a CPU by
injecting idle cycles at runtime.

It has some similarities with the intel power clamp driver but it is
actually designed to be more generic and relying on the idle injection
powercap framework.

The idle injection duration is fixed while the running duration is
variable. That allows to have control on the device reactivity for the
user experience.

An idle state powering down the CPU or the cluster will allow to drop
the static leakage, thus restoring the heat capacity of the SoC. It
can be set with a trip point between the hot and the critical points,
giving the opportunity to prevent a hard reset of the system when the
cpufreq cooling fails to cool down the CPU.

With more sophisticated boards having a per core sensor, the idle
cooling device allows to cool down a single core without throttling
the compute capacity of several cpus belonging to the same clock line,
so it could be used in collaboration with the cpufreq cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 V4:
   - Fixed typos in the kernel-doc and clarified the changelog (Amit Kucheria)
 V3:
   - Add missing parameter documentation (Viresh Kumar)
   - Fixed function description (Viresh Kumar)
   - Add entry in MAINTAINER file
 V2:
   - Remove idle_duration_us field and use idle_inject API instead (Viresh Kumar)
   - Fixed function definition wheh CPU_IDLE_COOLING is not set
   - Inverted the initialization in the init function (Viresh Kumar)
---
 MAINTAINERS                       |   3 +
 drivers/thermal/Kconfig           |   7 +
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/cpuidle_cooling.c | 234 ++++++++++++++++++++++++++++++
 include/linux/cpu_cooling.h       |  22 +++
 5 files changed, 267 insertions(+)
 create mode 100644 drivers/thermal/cpuidle_cooling.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c570f0204b48..d2e92a0360f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16187,12 +16187,15 @@ F:	Documentation/devicetree/bindings/thermal/
 
 THERMAL/CPU_COOLING
 M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
+M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Javi Merino <javi.merino@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
+F:	Documentation/driver-api/thermal/cpu-idle-cooling.rst
 F:	drivers/thermal/cpu_cooling.c
+F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
 THINKPAD ACPI EXTRAS DRIVER
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4e3ee036938b..4ee9953ba5ce 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -169,6 +169,13 @@ config CPU_FREQ_THERMAL
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
 
+config CPU_IDLE_THERMAL
+	bool "CPU idle cooling device"
+	depends on IDLE_INJECT
+	help
+	  This implements the CPU cooling mechanism through
+	  idle injection. This will throttle the CPU by injecting
+	  idle cycle.
 endif
 
 config CLOCK_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index d3b01cc96981..9c8aa2d4bd28 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -20,6 +20,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
 
 # cpufreq cooling
 thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
+thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
 # clock cooling
 thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
new file mode 100644
index 000000000000..369c5c613f6b
--- /dev/null
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019 Linaro Limited.
+ *
+ *  Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ */
+#include <linux/cpu_cooling.h>
+#include <linux/cpuidle.h>
+#include <linux/err.h>
+#include <linux/idle_inject.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+/**
+ * struct cpuidle_cooling_device - data for the idle cooling device
+ * @ii_dev: an atomic to keep track of the last task exiting the idle cycle
+ * @state: a normalized integer giving the state of the cooling device
+ */
+struct cpuidle_cooling_device {
+	struct idle_inject_device *ii_dev;
+	unsigned long state;
+};
+
+static DEFINE_IDA(cpuidle_ida);
+
+/**
+ * cpuidle_cooling_runtime - Running time computation
+ * @idle_duration_us: the idle cooling device
+ * @state: a percentile based number
+ *
+ * The running duration is computed from the idle injection duration
+ * which is fixed. If we reach 100% of idle injection ratio, that
+ * means the running duration is zero. If we have a 50% ratio
+ * injection, that means we have equal duration for idle and for
+ * running duration.
+ *
+ * The formula is deduced as follows:
+ *
+ *  running = idle x ((100 / ratio) - 1)
+ *
+ * For precision purpose for integer math, we use the following:
+ *
+ *  running = (idle x 100) / ratio - idle
+ *
+ * For example, if we have an injected duration of 50%, then we end up
+ * with 10ms of idle injection and 10ms of running duration.
+ *
+ * Return: An unsigned int for a usec based runtime duration.
+ */
+static unsigned int cpuidle_cooling_runtime(unsigned int idle_duration_us,
+					    unsigned long state)
+{
+	if (!state)
+		return 0;
+
+	return ((idle_duration_us * 100) / state) - idle_duration_us;
+}
+
+/**
+ * cpuidle_cooling_get_max_state - Get the maximum state
+ * @cdev  : the thermal cooling device
+ * @state : a pointer to the state variable to be filled
+ *
+ * The function always returns 100 as the injection ratio. It is
+ * percentile based for consistency accross different platforms.
+ *
+ * Return: The function can not fail, it is always zero
+ */
+static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	/*
+	 * Depending on the configuration or the hardware, the running
+	 * cycle and the idle cycle could be different. We want to
+	 * unify that to an 0..100 interval, so the set state
+	 * interface will be the same whatever the platform is.
+	 *
+	 * The state 100% will make the cluster 100% ... idle. A 0%
+	 * injection ratio means no idle injection at all and 50%
+	 * means for 10ms of idle injection, we have 10ms of running
+	 * time.
+	 */
+	*state = 100;
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_get_cur_state - Get the current cooling state
+ * @cdev: the thermal cooling device
+ * @state: a pointer to the state
+ *
+ * The function just copies  the state value from the private thermal
+ * cooling device structure, the mapping is 1 <-> 1.
+ *
+ * Return: The function can not fail, it is always zero
+ */
+static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
+
+	*state = idle_cdev->state;
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_set_cur_state - Set the current cooling state
+ * @cdev: the thermal cooling device
+ * @state: the target state
+ *
+ * The function checks first if we are initiating the mitigation which
+ * in turn wakes up all the idle injection tasks belonging to the idle
+ * cooling device. In any case, it updates the internal state for the
+ * cooling device.
+ *
+ * Return: The function can not fail, it is always zero
+ */
+static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long state)
+{
+	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
+	struct idle_inject_device *ii_dev = idle_cdev->ii_dev;
+	unsigned long current_state = idle_cdev->state;
+	unsigned int runtime_us, idle_duration_us;
+
+	idle_cdev->state = state;
+
+	idle_inject_get_duration(ii_dev, &runtime_us, &idle_duration_us);
+
+	runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
+
+	idle_inject_set_duration(ii_dev, runtime_us, idle_duration_us);
+
+	if (current_state == 0 && state > 0) {
+		idle_inject_start(ii_dev);
+	} else if (current_state > 0 && !state)  {
+		idle_inject_stop(ii_dev);
+	}
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_ops - thermal cooling device ops
+ */
+static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
+	.get_max_state = cpuidle_cooling_get_max_state,
+	.get_cur_state = cpuidle_cooling_get_cur_state,
+	.set_cur_state = cpuidle_cooling_set_cur_state,
+};
+
+/**
+ * cpuidle_of_cooling_register - Idle cooling device initialization function
+ * @drv: a cpuidle driver structure pointer
+ * @np: a node pointer to a device tree cooling device node
+ *
+ * This function is in charge of creating a cooling device per cpuidle
+ * driver and register it to thermal framework.
+ *
+ * Return: A valid pointer to a thermal cooling device or a PTR_ERR
+ * corresponding to the error detected in the underlying subsystems.
+ */
+struct thermal_cooling_device *
+__init cpuidle_of_cooling_register(struct device_node *np,
+				   struct cpuidle_driver *drv)
+{
+	struct idle_inject_device *ii_dev;
+	struct cpuidle_cooling_device *idle_cdev;
+	struct thermal_cooling_device *cdev;
+	char dev_name[THERMAL_NAME_LENGTH];
+	int id, ret;
+
+	idle_cdev = kzalloc(sizeof(*idle_cdev), GFP_KERNEL);
+	if (!idle_cdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	id = ida_simple_get(&cpuidle_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto out_kfree;
+	}
+
+	ii_dev = idle_inject_register(drv->cpumask);
+	if (IS_ERR(ii_dev)) {
+		ret = PTR_ERR(ii_dev);
+		goto out_id;
+	}
+
+	idle_inject_set_duration(ii_dev, 0, TICK_USEC);
+	
+	idle_cdev->ii_dev = ii_dev;
+
+	snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", id);
+
+	cdev = thermal_of_cooling_device_register(np, dev_name, idle_cdev,
+						  &cpuidle_cooling_ops);
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto out_unregister;
+	}
+
+	return cdev;
+
+out_unregister:
+	idle_inject_unregister(ii_dev);
+out_id:
+	ida_simple_remove(&cpuidle_ida, id);
+out_kfree:
+	kfree(idle_cdev);
+out:
+	return ERR_PTR(ret);
+}
+
+/**
+ * cpuidle_cooling_register - Idle cooling device initialization function
+ * @drv: a cpuidle driver structure pointer
+ *
+ * This function is in charge of creating a cooling device per cpuidle
+ * driver and register it to thermal framework.
+ *
+ * Return: A valid pointer to a thermal cooling device, a PTR_ERR
+ * corresponding to the error detected in the underlying subsystems.
+ */
+struct thermal_cooling_device *
+__init cpuidle_cooling_register(struct cpuidle_driver *drv)
+{
+	return cpuidle_of_cooling_register(NULL, drv);
+}
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 3cdd85f987d7..da0970183d1f 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -60,4 +60,26 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 }
 #endif /* CONFIG_CPU_FREQ_THERMAL */
 
+struct cpuidle_driver;
+
+#ifdef CONFIG_CPU_IDLE_THERMAL
+extern struct thermal_cooling_device *
+__init cpuidle_cooling_register(struct cpuidle_driver *drv);
+extern struct thermal_cooling_device *
+__init cpuidle_of_cooling_register(struct device_node *np,
+				   struct cpuidle_driver *drv);
+#else /* CONFIG_CPU_IDLE_THERMAL */
+static inline struct thermal_cooling_device *
+__init cpuidle_cooling_register(struct cpuidle_driver *drv)
+{
+	return ERR_PTR(-EINVAL);
+}
+static inline struct thermal_cooling_device *
+__init cpuidle_of_cooling_register(struct device_node *np,
+				   struct cpuidle_driver *drv)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif /* CONFIG_CPU_IDLE_THERMAL */
+
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

