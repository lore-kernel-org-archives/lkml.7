Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC81C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E272083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DZXKcF0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDIKHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:07:18 -0400
Received: from mail-eopbgr730073.outbound.protection.outlook.com ([40.107.73.73]:27040
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfDIKHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbrhqXpEaHjyGzxdYK+FhEe80PUFlQoWNNlPyDPeTs8=;
 b=DZXKcF0WxKHRYtfJFWJnLldyV169HzdrBCW3JbH348/9C//BSiTF/f+R7Nhz6r7+zg3Thb6tF0izhNPXHBM+BH/YD7bTHpG65UkT3GAf9cw4eDgc5iaZFFc0EWpjBDclGztW4ApBB2mair9uhV549lNK8SSydHxLt7kw7r7fR6k=
Received: from BYAPR02CA0004.namprd02.prod.outlook.com (2603:10b6:a02:ee::17)
 by BLUPR02MB148.namprd02.prod.outlook.com (2a01:111:e400:849::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1771.21; Tue, 9
 Apr 2019 10:07:09 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BYAPR02CA0004.outlook.office365.com
 (2603:10b6:a02:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:08 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 9 Apr 2019 11:07:04 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 9 Apr 2019 11:07:04 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=57788 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hDnei-0007SJ-Il; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 02/12] misc: xilinx-sdfec: add core driver
Date:   Tue, 9 Apr 2019 11:06:44 +0100
Message-ID: <1554804414-206099-3-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(36756003)(486006)(126002)(48376002)(7696005)(446003)(14444005)(11346002)(426003)(2616005)(28376004)(476003)(50466002)(44832011)(336012)(356004)(6666004)(2906002)(956004)(51416003)(26826003)(478600001)(8936002)(76130400001)(2201001)(106466001)(107886003)(9786002)(110136005)(93146003)(16586007)(54906003)(50226002)(316002)(36906005)(7636002)(246002)(47776003)(5660300002)(76176011)(71366001)(106002)(60926002)(305945005)(4326008)(8676002)(186003)(26005)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB148;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14bbc9e0-ddc8-4453-ab13-08d6bcd3204e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BLUPR02MB148;
X-MS-TrafficTypeDiagnostic: BLUPR02MB148:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB148388BBF42ABA5E6D8BB26CB2D0@BLUPR02MB148.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: AKGrNi0MrFrEUFxQhPf3vI7wFsQdMCrZOp4lKuYrqQdgjH80KfTWA+buuS5ciM95IzsrhVtYQ2jQnVfBz1RLC26LMFFS44ahhsirDc5fKC16Ge0puo5JJxEXLGcZtfEWG3vhGtkx8gKV5tM81hFqLeIm2OvIfeCv5tneUSXCY48UEiU8ZwrjkABeB0hoUMPe3ZqG04+dNCeh9sh8kZMu5523WB6jGrWbqiQfnBF3ZAo2vPkC6/ETWAF8mn5Na+sfvrXfKICKuyP3EkhsMOsI7NALIAVthZkza3iJkVwzmw0vvwcn4lG6FXYy40TobYvhI40KGfNig4Sp9PDe9flCYInjGJ5Oq5oUXaIDV6qPd3lxfZRcMmRrvezDVQ7IKKk1is4tOphlLr9S1IAVwwzWKtywvN80GR9XwW9JsxTfYyk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:08.1038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bbc9e0-ddc8-4453-ab13-08d6bcd3204e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements an platform driver that matches with xlnx,
sd-fec-1.1 device tree node and registers as a character
device, including:
- SD-FEC driver binds to sdfec DT node.
- creates and initialise an initial driver dev structure.
- add the driver in Linux build and Kconfig.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/Kconfig             |  12 +++
 drivers/misc/Makefile            |   1 +
 drivers/misc/xilinx_sdfec.c      | 215 +++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h |  42 ++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 drivers/misc/xilinx_sdfec.c
 create mode 100644 include/uapi/misc/xilinx_sdfec.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec..bbb868f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -520,6 +520,18 @@ config PCI_ENDPOINT_TEST
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
index d5b7d34..08f0906 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
+obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
new file mode 100644
index 0000000..278754b
--- /dev/null
+++ b/drivers/misc/xilinx_sdfec.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx SDFEC
+ *
+ * Copyright (C) 2016 - 2017 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for SDFEC16 (Soft Decision FEC 16nm)
+ * IP. It exposes a char device interface in sysfs and supports file
+ * operations like  open(), close() and ioctl().
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+
+#include <uapi/misc/xilinx_sdfec.h>
+
+#define DRIVER_NAME "xilinx_sdfec"
+#define DRIVER_VERSION "0.3"
+#define DRIVER_MAX_DEV BIT(MINORBITS)
+
+static struct class *xsdfec_class;
+static atomic_t xsdfec_ndevs = ATOMIC_INIT(0);
+static dev_t xsdfec_devt;
+
+/**
+ * struct xsdfec_dev - Driver data for SDFEC
+ * @regs: device physical base address
+ * @dev: pointer to device struct
+ * @config: Configuration of the SDFEC device
+ * @open_count: Count of char device being opened
+ * @xsdfec_cdev: Character device handle
+ * @irq_lock: Driver spinlock
+ *
+ * This structure contains necessary state for SDFEC driver to operate
+ */
+struct xsdfec_dev {
+	void __iomem *regs;
+	struct device *dev;
+	struct xsdfec_config config;
+	atomic_t open_count;
+	struct cdev xsdfec_cdev;
+	/* Spinlock to protect state_updated and stats_updated */
+	spinlock_t irq_lock;
+};
+
+static const struct file_operations xsdfec_fops = {
+	.owner = THIS_MODULE,
+};
+
+static int xsdfec_probe(struct platform_device *pdev)
+{
+	struct xsdfec_dev *xsdfec;
+	struct device *dev;
+	struct device *dev_create;
+	struct resource *res;
+	int err;
+
+	xsdfec = devm_kzalloc(&pdev->dev, sizeof(*xsdfec), GFP_KERNEL);
+	if (!xsdfec)
+		return -ENOMEM;
+
+	xsdfec->dev = &pdev->dev;
+	xsdfec->config.fec_id = atomic_read(&xsdfec_ndevs);
+	spin_lock_init(&xsdfec->irq_lock);
+
+	dev = xsdfec->dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xsdfec->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(xsdfec->regs)) {
+		dev_err(dev, "Unable to map resource");
+		err = PTR_ERR(xsdfec->regs);
+		goto err_xsdfec_dev;
+	}
+
+	/* Save driver private data */
+	platform_set_drvdata(pdev, xsdfec);
+
+	cdev_init(&xsdfec->xsdfec_cdev, &xsdfec_fops);
+	xsdfec->xsdfec_cdev.owner = THIS_MODULE;
+	err = cdev_add(&xsdfec->xsdfec_cdev,
+		       MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_id), 1);
+	if (err < 0) {
+		dev_err(dev, "cdev_add failed");
+		err = -EIO;
+		goto err_xsdfec_dev;
+	}
+
+	if (!xsdfec_class) {
+		err = -EIO;
+		dev_err(dev, "xsdfec class not created correctly");
+		goto err_xsdfec_cdev;
+	}
+
+	dev_create =
+		device_create(xsdfec_class, dev,
+			      MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_id),
+			      xsdfec, "xsdfec%d", xsdfec->config.fec_id);
+	if (IS_ERR(dev_create)) {
+		dev_err(dev, "unable to create device");
+		err = PTR_ERR(dev_create);
+		goto err_xsdfec_cdev;
+	}
+
+	atomic_set(&xsdfec->open_count, 1);
+	dev_info(dev, "XSDFEC%d Probe Successful", xsdfec->config.fec_id);
+	atomic_inc(&xsdfec_ndevs);
+	return 0;
+
+	/* Failure cleanup */
+err_xsdfec_cdev:
+	cdev_del(&xsdfec->xsdfec_cdev);
+err_xsdfec_dev:
+	return err;
+}
+
+static int xsdfec_remove(struct platform_device *pdev)
+{
+	struct xsdfec_dev *xsdfec;
+	struct device *dev = &pdev->dev;
+
+	xsdfec = platform_get_drvdata(pdev);
+	if (!xsdfec)
+		return -ENODEV;
+
+	if (!xsdfec_class) {
+		dev_err(dev, "xsdfec_class is NULL");
+		return -EIO;
+	}
+
+	device_destroy(xsdfec_class,
+		       MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_id));
+	cdev_del(&xsdfec->xsdfec_cdev);
+	atomic_dec(&xsdfec_ndevs);
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
+static int __init xsdfec_init_mod(void)
+{
+	int err;
+
+	xsdfec_class = class_create(THIS_MODULE, DRIVER_NAME);
+	if (IS_ERR(xsdfec_class)) {
+		err = PTR_ERR(xsdfec_class);
+		pr_err("%s : Unable to register xsdfec class", __func__);
+		return err;
+	}
+
+	err = alloc_chrdev_region(&xsdfec_devt, 0, DRIVER_MAX_DEV, DRIVER_NAME);
+	if (err < 0) {
+		pr_err("%s : Unable to get major number", __func__);
+		goto err_xsdfec_class;
+	}
+
+	err = platform_driver_register(&xsdfec_driver);
+	if (err < 0) {
+		pr_err("%s Unabled to register %s driver", __func__,
+		       DRIVER_NAME);
+		goto err_xsdfec_drv;
+	}
+	return 0;
+
+	/* Error Path */
+err_xsdfec_drv:
+	unregister_chrdev_region(xsdfec_devt, DRIVER_MAX_DEV);
+err_xsdfec_class:
+	class_destroy(xsdfec_class);
+	return err;
+}
+
+static void __exit xsdfec_cleanup_mod(void)
+{
+	platform_driver_unregister(&xsdfec_driver);
+	unregister_chrdev_region(xsdfec_devt, DRIVER_MAX_DEV);
+	class_destroy(xsdfec_class);
+	xsdfec_class = NULL;
+}
+
+module_init(xsdfec_init_mod);
+module_exit(xsdfec_cleanup_mod);
+
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx SD-FEC16 Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRIVER_VERSION);
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
new file mode 100644
index 0000000..5543163
--- /dev/null
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Xilinx SD-FEC
+ *
+ * Copyright (C) 2016 - 2017 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for SDFEC16 IP. It provides a char device
+ * in sysfs and supports file operations like open(), close() and ioctl().
+ */
+#ifndef __XILINX_SDFEC_H__
+#define __XILINX_SDFEC_H__
+
+/**
+ * enum xsdfec_state - State.
+ * @XSDFEC_INIT: Driver is initialized.
+ * @XSDFEC_STARTED: Driver is started.
+ * @XSDFEC_STOPPED: Driver is stopped.
+ * @XSDFEC_NEEDS_RESET: Driver needs to be reset.
+ * @XSDFEC_PL_RECONFIGURE: Programmable Logic needs to be recofigured.
+ *
+ * This enum is used to indicate the state of the driver.
+ */
+enum xsdfec_state {
+	XSDFEC_INIT = 0,
+	XSDFEC_STARTED,
+	XSDFEC_STOPPED,
+	XSDFEC_NEEDS_RESET,
+	XSDFEC_PL_RECONFIGURE,
+};
+
+/**
+ * struct xsdfec_config - Configuration of SD-FEC core.
+ * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
+ *          SD-FEC's in the FPGA and is related to the driver instance
+ *          Minor number.
+ */
+struct xsdfec_config {
+	s32 fec_id;
+};
+
+#endif /* __XILINX_SDFEC_H__ */
-- 
2.7.4

