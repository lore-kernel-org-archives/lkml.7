Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F73C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619B2214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407263AbfHITBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:01:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41189 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHITBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:01:37 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hwA8s-0006id-80; Fri, 09 Aug 2019 19:01:34 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org, sudipm.mukherjee@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Morris Ku <morris_ku@sunix.com>,
        Debbie Liu <debbie_liu@sunix.com>
Subject: [PATCH v2 1/2] serial: 8250_pci: Add support for Sunix serial boards
Date:   Sat, 10 Aug 2019 03:01:29 +0800
Message-Id: <20190809190130.30773-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Sunix serial boards with up to 16 ports.

Sunix board need its own setup callback instead of using Timedia's, to
properly support more than 4 ports.

Cc: Morris Ku <morris_ku@sunix.com>
Cc: Debbie Liu <debbie_liu@sunix.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 use div64_s64() instead of do_div()

 drivers/tty/serial/8250/8250_pci.c  | 93 +++++++++++++++++++++++------
 drivers/tty/serial/8250/8250_port.c |  8 +++
 include/uapi/linux/serial_core.h    |  3 +
 3 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 7f740b37700b..b2a5c2228858 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1692,6 +1692,30 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+static int
+pci_sunix_setup(struct serial_private *priv,
+		const struct pciserial_board *board,
+		struct uart_8250_port *port, int idx)
+{
+	int bar;
+	int offset;
+
+	port->port.flags |= UPF_FIXED_TYPE;
+	port->port.type = PORT_SUNIX;
+
+	if (idx < 4) {
+		bar = 0;
+		offset = idx * board->uart_offset;
+	} else {
+		bar = 1;
+		idx -= 4;
+		idx = div_s64_rem(idx, 4, &offset);
+		offset = idx * 64 + offset * board->uart_offset;
+	}
+
+	return setup_port(priv, port, bar, offset, 0);
+}
+
 #define PCI_VENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
 #define PCI_DEVICE_ID_OCTPRO		0x0001
@@ -2289,21 +2313,14 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_timedia_setup,
 	},
 	/*
-	 * SUNIX (Timedia) cards
-	 * Do not "probe" for these cards as there is at least one combination
-	 * card that should be handled by parport_pc that doesn't match the
-	 * rule in pci_timedia_probe.
-	 * It is part number is MIO5079A but its subdevice ID is 0x0102.
-	 * There are some boards with part number SER5037AL that report
-	 * subdevice ID 0x0002.
+	 * Sunix PCI serial boards
 	 */
 	{
 		.vendor		= PCI_VENDOR_ID_SUNIX,
 		.device		= PCI_DEVICE_ID_SUNIX_1999,
 		.subvendor	= PCI_VENDOR_ID_SUNIX,
 		.subdevice	= PCI_ANY_ID,
-		.init		= pci_timedia_init,
-		.setup		= pci_timedia_setup,
+		.setup		= pci_sunix_setup,
 	},
 	/*
 	 * Xircom cards
@@ -2757,6 +2774,11 @@ enum pci_board_num_t {
 	pbn_pericom_PI7C9X7952,
 	pbn_pericom_PI7C9X7954,
 	pbn_pericom_PI7C9X7958,
+	pbn_sunix_pci_1s,
+	pbn_sunix_pci_2s,
+	pbn_sunix_pci_4s,
+	pbn_sunix_pci_8s,
+	pbn_sunix_pci_16s,
 };
 
 /*
@@ -3494,6 +3516,31 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[pbn_sunix_pci_1s] = {
+		.num_ports	= 1,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[pbn_sunix_pci_2s] = {
+		.num_ports	= 2,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[pbn_sunix_pci_4s] = {
+		.num_ports	= 4,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[pbn_sunix_pci_8s] = {
+		.num_ports	= 8,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
+	[pbn_sunix_pci_16s] = {
+		.num_ports	= 16,
+		.base_baud      = 921600,
+		.uart_offset	= 0x8,
+	},
 };
 
 static const struct pci_device_id blacklist[] = {
@@ -4532,17 +4579,29 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		pbn_b0_bt_1_921600 },
 
 	/*
-	 * SUNIX (TIMEDIA)
+	 * Sunix PCI serial boards
 	 */
 	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00,
-		pbn_b0_bt_1_921600 },
-
+		PCI_VENDOR_ID_SUNIX, 0x0001, 0, 0,
+		pbn_sunix_pci_1s },
 	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
-		PCI_VENDOR_ID_SUNIX, PCI_ANY_ID,
-		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
-		pbn_b0_bt_1_921600 },
+		PCI_VENDOR_ID_SUNIX, 0x0002, 0, 0,
+		pbn_sunix_pci_2s },
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+		PCI_VENDOR_ID_SUNIX, 0x0004, 0, 0,
+		pbn_sunix_pci_4s },
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+		PCI_VENDOR_ID_SUNIX, 0x0084, 0, 0,
+		pbn_sunix_pci_4s },
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+		PCI_VENDOR_ID_SUNIX, 0x0008, 0, 0,
+		pbn_sunix_pci_8s },
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+		PCI_VENDOR_ID_SUNIX, 0x0088, 0, 0,
+		pbn_sunix_pci_8s },
+	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
+		PCI_VENDOR_ID_SUNIX, 0x0010, 0, 0,
+		pbn_sunix_pci_16s },
 
 	/*
 	 * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c1cec808571b..8900112ed232 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -308,6 +308,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_SUNIX] = {
+		.name		= "Sunix",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.rxtrig_bytes	= {1, 32, 64, 112},
+		.flags		= UART_CAP_FIFO | UART_CAP_SLEEP,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 3cc3af1c2ee1..055626ca0a40 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -290,4 +290,7 @@
 /* SiFive UART */
 #define PORT_SIFIVE_V0	120
 
+/* Sunix UART */
+#define PORT_SUNIX	121
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.17.1

