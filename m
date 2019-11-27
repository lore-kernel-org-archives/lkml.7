Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4899C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 03:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D692071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 03:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0DxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 22:53:00 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:57372 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbfK0DxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 22:53:00 -0500
X-Greylist: delayed 2067 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 22:52:59 EST
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAR3F1lO031150;
        Tue, 26 Nov 2019 21:18:30 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2whd020p47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 21:18:30 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod2.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id xAR3ITJ2021639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Nov 2019 21:18:29 -0600
Received: from us-aus-exch3.ni.corp.natinst.com (130.164.68.13) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 26 Nov 2019 21:18:28 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch3.ni.corp.natinst.com (130.164.68.13) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 26 Nov 2019 21:18:28 -0600
Received: from my-pen-rd9.apac.corp.natinst.com (172.18.68.32) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Tue, 26 Nov 2019 21:18:27 -0600
From:   Je Yen Tam <je.yen.tam@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Je Yen Tam <je.yen.tam@ni.com>
Subject: [PATCH] Revert "serial/8250: Add support for NI-Serial PXI/PXIe+485 devices"
Date:   Wed, 27 Nov 2019 11:17:51 +0800
Message-ID: <20191127031751.9082-1-je.yen.tam@ni.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_08:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fdc2de87124f5183a98ea7eced1f76dbdba22951 which is
commit 225607f75454 ("serial/8250: Add support for NI-Serial PXI/PXIe+485 devices").

The upstream introduced a breakage on NI-Serial PXI(e)-RS485 devices,
RS-232 variants have no issue. The Linux system can enumerate the Serial
PXI(e)-RS485 devices, but it broke the R/W operation on the ports.

However, the implementation is working on the NI internal Linux RT kernel
but it does not work in the Linux main tree kernel. This is only affecting
NI products, specifically the RS-485 variants. Reverting the upstream
until a proper implementation that can apply to both NI internal Linux
kernel and Linux mainline kernel is figured out.

Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
---
 drivers/tty/serial/8250/8250_pci.c | 292 +----------------------------
 1 file changed, 4 insertions(+), 288 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 6adbadd6a56a..8a01d034f9d1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -745,16 +745,8 @@ static int pci_ni8430_init(struct pci_dev *dev)
 }
 
 /* UART Port Control Register */
-#define NI16550_PCR_OFFSET	0x0f
-#define NI16550_PCR_RS422	0x00
-#define NI16550_PCR_ECHO_RS485	0x01
-#define NI16550_PCR_DTR_RS485	0x02
-#define NI16550_PCR_AUTO_RS485	0x03
-#define NI16550_PCR_WIRE_MODE_MASK	0x03
-#define NI16550_PCR_TXVR_ENABLE_BIT	BIT(3)
-#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
-#define NI16550_ACR_DTR_AUTO_DTR	(0x2 << 3)
-#define NI16550_ACR_DTR_MANUAL_DTR	(0x0 << 3)
+#define NI8430_PORTCON	0x0f
+#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
 
 static int
 pci_ni8430_setup(struct serial_private *priv,
@@ -776,117 +768,14 @@ pci_ni8430_setup(struct serial_private *priv,
 		return -ENOMEM;
 
 	/* enable the transceiver */
-	writeb(readb(p + offset + NI16550_PCR_OFFSET) | NI16550_PCR_TXVR_ENABLE_BIT,
-	       p + offset + NI16550_PCR_OFFSET);
+	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
+	       p + offset + NI8430_PORTCON);
 
 	iounmap(p);
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
-static int pci_ni8431_config_rs485(struct uart_port *port,
-	struct serial_rs485 *rs485)
-{
-	u8 pcr, acr;
-	struct uart_8250_port *up;
-
-	up = container_of(port, struct uart_8250_port, port);
-	acr = up->acr;
-	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
-	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
-
-	if (rs485->flags & SER_RS485_ENABLED) {
-		/* RS-485 */
-		if ((rs485->flags & SER_RS485_RX_DURING_TX) &&
-			(rs485->flags & SER_RS485_RTS_ON_SEND)) {
-			dev_dbg(port->dev, "Invalid 2-wire mode\n");
-			return -EINVAL;
-		}
-
-		if (rs485->flags & SER_RS485_RX_DURING_TX) {
-			/* Echo */
-			dev_vdbg(port->dev, "2-wire DTR with echo\n");
-			pcr |= NI16550_PCR_ECHO_RS485;
-			acr |= NI16550_ACR_DTR_MANUAL_DTR;
-		} else {
-			/* Auto or DTR */
-			if (rs485->flags & SER_RS485_RTS_ON_SEND) {
-				/* Auto */
-				dev_vdbg(port->dev, "2-wire Auto\n");
-				pcr |= NI16550_PCR_AUTO_RS485;
-				acr |= NI16550_ACR_DTR_AUTO_DTR;
-			} else {
-				/* DTR-controlled */
-				/* No Echo */
-				dev_vdbg(port->dev, "2-wire DTR no echo\n");
-				pcr |= NI16550_PCR_DTR_RS485;
-				acr |= NI16550_ACR_DTR_MANUAL_DTR;
-			}
-		}
-	} else {
-		/* RS-422 */
-		dev_vdbg(port->dev, "4-wire\n");
-		pcr |= NI16550_PCR_RS422;
-		acr |= NI16550_ACR_DTR_MANUAL_DTR;
-	}
-
-	dev_dbg(port->dev, "write pcr: 0x%08x\n", pcr);
-	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
-
-	up->acr = acr;
-	port->serial_out(port, UART_SCR, UART_ACR);
-	port->serial_out(port, UART_ICR, up->acr);
-
-	/* Update the cache. */
-	port->rs485 = *rs485;
-
-	return 0;
-}
-
-static int pci_ni8431_setup(struct serial_private *priv,
-		 const struct pciserial_board *board,
-		 struct uart_8250_port *uart, int idx)
-{
-	u8 pcr, acr;
-	struct pci_dev *dev = priv->dev;
-	void __iomem *addr;
-	unsigned int bar, offset = board->first_offset;
-
-	if (idx >= board->num_ports)
-		return 1;
-
-	bar = FL_GET_BASE(board->flags);
-	offset += idx * board->uart_offset;
-
-	addr = pci_ioremap_bar(dev, bar);
-	if (!addr)
-		return -ENOMEM;
-
-	/* enable the transceiver */
-	writeb(readb(addr + NI16550_PCR_OFFSET) | NI16550_PCR_TXVR_ENABLE_BIT,
-		addr + NI16550_PCR_OFFSET);
-
-	pcr = readb(addr + NI16550_PCR_OFFSET);
-	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
-
-	/* set wire mode to default RS-422 */
-	pcr |= NI16550_PCR_RS422;
-	acr = NI16550_ACR_DTR_MANUAL_DTR;
-
-	/* write port configuration to register */
-	writeb(pcr, addr + NI16550_PCR_OFFSET);
-
-	/* access and write to UART acr register */
-	writeb(UART_ACR, addr + UART_SCR);
-	writeb(acr, addr + UART_ICR);
-
-	uart->port.rs485_config = &pci_ni8431_config_rs485;
-
-	iounmap(addr);
-
-	return setup_port(priv, uart, bar, offset, board->reg_shift);
-}
-
 static int pci_netmos_9900_setup(struct serial_private *priv,
 				const struct pciserial_board *board,
 				struct uart_8250_port *port, int idx)
@@ -2023,15 +1912,6 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_ACCESIO_PCIE_COM_8SM	0x10E9
 #define PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM	0x11D8
 
-#define PCIE_DEVICE_ID_NI_PXIE8430_2328	0x74C2
-#define PCIE_DEVICE_ID_NI_PXIE8430_23216	0x74C1
-#define PCI_DEVICE_ID_NI_PXI8431_4852	0x7081
-#define PCI_DEVICE_ID_NI_PXI8431_4854	0x70DE
-#define PCI_DEVICE_ID_NI_PXI8431_4858	0x70E3
-#define PCI_DEVICE_ID_NI_PXI8433_4852	0x70E9
-#define PCI_DEVICE_ID_NI_PXI8433_4854	0x70ED
-#define PCIE_DEVICE_ID_NI_PXIE8431_4858	0x74C4
-#define PCIE_DEVICE_ID_NI_PXIE8431_48516	0x74C3
 
 #define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
@@ -2269,87 +2149,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_ni8430_setup,
 		.exit		= pci_ni8430_exit,
 	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCIE_DEVICE_ID_NI_PXIE8430_2328,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8430_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCIE_DEVICE_ID_NI_PXIE8430_23216,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8430_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCI_DEVICE_ID_NI_PXI8431_4852,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8431_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCI_DEVICE_ID_NI_PXI8431_4854,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8431_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCI_DEVICE_ID_NI_PXI8431_4858,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8431_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCI_DEVICE_ID_NI_PXI8433_4852,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8431_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCI_DEVICE_ID_NI_PXI8433_4854,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8431_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCIE_DEVICE_ID_NI_PXIE8431_4858,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8431_setup,
-		.exit		= pci_ni8430_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_NI,
-		.device		= PCIE_DEVICE_ID_NI_PXIE8431_48516,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.init		= pci_ni8430_init,
-		.setup		= pci_ni8431_setup,
-		.exit		= pci_ni8430_exit,
-	},
 	/* Quatech */
 	{
 		.vendor		= PCI_VENDOR_ID_QUATECH,
@@ -3106,13 +2905,6 @@ enum pci_board_num_t {
 	pbn_ni8430_4,
 	pbn_ni8430_8,
 	pbn_ni8430_16,
-	pbn_ni8430_pxie_8,
-	pbn_ni8430_pxie_16,
-	pbn_ni8431_2,
-	pbn_ni8431_4,
-	pbn_ni8431_8,
-	pbn_ni8431_pxie_8,
-	pbn_ni8431_pxie_16,
 	pbn_ADDIDATA_PCIe_1_3906250,
 	pbn_ADDIDATA_PCIe_2_3906250,
 	pbn_ADDIDATA_PCIe_4_3906250,
@@ -3765,55 +3557,6 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 0x10,
 		.first_offset	= 0x800,
 	},
-	[pbn_ni8430_pxie_16] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 16,
-		.base_baud	= 3125000,
-		.uart_offset	= 0x10,
-		.first_offset	= 0x800,
-	},
-	[pbn_ni8430_pxie_8] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 3125000,
-		.uart_offset	= 0x10,
-		.first_offset	= 0x800,
-	},
-	[pbn_ni8431_8] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 3686400,
-		.uart_offset	= 0x10,
-		.first_offset	= 0x800,
-	},
-	[pbn_ni8431_4] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 4,
-		.base_baud	= 3686400,
-		.uart_offset	= 0x10,
-		.first_offset	= 0x800,
-	},
-	[pbn_ni8431_2] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 3686400,
-		.uart_offset	= 0x10,
-		.first_offset	= 0x800,
-	},
-	[pbn_ni8431_pxie_16] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 16,
-		.base_baud	= 3125000,
-		.uart_offset	= 0x10,
-		.first_offset	= 0x800,
-	},
-	[pbn_ni8431_pxie_8] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 3125000,
-		.uart_offset	= 0x10,
-		.first_offset	= 0x800,
-	},
 	/*
 	 * ADDI-DATA GmbH PCI-Express communication cards <info@addi-data.com>
 	 */
@@ -5567,33 +5310,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2324,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_ni8430_4 },
-	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8430_2328,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_pxie_8 },
-	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8430_23216,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8430_pxie_16 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4852,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8431_2 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4854,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8431_4 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4858,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8431_8 },
-	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8431_4858,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8431_pxie_8 },
-	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8431_48516,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8431_pxie_16 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8433_4852,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8431_2 },
-	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8433_4854,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_ni8431_4 },
 
 	/*
 	 * MOXA
-- 
2.17.1

