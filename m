Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204EBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB06C217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gncnD68s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfDEKZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:25:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40135 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfDEKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:25:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so2833347pgo.7;
        Fri, 05 Apr 2019 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7+gZA3YzAJy9PwL0DhGaxeNKZSv2naTy//K+ECSQLls=;
        b=gncnD68snuiqU06YzL4C/UY7aSHm8wDO8RrdIu9lEUnkqAL3WADj2fin0haGlAdEoj
         WLNktvYjzF7BU5KtU70ShshC8LqSP2y8aKTry11LFJItVDT9t3hp9wltGUqUyh+dUn3D
         0I5JAvWgfaLOFzeg4beJht4ZO548nnVLTS6PxK4pKpJC4U9NDgxxWSTHNWln972aWnIx
         vweLQigUO1xCK9tROj+C4IxDZA9ovNz6pLOzA9JU6WiqYAcq3CvG/OwLBS88XUIma1J4
         cOFPglUXr0JFxkKKRT6QIc8gJv4jNuPWZ9l49XGiXbso1bLq1lLbRVXROh74Yi3fXQy5
         ATAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7+gZA3YzAJy9PwL0DhGaxeNKZSv2naTy//K+ECSQLls=;
        b=eFGWVPZ9Z1hz6FaS+WiwPdUBawMe7OqwuPMcOdGwvk/uLy2Gya3Olghps0bgeaRisY
         6UbRZYsTD2gf/e4QPvZyc2eecw1xl7FikSCSWmyEaDx78hvCcDV0T/qm+/XqqbnumFe3
         DHla1XzzCEF/os93IMEqwftUdH1kJCISydLcm9oKU3SlVxnrUzFjlkwwA/+5MlXbSv+o
         1N7YCsY4vnuwhEPxVkln/vWUk8swn6c39Vxl15gD3YQyji667zZqFDtICl3DnlB7M0UZ
         FAFqwu9rTMWafJ6U/8Yt5B0JQVqamWChyToulAKKssGAy96VfqC78QvvYoDqWntluhRc
         4g3Q==
X-Gm-Message-State: APjAAAVKHsPMPWiIVuUntKKIuxPM6icaU3ZxRwg9i3D7eIuqay1TXXH1
        B58tddGIKIMa+pWqSiIPhOI=
X-Google-Smtp-Source: APXvYqxZYfzCstKaiN5g7jf6ckh5bJJzJfmt9GURQ1oajFIwRfsRJJtihhUmWe/l7kwy68r2rG7KwA==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr11600972pfo.181.1554459905958;
        Fri, 05 Apr 2019 03:25:05 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v15sm30870895pff.105.2019.04.05.03.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 03:25:05 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date:   Fri,  5 Apr 2019 06:24:54 -0400
Message-Id: <20190405102455.15311-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405102455.15311-1-tiny.windzz@gmail.com>
References: <20190405102455.15311-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some SoCs, the CPU frequency subset and voltage value of each OPP
varies based on the silicon variant in use. Allwinner Process Voltage
Scaling Tables defines the voltage and frequency value  based on the
speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
reads the efuse value from the SoC to provide the OPP framework with
required information.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 MAINTAINERS                           |   7 +
 drivers/cpufreq/Kconfig.arm           |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c  |   2 +
 drivers/cpufreq/sunxi-cpufreq-nvmem.c | 236 ++++++++++++++++++++++++++
 5 files changed, 256 insertions(+)
 create mode 100644 drivers/cpufreq/sunxi-cpufreq-nvmem.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 391405091c6b..bfd18ba6aa1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -667,6 +667,13 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALLWINNER CPUFREQ DRIVER
+M:	Yangtao Li <tiny.windzz@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
+F:	drivers/cpufreq/sunxi-cpufreq-nvmem.c
+
 ALLWINNER SECURITY SYSTEM
 M:	Corentin Labbe <clabbe.montjoie@gmail.com>
 L:	linux-crypto@vger.kernel.org
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 179a1d302f48..25933c4321a7 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -18,6 +18,16 @@ config ACPI_CPPC_CPUFREQ
 
 	  If in doubt, say N.
 
+config ARM_ALLWINNER_CPUFREQ_NVMEM
+	tristate "Allwinner nvmem based CPUFreq"
+	depends on ARCH_SUNXI
+	depends on NVMEM_SUNXI_SID
+	select PM_OPP
+	help
+	  This adds the CPUFreq driver for Allwinner nvmem based SoC.
+
+	  If in doubt, say N.
+
 config ARM_ARMADA_37XX_CPUFREQ
 	tristate "Armada 37xx CPUFreq support"
 	depends on ARCH_MVEBU && CPUFREQ_DT
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 689b26c6f949..da28de67613c 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
+obj-$(CONFIG_ARM_ALLWINNER_CPUFREQ_NVMEM) += sunxi-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 47729a22c159..50e7810f3a28 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -105,6 +105,8 @@ static const struct of_device_id whitelist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blacklist[] __initconst = {
+	{ .compatible = "allwinner,sun50i-h6", },
+
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
 
diff --git a/drivers/cpufreq/sunxi-cpufreq-nvmem.c b/drivers/cpufreq/sunxi-cpufreq-nvmem.c
new file mode 100644
index 000000000000..e189f94592d5
--- /dev/null
+++ b/drivers/cpufreq/sunxi-cpufreq-nvmem.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Allwinner CPUFreq nvmem based driver
+ *
+ * Copyright (C) 2019 Yangtao Li <tiny.windzz@gmail.com>
+ */
+
+/*
+ * For some SoCs, the CPU frequency subset and voltage value of each OPP
+ * varies based on the silicon variant in use. Allwinner Process Voltage
+ * Scaling Tables defines the voltage and frequency value  based on the
+ * speedbin blown in the efuse combination. The sunxi-cpufreq-nvmem driver
+ * reads the efuse value from the SoC to provide the OPP framework with
+ * required information.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+struct sunxi_cpufreq_soc_data {
+	u32 (*efuse_xlate)(const struct sunxi_cpufreq_soc_data *soc_data,
+			   u32 efuse);
+	u32 nvmem_mask;
+	u32 nvmem_shift;
+};
+
+static struct platform_device *cpufreq_dt_pdev, *sunxi_cpufreq_pdev;
+
+static u32 sun50i_efuse_xlate(const struct sunxi_cpufreq_soc_data *soc_data,
+			  u32 efuse)
+{
+	return 1 << (efuse >> soc_data->nvmem_shift) & soc_data->nvmem_mask;
+}
+
+/**
+ * sunxi_cpufreq_get_efuse() - Parse and return efuse value present on SoC
+ * @soc_data: pointer to sunxi_cpufreq_soc_data context
+ * @versions: Set to the value parsed from efuse
+ *
+ * Returns 0 if success.
+ */
+static int sunxi_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data,
+				   u32 *versions)
+{
+	struct nvmem_cell *speedbin_nvmem;
+	struct device_node *np;
+	struct device *cpu_dev;
+	u32 *speedbin;
+	size_t len;
+	int ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	if (!np)
+		return -ENOENT;
+
+	ret = of_device_is_compatible(np, "operating-points-v2-sunxi-cpu");
+	if (!ret) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+
+	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+	of_node_put(np);
+	if (IS_ERR(speedbin_nvmem)) {
+		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
+			pr_err("Could not get nvmem cell: %ld\n",
+				PTR_ERR(speedbin_nvmem));
+		return PTR_ERR(speedbin_nvmem);
+	}
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	nvmem_cell_put(speedbin_nvmem);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	*versions = soc_data->efuse_xlate(soc_data, *speedbin);
+
+	kfree(speedbin);
+	return 0;
+};
+
+static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
+	.efuse_xlate = sun50i_efuse_xlate,
+	.nvmem_mask = 0x7,
+	.nvmem_shift = 5,
+};
+
+static const struct of_device_id sunxi_cpufreq_match_list[] = {
+	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
+	{}
+};
+
+static const struct of_device_id *sunxi_cpufreq_match_node(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(sunxi_cpufreq_match_list, np);
+	of_node_put(np);
+
+	return match;
+}
+
+static int sunxi_cpufreq_nvmem_probe(struct platform_device *pdev)
+{
+	const struct sunxi_cpufreq_soc_data *soc_data;
+	struct opp_table **opp_tables;
+	const struct of_device_id *match;
+	unsigned int cpu;
+	u32 versions;
+	int ret;
+
+	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
+			     GFP_KERNEL);
+	if (!opp_tables)
+		return -ENOMEM;
+
+	match = sunxi_cpufreq_match_node();
+	soc_data = match->data;
+	if (!soc_data)
+		return -EINVAL;
+
+	ret = sunxi_cpufreq_get_efuse(soc_data, &versions);
+	if (ret)
+		return ret;
+
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev = get_cpu_device(cpu);
+
+		if (NULL == cpu_dev) {
+			ret = -ENODEV;
+			goto free_opp;
+		}
+
+		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
+							      &versions, 1);
+		if (IS_ERR(opp_tables[cpu])) {
+			ret = PTR_ERR(opp_tables[cpu]);
+			pr_err("Failed to set supported hardware\n");
+			goto free_opp;
+		}
+	}
+
+	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
+							  NULL, 0);
+	if (!IS_ERR(cpufreq_dt_pdev)) {
+		platform_set_drvdata(pdev, opp_tables);
+		return 0;
+	}
+
+	ret = PTR_ERR(cpufreq_dt_pdev);
+	pr_err("Failed to register platform device\n");
+
+free_opp:
+	for_each_possible_cpu(cpu) {
+		if (IS_ERR_OR_NULL(opp_tables[cpu]))
+			break;
+		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+	}
+	kfree(opp_tables);
+
+	return ret;
+}
+
+static int sunxi_cpufreq_nvmem_remove(struct platform_device *pdev)
+{
+	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	unsigned int cpu;
+
+	platform_device_unregister(cpufreq_dt_pdev);
+
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+
+	kfree(opp_tables);
+
+	return 0;
+}
+
+static struct platform_driver sunxi_cpufreq_driver = {
+	.probe = sunxi_cpufreq_nvmem_probe,
+	.remove = sunxi_cpufreq_nvmem_remove,
+	.driver = {
+		.name = "sunxi-cpufreq-nvmem",
+	},
+};
+
+/*
+ * Since the driver depends on nvmem drivers, which may return EPROBE_DEFER,
+ * all the real activity is done in the probe, which may be defered as well.
+ * The init here is only registering the driver and the platform device.
+ */
+static int __init sunxi_cpufreq_init(void)
+{
+	const struct of_device_id *match;
+	int ret;
+
+	match = sunxi_cpufreq_match_node();
+	if (!match)
+		return -ENODEV;
+
+	ret = platform_driver_register(&sunxi_cpufreq_driver);
+	if (unlikely(ret < 0))
+		return ret;
+
+	sunxi_cpufreq_pdev = platform_device_register_simple(
+		"sunxi-cpufreq-nvmem", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(sunxi_cpufreq_pdev);
+	if (0 == ret)
+		return 0;
+
+	platform_driver_unregister(&sunxi_cpufreq_driver);
+	return ret;
+}
+module_init(sunxi_cpufreq_init);
+
+static void __exit sunxi_cpufreq_exit(void)
+{
+	platform_device_unregister(sunxi_cpufreq_pdev);
+	platform_driver_unregister(&sunxi_cpufreq_driver);
+}
+module_exit(sunxi_cpufreq_exit);
+
+MODULE_DESCRIPTION("Sunxi cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0

