Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3402C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D9020859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="puETIBnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbfFJNq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:46:28 -0400
Received: from mail-eopbgr760044.outbound.protection.outlook.com ([40.107.76.44]:58567
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390480AbfFJNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI2vB49gwBMrj0B8x9WlnmTlrpSNJRpw2FVvnhx3ye0=;
 b=puETIBnjrjGct7hv1/mxEn9BWF9xY5bKPCNmGsdIqFzXsQaCWnKRjToCFb2hgvDVa9US1BOPwdpPJX6mwBAQjKVDyKDtcFQheJOszGlE+Wl99Kv4BOdB0aY5y3MflXrGtlV2dR+fzAg3T6D/3kyuhg+qZR3cxIYR34UqZP64f4A=
Received: from BN7PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:20::48)
 by CY4PR02MB2678.namprd02.prod.outlook.com (2603:10b6:903:124::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.17; Mon, 10 Jun
 2019 13:45:36 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN7PR02CA0035.outlook.office365.com
 (2603:10b6:408:20::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Mon, 10 Jun 2019 13:45:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Mon, 10 Jun 2019 13:45:35 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 10 Jun 2019 14:45:31 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 10 Jun 2019 14:45:31 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 mark.rutland@arm.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=49286 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1haKc7-00074r-BO; Mon, 10 Jun 2019 14:45:31 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V6 02/11] misc: xilinx-sdfec: add core driver
Date:   Mon, 10 Jun 2019 14:45:05 +0100
Message-ID: <1560174314-124649-3-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560174314-124649-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560174314-124649-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(60926002)(426003)(5660300002)(2201001)(336012)(28376004)(36906005)(316002)(446003)(9786002)(71366001)(6666004)(26826003)(14444005)(478600001)(16586007)(51416003)(2906002)(76176011)(11346002)(486006)(7696005)(110136005)(54906003)(106002)(956004)(2616005)(476003)(44832011)(126002)(356004)(70206006)(26005)(186003)(76130400001)(70586007)(8936002)(36756003)(107886003)(48376002)(50226002)(47776003)(50466002)(305945005)(7636002)(8676002)(4326008)(246002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2678;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b15232-c2ab-4a04-8f66-08d6eda9ea98
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CY4PR02MB2678;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2678:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB26787447AEAA6CD19E44D233CB130@CY4PR02MB2678.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0064B3273C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ecW1RH+aVMptyOfymYPoeqBRFTF1hSN/4/l39bKFxguIn25JYU/2nmEeYQcFfDtJBM2+BOs9wx/R5WgOWrYWsjWlFbG2p2F7rzQMWhxxy+IcYxmpBw2FPBIGW5sIBw0CABYPi4Ot75OZlZXD0m0OLLu/4sZPzeg+8ccYt5Gx7j0OQo1756zvVyNIQaxMuBROgSZqhtBI55AQm7ADfa5ZqGBuuFTfaYiXMa4OIgtQcYpyhouZQl6C4bSlLD/p8Fy7+/eHVHyTUcGoKAw0DLerdjKLSX+Y7+o0Z64NAVmwk/4AXVKu0j4zQh2TOUI9+jJC9gTPyap4NaZtsVDdcd+tdNAGlgw6/Z1tE5414/RA/u8OZjs1lP58wZ/UWUnG7+SAQFpnV8hHkGm+vsF8fhxcHO1KW+sOMLH3/5I++Vb+bfQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2019 13:45:35.4574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b15232-c2ab-4a04-8f66-08d6eda9ea98
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a platform driver that matches with xlnx,
sd-fec-1.1 device tree node and registers as a character
device, including:
- SD-FEC driver binds to sdfec DT node.
- creates and initialise an initial driver dev structure.
- add the driver in Linux build and Kconfig.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/Kconfig        |  12 ++++
 drivers/misc/Makefile       |   1 +
 drivers/misc/xilinx_sdfec.c | 162 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/misc/xilinx_sdfec.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6b0417b..319a6bf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -471,6 +471,18 @@ config PCI_ENDPOINT_TEST
            Enable this configuration option to enable the host side test driver
            for PCI Endpoint.
 
+config XILINX_SDFEC
+	tristate "Xilinx SDFEC 16"
+	help
+	  This option enables support for the Xilinx SDFEC (Soft Decision
+	  Forward Error Correction) driver. This enables a char driver
+	  for the SDFEC.
+
+	  You may select this driver if your design instantiates the
+	  SDFEC(16nm) hardened block. To compile this as a module choose M.
+
+	  If unsure, say N.
+
 config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b9affcd..0cb3546 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
+obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
new file mode 100644
index 0000000..ff0704b
--- /dev/null
+++ b/drivers/misc/xilinx_sdfec.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx SDFEC
+ *
+ * Copyright (C) 2019 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for SDFEC16 (Soft Decision FEC 16nm)
+ * IP. It exposes a char device which supports file operations
+ * like  open(), close() and ioctl().
+ */
+
+#include <linux/miscdevice.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#define DEV_NAME_LEN 12
+
+static struct idr dev_idr;
+static struct mutex dev_idr_lock;
+
+/**
+ * struct xsdfec_dev - Driver data for SDFEC
+ * @regs: device physical base address
+ * @dev: pointer to device struct
+ * @miscdev: Misc device handle
+ * @error_data_lock: Error counter and states spinlock
+ * @dev_name: Device name
+ * @dev_id: Device ID
+ *
+ * This structure contains necessary state for SDFEC driver to operate
+ */
+struct xsdfec_dev {
+	void __iomem *regs;
+	struct device *dev;
+	struct miscdevice miscdev;
+	/* Spinlock to protect state_updated and stats_updated */
+	spinlock_t error_data_lock;
+	char dev_name[DEV_NAME_LEN];
+	int dev_id;
+};
+
+static const struct file_operations xsdfec_fops = {
+	.owner = THIS_MODULE,
+};
+
+static void xsdfec_idr_remove(struct xsdfec_dev *xsdfec)
+{
+	mutex_lock(&dev_idr_lock);
+	idr_remove(&dev_idr, xsdfec->dev_id);
+	mutex_unlock(&dev_idr_lock);
+}
+
+static int xsdfec_probe(struct platform_device *pdev)
+{
+	struct xsdfec_dev *xsdfec;
+	struct device *dev;
+	struct resource *res;
+	int err;
+
+	xsdfec = devm_kzalloc(&pdev->dev, sizeof(*xsdfec), GFP_KERNEL);
+	if (!xsdfec)
+		return -ENOMEM;
+
+	xsdfec->dev = &pdev->dev;
+	spin_lock_init(&xsdfec->error_data_lock);
+
+	dev = xsdfec->dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xsdfec->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(xsdfec->regs)) {
+		err = PTR_ERR(xsdfec->regs);
+		return err;
+	}
+
+	/* Save driver private data */
+	platform_set_drvdata(pdev, xsdfec);
+
+	mutex_lock(&dev_idr_lock);
+	err = idr_alloc(&dev_idr, xsdfec->dev_name, 0, 0, GFP_KERNEL);
+	mutex_unlock(&dev_idr_lock);
+	if (err < 0)
+		goto err_xsddev_idr;
+	xsdfec->dev_id = err;
+
+	snprintf(xsdfec->dev_name, DEV_NAME_LEN, "xsdfec%d", xsdfec->dev_id);
+	xsdfec->miscdev.minor = MISC_DYNAMIC_MINOR;
+	xsdfec->miscdev.name = xsdfec->dev_name;
+	xsdfec->miscdev.fops = &xsdfec_fops;
+	xsdfec->miscdev.parent = dev;
+	err = misc_register(&xsdfec->miscdev);
+	if (err) {
+		dev_err(dev, "error:%d. Unable to register device", err);
+		return err;
+	}
+	return 0;
+
+err_xsddev_idr:
+	xsdfec_idr_remove(xsdfec);
+
+	return err;
+}
+
+static int xsdfec_remove(struct platform_device *pdev)
+{
+	struct xsdfec_dev *xsdfec;
+
+	xsdfec = platform_get_drvdata(pdev);
+	misc_deregister(&xsdfec->miscdev);
+	xsdfec_idr_remove(xsdfec);
+	return 0;
+}
+
+static const struct of_device_id xsdfec_of_match[] = {
+	{
+		.compatible = "xlnx,sd-fec-1.1",
+	},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xsdfec_of_match);
+
+static struct platform_driver xsdfec_driver = {
+	.driver = {
+		.name = "xilinx-sdfec",
+		.of_match_table = xsdfec_of_match,
+	},
+	.probe = xsdfec_probe,
+	.remove =  xsdfec_remove,
+};
+
+static int __init xsdfec_init(void)
+{
+	int err;
+
+	mutex_init(&dev_idr_lock);
+	idr_init(&dev_idr);
+	err = platform_driver_register(&xsdfec_driver);
+	if (err < 0) {
+		pr_err("%s Unabled to register SDFEC driver", __func__);
+		return err;
+	}
+	return 0;
+}
+
+static void __exit xsdfec_exit(void)
+{
+	platform_driver_unregister(&xsdfec_driver);
+	idr_destroy(&dev_idr);
+}
+
+module_init(xsdfec_init);
+module_exit(xsdfec_exit);
+
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx SD-FEC16 Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

