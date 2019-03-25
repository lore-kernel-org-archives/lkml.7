Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17010C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00AD20835
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfCYDYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:24:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:19159 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfCYDYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:24:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 20:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="310109754"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2019 20:24:18 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 15/17] fpga: dfl: fme: add power management support
Date:   Mon, 25 Mar 2019 11:07:42 +0800
Message-Id: <1553483264-5379-16-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for power management private feature under
FPGA Management Engine (FME), sysfs interfaces are introduced for
different power management functions, users could use these sysfs
interface to get current number of consumed power, throttling
thresholds, threshold status and other information, and configure
different value for throttling thresholds too.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme |  56 +++++
 drivers/fpga/dfl-fme-main.c                      | 257 +++++++++++++++++++++++
 2 files changed, 313 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index d3aeb88..4b6448f 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -100,3 +100,59 @@ Description:	Read-only. Read this file to get the policy of temperature
 		threshold1. It only supports two value (policy):
 		    0 - AP2 state (90% throttling)
 		    1 - AP1 state (50% throttling)
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/consumed
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns current power consumed by FPGA.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold1
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read/Write this file to get/set current power
+		threshold1 in Watts.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold2
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read/Write this file to get/set current power
+		threshold2 in Watts.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold1_status
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns 1 if power consumption reaches the
+		threshold1, otherwise 0.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/threshold2_status
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns 1 if power consumption reaches the
+		threshold2, otherwise 0.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/ltr
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get current Latency Tolerance
+		Reporting (ltr) value, it's only valid for integrated
+		solution as it blocks CPU on low power state.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/xeon_limit
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get power limit for xeon, it
+		is only valid for integrated solution.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/power_mgmt/fpga_limit
+Date:		March 2019
+KernelVersion:  5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get power limit for fpga, it
+		is only valid for integrated solution.
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 449a17d..dafa6580 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -415,6 +415,259 @@ static const struct dfl_feature_ops fme_thermal_mgmt_ops = {
 	.uinit = fme_thermal_mgmt_uinit,
 };
 
+#define FME_PWR_STATUS		0x8
+#define FME_LATENCY_TOLERANCE	BIT_ULL(18)
+#define PWR_CONSUMED		GENMASK_ULL(17, 0)
+
+#define FME_PWR_THRESHOLD	0x10
+#define PWR_THRESHOLD1		GENMASK_ULL(6, 0)	/* in Watts */
+#define PWR_THRESHOLD2		GENMASK_ULL(14, 8)	/* in Watts */
+#define PWR_THRESHOLD_MAX	0x7f
+#define PWR_THRESHOLD1_STATUS	BIT_ULL(16)
+#define PWR_THRESHOLD2_STATUS	BIT_ULL(17)
+
+#define FME_PWR_XEON_LIMIT	0x18
+#define XEON_PWR_LIMIT		GENMASK_ULL(14, 0)
+#define XEON_PWR_EN		BIT_ULL(15)
+#define FME_PWR_FPGA_LIMIT	0x20
+#define FPGA_PWR_LIMIT		GENMASK_ULL(14, 0)
+#define FPGA_PWR_EN		BIT_ULL(15)
+
+#define POWER_ATTR(_name, _mode, _show, _store)	\
+struct device_attribute power_attr_##_name =		\
+	__ATTR(_name, _mode, _show, _store)
+
+#define POWER_ATTR_RO(_name, _show)			\
+	POWER_ATTR(_name, 0444, _show, NULL)
+
+#define POWER_ATTR_RW(_name, _show, _store)		\
+	POWER_ATTR(_name, 0644, _show, _store)
+
+static ssize_t pwr_consumed_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_STATUS);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(PWR_CONSUMED, v));
+}
+static POWER_ATTR_RO(consumed, pwr_consumed_show);
+
+static ssize_t pwr_threshold1_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_THRESHOLD);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(PWR_THRESHOLD1, v));
+}
+
+static ssize_t pwr_threshold1_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 threshold;
+	int ret;
+	u64 v;
+
+	ret = kstrtou8(buf, 0, &threshold);
+	if (ret)
+		return ret;
+
+	if (threshold > PWR_THRESHOLD_MAX)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + FME_PWR_THRESHOLD);
+	v &= ~PWR_THRESHOLD1;
+	v |= FIELD_PREP(PWR_THRESHOLD1, threshold);
+	writeq(v, base + FME_PWR_THRESHOLD);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static POWER_ATTR_RW(threshold1, pwr_threshold1_show, pwr_threshold1_store);
+
+static ssize_t pwr_threshold2_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_THRESHOLD);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(PWR_THRESHOLD2, v));
+}
+
+static ssize_t pwr_threshold2_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 threshold;
+	int ret;
+	u64 v;
+
+	ret = kstrtou8(buf, 0, &threshold);
+	if (ret)
+		return ret;
+
+	if (threshold > PWR_THRESHOLD_MAX)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + FME_PWR_THRESHOLD);
+	v &= ~PWR_THRESHOLD2;
+	v |= FIELD_PREP(PWR_THRESHOLD2, threshold);
+	writeq(v, base + FME_PWR_THRESHOLD);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static POWER_ATTR_RW(threshold2, pwr_threshold2_show, pwr_threshold2_store);
+
+static ssize_t pwr_threshold1_status_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_THRESHOLD);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(PWR_THRESHOLD1_STATUS, v));
+}
+static POWER_ATTR_RO(threshold1_status, pwr_threshold1_status_show);
+
+static ssize_t pwr_threshold2_status_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_THRESHOLD);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(PWR_THRESHOLD2_STATUS, v));
+}
+static POWER_ATTR_RO(threshold2_status, pwr_threshold2_status_show);
+
+static ssize_t ltr_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_STATUS);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(FME_LATENCY_TOLERANCE, v));
+}
+static POWER_ATTR_RO(ltr, ltr_show);
+
+static ssize_t xeon_limit_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u16 xeon_limit = 0;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_XEON_LIMIT);
+
+	if (FIELD_GET(XEON_PWR_EN, v))
+		xeon_limit = FIELD_GET(XEON_PWR_LIMIT, v);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", xeon_limit);
+}
+static POWER_ATTR_RO(xeon_limit, xeon_limit_show);
+
+static ssize_t fpga_limit_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u16 fpga_limit = 0;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_POWER_MGMT);
+
+	v = readq(base + FME_PWR_FPGA_LIMIT);
+
+	if (FIELD_GET(FPGA_PWR_EN, v))
+		fpga_limit = FIELD_GET(FPGA_PWR_LIMIT, v);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", fpga_limit);
+}
+static POWER_ATTR_RO(fpga_limit, fpga_limit_show);
+
+static struct attribute *power_mgmt_attrs[] = {
+	&power_attr_consumed.attr,
+	&power_attr_threshold1.attr,
+	&power_attr_threshold2.attr,
+	&power_attr_threshold1_status.attr,
+	&power_attr_threshold2_status.attr,
+	&power_attr_xeon_limit.attr,
+	&power_attr_fpga_limit.attr,
+	&power_attr_ltr.attr,
+	NULL,
+};
+
+static struct attribute_group power_mgmt_attr_group = {
+	.attrs	= power_mgmt_attrs,
+	.name	= "power_mgmt",
+};
+
+static int fme_power_mgmt_init(struct platform_device *pdev,
+			       struct dfl_feature *feature)
+{
+	return sysfs_create_group(&pdev->dev.kobj, &power_mgmt_attr_group);
+}
+
+static void fme_power_mgmt_uinit(struct platform_device *pdev,
+				 struct dfl_feature *feature)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &power_mgmt_attr_group);
+}
+
+static const struct dfl_feature_id fme_power_mgmt_id_table[] = {
+	{.id = FME_FEATURE_ID_POWER_MGMT,},
+	{0,}
+};
+
+static const struct dfl_feature_ops fme_power_mgmt_ops = {
+	.init = fme_power_mgmt_init,
+	.uinit = fme_power_mgmt_uinit,
+};
+
 static struct dfl_feature_driver fme_feature_drvs[] = {
 	{
 		.id_table = fme_hdr_id_table,
@@ -429,6 +682,10 @@ static struct dfl_feature_driver fme_feature_drvs[] = {
 		.ops = &fme_thermal_mgmt_ops,
 	},
 	{
+		.id_table = fme_power_mgmt_id_table,
+		.ops = &fme_power_mgmt_ops,
+	},
+	{
 		.ops = NULL,
 	},
 };
-- 
2.7.4

