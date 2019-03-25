Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3EA20835
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfCYDYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:24:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:19159 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbfCYDYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:24:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 20:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="310109723"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2019 20:24:09 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 11/17] fpga: dfl: afu: add error reporting support.
Date:   Mon, 25 Mar 2019 11:07:38 +0800
Message-Id: <1553483264-5379-12-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error reporting is one important private feature, it reports error
detected on port and accelerated function unit (AFU). It introduces
several sysfs interfaces to allow userspace to check and clear
errors detected by hardware.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  29 +++
 drivers/fpga/Makefile                             |   1 +
 drivers/fpga/dfl-afu-error.c                      | 225 ++++++++++++++++++++++
 drivers/fpga/dfl-afu-main.c                       |   4 +
 drivers/fpga/dfl-afu.h                            |   4 +
 5 files changed, 263 insertions(+)
 create mode 100644 drivers/fpga/dfl-afu-error.c

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index f611e47..e6140aa 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -79,3 +79,32 @@ KernelVersion:	5.2
 Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. Read this file to get the status of issued command
 		to userclck_freqcntrcmd.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/errors
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get errors detected on port and
+		Accelerated Function Unit (AFU).
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/first_error
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first error detected by
+		hardware.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/first_malformed_req
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the first malformed request
+		captured by hardware.
+
+What:		/sys/bus/platform/devices/dfl-port.0/errors/clear
+Date:		March 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. Write error code to this file to clear errors. If
+		the input error code doesn't match, it returns -EBUSY error
+		code.
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index c0dd4c8..f1f0af7 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
+dfl-afu-objs += dfl-afu-error.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
new file mode 100644
index 0000000..b66bd4a
--- /dev/null
+++ b/drivers/fpga/dfl-afu-error.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Accelerated Function Unit (AFU) Error Reporting
+ *
+ * Copyright 2019 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@linux.intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Mitchel Henry <henry.mitchel@intel.com>
+ */
+
+#include <linux/uaccess.h>
+
+#include "dfl-afu.h"
+
+#define PORT_ERROR_MASK		0x8
+#define PORT_ERROR		0x10
+#define PORT_FIRST_ERROR	0x18
+#define PORT_MALFORMED_REQ0	0x20
+#define PORT_MALFORMED_REQ1	0x28
+
+#define ERROR_MASK		GENMASK_ULL(63, 0)
+
+/* mask or unmask port errors by the error mask register. */
+static void __port_err_mask(struct device *dev, bool mask)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
+}
+
+/* clear port errors. */
+static int __port_err_clear(struct device *dev, u64 err)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	void __iomem *base_err, *base_hdr;
+	int ret;
+	u64 v;
+
+	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	/*
+	 * clear Port Errors
+	 *
+	 * - Check for AP6 State
+	 * - Halt Port by keeping Port in reset
+	 * - Set PORT Error mask to all 1 to mask errors
+	 * - Clear all errors
+	 * - Set Port mask to all 0 to enable errors
+	 * - All errors start capturing new errors
+	 * - Enable Port by pulling the port out of reset
+	 */
+
+	/* if device is still in AP6 power state, can not clear any error. */
+	v = readq(base_hdr + PORT_HDR_STS);
+	if (FIELD_GET(PORT_STS_PWR_STATE, v) == PORT_STS_PWR_STATE_AP6) {
+		dev_err(dev, "Could not clear errors, device in AP6 state.\n");
+		return -EBUSY;
+	}
+
+	/* Halt Port by keeping Port in reset */
+	ret = __port_disable(pdev);
+	if (ret)
+		return ret;
+
+	/* Mask all errors */
+	__port_err_mask(dev, true);
+
+	/* Clear errors if err input matches with current port errors.*/
+	v = readq(base_err + PORT_ERROR);
+
+	if (v == err) {
+		writeq(v, base_err + PORT_ERROR);
+
+		v = readq(base_err + PORT_FIRST_ERROR);
+		writeq(v, base_err + PORT_FIRST_ERROR);
+	} else {
+		ret = -EBUSY;
+	}
+
+	/* Clear mask */
+	__port_err_mask(dev, false);
+
+	/* Enable the Port by clear the reset */
+	__port_enable(pdev);
+
+	return ret;
+}
+
+static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dfl_feature_revision(base));
+}
+static DEVICE_ATTR_RO(revision);
+
+static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 error;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	error = readq(base + PORT_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)error);
+}
+static DEVICE_ATTR_RO(errors);
+
+static ssize_t first_error_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 error;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	error = readq(base + PORT_FIRST_ERROR);
+	mutex_unlock(&pdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)error);
+}
+static DEVICE_ATTR_RO(first_error);
+
+static ssize_t first_malformed_req_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 req0, req1;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
+
+	mutex_lock(&pdata->lock);
+	req0 = readq(base + PORT_MALFORMED_REQ0);
+	req1 = readq(base + PORT_MALFORMED_REQ1);
+	mutex_unlock(&pdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%016llx%016llx\n",
+			 (unsigned long long)req1, (unsigned long long)req0);
+}
+static DEVICE_ATTR_RO(first_malformed_req);
+
+static ssize_t clear_store(struct device *dev, struct device_attribute *attr,
+			   const char *buff, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	u64 value;
+	int ret;
+
+	if (kstrtou64(buff, 0, &value))
+		return -EINVAL;
+
+	mutex_lock(&pdata->lock);
+	ret = __port_err_clear(dev, value);
+	mutex_unlock(&pdata->lock);
+
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(clear);
+
+static struct attribute *port_err_attrs[] = {
+	&dev_attr_revision.attr,
+	&dev_attr_errors.attr,
+	&dev_attr_first_error.attr,
+	&dev_attr_first_malformed_req.attr,
+	&dev_attr_clear.attr,
+	NULL,
+};
+
+static struct attribute_group port_err_attr_group = {
+	.attrs = port_err_attrs,
+	.name = "errors",
+};
+
+static int port_err_init(struct platform_device *pdev,
+			 struct dfl_feature *feature)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	dev_dbg(&pdev->dev, "PORT ERR Init.\n");
+
+	mutex_lock(&pdata->lock);
+	__port_err_mask(&pdev->dev, false);
+	mutex_unlock(&pdata->lock);
+
+	return sysfs_create_group(&pdev->dev.kobj, &port_err_attr_group);
+}
+
+static void port_err_uinit(struct platform_device *pdev,
+			   struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT ERR UInit.\n");
+
+	sysfs_remove_group(&pdev->dev.kobj, &port_err_attr_group);
+}
+
+const struct dfl_feature_id port_err_id_table[] = {
+	{.id = PORT_FEATURE_ID_ERROR,},
+	{0,}
+};
+
+const struct dfl_feature_ops port_err_ops = {
+	.init = port_err_init,
+	.uinit = port_err_uinit,
+};
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index e727d9b..754729e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -528,6 +528,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
 		.ops = &port_afu_ops,
 	},
 	{
+		.id_table = port_err_id_table,
+		.ops = &port_err_ops,
+	},
+	{
 		.ops = NULL,
 	}
 };
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 35e60c5..c3182a2 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -100,4 +100,8 @@ int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova);
 struct dfl_afu_dma_region *
 afu_dma_region_find(struct dfl_feature_platform_data *pdata,
 		    u64 iova, u64 size);
+
+extern const struct dfl_feature_ops port_err_ops;
+extern const struct dfl_feature_id port_err_id_table[];
+
 #endif /* __DFL_AFU_H */
-- 
2.7.4

