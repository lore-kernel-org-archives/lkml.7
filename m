Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE499C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867B52133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sI0ZEWLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfDBMcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:32:04 -0400
Received: from mail-eopbgr760053.outbound.protection.outlook.com ([40.107.76.53]:56489
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731017AbfDBMcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTuo47Fup6mOczBI7X2sme+HK4EqcMBEK3ZpBEhGt3I=;
 b=sI0ZEWLqiIiUJP8l+glXI3KD16TwSlikGyB+Voy/vRNiU5tsAFbdr0/xcYJ3C4gLAYP9c0uevSgXTD9DHNPz4+omb1RoC5DTw6DF+j6FGAPbnv9V8We7GtSeWPVTittzE7DrrREzSYecDBsmOEVPXifTd4wieMDO19+G8yqYlBQ=
Received: from SN4PR0201CA0034.namprd02.prod.outlook.com
 (2603:10b6:803:2e::20) by CY1PR02MB1659.namprd02.prod.outlook.com
 (2a01:111:e400:529a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15; Tue, 2 Apr
 2019 12:31:57 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0034.outlook.office365.com
 (2603:10b6:803:2e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.20 via Frontend
 Transport; Tue, 2 Apr 2019 12:31:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Tue, 2 Apr 2019 12:31:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53513 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIa4-0006Cg-MM; Tue, 02 Apr 2019 05:31:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZz-0007Yr-Ib; Tue, 02 Apr 2019 05:31:51 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hBIZt-0007U9-9o; Tue, 02 Apr 2019 05:31:45 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v4 3/3] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
Date:   Tue, 2 Apr 2019 18:01:23 +0530
Message-ID: <20190402123123.915-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190402123123.915-1-nava.manne@xilinx.com>
References: <20190402123123.915-1-nava.manne@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(199004)(189003)(336012)(77096007)(2906002)(81156014)(16586007)(106466001)(7696005)(1076003)(106002)(50226002)(5660300002)(2616005)(305945005)(48376002)(11346002)(110136005)(36756003)(50466002)(8676002)(486006)(81166006)(8936002)(126002)(9786002)(2201001)(63266004)(316002)(356004)(51416003)(426003)(186003)(476003)(446003)(47776003)(478600001)(26005)(6666004)(76176011)(36386004)(921003)(83996005)(1121003)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1659;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1840be3-634d-49b2-27ce-08d6b7673273
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CY1PR02MB1659;
X-MS-TrafficTypeDiagnostic: CY1PR02MB1659:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB16592F2ADACAB467E25CBC12C2560@CY1PR02MB1659.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0995196AA2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KapM21iChRHflXVeUTFdO0dUxiDTtt5G+oPPOM/oyP++Q1GihEg+itMs4gbnkFRBgypjkMv1Es1mSrI934lxlYfqT9fxEonGMOB3wbVIoygh+IxSTwm05I+v4H3wVXZluBKwS51JOHJOEaVj7ldLGYFbCRZORvJ5DI2gOR9lgei86F64B2iOYzXHTIzUlfOjZTVzxyfWqDJVraEWrj8WQw+ROSuif5SoAlTcTcVDq5aznk4i2kHV1LM6K6dsM+Z9Gt+Pwzp+kcgfothFQU1qmMR0FRHD6mGNotxs+BqZ9FH4njIpWmQN7MyRKk3T8yX6vs+SWyC59XQT0uROW1qBH2w39cPQp2mtlJeUdhvOsb5rNrZ75NDQwoM2n4nMkY2Iyhbdlage+mqg9rF6Xb7/+SPZ0bZokYXAz3R/xftFGc8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2019 12:31:57.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1840be3-634d-49b2-27ce-08d6b7673273
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FPGA Manager support for the Xilinx
ZynqMP chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v4:
		-Updated the Fpga Mgr registrations call's
		 to 5.0
		-Removed dma_set_mask_and_coherent() As the FW
		 supports only 32-bit address operations.

Changes for v3:
		-Created patches on top of 5.0-rc5.
		 No functional changes.

Changes for v2:
		-Fixed some minor coding issues as suggested by
		 Moritz

Changes for v1:
		-None.

Changes for RFC-V2:
		-Updated the Fpga Mgr registrations call's
		 to 4.18

 drivers/fpga/Kconfig       |   9 +++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/zynqmp-fpga.c | 159 +++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index c20445b867ae..d892f3efcd76 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -204,4 +204,13 @@ config FPGA_DFL_PCI
 
 	  To compile this as a module, choose M here.
 
+config FPGA_MGR_ZYNQMP_FPGA
+	tristate "Xilinx ZynqMP FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
+	  This driver uses the processor configuration port(PCAP)
+	  to configure the programmable logic(PL) through PS
+	  on ZynqMP SoC.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index c0dd4c82fbdb..312b9371742f 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
 obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
new file mode 100644
index 000000000000..f6e35fe95adb
--- /dev/null
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Xilinx, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Constant Definitions */
+#define IXR_FPGA_DONE_MASK	0X00000008U
+
+/**
+ * struct zynqmp_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ * @flags:	flags which is used to identify the bitfile type
+ */
+struct zynqmp_fpga_priv {
+	struct device *dev;
+	u32 flags;
+};
+
+static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+
+	priv = mgr->priv;
+	priv->flags = info->flags;
+
+	return 0;
+}
+
+static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	struct zynqmp_fpga_priv *priv;
+	dma_addr_t dma_addr;
+	u32 eemi_flags = 0;
+	char *kbuf;
+	int ret;
+
+	if (!eemi_ops || !eemi_ops->fpga_load)
+		return -ENXIO;
+
+	priv = mgr->priv;
+
+	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	if (priv->flags & FPGA_MGR_PARTIAL_RECONFIG)
+		eemi_flags |= XILINX_ZYNQMP_PM_FPGA_PARTIAL;
+
+	ret = eemi_ops->fpga_load(dma_addr, size, eemi_flags);
+
+	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 status;
+
+	if (!eemi_ops || !eemi_ops->fpga_get_status)
+		return FPGA_MGR_STATE_UNKNOWN;
+
+	eemi_ops->fpga_get_status(&status);
+	if (status & IXR_FPGA_DONE_MASK)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops zynqmp_fpga_ops = {
+	.state = zynqmp_fpga_ops_state,
+	.write_init = zynqmp_fpga_ops_write_init,
+	.write = zynqmp_fpga_ops_write,
+	.write_complete = zynqmp_fpga_ops_write_complete,
+};
+
+static int zynqmp_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_fpga_priv *priv;
+	struct fpga_manager *mgr;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
+				   &zynqmp_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	ret = fpga_mgr_register(mgr);
+	if (ret) {
+		dev_err(dev, "unable to register FPGA manager");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int zynqmp_fpga_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
+
+	return 0;
+}
+
+static const struct of_device_id zynqmp_fpga_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-pcap-fpga", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
+
+static struct platform_driver zynqmp_fpga_driver = {
+	.probe = zynqmp_fpga_probe,
+	.remove = zynqmp_fpga_remove,
+	.driver = {
+		.name = "zynqmp_fpga_manager",
+		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+	},
+};
+
+module_platform_driver(zynqmp_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0

