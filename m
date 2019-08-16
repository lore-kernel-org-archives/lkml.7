Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD5C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B1B2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfHPQvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:51:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60045 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfHPQvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:35 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hyfRq-0006rx-NA; Fri, 16 Aug 2019 16:51:31 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] serial: 8250_pci: Merge 8250_moxa to 8250_pci
Date:   Sat, 17 Aug 2019 00:51:24 +0800
Message-Id: <20190816165124.16942-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moxa serial boards only need a special setup function, we can use
generic 8250 framework for other parts.

So let's merge 8250_moxa to 8250_pci.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/tty/serial/8250/8250_moxa.c | 155 ----------------------------
 drivers/tty/serial/8250/8250_pci.c  | 113 +++++++++++++++++---
 drivers/tty/serial/8250/Kconfig     |  10 --
 drivers/tty/serial/8250/Makefile    |   1 -
 4 files changed, 99 insertions(+), 180 deletions(-)
 delete mode 100644 drivers/tty/serial/8250/8250_moxa.c

diff --git a/drivers/tty/serial/8250/8250_moxa.c b/drivers/tty/serial/8250/8250_moxa.c
deleted file mode 100644
index 1ee4cd94d4fa..000000000000
--- a/drivers/tty/serial/8250/8250_moxa.c
+++ /dev/null
@@ -1,155 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * 8250_moxa.c - MOXA Smartio/Industio MUE multiport serial driver.
- *
- * Author: Mathieu OTHACEHE <m.othacehe@gmail.com>
- */
-
-#include <linux/module.h>
-#include <linux/pci.h>
-
-#include "8250.h"
-
-#define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
-#define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
-#define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
-#define	PCI_DEVICE_ID_MOXA_CP114EL	0x1144
-#define	PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
-#define	PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
-#define	PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
-#define	PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
-#define	PCI_DEVICE_ID_MOXA_CP132EL	0x1322
-#define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
-#define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
-#define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
-
-#define MOXA_BASE_BAUD 921600
-#define MOXA_UART_OFFSET 0x200
-#define MOXA_BASE_BAR 1
-
-struct moxa8250_board {
-	unsigned int num_ports;
-	int line[0];
-};
-
-enum {
-	moxa8250_2p = 0,
-	moxa8250_4p,
-	moxa8250_8p
-};
-
-static struct moxa8250_board moxa8250_boards[] = {
-	[moxa8250_2p] = { .num_ports = 2},
-	[moxa8250_4p] = { .num_ports = 4},
-	[moxa8250_8p] = { .num_ports = 8},
-};
-
-static int moxa8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-{
-	struct uart_8250_port uart;
-	struct moxa8250_board *brd;
-	void __iomem *ioaddr;
-	resource_size_t baseaddr;
-	unsigned int i, nr_ports;
-	unsigned int offset;
-	int ret;
-
-	brd = &moxa8250_boards[id->driver_data];
-	nr_ports = brd->num_ports;
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	brd = devm_kzalloc(&pdev->dev, sizeof(struct moxa8250_board) +
-			   sizeof(unsigned int) * nr_ports, GFP_KERNEL);
-	if (!brd)
-		return -ENOMEM;
-	brd->num_ports = nr_ports;
-
-	memset(&uart, 0, sizeof(struct uart_8250_port));
-
-	uart.port.dev = &pdev->dev;
-	uart.port.irq = pdev->irq;
-	uart.port.uartclk = MOXA_BASE_BAUD * 16;
-	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
-
-	baseaddr = pci_resource_start(pdev, MOXA_BASE_BAR);
-	ioaddr = pcim_iomap(pdev, MOXA_BASE_BAR, 0);
-	if (!ioaddr)
-		return -ENOMEM;
-
-	for (i = 0; i < nr_ports; i++) {
-
-		/*
-		 * MOXA Smartio MUE boards with 4 ports have
-		 * a different offset for port #3
-		 */
-		if (nr_ports == 4 && i == 3)
-			offset = 7 * MOXA_UART_OFFSET;
-		else
-			offset = i * MOXA_UART_OFFSET;
-
-		uart.port.iotype = UPIO_MEM;
-		uart.port.iobase = 0;
-		uart.port.mapbase = baseaddr + offset;
-		uart.port.membase = ioaddr + offset;
-		uart.port.regshift = 0;
-
-		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
-			uart.port.iobase, uart.port.irq, uart.port.iotype);
-
-		brd->line[i] = serial8250_register_8250_port(&uart);
-		if (brd->line[i] < 0) {
-			dev_err(&pdev->dev,
-				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
-				uart.port.iobase, uart.port.irq,
-				uart.port.iotype, brd->line[i]);
-			break;
-		}
-	}
-
-	pci_set_drvdata(pdev, brd);
-	return 0;
-}
-
-static void moxa8250_remove(struct pci_dev *pdev)
-{
-	struct moxa8250_board *brd = pci_get_drvdata(pdev);
-	unsigned int i;
-
-	for (i = 0; i < brd->num_ports; i++)
-		serial8250_unregister_port(brd->line[i]);
-}
-
-#define MOXA_DEVICE(id, data) { PCI_VDEVICE(MOXA, id), (kernel_ulong_t)data }
-
-static const struct pci_device_id pci_ids[] = {
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP102E, moxa8250_2p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP102EL, moxa8250_2p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP104EL_A, moxa8250_4p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP114EL, moxa8250_4p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP116E_A_A, moxa8250_8p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP116E_A_B, moxa8250_8p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP118EL_A, moxa8250_8p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP118E_A_I, moxa8250_8p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP132EL, moxa8250_2p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP134EL_A, moxa8250_4p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP138E_A, moxa8250_8p),
-	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP168EL_A, moxa8250_8p),
-	{0}
-};
-MODULE_DEVICE_TABLE(pci, pci_ids);
-
-static struct pci_driver moxa8250_pci_driver = {
-	.name           = "8250_moxa",
-	.id_table       = pci_ids,
-	.probe          = moxa8250_probe,
-	.remove         = moxa8250_remove,
-};
-
-module_pci_driver(moxa8250_pci_driver);
-
-MODULE_AUTHOR("Mathieu OTHACEHE");
-MODULE_DESCRIPTION("MOXA SmartIO MUE driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c0d10a35bf70..76d58bddeb06 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1827,6 +1827,22 @@ pci_sunix_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
+static int
+pci_moxa_setup(struct serial_private *priv,
+		const struct pciserial_board *board,
+		struct uart_8250_port *port, int idx)
+{
+	unsigned int bar = FL_GET_BASE(board->flags);
+	int offset;
+
+	if (board->num_ports == 4 && idx == 3)
+		offset = 7 * board->uart_offset;
+	else
+		offset = idx * board->uart_offset;
+
+	return setup_port(priv, port, bar, offset, 0);
+}
+
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_DEVICE_ID_OCTPRO		0x0001
@@ -1931,6 +1947,18 @@ pci_sunix_setup(struct serial_private *priv,
 #define PCIE_DEVICE_ID_NI_PXIE8431_4858	0x74C4
 #define PCIE_DEVICE_ID_NI_PXIE8431_48516	0x74C3
 
+#define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
+#define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
+#define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
+#define	PCI_DEVICE_ID_MOXA_CP114EL	0x1144
+#define	PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
+#define	PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
+#define	PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
+#define	PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
+#define	PCI_DEVICE_ID_MOXA_CP132EL	0x1322
+#define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
+#define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
+#define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -2781,6 +2809,16 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_fintek_setup,
 		.init		= pci_fintek_init,
 	},
+	/*
+	 * MOXA
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_MOXA,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_moxa_setup,
+	},
 
 	/*
 	 * Default "match everything" terminator entry
@@ -2987,6 +3025,9 @@ enum pci_board_num_t {
 	pbn_sunix_pci_4s,
 	pbn_sunix_pci_8s,
 	pbn_sunix_pci_16s,
+	pbn_moxa8250_2p,
+	pbn_moxa8250_4p,
+	pbn_moxa8250_8p,
 };
 
 /*
@@ -3798,6 +3839,24 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[pbn_moxa8250_2p] = {
+		.flags		= FL_BASE1,
+		.num_ports      = 2,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa8250_4p] = {
+		.flags		= FL_BASE1,
+		.num_ports      = 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
+	[pbn_moxa8250_8p] = {
+		.flags		= FL_BASE1,
+		.num_ports      = 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x200,
+	},
 };
 
 static const struct pci_device_id blacklist[] = {
@@ -3811,20 +3870,6 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_DEVICE(0x4348, 0x5053), }, /* WCH CH353 1S1P */
 	{ PCI_DEVICE(0x1c00, 0x3250), }, /* WCH CH382 2S1P */
 
-	/* Moxa Smartio MUE boards handled by 8250_moxa */
-	{ PCI_VDEVICE(MOXA, 0x1024), },
-	{ PCI_VDEVICE(MOXA, 0x1025), },
-	{ PCI_VDEVICE(MOXA, 0x1045), },
-	{ PCI_VDEVICE(MOXA, 0x1144), },
-	{ PCI_VDEVICE(MOXA, 0x1160), },
-	{ PCI_VDEVICE(MOXA, 0x1161), },
-	{ PCI_VDEVICE(MOXA, 0x1182), },
-	{ PCI_VDEVICE(MOXA, 0x1183), },
-	{ PCI_VDEVICE(MOXA, 0x1322), },
-	{ PCI_VDEVICE(MOXA, 0x1342), },
-	{ PCI_VDEVICE(MOXA, 0x1381), },
-	{ PCI_VDEVICE(MOXA, 0x1683), },
-
 	/* Intel platforms with MID UART */
 	{ PCI_VDEVICE(INTEL, 0x081b), },
 	{ PCI_VDEVICE(INTEL, 0x081c), },
@@ -5407,6 +5452,46 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_ni8431_4 },
 
+	/*
+	 * MOXA
+	 */
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_2p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_2p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_4p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_4p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_8p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_8p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_8p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_8p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_2p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_4p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_8p },
+	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_moxa8250_8p },
+
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index ff5d142bbd70..7ef60f8b6e2c 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -468,16 +468,6 @@ config SERIAL_8250_MID
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
 
-config SERIAL_8250_MOXA
-	tristate "MOXA SmartIO MUE support"
-	depends on SERIAL_8250 && PCI
-	help
-	  Say Y here if you have a Moxa SmartIO MUE multiport serial card.
-	  If unsure, say N.
-
-	  This driver can also be built as a module. The module will be called
-	  8250_moxa. If you want to do that, say M here.
-
 config SERIAL_8250_PXA
 	tristate "PXA serial port support"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 9b451d81588b..08c1d8117506 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -35,7 +35,6 @@ obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
-obj-$(CONFIG_SERIAL_8250_MOXA)		+= 8250_moxa.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
-- 
2.17.1

