Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3473BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C52620449
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfGZOA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:00:27 -0400
Received: from foss.arm.com ([217.140.110.172]:45056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387395AbfGZOAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:00:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E7CF152D;
        Fri, 26 Jul 2019 07:00:18 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C6CC3F694;
        Fri, 26 Jul 2019 07:00:16 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        aidapala@qti.qualcomm.com, pajay@qti.qualcomm.com,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        wesleys@xilinx.com, Felix Burton <fburton@xilinx.com>,
        Saeed Nowshadi <saeed.nowshadi@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 5/5] reset: Add support for resets provided by SCMI
Date:   Fri, 26 Jul 2019 14:59:54 +0100
Message-Id: <20190726135954.11078-6-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135954.11078-1-sudeep.holla@arm.com>
References: <20190726135954.11078-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some ARM based systems, a separate Cortex-M based System Control
Processor(SCP) provides the overall power, clock, reset and system
control. System Control and Management Interface(SCMI) Message Protocol
is defined for the communication between the Application Cores(AP)
and the SCP.

Adds support for the resets provided using SCMI protocol for performing
reset management of various devices present on the SoC. Various reset
functionalities are achieved by the means of different ARM SCMI device
operations provided by the ARM SCMI framework.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS                |   1 +
 drivers/reset/Kconfig      |  10 +++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-scmi.c | 133 +++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+)
 create mode 100644 drivers/reset/reset-scmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..59df8f88b56d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15545,6 +15545,7 @@ F:	drivers/clk/clk-sc[mp]i.c
 F:	drivers/cpufreq/sc[mp]i-cpufreq.c
 F:	drivers/firmware/arm_scpi.c
 F:	drivers/firmware/arm_scmi/
+F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
 
 SYSTEM RESET/SHUTDOWN DRIVERS
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 21efb7d39d62..09dcc3bf3b7a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -22,6 +22,16 @@ config RESET_A10SR
 	  This option enables support for the external reset functions for
 	  peripheral PHYs on the Altera Arria10 System Resource Chip.
 
+config RESET_ARM_SCMI
+	tristate "Reset driver controlled via ARM SCMI interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	help
+	  This driver provides support for reset signal/domains that are
+	  controlled by firmware that implements the SCMI interface.
+
+	  This driver uses SCMI Message Protocol to interact with the
+	  firmware providing all the reset signals.
+
 config RESET_ATH79
 	bool "AR71xx Reset Driver" if COMPILE_TEST
 	default ATH79
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 61456b8f659c..2f1103d31938 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -4,6 +4,7 @@ obj-y += hisilicon/
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
+obj-$(CONFIG_RESET_ARM_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
new file mode 100644
index 000000000000..9e5d07cac2ed
--- /dev/null
+++ b/drivers/reset/reset-scmi.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM System Control and Management Interface (ARM SCMI) reset driver
+ *
+ * Copyright (C) 2019 ARM Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/scmi_protocol.h>
+
+/**
+ * struct scmi_reset_data - reset controller information structure
+ * @rcdev: reset controller entity
+ * @handle: ARM SCMI handle used for communication with system controller
+ * @dev: reset controller device pointer
+ */
+struct scmi_reset_data {
+	struct reset_controller_dev rcdev;
+	const struct scmi_handle *handle;
+	struct device *dev;
+};
+
+#define to_scmi_reset_data(p)	\
+	container_of((p), struct scmi_reset_data, rcdev)
+
+/**
+ * scmi_reset_assert() - assert device reset
+ * @rcdev: reset controller entity
+ * @id: ID of the reset to be asserted
+ *
+ * This function implements the reset driver op to assert a device's reset
+ * using the ARM SCMI protocol.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int
+scmi_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct scmi_reset_data *data = to_scmi_reset_data(rcdev);
+	const struct scmi_handle *handle = data->handle;
+	int ret;
+
+	ret = handle->reset_ops->assert(handle, id);
+
+	return ret;
+}
+
+/**
+ * scmi_reset_deassert() - deassert device reset
+ * @rcdev: reset controller entity
+ * @id: ID of the reset to be deasserted
+ *
+ * This function implements the reset driver op to deassert a device's reset
+ * using the ARM SCMI protocol.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int
+scmi_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct scmi_reset_data *data = to_scmi_reset_data(rcdev);
+	const struct scmi_handle *handle = data->handle;
+
+	return handle->reset_ops->deassert(handle, id);
+}
+
+/**
+ * scmi_reset_reset() - reset the device
+ * @rcdev: reset controller entity
+ * @id: ID of the reset signal to be reset(assert + deassert)
+ *
+ * This function implements the reset driver op to reset a device's reset
+ * signal using the ARM SCMI protocol.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int
+scmi_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct scmi_reset_data *data = to_scmi_reset_data(rcdev);
+	const struct scmi_handle *handle = data->handle;
+
+	return handle->reset_ops->reset(handle, id);
+}
+
+static const struct reset_control_ops scmi_reset_ops = {
+	.assert		= scmi_reset_assert,
+	.deassert	= scmi_reset_deassert,
+	.reset		= scmi_reset_reset,
+};
+
+static int scmi_reset_probe(struct scmi_device *sdev)
+{
+	struct scmi_reset_data *data;
+	struct device *dev = &sdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct scmi_handle *handle = sdev->handle;
+
+	if (!handle || !handle->reset_ops)
+		return -ENODEV;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->rcdev.ops = &scmi_reset_ops;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.of_node = np;
+	data->dev = dev;
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_RESET },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_reset_driver = {
+	.name = "scmi-reset",
+	.probe = scmi_reset_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_reset_driver);
+
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

