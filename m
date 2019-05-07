Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94AAC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EF620675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfEGShb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:37:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:41333 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfEGShS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:37:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 11:37:17 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2019 11:37:16 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 2/4] firmware: add Intel Stratix10 remote system update driver
Date:   Tue,  7 May 2019 13:46:37 -0500
Message-Id: <1557254799-7416-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557254799-7416-1-git-send-email-richard.gong@linux.intel.com>
References: <1557254799-7416-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

The Intel Remote System Update (RSU) driver exposes interfaces access
through the Intel Service Layer to user space via sysfs interface.
The RSU interfaces report and control some of the optional RSU features
on Intel Stratix 10 SoC.

The RSU feature provides a way for customers to update the boot
configuration of a Intel Stratix 10 SoC device with significantly reduced
risk of corrupting the bitstream storage and bricking the system.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Alan Tull <atull@kernel.org>
---
v2: s/SysFS/sysfs, s/scnprintf/sprintf,
    s/attr_group/ATTRIBUTE_GROUPS, use devm_device_add_groups() and
    devm_device_remove_groups()
    added check the return value from rsu_send_msg()
    removed a pr_info in stratix10_rsu_probe()
    removed compatible = "intel,stratix10-rsu"
---
 drivers/firmware/Kconfig         |  18 ++
 drivers/firmware/Makefile        |   1 +
 drivers/firmware/stratix10-rsu.c | 409 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 428 insertions(+)
 create mode 100644 drivers/firmware/stratix10-rsu.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 11fda9e..517a8d5 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -214,6 +214,24 @@ config INTEL_STRATIX10_SERVICE
 
 	  Say Y here if you want Stratix10 service layer support.
 
+config INTEL_STRATIX10_RSU
+        tristate "Intel Stratix10 Remote System Update"
+        depends on INTEL_STRATIX10_SERVICE
+        help
+          The Intel Remote System Update (RSU) driver exposes interfaces
+          access through the Intel Service Layer to user space via sysfs
+          device attribute nodes. The RSU interfaces report/control some of
+          the optional RSU features of the Stratix 10 SoC FPGA.
+
+          The RSU provides a way for customers to update the boot
+          configuration of a Stratix 10 SoC device with significantly reduced
+          risk of corrupting the bitstream storage and bricking the system.
+
+          Enable RSU support if you are using an Intel SoC FPGA with the RSU
+          feature enabled and you want Linux user space control.
+
+          Say Y here if you want Intel RSU support.
+
 config QCOM_SCM
 	bool
 	depends on ARM || ARM64
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 3fa0b34..d04d5fc 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_EDD)		+= edd.o
 obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
 obj-$(CONFIG_DMIID)		+= dmi-id.o
 obj-$(CONFIG_INTEL_STRATIX10_SERVICE) += stratix10-svc.o
+obj-$(CONFIG_INTEL_STRATIX10_RSU)     += stratix10-rsu.o
 obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
new file mode 100644
index 0000000..770605c
--- /dev/null
+++ b/drivers/firmware/stratix10-rsu.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019, Intel Corporation
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/intel/stratix10-svc-client.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+
+#define RSU_STATE_MASK			GENMASK_ULL(31, 0)
+#define RSU_VERSION_MASK                GENMASK_ULL(63, 32)
+#define RSU_ERROR_LOCATION_MASK         GENMASK_ULL(31, 0)
+#define RSU_ERROR_DETAIL_MASK		GENMASK_ULL(63, 32)
+
+#define RSU_TIMEOUT	(msecs_to_jiffies(SVC_RSU_REQUEST_TIMEOUT_MS))
+
+/**
+ * struct stratix10_rsu_priv - rsu data structure
+ * @chan: pointer to the allocated service channel
+ * @client: active service client
+ * @completion: state for callback completion
+ * @lock: a mutex to protect callback completion state
+ * @status.current_image: address of image currently running in flash
+ * @status.fail_image: address of failed image in flash
+ * @status.version: the version number of RSU firmware
+ * @status.state: the state of RSU system
+ * @status.error_details: error code
+ * @status.error_location: the error offset inside the image that failed
+ */
+struct stratix10_rsu_priv {
+	struct stratix10_svc_chan *chan;
+	struct stratix10_svc_client client;
+	struct completion completion;
+	struct mutex lock;
+	struct {
+		unsigned long current_image;
+		unsigned long fail_image;
+		unsigned int version;
+		unsigned int state;
+		unsigned int error_details;
+		unsigned int error_location;
+	} status;
+};
+
+/**
+ * rsu_status_callback() - Status callback from Intel service layer
+ * @client: pointer to service client
+ * @data: pointer to callback data structure
+ *
+ * Callback from Intel service layer for RSU status request. Status is
+ * only updated after a system reboot, so a get updated status call is
+ * made during driver probe.
+ */
+static void rsu_status_callback(struct stratix10_svc_client *client,
+				struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+	struct arm_smccc_res *res = (struct arm_smccc_res *)data->kaddr1;
+
+	if (data->status == BIT(SVC_STATUS_RSU_OK)) {
+		priv->status.version = FIELD_GET(RSU_VERSION_MASK,
+						 res->a2);
+		priv->status.state = FIELD_GET(RSU_STATE_MASK, res->a2);
+		priv->status.fail_image = res->a1;
+		priv->status.current_image = res->a0;
+		priv->status.error_location =
+			FIELD_GET(RSU_ERROR_LOCATION_MASK, res->a3);
+		priv->status.error_details =
+			FIELD_GET(RSU_ERROR_DETAIL_MASK, res->a3);
+	} else {
+		dev_err(client->dev, "COMMAND_RSU_STATUS returned 0x%lX\n",
+			res->a0);
+		priv->status.version = 0;
+		priv->status.state = 0;
+		priv->status.fail_image = 0;
+		priv->status.current_image = 0;
+		priv->status.error_location = 0;
+		priv->status.error_details = 0;
+	}
+
+	complete(&priv->completion);
+}
+
+/**
+ * rsu_command_callback() - Update callback from Intel service layer
+ * @client: pointer to client
+ * @data: pointer to callback data structure
+ *
+ * Callback from Intel service layer for RSU commands.
+ */
+static void rsu_command_callback(struct stratix10_svc_client *client,
+				 struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+
+	if (data->status != BIT(SVC_STATUS_RSU_OK))
+		dev_err(client->dev, "RSU returned status is %i\n",
+			data->status);
+	complete(&priv->completion);
+}
+
+/**
+ * rsu_send_msg() - send a message to Intel service layer
+ * @priv: pointer to rsu private data
+ * @command: RSU status or update command
+ * @arg: the request argument, the bitstream address or notify status
+ * @callback: function pointer for the callback (status or update)
+ *
+ * Start an Intel service layer transaction to perform the SMC call that
+ * is necessary to get RSU boot log or set the address of bitstream to
+ * boot after reboot.
+ *
+ * Returns 0 on success or -ETIMEDOUT on error.
+ */
+static int rsu_send_msg(struct stratix10_rsu_priv *priv,
+			enum stratix10_svc_command_code command,
+	unsigned long arg,
+	void (*callback)(struct stratix10_svc_client *client,
+			 struct stratix10_svc_cb_data *data))
+{
+	struct stratix10_svc_client_msg msg;
+	int ret;
+
+	mutex_lock(&priv->lock);
+	reinit_completion(&priv->completion);
+	priv->client.receive_cb = callback;
+
+	msg.command = command;
+	if (arg)
+		msg.arg[0] = arg;
+
+	ret = stratix10_svc_send(priv->chan, &msg);
+	if (ret < 0)
+		goto status_done;
+
+	ret = wait_for_completion_interruptible_timeout(&priv->completion,
+							RSU_TIMEOUT);
+	if (!ret) {
+		dev_err(priv->client.dev,
+			"timeout waiting for COMMAND_RSU_STATUS\n");
+		ret = -ETIMEDOUT;
+		goto status_done;
+	} else if (ret < 0) {
+		dev_err(priv->client.dev,
+			"error %d waiting for COMMAND_RSU_STATUS\n", ret);
+		goto status_done;
+	} else {
+		ret = 0;
+	}
+
+status_done:
+	stratix10_svc_done(priv->chan);
+	mutex_unlock(&priv->lock);
+	return ret;
+}
+
+/*
+ * This driver exposes some optional features of the Intel Stratix 10 SoC FPGA.
+ * The sysfs interfaces exposed here are FPGA Remote System Update (RSU)
+ * related.  They allow user space software to query the configuration system
+ * status and to request optional reboot behavior specific to Intel FPGAs.
+ */
+
+static ssize_t current_image_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "%ld", priv->status.current_image);
+}
+
+static ssize_t fail_image_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "%ld", priv->status.fail_image);
+}
+
+static ssize_t version_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "%d", priv->status.version);
+}
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "%d", priv->status.state);
+}
+
+static ssize_t error_location_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "%d", priv->status.error_location);
+}
+
+static ssize_t error_details_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "%d", priv->status.error_details);
+}
+
+static ssize_t reboot_image_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+	unsigned long address;
+	int ret;
+
+	if (priv == 0)
+		return -ENODEV;
+
+	ret = kstrtoul(buf, 0, &address);
+	if (ret)
+		return ret;
+
+	ret = rsu_send_msg(priv, COMMAND_RSU_UPDATE,
+			   address, rsu_command_callback);
+	if (ret) {
+		dev_err(dev, "Error, RSU update returned %i\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t notify_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+	unsigned long status;
+	int ret;
+
+	if (priv == 0)
+		return -ENODEV;
+
+	ret = kstrtoul(buf, 0, &status);
+	if (ret)
+		return ret;
+
+	ret = rsu_send_msg(priv, COMMAND_RSU_NOTIFY,
+			   status, rsu_command_callback);
+	if (ret) {
+		dev_err(dev, "Error, RSU notify returned %i\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t watchdog_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+	unsigned long wd_action;
+	int ret;
+
+	if (priv == 0)
+		return -ENODEV;
+
+	ret = kstrtoul(buf, 0, &wd_action);
+	if (ret)
+		return ret;
+
+	ret = rsu_send_msg(priv, COMMAND_RSU_WD,
+			   wd_action, rsu_command_callback);
+	if (ret) {
+		dev_err(dev, "Error, WD timer expiration returned %i\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(current_image);
+static DEVICE_ATTR_RO(fail_image);
+static DEVICE_ATTR_RO(state);
+static DEVICE_ATTR_RO(version);
+static DEVICE_ATTR_RO(error_location);
+static DEVICE_ATTR_RO(error_details);
+static DEVICE_ATTR_WO(reboot_image);
+static DEVICE_ATTR_WO(notify);
+static DEVICE_ATTR_WO(watchdog);
+
+static struct attribute *rsu_attrs[] = {
+	&dev_attr_current_image.attr,
+	&dev_attr_fail_image.attr,
+	&dev_attr_state.attr,
+	&dev_attr_version.attr,
+	&dev_attr_error_location.attr,
+	&dev_attr_error_details.attr,
+	&dev_attr_reboot_image.attr,
+	&dev_attr_notify.attr,
+	&dev_attr_watchdog.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(rsu);
+
+static int stratix10_rsu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stratix10_rsu_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client.dev = dev;
+	priv->client.receive_cb = NULL;
+	priv->client.priv = priv;
+	priv->status.current_image = 0;
+	priv->status.fail_image = 0;
+	priv->status.error_location = 0;
+	priv->status.error_details = 0;
+	priv->status.version = 0;
+	priv->status.state = 0;
+
+	mutex_init(&priv->lock);
+	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
+							  SVC_CLIENT_RSU);
+	if (IS_ERR(priv->chan)) {
+		dev_err(dev, "couldn't get service channel %s\n",
+			SVC_CLIENT_RSU);
+		return PTR_ERR(priv->chan);
+	}
+
+	init_completion(&priv->completion);
+	platform_set_drvdata(pdev, priv);
+
+	/* status is only updated after reboot */
+	ret = rsu_send_msg(priv, COMMAND_RSU_STATUS,
+			   0, rsu_status_callback);
+	if (ret) {
+		dev_err(dev, "Error, getting RSU status %i\n", ret);
+		stratix10_svc_free_channel(priv->chan);
+	}
+
+	ret = devm_device_add_groups(dev, rsu_groups);
+	if (ret) {
+		dev_err(dev, "unable to create sysfs group");
+		stratix10_svc_free_channel(priv->chan);
+	}
+
+	return ret;
+}
+
+static int stratix10_rsu_remove(struct platform_device *pdev)
+{
+	struct stratix10_rsu_priv *priv = platform_get_drvdata(pdev);
+
+	stratix10_svc_free_channel(priv->chan);
+	devm_device_remove_groups(&pdev->dev, rsu_groups);
+	return 0;
+}
+
+static struct platform_driver stratix10_rsu_driver = {
+	.probe = stratix10_rsu_probe,
+	.remove = stratix10_rsu_remove,
+	.driver = {
+		.name = "stratix10-rsu",
+	},
+};
+
+module_platform_driver(stratix10_rsu_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Remote System Update Driver");
+MODULE_AUTHOR("Richard Gong <richard.gong@intel.com>");
-- 
2.7.4

