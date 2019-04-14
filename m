Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4307CC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BD92175B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNFCAOfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDNSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:06:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43167 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:06:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so7444590pfd.10;
        Sun, 14 Apr 2019 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyeyE30t3+QkNeGEJDj6X4cHeIUYKsd28+MRNW6dPlE=;
        b=WNFCAOfncHPYIhxyKuHaPJIjuIjk8hYRd6NsO+vanH1eYr2YVfR5JPpazSYc/NT/9F
         R9kF7bINdAIfRax1ykGfnzjBW6PjGQ4zGI/+bVmu6Vn4gnAnnPViE5/tzxzmhUtTOsKI
         zcoe28PjRkZfm6lNJYwnxdtUyxNmwnpmouUbym1MzoaBqkBO9Ls43r9OyGlM3QqAx35x
         IXY0ctQNTmR8TWx/yJenxutW+1knDRbAlHWcxIkSYHm7Z3EuUGEQOeuHiHdZNLgJLFXU
         wFROTAYaYdyamsoy1+7JEcxlIh+Migg1O7/IMoXGoucvkZaS4YqzK4SHUWuJE2HhljdV
         qTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyeyE30t3+QkNeGEJDj6X4cHeIUYKsd28+MRNW6dPlE=;
        b=sA7b0TG0ZWOvfVXbtrgi4JdOt5di0+jZwKM5GoMlje/5lDW4rUushpvTeCp53ssIyO
         xI7/C83cimyxqT81TbtmAvR3tiNEb3oUEK6QPwjYLtwq2iqxY+Ot+jEwXo3n19I4OsVs
         uQ0plfxTiwHJZNXLWtRinLgmsGGK2MkWakPGWcyB45RzpMkpixBCrd+oB2wS0cGU1Itz
         RwLCCDMaJAlsjIyBtX1atKGDkthluaY27rBhMrWmd322YiGRViClCEKk9zpx9TjC9E33
         TYDZZxd8DrpHmL++Gnm0tkpoenunqo1yG0r3jcEKtwkVXZTKP7y+TuGSOh3ky0KP3MgZ
         qLHg==
X-Gm-Message-State: APjAAAXFk2109/Ts5SmxTyd3ZbG0Sr3VKhS1L8jRfFPlGNPZUrMEaoFS
        +ucFBL9OCIXyls3kudRgBvA=
X-Google-Smtp-Source: APXvYqz1KY2XMNv4I+uLKKoYmOKU9/A/hha3VmXnCVfrzc4Uikh9kNiAlywvB3mb60y6bz6e0PT6PA==
X-Received: by 2002:a65:408b:: with SMTP id t11mr61973250pgp.372.1555265181127;
        Sun, 14 Apr 2019 11:06:21 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e7sm43359712pfc.132.2019.04.14.11.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 11:06:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler for Tegra30
Date:   Sun, 14 Apr 2019 20:59:39 +0300
Message-Id: <20190414175939.12368-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414175939.12368-1-digetx@gmail.com>
References: <20190414175939.12368-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulators coupler for Tegra30 SoC's that performs voltage balancing
of a coupled regulators and thus provides voltage scaling functionality.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/Kconfig              |   6 +
 drivers/soc/tegra/Makefile             |   1 +
 drivers/soc/tegra/regulators-tegra30.c | 256 +++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/soc/tegra/regulators-tegra30.c

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 545c0da2e069..a5235af27644 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -139,3 +139,9 @@ config SOC_TEGRA20_VOLTAGE_COUPLER
 	def_bool y
 	depends on ARCH_TEGRA_2x_SOC
 	depends on REGULATOR
+
+config SOC_TEGRA30_VOLTAGE_COUPLER
+	bool "Voltage scaling support for Tegra30 SoC's"
+	def_bool y
+	depends on ARCH_TEGRA_3x_SOC
+	depends on REGULATOR
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
index 000000000000..ecd6a984e045
--- /dev/null
+++ b/drivers/soc/tegra/regulators-tegra30.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Voltage regulators coupling resolver for NVIDIA Tegra30
+ *
+ * Author: Dmitry Osipenko <digetx@gmail.com>
+ */
+
+#define pr_fmt(fmt)	"tegra voltage-coupler: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#include <soc/tegra/fuse.h>
+
+struct tegra_regulators_coupler {
+	struct regulators_coupler coupler;
+	int core_min_uV;
+};
+
+static const char * const cpu_names[] = {
+	"vdd_cpu,vdd_sys",
+	"+V1.0_VDD_CPU",
+	"vdd_cpu",
+};
+
+static const char * const core_names[] = {
+	"tps62361-vout",
+	"tps62362-vout",
+	"vdd_core",
+};
+
+static inline struct tegra_regulators_coupler *
+to_tegra_coupler(struct regulators_coupler *coupler)
+{
+	return container_of(coupler, struct tegra_regulators_coupler, coupler);
+}
+
+static int tegra30_core_limit(struct tegra_regulators_coupler *tegra,
+			      struct regulator_dev *core_rdev)
+{
+	if (tegra->core_min_uV > 0)
+		return tegra->core_min_uV;
+
+	tegra->core_min_uV = regulator_get_voltage_rdev(core_rdev);
+	if (tegra->core_min_uV > 0)
+		pr_info("core minimum voltage limited to %duV\n",
+			tegra->core_min_uV);
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
+		case 7:
+		case 8:
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
+static int tegra30_voltage_update(struct tegra_regulators_coupler *tegra,
+				  struct regulator_dev *cpu_rdev,
+				  struct regulator_dev *core_rdev)
+{
+	int cpu_min_uV, cpu_max_uV = INT_MAX;
+	int core_min_uV, core_max_uV = INT_MAX;
+	int core_min_limited_uV;
+	int core_target_uV;
+	int cpu_target_uV;
+	int core_uV;
+	int cpu_uV;
+	int err;
+
+	/*
+	 * The CORE voltage scaling is currently not hooked up in drivers,
+	 * hence we will limit the minimum CORE voltage to the initial value.
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
+	cpu_min_uV = core_min_uV - 300000;
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
+			cpu_target_uV = min(cpu_uV + 100000, cpu_min_uV);
+		} else {
+			cpu_target_uV = max(cpu_uV - 100000, cpu_min_uV);
+			cpu_target_uV = max(core_uV - 300000, cpu_target_uV);
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
+			core_target_uV = min(core_target_uV, core_uV + 100000);
+			core_target_uV = min(core_target_uV, cpu_uV + 300000);
+		} else {
+			core_target_uV = max(core_target_uV, core_uV - 100000);
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
+static struct regulator_dev *lookup_rdev(struct regulator_dev *rdev,
+					 const char * const *names,
+					 unsigned int num_names)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	unsigned int i, k;
+
+	for (i = 0; i < num_names; i++) {
+		if (!strcmp(names[i], rdev_get_name(rdev)))
+			return rdev;
+	}
+
+	for (k = 0; k < c_desc->n_coupled; k++) {
+		rdev = c_desc->coupled_rdevs[k];
+
+		for (i = 0; i < num_names; i++) {
+			if (!strcmp(names[i], rdev_get_name(rdev)))
+				return rdev;
+		}
+	}
+
+	pr_err_once("%s: failed for %s\n", __func__, rdev_get_name(rdev));
+
+	for (i = 0; i < num_names; i++)
+		pr_err_once("%s: entry%u: %s\n", __func__, i, names[i]);
+
+	return NULL;
+}
+
+static int tegra30_regulator_balance_voltage(struct regulators_coupler *coupler,
+					     struct regulator_dev *rdev,
+					     suspend_state_t state)
+{
+	struct tegra_regulators_coupler *tegra = to_tegra_coupler(coupler);
+	struct regulator_dev *core_rdev;
+	struct regulator_dev *cpu_rdev;
+
+	core_rdev = lookup_rdev(rdev, core_names, ARRAY_SIZE(core_names));
+	cpu_rdev  = lookup_rdev(rdev, cpu_names, ARRAY_SIZE(cpu_names));
+
+	if (!core_rdev || !cpu_rdev || state != PM_SUSPEND_ON) {
+		pr_err("regulators are not coupled properly\n");
+		return -EINVAL;
+	}
+
+	return tegra30_voltage_update(tegra, cpu_rdev, core_rdev);
+}
+
+static struct tegra_regulators_coupler tegra30_coupler = {
+	.coupler = {
+		.balance_voltage = tegra30_regulator_balance_voltage,
+	},
+};
+
+static int __init tegra_regulators_coupler_init(void)
+{
+	if (!of_machine_is_compatible("nvidia,tegra30"))
+		return 0;
+
+	return regulators_coupler_register(&tegra30_coupler.coupler);
+}
+arch_initcall(tegra_regulators_coupler_init);
-- 
2.21.0

