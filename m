Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335BC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3456207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfLIOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:25:11 -0500
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:15948
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfLIOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:25:07 -0500
Received: from CH2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:4e::21)
 by SN6PR02MB5069.namprd02.prod.outlook.com (2603:10b6:805:67::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Mon, 9 Dec
 2019 14:25:04 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CH2PR02CA0011.outlook.office365.com
 (2603:10b6:610:4e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Mon, 9 Dec 2019 14:25:04 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 14:25:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieJwl-0007qI-Ex; Mon, 09 Dec 2019 06:23:35 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieJwg-0006oJ-8J; Mon, 09 Dec 2019 06:23:30 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB9ENTt0022367;
        Mon, 9 Dec 2019 06:23:29 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieJwf-0006nz-0I; Mon, 09 Dec 2019 06:23:29 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Subject: [PATCH v2 1/2] uio: uio_xilinx_apm: Add Xilinx AXI performance monitor driver
Date:   Mon,  9 Dec 2019 19:53:24 +0530
Message-Id: <1575901405-3084-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--11.547-7.0-31-1
X-imss-scan-details: No--11.547-7.0-31-1;No--11.547-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203751041825349;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(426003)(76482006)(336012)(2616005)(6666004)(30864003)(73392003)(36756003)(450100002)(54906003)(316002)(82202003)(4326008)(9686003)(107886003)(498600001)(305945005)(8936002)(86362001)(81156014)(70586007)(70206006)(5660300002)(2906002)(26005)(356004)(55446002)(9786002)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5069;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56c37127-e8d8-47ee-b091-08d77cb39541
X-MS-TrafficTypeDiagnostic: SN6PR02MB5069:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50692689E980274116E5F91F87580@SN6PR02MB5069.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+uceQu76uKvEDyqEdDRBNUL6RqsQBALtu6d88CGu7uvVDHHXdN1K1ykocJBOyY7dAOnH9+H/PYbYLxKkCgcHGFDxCy4FLgqd7x3PtTbL+W2AkLfC1AYuF21vZBUNJ84ovr9S07FH3HMgaiYRevJXiX/ee2zLPyZYAWtWNjPyBF2p0AENKjkRPFUxoIy9iXkmiqtE2sT0iiesoNEoSW9tHZZM+3N+vBnIgJInd33o+mhGqolME1yvswEgBWgn5+uuvjLAVxl7Qg5NDksAyYpq+05oNvEmYDe3fyVfST/fk4TF2Yut7jwtV2WHruzNcd904ae5WKR0P5OB10vg5VZkE7wq70tfCdMov7oLvW9PePxrf1q6FRvdYjSNfeislvajGwKbQrA0Rz30U9c7BALgcPcaJt+GTIlpiSt+glUUCB73/PMZcuRx+4QiJ0EjPZj
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 14:25:03.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c37127-e8d8-47ee-b091-08d77cb39541
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Added driver for Xilinx AXI performance monitor IP.

Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Updated the header

 drivers/uio/Kconfig          |  12 ++
 drivers/uio/Makefile         |   1 +
 drivers/uio/uio_xilinx_apm.c | 358 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)
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
index 0000000..3f69922
--- /dev/null
+++ b/drivers/uio/uio_xilinx_apm.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx AXI Performance Monitor
+ *
+ * Description:
+ * This driver is developed for AXI Performance Monitor IP,
+ * designed to monitor AXI4 traffic for performance analysis
+ * of AXI bus in the system. Driver maps HW registers and parameters
+ * to userspace. Userspace need not clear the interrupt of IP since
+ * driver clears the interrupt.
+ *
+ * Copyright (c) 2019 Xilinx Inc.
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

