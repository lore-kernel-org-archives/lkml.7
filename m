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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10883C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AB4229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyzuUvDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbfGYPVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:21:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37541 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfGYPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:21:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so34770312lfh.4;
        Thu, 25 Jul 2019 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7Fl0NTIjAmTZr47B8I0IlVheYWmGAV4TiyTKGSazAc=;
        b=AyzuUvDKNF4FABUyFLuc37gDDcs4vy0p+/PmKKxMh96PrQntlNGw1oaBcKof5zfL+Q
         K8TbAv3K6ylK21BIFxf7SyOwLnYF6J76unKkUWXoGTkxISD2ywoCsfPUjLLrR00kh5mT
         B2q78mTCxtvpNmWsnYBCjmfb1MNSL3Kj1p0dInbXCcg4f1aTSocde8N65gRsONYokPPG
         kqUDqb3yXSyBc+WkgpPeFFnzF5f4LIjlxpzF5k1lEYSoBpVQ3nAxB1dMunvSZ41NzD1+
         rdPRXJsQBAlYYfa486T2S9dsSrWrLr5AlkmvL3Mv2h+FZEvIN4VoVWR94K8ic6p46XJM
         vDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7Fl0NTIjAmTZr47B8I0IlVheYWmGAV4TiyTKGSazAc=;
        b=lLcR/bBEM1Vvwo1NT7939Qj2RQQO/qHu1Tik8FHuExfm3l3hVKlSKjwLUEzE9XBsGz
         6EcUZKNaFtMDHJTju3TnQXqqiQU3WBj/9OC5hiu/kSL7VOY9CwjYK92LC0852wsBiPCS
         b0s5d3efu3ZDVJXYsgFqwLrDQB/IGOjvDaI5RgKxj47BpO6oX6qTb77JRQnhb0B+oWR5
         4gbiYgSiAQzFRWZZvberWxsZpDQ0jNzPrrglKxaAnggW8sRbVVZNggcvkjecgo+O0qWi
         JPpMTOAUlMDRSIcYfpJqGhabnqGrfEBYamxeMXxjkPnAfcxMDJgkMSDVUej6+2Lto75l
         gm5w==
X-Gm-Message-State: APjAAAVvnHMYG27mL+KQfOk5iVjzZPGGi4V+pPt7x47kPXiFtbPjDzOI
        DgaQjh2heS3ypdTCAF7D88I=
X-Google-Smtp-Source: APXvYqxpo7zYrG+kuBcmxJJ+gACW7ybWHQ5OqEQYE9b9z1DIf4TRBzt8tHi+7iHGg5fi1uePJgh5VA==
X-Received: by 2002:ac2:52ac:: with SMTP id r12mr39173379lfm.54.1564068058175;
        Thu, 25 Jul 2019 08:20:58 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id e87sm10452281ljf.54.2019.07.25.08.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:20:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] soc/tegra: regulators: Add regulators coupler for Tegra20
Date:   Thu, 25 Jul 2019 18:18:31 +0300
Message-Id: <20190725151832.9802-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725151832.9802-1-digetx@gmail.com>
References: <20190725151832.9802-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators coupler for Tegra20 SoCs that performs voltage balancing
of a coupled regulators and thus provides voltage scaling functionality.

There are 3 coupled regulators on all Tegra20 SoCs: CORE, RTC and CPU.
The CORE and RTC voltages shall be in range of 170mV from each other and
they both shall be higher than the CPU voltage by at least 120mV. This
sounds like it could be handle by a generic voltage balancer, but the CORE
voltage scaling isn't implemented in any of the upstream drivers yet.
It will take quite some time and effort to hook up voltage scaling for
all of the drivers, hence we will use a custom coupler that will manage
the CPU voltage scaling for the starter.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/Kconfig              |   6 +
 drivers/soc/tegra/Makefile             |   1 +
 drivers/soc/tegra/regulators-tegra20.c | 364 +++++++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/soc/tegra/regulators-tegra20.c

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index d98c69efb7e0..7986ab80e07a 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -14,6 +14,7 @@ config ARCH_TEGRA_2x_SOC
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select SOC_TEGRA_FLOWCTRL
 	select SOC_TEGRA_PMC
+	select SOC_TEGRA20_VOLTAGE_COUPLER
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
@@ -134,3 +135,8 @@ config SOC_TEGRA_POWERGATE_BPMP
 	def_bool y
 	depends on PM_GENERIC_DOMAINS
 	depends on TEGRA_BPMP
+
+config SOC_TEGRA20_VOLTAGE_COUPLER
+	bool "Voltage scaling support for Tegra20 SoCs"
+	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
+
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index 902759fe5f4d..9f0bdd53bef8 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -5,3 +5,4 @@ obj-y += common.o
 obj-$(CONFIG_SOC_TEGRA_FLOWCTRL) += flowctrl.o
 obj-$(CONFIG_SOC_TEGRA_PMC) += pmc.o
 obj-$(CONFIG_SOC_TEGRA_POWERGATE_BPMP) += powergate-bpmp.o
+obj-$(CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER) += regulators-tegra20.o
diff --git a/drivers/soc/tegra/regulators-tegra20.c b/drivers/soc/tegra/regulators-tegra20.c
new file mode 100644
index 000000000000..84ea3ff316ec
--- /dev/null
+++ b/drivers/soc/tegra/regulators-tegra20.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Voltage regulators coupler for NVIDIA Tegra20
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
+struct tegra_regulator_coupler {
+	struct regulator_coupler coupler;
+	struct regulator_dev *core_rdev;
+	struct regulator_dev *cpu_rdev;
+	struct regulator_dev *rtc_rdev;
+	int core_min_uV;
+};
+
+static inline struct tegra_regulator_coupler *
+to_tegra_coupler(struct regulator_coupler *coupler)
+{
+	return container_of(coupler, struct tegra_regulator_coupler, coupler);
+}
+
+static int tegra20_core_limit(struct tegra_regulator_coupler *tegra,
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
+static int tegra20_core_rtc_max_spread(struct regulator_dev *core_rdev,
+				       struct regulator_dev *rtc_rdev)
+{
+	struct coupling_desc *c_desc = &core_rdev->coupling_desc;
+	struct regulator_dev *rdev;
+	int max_spread;
+	unsigned int i;
+
+	for (i = 1; i < c_desc->n_coupled; i++) {
+		max_spread = core_rdev->constraints->max_spread[i - 1];
+		rdev = c_desc->coupled_rdevs[i];
+
+		if (rdev == rtc_rdev && max_spread)
+			return max_spread;
+	}
+
+	pr_err_once("rtc-core max-spread is undefined in device-tree\n");
+
+	return 150000;
+}
+
+static int tegra20_core_rtc_update(struct tegra_regulator_coupler *tegra,
+				   struct regulator_dev *core_rdev,
+				   struct regulator_dev *rtc_rdev,
+				   int cpu_uV, int cpu_min_uV)
+{
+	int core_min_uV, core_max_uV = INT_MAX;
+	int rtc_min_uV, rtc_max_uV = INT_MAX;
+	int core_target_uV;
+	int rtc_target_uV;
+	int max_spread;
+	int core_uV;
+	int rtc_uV;
+	int err;
+
+	/*
+	 * RTC and CORE voltages should be no more than 170mV from each other,
+	 * CPU should be below RTC and CORE by at least 120mV. This applies
+	 * to all Tegra20 SoC's.
+	 */
+	max_spread = tegra20_core_rtc_max_spread(core_rdev, rtc_rdev);
+
+	/*
+	 * The core voltage scaling is currently not hooked up in drivers,
+	 * hence we will limit the minimum core voltage to a reasonable value.
+	 * This should be good enough for the time being.
+	 */
+	core_min_uV = tegra20_core_limit(tegra, core_rdev);
+	if (core_min_uV < 0)
+		return core_min_uV;
+
+	err = regulator_check_voltage(core_rdev, &core_min_uV, &core_max_uV);
+	if (err)
+		return err;
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
+	core_min_uV = max(cpu_min_uV + 125000, core_min_uV);
+	if (core_min_uV > core_max_uV)
+		return -EINVAL;
+
+	if (cpu_uV + 120000 > core_uV)
+		pr_err("core-cpu voltage constraint violated: %d %d\n",
+		       core_uV, cpu_uV + 120000);
+
+	rtc_uV = regulator_get_voltage_rdev(rtc_rdev);
+	if (rtc_uV < 0)
+		return rtc_uV;
+
+	if (cpu_uV + 120000 > rtc_uV)
+		pr_err("rtc-cpu voltage constraint violated: %d %d\n",
+		       rtc_uV, cpu_uV + 120000);
+
+	if (abs(core_uV - rtc_uV) > 170000)
+		pr_err("core-rtc voltage constraint violated: %d %d\n",
+		       core_uV, rtc_uV);
+
+	rtc_min_uV = max(cpu_min_uV + 125000, core_min_uV - max_spread);
+
+	err = regulator_check_voltage(rtc_rdev, &rtc_min_uV, &rtc_max_uV);
+	if (err)
+		return err;
+
+	while (core_uV != core_min_uV || rtc_uV != rtc_min_uV) {
+		if (core_uV < core_min_uV) {
+			core_target_uV = min(core_uV + max_spread, core_min_uV);
+			core_target_uV = min(rtc_uV + max_spread, core_target_uV);
+		} else {
+			core_target_uV = max(core_uV - max_spread, core_min_uV);
+			core_target_uV = max(rtc_uV - max_spread, core_target_uV);
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
+
+		if (rtc_uV < rtc_min_uV) {
+			rtc_target_uV = min(rtc_uV + max_spread, rtc_min_uV);
+			rtc_target_uV = min(core_uV + max_spread, rtc_target_uV);
+		} else {
+			rtc_target_uV = max(rtc_uV - max_spread, rtc_min_uV);
+			rtc_target_uV = max(core_uV - max_spread, rtc_target_uV);
+		}
+
+		err = regulator_set_voltage_rdev(rtc_rdev,
+						 rtc_target_uV,
+						 rtc_max_uV,
+						 PM_SUSPEND_ON);
+		if (err)
+			return err;
+
+		rtc_uV = rtc_target_uV;
+	}
+
+	return 0;
+}
+
+static int tegra20_core_voltage_update(struct tegra_regulator_coupler *tegra,
+				       struct regulator_dev *cpu_rdev,
+				       struct regulator_dev *core_rdev,
+				       struct regulator_dev *rtc_rdev)
+{
+	int cpu_uV;
+
+	cpu_uV = regulator_get_voltage_rdev(cpu_rdev);
+	if (cpu_uV < 0)
+		return cpu_uV;
+
+	return tegra20_core_rtc_update(tegra, core_rdev, rtc_rdev,
+				       cpu_uV, cpu_uV);
+}
+
+static int tegra20_cpu_voltage_update(struct tegra_regulator_coupler *tegra,
+				      struct regulator_dev *cpu_rdev,
+				      struct regulator_dev *core_rdev,
+				      struct regulator_dev *rtc_rdev)
+{
+	int cpu_min_uV_consumers = 0;
+	int cpu_max_uV = INT_MAX;
+	int cpu_min_uV = 0;
+	int cpu_uV;
+	int err;
+
+	err = regulator_check_voltage(cpu_rdev, &cpu_min_uV, &cpu_max_uV);
+	if (err)
+		return err;
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
+	if (cpu_min_uV > cpu_uV) {
+		err = tegra20_core_rtc_update(tegra, core_rdev, rtc_rdev,
+					      cpu_uV, cpu_min_uV);
+		if (err)
+			return err;
+
+		err = regulator_set_voltage_rdev(cpu_rdev, cpu_min_uV,
+						 cpu_max_uV, PM_SUSPEND_ON);
+		if (err)
+			return err;
+	} else if (cpu_min_uV < cpu_uV)  {
+		err = regulator_set_voltage_rdev(cpu_rdev, cpu_min_uV,
+						 cpu_max_uV, PM_SUSPEND_ON);
+		if (err)
+			return err;
+
+		err = tegra20_core_rtc_update(tegra, core_rdev, rtc_rdev,
+					      cpu_uV, cpu_min_uV);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int tegra20_regulator_balance_voltage(struct regulator_coupler *coupler,
+					     struct regulator_dev *rdev,
+					     suspend_state_t state)
+{
+	struct tegra_regulator_coupler *tegra = to_tegra_coupler(coupler);
+	struct regulator_dev *core_rdev = tegra->core_rdev;
+	struct regulator_dev *cpu_rdev = tegra->cpu_rdev;
+	struct regulator_dev *rtc_rdev = tegra->rtc_rdev;
+
+	if ((core_rdev != rdev && cpu_rdev != rdev && rtc_rdev != rdev) ||
+	    state != PM_SUSPEND_ON) {
+		pr_err("regulators are not coupled properly\n");
+		return -EINVAL;
+	}
+
+	if (rdev == cpu_rdev)
+		return tegra20_cpu_voltage_update(tegra, cpu_rdev,
+						  core_rdev, rtc_rdev);
+
+	if (rdev == core_rdev)
+		return tegra20_core_voltage_update(tegra, cpu_rdev,
+						   core_rdev, rtc_rdev);
+
+	pr_err("changing %s voltage not permitted\n", rdev_get_name(rtc_rdev));
+
+	return -EPERM;
+}
+
+static int tegra20_regulator_attach(struct regulator_coupler *coupler,
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
+	if (of_property_read_bool(np, "nvidia,tegra-rtc-regulator") &&
+	    !tegra->rtc_rdev) {
+		tegra->rtc_rdev = rdev;
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
+static int tegra20_regulator_detach(struct regulator_coupler *coupler,
+				    struct regulator_dev *rdev)
+{
+	struct tegra_regulator_coupler *tegra = to_tegra_coupler(coupler);
+
+	if (tegra->core_rdev == rdev) {
+		tegra->core_rdev = NULL;
+		return 0;
+	}
+
+	if (tegra->rtc_rdev == rdev) {
+		tegra->rtc_rdev = NULL;
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
+static struct tegra_regulator_coupler tegra20_coupler = {
+	.coupler = {
+		.attach_regulator = tegra20_regulator_attach,
+		.detach_regulator = tegra20_regulator_detach,
+		.balance_voltage = tegra20_regulator_balance_voltage,
+	},
+};
+
+static int __init tegra_regulator_coupler_init(void)
+{
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		return 0;
+
+	return regulator_coupler_register(&tegra20_coupler.coupler);
+}
+arch_initcall(tegra_regulator_coupler_init);
-- 
2.22.0

