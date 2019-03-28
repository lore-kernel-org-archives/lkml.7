Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E920206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jNDLmX8X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OI24v2TH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfC1P3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:29:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfC1P3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:29:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E370761F56; Thu, 28 Mar 2019 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786954;
        bh=7BMY4QJoj1T/gCui5d+gGvi++TgL+G+x0BzCC+M750c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNDLmX8X+pxV6QKpENBt5P+pMGUT+qHHzXp70jzENQ9HAD2/GDbMLypu0IiZB/N42
         /jwpfivh6oV2nOhmpk5/80ltbL2eI7GLcrHf5Dxy61gc9QeO74Y07bUpJXH06Mv06p
         DJ9+lUlWV4kDfemSqkk8kU5t2jW4Q14dd+glz3jI=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C099A61778;
        Thu, 28 Mar 2019 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786951;
        bh=7BMY4QJoj1T/gCui5d+gGvi++TgL+G+x0BzCC+M750c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI24v2THZqLCEEz3/r+th5BwKuLftsiALnWXCaeJbL8U4LRcp8O0opVneH/QCpgSb
         3BCguZRB2uxpZ0dBQhdRUZh1Ssa4e9TNEpyn2d0OhiI7Wr1qQdoCYsH8UaChgT4i+W
         gg2hd7rNUOBo/fICiAkITzqykWZMzj0/gGzm6ngM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C099A61778
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 5/9] PM / devfreq: Add devfreq driver for interconnect bandwidth voting
Date:   Thu, 28 Mar 2019 20:58:18 +0530
Message-Id: <20190328152822.532-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <skannan@codeaurora.org>

This driver registers itself as a devfreq device that allows devfreq
governors to make bandwidth votes for an interconnect path. This allows
applying various policies for different interconnect paths using devfreq
governors.

Example uses:
* Use the devfreq performance governor to set the CPU to DDR
  interconnect path for maximum performance.
* Use the devfreq powersave governor to set the GPU to DDR
  interconnect path for minimum performance.
* Use the Passive governor to scale the DDR frequency based
  on the needs of the CPUs' current frequency

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
[Sibi: cleanup and added passive governor support]
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/devfreq/Kconfig        |  15 ++++
 drivers/devfreq/Makefile       |   1 +
 drivers/devfreq/devfreq_icbw.c | 132 +++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/devfreq/devfreq_icbw.c

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 9a45f464a56b..0df5b65f157a 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -117,6 +117,21 @@ config ARM_RK3399_DMC_DEVFREQ
           It sets the frequency for the memory controller and reads the usage counts
           from hardware.
 
+config DEVFREQ_ICBW
+	tristate "Driver for making bandwidth votes on interconnect paths"
+	select DEVFREQ_GOV_PASSIVE
+	select DEVFREQ_GOV_PERFORMANCE
+	select DEVFREQ_GOV_POWERSAVE
+	select DEVFREQ_GOV_USERSPACE
+	depends on INTERCONNECT
+	default n
+	help
+	  Different devfreq governors use this devfreq device to make
+	  bandwidth votes for interconnect paths between different devices
+	  (Eg: CPU to DDR, GPU to DDR, etc). This driver provides a generic
+	  interface so that the devfreq governors can be shared across SoCs
+	  and architectures.
+
 source "drivers/devfreq/event/Kconfig"
 
 endif # PM_DEVFREQ
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index 32b8d4d3f12c..66591b0e5259 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
 obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
 obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
+obj-$(CONFIG_DEVFREQ_ICBW)		+= devfreq_icbw.o
 
 # DEVFREQ Event Drivers
 obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
diff --git a/drivers/devfreq/devfreq_icbw.c b/drivers/devfreq/devfreq_icbw.c
new file mode 100644
index 000000000000..c552cf4218c8
--- /dev/null
+++ b/drivers/devfreq/devfreq_icbw.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/devfreq.h>
+#include <linux/interconnect.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+struct icbw_data {
+	struct devfreq *df;
+	struct icc_path *path;
+	u32 cur_ab;
+	u32 cur_pb;
+};
+
+static int icbw_target(struct device *dev, unsigned long *freq, u32 flags)
+{
+	struct dev_pm_opp *opp;
+	struct icbw_data *data = dev_get_drvdata(dev);
+	u32 new_pb, new_ab;
+	int ret;
+
+	opp = devfreq_recommended_opp(dev, freq, flags);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	/* Get avg and peak bandwidth */
+	new_ab = dev_pm_opp_get_avg_bw(opp);
+	new_pb = dev_pm_opp_get_peak_bw(opp);
+	dev_pm_opp_put(opp);
+
+	if (data->cur_pb == new_pb && data->cur_ab == new_ab)
+		return 0;
+
+	dev_dbg(dev, "BW icc: AB: %u PB: %u\n", new_ab, new_pb);
+
+	ret = icc_set_bw(data->path, new_ab, new_pb);
+	if (ret) {
+		dev_err(dev, "bandwidth request failed (%d)\n", ret);
+	} else {
+		data->cur_pb = new_pb;
+		data->cur_ab = new_ab;
+	}
+
+	return ret;
+}
+
+static int devfreq_icbw_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct devfreq_dev_profile *profile;
+	struct devfreq_passive_data *passive_data;
+	struct icbw_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	dev_set_drvdata(dev, data);
+
+	passive_data = devm_kzalloc(dev, sizeof(*passive_data), GFP_KERNEL);
+	if (!passive_data)
+		return -ENOMEM;
+
+	passive_data->cpufreq_type = true;
+
+	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
+	if (!profile)
+		return -ENOMEM;
+
+	profile->target = icbw_target;
+
+	data->path = of_icc_get(dev, NULL);
+	if (IS_ERR(data->path)) {
+		dev_err(dev, "Unable to register interconnect path\n");
+		return PTR_ERR(data->path);
+	}
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret) {
+		dev_err(dev, "Couldn't find OPP table\n");
+		goto err_icc;
+	}
+
+	data->df = devfreq_add_device(dev, profile,
+				      DEVFREQ_GOV_PASSIVE, passive_data);
+	if (IS_ERR(data->df)) {
+		ret = PTR_ERR(data->df);
+		goto err_opp_table;
+	}
+
+	return 0;
+
+err_opp_table:
+	dev_pm_opp_of_remove_table(dev);
+err_icc:
+	icc_put(data->path);
+	return ret;
+}
+
+static int devfreq_icbw_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct icbw_data *data = dev_get_drvdata(dev);
+
+	devfreq_remove_device(data->df);
+	icc_put(data->path);
+	return 0;
+}
+
+static const struct of_device_id icbw_match_table[] = {
+	{ .compatible = "devfreq-icbw" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, icbw_match_table);
+
+static struct platform_driver icbw_driver = {
+	.probe = devfreq_icbw_probe,
+	.remove = devfreq_icbw_remove,
+	.driver = {
+		.name = "devfreq-icbw",
+		.of_match_table = icbw_match_table,
+	},
+};
+module_platform_driver(icbw_driver);
+
+MODULE_DESCRIPTION("Interconnect bandwidth voting driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

