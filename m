Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E541C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7672147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ioS5YoEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfCSMFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:05:34 -0400
Received: from mail-eopbgr700061.outbound.protection.outlook.com ([40.107.70.61]:46688
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbfCSMEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vZC+wH5XY0iuooQoC2gZ1MKPXL9lpkiyAxqwiW30M8=;
 b=ioS5YoEBncr9VCll3+Ykn4odTaXXxWDnbFq1GrtxJqj/sbtUztj0h6P2/iHsqjGxPR8NrXS4dgrjW4xB5pk3aGSR5HaZNk8xR8sJX+G/8ivcm3TU9TDDOxl6EQYmz7nczjIHTa23plO0ndnILnsNhG+sV1jzVEyOLy5VDHWX2Sk=
Received: from SN6PR02CA0036.namprd02.prod.outlook.com (2603:10b6:805:a2::49)
 by SN6PR02MB5552.namprd02.prod.outlook.com (2603:10b6:805:e8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 12:04:35 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by SN6PR02CA0036.outlook.office365.com
 (2603:10b6:805:a2::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:35 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:33 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:33 +0000
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=43674 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1h6DTt-0003Ch-EX; Tue, 19 Mar 2019 12:04:33 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 02/12] misc: xilinx-sdfec: add core driver
Date:   Tue, 19 Mar 2019 12:04:14 +0000
Message-ID: <1552997064-432700-3-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(110136005)(48376002)(54906003)(486006)(44832011)(4326008)(51416003)(8676002)(356004)(6666004)(106002)(107886003)(5660300002)(50466002)(93146003)(14444005)(336012)(2616005)(106466001)(11346002)(28376004)(956004)(126002)(476003)(186003)(426003)(446003)(36756003)(7696005)(76176011)(5024004)(36906005)(316002)(26005)(50226002)(2906002)(246002)(47776003)(71366001)(8746002)(478600001)(2201001)(7636002)(9786002)(26826003)(60926002)(8936002)(305945005)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5552;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3ef7696-e010-47c5-91a4-08d6ac630e06
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB5552;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5552:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB55528D8BB14D515F06D2A106CB400@SN6PR02MB5552.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: j7molkt71flHVJ5co4hW+ohUsT5mRFnDq6lEOIFKJVYPEh5tLvp0xLGMOF8xsdeDchGZ17MN9a9lDay8Q7JOdQAjSzVtc+3uk0QVCsyfOHq2xIHBUlpbVRob4SReR3aLXGQbk+YFfnZ/3KO56tQSyQNCAxZ4BFWCNCH9Dm+4kHm+LWTTYP+I5WrEEay+q5nCUEtf4pm9bCG562E8aons/gYvOcuIXQqlee+3DDR4q4Frv8eZaa0vDQsN7EgtCBFWFmTnNNMcArelyaPdl5fLhUhsQ64+LuyvGcdh0skOf6vji2rSk6vL7Dxu1oGdjUj6GKyH2jiM2O5tjwOy5/N5tKep8AvLTlPA/eeSL7QJYA4/bIOTpKPox/EYKIfjub+XtG9f8hInG2riuaTiPYNU+rwZ3wkdQslDOxaqQl8qnSs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:35.2822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ef7696-e010-47c5-91a4-08d6ac630e06
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5552
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

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/Kconfig             |  12 +++
 drivers/misc/Makefile            |   1 +
 drivers/misc/xilinx_sdfec.c      | 215 +++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h |  42 ++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 drivers/misc/xilinx_sdfec.c
 create mode 100644 include/uapi/misc/xilinx_sdfec.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec..bbb868f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -520,6 +520,18 @@ config PCI_ENDPOINT_TEST
            Enable this configuration option to enable the host side test d=
river
            for PCI Endpoint.

+config XILINX_SDFEC
+       tristate "Xilinx SDFEC 16"
+       help
+         This option enables support for the Xilinx SDFEC (Soft Decision
+         Forward Error Correction) driver. This enables a char driver
+         for the SDFEC.
+
+         You may select this driver if your design instantiates the
+         SDFEC(16nm) hardened block. To compile this as a module choose M.
+
+         If unsure, say N.
+
 config MISC_RTSX
        tristate
        default MISC_RTSX_PCI || MISC_RTSX_USB
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d5b7d34..08f0906 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_VMWARE_VMCI)     +=3D vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)      +=3D lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)             +=3D sram.o
 obj-$(CONFIG_SRAM_EXEC)                +=3D sram-exec.o
+obj-$(CONFIG_XILINX_SDFEC)     +=3D xilinx_sdfec.o
 obj-y                          +=3D mic/
 obj-$(CONFIG_GENWQE)           +=3D genwqe/
 obj-$(CONFIG_ECHO)             +=3D echo/
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
+static atomic_t xsdfec_ndevs =3D ATOMIC_INIT(0);
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
+       void __iomem *regs;
+       struct device *dev;
+       struct xsdfec_config config;
+       atomic_t open_count;
+       struct cdev xsdfec_cdev;
+       /* Spinlock to protect state_updated and stats_updated */
+       spinlock_t irq_lock;
+};
+
+static const struct file_operations xsdfec_fops =3D {
+       .owner =3D THIS_MODULE,
+};
+
+static int xsdfec_probe(struct platform_device *pdev)
+{
+       struct xsdfec_dev *xsdfec;
+       struct device *dev;
+       struct device *dev_create;
+       struct resource *res;
+       int err;
+
+       xsdfec =3D devm_kzalloc(&pdev->dev, sizeof(*xsdfec), GFP_KERNEL);
+       if (!xsdfec)
+               return -ENOMEM;
+
+       xsdfec->dev =3D &pdev->dev;
+       xsdfec->config.fec_id =3D atomic_read(&xsdfec_ndevs);
+       spin_lock_init(&xsdfec->irq_lock);
+
+       dev =3D xsdfec->dev;
+       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       xsdfec->regs =3D devm_ioremap_resource(dev, res);
+       if (IS_ERR(xsdfec->regs)) {
+               dev_err(dev, "Unable to map resource");
+               err =3D PTR_ERR(xsdfec->regs);
+               goto err_xsdfec_dev;
+       }
+
+       /* Save driver private data */
+       platform_set_drvdata(pdev, xsdfec);
+
+       cdev_init(&xsdfec->xsdfec_cdev, &xsdfec_fops);
+       xsdfec->xsdfec_cdev.owner =3D THIS_MODULE;
+       err =3D cdev_add(&xsdfec->xsdfec_cdev,
+                      MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_id), 1)=
;
+       if (err < 0) {
+               dev_err(dev, "cdev_add failed");
+               err =3D -EIO;
+               goto err_xsdfec_dev;
+       }
+
+       if (!xsdfec_class) {
+               err =3D -EIO;
+               dev_err(dev, "xsdfec class not created correctly");
+               goto err_xsdfec_cdev;
+       }
+
+       dev_create =3D
+               device_create(xsdfec_class, dev,
+                             MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_=
id),
+                             xsdfec, "xsdfec%d", xsdfec->config.fec_id);
+       if (IS_ERR(dev_create)) {
+               dev_err(dev, "unable to create device");
+               err =3D PTR_ERR(dev_create);
+               goto err_xsdfec_cdev;
+       }
+
+       atomic_set(&xsdfec->open_count, 1);
+       dev_info(dev, "XSDFEC%d Probe Successful", xsdfec->config.fec_id);
+       atomic_inc(&xsdfec_ndevs);
+       return 0;
+
+       /* Failure cleanup */
+err_xsdfec_cdev:
+       cdev_del(&xsdfec->xsdfec_cdev);
+err_xsdfec_dev:
+       return err;
+}
+
+static int xsdfec_remove(struct platform_device *pdev)
+{
+       struct xsdfec_dev *xsdfec;
+       struct device *dev =3D &pdev->dev;
+
+       xsdfec =3D platform_get_drvdata(pdev);
+       if (!xsdfec)
+               return -ENODEV;
+
+       if (!xsdfec_class) {
+               dev_err(dev, "xsdfec_class is NULL");
+               return -EIO;
+       }
+
+       device_destroy(xsdfec_class,
+                      MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_id));
+       cdev_del(&xsdfec->xsdfec_cdev);
+       atomic_dec(&xsdfec_ndevs);
+       return 0;
+}
+
+static const struct of_device_id xsdfec_of_match[] =3D {
+       {
+               .compatible =3D "xlnx,sd-fec-1.1",
+       },
+       { /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xsdfec_of_match);
+
+static struct platform_driver xsdfec_driver =3D {
+       .driver =3D {
+               .name =3D "xilinx-sdfec",
+               .of_match_table =3D xsdfec_of_match,
+       },
+       .probe =3D xsdfec_probe,
+       .remove =3D  xsdfec_remove,
+};
+
+static int __init xsdfec_init_mod(void)
+{
+       int err;
+
+       xsdfec_class =3D class_create(THIS_MODULE, DRIVER_NAME);
+       if (IS_ERR(xsdfec_class)) {
+               err =3D PTR_ERR(xsdfec_class);
+               pr_err("%s : Unable to register xsdfec class", __func__);
+               return err;
+       }
+
+       err =3D alloc_chrdev_region(&xsdfec_devt, 0, DRIVER_MAX_DEV, DRIVER=
_NAME);
+       if (err < 0) {
+               pr_err("%s : Unable to get major number", __func__);
+               goto err_xsdfec_class;
+       }
+
+       err =3D platform_driver_register(&xsdfec_driver);
+       if (err < 0) {
+               pr_err("%s Unabled to register %s driver", __func__,
+                      DRIVER_NAME);
+               goto err_xsdfec_drv;
+       }
+       return 0;
+
+       /* Error Path */
+err_xsdfec_drv:
+       unregister_chrdev_region(xsdfec_devt, DRIVER_MAX_DEV);
+err_xsdfec_class:
+       class_destroy(xsdfec_class);
+       return err;
+}
+
+static void __exit xsdfec_cleanup_mod(void)
+{
+       platform_driver_unregister(&xsdfec_driver);
+       unregister_chrdev_region(xsdfec_devt, DRIVER_MAX_DEV);
+       class_destroy(xsdfec_class);
+       xsdfec_class =3D NULL;
+}
+
+module_init(xsdfec_init_mod);
+module_exit(xsdfec_cleanup_mod);
+
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx SD-FEC16 Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRIVER_VERSION);
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
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
+       XSDFEC_INIT =3D 0,
+       XSDFEC_STARTED,
+       XSDFEC_STOPPED,
+       XSDFEC_NEEDS_RESET,
+       XSDFEC_PL_RECONFIGURE,
+};
+
+/**
+ * struct xsdfec_config - Configuration of SD-FEC core.
+ * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
+ *          SD-FEC's in the FPGA and is related to the driver instance
+ *          Minor number.
+ */
+struct xsdfec_config {
+       s32 fec_id;
+};
+
+#endif /* __XILINX_SDFEC_H__ */
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
