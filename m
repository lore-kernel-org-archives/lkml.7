Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF71BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8095B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfKYLAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:00:11 -0500
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:41808
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfKYLAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:00:10 -0500
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by CH2PR02MB6101.namprd02.prod.outlook.com (2603:10b6:610:b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Mon, 25 Nov
 2019 11:00:07 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 11:00:07 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 11:00:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC2r-00077P-JY; Mon, 25 Nov 2019 02:56:41 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC2m-0000lR-8f; Mon, 25 Nov 2019 02:56:36 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAPAuZJ4025735;
        Mon, 25 Nov 2019 02:56:35 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC2l-0000fS-24; Mon, 25 Nov 2019 02:56:35 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, gregkh@linuxfoundation.org, arnd@arndb.de,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/3] misc: xilinx_flex: Add support for the flex noc Performance Monitor
Date:   Mon, 25 Nov 2019 16:25:51 +0530
Message-Id: <1574679352-2989-2-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--15.755-7.0-31-1
X-imss-scan-details: No--15.755-7.0-31-1;No--15.755-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191532074686330;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(199004)(189003)(76482006)(498600001)(305945005)(316002)(26005)(11346002)(446003)(2616005)(73392003)(8676002)(50226002)(2906002)(8936002)(81156014)(81166006)(9786002)(16586007)(14444005)(86362001)(70206006)(70586007)(48376002)(50466002)(6916009)(51416003)(450100002)(76176011)(2351001)(6666004)(356004)(47776003)(61266001)(55446002)(107886003)(426003)(9686003)(336012)(82202003)(2361001)(36756003)(4326008)(30864003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6101;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94773c8-9dbb-4410-02f6-08d77196a210
X-MS-TrafficTypeDiagnostic: CH2PR02MB6101:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6101A4D0AFBBC2FE731C4FF5874A0@CH2PR02MB6101.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: et7dpULa9evAiHJpx9wQQt1Ubd5MinV23z9LUYfiYzzmedYgprhK4GcwOCwZhx/V7EvxahsDDIZACHIcK3wEiYRG+CzIj3LPmtBvI4lN+OXY4qcnjnFSLNIsNoe1TYBJpEaTH9F0PCOdDDsIzes66rbeXd/TbrXBPTZA8QkH9827Tyn8fzIsGRV+5FV40VtPGPxIKjeKfElG8oMc1rRlvnkRHt7cwo8zbAwc9Yn2e9eKcPgCvQZuPHdnawPwaMnOXClNIlO5qP3NzBix9+fbdu+CaxeoxDNOE/FX6A2Lug0swaZpEjtQEC6AZ0YkIK3colB0pTOSrk/gvbg9aK9uUrrKTAvWEnptF1PDSfdE1atbxKoZDlT27CTcU5I6Ds4Fyr2dR5CrohSVn/jsTqLbzOKOCcqgFvhlsSpnv7tMXG0ahDElbQJr5hIz8oflrJ7W
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 11:00:07.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94773c8-9dbb-4410-02f6-08d77196a210
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add support for the FlexNoc Performance Monitor.
Adds support for various port setting and monitoring
the packets transactions. It supports LPD and FPD monitoring
counters for read and write transaction requests and responses.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
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

