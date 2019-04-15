Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE5DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF49420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="At3ZSvWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDOHSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:18:50 -0400
Received: from mail-eopbgr770053.outbound.protection.outlook.com ([40.107.77.53]:20964
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfDOHSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXbJCqrAbDF0HalfwO5klj8gHb1eneAvXgiVJYnLlhk=;
 b=At3ZSvWe3zXg+SOgg2+SHNhTls98WFgdRm7YFGMdq/GBfkACX78xhCvU+aTqWZKitl8iU9qRRDrj9o8o9CVka/03GkC/Xuy+lMduCiHaaLGIO/YNUU7m2ynJdeYKeFr2yVAOuWXtvaqhW1+1r/0ofO9dQMU+pSOb/qYC+sbFqVM=
Received: from BN7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:408:20::39)
 by BY2PR02MB2005.namprd02.prod.outlook.com (2a01:111:e400:c504::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.14; Mon, 15 Apr
 2019 07:18:40 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN7PR02CA0026.outlook.office365.com
 (2603:10b6:408:20::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.16 via Frontend
 Transport; Mon, 15 Apr 2019 07:18:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 15 Apr 2019 07:18:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41390 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvt1-0004EJ-3C; Mon, 15 Apr 2019 00:18:39 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsw-0006rY-04; Mon, 15 Apr 2019 00:18:34 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3F7ITW0029064;
        Mon, 15 Apr 2019 00:18:29 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1hFvsq-0006nQ-Gx; Mon, 15 Apr 2019 00:18:28 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v5 3/3] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
Date:   Mon, 15 Apr 2019 12:47:48 +0530
Message-ID: <20190415071748.32275-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415071748.32275-1-nava.manne@xilinx.com>
References: <20190415071748.32275-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39850400004)(346002)(2980300002)(199004)(189003)(47776003)(50226002)(106002)(186003)(77096007)(110136005)(16586007)(51416003)(106466001)(126002)(476003)(316002)(26005)(7696005)(1076003)(50466002)(426003)(478600001)(336012)(36386004)(2616005)(486006)(36756003)(446003)(11346002)(48376002)(81166006)(2906002)(5660300002)(63266004)(8676002)(2201001)(76176011)(8936002)(81156014)(9786002)(305945005)(356004)(6666004)(921003)(5001870100001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2005;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fd03110-3f35-4351-c43c-08d6c1729596
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BY2PR02MB2005;
X-MS-TrafficTypeDiagnostic: BY2PR02MB2005:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB200576E7DC8C258B3B859AEBC22B0@BY2PR02MB2005.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000800954F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TgYbdRyTd7H+lm10qD+dvSAkVqQFodUSyIHI8qxFjVbEm30cpiKaPwMCPOZ5pPqC9F/PCc/sUEA4BNTTSiHNacIdLOpjCKt8R8YULHsyyicwvUxP6ryuzkTam4Fg3BWTNG1GcGO+CY630ZLvJXIc4kXejpsVutmxNHE2oZQ1wcDnNH1dXAVu/rnppBvX6hHuCEbC1KB07K7O/vAz5z+7LdgL/ijeIE7Jdp+zSisO0NocjX6YYlsOx8/XUWV8Tzb7XWNKqdGvfibAgUcXfHBjHaGjFRFiJlqROobT8AhRN9YdhJApPhAP2XZvNzCwuKLQLtkeXJHUx3W3yc/BboLWxK6k0G2HJQzbt+HoT7rtMqOt/+xscFq81svLU86YWsq9EE5IpuYbkRIAW0/k/PgQl1hWQjxSkv1wUQiOUAnMDOY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2019 07:18:39.7260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd03110-3f35-4351-c43c-08d6c1729596
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FPGA Manager support for the Xilinx
ZynqMP chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
Changes for v5:
		-Removed hardcoded  macro values and used BIT(x)
		 as suggested by Moritz.

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
index 000000000000..f7cbaadf49ab
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
+#define IXR_FPGA_DONE_MASK	BIT(3)
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

