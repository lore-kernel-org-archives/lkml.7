Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8B0C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9559B27D8C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfFCI2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:28:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58252 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfFCI2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:28:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FE9A20015A;
        Mon,  3 Jun 2019 10:28:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 915022003C1;
        Mon,  3 Jun 2019 10:28:23 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5E4E6402CF;
        Mon,  3 Jun 2019 16:28:15 +0800 (SGT)
From:   peng.fan@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com,
        sudeep.holla@arm.com, f.fainelli@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, shawnguo@kernel.org,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andre.przywara@arm.com, van.freenix@gmail.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Date:   Mon,  3 Jun 2019 16:30:05 +0800
Message-Id: <20190603083005.4304-3-peng.fan@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603083005.4304-1-peng.fan@nxp.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This mailbox driver implements a mailbox which signals transmitted data
via an ARM smc (secure monitor call) instruction. The mailbox receiver
is implemented in firmware and can synchronously return data when it
returns execution to the non-secure world again.
An asynchronous receive path is not implemented.
This allows the usage of a mailbox to trigger firmware actions on SoCs
which either don't have a separate management processor or on which such
a core is not available. A user of this mailbox could be the SCP
interface.

Modified from Andre Przywara's v2 patch
https://lore.kernel.org/patchwork/patch/812999/

Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add interrupts notification support.

 drivers/mailbox/Kconfig                 |   7 ++
 drivers/mailbox/Makefile                |   2 +
 drivers/mailbox/arm-smc-mailbox.c       | 190 ++++++++++++++++++++++++++++++++
 include/linux/mailbox/arm-smc-mailbox.h |  10 ++
 4 files changed, 209 insertions(+)
 create mode 100644 drivers/mailbox/arm-smc-mailbox.c
 create mode 100644 include/linux/mailbox/arm-smc-mailbox.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 595542bfae85..c3bd0f1ddcd8 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -15,6 +15,13 @@ config ARM_MHU
 	  The controller has 3 mailbox channels, the last of which can be
 	  used in Secure mode only.
 
+config ARM_SMC_MBOX
+	tristate "Generic ARM smc mailbox"
+	depends on OF && HAVE_ARM_SMCCC
+	help
+	  Generic mailbox driver which uses ARM smc calls to call into
+	  firmware for triggering mailboxes.
+
 config IMX_MBOX
 	tristate "i.MX Mailbox"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index c22fad6f696b..93918a84c91b 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
 
 obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
 
+obj-$(CONFIG_ARM_SMC_MBOX)	+= arm-smc-mailbox.o
+
 obj-$(CONFIG_IMX_MBOX)	+= imx-mailbox.o
 
 obj-$(CONFIG_ARMADA_37XX_RWTM_MBOX)	+= armada-37xx-rwtm-mailbox.o
diff --git a/drivers/mailbox/arm-smc-mailbox.c b/drivers/mailbox/arm-smc-mailbox.c
new file mode 100644
index 000000000000..fef6e38d8b98
--- /dev/null
+++ b/drivers/mailbox/arm-smc-mailbox.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016,2017 ARM Ltd.
+ * Copyright 2019 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/arm-smc-mailbox.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define ARM_SMC_MBOX_USE_HVC	BIT(0)
+#define ARM_SMC_MBOX_USB_IRQ	BIT(1)
+
+struct arm_smc_chan_data {
+	u32 function_id;
+	u32 flags;
+	int irq;
+};
+
+static int arm_smc_send_data(struct mbox_chan *link, void *data)
+{
+	struct arm_smc_chan_data *chan_data = link->con_priv;
+	struct arm_smccc_mbox_cmd *cmd = data;
+	struct arm_smccc_res res;
+	u32 function_id;
+
+	if (chan_data->function_id != UINT_MAX)
+		function_id = chan_data->function_id;
+	else
+		function_id = cmd->a0;
+
+	if (chan_data->flags & ARM_SMC_MBOX_USE_HVC)
+		arm_smccc_hvc(function_id, cmd->a1, cmd->a2, cmd->a3, cmd->a4,
+			      cmd->a5, cmd->a6, cmd->a7, &res);
+	else
+		arm_smccc_smc(function_id, cmd->a1, cmd->a2, cmd->a3, cmd->a4,
+			      cmd->a5, cmd->a6, cmd->a7, &res);
+
+	if (chan_data->irq)
+		return 0;
+
+	mbox_chan_received_data(link, (void *)res.a0);
+
+	return 0;
+}
+
+static const struct mbox_chan_ops arm_smc_mbox_chan_ops = {
+	.send_data	= arm_smc_send_data,
+};
+
+static irqreturn_t chan_irq_handler(int irq, void *data)
+{
+	struct mbox_chan *chan = data;
+
+	mbox_chan_received_data(chan, NULL);
+
+	return IRQ_HANDLED;
+}
+
+static int arm_smc_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mbox_controller *mbox;
+	struct arm_smc_chan_data *chan_data;
+	const char *method;
+	bool use_hvc = false;
+	int ret, irq_count, i;
+	u32 val;
+
+	if (!of_property_read_u32(dev->of_node, "arm,num-chans", &val)) {
+		if (val < 1 || val > INT_MAX) {
+			dev_err(dev, "invalid arm,num-chans value %u of %pOFn\n", val, pdev->dev.of_node);
+			return -EINVAL;
+		}
+	}
+
+	irq_count = platform_irq_count(pdev);
+	if (irq_count == -EPROBE_DEFER)
+		return irq_count;
+
+	if (irq_count && irq_count != val) {
+		dev_err(dev, "Interrupts not match num-chans\n");
+		return -EINVAL;
+	}
+
+	if (!of_property_read_string(dev->of_node, "method", &method)) {
+		if (!strcmp("hvc", method)) {
+			use_hvc = true;
+		} else if (!strcmp("smc", method)) {
+			use_hvc = false;
+		} else {
+			dev_warn(dev, "invalid \"method\" property: %s\n",
+				 method);
+
+			return -EINVAL;
+		}
+	}
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	mbox->num_chans = val;
+	mbox->chans = devm_kcalloc(dev, mbox->num_chans, sizeof(*mbox->chans),
+				   GFP_KERNEL);
+	if (!mbox->chans)
+		return -ENOMEM;
+
+	chan_data = devm_kcalloc(dev, mbox->num_chans, sizeof(*chan_data),
+				 GFP_KERNEL);
+	if (!chan_data)
+		return -ENOMEM;
+
+	for (i = 0; i < mbox->num_chans; i++) {
+		u32 function_id;
+
+		ret = of_property_read_u32_index(dev->of_node,
+						 "arm,func-ids", i,
+						 &function_id);
+		if (ret)
+			chan_data[i].function_id = UINT_MAX;
+
+		else
+			chan_data[i].function_id = function_id;
+
+		if (use_hvc)
+			chan_data[i].flags |= ARM_SMC_MBOX_USE_HVC;
+		mbox->chans[i].con_priv = &chan_data[i];
+
+		if (irq_count) {
+			chan_data[i].irq = platform_get_irq(pdev, i);
+			if (chan_data[i].irq < 0)
+				return chan_data[i].irq;
+
+			ret = devm_request_irq(&pdev->dev, chan_data[i].irq,
+					       chan_irq_handler, 0, pdev->name,
+					       &mbox->chans[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	mbox->txdone_poll = false;
+	mbox->txdone_irq = false;
+	mbox->ops = &arm_smc_mbox_chan_ops;
+	mbox->dev = dev;
+
+	ret = mbox_controller_register(mbox);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, mbox);
+	dev_info(dev, "ARM SMC mailbox enabled with %d chan%s.\n",
+		 mbox->num_chans, mbox->num_chans == 1 ? "" : "s");
+
+	return ret;
+}
+
+static int arm_smc_mbox_remove(struct platform_device *pdev)
+{
+	struct mbox_controller *mbox = platform_get_drvdata(pdev);
+
+	mbox_controller_unregister(mbox);
+	return 0;
+}
+
+static const struct of_device_id arm_smc_mbox_of_match[] = {
+	{ .compatible = "arm,smc-mbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, arm_smc_mbox_of_match);
+
+static struct platform_driver arm_smc_mbox_driver = {
+	.driver = {
+		.name = "arm-smc-mbox",
+		.of_match_table = arm_smc_mbox_of_match,
+	},
+	.probe		= arm_smc_mbox_probe,
+	.remove		= arm_smc_mbox_remove,
+};
+module_platform_driver(arm_smc_mbox_driver);
+
+MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
+MODULE_DESCRIPTION("Generic ARM smc mailbox driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mailbox/arm-smc-mailbox.h b/include/linux/mailbox/arm-smc-mailbox.h
new file mode 100644
index 000000000000..ca366fe491c3
--- /dev/null
+++ b/include/linux/mailbox/arm-smc-mailbox.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_ARM_SMC_MAILBOX_H_
+#define _LINUX_ARM_SMC_MAILBOX_H_
+
+struct arm_smccc_mbox_cmd {
+	unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
+};
+
+#endif /* _LINUX_ARM_SMC_MAILBOX_H_ */
-- 
2.16.4

