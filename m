Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E222075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rzKrLaD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfCZTQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:16:25 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:29966
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731973AbfCZTQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GEAKUPkmcHNQuhyAEfPTMtjxcotImzzYKOIbpnZmpw=;
 b=rzKrLaD0RfcYWYwpmAYstch5rnQnF/DmQiKrfwzIbXef4PbazlYM2Lm0koyygn5UFivb0wdexE7N7O2BvjVUHHw4s4pGsAhzVVX98WYToBQ2ny9EUYO2WbDW6XIoh7GY7uAdtsNcSkvlvN0DUVPqMTbQATmJia76spN0fAcuN7s=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3535.eurprd04.prod.outlook.com (52.134.4.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 19:16:19 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::f808:5ebf:a573:3ea1]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::f808:5ebf:a573:3ea1%8]) with mapi id 15.20.1750.014; Tue, 26 Mar 2019
 19:16:19 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH] soc: fsl: add DPAA2 console support
Thread-Topic: [PATCH] soc: fsl: add DPAA2 console support
Thread-Index: AQHU5AhknrBzPfGcyEqu6n1s2eiIeg==
Date:   Tue, 26 Mar 2019 19:16:19 +0000
Message-ID: <1553627718-23714-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::16) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb594b6a-2696-43aa-135e-08d6b21f864f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3535;
x-ms-traffictypediagnostic: VI1PR0402MB3535:
x-microsoft-antispam-prvs: <VI1PR0402MB3535CB04B654C9D9C964AFF5E05F0@VI1PR0402MB3535.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(189003)(199004)(25786009)(36756003)(486006)(316002)(5660300002)(52116002)(6636002)(71190400001)(71200400001)(14454004)(6486002)(6436002)(3846002)(476003)(86362001)(99286004)(478600001)(54906003)(7736002)(37006003)(2906002)(66066001)(8676002)(81156014)(6116002)(305945005)(44832011)(2616005)(8936002)(106356001)(81166006)(102836004)(105586002)(6506007)(386003)(26005)(6862004)(6512007)(68736007)(53936002)(4326008)(256004)(97736004)(14444005)(50226002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3535;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ro8hLBgKp+hy4c2ueo73th2yzLrFQj8/PmN7jPByXO1lLY/6oWsOKRr0XjaJgppLHheh7NZXABZuo+MaFecNFsKraPsYIEzQ3YIW/zkA1GsvcbH22niJO/OA2mUdBhK/c31Dmp9YChyRAw1PQ8j94Pr9aP79s1eI2/2uOe4Ze6JEJAAPk2Q3s0uV1JY1cxiYTKvuqxvAUAoKtE8vyZC5zYSl4jc73kVPMkK7UY2T3mUlIGjGZisW531MCX3o7ak3M4jaHeWvTWu6iMcseymcmGBY/B38Pss2+3Ru2T1WBHBSf5UrHMVjm+69PSyGWNlyXp9J1O0HWvRqYLGAiGsiv2k3ICh4G4UleWvviZejQrfyBgXn0BWBPerGRGhRmylx1u4/S4fz93p4RApZWsppX3LYypT/ZtbulrQi4WgOFzg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb594b6a-2696-43aa-135e-08d6b21f864f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 19:16:19.0556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3535
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DPAA2 MC and AIOP console log support.

The platform driver probes on the "fsl,dpaa2-console" device tree node
which describes the base firmware address needed in order to infer the
start address of both firmware logs: MC and AIOP.
It then exports two misc char devices which can be used to dump
the needed logs.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/Kconfig         |  10 ++
 drivers/soc/fsl/Makefile        |   1 +
 drivers/soc/fsl/dpaa2-console.c | 306 ++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 317 insertions(+)
 create mode 100644 drivers/soc/fsl/dpaa2-console.c

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 61f8e1433d0a..9fe8222c3968 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -29,4 +29,14 @@ config FSL_MC_DPIO
 	  other DPAA2 objects. This driver does not expose the DPIO
 	  objects individually, but groups them under a service layer
 	  API.
+
+config DPAA2_CONSOLE
+	tristate "QorIQ DPAA2 console driver"
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X8=
6_LOCAL_APIC || PPC)))
+	default y
+	help
+	  Console driver for DPAA2 platforms. Exports 2 char devices,
+	  /dev/dpaa2_mc_console and /dev/dpaa2_aiop_console,
+	  which can be used to dump the Management Complex and AIOP
+	  firmware logs.
 endmenu
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 803ef1bfb5ff..57762c9fc7da 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/
 obj-$(CONFIG_CPM)			+=3D qe/
 obj-$(CONFIG_FSL_GUTS)			+=3D guts.o
 obj-$(CONFIG_FSL_MC_DPIO) 		+=3D dpio/
+obj-$(CONFIG_DPAA2_CONSOLE)		+=3D dpaa2-console.o
diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-consol=
e.c
new file mode 100644
index 000000000000..21a5e121f87b
--- /dev/null
+++ b/drivers/soc/fsl/dpaa2-console.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2015-2016 Freescale Semiconductor Inc.
+ * Copyright 2018 NXP
+ */
+
+#define pr_fmt(fmt) "dpaa2-console: " fmt
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Roy Pledge <roy.pledge@nxp.com>");
+MODULE_DESCRIPTION("DPAA2 console driver");
+
+/* MC firmware base low/high registers indexes */
+#define MCFBALR_OFFSET 0
+#define MCFBAHR_OFFSET 1
+
+/* Bit masks used to get the most/least significant part of the MC base ad=
dr */
+#define MC_FW_ADDR_MASK_HIGH 0x1FFFF
+#define MC_FW_ADDR_MASK_LOW  0xE0000000
+
+#define MC_BUFFER_OFFSET 0x01000000
+#define MC_BUFFER_SIZE   (1024 * 1024 * 16)
+#define MC_OFFSET_DELTA  MC_BUFFER_OFFSET
+
+#define AIOP_BUFFER_OFFSET 0x06000000
+#define AIOP_BUFFER_SIZE   (1024 * 1024 * 16)
+#define AIOP_OFFSET_DELTA  0
+
+#define LOG_HEADER_FLAG_BUFFER_WRAPAROUND 0x80000000
+#define LAST_BYTE(a) ((a) & ~(LOG_HEADER_FLAG_BUFFER_WRAPAROUND))
+
+/* MC and AIOP Magic words */
+#define MAGIC_MC   0x4d430100
+#define MAGIC_AIOP 0x41494F50
+
+struct log_header {
+	__le32 magic_word;
+	char reserved[4];
+	__le32 buf_start;
+	__le32 buf_length;
+	__le32 last_byte;
+};
+
+struct console_data {
+	char *map_addr;
+	struct log_header *hdr;
+	char *start_addr;
+	char *end_addr;
+	char *end_of_data;
+	char *cur_ptr;
+};
+
+struct resource mc_base_addr;
+
+static inline void adjust_end(struct console_data *cd)
+{
+	u32 last_byte =3D readl(&cd->hdr->last_byte);
+
+	cd->end_of_data =3D cd->start_addr + LAST_BYTE(last_byte);
+}
+
+static u64 get_mc_fw_base_address(void)
+{
+	u64 mcfwbase =3D 0ULL;
+	u32 *mcfbaregs;
+
+	mcfbaregs =3D (u32 *)ioremap(mc_base_addr.start,
+				   resource_size(&mc_base_addr));
+	if (!mcfbaregs) {
+		pr_err("could not map MC Firmaware Base registers\n");
+		return -EIO;
+	}
+
+	mcfwbase  =3D readl(mcfbaregs + MCFBAHR_OFFSET) & MC_FW_ADDR_MASK_HIGH;
+	mcfwbase <<=3D 32;
+	mcfwbase |=3D readl(mcfbaregs + MCFBALR_OFFSET) & MC_FW_ADDR_MASK_LOW;
+	iounmap(mcfbaregs);
+
+	pr_debug("MC base address at 0x%016llx\n", mcfwbase);
+	return mcfwbase;
+}
+
+static ssize_t dpaa2_console_size(struct console_data *cd)
+{
+	ssize_t size;
+
+	if (cd->cur_ptr <=3D cd->end_of_data)
+		size =3D cd->end_of_data - cd->cur_ptr;
+	else
+		size =3D (cd->end_addr - cd->cur_ptr) +
+			(cd->end_of_data - cd->start_addr);
+
+	return size;
+}
+
+static int dpaa2_generic_console_open(struct inode *node, struct file *fp,
+				      u64 offset, u64 size,
+				      u32 expected_magic,
+				      u32 offset_delta)
+{
+	u32 read_magic, wrapped, last_byte, buf_start, buf_length;
+	struct console_data *cd;
+	u64 base_addr;
+	int err;
+
+	cd =3D kmalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	base_addr =3D get_mc_fw_base_address();
+	if (base_addr < 0)
+		return -EIO;
+
+	cd->map_addr =3D ioremap(base_addr + offset, size);
+	if (!cd->map_addr) {
+		pr_err("cannot map console log memory\n");
+		err =3D -EIO;
+		goto err_ioremap;
+	}
+
+	cd->hdr =3D (struct log_header *)cd->map_addr;
+	read_magic =3D readl(&cd->hdr->magic_word);
+	last_byte =3D readl(&cd->hdr->last_byte);
+	buf_start =3D readl(&cd->hdr->buf_start);
+	buf_length =3D readl(&cd->hdr->buf_length);
+
+	if (read_magic !=3D expected_magic) {
+		pr_warn("expected =3D %08x, read =3D %08x\n",
+			expected_magic, read_magic);
+		err =3D -EIO;
+		goto err_magic;
+	}
+
+	cd->start_addr =3D cd->map_addr + buf_start - offset_delta;
+	cd->end_addr =3D cd->start_addr + buf_length;
+
+	wrapped =3D last_byte & LOG_HEADER_FLAG_BUFFER_WRAPAROUND;
+
+	adjust_end(cd);
+	if (wrapped && cd->end_of_data !=3D cd->end_addr)
+		cd->cur_ptr =3D cd->end_of_data + 1;
+	else
+		cd->cur_ptr =3D cd->start_addr;
+
+	fp->private_data =3D cd;
+
+	return 0;
+
+err_magic:
+	iounmap(cd->map_addr);
+
+err_ioremap:
+	kfree(cd);
+
+	return err;
+}
+
+static int dpaa2_mc_console_open(struct inode *node, struct file *fp)
+{
+	return dpaa2_generic_console_open(node, fp,
+					  MC_BUFFER_OFFSET, MC_BUFFER_SIZE,
+					  MAGIC_MC, MC_OFFSET_DELTA);
+}
+
+static int dpaa2_aiop_console_open(struct inode *node, struct file *fp)
+{
+	return dpaa2_generic_console_open(node, fp,
+					  AIOP_BUFFER_OFFSET, AIOP_BUFFER_SIZE,
+					  MAGIC_AIOP, AIOP_OFFSET_DELTA);
+}
+
+static int dpaa2_console_close(struct inode *node, struct file *fp)
+{
+	struct console_data *cd =3D fp->private_data;
+
+	iounmap(cd->map_addr);
+	kfree(cd);
+	return 0;
+}
+
+static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,
+				  size_t count, loff_t *f_pos)
+{
+	struct console_data *cd =3D fp->private_data;
+	size_t bytes =3D dpaa2_console_size(cd);
+	size_t bytes_end =3D cd->end_addr - cd->cur_ptr;
+	size_t written =3D 0;
+
+	/* Check if we need to adjust the end of data addr */
+	adjust_end(cd);
+
+	if (cd->end_of_data =3D=3D cd->cur_ptr)
+		return 0;
+
+	if (count < bytes)
+		bytes =3D count;
+
+	if (bytes > bytes_end) {
+		if (copy_to_user(buf, cd->cur_ptr, bytes_end))
+			return -EFAULT;
+		buf +=3D bytes_end;
+		cd->cur_ptr =3D cd->start_addr;
+		bytes -=3D bytes_end;
+		written +=3D bytes_end;
+	}
+
+	if (copy_to_user(buf, cd->cur_ptr, bytes))
+		return -EFAULT;
+	cd->cur_ptr +=3D bytes;
+	written +=3D bytes;
+
+	return written;
+}
+
+static const struct file_operations dpaa2_mc_console_fops =3D {
+	.owner          =3D THIS_MODULE,
+	.open           =3D dpaa2_mc_console_open,
+	.release        =3D dpaa2_console_close,
+	.read           =3D dpaa2_console_read,
+};
+
+static struct miscdevice dpaa2_mc_console_dev =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name =3D "dpaa2_mc_console",
+	.fops =3D &dpaa2_mc_console_fops
+};
+
+static const struct file_operations dpaa2_aiop_console_fops =3D {
+	.owner          =3D THIS_MODULE,
+	.open           =3D dpaa2_aiop_console_open,
+	.release        =3D dpaa2_console_close,
+	.read           =3D dpaa2_console_read,
+};
+
+static struct miscdevice dpaa2_aiop_console_dev =3D {
+	.minor =3D MISC_DYNAMIC_MINOR,
+	.name =3D "dpaa2_aiop_console",
+	.fops =3D &dpaa2_aiop_console_fops
+};
+
+static int dpaa2_console_probe(struct platform_device *pdev)
+{
+	int error;
+
+	error =3D of_address_to_resource(pdev->dev.of_node, 0, &mc_base_addr);
+	if (error < 0) {
+		pr_err("of_address_to_resource() failed for %pOF with %d\n",
+		       pdev->dev.of_node, error);
+		return error;
+	}
+
+	error =3D misc_register(&dpaa2_mc_console_dev);
+	if (error) {
+		pr_err("dpaa2-console: cannot register device %s\n",
+		       dpaa2_mc_console_dev.name);
+		goto err_register_mc;
+	}
+
+	error =3D misc_register(&dpaa2_aiop_console_dev);
+	if (error) {
+		pr_err("dpaa2-console: cannot register device %s\n",
+		       dpaa2_aiop_console_dev.name);
+		goto err_register_aiop;
+	}
+
+	return 0;
+
+err_register_aiop:
+	misc_deregister(&dpaa2_mc_console_dev);
+err_register_mc:
+	return error;
+}
+
+static int dpaa2_console_remove(struct platform_device *pdev)
+{
+	misc_deregister(&dpaa2_mc_console_dev);
+	misc_deregister(&dpaa2_aiop_console_dev);
+
+	return 0;
+}
+
+static const struct of_device_id dpaa2_console_match_table[] =3D {
+	{ .compatible =3D "fsl,dpaa2-console",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, dpaa2_console_match_table);
+
+static struct platform_driver dpaa2_console_driver =3D {
+	.driver =3D {
+		   .name =3D "dpaa2-console",
+		   .pm =3D NULL,
+		   .of_match_table =3D dpaa2_console_match_table,
+		   },
+	.probe =3D dpaa2_console_probe,
+	.remove =3D dpaa2_console_remove,
+};
+module_platform_driver(dpaa2_console_driver);
--=20
1.9.1

