Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5478C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801012186A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax1Wu1yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDKWhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:37:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44399 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:37:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id h18so5909936lfj.11;
        Thu, 11 Apr 2019 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIT5mwanOywEIosT92z5PbLBPBRJnXpwDI1N80242dk=;
        b=ax1Wu1yyA+2u42hbOOkMr4Ht3ekuxa/xvAYho59Ih54kGdvPCpnqXvnLM+FO+bIjXj
         jhTy7rNThzrMBKDxfSbzwbFUlJOVXAYro+THIKEvlrSiF/2O9uJMy8jIRgi987gqNgz6
         8ECw9nINMWaoXfKBKvYGPdbETS5PhLNVB6HgWnN3ULcmuG80vKj6TnTl76Qd0RhoVbWU
         OrAkEKQf/xP6oCqs6RoQLNu5f984bY3/yWzyqwqZLte3j1G2sE5afM4ykCptYyrEwsox
         49PD1v8iVw/RN6ATmcPirfBHisotAiqRkDQVwp9SY0kC7Orl5w/ZBme7xl60RPIc8CZc
         RuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIT5mwanOywEIosT92z5PbLBPBRJnXpwDI1N80242dk=;
        b=SBVguYcxND9Amtnba+nD6xlpYrenKZP3VfLdpy6bZCm97w69DVIdkMUSzy7D8rvyZG
         w5uGV7V3iyhdc+kz8Rnqwjj3k29LuajQO6GrrMUeivxV4b0PxPwviZ6Lm0/UMLtXQEfA
         sYpgQfJJu8Zb4B9INfCV4HzvEQ5R+a048mIbKQT+ovMSZszCGWiZvZRLaNIsBtbi4J0s
         JMvjUrbFSeEVY/rsKXzs0cYEbHc7JIQsPpHpSvrjkq4iG9dZjxFqKiAJGFw6lnXViRfE
         fafwxcNeQXDAOILg7NGRg0lxeEl9qCnX9drG2ljX6w/mp/8XHUPlD+zxhjW7hXVGpl69
         ymyg==
X-Gm-Message-State: APjAAAXxFnAgCSXRq4jsRvy8QfKVUHHhsqePoHpXP6sPMQw/uSl7dvwE
        t+ehR+cAZszGJMdu12jwnGQ=
X-Google-Smtp-Source: APXvYqx2z6HxuuSSEHCvRNuWCMuImyUT2oBT3VYQfFABG3IVuaPt+c6UPzL/+IjFlxdScLwOEpVjHw==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr21989120lfk.49.1555022247929;
        Thu, 11 Apr 2019 15:37:27 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l4sm7691381lfp.29.2019.04.11.15.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:37:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1] PM / devfreq: Introduce driver for NVIDIA Tegra20
Date:   Fri, 12 Apr 2019 01:36:53 +0300
Message-Id: <20190411223653.27322-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
reads out Memory Controller counters and adjusts memory frequency based
on the memory clients activity.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS                       |   8 ++
 drivers/devfreq/Kconfig           |  10 ++
 drivers/devfreq/Makefile          |   1 +
 drivers/devfreq/tegra20-devfreq.c | 177 ++++++++++++++++++++++++++++++
 4 files changed, 196 insertions(+)
 create mode 100644 drivers/devfreq/tegra20-devfreq.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 80b59db1b6e4..91f475ec4545 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10056,6 +10056,14 @@ F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
+MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/tegra20-devfreq.c
+
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 6bae9688a52b..c2a1f791ca86 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -101,6 +101,16 @@ config ARM_TEGRA_DEVFREQ
 	  It reads ACTMON counters of memory controllers and adjusts the
 	  operating frequencies and voltages with OPP support.
 
+config ARM_TEGRA20_DEVFREQ
+	tristate "Tegra20 DEVFREQ Driver"
+	depends on TEGRA_MC && TEGRA20_EMC
+	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select PM_OPP
+	help
+	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
+	  It reads Memory Controller counters and adjusts the operating
+	  frequencies and voltages with OPP support.
+
 config ARM_RK3399_DMC_DEVFREQ
 	tristate "ARM RK3399 DMC DEVFREQ Driver"
 	depends on ARCH_ROCKCHIP
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d3f12c..6fcc5596b8b7 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
new file mode 100644
index 000000000000..18c9aad7a9d7
--- /dev/null
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra20 devfreq driver
+ *
+ * Author: Dmitry Osipenko <digetx@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/devfreq.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#include <soc/tegra/mc.h>
+
+#include "governor.h"
+
+#define MC_STAT_CONTROL				0x90
+#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
+#define MC_STAT_EMC_CLOCKS			0xa4
+#define MC_STAT_EMC_CONTROL			0xa8
+#define MC_STAT_EMC_COUNT			0xb8
+
+#define EMC_GATHER_CLEAR			(1 << 8)
+#define EMC_GATHER_ENABLE			(3 << 8)
+
+struct tegra_devfreq {
+	struct devfreq *devfreq;
+	struct clk *clk;
+	void __iomem *regs;
+};
+
+static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
+				u32 flags)
+{
+	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	int err;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	rate = dev_pm_opp_get_freq(opp);
+	dev_pm_opp_put(opp);
+
+	err = clk_set_min_rate(tegra->clk, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(tegra->clk, 0);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int tegra_devfreq_get_dev_status(struct device *dev,
+					struct devfreq_dev_status *stat)
+{
+	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
+
+	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
+	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;
+	stat->current_frequency = clk_get_rate(tegra->clk);
+
+	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
+	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
+
+	return 0;
+}
+
+static struct devfreq_dev_profile tegra_devfreq_profile = {
+	.polling_ms	= 500,
+	.target		= tegra_devfreq_target,
+	.get_dev_status	= tegra_devfreq_get_dev_status,
+};
+
+static struct tegra_mc *tegra_get_memory_controller(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct tegra_mc *mc;
+
+	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return ERR_PTR(-ENODEV);
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return mc;
+}
+
+static int tegra_devfeq_probe(struct platform_device *pdev)
+{
+	struct tegra_devfreq *tegra;
+	struct tegra_mc *mc;
+	unsigned long max_rate;
+	unsigned long rate;
+	int err;
+
+	mc = tegra_get_memory_controller();
+	if (IS_ERR(mc)) {
+		err = PTR_ERR(mc);
+		dev_err(&pdev->dev, "failed to get mc: %d\n", err);
+		return err;
+	}
+
+	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
+	if (!tegra)
+		return -ENOMEM;
+
+	tegra->clk = devm_clk_get(&pdev->dev, "emc");
+	if (IS_ERR(tegra->clk)) {
+		err = PTR_ERR(tegra->clk);
+		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
+		return err;
+	}
+
+	tegra->regs = mc->regs;
+
+	max_rate = clk_round_rate(tegra->clk, ULONG_MAX);
+
+	for (rate = 0; rate <= max_rate; rate++) {
+		rate = clk_round_rate(tegra->clk, rate);
+		dev_pm_opp_add(&pdev->dev, rate, 0);
+	}
+
+	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
+	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
+	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);
+
+	platform_set_drvdata(pdev, tegra);
+
+	tegra->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
+					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
+	if (IS_ERR(tegra->devfreq))
+		return PTR_ERR(tegra->devfreq);
+
+	return 0;
+}
+
+static int tegra_devfreq_remove(struct platform_device *pdev)
+{
+	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
+
+	devfreq_remove_device(tegra->devfreq);
+	dev_pm_opp_remove_all_dynamic(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver tegra_devfeq_driver = {
+	.probe		= tegra_devfeq_probe,
+	.remove		= tegra_devfreq_remove,
+	.driver		= {
+		.name	= "tegra20-devfreq",
+	},
+};
+module_platform_driver(tegra_devfeq_driver);
+
+MODULE_ALIAS("platform:tegra20-devfreq");
+MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra20 devfreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0

