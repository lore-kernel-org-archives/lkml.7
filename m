Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D429C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99DD206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 21:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkPF+cjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfFWVKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 17:10:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38129 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfFWVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 17:10:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so10590783ljg.5;
        Sun, 23 Jun 2019 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7PQ+bhTZrhSU2irq6FgAfJOjSY9A9kXr28fZxDHwiAw=;
        b=FkPF+cjRBHeweNeWiYweoWZEq4JlizBRh3Q9dsixr3XmtLP8ZYNsh3yYEL5w0d6jAV
         hVU8jmrr41BxDePWbIsirwGg+fJM+2slN0wqDYI7Vb4nst7VEHxve2ToxCsStPxw+zCJ
         yvOSj31GHVb/MHL/05uNdVduKuHgZmc8+kiITPx17QGJyN1A77fs6gsIxCuUyYdmRlhG
         MhmO3TxLk6ytpN1/5EJaVhWRNMPp8DN1uQpMShTUth+bOHAlL04dMT5G2be1MaTl2zlf
         uSb20jJBGPXFq4RHaHLmrL+p9LEA4dZ6oLyPIgXfXVJ+4gDojaTSbF25/Ki4gJ9VwZHh
         f7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7PQ+bhTZrhSU2irq6FgAfJOjSY9A9kXr28fZxDHwiAw=;
        b=nDVqElv+OHUElwPSI+w2bwhtdbX7gdLykUxqMP16vDyadNKjVr0/eI5XWwGXxHvkgU
         OzvziRDtlDTHBr4KNdJBejH4Df2Zc46Mv1uwLVEBJlZ7jZvQEs6uhjPbhestyGHcfsqi
         /9pdEwRmR0KKfOBtZSJl+IRs1KF1D6xqc7DK1RGOBt2aEKwmHj4UCQeiSq0r6a5e/Hvi
         3tRHvDM3qN3+SuPvXUiQiraKlg+2p3yoWgUnT00K3/ab7hTj3WY/UWGaGVMEhRmUitbX
         GnZPkppMIjd5ztf+QvkOm4MULdxSJnF+PDsRokuBtUSUdaZ1sda9RfCy9ioEV2WrrRIT
         rNpQ==
X-Gm-Message-State: APjAAAW9acVLEd8B9+XWGNffM4YkBbeXq38hejRugX7ghqlllUkQy0VW
        iAZ9ms+N7aA351G3xY82KnY=
X-Google-Smtp-Source: APXvYqwcvmGnIj+NM+Q1D2TY7Dy+xW4F0GaptxUBGPDXNkZBWUqzTzmP3NdAod/zE5POkmRnSWFOhw==
X-Received: by 2002:a2e:6c07:: with SMTP id h7mr18221222ljc.177.1561324233623;
        Sun, 23 Jun 2019 14:10:33 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id b11sm1431125ljf.8.2019.06.23.14.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:10:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] soc/tegra: regulators: Add regulators coupler for Tegra30
Date:   Mon, 24 Jun 2019 00:08:35 +0300
Message-Id: <20190623210835.26281-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623210835.26281-1-digetx@gmail.com>
References: <20190623210835.26281-1-digetx@gmail.com>
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
 drivers/soc/tegra/regulators-tegra30.c | 302 +++++++++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 539c01012b00..84bd615c4a92 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -29,6 +29,7 @@ config ARCH_TEGRA_3x_SOC
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select SOC_TEGRA30_VOLTAGE_COUPLER
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T30 processor family, based on the
@@ -141,3 +142,6 @@ config SOC_TEGRA20_VOLTAGE_COUPLER
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
index 000000000000..7af22bacb088
--- /dev/null
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -0,0 +1,302 @@
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
+	cpu_min_uV = core_min_uV - max_spread;
+
+	err = regulator_check_consumers(cpu_rdev, &cpu_min_uV, &cpu_max_uV,
+					PM_SUSPEND_ON);
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
+	core_uV = regulator_get_voltage_rdev(core_rdev);
+	if (core_uV < 0)
+		return core_uV;
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

