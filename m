Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3157AC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98F72146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391995AbfIZF3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:29:34 -0400
Received: from mail-eopbgr760078.outbound.protection.outlook.com ([40.107.76.78]:9779
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392201AbfIZF3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:29:33 -0400
Received: from MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31)
 by BL0PR02MB4882.namprd02.prod.outlook.com (2603:10b6:208:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Thu, 26 Sep
 2019 05:25:42 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MN2PR02CA0018.outlook.office365.com
 (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21 via Frontend
 Transport; Thu, 26 Sep 2019 05:25:42 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 05:25:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFO-00067z-2l; Wed, 25 Sep 2019 22:23:22 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFI-00018r-V3; Wed, 25 Sep 2019 22:23:17 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8Q5NGnt023252;
        Wed, 25 Sep 2019 22:23:16 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFH-00018B-Nv; Wed, 25 Sep 2019 22:23:16 -0700
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCHv3 2/3] misc: xilinx_flex: Add support for the flex noc Performance Monitor
Date:   Thu, 26 Sep 2019 10:53:08 +0530
Message-Id:
 <a0a95c8b9dfc78a2eb97737b90322cc29332c1b0.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--15.755-7.0-31-1
X-imss-scan-details: No--15.755-7.0-31-1;No--15.755-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132139491422503463;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39850400004)(376002)(346002)(396003)(199004)(189003)(51416003)(5660300002)(476003)(11346002)(486006)(8676002)(30864003)(305945005)(6666004)(14444005)(73392003)(107886003)(336012)(9786002)(426003)(81166006)(126002)(50226002)(6916009)(47776003)(81156014)(70206006)(450100002)(86362001)(70586007)(316002)(2906002)(8936002)(4326008)(118296001)(16586007)(356004)(9686003)(26005)(2361001)(76482006)(76176011)(2351001)(446003)(48376002)(82202003)(50466002)(498600001)(7696005)(36756003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4882;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ca48457-fcc7-4c64-f58f-08d74241f972
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600167)(711020)(4605104)(1401327)(2017052603328);SRVR:BL0PR02MB4882;
X-MS-TrafficTypeDiagnostic: BL0PR02MB4882:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4882D31A8C52578202787B5887860@BL0PR02MB4882.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 0172F0EF77
X-Microsoft-Antispam-Message-Info: hcDzGsczzGbp7D5+f/i59LB7/3on9pu3aYVG9pAZSE6gAmxvRxZHf1YNszj3auFC71EIYpgQ5ejH4c+2cSVJN62KpOJ30c3qChmS3hf6Lm+/kWeABp6RcoZCouCdfsvKsUHipPImxDm7IauTibGBX4j/WLdVVCVIhvpITlUpcd+r0gZ1AUvy1B2YQbfCF0Y0oRSvQ7X/U7NKh+o+8Zycydg5nAnPqWICY9xKfHBv2Erf26shgB+50+Ey9IBzUr2UD0GyHzjmdfqD8TSU1jkKYRDHRHegv8V07JbucfJX/n9TRpRxH8aAuO/TeF91p4WDiV2q2HmG2tt1bO28KUQSo54f09DMLBP/1Z+aZ542g61lOKKy728WLXIcCv7aO7lgiwaX1x4aopHgVNuJv0kmROFalfcTIHfOps1P8okG7jc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 05:25:41.8681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca48457-fcc7-4c64-f58f-08d74241f972
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190926052308.1O1Y1M0DxmOHw9P885cjm-Bm5YFD6HtEMXUEgrNnZwY@z>

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add support for the FlexNoc Performance Monitor.
Adds support for various port setting and monitoring
the packets transactions. It supports LPD and FPD monitoring
counters for read and write transaction requests and responses.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Add a mutex to prevent race

---
 drivers/misc/Kconfig          |   9 +
 drivers/misc/Makefile         |   1 +
 drivers/misc/xilinx_flex_pm.c | 653 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 663 insertions(+)
 create mode 100644 drivers/misc/xilinx_flex_pm.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c55b637..1e9a6fa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -454,6 +454,15 @@ config XILINX_SDFEC
 
 	  If unsure, say N.
 
+config XILINX_FLEX_PM
+	tristate "Xilinx Flexnoc Performance Monitor"
+	help
+	  This option enables support for the Xilinx Flex Noc Performance Monitor driver.
+	  It monitors the read and write transactions. It has counters for the LPD and
+	  FPD domains.
+
+	  If unsure, say N
+
 config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c1860d3..1f1c34d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_XILINX_FLEX_PM)	+= xilinx_flex_pm.o
diff --git a/drivers/misc/xilinx_flex_pm.c b/drivers/misc/xilinx_flex_pm.c
new file mode 100644
index 0000000..e7684d1
--- /dev/null
+++ b/drivers/misc/xilinx_flex_pm.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Flex Noc Performance Monitor driver.
+ * Copyright (c) 2019 Xilinx Inc.
+ */
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define to_xflex_dev_info(n)	((struct xflex_dev_info *)dev_get_drvdata(n))
+
+#define FPM_LAR_OFFSET			0xFB0
+#define FPM_UNLOCK			0xC5ACCE55
+
+#define FPM_RD_REQ_OFFSET		0x1000
+#define FPM_RD_RES_OFFSET		0x2000
+#define FPM_WR_REQ_OFFSET		0x3000
+#define FPM_WR_RES_OFFSET		0x4000
+
+#define FPM_PORT_SEL_OFFSET		0x134
+#define FPM_MAIN_CTRL_OFFSET		0x008
+#define FPM_SRC_SEL_OFFSET		0x138
+#define FPM_STATPERIOD			0x24
+#define FPM_CFGCTRL			0x0C
+#define FPM_LPD				0x4210002
+#define FPM_FPD				0x420c003
+
+#define FPM_VAL				0x300
+#define FPM_SRC				0x200
+#define FPM_WRRSP_L			0x70000
+#define FPM_WRREQ_L			0x60000
+#define FPM_RDRSP_L			0x50000
+#define FPM_RDREQ_L			0x40000
+#define FPM_PROBE_SHIFT			16
+#define FPM_COUNTER_OFFSET		0x14
+#define FPM_GLOBALEN			BIT(0)
+#define FPM_STATEN			BIT(3)
+#define FPM_STATCOND_DUMP		BIT(5)
+#define FPM_NUM_COUNTERS		4
+#define FPM_MAINCTL_DIS			0
+
+#define FPM_SRC_OFF			0x0
+#define FPM_SRC_CYCLE			0x1
+#define FPM_SRC_IDLE			0x2
+#define FPM_SRC_XFER			0x3
+#define FPM_SRC_BUSY			0x4
+#define FPM_SRC_WAIT			0x5
+#define FPM_SRC_PACKET			0x6
+
+/* Port values */
+#define FPM_PORT_LPD_AFIFS_AXI		0x0
+#define FPM_PORT_LPD_OCM		0x1
+#define FPM_PORT_LPD_OCMEXT		0x2
+#define FPM_PORT_PMC_RPU_AXI0		0x3
+
+#define FPM_PORT_FPDAXI			0x1
+#define FPM_PORT_PROTXPPU		0x2
+
+/**
+ * struct xflex_dev_info - Global Driver structure
+ * @dev: Device structure
+ * @baselpd: Iomapped LPD base address
+ * @basefpd: Iomapped FPD base address
+ * @funnel: Iomapped funnel register base address
+ * @counterid_lpd: LPD counter id
+ * @counterid_fpd: FPD counter id
+ */
+struct xflex_dev_info {
+	struct device *dev;
+	void __iomem *baselpd;
+	void __iomem *basefpd;
+	void __iomem *funnel;
+	u32 counterid_fpd;
+	u32 counterid_lpd;
+	struct mutex mutex; /* avoid parallel access to device */
+};
+
+/**
+ * enum xflex_sysfs_cmd_codes - sysfs command codes
+ * @XFLEX_GET_COUNTER_FPD: get the FPD counter value
+ * @XFLEX_SET_COUNTER_FPD: set the FPD counter value
+ * @XFLEX_GET_COUNTER_FPD_RDREQ: get the FPD read request count
+ * @XFLEX_GET_COUNTER_FPD_RDRSP: get the FPD read response count
+ * @XFLEX_GET_COUNTER_FPD_WRREQ: get the FPD write request count
+ * @XFLEX_GET_COUNTER_FPD_WRRSP: get the FPD write response count
+ * @XFLEX_GET_COUNTER_LPD_RDREQ: get the LPD read request count
+ * @XFLEX_GET_COUNTER_LPD_RDRSP: get the LPD read response count
+ * @XFLEX_GET_COUNTER_LPD_WRREQ: get the LPD write request count
+ * @XFLEX_GET_COUNTER_LPD_WRRSP: get the LPD write response count
+ * @XFLEX_SET_COUNTER_LPD: set the LPD counter value
+ * @XFLEX_SET_SRC_COUNTER_LPD: set the LPD source
+ * @XFLEX_SET_SRC_COUNTER_FPD: set the FPD source
+ * @XFLEX_SET_PORT_COUNTER_LPD: set the LPD port
+ * @XFLEX_SET_PORT_COUNTER_FPD: set the FPD port
+ */
+enum xflex_sysfs_cmd_codes {
+	XFLEX_GET_COUNTER_FPD = 0,
+	XFLEX_SET_COUNTER_FPD,
+	XFLEX_GET_COUNTER_FPD_RDREQ,
+	XFLEX_GET_COUNTER_FPD_RDRSP,
+	XFLEX_GET_COUNTER_FPD_WRREQ,
+	XFLEX_GET_COUNTER_FPD_WRRSP,
+	XFLEX_GET_COUNTER_LPD_RDREQ,
+	XFLEX_GET_COUNTER_LPD_RDRSP,
+	XFLEX_GET_COUNTER_LPD_WRREQ,
+	XFLEX_GET_COUNTER_LPD_WRRSP,
+	XFLEX_SET_COUNTER_LPD,
+	XFLEX_SET_SRC_COUNTER_LPD,
+	XFLEX_SET_SRC_COUNTER_FPD,
+	XFLEX_SET_PORT_COUNTER_LPD,
+	XFLEX_SET_PORT_COUNTER_FPD,
+};
+
+static inline void fpm_reg(void __iomem *base, u32 val, u32 offset)
+{
+	writel(val, base + FPM_RD_REQ_OFFSET + offset);
+	writel(val, base + FPM_RD_RES_OFFSET + offset);
+	writel(val, base + FPM_WR_REQ_OFFSET + offset);
+	writel(val, base + FPM_WR_RES_OFFSET + offset);
+}
+
+static void reset_default(struct device *dev, u32 counter, u32 domain)
+{
+	struct xflex_dev_info *flexpm = to_xflex_dev_info(dev);
+	void __iomem *base = flexpm->basefpd;
+	u32 offset;
+
+	if (domain == FPM_LPD)
+		base = flexpm->baselpd;
+
+	fpm_reg(base, FPM_MAINCTL_DIS, FPM_MAIN_CTRL_OFFSET);
+	fpm_reg(base, FPM_STATEN | FPM_STATCOND_DUMP, FPM_MAIN_CTRL_OFFSET);
+	fpm_reg(base, FPM_STATEN | FPM_STATCOND_DUMP, FPM_MAIN_CTRL_OFFSET);
+
+	offset = FPM_PORT_SEL_OFFSET + counter * FPM_COUNTER_OFFSET;
+	fpm_reg(base, FPM_PORT_LPD_OCM, offset);
+	offset = FPM_SRC_SEL_OFFSET + counter * FPM_COUNTER_OFFSET;
+	fpm_reg(base, FPM_SRC_PACKET, offset);
+
+	fpm_reg(base, 0, FPM_STATPERIOD);
+	fpm_reg(base, FPM_GLOBALEN, FPM_CFGCTRL);
+}
+
+/**
+ * xflex_sysfs_cmd - Implements sysfs operations
+ * @dev: Device structure
+ * @buf: Value to write
+ * @cmd: sysfs cmd
+ *
+ * Return: value read from the sysfs cmd on success and negative error code
+ *		otherwise.
+ */
+static int xflex_sysfs_cmd(struct device *dev, const char *buf,
+			   enum xflex_sysfs_cmd_codes cmd)
+{
+	struct xflex_dev_info *flexpm = to_xflex_dev_info(dev);
+	u32 domain, src, offset, reg, val, counter;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 rdval = 0;
+	u32 pm_api_ret[4] = {0, 0, 0, 0};
+
+	if (IS_ERR_OR_NULL(eemi_ops))
+		return PTR_ERR(eemi_ops);
+
+	if (!eemi_ops->ioctl)
+		return -ENOTSUPP;
+
+	switch (cmd) {
+	case XFLEX_GET_COUNTER_LPD_WRRSP:
+		reg = flexpm->counterid_lpd | FPM_WRRSP_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	case XFLEX_GET_COUNTER_LPD_WRREQ:
+		reg = flexpm->counterid_lpd | FPM_WRREQ_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	case XFLEX_GET_COUNTER_LPD_RDRSP:
+		reg = flexpm->counterid_lpd | FPM_RDRSP_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	case XFLEX_GET_COUNTER_LPD_RDREQ:
+		reg = flexpm->counterid_lpd | FPM_RDREQ_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_LPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	case XFLEX_SET_COUNTER_LPD:
+		ret = kstrtou32(buf, 0, &val);
+		if (ret < 0)
+			goto exit_unlock;
+
+		flexpm->counterid_lpd = val;
+		reset_default(dev, val, FPM_LPD);
+		break;
+
+	case XFLEX_SET_PORT_COUNTER_FPD:
+		ret = kstrtou32(buf, 0, &val);
+		if (ret < 0)
+			goto exit_unlock;
+
+		counter = flexpm->counterid_fpd * FPM_COUNTER_OFFSET;
+		offset = FPM_PORT_SEL_OFFSET + counter * FPM_COUNTER_OFFSET;
+		fpm_reg(flexpm->basefpd, val, offset);
+		break;
+
+	case XFLEX_SET_PORT_COUNTER_LPD:
+		ret = kstrtou32(buf, 0, &val);
+		if (ret < 0)
+			goto exit_unlock;
+
+		counter = flexpm->counterid_lpd * FPM_COUNTER_OFFSET;
+		offset = FPM_PORT_SEL_OFFSET + counter * FPM_COUNTER_OFFSET;
+		fpm_reg(flexpm->baselpd, val, offset);
+		break;
+
+	case XFLEX_SET_SRC_COUNTER_LPD:
+		reg = flexpm->counterid_lpd;
+		domain = FPM_LPD;
+		ret = kstrtou32(buf, 0, &val);
+		if (ret < 0)
+			goto exit_unlock;
+
+		for (src = 0; src < FPM_NUM_COUNTERS; src++) {
+			reg = reg | FPM_SRC | (src << FPM_PROBE_SHIFT);
+			ret = eemi_ops->ioctl(domain, IOCTL_PROBE_COUNTER_WRITE,
+					      reg, val, NULL);
+			if (ret < 0) {
+				dev_err(dev, "Counter write error %d\n", ret);
+				goto exit_unlock;
+			}
+		}
+		break;
+
+	case XFLEX_SET_SRC_COUNTER_FPD:
+		reg = flexpm->counterid_fpd;
+		domain = FPM_FPD;
+		ret = kstrtou32(buf, 0, &val);
+		if (ret < 0)
+			goto exit_unlock;
+
+		for (src = 0; src < FPM_NUM_COUNTERS; src++) {
+			reg = reg | FPM_SRC | (src << FPM_PROBE_SHIFT);
+			ret = eemi_ops->ioctl(domain, IOCTL_PROBE_COUNTER_WRITE,
+					      reg, val, NULL);
+			if (ret < 0) {
+				dev_err(dev, "Counter write error %d\n", ret);
+				goto exit_unlock;
+			}
+		}
+		break;
+
+	case XFLEX_SET_COUNTER_FPD:
+		ret = kstrtou32(buf, 0, &val);
+		if (ret < 0)
+			goto exit_unlock;
+
+		flexpm->counterid_fpd = val;
+		reset_default(dev, val, FPM_FPD);
+		break;
+
+	case XFLEX_GET_COUNTER_FPD_WRRSP:
+		reg = flexpm->counterid_fpd | FPM_WRRSP_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	case XFLEX_GET_COUNTER_FPD_WRREQ:
+		reg = flexpm->counterid_fpd | FPM_WRREQ_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	case XFLEX_GET_COUNTER_FPD_RDRSP:
+		reg = flexpm->counterid_fpd | FPM_RDRSP_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	case XFLEX_GET_COUNTER_FPD_RDREQ:
+		reg = flexpm->counterid_fpd | FPM_RDREQ_L | FPM_VAL;
+		ret = eemi_ops->ioctl(FPM_FPD, IOCTL_PROBE_COUNTER_READ,
+				      reg, 0, &pm_api_ret[0]);
+		if (ret < 0) {
+			dev_err(dev, "Counter read error %d\n", ret);
+			goto exit_unlock;
+		}
+
+		rdval = pm_api_ret[1];
+		break;
+
+	default:
+		dev_err(dev, "Invalid option\n");
+		break;
+	}
+
+	return rdval;
+
+exit_unlock:
+	mutex_unlock(&flexpm->lock);
+	return ret;
+}
+
+/* Sysfs functions */
+
+static ssize_t counterfpd_wrreq_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_WRREQ);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_wrreq);
+
+static ssize_t counterfpd_wrrsp_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_WRRSP);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_wrrsp);
+
+static ssize_t counterfpd_rdreq_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_RDREQ);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_rdreq);
+
+static ssize_t counterfpd_rdrsp_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_FPD_RDRSP);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterfpd_rdrsp);
+
+static ssize_t counterlpd_wrreq_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_WRREQ);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_wrreq);
+
+static ssize_t counterlpd_wrrsp_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_WRRSP);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_wrrsp);
+
+static ssize_t counterlpd_rdreq_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_RDREQ);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_rdreq);
+
+static ssize_t counterlpd_rdrsp_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int rdval = xflex_sysfs_cmd(dev, buf, XFLEX_GET_COUNTER_LPD_RDRSP);
+
+	if (rdval < 0)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", rdval);
+}
+static DEVICE_ATTR_RO(counterlpd_rdrsp);
+
+static ssize_t counterlpdsrc_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	xflex_sysfs_cmd(dev, buf, XFLEX_SET_SRC_COUNTER_LPD);
+
+	return size;
+}
+static DEVICE_ATTR_WO(counterlpdsrc);
+
+static ssize_t counterfpdsrc_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	xflex_sysfs_cmd(dev, buf, XFLEX_SET_SRC_COUNTER_FPD);
+
+	return size;
+}
+static DEVICE_ATTR_WO(counterfpdsrc);
+
+static ssize_t counterlpdport_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	xflex_sysfs_cmd(dev, buf, XFLEX_SET_PORT_COUNTER_LPD);
+
+	return size;
+}
+static DEVICE_ATTR_WO(counterlpdport);
+
+static ssize_t counterfpdport_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	xflex_sysfs_cmd(dev, buf, XFLEX_SET_PORT_COUNTER_FPD);
+
+	return size;
+}
+static DEVICE_ATTR_WO(counterfpdport);
+
+static ssize_t counteridlpd_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct xflex_dev_info *flexpm = to_xflex_dev_info(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%08d\n", flexpm->counterid_lpd);
+}
+
+static ssize_t counteridlpd_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	int ret;
+	struct xflex_dev_info *flexpm = to_xflex_dev_info(dev);
+
+	ret = kstrtou32(buf, 0, &flexpm->counterid_lpd);
+	if (ret < 0)
+		return ret;
+
+	reset_default(dev, flexpm->counterid_lpd, FPM_LPD);
+
+	return size;
+}
+static DEVICE_ATTR_RW(counteridlpd);
+
+static ssize_t counteridfpd_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct xflex_dev_info *flexpm = to_xflex_dev_info(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%08d\n", flexpm->counterid_fpd);
+}
+
+static ssize_t counteridfpd_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	int ret;
+	struct xflex_dev_info *flexpm = to_xflex_dev_info(dev);
+
+	ret = kstrtou32(buf, 0, &flexpm->counterid_fpd);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+static DEVICE_ATTR_RW(counteridfpd);
+
+static struct attribute *xflex_attrs[] = {
+	&dev_attr_counterlpdsrc.attr,
+	&dev_attr_counterlpdport.attr,
+	&dev_attr_counterfpdsrc.attr,
+	&dev_attr_counterfpdport.attr,
+
+	&dev_attr_counterlpd_rdreq.attr,
+	&dev_attr_counterlpd_wrreq.attr,
+	&dev_attr_counterlpd_rdrsp.attr,
+	&dev_attr_counterlpd_wrrsp.attr,
+
+	&dev_attr_counterfpd_rdreq.attr,
+	&dev_attr_counterfpd_wrreq.attr,
+	&dev_attr_counterfpd_rdrsp.attr,
+	&dev_attr_counterfpd_wrrsp.attr,
+
+	&dev_attr_counteridlpd.attr,
+	&dev_attr_counteridfpd.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(xflex);
+
+/**
+ * xflex_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation and creates sysfs entries for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xflex_probe(struct platform_device *pdev)
+{
+	struct xflex_dev_info *flexpm;
+	struct resource *res;
+	int err;
+	struct device *dev = &pdev->dev;
+
+	flexpm = devm_kzalloc(dev, sizeof(*flexpm), GFP_KERNEL);
+	if (!flexpm)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "baselpd");
+	flexpm->baselpd = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(flexpm->baselpd))
+		return PTR_ERR(flexpm->baselpd);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "basefpd");
+	flexpm->basefpd = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(flexpm->basefpd))
+		return PTR_ERR(flexpm->basefpd);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "funnel");
+	flexpm->funnel = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(flexpm->funnel))
+		return PTR_ERR(flexpm->funnel);
+
+	mutex_init(&flexpm->lock);
+	writel(FPM_UNLOCK, flexpm->funnel + FPM_LAR_OFFSET);
+	writel(FPM_UNLOCK, flexpm->baselpd + FPM_LAR_OFFSET);
+
+	/* Create sysfs file entries for the device */
+	err = sysfs_create_groups(&dev->kobj, xflex_groups);
+	if (err < 0) {
+		dev_err(dev, "unable to create sysfs entries\n");
+		return err;
+	}
+
+	dev_set_drvdata(dev, flexpm);
+
+	return 0;
+}
+
+/**
+ * xflex_remove - Driver remove function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This function frees all the resources allocated to the device.
+ *
+ * Return: 0 always
+ */
+static int xflex_remove(struct platform_device *pdev)
+{
+	sysfs_remove_groups(&pdev->dev.kobj, xflex_groups);
+	return 0;
+}
+
+static const struct of_device_id xflex_of_match[] = {
+	{ .compatible = "xlnx,flexnoc-pm-2.7", },
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xflex_of_match);
+
+static struct platform_driver xflex_driver = {
+	.driver = {
+		.name = "xilinx-flex",
+		.of_match_table = xflex_of_match,
+	},
+	.probe = xflex_probe,
+	.remove = xflex_remove,
+};
+
+module_platform_driver(xflex_driver);
+
+MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Flexnoc performance monitor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.1

