Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E93DC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B5B21479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 03:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfGBDfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 23:35:02 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:59972 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbfGBDfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:35:02 -0400
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jul 2019 23:34:56 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x623LFYe003135;
        Mon, 1 Jul 2019 22:24:06 -0500
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2tfgpetx9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 22:24:06 -0500
Received: from us-aus-exch2.ni.corp.natinst.com (us-aus-exch2.ni.corp.natinst.com [130.164.68.12])
        by us-aus-skprod3.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x623O5o1026811
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 1 Jul 2019 22:24:05 -0500
Received: from us-aus-exch5.ni.corp.natinst.com (130.164.68.15) by
 us-aus-exch2.ni.corp.natinst.com (130.164.68.12) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 1 Jul 2019 22:24:05 -0500
Received: from us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) by
 us-aus-exch5.ni.corp.natinst.com (130.164.68.15) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 1 Jul 2019 22:24:04 -0500
Received: from my-pen-rd9.apac.corp.natinst.com (130.164.49.7) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 1 Jul 2019 22:24:02 -0500
From:   jeyentam <je.yen.tam@ni.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jeyentam <je.yen.tam@ni.com>
Subject: [PATCH 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485 devices.
Date:   Mon, 1 Jul 2019 20:23:23 -0700
Message-ID: <20190702032323.28967-1-je.yen.tam@ni.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.

Signed-off-by: jeyentam <je.yen.tam@ni.com>
---
 drivers/tty/serial/8250/8250_pci.c | 879 +++++++++++++++++++----------
 1 file changed, 582 insertions(+), 297 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index df41397de478..0a711b895b33 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Probe module for 8250/16550-type PCI serial ports.
+ *	Probe module for 8250/16550-type PCI serial ports.
  *
- *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
+ *	Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
  *
- *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *	Copyright (C) 2001 Russell King, All Rights Reserved.
  */
 #undef DEBUG
 #include <linux/module.h>
@@ -26,9 +26,9 @@
 
 /*
  * init function returns:
- *  > 0 - number of ports
- *  = 0 - use board->num_ports
- *  < 0 - error
+ *	> 0 - number of ports
+ *	= 0 - use board->num_ports
+ *	< 0 - error
  */
 struct pci_serial_quirk {
 	u32	vendor;
@@ -59,13 +59,13 @@ static int pci_default_setup(struct serial_private*,
 static void moan_device(const char *str, struct pci_dev *dev)
 {
 	dev_err(&dev->dev,
-	       "%s: %s\n"
-	       "Please send the output of lspci -vv, this\n"
-	       "message (0x%04x,0x%04x,0x%04x,0x%04x), the\n"
-	       "manufacturer and name of serial board or\n"
-	       "modem board to <linux-serial@vger.kernel.org>.\n",
-	       pci_name(dev), str, dev->vendor, dev->device,
-	       dev->subsystem_vendor, dev->subsystem_device);
+		   "%s: %s\n"
+		   "Please send the output of lspci -vv, this\n"
+		   "message (0x%04x,0x%04x,0x%04x,0x%04x), the\n"
+		   "manufacturer and name of serial board or\n"
+		   "modem board to <linux-serial@vger.kernel.org>.\n",
+		   pci_name(dev), str, dev->vendor, dev->device,
+		   dev->subsystem_vendor, dev->subsystem_device);
 }
 
 static int
@@ -128,7 +128,7 @@ static int addidata_apci7800_setup(struct serial_private *priv,
  */
 static int
 afavlab_setup(struct serial_private *priv, const struct pciserial_board *board,
-	      struct uart_8250_port *port, int idx)
+		  struct uart_8250_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
 
@@ -144,9 +144,9 @@ afavlab_setup(struct serial_private *priv, const struct pciserial_board *board,
 }
 
 /*
- * HP's Remote Management Console.  The Diva chip came in several
- * different versions.  N-class, L2000 and A500 have two Diva chips, each
- * with 3 UARTs (the third UART on the second chip is unused).  Superdome
+ * HP's Remote Management Console.	The Diva chip came in several
+ * different versions.	N-class, L2000 and A500 have two Diva chips, each
+ * with 3 UARTs (the third UART on the second chip is unused).	Superdome
  * and Keystone have one Diva chip with 3 UARTs.  Some later machines have
  * one Diva chip, but it has been expanded to 5 UARTs.
  */
@@ -245,11 +245,11 @@ static int pci_plx9050_init(struct pci_dev *dev)
 
 	irq_config = 0x41;
 	if (dev->vendor == PCI_VENDOR_ID_PANACOM ||
-	    dev->subsystem_vendor == PCI_SUBVENDOR_ID_EXSYS)
+		dev->subsystem_vendor == PCI_SUBVENDOR_ID_EXSYS)
 		irq_config = 0x43;
 
 	if ((dev->vendor == PCI_VENDOR_ID_PLX) &&
-	    (dev->device == PCI_DEVICE_ID_PLX_ROMULUS))
+		(dev->device == PCI_DEVICE_ID_PLX_ROMULUS))
 		/*
 		 * As the megawolf cards have the int pins active
 		 * high, and have 2 UART chips, both ints must be
@@ -317,7 +317,7 @@ static void pci_ni8420_exit(struct pci_dev *dev)
 
 	/* Disable the CPU Interrupt */
 	writel(readl(p + NI8420_INT_ENABLE_REG) & ~(NI8420_INT_ENABLE_BIT),
-	       p + NI8420_INT_ENABLE_REG);
+		   p + NI8420_INT_ENABLE_REG);
 	iounmap(p);
 }
 
@@ -426,15 +426,15 @@ static void sbs_exit(struct pci_dev *dev)
  * hope) because it doesn't touch EEPROM settings to prevent conflicts
  * with other OSes (like M$ DOS).
  *
- *  SIIG support added by Andrey Panin <pazke@donpac.ru>, 10/1999
+ *	SIIG support added by Andrey Panin <pazke@donpac.ru>, 10/1999
  *
  * There is two family of SIIG serial cards with different PCI
  * interface chip and different configuration methods:
- *     - 10x cards have control registers in IO and/or memory space;
- *     - 20x cards have control registers in standard PCI configuration space.
+ *	   - 10x cards have control registers in IO and/or memory space;
+ *	   - 20x cards have control registers in standard PCI configuration space.
  *
  * Note: all 10x cards have PCI device ids 0x10..
- *       all 20x cards have PCI device ids 0x20..
+ *		 all 20x cards have PCI device ids 0x20..
  *
  * There are also Quartet Serial cards which use Oxford Semiconductor
  * 16954 quad UART PCI chip clocked by 18.432 MHz quartz.
@@ -485,7 +485,7 @@ static int pci_siig20x_init(struct pci_dev *dev)
 
 	/* If this card has 2 UART, we have to do the same with second UART. */
 	if (((dev->device & 0xfffc) == PCI_DEVICE_ID_SIIG_2S_20x) ||
-	    ((dev->device & 0xfffc) == PCI_DEVICE_ID_SIIG_2S1P_20x)) {
+		((dev->device & 0xfffc) == PCI_DEVICE_ID_SIIG_2S1P_20x)) {
 		pci_read_config_byte(dev, 0x73, &data);
 		pci_write_config_byte(dev, 0x73, data & 0xef);
 	}
@@ -559,9 +559,9 @@ static const struct timedia_struct {
 };
 
 /*
- * There are nearly 70 different Timedia/SUNIX PCI serial devices.  Instead of
+ * There are nearly 70 different Timedia/SUNIX PCI serial devices.	Instead of
  * listing them individually, this driver merely grabs them all with
- * PCI_ANY_ID.  Some of these devices, however, also feature a parallel port,
+ * PCI_ANY_ID.	Some of these devices, however, also feature a parallel port,
  * and should be left free to be claimed by parport_serial instead.
  */
 static int pci_timedia_probe(struct pci_dev *dev)
@@ -634,8 +634,8 @@ pci_timedia_setup(struct serial_private *priv,
  */
 static int
 titan_400l_800l_setup(struct serial_private *priv,
-		      const struct pciserial_board *board,
-		      struct uart_8250_port *port, int idx)
+			  const struct pciserial_board *board,
+			  struct uart_8250_port *port, int idx)
 {
 	unsigned int bar, offset = board->first_offset;
 
@@ -676,7 +676,7 @@ static int pci_ni8420_init(struct pci_dev *dev)
 
 	/* Enable CPU Interrupt */
 	writel(readl(p + NI8420_INT_ENABLE_REG) | NI8420_INT_ENABLE_BIT,
-	       p + NI8420_INT_ENABLE_REG);
+		   p + NI8420_INT_ENABLE_REG);
 
 	iounmap(p);
 	return 0;
@@ -717,7 +717,7 @@ static int pci_ni8430_init(struct pci_dev *dev)
 
 	/* Set window access to go to RAMSEL IO address space */
 	writel((readl(p + MITE_IOWCR1) & MITE_IOWCR1_RAMSEL_MASK),
-	       p + MITE_IOWCR1);
+		   p + MITE_IOWCR1);
 
 	/* Enable IO Bus Interrupt 0 */
 	writel(MITE_LCIMR1_IO_IE_0, p + MITE_LCIMR1);
@@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
 }
 
 /* UART Port Control Register */
-#define NI8430_PORTCON	0x0f
-#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
+#define NI16550_PCR_OFFSET				  0x0f
+#define NI16550_PCR_RS422				  0x00
+#define NI16550_PCR_ECHO_RS485			  0x01
+#define NI16550_PCR_DTR_RS485			  0x02
+#define NI16550_PCR_AUTO_RS485			  0x03
+#define NI16550_PCR_WIRE_MODE_MASK		  0x03
+#define NI16550_PCR_TXVR_ENABLE_BIT		  (1 << 3)
+#define NI16550_PCR_RS485_TERMINATION_BIT (1 << 6)
+#define NI16550_ACR_DTR_AUTO_DTR		  (0x2 << 3)
+#define NI16550_ACR_DTR_MANUAL_DTR		  (0x0 << 3)
 
 static int
 pci_ni8430_setup(struct serial_private *priv,
@@ -753,14 +761,127 @@ pci_ni8430_setup(struct serial_private *priv,
 		return -ENOMEM;
 
 	/* enable the transceiver */
-	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
-	       p + offset + NI8430_PORTCON);
+	writeb(readb(p + offset + NI16550_PCR_OFFSET) |
+			NI16550_PCR_TXVR_ENABLE_BIT,
+			p + offset + NI16550_PCR_OFFSET);
 
 	iounmap(p);
 
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
+static int pci_ni8431_config_rs485(struct uart_port *port,
+	struct serial_rs485 *rs485)
+{
+	u8 pcr, acr;
+
+	struct uart_8250_port *up;
+
+	up = container_of(port, struct uart_8250_port, port);
+
+	acr = up->acr;
+
+	dev_dbg(port->dev, "ni16550_config_rs485\n");
+
+	/* "rs485" should be given to us non-NULL. */
+	WARN_ON(rs485 == NULL);
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* RS-485 */
+		if ((rs485->flags & SER_RS485_RX_DURING_TX) &&
+			(rs485->flags & SER_RS485_RTS_ON_SEND)) {
+			dev_dbg(port->dev, "Invalid 2-wire mode\n");
+			return -EINVAL;
+		}
+
+		if (rs485->flags & SER_RS485_RX_DURING_TX) {
+			/* Echo */
+			dev_vdbg(port->dev, "2-wire DTR with echo\n");
+			pcr |= NI16550_PCR_ECHO_RS485;
+			acr |= NI16550_ACR_DTR_MANUAL_DTR;
+		} else {
+			/* Auto or DTR */
+			if (rs485->flags & SER_RS485_RTS_ON_SEND) {
+				/* Auto */
+				dev_vdbg(port->dev, "2-wire Auto\n");
+				pcr |= NI16550_PCR_AUTO_RS485;
+				acr |= NI16550_ACR_DTR_AUTO_DTR;
+			} else {
+				/* DTR-controlled */
+				/* No Echo */
+				dev_vdbg(port->dev, "2-wire DTR no echo\n");
+				pcr |= NI16550_PCR_DTR_RS485;
+				acr |= NI16550_ACR_DTR_MANUAL_DTR;
+			}
+		}
+	} else {
+		/* RS-422 */
+		dev_vdbg(port->dev, "4-wire\n");
+		pcr |= NI16550_PCR_RS422;
+		acr |= NI16550_ACR_DTR_MANUAL_DTR;
+	}
+
+	dev_dbg(port->dev, "write pcr: 0x%08x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	up->acr = acr;
+	port->serial_out(port, UART_SCR, UART_ACR);
+	port->serial_out(port, UART_ICR, up->acr);
+
+	/* Update the cache. */
+	port->rs485 = *rs485;
+
+	dev_dbg(port->dev, "ni16550_config_rs485\n");
+	return 0;
+}
+
+static int pci_ni8431_setup(struct serial_private *priv,
+		 const struct pciserial_board *board,
+		 struct uart_8250_port *uart, int idx)
+{
+	u8 pcr, acr;
+	struct pci_dev *dev = priv->dev;
+	void __iomem *addr;
+	unsigned int bar, offset = board->first_offset;
+
+	if (idx >= board->num_ports)
+		return 1;
+
+	bar = FL_GET_BASE(board->flags);
+	offset += idx * board->uart_offset;
+
+	addr = pci_ioremap_bar(dev, bar);
+	if (!addr)
+		return -ENOMEM;
+
+	/* enable the transceiver */
+	writeb(readb(addr + NI16550_PCR_OFFSET) | NI16550_PCR_TXVR_ENABLE_BIT,
+		addr + NI16550_PCR_OFFSET);
+
+	pcr = readb(addr + NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	/* set wire mode to default RS-422 */
+	pcr |= NI16550_PCR_RS422;
+	acr = NI16550_ACR_DTR_MANUAL_DTR;
+
+	/* write port configuration to register */
+	writeb(pcr, addr + NI16550_PCR_OFFSET);
+
+	/* access and write to UART acr register */
+	writeb(UART_ACR, addr + UART_SCR);
+	writeb(acr, addr + UART_ICR);
+
+	uart->port.rs485_config = &pci_ni8431_config_rs485;
+
+	iounmap(addr);
+
+	return setup_port(priv, uart, bar, offset, board->reg_shift);
+}
+
 static int pci_netmos_9900_setup(struct serial_private *priv,
 				const struct pciserial_board *board,
 				struct uart_8250_port *port, int idx)
@@ -768,7 +889,7 @@ static int pci_netmos_9900_setup(struct serial_private *priv,
 	unsigned int bar;
 
 	if ((priv->dev->device != PCI_DEVICE_ID_NETMOS_9865) &&
-	    (priv->dev->subsystem_device & 0xff00) == 0x3000) {
+		(priv->dev->subsystem_device & 0xff00) == 0x3000) {
 		/* netmos apparently orders BARs by datasheet layout, so serial
 		 * ports get BARs 0 and 3 (or 1 and 4 for memmapped)
 		 */
@@ -784,7 +905,7 @@ static int pci_netmos_9900_setup(struct serial_private *priv,
  * of capabilities:
  *
  * 9900 has varying capabilities and can cascade to sub-controllers
- *   (cascading should be purely internal)
+ *	 (cascading should be purely internal)
  * 9904 is hardwired with 4 serial ports
  * 9912 and 9922 are hardwired with 2 serial ports
  */
@@ -1030,7 +1151,7 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 
 	/* OxSemi Tornado devices are all 0xCxxx */
 	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
-	    (dev->device & 0xF000) != 0xC000)
+		(dev->device & 0xF000) != 0xC000)
 		return 0;
 
 	p = pci_iomap(dev, 0, 5);
@@ -1081,10 +1202,10 @@ struct quatech_feature {
 
 
 static struct quatech_feature quatech_cards[] = {
-	{ PCI_DEVICE_ID_QUATECH_QSC100,   1 },
-	{ PCI_DEVICE_ID_QUATECH_DSC100,   1 },
+	{ PCI_DEVICE_ID_QUATECH_QSC100,	  1 },
+	{ PCI_DEVICE_ID_QUATECH_DSC100,	  1 },
 	{ PCI_DEVICE_ID_QUATECH_DSC100E,  0 },
-	{ PCI_DEVICE_ID_QUATECH_DSC200,   1 },
+	{ PCI_DEVICE_ID_QUATECH_DSC200,	  1 },
 	{ PCI_DEVICE_ID_QUATECH_DSC200E,  0 },
 	{ PCI_DEVICE_ID_QUATECH_ESC100D,  1 },
 	{ PCI_DEVICE_ID_QUATECH_ESC100M,  1 },
@@ -1237,7 +1358,7 @@ static int pci_quatech_clock(struct uart_8250_port *port)
 	}
 	reg &= QOPR_CLOCK_X8;
 	if (reg == QOPR_CLOCK_X2) {
-		clock =  3685400;
+		clock =	 3685400;
 		set = QOPR_CLOCK_X2;
 	} else if (reg == QOPR_CLOCK_X4) {
 		clock = 7372800;
@@ -1369,8 +1490,8 @@ ce4100_serial_setup(struct serial_private *priv,
 
 static int
 pci_omegapci_setup(struct serial_private *priv,
-		      const struct pciserial_board *board,
-		      struct uart_8250_port *port, int idx)
+			  const struct pciserial_board *board,
+			  struct uart_8250_port *port, int idx)
 {
 	return setup_port(priv, port, 2, idx * 8, 0);
 }
@@ -1394,7 +1515,7 @@ pci_brcm_trumanage_setup(struct serial_private *priv,
 
 /* We should do proper H/W transceiver setting before change to RS485 mode */
 static int pci_fintek_rs485_config(struct uart_port *port,
-			       struct serial_rs485 *rs485)
+				   struct serial_rs485 *rs485)
 {
 	struct pci_dev *pci_dev = to_pci_dev(port->dev);
 	u8 setting;
@@ -1440,8 +1561,8 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 }
 
 static int pci_fintek_setup(struct serial_private *priv,
-			    const struct pciserial_board *board,
-			    struct uart_8250_port *port, int idx)
+				const struct pciserial_board *board,
+				struct uart_8250_port *port, int idx)
 {
 	struct pci_dev *pdev = priv->dev;
 	u8 *data;
@@ -1574,7 +1695,7 @@ static unsigned int kt_serial_in(struct uart_port *p, int offset)
 	 * When the Intel ME (management engine) gets reset its serial
 	 * port registers could return 0 momentarily.  Functions like
 	 * serial8250_console_write, read and save the IER, perform
-	 * some operation and then restore it.  In order to avoid
+	 * some operation and then restore it.	In order to avoid
 	 * setting IER register inadvertently to 0, if the value read
 	 * is 0, double check with ier value in uart_8250_port and use
 	 * that instead.  up->ier should be the same value as what is
@@ -1609,8 +1730,8 @@ static int pci_eg20t_init(struct pci_dev *dev)
 
 static int
 pci_wch_ch353_setup(struct serial_private *priv,
-		    const struct pciserial_board *board,
-		    struct uart_8250_port *port, int idx)
+			const struct pciserial_board *board,
+			struct uart_8250_port *port, int idx)
 {
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16550A;
@@ -1629,8 +1750,8 @@ pci_wch_ch355_setup(struct serial_private *priv,
 
 static int
 pci_wch_ch38x_setup(struct serial_private *priv,
-		    const struct pciserial_board *board,
-		    struct uart_8250_port *port, int idx)
+			const struct pciserial_board *board,
+			struct uart_8250_port *port, int idx)
 {
 	port->port.flags |= UPF_FIXED_TYPE;
 	port->port.type = PORT_16850;
@@ -1750,15 +1871,15 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
 	*/
 	{
-		.vendor         = PCI_VENDOR_ID_AMCC,
-		.device         = PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = addidata_apci7800_setup,
+		.vendor			= PCI_VENDOR_ID_AMCC,
+		.device			= PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= addidata_apci7800_setup,
 	},
 	/*
 	 * AFAVLAB cards - these may be called via parport_serial
-	 *  It is not clear whether this applies to all products.
+	 *	It is not clear whether this applies to all products.
 	 */
 	{
 		.vendor		= PCI_VENDOR_ID_AFAVLAB,
@@ -1956,6 +2077,87 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_ni8430_setup,
 		.exit		= pci_ni8430_exit,
 	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8430_2328,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8430_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8430_23216,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8430_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8431_4852,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8431_4854,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8431_4858,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8433_4852,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCI_DEVICE_ID_NI_PXI8433_4854,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8431_4858,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_NI,
+		.device		= PCIE_DEVICE_ID_NI_PXIE8431_48516,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_ni8430_init,
+		.setup		= pci_ni8431_setup,
+		.exit		= pci_ni8430_exit,
+	},
 	/* Quatech */
 	{
 		.vendor		= PCI_VENDOR_ID_QUATECH,
@@ -2028,109 +2230,109 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.exit		= pci_plx9050_exit,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SDB,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4S,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4S,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4DB,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_MPCIE_COM232_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SMDB,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4SM,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_MPCIE_COM_4SM,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_MPCIE_ICM422_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_MPCIE_ICM485_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4S,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_ICM232_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_MPCIE_ICM232_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_COM422_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_COM485_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_COM232_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_COM_4SM,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	{
-		.vendor     = PCI_VENDOR_ID_ACCESIO,
-		.device     = PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM,
-		.subvendor  = PCI_ANY_ID,
-		.subdevice  = PCI_ANY_ID,
-		.setup      = pci_pericom_setup,
+		.vendor		= PCI_VENDOR_ID_ACCESIO,
+		.device		= PCI_DEVICE_ID_ACCESIO_PCIE_ICM_4SM,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
 	},
 	/*
 	 * SBS Technologies, Inc., PMC-OCTALPRO 232
@@ -2305,72 +2507,72 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = PCI_VENDOR_ID_INTEL,
-		.device         = 0x8811,
+		.vendor			= PCI_VENDOR_ID_INTEL,
+		.device			= 0x8811,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = PCI_VENDOR_ID_INTEL,
-		.device         = 0x8812,
+		.vendor			= PCI_VENDOR_ID_INTEL,
+		.device			= 0x8812,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = PCI_VENDOR_ID_INTEL,
-		.device         = 0x8813,
+		.vendor			= PCI_VENDOR_ID_INTEL,
+		.device			= 0x8813,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = PCI_VENDOR_ID_INTEL,
-		.device         = 0x8814,
+		.vendor			= PCI_VENDOR_ID_INTEL,
+		.device			= 0x8814,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = 0x10DB,
-		.device         = 0x8027,
+		.vendor			= 0x10DB,
+		.device			= 0x8027,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = 0x10DB,
-		.device         = 0x8028,
+		.vendor			= 0x10DB,
+		.device			= 0x8028,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = 0x10DB,
-		.device         = 0x8029,
+		.vendor			= 0x10DB,
+		.device			= 0x8029,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = 0x10DB,
-		.device         = 0x800C,
+		.vendor			= 0x10DB,
+		.device			= 0x800C,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
 		.setup		= pci_default_setup,
 	},
 	{
-		.vendor         = 0x10DB,
-		.device         = 0x800D,
+		.vendor			= 0x10DB,
+		.device			= 0x800D,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_eg20t_init,
@@ -2388,35 +2590,35 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	},
 	/* WCH CH353 1S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_1S1P,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = pci_wch_ch353_setup,
+		.vendor			= PCI_VENDOR_ID_WCH,
+		.device			= PCI_DEVICE_ID_WCH_CH353_1S1P,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1P card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1P,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = pci_wch_ch353_setup,
+		.vendor			= PCI_VENDOR_ID_WCH,
+		.device			= PCI_DEVICE_ID_WCH_CH353_2S1P,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= pci_wch_ch353_setup,
 	},
 	/* WCH CH353 4S card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_4S,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = pci_wch_ch353_setup,
+		.vendor			= PCI_VENDOR_ID_WCH,
+		.device			= PCI_DEVICE_ID_WCH_CH353_4S,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= pci_wch_ch353_setup,
 	},
 	/* WCH CH353 2S1PF card (16550 clone) */
 	{
-		.vendor         = PCI_VENDOR_ID_WCH,
-		.device         = PCI_DEVICE_ID_WCH_CH353_2S1PF,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = pci_wch_ch353_setup,
+		.vendor			= PCI_VENDOR_ID_WCH,
+		.device			= PCI_DEVICE_ID_WCH_CH353_2S1PF,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= pci_wch_ch353_setup,
 	},
 	/* WCH CH352 2S card (16550 clone) */
 	{
@@ -2436,27 +2638,27 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	},
 	/* WCH CH382 2S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = pci_wch_ch38x_setup,
+		.vendor			= PCIE_VENDOR_ID_WCH,
+		.device			= PCIE_DEVICE_ID_WCH_CH382_2S,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= pci_wch_ch38x_setup,
 	},
 	/* WCH CH382 2S1P card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH382_2S1P,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = pci_wch_ch38x_setup,
+		.vendor			= PCIE_VENDOR_ID_WCH,
+		.device			= PCIE_DEVICE_ID_WCH_CH382_2S1P,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= pci_wch_ch38x_setup,
 	},
 	/* WCH CH384 4S card (16850 clone) */
 	{
-		.vendor         = PCIE_VENDOR_ID_WCH,
-		.device         = PCIE_DEVICE_ID_WCH_CH384_4S,
-		.subvendor      = PCI_ANY_ID,
-		.subdevice      = PCI_ANY_ID,
-		.setup          = pci_wch_ch38x_setup,
+		.vendor			= PCIE_VENDOR_ID_WCH,
+		.device			= PCIE_DEVICE_ID_WCH_CH384_4S,
+		.subvendor		= PCI_ANY_ID,
+		.subdevice		= PCI_ANY_ID,
+		.setup			= pci_wch_ch38x_setup,
 	},
 	/*
 	 * ASIX devices with FIFO bug
@@ -2526,9 +2728,9 @@ static struct pci_serial_quirk *find_quirk(struct pci_dev *dev)
 
 	for (quirk = pci_serial_quirks; ; quirk++)
 		if (quirk_id_matches(quirk->vendor, dev->vendor) &&
-		    quirk_id_matches(quirk->device, dev->device) &&
-		    quirk_id_matches(quirk->subvendor, dev->subsystem_vendor) &&
-		    quirk_id_matches(quirk->subdevice, dev->subsystem_device))
+			quirk_id_matches(quirk->device, dev->device) &&
+			quirk_id_matches(quirk->subvendor, dev->subsystem_vendor) &&
+			quirk_id_matches(quirk->subdevice, dev->subsystem_device))
 			break;
 	return quirk;
 }
@@ -2549,13 +2751,13 @@ static inline int get_pci_irq(struct pci_dev *dev,
  * driver_data member.
  *
  * The makeup of these names are:
- *  pbn_bn{_bt}_n_baud{_offsetinhex}
+ *	pbn_bn{_bt}_n_baud{_offsetinhex}
  *
- *  bn		= PCI BAR number
- *  bt		= Index using PCI BARs
- *  n		= number of serial ports
- *  baud	= baud rate
- *  offsetinhex	= offset for each sequential port (in hex)
+ *	bn		= PCI BAR number
+ *	bt		= Index using PCI BARs
+ *	n		= number of serial ports
+ *	baud	= baud rate
+ *	offsetinhex	= offset for each sequential port (in hex)
  *
  * This table is sorted by (in order): bn, bt, baud, offsetindex, n.
  *
@@ -2679,6 +2881,13 @@ enum pci_board_num_t {
 	pbn_ni8430_4,
 	pbn_ni8430_8,
 	pbn_ni8430_16,
+	pbn_ni8430_pxie_8,
+	pbn_ni8430_pxie_16,
+	pbn_ni8431_2,
+	pbn_ni8431_4,
+	pbn_ni8431_8,
+	pbn_ni8431_pxie_8,
+	pbn_ni8431_pxie_16,
 	pbn_ADDIDATA_PCIe_1_3906250,
 	pbn_ADDIDATA_PCIe_2_3906250,
 	pbn_ADDIDATA_PCIe_4_3906250,
@@ -2701,7 +2910,7 @@ enum pci_board_num_t {
 /*
  * uart_offset - the space between channels
  * reg_shift   - describes how the UART registers are mapped
- *               to PCI memory by the card.
+ *				 to PCI memory by the card.
  * For example IER register on SBS, Inc. PMC-OctPro is located at
  * offset 0x10 from the UART base, while UART_IER is defined as 1
  * in include/linux/serial_reg.h,
@@ -2765,10 +2974,10 @@ static struct pciserial_board pci_boards[] = {
 	},
 
 	[pbn_b0_2_1130000] = {
-		.flags          = FL_BASE0,
-		.num_ports      = 2,
-		.base_baud      = 1130000,
-		.uart_offset    = 8,
+		.flags			= FL_BASE0,
+		.num_ports		= 2,
+		.base_baud		= 1130000,
+		.uart_offset	= 8,
 	},
 
 	[pbn_b0_4_1152000] = {
@@ -3000,10 +3209,10 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 8,
 	},
 	[pbn_b2_4_115200] = {
-		.flags          = FL_BASE2,
-		.num_ports      = 4,
-		.base_baud      = 115200,
-		.uart_offset    = 8,
+		.flags			= FL_BASE2,
+		.num_ports		= 4,
+		.base_baud		= 115200,
+		.uart_offset	= 8,
 	},
 	[pbn_b2_8_115200] = {
 		.flags		= FL_BASE2,
@@ -3320,6 +3529,55 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 0x10,
 		.first_offset	= 0x800,
 	},
+	[pbn_ni8430_pxie_16] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 16,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8430_pxie_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_4] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_2] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 3686400,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_pxie_16] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 16,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
+	[pbn_ni8431_pxie_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 3125000,
+		.uart_offset	= 0x10,
+		.first_offset	= 0x800,
+	},
 	/*
 	 * ADDI-DATA GmbH PCI-Express communication cards <info@addi-data.com>
 	 */
@@ -3355,7 +3613,7 @@ static struct pciserial_board pci_boards[] = {
 		.flags		= FL_BASE_BARS,
 		.num_ports	= 2,
 		.base_baud	= 921600,
-		.reg_shift      = 2,
+		.reg_shift		= 2,
 	},
 	[pbn_omegapci] = {
 		.flags		= FL_BASE0,
@@ -3402,35 +3660,35 @@ static struct pciserial_board pci_boards[] = {
 	[pbn_wch384_4] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
-		.base_baud      = 115200,
-		.uart_offset    = 8,
-		.first_offset   = 0xC0,
+		.base_baud		= 115200,
+		.uart_offset	= 8,
+		.first_offset	= 0xC0,
 	},
 	/*
 	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
 	 */
 	[pbn_pericom_PI7C9X7951] = {
-		.flags          = FL_BASE0,
-		.num_ports      = 1,
-		.base_baud      = 921600,
+		.flags			= FL_BASE0,
+		.num_ports		= 1,
+		.base_baud		= 921600,
 		.uart_offset	= 0x8,
 	},
 	[pbn_pericom_PI7C9X7952] = {
-		.flags          = FL_BASE0,
-		.num_ports      = 2,
-		.base_baud      = 921600,
+		.flags			= FL_BASE0,
+		.num_ports		= 2,
+		.base_baud		= 921600,
 		.uart_offset	= 0x8,
 	},
 	[pbn_pericom_PI7C9X7954] = {
-		.flags          = FL_BASE0,
-		.num_ports      = 4,
-		.base_baud      = 921600,
+		.flags			= FL_BASE0,
+		.num_ports		= 4,
+		.base_baud		= 921600,
 		.uart_offset	= 0x8,
 	},
 	[pbn_pericom_PI7C9X7958] = {
-		.flags          = FL_BASE0,
-		.num_ports      = 8,
-		.base_baud      = 921600,
+		.flags			= FL_BASE0,
+		.num_ports		= 8,
+		.base_baud		= 921600,
 		.uart_offset	= 0x8,
 	},
 };
@@ -3492,9 +3750,9 @@ static int serial_pci_is_class_communication(struct pci_dev *dev)
 	 * interface is greater than 6, give up.
 	 */
 	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
-	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MULTISERIAL) &&
-	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
-	    (dev->class & 0xff) > 6)
+		 ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MULTISERIAL) &&
+		 ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
+		(dev->class & 0xff) > 6)
 		return -ENODEV;
 
 	return 0;
@@ -3534,7 +3792,7 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 
 	/*
 	 * If there is 1 or 0 iomem regions, and exactly one port,
-	 * use it.  We guess the number of ports based on the IO
+	 * use it.	We guess the number of ports based on the IO
 	 * region size.
 	 */
 	if (num_iomem <= 1 && num_port == 1) {
@@ -3552,8 +3810,8 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 	num_port = 0;
 	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO &&
-		    pci_resource_len(dev, i) == 8 &&
-		    (first_port == -1 || (first_port + num_port) == i)) {
+			pci_resource_len(dev, i) == 8 &&
+			(first_port == -1 || (first_port + num_port) == i)) {
 			num_port++;
 			if (first_port == -1)
 				first_port = i;
@@ -3574,11 +3832,11 @@ serial_pci_matches(const struct pciserial_board *board,
 		   const struct pciserial_board *guessed)
 {
 	return
-	    board->num_ports == guessed->num_ports &&
-	    board->base_baud == guessed->base_baud &&
-	    board->uart_offset == guessed->uart_offset &&
-	    board->reg_shift == guessed->reg_shift &&
-	    board->first_offset == guessed->first_offset;
+		board->num_ports == guessed->num_ports &&
+		board->base_baud == guessed->base_baud &&
+		board->uart_offset == guessed->uart_offset &&
+		board->reg_shift == guessed->reg_shift &&
+		board->first_offset == guessed->first_offset;
 }
 
 struct serial_private *
@@ -3599,9 +3857,9 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 	/*
 	 * Run the new-style initialization function.
 	 * The initialization function returns:
-	 *  <0  - error
-	 *   0  - use board->num_ports
-	 *  >0  - number of ports
+	 *	<0	- error
+	 *	 0	- use board->num_ports
+	 *	>0	- number of ports
 	 */
 	if (quirk->init) {
 		rc = quirk->init(dev);
@@ -3614,8 +3872,8 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 	}
 
 	priv = kzalloc(sizeof(struct serial_private) +
-		       sizeof(unsigned int) * nr_ports,
-		       GFP_KERNEL);
+			   sizeof(unsigned int) * nr_ports,
+			   GFP_KERNEL);
 	if (!priv) {
 		priv = ERR_PTR(-ENOMEM);
 		goto err_deinit;
@@ -3714,7 +3972,7 @@ void pciserial_resume_ports(struct serial_private *priv)
 EXPORT_SYMBOL_GPL(pciserial_resume_ports);
 
 /*
- * Probe one serial board.  Unfortunately, there is no rhyme nor reason
+ * Probe one serial board.	Unfortunately, there is no rhyme nor reason
  * to the arrangement of serial ports on a PCI card.
  */
 static int
@@ -3760,7 +4018,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 		board = &tmp;
 
 		/*
-		 * We matched one of our class entries.  Try to
+		 * We matched one of our class entries.	 Try to
 		 * determine the parameters of this board.
 		 */
 		rc = serial_pci_guess_board(dev, &tmp);
@@ -3773,11 +4031,11 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 		 * then we no longer need this entry.
 		 */
 		memcpy(&tmp, &pci_boards[pbn_default],
-		       sizeof(struct pciserial_board));
+			   sizeof(struct pciserial_board));
 		rc = serial_pci_guess_board(dev, &tmp);
 		if (rc == 0 && serial_pci_matches(board, &tmp))
 			moan_device("Redundant entry in serial pci_table.",
-				    dev);
+					dev);
 	}
 
 	priv = pciserial_init_ports(dev, board);
@@ -4015,7 +4273,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		pbn_plx_romulus },
 	/*
 	* EndRun Technologies. PCI express device range.
-	*    EndRun PTP/1588 has 2 Native UARTs.
+	*	 EndRun PTP/1588 has 2 Native UARTs.
 	*/
 	{	PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -4098,7 +4356,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 
 		/*
 		 * The below card is a little controversial since it is the
-		 * subject of a PCI vendor/device ID clash.  (See
+		 * subject of a PCI vendor/device ID clash.	 (See
 		 * www.ussg.iu.edu/hypermail/linux/kernel/0303.1/0516.html).
 		 * For now just used the hex ID 0x950a.
 		 */
@@ -4127,136 +4385,136 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Oxford Semiconductor Inc. Tornado PCI express device range.
 	 */
-	{	PCI_VENDOR_ID_OXSEMI, 0xc101,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc101,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc105,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc105,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc11b,    /* OXPCIe952 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc11b,	 /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc11f,    /* OXPCIe952 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc11f,	 /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc120,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc120,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc124,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc124,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc138,    /* OXPCIe952 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc138,	 /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc13d,    /* OXPCIe952 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc13d,	 /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc140,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc140,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc141,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc141,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc144,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc144,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc145,    /* OXPCIe952 1 Legacy UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc145,	 /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc158,    /* OXPCIe952 2 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc158,	 /* OXPCIe952 2 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_2_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc15d,    /* OXPCIe952 2 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc15d,	 /* OXPCIe952 2 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_2_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc208,    /* OXPCIe954 4 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc208,	 /* OXPCIe954 4 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_4_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc20d,    /* OXPCIe954 4 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc20d,	 /* OXPCIe954 4 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_4_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc308,    /* OXPCIe958 8 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc308,	 /* OXPCIe958 8 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_8_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc30d,    /* OXPCIe958 8 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc30d,	 /* OXPCIe958 8 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_8_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc40b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc40b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc40f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc40f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc41b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc41b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc41f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc41f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc42b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc42b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc42f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc42f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc43b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc43b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc43f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc43f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc44b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc44b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc44f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc44f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc45b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc45b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc45f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc45f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc46b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc46b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc46f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc46f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc47b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc47b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc47f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc47f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc48b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc48b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc48f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc48f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc49b,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc49b,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc49f,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc49f,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4ab,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc4ab,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4af,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc4af,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4bb,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc4bb,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4bf,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc4bf,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4cb,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc4cb,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
-	{	PCI_VENDOR_ID_OXSEMI, 0xc4cf,    /* OXPCIe200 1 Native UART */
+	{	PCI_VENDOR_ID_OXSEMI, 0xc4cf,	 /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_1_4000000 },
 	/*
@@ -4308,7 +4566,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 
 	/*
 	 * Titan Electronic cards
-	 *  The 400L and 800L have a custom setup quirk.
+	 *	The 400L and 800L have a custom setup quirk.
 	 */
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -4644,19 +4902,19 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
 	 */
-	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7951,
+	{	PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7951,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0,
 		0, pbn_pericom_PI7C9X7951 },
-	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7952,
+	{	PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7952,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0,
 		0, pbn_pericom_PI7C9X7952 },
-	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7954,
+	{	PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7954,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0,
 		0, pbn_pericom_PI7C9X7954 },
-	{   PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7958,
+	{	PCI_VENDOR_ID_PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7958,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0,
 		0, pbn_pericom_PI7C9X7958 },
@@ -4786,7 +5044,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * IntaShield IS-400
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	 /* 135a.0dc0 */
 		pbn_b2_4_115200 },
 	/*
 	 * BrainBoxes UC-260
@@ -4802,10 +5060,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * Perle PCI-RAS cards
 	 */
-	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+	{		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
 		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS4,
 		0, 0, pbn_b2_4_921600 },
-	{       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+	{		PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
 		PCI_SUBVENDOR_ID_PERLE, PCI_SUBDEVICE_ID_PCI_RAS8,
 		0, 0, pbn_b2_8_921600 },
 
@@ -5003,6 +5261,33 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PCI8432_2324,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_ni8430_4 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8430_2328,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_pxie_8 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8430_23216,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8430_pxie_16 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4852,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4854,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_4 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8431_4858,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_8 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8431_4858,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_pxie_8 },
+	{	PCI_VENDOR_ID_NI, PCIE_DEVICE_ID_NI_PXIE8431_48516,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_pxie_16 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8433_4852,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_2 },
+	{	PCI_VENDOR_ID_NI, PCI_DEVICE_ID_NI_PXI8433_4854,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_ni8431_4 },
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
@@ -5179,7 +5464,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0, pbn_b0_bt_4_115200 },
 	/* Intel CE4100 */
 	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CE4100_UART,
-		PCI_ANY_ID,  PCI_ANY_ID, 0, 0,
+		PCI_ANY_ID,	 PCI_ANY_ID, 0, 0,
 		pbn_ce4100_1_115200 },
 
 	/*
@@ -5314,8 +5599,8 @@ static struct pci_driver serial_pci_driver = {
 	.name		= "serial",
 	.probe		= pciserial_init_one,
 	.remove		= pciserial_remove_one,
-	.driver         = {
-		.pm     = &pciserial_pm_ops,
+	.driver			= {
+		.pm		= &pciserial_pm_ops,
 	},
 	.id_table	= serial_pci_tbl,
 	.err_handler	= &serial8250_err_handler,
-- 
2.17.1

