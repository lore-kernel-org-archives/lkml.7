Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BD321850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MAn0B37x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfB1HDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:03:04 -0500
Received: from mail-eopbgr810045.outbound.protection.outlook.com ([40.107.81.45]:28896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731136AbfB1HDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5SCvw/0IrpDBcybq17efOzbAmFzhV6Xubqp7EjTflo=;
 b=MAn0B37x9lF1ZA8KGpmXyPgz/LeN2IKO/4qjzaxxnRgppWTiB/Gv6SnriwsaNMxXPfPE8j8GFquXFWo8pvD3Pv0OtfBsTJGPuHx8nAsU8jWCpEemlNss174UGjS/EybaHDS3YrNDhNSG2XZqfgr1KJqagKI1M7rxBhz5tGtXtmQ=
Received: from DM6PR02CA0008.namprd02.prod.outlook.com (2603:10b6:5:1c::21) by
 CY4PR02MB2262.namprd02.prod.outlook.com (2603:10b6:903:9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 07:03:00 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by DM6PR02CA0008.outlook.office365.com
 (2603:10b6:5:1c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1665.15 via Frontend
 Transport; Thu, 28 Feb 2019 07:03:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1643.11
 via Frontend Transport; Thu, 28 Feb 2019 07:02:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41005 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gzFid-0005Wt-Et; Wed, 27 Feb 2019 23:02:59 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gzFiY-0005DF-Bv; Wed, 27 Feb 2019 23:02:54 -0800
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gzFiQ-00059x-Ax; Wed, 27 Feb 2019 23:02:47 -0800
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <broonie@kernel.org>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <dwmw2@infradead.org>,
        <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [RFC PATCH 2/2] spi: spi-mem: Add support for Zynq QSPI controller
Date:   Thu, 28 Feb 2019 12:32:41 +0530
Message-ID: <1551337361-11665-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(189003)(199004)(426003)(126002)(2616005)(106002)(4326008)(36756003)(2906002)(81156014)(356004)(6666004)(81166006)(486006)(107886003)(110136005)(9786002)(50226002)(30864003)(476003)(14444005)(5660300002)(36386004)(54906003)(8936002)(47776003)(26005)(16586007)(336012)(316002)(50466002)(77096007)(48376002)(51416003)(478600001)(106466001)(186003)(63266004)(7696005)(8676002)(305945005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2262;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42dbe99f-cd62-4417-cb27-08d69d4ac68d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2262;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2262:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2262;20:ksRnSXOAEKNfMcK1c7ndTuPv7kocwZW5UcU0a9I9qz4c+W1GkWyoZTpV1NiDKbjD+WmCKngdy2SfqNrI4x6903jeKi/HLwzp3yCpxicwiU4aXnUP/31FQLS5wUmPHNGOIfWcsRtSjQ6xWcnXOKm8L4Z2Fqo2GDmzAoMfQErQYD+FvytccVgVZRqsveRiF6fvGh2dMWd78YmjiIg3OV0p3khI9bdQ/GfQcQJ+taj7Fm+j681TNqkp172XO5Hvl2pD8cLfpxMCvoZOd15/y6f0HXpdLP0yuW1iGy52OOxU9C9ABv0pBrIdbSQ9KRfBhByaaScQGS7ts7DclU1N9lHJOj1YC3GVhlZ7SWtLtWqCbBm3t5KKGOD1bDZ8XIME4HOE1gbvVvmFW9Gftp+Jj6XAtHxncxUMZjad05Pz62FMVvlzXJkBBKVYbxMoaCoZMoegXfqRXOByvloyjWszBgsTKJJRPFjgwB45WvcoxvSR6iqk/3uq8wDP/84pwb0CgjQp
X-Microsoft-Antispam-PRVS: <CY4PR02MB226249DB7AC5AA7E626F02C2AF750@CY4PR02MB2262.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0962D394D2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2262;23:zIvoJTIIVDTZnv3B+Z6smwFc6qyah+OCGNxomCwr1?=
 =?us-ascii?Q?JoQuXcG8SGBFlmTk/BhKOswwdkvkQALf7NDlSPNMyC/MFF2DNDLWmFCqh7ns?=
 =?us-ascii?Q?8A2SkZZXNXAqfx3H4EBJLOm+DTPN5ZANxHOM17Fc2vDVe+Tkg1DTadtulpdH?=
 =?us-ascii?Q?04yYRUbwECKz8gCnnkPmz8IzF0HXKA9nAco+OE3d/1kxLfqz8RmHVHL/oOOy?=
 =?us-ascii?Q?/GSiRdXDJLSkjU4lB02ClJsuZsn1EZ8RncLrXXU0+piQ8CR6fG2SivGs9YXf?=
 =?us-ascii?Q?clCaatey23r3+VExY6Kc0TMJzh4MmV34ch1Acd7VIILzlc20UqupD/+UUoMQ?=
 =?us-ascii?Q?wPmcvZogANrMef5gHk9vMZKq/29PhNUeJ/QMLyftv3tVZgrnslqHrRMyzJ1P?=
 =?us-ascii?Q?tYwN2YvcpnavxJOYj9CwnvmdhllEbHamIV5yZRcIOJu8eUDFprkRQK56/tcL?=
 =?us-ascii?Q?9U6EiOum7f/3VRwEM1lx5kyq4Ie0wcP+5yU9JZ4mtEHmh1j0OyAM5mD9a+Yd?=
 =?us-ascii?Q?m5vbDI4p1ASUKafbSpL4JSzSce3B2auET7Zxj26d9Sz3Bjfz7UdVjiyJJcH4?=
 =?us-ascii?Q?F4eXyj9iP2s3ot14mKAxzXl+8axdGEBZaG/J0AUDRgD5zOzqpcxRkMUvTzR0?=
 =?us-ascii?Q?nvxTQvKlR8vNzQQWhc04mpMiXg3raCmIyeJh+zPqogXIH8ab4MFkmYASwYvw?=
 =?us-ascii?Q?NEbH4DsPl4ozzg3vzardlOeiTOa06M1ao39kBZpDkoa1V9S4gB1B7UithVeJ?=
 =?us-ascii?Q?ENEhyJAum8A533qTuvADpIqdI4yxaMxlLSF0uswo805ngJ7VBrUNr30d/jxV?=
 =?us-ascii?Q?ybOng8VWP9/4KjsThiZrMN+Yb0ST36f4JhMhLo6hP4elgAcXlhRhk5K6LFU5?=
 =?us-ascii?Q?tUG79/FOm114p4+3gdbAZ2cuGTZIeEY4LXlhCkhYarY3n+JohcqS2akua7gE?=
 =?us-ascii?Q?3vqn8PzlGL3Nuz75RwXXKRBaurE5ohMAorqueLtDw7t+3mLsVRDfnktQlrBC?=
 =?us-ascii?Q?UZuCRFXNnmYndaV828t07KYV4Oi12KnWljmv3CSFeGyQs1wpEhWmbroeoVg5?=
 =?us-ascii?Q?3tfKa1O6BGe7EzaH3bO0DbUcAweoIzSGpZFWs98lkp6l1bSSQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: avnYVBI1hdKE8q2uV7o7bCvmzM1Gp8Kgal18zYqLBQB5EZbsBC9x7l65xl0mP2psIQttcDqgObc4pV2c/IfHe3MmnyKqzkTvSOoKn9zQtZAuTII/uML2Ge55QMY7hAojt8FfJqG6MZD0X1lfFPE6CIjeAo4GGldPCg8c0A4ntOLWDFj1/D5WRi2J8iLr8rwGevD4y3hYnmt493xkZ3kFvbZdcCQQQsgfQvFgd0LzjqxT3pz7sauhbxj2Xaf5iVm+Syc7aAueJ5GI9z+r6uLfv6dY5bf7m3dns3foKDbpJVdJfdF+K1wftj9f4zn/lR15vIszy5pn97qk9tf62T3VnDLzf+607kaS4hcwROe9d7AdJPMOPqJrKGIOtZhPyKm9wAmJcbdGrjaR89WioEjR8UKhiDyKeScXWfpwuk8ckVk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2019 07:02:59.8980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dbe99f-cd62-4417-cb27-08d69d4ac68d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for QSPI controller driver used by Xilinx Zynq SOC.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
 drivers/spi/Kconfig         |   8 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-zynq-qspi.c | 780 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 789 insertions(+)
 create mode 100644 drivers/spi/spi-zynq-qspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f89cb1..f12c880 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -816,6 +816,14 @@ config SPI_XTENSA_XTFPGA
 	  16 bit words in SPI mode 0, automatically asserting CS on transfer
 	  start and deasserting on end.
 
+config SPI_ZYNQ_QSPI
+	tristate "Xilinx Zynq QSPI controller"
+	depends on ARCH_ZYNQ
+	help
+	  This enables support for the Zynq Quad SPI controller
+	  in master mode.
+	  This controller only supports SPI memory interface.
+
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
 	depends on SPI_MASTER && HAS_DMA
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index f296270..565db4d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
+obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 
 # SPI slave protocol handlers
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
new file mode 100644
index 0000000..87c9ec2
--- /dev/null
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -0,0 +1,780 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Xilinx, Inc.
+ *
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/workqueue.h>
+#include <linux/spi/spi-mem.h>
+
+/* Register offset definitions */
+#define ZYNQ_QSPI_CONFIG_OFFSET		0x00 /* Configuration  Register, RW */
+#define ZYNQ_QSPI_STATUS_OFFSET		0x04 /* Interrupt Status Register, RO */
+#define ZYNQ_QSPI_IEN_OFFSET		0x08 /* Interrupt Enable Register, WO */
+#define ZYNQ_QSPI_IDIS_OFFSET		0x0C /* Interrupt Disable Reg, WO */
+#define ZYNQ_QSPI_IMASK_OFFSET		0x10 /* Interrupt Enabled Mask Reg,RO */
+#define ZYNQ_QSPI_ENABLE_OFFSET		0x14 /* Enable/Disable Register, RW */
+#define ZYNQ_QSPI_DELAY_OFFSET		0x18 /* Delay Register, RW */
+#define ZYNQ_QSPI_TXD_00_00_OFFSET	0x1C /* Transmit 4-byte inst, WO */
+#define ZYNQ_QSPI_TXD_00_01_OFFSET	0x80 /* Transmit 1-byte inst, WO */
+#define ZYNQ_QSPI_TXD_00_10_OFFSET	0x84 /* Transmit 2-byte inst, WO */
+#define ZYNQ_QSPI_TXD_00_11_OFFSET	0x88 /* Transmit 3-byte inst, WO */
+#define ZYNQ_QSPI_RXD_OFFSET		0x20 /* Data Receive Register, RO */
+#define ZYNQ_QSPI_SIC_OFFSET		0x24 /* Slave Idle Count Register, RW */
+#define ZYNQ_QSPI_TX_THRESH_OFFSET	0x28 /* TX FIFO Watermark Reg, RW */
+#define ZYNQ_QSPI_RX_THRESH_OFFSET	0x2C /* RX FIFO Watermark Reg, RW */
+#define ZYNQ_QSPI_GPIO_OFFSET		0x30 /* GPIO Register, RW */
+#define ZYNQ_QSPI_LINEAR_CFG_OFFSET	0xA0 /* Linear Adapter Config Ref, RW */
+#define ZYNQ_QSPI_MOD_ID_OFFSET		0xFC /* Module ID Register, RO */
+
+/*
+ * QSPI Configuration Register bit Masks
+ *
+ * This register contains various control bits that effect the operation
+ * of the QSPI controller
+ */
+#define ZYNQ_QSPI_CONFIG_IFMODE_MASK	0x80000000 /* Flash Memory Interface */
+#define ZYNQ_QSPI_CONFIG_MANSRT_MASK	0x00010000 /* Manual TX Start */
+#define ZYNQ_QSPI_CONFIG_MANSRTEN_MASK	0x00008000 /* Enable Manual TX Mode */
+#define ZYNQ_QSPI_CONFIG_SSFORCE_MASK	0x00004000 /* Manual Chip Select */
+#define ZYNQ_QSPI_CONFIG_BDRATE_MASK	0x00000038 /* Baud Rate Divisor Mask */
+#define ZYNQ_QSPI_CONFIG_CPHA_MASK	0x00000004 /* Clock Phase Control */
+#define ZYNQ_QSPI_CONFIG_CPOL_MASK	0x00000002 /* Clock Polarity Control */
+#define ZYNQ_QSPI_CONFIG_SSCTRL_MASK	0x00000400 /* Slave Select Mask */
+#define ZYNQ_QSPI_CONFIG_FWIDTH_MASK	0x000000C0 /* FIFO width */
+#define ZYNQ_QSPI_CONFIG_MSTREN_MASK	0x00000001 /* Master Mode */
+
+/*
+ * QSPI Configuration Register - Baud rate and slave select
+ *
+ * These are the values used in the calculation of baud rate divisor and
+ * setting the slave select.
+ */
+#define ZYNQ_QSPI_BAUD_DIV_MAX		7 /* Baud rate divisor maximum */
+#define ZYNQ_QSPI_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift in CR */
+#define ZYNQ_QSPI_SS_SHIFT		10 /* Slave Select field shift in CR */
+
+/*
+ * QSPI Interrupt Registers bit Masks
+ *
+ * All the four interrupt registers (Status/Mask/Enable/Disable) have the same
+ * bit definitions.
+ */
+#define ZYNQ_QSPI_IXR_RX_OVERFLOW_MASK	0x00000001 /* QSPI RX FIFO Overflow */
+#define ZYNQ_QSPI_IXR_TXNFULL_MASK	0x00000004 /* QSPI TX FIFO Overflow */
+#define ZYNQ_QSPI_IXR_TXFULL_MASK	0x00000008 /* QSPI TX FIFO is full */
+#define ZYNQ_QSPI_IXR_RXNEMTY_MASK	0x00000010 /* QSPI RX FIFO Not Empty */
+#define ZYNQ_QSPI_IXR_RXF_FULL_MASK	0x00000020 /* QSPI RX FIFO is full */
+#define ZYNQ_QSPI_IXR_TXF_UNDRFLOW_MASK	0x00000040 /* QSPI TX FIFO Underflow */
+#define ZYNQ_QSPI_IXR_ALL_MASK		(ZYNQ_QSPI_IXR_RX_OVERFLOW_MASK | \
+					ZYNQ_QSPI_IXR_TXNFULL_MASK | \
+					ZYNQ_QSPI_IXR_TXFULL_MASK | \
+					ZYNQ_QSPI_IXR_RXNEMTY_MASK | \
+					ZYNQ_QSPI_IXR_RXF_FULL_MASK | \
+					ZYNQ_QSPI_IXR_TXF_UNDRFLOW_MASK)
+#define ZYNQ_QSPI_IXR_RXTX_MASK		(ZYNQ_QSPI_IXR_TXNFULL_MASK | \
+					ZYNQ_QSPI_IXR_RXNEMTY_MASK)
+
+/*
+ * QSPI Enable Register bit Masks
+ *
+ * This register is used to enable or disable the QSPI controller
+ */
+#define ZYNQ_QSPI_ENABLE_ENABLE_MASK	0x00000001 /* QSPI Enable Bit Mask */
+
+/*
+ * QSPI Linear Configuration Register
+ *
+ * It is named Linear Configuration but it controls other modes when not in
+ * linear mode also.
+ */
+#define ZYNQ_QSPI_LCFG_TWO_MEM_MASK	0x40000000 /* LQSPI Two memories Mask */
+#define ZYNQ_QSPI_LCFG_SEP_BUS_MASK	0x20000000 /* LQSPI Separate bus Mask */
+#define ZYNQ_QSPI_LCFG_U_PAGE_MASK	0x10000000 /* LQSPI Upper Page Mask */
+
+#define ZYNQ_QSPI_LCFG_DUMMY_SHIFT	8
+
+#define ZYNQ_QSPI_FAST_READ_QOUT_CODE	0x6B /* read instruction code */
+#define ZYNQ_QSPI_FIFO_DEPTH		63 /* FIFO depth in words */
+#define ZYNQ_QSPI_RX_THRESHOLD		32 /* Rx FIFO threshold level */
+#define ZYNQ_QSPI_TX_THRESHOLD		1 /* Tx FIFO threshold level */
+
+/*
+ * The modebits configurable by the driver to make the SPI support different
+ * data formats
+ */
+#define MODEBITS			(SPI_CPOL | SPI_CPHA)
+
+/* Default number of chip selects */
+#define ZYNQ_QSPI_DEFAULT_NUM_CS	1
+
+/**
+ * struct zynq_qspi - Defines qspi driver instance
+ * @regs:		Virtual address of the QSPI controller registers
+ * @refclk:		Pointer to the peripheral clock
+ * @pclk:		Pointer to the APB clock
+ * @irq:		IRQ number
+ * @txbuf:		Pointer to the TX buffer
+ * @rxbuf:		Pointer to the RX buffer
+ * @tx_bytes:		Number of bytes left to transfer
+ * @rx_bytes:		Number of bytes left to receive
+ * @data_completion:	completion structure
+ */
+struct zynq_qspi {
+	struct device *dev;
+	void __iomem *regs;
+	struct clk *refclk;
+	struct clk *pclk;
+	int irq;
+	u8 *txbuf;
+	u8 *rxbuf;
+	int tx_bytes;
+	int rx_bytes;
+	struct completion data_completion;
+};
+
+/*
+ * Inline functions for the QSPI controller read/write
+ */
+static inline u32 zynq_qspi_read(struct zynq_qspi *xqspi, u32 offset)
+{
+	return readl_relaxed(xqspi->regs + offset);
+}
+
+static inline void zynq_qspi_write(struct zynq_qspi *xqspi, u32 offset,
+				   u32 val)
+{
+	writel_relaxed(val, xqspi->regs + offset);
+}
+
+/**
+ * zynq_qspi_init_hw - Initialize the hardware
+ * @xqspi:	Pointer to the zynq_qspi structure
+ *
+ * The default settings of the QSPI controller's configurable parameters on
+ * reset are
+ *	- Master mode
+ *	- Baud rate divisor is set to 2
+ *	- Tx threshold set to 1l Rx threshold set to 32
+ *	- Flash memory interface mode enabled
+ *	- Size of the word to be transferred as 8 bit
+ * This function performs the following actions
+ *	- Disable and clear all the interrupts
+ *	- Enable manual slave select
+ *	- Enable manual start
+ *	- Deselect all the chip select lines
+ *	- Set the size of the word to be transferred as 32 bit
+ *	- Set the little endian mode of TX FIFO and
+ *	- Enable the QSPI controller
+ */
+static void zynq_qspi_init_hw(struct zynq_qspi *xqspi)
+{
+	u32 config_reg;
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_IDIS_OFFSET, ZYNQ_QSPI_IXR_ALL_MASK);
+
+	/* Disable linear mode as the boot loader may have used it */
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_LINEAR_CFG_OFFSET, 0);
+
+	/* Clear the RX FIFO */
+	while (zynq_qspi_read(xqspi, ZYNQ_QSPI_STATUS_OFFSET) &
+			      ZYNQ_QSPI_IXR_RXNEMTY_MASK)
+		zynq_qspi_read(xqspi, ZYNQ_QSPI_RXD_OFFSET);
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_STATUS_OFFSET, ZYNQ_QSPI_IXR_ALL_MASK);
+	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
+	config_reg &= ~(ZYNQ_QSPI_CONFIG_MSTREN_MASK |
+			ZYNQ_QSPI_CONFIG_CPOL_MASK |
+			ZYNQ_QSPI_CONFIG_CPHA_MASK |
+			ZYNQ_QSPI_CONFIG_BDRATE_MASK |
+			ZYNQ_QSPI_CONFIG_SSFORCE_MASK |
+			ZYNQ_QSPI_CONFIG_MANSRTEN_MASK |
+			ZYNQ_QSPI_CONFIG_MANSRT_MASK);
+	config_reg |= (ZYNQ_QSPI_CONFIG_MSTREN_MASK |
+		       ZYNQ_QSPI_CONFIG_SSFORCE_MASK |
+		       ZYNQ_QSPI_CONFIG_FWIDTH_MASK |
+		       ZYNQ_QSPI_CONFIG_IFMODE_MASK);
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_RX_THRESH_OFFSET,
+			ZYNQ_QSPI_RX_THRESHOLD);
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_TX_THRESH_OFFSET,
+			ZYNQ_QSPI_TX_THRESHOLD);
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET,
+			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
+}
+
+static int zynq_qspi_check_buswidth(u8 width)
+{
+	switch (width) {
+	case 1:
+	case 2:
+	case 4:
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
+static bool zynq_qspi_supports_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	int ret;
+
+	ret = zynq_qspi_check_buswidth(op->cmd.buswidth);
+
+	if (op->addr.nbytes)
+		ret |= zynq_qspi_check_buswidth(op->addr.buswidth);
+
+	if (op->dummy.nbytes)
+		ret |= zynq_qspi_check_buswidth(op->dummy.buswidth);
+
+	if (op->data.nbytes)
+		ret |= zynq_qspi_check_buswidth(op->data.buswidth);
+
+	if (ret)
+		return false;
+
+	/*
+	 * The number of address bytes should be equal to or less than 3 bytes.
+	 */
+	if (op->addr.nbytes > 3)
+		return false;
+
+	return true;
+}
+
+/**
+ * zynq_qspi_rxfifo_op - Read 1..4 bytes from RxFIFO to RX buffer
+ * @xqspi:	Pointer to the zynq_qspi structure
+ * @size:	Number of bytes to be read (1..4)
+ */
+static void zynq_qspi_rxfifo_op(struct zynq_qspi *xqspi, unsigned int size)
+{
+	u32 data;
+
+	data = zynq_qspi_read(xqspi, ZYNQ_QSPI_RXD_OFFSET);
+
+	if (xqspi->rxbuf) {
+		memcpy(xqspi->rxbuf, ((u8 *)&data) + 4 - size, size);
+		xqspi->rxbuf += size;
+	}
+
+	xqspi->rx_bytes -= size;
+	if (xqspi->rx_bytes < 0)
+		xqspi->rx_bytes = 0;
+}
+
+/**
+ * zynq_qspi_txfifo_op - Write 1..4 bytes from TX buffer to TxFIFO
+ * @xqspi:	Pointer to the zynq_qspi structure
+ * @size:	Number of bytes to be written (1..4)
+ */
+static void zynq_qspi_txfifo_op(struct zynq_qspi *xqspi, unsigned int size)
+{
+	static const unsigned int offset[4] = {
+		ZYNQ_QSPI_TXD_00_01_OFFSET, ZYNQ_QSPI_TXD_00_10_OFFSET,
+		ZYNQ_QSPI_TXD_00_11_OFFSET, ZYNQ_QSPI_TXD_00_00_OFFSET };
+	u32 data;
+
+	if (xqspi->txbuf) {
+		data = 0xffffffff;
+		memcpy(&data, xqspi->txbuf, size);
+		xqspi->txbuf += size;
+	} else {
+		data = 0;
+	}
+
+	xqspi->tx_bytes -= size;
+	zynq_qspi_write(xqspi, offset[size - 1], data);
+}
+
+/**
+ * zynq_qspi_chipselect - Select or deselect the chip select line
+ * @spi:	Pointer to the spi_device structure
+ * @assert:	1 for select or 0 for deselect the chip select line
+ */
+static void zynq_qspi_chipselect(struct spi_device *spi, bool assert)
+{
+	struct spi_controller *ctrl = spi->master;
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctrl);
+	u32 config_reg;
+
+	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
+	if (assert) {
+		/* Select the slave */
+		config_reg &= ~ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
+		config_reg |= (((~(BIT(spi->chip_select))) <<
+				ZYNQ_QSPI_SS_SHIFT) &
+				ZYNQ_QSPI_CONFIG_SSCTRL_MASK);
+	} else {
+		config_reg |= ZYNQ_QSPI_CONFIG_SSCTRL_MASK;
+	}
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
+}
+
+/**
+ * zynq_qspi_config_op - Configure QSPI controller for specified transfer
+ * @xqspi:	Pointer to the zynq_qspi structure
+ * @qspi:	Pointer to the spi_device structure
+ *
+ * Sets the operational mode of QSPI controller for the next QSPI transfer and
+ * sets the requested clock frequency.
+ *
+ * Return:	0 on success and -EINVAL on invalid input parameter
+ *
+ * Note: If the requested frequency is not an exact match with what can be
+ * obtained using the prescalar value, the driver sets the clock frequency which
+ * is lower than the requested frequency (maximum lower) for the transfer. If
+ * the requested frequency is higher or lower than that is supported by the QSPI
+ * controller the driver will set the highest or lowest frequency supported by
+ * controller.
+ */
+static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
+{
+	u32 config_reg, baud_rate_val = 0;
+
+	/* Set the clock frequency */
+	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
+	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
+		spi->max_speed_hz)
+		baud_rate_val++;
+	config_reg = zynq_qspi_read(xqspi, ZYNQ_QSPI_CONFIG_OFFSET);
+
+	/* Set the QSPI clock phase and clock polarity */
+	config_reg &= (~ZYNQ_QSPI_CONFIG_CPHA_MASK) &
+		      (~ZYNQ_QSPI_CONFIG_CPOL_MASK);
+	if (spi->mode & SPI_CPHA)
+		config_reg |= ZYNQ_QSPI_CONFIG_CPHA_MASK;
+	if (spi->mode & SPI_CPOL)
+		config_reg |= ZYNQ_QSPI_CONFIG_CPOL_MASK;
+
+	config_reg &= ~ZYNQ_QSPI_CONFIG_BDRATE_MASK;
+	config_reg |= (baud_rate_val << ZYNQ_QSPI_BAUD_DIV_SHIFT);
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_CONFIG_OFFSET, config_reg);
+
+	return 0;
+}
+
+/**
+ * zynq_qspi_setup - Configure the QSPI controller
+ * @spi:	Pointer to the spi_device structure
+ *
+ * Sets the operational mode of QSPI controller for the next QSPI transfer, baud
+ * rate and divisor value to setup the requested qspi clock.
+ *
+ * Return:	0 on success and error value on failure
+ */
+static int zynq_qspi_setup_op(struct spi_device *spi)
+{
+	struct spi_controller *ctrl = spi->master;
+	struct zynq_qspi *qspi = spi_controller_get_devdata(ctrl);
+
+	if (ctrl->busy)
+		return -EBUSY;
+
+	clk_enable(qspi->refclk);
+	clk_enable(qspi->pclk);
+	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
+			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
+
+	return 0;
+}
+
+/**
+ * zynq_qspi_write_op - Fills the TX FIFO with as many bytes as possible
+ * @xqspi:	Pointer to the zynq_qspi structure
+ * @txcount:	Maximum number of words to write
+ * @txempty:	Indicates that TxFIFO is empty
+ */
+static void zynq_qspi_write_op(struct zynq_qspi *xqspi, int txcount,
+			       bool txempty)
+{
+	int count, len, k;
+
+	len = xqspi->tx_bytes;
+	if (len && len < 4) {
+		/*
+		 * We must empty the TxFIFO between accesses to TXD0,
+		 * TXD1, TXD2, TXD3.
+		 */
+		if (txempty)
+			zynq_qspi_txfifo_op(xqspi, len);
+
+		return;
+	}
+
+	count = len / 4;
+	if (count > txcount)
+		count = txcount;
+
+	if (xqspi->txbuf) {
+		writesl(xqspi->regs + ZYNQ_QSPI_TXD_00_00_OFFSET,
+			xqspi->txbuf, count);
+		xqspi->txbuf += count * 4;
+	} else {
+		for (k = 0; k < count; k++)
+			writel_relaxed(0, xqspi->regs +
+					  ZYNQ_QSPI_TXD_00_00_OFFSET);
+	}
+
+	xqspi->tx_bytes -= count * 4;
+}
+
+/**
+ * zynq_qspi_read_op - Drains the RX FIFO by as many bytes as possible
+ * @xqspi:	Pointer to the zynq_qspi structure
+ * @rxcount:	Maximum number of words to read
+ */
+static void zynq_qspi_read_op(struct zynq_qspi *xqspi, int rxcount)
+{
+	int count, len, k;
+
+	len = xqspi->rx_bytes - xqspi->tx_bytes;
+	count = len / 4;
+	if (count > rxcount)
+		count = rxcount;
+	if (xqspi->rxbuf) {
+		readsl(xqspi->regs + ZYNQ_QSPI_RXD_OFFSET,
+		       xqspi->rxbuf, count);
+		xqspi->rxbuf += count * 4;
+	} else {
+		for (k = 0; k < count; k++)
+			readl_relaxed(xqspi->regs + ZYNQ_QSPI_RXD_OFFSET);
+	}
+	xqspi->rx_bytes -= count * 4;
+	len -= count * 4;
+
+	if (len && len < 4 && count < rxcount)
+		zynq_qspi_rxfifo_op(xqspi, len);
+}
+
+/**
+ * zynq_qspi_irq - Interrupt service routine of the QSPI controller
+ * @irq:	IRQ number
+ * @dev_id:	Pointer to the xqspi structure
+ *
+ * This function handles TX empty only.
+ * On TX empty interrupt this function reads the received data from RX FIFO and
+ * fills the TX FIFO if there is any data remaining to be transferred.
+ *
+ * Return:	IRQ_HANDLED when interrupt is handled; IRQ_NONE otherwise.
+ */
+static irqreturn_t zynq_qspi_irq(int irq, void *dev_id)
+{
+	u32 intr_status;
+	bool txempty;
+	struct zynq_qspi *xqspi = (struct zynq_qspi *)dev_id;
+
+	intr_status = zynq_qspi_read(xqspi, ZYNQ_QSPI_STATUS_OFFSET);
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_STATUS_OFFSET, intr_status);
+
+	if ((intr_status & ZYNQ_QSPI_IXR_TXNFULL_MASK) ||
+	    (intr_status & ZYNQ_QSPI_IXR_RXNEMTY_MASK)) {
+		/*
+		 * This bit is set when Tx FIFO has < THRESHOLD entries.
+		 * We have the THRESHOLD value set to 1,
+		 * so this bit indicates Tx FIFO is empty.
+		 */
+		txempty = !!(intr_status & ZYNQ_QSPI_IXR_TXNFULL_MASK);
+		/* Read out the data from the RX FIFO */
+		zynq_qspi_read_op(xqspi, ZYNQ_QSPI_RX_THRESHOLD);
+		if (xqspi->tx_bytes) {
+			/* There is more data to send */
+			zynq_qspi_write_op(xqspi, ZYNQ_QSPI_RX_THRESHOLD,
+					   txempty);
+		} else {
+			/*
+			 * If transfer and receive is completed then only send
+			 * complete signal.
+			 */
+			if (!xqspi->rx_bytes) {
+				zynq_qspi_write(xqspi,
+						ZYNQ_QSPI_IDIS_OFFSET,
+						ZYNQ_QSPI_IXR_RXTX_MASK);
+				complete(&xqspi->data_completion);
+			}
+		}
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/**
+ * zynq_qspi_exec_mem_op() - Initiates the QSPI transfer
+ * @mem: the SPI memory
+ * @op: the memory operation to execute
+ *
+ * Executes a memory operation.
+ *
+ * This function first selects the chip and starts the memory operation.
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
+	int err = 0, i;
+	u8 *tmpbuf;
+
+	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->dummy.buswidth, op->data.buswidth);
+
+	zynq_qspi_chipselect(mem->spi, true);
+	zynq_qspi_config_op(xqspi, mem->spi);
+
+	if (op->cmd.opcode) {
+		reinit_completion(&xqspi->data_completion);
+		xqspi->txbuf = (u8 *)&op->cmd.opcode;
+		xqspi->rxbuf = NULL;
+		xqspi->tx_bytes = sizeof(op->cmd.opcode);
+		xqspi->rx_bytes = sizeof(op->cmd.opcode);
+		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
+		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
+				ZYNQ_QSPI_IXR_RXTX_MASK);
+		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+							       msecs_to_jiffies(1000))) {
+			err = -ETIMEDOUT;
+		}
+	}
+	zynq_qspi_config_op(xqspi, mem->spi);
+	if (op->addr.nbytes) {
+		for (i = 0; i < op->addr.nbytes; i++) {
+			xqspi->txbuf[i] = op->addr.val >>
+					(8 * (op->addr.nbytes - i - 1));
+		}
+
+		reinit_completion(&xqspi->data_completion);
+		xqspi->rxbuf = NULL;
+		xqspi->tx_bytes = op->addr.nbytes;
+		xqspi->rx_bytes = op->addr.nbytes;
+		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
+		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
+				ZYNQ_QSPI_IXR_RXTX_MASK);
+		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+							       msecs_to_jiffies(1000))) {
+			err = -ETIMEDOUT;
+		}
+	}
+	zynq_qspi_config_op(xqspi, mem->spi);
+	if (op->dummy.nbytes) {
+		tmpbuf = kzalloc(op->dummy.nbytes, GFP_KERNEL);
+		memset(tmpbuf, 0xff, op->dummy.nbytes);
+		reinit_completion(&xqspi->data_completion);
+		xqspi->txbuf = tmpbuf;
+		xqspi->rxbuf = NULL;
+		xqspi->tx_bytes = op->dummy.nbytes;
+		xqspi->rx_bytes = op->dummy.nbytes;
+		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
+		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
+				ZYNQ_QSPI_IXR_RXTX_MASK);
+		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+							       msecs_to_jiffies(1000))) {
+			err = -ETIMEDOUT;
+		}
+		kfree(tmpbuf);
+	}
+	zynq_qspi_config_op(xqspi, mem->spi);
+	if (op->data.nbytes) {
+		reinit_completion(&xqspi->data_completion);
+		if (op->data.dir == SPI_MEM_DATA_OUT) {
+			xqspi->txbuf = (u8 *)op->data.buf.out;
+			xqspi->tx_bytes = op->data.nbytes;
+			xqspi->rxbuf = NULL;
+			xqspi->rx_bytes = op->data.nbytes;
+		} else {
+			xqspi->txbuf = NULL;
+			xqspi->rxbuf = (u8 *)op->data.buf.in;
+			xqspi->rx_bytes = op->data.nbytes;
+			xqspi->tx_bytes = op->data.nbytes;
+		}
+
+		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
+		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
+				ZYNQ_QSPI_IXR_RXTX_MASK);
+		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+							       msecs_to_jiffies(1000))) {
+			err = -ETIMEDOUT;
+		}
+	}
+	zynq_qspi_chipselect(mem->spi, false);
+
+	return err;
+}
+
+static const struct spi_controller_mem_ops zynq_qspi_mem_ops = {
+	.supports_op = zynq_qspi_supports_op,
+	.exec_op = zynq_qspi_exec_mem_op,
+};
+
+/**
+ * zynq_qspi_probe - Probe method for the QSPI driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function initializes the driver data structures and the hardware.
+ *
+ * Return:	0 on success and error value on failure
+ */
+static int zynq_qspi_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct spi_controller *ctlr;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct zynq_qspi *xqspi;
+	struct resource *res;
+	u32 num_cs;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	xqspi = spi_controller_get_devdata(ctlr);
+	xqspi->dev = dev;
+	platform_set_drvdata(pdev, xqspi);
+	ctlr->mem_ops = &zynq_qspi_mem_ops;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xqspi->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xqspi->regs)) {
+		ret = PTR_ERR(xqspi->regs);
+		goto remove_master;
+	}
+
+	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(xqspi->pclk)) {
+		dev_err(&pdev->dev, "pclk clock not found.\n");
+		ret = PTR_ERR(xqspi->pclk);
+		goto remove_master;
+	}
+
+	init_completion(&xqspi->data_completion);
+
+	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (IS_ERR(xqspi->refclk)) {
+		dev_err(&pdev->dev, "ref_clk clock not found.\n");
+		ret = PTR_ERR(xqspi->refclk);
+		goto remove_master;
+	}
+
+	ret = clk_prepare_enable(xqspi->pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
+		goto remove_master;
+	}
+
+	ret = clk_prepare_enable(xqspi->refclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable device clock.\n");
+		goto clk_dis_pclk;
+	}
+
+	/* QSPI controller initializations */
+	zynq_qspi_init_hw(xqspi);
+
+	xqspi->irq = platform_get_irq(pdev, 0);
+	if (xqspi->irq <= 0) {
+		ret = -ENXIO;
+		dev_err(&pdev->dev, "irq resource not found\n");
+		goto remove_master;
+	}
+	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
+			       0, pdev->name, xqspi);
+	if (ret != 0) {
+		ret = -ENXIO;
+		dev_err(&pdev->dev, "request_irq failed\n");
+		goto remove_master;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "num-cs",
+				   &num_cs);
+	if (ret < 0)
+		ctlr->num_chipselect = ZYNQ_QSPI_DEFAULT_NUM_CS;
+	else
+		ctlr->num_chipselect = num_cs;
+	ctlr->mode_bits =  SPI_RX_DUAL | SPI_RX_QUAD |
+			    SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mem_ops = &zynq_qspi_mem_ops;
+	ctlr->setup = zynq_qspi_setup_op;
+	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
+	ctlr->dev.of_node = np;
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_master failed\n");
+		goto clk_dis_all;
+	}
+
+	return ret;
+
+clk_dis_all:
+	clk_disable_unprepare(xqspi->refclk);
+clk_dis_pclk:
+	clk_disable_unprepare(xqspi->pclk);
+remove_master:
+	spi_controller_put(ctlr);
+
+	return ret;
+}
+
+/**
+ * zynq_qspi_remove - Remove method for the QSPI driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function is called if a device is physically removed from the system or
+ * if the driver module is being unloaded. It frees all resources allocated to
+ * the device.
+ *
+ * Return:	0 on success and error value on failure
+ */
+static int zynq_qspi_remove(struct platform_device *pdev)
+{
+	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
+
+	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
+
+	clk_disable_unprepare(xqspi->refclk);
+	clk_disable_unprepare(xqspi->pclk);
+
+	return 0;
+}
+
+static const struct of_device_id zynq_qspi_of_match[] = {
+	{ .compatible = "xlnx,zynq-qspi-1.0", },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, zynq_qspi_of_match);
+
+/*
+ * zynq_qspi_driver - This structure defines the QSPI platform driver
+ */
+static struct platform_driver zynq_qspi_driver = {
+	.probe = zynq_qspi_probe,
+	.remove = zynq_qspi_remove,
+	.driver = {
+		.name = "zynq-qspi",
+		.of_match_table = zynq_qspi_of_match,
+	},
+};
+
+module_platform_driver(zynq_qspi_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_DESCRIPTION("Xilinx Zynq QSPI driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

