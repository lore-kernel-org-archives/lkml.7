Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD5AC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13DE2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBRZl7kS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbfGYPVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:21:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36536 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbfGYPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:21:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so34850188lfc.3;
        Thu, 25 Jul 2019 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONV+L9A/tji0gKQPGK36B/og/uekKtptCylJuV5Pb3I=;
        b=iBRZl7kSUVswPaFDXy1SzNdq86gl5gFvRKFa7qJbqPD7vvFdv/I2vrLUS+a5/pQLfc
         NvZeFC0cV/Fg9t+KpgKUf7UkhjTdUYrAqgH9y04b5XA+vU1zWdosP8Q/BOjbUfPOBj1K
         j3jATRaviselpfjzVNnD+2hloDvqxQZTd2UPKQYmfePGoBexkl/S8YQl6pf4p1gKwLmt
         QiAPwev/ordDMC4J+Ab7JUvuWiob4zdJte3EiPV/h9yRYPOn4LC8op7a9rzA9tAo1IGh
         njj/iQcG5CGvhMogP8wKdnEwvYw/5+PpdapWcBRuEn8A/kipxLVFdE+B2xcahedbYq3p
         JaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONV+L9A/tji0gKQPGK36B/og/uekKtptCylJuV5Pb3I=;
        b=Xd48g3HADfKWi4cayH2V0YRbpH6w0oeO2PMvXgBhr3h7jYDM6MACW17uAJAe0GUyTO
         xUies4mbS5BEKBVtiNUfHaKK8DHdFKLf4aH79dqFQV5qnb61jO41u9c/OzEn102QUMYX
         XNB1Zc+y+iEBRYlibkVTJYnT71pKx15BeEAPzOHCFDubnlCqBw57Qq8qGjCPFi2rYNEh
         jSDro19nxDD6zEPsKajQg9t70xKnV+3tTrni1sAc1SIUrDJ759YN0VkbtmzspKHPyfFi
         NQ314wGnKZvGrbCCJum3cXl8Sgxh2iiL/R++S1S7pX3KfWZMaLY5ojbnNO5cgVku7x6h
         5FGA==
X-Gm-Message-State: APjAAAWPcubDP4INQbx3tC3wZT6cSozKtM7vYc6R3Z4DhtvPdmL1zMIC
        E6ijGC4TRW3mNZzUWwrv+34=
X-Google-Smtp-Source: APXvYqzJjxw3lXR0PFOU/qJbsHbyb7Eb9qLp55rgKMHG1pzz+eENBtaSllYEhjtk7OfhNqb64eb2mQ==
X-Received: by 2002:ac2:455a:: with SMTP id j26mr40874298lfm.18.1564068059202;
        Thu, 25 Jul 2019 08:20:59 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id e87sm10452281ljf.54.2019.07.25.08.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:20:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] soc/tegra: regulators: Add regulators coupler for Tegra30
Date:   Thu, 25 Jul 2019 18:18:32 +0300
Message-Id: <20190725151832.9802-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725151832.9802-1-digetx@gmail.com>
References: <20190725151832.9802-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators coupler for Tegra30 SoCs that performs voltage balancing
of a coupled regulators and thus provides voltage scaling functionality.

There are 2 coupled regulators on all Tegra30 SoCs: CORE and CPU. The
coupled regulator voltages shall be in a range of 300mV from each other
and CORE voltage shall be higher than the CPU by N mV, where N depends
on the CPU voltage.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/Kconfig              |   4 +
 drivers/soc/tegra/Makefile             |   1 +
 drivers/soc/tegra/regulators-tegra30.c | 316 +++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 7986ab80e07a..bc86dc2f4198 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -28,6 +28,7 @@ config ARCH_TEGRA_3x_SOC
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select SOC_TEGRA30_VOLTAGE_COUPLER
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T30 processor family, based on the
@@ -140,3 +141,6 @@ config SOC_TEGRA20_VOLTAGE_COUPLER
 	bool "Voltage scaling support for Tegra20 SoCs"
 	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
 
+config SOC_TEGRA30_VOLTAGE_COUPLER
+	bool "Voltage scaling support for Tegra30 SoCs"
+	depends on ARCH_TEGRA_3x_SOC || COMPILE_TEST
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index 9f0bdd53bef8..9c809c1814bd 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_SOC_TEGRA_FLOWCTRL) += flowctrl.o
 obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
 obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP) += powergate-bpmp.o
 obj-$(CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER) += regulators-tegra20.o
+obj-$(CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER) += regulators-tegra30.o
diff --git a/drivers/soc/tegra/regulators-tegra30.c b/drivers/soc/tegra/regulators-tegra30.c
new file mode 100644
index 000000000000..f19fccfe1a92
--- /dev/null
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Voltage regulators coupler for NVIDIA Tegra30
+// Copyright (C) 2019 GRATE-DRIVER project
+//
+// Voltage constraints borrowed from downstream kernel sources
+// Copyright (C) 2010-2011 NVIDIA Corporation
+
+#define pr_fmt(fmt)	"tegra voltage-coupler: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/regulator/coupler.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#include <soc/tegra/fuse.h>
+
+struct tegra_regulator_coupler {
+	struct regulator_coupler coupler;
+	struct regulator_dev *core_rdev;
+	struct regulator_dev *cpu_rdev;
+	int core_min_uV;
+};
+
+static inline struct tegra_regulator_coupler *
+to_tegra_coupler(struct regulator_coupler *coupler)
+{
+	return container_of(coupler, struct tegra_regulator_coupler, coupler);
+}
+
+static int tegra30_core_limit(struct tegra_regulator_coupler *tegra,
+			      struct regulator_dev *core_rdev)
+{
+	int core_min_uV = 0;
+	int core_max_uV;
+	int core_cur_uV;
+	int err;
+
+	if (tegra->core_min_uV > 0)
+		return tegra->core_min_uV;
+
+	core_cur_uV = regulator_get_voltage_rdev(core_rdev);
+	if (core_cur_uV < 0)
+		return core_cur_uV;
+
+	core_max_uV = max(core_cur_uV, 1200000);
+
+	err = regulator_check_voltage(core_rdev, &core_min_uV, &core_max_uV);
+	if (err)
+		return err;
+
+	/*
+	 * Limit minimum CORE voltage to a value left from bootloader or,
+	 * if it's unreasonably low value, to the most common 1.2v or to
+	 * whatever maximum value defined via board's device-tree.
+	 */
+	tegra->core_min_uV = core_max_uV;
+
+	pr_info("core minimum voltage limited to %duV\n", tegra->core_min_uV);
+
+	return tegra->core_min_uV;
+}
+
+static int tegra30_core_cpu_limit(int cpu_uV)
+{
+	if (cpu_uV < 800000)
+		return 950000;
+
+	if (cpu_uV < 900000)
+		return 1000000;
+
+	if (cpu_uV < 1000000)
+		return 1100000;
+
+	if (cpu_uV < 1100000)
+		return 1200000;
+
+	if (cpu_uV < 1250000) {
+		switch (tegra_sku_info.cpu_speedo_id) {
+		case 0 ... 1:
+		case 4:
+		case 7 ... 8:
+			return 1200000;
+
+		default:
+			return 1300000;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int tegra30_voltage_update(struct tegra_regulator_coupler *tegra,
+				  struct regulator_dev *cpu_rdev,
+				  struct regulator_dev *core_rdev)
+{
+	int core_min_uV, core_max_uV = INT_MAX;
+	int cpu_min_uV, cpu_max_uV = INT_MAX;
+	int cpu_min_uV_consumers = 0;
+	int core_min_limited_uV;
+	int core_target_uV;
+	int cpu_target_uV;
+	int core_max_step;
+	int cpu_max_step;
+	int max_spread;
+	int core_uV;
+	int cpu_uV;
+	int err;
+
+	/*
+	 * CPU voltage should not got lower than 300mV from the CORE.
+	 * CPU voltage should stay below the CORE by 100mV+, depending
+	 * by the CORE voltage. This applies to all Tegra30 SoC's.
+	 */
+	max_spread = cpu_rdev->constraints->max_spread[0];
+	cpu_max_step = cpu_rdev->constraints->max_uV_step;
+	core_max_step = core_rdev->constraints->max_uV_step;
+
+	if (!max_spread) {
+		pr_err_once("cpu-core max-spread is undefined in device-tree\n");
+		max_spread = 300000;
+	}
+
+	if (!cpu_max_step) {
+		pr_err_once("cpu max-step is undefined in device-tree\n");
+		cpu_max_step = 150000;
+	}
+
+	if (!core_max_step) {
+		pr_err_once("core max-step is undefined in device-tree\n");
+		core_max_step = 150000;
+	}
+
+	/*
+	 * The CORE voltage scaling is currently not hooked up in drivers,
+	 * hence we will limit the minimum CORE voltage to a reasonable value.
+	 * This should be good enough for the time being.
+	 */
+	core_min_uV = tegra30_core_limit(tegra, core_rdev);
+	if (core_min_uV < 0)
+		return core_min_uV;
+
+	err = regulator_check_consumers(core_rdev, &core_min_uV, &core_max_uV,
+					PM_SUSPEND_ON);
+	if (err)
+		return err;
+
+	core_uV = regulator_get_voltage_rdev(core_rdev);
+	if (core_uV < 0)
+		return core_uV;
+
+	cpu_min_uV = core_min_uV - max_spread;
+
+	err = regulator_check_consumers(cpu_rdev, &cpu_min_uV, &cpu_max_uV,
+					PM_SUSPEND_ON);
+	if (err)
+		return err;
+
+	err = regulator_check_consumers(cpu_rdev, &cpu_min_uV_consumers,
+					&cpu_max_uV, PM_SUSPEND_ON);
+	if (err)
+		return err;
+
+	err = regulator_check_voltage(cpu_rdev, &cpu_min_uV, &cpu_max_uV);
+	if (err)
+		return err;
+
+	cpu_uV = regulator_get_voltage_rdev(cpu_rdev);
+	if (cpu_uV < 0)
+		return cpu_uV;
+
+	/*
+	 * CPU's regulator may not have any consumers, hence the voltage
+	 * must not be changed in that case because CPU simply won't
+	 * survive the voltage drop if it's running on a higher frequency.
+	 */
+	if (!cpu_min_uV_consumers)
+		cpu_min_uV = cpu_uV;
+
+	/*
+	 * Bootloader shall set up voltages correctly, but if it
+	 * happens that there is a violation, then try to fix it
+	 * at first.
+	 */
+	core_min_limited_uV = tegra30_core_cpu_limit(cpu_uV);
+	if (core_min_limited_uV < 0)
+		return core_min_limited_uV;
+
+	core_min_uV = max(core_min_uV, tegra30_core_cpu_limit(cpu_min_uV));
+
+	err = regulator_check_voltage(core_rdev, &core_min_uV, &core_max_uV);
+	if (err)
+		return err;
+
+	if (core_min_limited_uV > core_uV) {
+		pr_err("core voltage constraint violated: %d %d %d\n",
+		       core_uV, core_min_limited_uV, cpu_uV);
+		goto update_core;
+	}
+
+	while (cpu_uV != cpu_min_uV || core_uV != core_min_uV) {
+		if (cpu_uV < cpu_min_uV) {
+			cpu_target_uV = min(cpu_uV + cpu_max_step, cpu_min_uV);
+		} else {
+			cpu_target_uV = max(cpu_uV - cpu_max_step, cpu_min_uV);
+			cpu_target_uV = max(core_uV - max_spread, cpu_target_uV);
+		}
+
+		err = regulator_set_voltage_rdev(cpu_rdev,
+						 cpu_target_uV,
+						 cpu_max_uV,
+						 PM_SUSPEND_ON);
+		if (err)
+			return err;
+
+		cpu_uV = cpu_target_uV;
+update_core:
+		core_min_limited_uV = tegra30_core_cpu_limit(cpu_uV);
+		if (core_min_limited_uV < 0)
+			return core_min_limited_uV;
+
+		core_target_uV = max(core_min_limited_uV, core_min_uV);
+
+		if (core_uV < core_target_uV) {
+			core_target_uV = min(core_target_uV, core_uV + core_max_step);
+			core_target_uV = min(core_target_uV, cpu_uV + max_spread);
+		} else {
+			core_target_uV = max(core_target_uV, core_uV - core_max_step);
+		}
+
+		err = regulator_set_voltage_rdev(core_rdev,
+						 core_target_uV,
+						 core_max_uV,
+						 PM_SUSPEND_ON);
+		if (err)
+			return err;
+
+		core_uV = core_target_uV;
+	}
+
+	return 0;
+}
+
+static int tegra30_regulator_balance_voltage(struct regulator_coupler *coupler,
+					     struct regulator_dev *rdev,
+					     suspend_state_t state)
+{
+	struct tegra_regulator_coupler *tegra = to_tegra_coupler(coupler);
+	struct regulator_dev *core_rdev = tegra->core_rdev;
+	struct regulator_dev *cpu_rdev = tegra->cpu_rdev;
+
+	if ((core_rdev != rdev && cpu_rdev != rdev) || state != PM_SUSPEND_ON) {
+		pr_err("regulators are not coupled properly\n");
+		return -EINVAL;
+	}
+
+	return tegra30_voltage_update(tegra, cpu_rdev, core_rdev);
+}
+
+static int tegra30_regulator_attach(struct regulator_coupler *coupler,
+				    struct regulator_dev *rdev)
+{
+	struct tegra_regulator_coupler *tegra = to_tegra_coupler(coupler);
+	struct device_node *np = rdev->dev.of_node;
+
+	if (of_property_read_bool(np, "nvidia,tegra-core-regulator") &&
+	    !tegra->core_rdev) {
+		tegra->core_rdev = rdev;
+		return 0;
+	}
+
+	if (of_property_read_bool(np, "nvidia,tegra-cpu-regulator") &&
+	    !tegra->cpu_rdev) {
+		tegra->cpu_rdev = rdev;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int tegra30_regulator_detach(struct regulator_coupler *coupler,
+				    struct regulator_dev *rdev)
+{
+	struct tegra_regulator_coupler *tegra = to_tegra_coupler(coupler);
+
+	if (tegra->core_rdev == rdev) {
+		tegra->core_rdev = NULL;
+		return 0;
+	}
+
+	if (tegra->cpu_rdev == rdev) {
+		tegra->cpu_rdev = NULL;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static struct tegra_regulator_coupler tegra30_coupler = {
+	.coupler = {
+		.attach_regulator = tegra30_regulator_attach,
+		.detach_regulator = tegra30_regulator_detach,
+		.balance_voltage = tegra30_regulator_balance_voltage,
+	},
+};
+
+static int __init tegra_regulator_coupler_init(void)
+{
+	if (!of_machine_is_compatible("nvidia,tegra30"))
+		return 0;
+
+	return regulator_coupler_register(&tegra30_coupler.coupler);
+}
+arch_initcall(tegra_regulator_coupler_init);
-- 
2.22.0

