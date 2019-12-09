Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE092077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLIKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:07:31 -0500
Received: from mail-eopbgr680064.outbound.protection.outlook.com ([40.107.68.64]:13379
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbfLIKHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:07:30 -0500
Received: from BYAPR02CA0056.namprd02.prod.outlook.com (2603:10b6:a03:54::33)
 by BY5PR02MB6020.namprd02.prod.outlook.com (2603:10b6:a03:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Mon, 9 Dec
 2019 10:07:27 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0056.outlook.office365.com
 (2603:10b6:a03:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.18 via Frontend
 Transport; Mon, 9 Dec 2019 10:07:27 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 10:07:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieFwq-00067A-RY; Mon, 09 Dec 2019 02:07:24 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieFwl-0006PG-Lq; Mon, 09 Dec 2019 02:07:19 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB9A7Iw9006017;
        Mon, 9 Dec 2019 02:07:19 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieFwk-0006Og-De; Mon, 09 Dec 2019 02:07:18 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>,
        Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Subject: [PATCH] uio: uio_xilinx_apm: Add Xilinx AXI performance monitor driver
Date:   Mon,  9 Dec 2019 15:37:15 +0530
Message-Id: <1575886035-19422-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--12.633-7.0-31-1
X-imss-scan-details: No--12.633-7.0-31-1;No--12.633-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203596471037861;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(70586007)(70206006)(6916009)(305945005)(55446002)(36756003)(498600001)(26005)(54906003)(426003)(9686003)(8936002)(86362001)(76482006)(73392003)(81166006)(81156014)(4326008)(2906002)(5660300002)(30864003)(107886003)(2616005)(8676002)(356004)(6666004)(316002)(336012)(82202003)(9786002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6020;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a89214a8-5fdf-4311-1b32-08d77c8f981f
X-MS-TrafficTypeDiagnostic: BY5PR02MB6020:
X-Microsoft-Antispam-PRVS: <BY5PR02MB60204938F9D8B871444ADB8B87580@BY5PR02MB6020.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESHqrxDCxVIbNFV7QxJhJRT0/QKMwTjgbEK5FXVEsBQV3AjnWXNO1iX4uheinPAau9iIDdHDD6PhcDz4BWn4FY9iH/LKhlLtT+AzYTxrjq4cilGwH7NjGeiOqJ/exif/40DNKg8xu7KT+ofjeAe2K6yTrqRoUaRpfDlIe8zl46PYg+JyOXjnPHx0Iru7owGsanaJYOqLIDcm9f5QTHsmTynRwKqLcFpBd/qIgpA8dL0RygKgY6ZWpfB/RGGTRCD8uBiq2E/pwi0qDhsCfxap5aC/V2wTEEmSI8npnHMe7oOHDfdV+jZixhDBLd5C4OLkw2CdqMcIvERKOWD7pfTVy3SJvPtJIH8LHX44LUomf8kuMEiGesTF9Qijy4G0qq0LJDkOhZsuSQVWzfvIuWmTd3LajF7IlPIijlEWHwHGHVWZUBsyR7cKQdCyIdSn+kQVW+X/l4PzX1p3U/flknd/bJv50cYmgHan/LBfoCo21WrsLHU9B4FfvZzY1Lt9h4yrgu0p8Gv57WU35G+KHjO6FA==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 10:07:26.8726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89214a8-5fdf-4311-1b32-08d77c8f981f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Added driver for Xilinx AXI performance monitor IP.

Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/uio/Kconfig          |  12 ++
 drivers/uio/Makefile         |   1 +
 drivers/uio/uio_xilinx_apm.c | 369 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 drivers/uio/uio_xilinx_apm.c

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81..de30312 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -165,4 +165,16 @@ config UIO_HV_GENERIC
 	  to network and storage devices from userspace.
 
 	  If you compile this as a module, it will be called uio_hv_generic.
+
+config UIO_XILINX_APM
+	tristate "Xilinx AXI Performance Monitor driver"
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
+	help
+	  This driver is developed for AXI Performance Monitor IP, designed to
+	  monitor AXI4 traffic for performance analysis of AXI bus in the
+	  system. Driver maps HW registers and parameters to userspace.
+
+	  To compile this driver as a module, choose M here; the module
+	  will be called uio_xilinx_apm.
+
 endif
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index c285dd2..b3464d8 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
 obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
 obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
+obj-$(CONFIG_UIO_XILINX_APM)	+= uio_xilinx_apm.o
diff --git a/drivers/uio/uio_xilinx_apm.c b/drivers/uio/uio_xilinx_apm.c
new file mode 100644
index 0000000..90d70a5
--- /dev/null
+++ b/drivers/uio/uio_xilinx_apm.c
@@ -0,0 +1,369 @@
+/*
+ * Xilinx AXI Performance Monitor
+ *
+ * Copyright (C) 2013 Xilinx, Inc. All rights reserved.
+ *
+ * Description:
+ * This driver is developed for AXI Performance Monitor IP,
+ * designed to monitor AXI4 traffic for performance analysis
+ * of AXI bus in the system. Driver maps HW registers and parameters
+ * to userspace. Userspace need not clear the interrupt of IP since
+ * driver clears the interrupt.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/uio_driver.h>
+
+#define XAPM_IS_OFFSET		0x0038  /* Interrupt Status Register */
+#define DRV_NAME		"xilinxapm_uio"
+#define DRV_VERSION		"1.0"
+#define UIO_DUMMY_MEMSIZE	4096
+#define XAPM_MODE_ADVANCED	1
+#define XAPM_MODE_PROFILE	2
+#define XAPM_MODE_TRACE		3
+
+/**
+ * struct xapm_param - HW parameters structure
+ * @mode: Mode in which APM is working
+ * @maxslots: Maximum number of Slots in APM
+ * @eventcnt: Event counting enabled in APM
+ * @eventlog: Event logging enabled in APM
+ * @sampledcnt: Sampled metric counters enabled in APM
+ * @numcounters: Number of counters in APM
+ * @metricwidth: Metric Counter width (32/64)
+ * @sampledwidth: Sampled metric counter width
+ * @globalcntwidth: Global Clock counter width
+ * @scalefactor: Scaling factor
+ * @isr: Interrupts info shared to userspace
+ * @is_32bit_filter: Flags for 32bit filter
+ * @clk: Clock handle
+ */
+struct xapm_param {
+	u32 mode;
+	u32 maxslots;
+	u32 eventcnt;
+	u32 eventlog;
+	u32 sampledcnt;
+	u32 numcounters;
+	u32 metricwidth;
+	u32 sampledwidth;
+	u32 globalcntwidth;
+	u32 scalefactor;
+	u32 isr;
+	bool is_32bit_filter;
+	struct clk *clk;
+};
+
+/**
+ * struct xapm_dev - Global driver structure
+ * @info: uio_info structure
+ * @param: xapm_param structure
+ * @regs: IOmapped base address
+ */
+struct xapm_dev {
+	struct uio_info info;
+	struct xapm_param param;
+	void __iomem *regs;
+};
+
+/**
+ * xapm_handler - Interrupt handler for APM
+ * @irq: IRQ number
+ * @info: Pointer to uio_info structure
+ *
+ * Return: Always returns IRQ_HANDLED
+ */
+static irqreturn_t xapm_handler(int irq, struct uio_info *info)
+{
+	struct xapm_dev *xapm = (struct xapm_dev *)info->priv;
+	void *ptr;
+
+	ptr = (unsigned long *)xapm->info.mem[1].addr;
+	/* Clear the interrupt and copy the ISR value to userspace */
+	xapm->param.isr = readl(xapm->regs + XAPM_IS_OFFSET);
+	writel(xapm->param.isr, xapm->regs + XAPM_IS_OFFSET);
+	memcpy(ptr, &xapm->param, sizeof(struct xapm_param));
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * xapm_getprop - Retrieves dts properties to param structure
+ * @pdev: Pointer to platform device
+ * @param: Pointer to param structure
+ *
+ * Returns: '0' on success and failure value on error
+ */
+static int xapm_getprop(struct platform_device *pdev, struct xapm_param *param)
+{
+	u32 mode = 0;
+	int ret;
+	struct device_node *node;
+
+	node = pdev->dev.of_node;
+
+	/* Retrieve required dts properties and fill param structure */
+	ret = of_property_read_u32(node, "xlnx,enable-profile", &mode);
+	if (ret < 0)
+		dev_info(&pdev->dev, "no property xlnx,enable-profile\n");
+	else if (mode)
+		param->mode = XAPM_MODE_PROFILE;
+
+	ret = of_property_read_u32(node, "xlnx,enable-trace", &mode);
+	if (ret < 0)
+		dev_info(&pdev->dev, "no property xlnx,enable-trace\n");
+	else if (mode)
+		param->mode = XAPM_MODE_TRACE;
+
+	ret = of_property_read_u32(node, "xlnx,num-monitor-slots",
+				   &param->maxslots);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,num-monitor-slots");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,enable-event-count",
+				   &param->eventcnt);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,enable-event-count");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,enable-event-log",
+				   &param->eventlog);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,enable-event-log");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,have-sampled-metric-cnt",
+				   &param->sampledcnt);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,have-sampled-metric-cnt");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,num-of-counters",
+				   &param->numcounters);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,num-of-counters");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,metric-count-width",
+				   &param->metricwidth);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,metric-count-width");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,metrics-sample-count-width",
+				   &param->sampledwidth);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property metrics-sample-count-width");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,global-count-width",
+				   &param->globalcntwidth);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,global-count-width");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "xlnx,metric-count-scale",
+				   &param->scalefactor);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no property xlnx,metric-count-scale");
+		return ret;
+	}
+
+	param->is_32bit_filter = of_property_read_bool(node,
+						"xlnx,id-filter-32bit");
+
+	return 0;
+}
+
+/**
+ * xapm_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * Returns: '0' on success and failure value on error
+ */
+
+static int xapm_probe(struct platform_device *pdev)
+{
+	struct xapm_dev *xapm;
+	struct resource *res;
+	int irq;
+	int ret;
+	void *ptr;
+
+	xapm = devm_kzalloc(&pdev->dev, (sizeof(struct xapm_dev)), GFP_KERNEL);
+	if (!xapm)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xapm->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xapm->regs)) {
+		dev_err(&pdev->dev, "unable to iomap registers\n");
+		return PTR_ERR(xapm->regs);
+	}
+
+	xapm->param.clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(xapm->param.clk)) {
+		if (PTR_ERR(xapm->param.clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "axi clock error\n");
+		return PTR_ERR(xapm->param.clk);
+	}
+
+	ret = clk_prepare_enable(xapm->param.clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+		return ret;
+	}
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	/* Initialize mode as Advanced so that if no mode in dts, default
+	 * is Advanced
+	 */
+	xapm->param.mode = XAPM_MODE_ADVANCED;
+	ret = xapm_getprop(pdev, &xapm->param);
+	if (ret < 0)
+		goto err_clk_dis;
+
+	xapm->info.mem[0].name = "xilinx_apm";
+	xapm->info.mem[0].addr = res->start;
+	xapm->info.mem[0].size = resource_size(res);
+	xapm->info.mem[0].memtype = UIO_MEM_PHYS;
+
+	xapm->info.mem[1].addr = (unsigned long)kzalloc(UIO_DUMMY_MEMSIZE,
+							GFP_KERNEL);
+	ptr = (unsigned long *)xapm->info.mem[1].addr;
+	xapm->info.mem[1].size = UIO_DUMMY_MEMSIZE;
+	xapm->info.mem[1].memtype = UIO_MEM_LOGICAL;
+
+	xapm->info.name = "axi-pmon";
+	xapm->info.version = DRV_VERSION;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "unable to get irq\n");
+		ret = irq;
+		goto err_clk_dis;
+	}
+
+	xapm->info.irq = irq;
+	xapm->info.handler = xapm_handler;
+	xapm->info.priv = xapm;
+	xapm->info.irq_flags = IRQF_SHARED;
+
+	memcpy(ptr, &xapm->param, sizeof(struct xapm_param));
+
+	ret = uio_register_device(&pdev->dev, &xapm->info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to register to UIO\n");
+		goto err_clk_dis;
+	}
+
+	platform_set_drvdata(pdev, xapm);
+
+	dev_info(&pdev->dev, "Probed Xilinx APM\n");
+
+	return 0;
+
+err_clk_dis:
+	clk_disable_unprepare(xapm->param.clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	return ret;
+}
+
+/**
+ * xapm_remove - Driver remove function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * Return: Always returns '0'
+ */
+static int xapm_remove(struct platform_device *pdev)
+{
+	struct xapm_dev *xapm = platform_get_drvdata(pdev);
+
+	uio_unregister_device(&xapm->info);
+	clk_disable_unprepare(xapm->param.clk);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused xapm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xapm_dev *xapm = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(xapm->param.clk);
+	return 0;
+};
+
+static int __maybe_unused xapm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xapm_dev *xapm = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = clk_prepare_enable(xapm->param.clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable clock.\n");
+		return ret;
+	}
+	return 0;
+};
+
+static const struct dev_pm_ops xapm_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xapm_runtime_suspend, xapm_runtime_resume)
+	SET_RUNTIME_PM_OPS(xapm_runtime_suspend,
+			   xapm_runtime_resume, NULL)
+};
+
+static const struct of_device_id xapm_of_match[] = {
+	{ .compatible = "xlnx,axi-perf-monitor", },
+	{ /* end of table*/ }
+};
+
+MODULE_DEVICE_TABLE(of, xapm_of_match);
+
+static struct platform_driver xapm_driver = {
+	.driver = {
+		.name = "xilinx-axipmon",
+		.of_match_table = xapm_of_match,
+		.pm = &xapm_dev_pm_ops,
+	},
+	.probe = xapm_probe,
+	.remove = xapm_remove,
+};
+
+module_platform_driver(xapm_driver);
+
+MODULE_AUTHOR("Xilinx Inc.");
+MODULE_DESCRIPTION("Xilinx AXI Performance Monitor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.1

