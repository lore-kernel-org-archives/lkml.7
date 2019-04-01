Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D935C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF84213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ja3o3C14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfDAH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:59:43 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:7388
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732036AbfDAH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ3RciuQtRkh8oxSX+QGDyckFHmbGUrtCbz3aw/d5Wk=;
 b=Ja3o3C14xB4YwBhfM1YBZkp3rKXoM4V9xxZVY9xqH42YoB0vJIHFSlZd3MOwt8+pHAAqSxm9l0Z31c383aasfa2kiz4C9aK6wC6QroMq7fnqapz0ck9lp3PDaGqZ+mTPVsYyLuC8xEBHxwg2KmL8n04iJFG+BrB8dYXj3bRjhKY=
Received: from CY4PR02CA0039.namprd02.prod.outlook.com (2603:10b6:903:117::25)
 by SN1PR02MB1664.namprd02.prod.outlook.com (2a01:111:e400:5230::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.20; Mon, 1 Apr
 2019 07:59:36 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by CY4PR02CA0039.outlook.office365.com
 (2603:10b6:903:117::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.16 via Frontend
 Transport; Mon, 1 Apr 2019 07:59:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.16
 via Frontend Transport; Mon, 1 Apr 2019 07:59:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hArqw-0006AB-Fe; Mon, 01 Apr 2019 00:59:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hArqr-0003UH-C0; Mon, 01 Apr 2019 00:59:29 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x317xJPh011166;
        Mon, 1 Apr 2019 00:59:19 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hArqg-0003HB-Eq; Mon, 01 Apr 2019 00:59:19 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <broonie@kernel.org>, <bbrezillon@kernel.org>
CC:     <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <dwmw2@infradead.org>, <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI controller
Date:   Mon, 1 Apr 2019 13:29:13 +0530
Message-ID: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(81166006)(106466001)(6666004)(107886003)(81156014)(186003)(8936002)(8676002)(356004)(110136005)(16586007)(36756003)(316002)(36386004)(51416003)(54906003)(14444005)(30864003)(48376002)(305945005)(478600001)(7696005)(50466002)(106002)(50226002)(476003)(126002)(336012)(9786002)(486006)(2906002)(5660300002)(426003)(47776003)(4326008)(7416002)(2616005)(63266004)(77096007)(26005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1664;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec8515a-5497-4877-ac88-08d6b677fb84
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR02MB1664;
X-MS-TrafficTypeDiagnostic: SN1PR02MB1664:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB166491EDACE54CE400B45CC7AF550@SN1PR02MB1664.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0994F5E0C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: d91F7Z8oJ6L4ylPs9nRhUViURASU+XR8Nsoyp7pNv4VAeRxJ2L7xQp073ULTYzSDz4t1eGjVmIiWkhy2FG7tKvDjTciaVk5yBCHv58+Y/1TX3JPzZoKheLKlrwr+irQBMSWFJs4YXGhFCQh0z13Ywy0nR2ke7SN2OTDrk2Aioph8uY4mMnErNeogzjdJcqxj+g7ovuzO0knpMD1/DdOjmUzZJtFpL5Wq2JKYEyKo3xNLePaVyBr5g5aIkbzfnXBG+FgIsipdgmFqk9iA9FW2FkmE9RtggVD6506A30rGbTZU0lKwfeRXsGJ5FIm3yleZgGer5rmmt4gPzeLPe3kQBcKmxHXWTM0t4jgc9jOfvmfgcuWpDdSHzK1rNAphG8DzdFWIz86Eod5EpEuCf8IbUmzzmpAxCeBaZ1P100ec2Ok=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2019 07:59:34.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec8515a-5497-4877-ac88-08d6b677fb84
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for QSPI controller driver used by Xilinx Zynq SOC.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v2
 - Updated the driver to call spi_mem_default_supports_op() from
   ctrl->supports_op()
Changes in v1
 - Added COMPILE_TEST macro
 - converted MASKs to GENMASK() and BIT() macros
 - Renamed MODEBITS to ZYNQ_QSPI_MODEBITS
 - Removed checking buswidth() code, as it is already handled by framework
 - Updated in comments regarding baud rate calculation
---
 drivers/spi/Kconfig         |  10 +-
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-zynq-qspi.c | 761 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 771 insertions(+), 1 deletion(-)
 create mode 100644 drivers/spi/spi-zynq-qspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f89cb1..7bf7d38 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -816,9 +816,17 @@ config SPI_XTENSA_XTFPGA
 	  16 bit words in SPI mode 0, automatically asserting CS on transfer
 	  start and deasserting on end.
 
+config SPI_ZYNQ_QSPI
+	tristate "Xilinx Zynq QSPI controller"
+	depends on ARCH_ZYNQ || COMPILE_TEST
+	help
+	  This enables support for the Zynq Quad SPI controller
+	  in master mode.
+	  This controller only supports SPI memory interface.
+
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
-	depends on SPI_MASTER && HAS_DMA
+	depends on (SPI_MASTER && HAS_DMA) || COMPILE_TEST
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 
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
index 0000000..8079d00
--- /dev/null
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -0,0 +1,761 @@
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
+#define ZYNQ_QSPI_CONFIG_IFMODE_MASK	BIT(31) /* Flash Memory Interface */
+#define ZYNQ_QSPI_CONFIG_MANSRT_MASK	BIT(16) /* Manual TX Start */
+#define ZYNQ_QSPI_CONFIG_MANSRTEN_MASK	BIT(15) /* Enable Manual TX Mode */
+#define ZYNQ_QSPI_CONFIG_SSFORCE_MASK	BIT(14) /* Manual Chip Select */
+#define ZYNQ_QSPI_CONFIG_BDRATE_MASK	GENMASK(5, 3) /* Baud Rate Mask */
+#define ZYNQ_QSPI_CONFIG_CPHA_MASK	BIT(2) /* Clock Phase Control */
+#define ZYNQ_QSPI_CONFIG_CPOL_MASK	BIT(1) /* Clock Polarity Control */
+#define ZYNQ_QSPI_CONFIG_SSCTRL_MASK	BIT(10) /* Slave Select Mask */
+#define ZYNQ_QSPI_CONFIG_FWIDTH_MASK	GENMASK(7, 6) /* FIFO width */
+#define ZYNQ_QSPI_CONFIG_MSTREN_MASK	BIT(0) /* Master Mode */
+
+/*
+ * QSPI Configuration Register - Baud rate and slave select
+ *
+ * These are the values used in the calculation of baud rate divisor and
+ * setting the slave select.
+ */
+#define ZYNQ_QSPI_BAUD_DIV_MAX		GENMASK(2, 0) /* Baud rate maximum */
+#define ZYNQ_QSPI_BAUD_DIV_SHIFT	3 /* Baud rate divisor shift in CR */
+#define ZYNQ_QSPI_SS_SHIFT		10 /* Slave Select field shift in CR */
+
+/*
+ * QSPI Interrupt Registers bit Masks
+ *
+ * All the four interrupt registers (Status/Mask/Enable/Disable) have the same
+ * bit definitions.
+ */
+#define ZYNQ_QSPI_IXR_RX_OVERFLOW_MASK	BIT(0) /* QSPI RX FIFO Overflow */
+#define ZYNQ_QSPI_IXR_TXNFULL_MASK	BIT(2) /* QSPI TX FIFO Overflow */
+#define ZYNQ_QSPI_IXR_TXFULL_MASK	BIT(3) /* QSPI TX FIFO is full */
+#define ZYNQ_QSPI_IXR_RXNEMTY_MASK	BIT(4) /* QSPI RX FIFO Not Empty */
+#define ZYNQ_QSPI_IXR_RXF_FULL_MASK	BIT(5) /* QSPI RX FIFO is full */
+#define ZYNQ_QSPI_IXR_TXF_UNDRFLOW_MASK	BIT(6) /* QSPI TX FIFO Underflow */
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
+#define ZYNQ_QSPI_ENABLE_ENABLE_MASK	BIT(0) /* QSPI Enable Bit Mask */
+
+/*
+ * QSPI Linear Configuration Register
+ *
+ * It is named Linear Configuration but it controls other modes when not in
+ * linear mode also.
+ */
+#define ZYNQ_QSPI_LCFG_TWO_MEM_MASK	BIT(30) /* LQSPI Two memories Mask */
+#define ZYNQ_QSPI_LCFG_SEP_BUS_MASK	BIT(29) /* LQSPI Separate bus Mask */
+#define ZYNQ_QSPI_LCFG_U_PAGE_MASK	BIT(28) /* LQSPI Upper Page Mask */
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
+#define ZYNQ_QSPI_MODEBITS			(SPI_CPOL | SPI_CPHA)
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
+static bool zynq_qspi_supports_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
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
+	/*
+	 * Set the clock frequency
+	 * The baud rate divisor is not a direct mapping to the value written
+	 * into the configuration register (config_reg[5:3])
+	 * i.e. 000 - divide by 2
+	 *      001 - divide by 4
+	 *      ----------------
+	 *      111 - divide by 256
+	 */
+	while ((baud_rate_val < ZYNQ_QSPI_BAUD_DIV_MAX)  &&
+	       (clk_get_rate(xqspi->refclk) / (2 << baud_rate_val)) >
+		spi->max_speed_hz)
+		baud_rate_val++;
+
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
+							       msecs_to_jiffies(1000)))
+			err = -ETIMEDOUT;
+	}
+
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
+							       msecs_to_jiffies(1000)))
+			err = -ETIMEDOUT;
+	}
+
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
+							       msecs_to_jiffies(1000)))
+			err = -ETIMEDOUT;
+
+		kfree(tmpbuf);
+	}
+
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
+							       msecs_to_jiffies(1000)))
+			err = -ETIMEDOUT;
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
+	ret = of_property_read_u32(np, "num-cs",
+				   &num_cs);
+	if (ret < 0)
+		ctlr->num_chipselect = ZYNQ_QSPI_DEFAULT_NUM_CS;
+	else
+		ctlr->num_chipselect = num_cs;
+
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

