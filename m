Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD8C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD0E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfDYIlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:41:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41610 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726030AbfDYIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:41:41 -0400
X-UUID: b75eb9a231294e17b2404f140b9fbb94-20190425
X-UUID: b75eb9a231294e17b2404f140b9fbb94-20190425
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1392580406; Thu, 25 Apr 2019 16:41:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 25 Apr 2019 16:41:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 25 Apr 2019 16:41:34 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Long Cheng <long.cheng@mediatek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Shih <pihsun@chromium.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Changqi Hu <changqi.hu@mediatek.com>
Subject: [PATCH 1/2] serial: 8250-mtk: add follow control
Date:   Thu, 25 Apr 2019 16:41:30 +0800
Message-ID: <1556181691-10293-2-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com>
References: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SW and HW follow control function.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c |   60 ++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c1fdbc0..959fd85 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -21,12 +21,14 @@
 
 #include "8250.h"
 
-#define UART_MTK_HIGHS		0x09	/* Highspeed register */
-#define UART_MTK_SAMPLE_COUNT	0x0a	/* Sample count register */
-#define UART_MTK_SAMPLE_POINT	0x0b	/* Sample point register */
+#define MTK_UART_HIGHS		0x09	/* Highspeed register */
+#define MTK_UART_SAMPLE_COUNT	0x0a	/* Sample count register */
+#define MTK_UART_SAMPLE_POINT	0x0b	/* Sample point register */
 #define MTK_UART_RATE_FIX	0x0d	/* UART Rate Fix Register */
-
 #define MTK_UART_DMA_EN		0x13	/* DMA Enable register */
+#define MTK_UART_RXTRI_AD	0x14	/* RX Trigger address */
+#define MTK_UART_FRACDIV_L	0x15	/* Fractional divider LSB address */
+#define MTK_UART_FRACDIV_M	0x16	/* Fractional divider MSB address */
 #define MTK_UART_DMA_EN_TX	0x2
 #define MTK_UART_DMA_EN_RX	0x5
 
@@ -46,6 +48,7 @@ enum dma_rx_status {
 struct mtk8250_data {
 	int			line;
 	unsigned int		rx_pos;
+	unsigned int		clk_count;
 	struct clk		*uart_clk;
 	struct clk		*bus_clk;
 	struct uart_8250_dma	*dma;
@@ -196,9 +199,15 @@ static void mtk8250_shutdown(struct uart_port *port)
 mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
 {
+	unsigned short fraction_L_mapping[] = {
+		0, 1, 0x5, 0x15, 0x55, 0x57, 0x57, 0x77, 0x7F, 0xFF, 0xFF
+	};
+	unsigned short fraction_M_mapping[] = {
+		0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 3
+	};
 	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int baud, quot, fraction;
 	unsigned long flags;
-	unsigned int baud, quot;
 
 #ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma) {
@@ -214,7 +223,7 @@ static void mtk8250_shutdown(struct uart_port *port)
 	serial8250_do_set_termios(port, termios, old);
 
 	/*
-	 * Mediatek UARTs use an extra highspeed register (UART_MTK_HIGHS)
+	 * Mediatek UARTs use an extra highspeed register (MTK_UART_HIGHS)
 	 *
 	 * We need to recalcualte the quot register, as the claculation depends
 	 * on the vaule in the highspeed register.
@@ -230,18 +239,11 @@ static void mtk8250_shutdown(struct uart_port *port)
 				  port->uartclk / 16 / UART_DIV_MAX,
 				  port->uartclk);
 
-	if (baud <= 115200) {
-		serial_port_out(port, UART_MTK_HIGHS, 0x0);
+	if (baud < 115200) {
+		serial_port_out(port, MTK_UART_HIGHS, 0x0);
 		quot = uart_get_divisor(port, baud);
-	} else if (baud <= 576000) {
-		serial_port_out(port, UART_MTK_HIGHS, 0x2);
-
-		/* Set to next lower baudrate supported */
-		if ((baud == 500000) || (baud == 576000))
-			baud = 460800;
-		quot = DIV_ROUND_UP(port->uartclk, 4 * baud);
 	} else {
-		serial_port_out(port, UART_MTK_HIGHS, 0x3);
+		serial_port_out(port, MTK_UART_HIGHS, 0x3);
 		quot = DIV_ROUND_UP(port->uartclk, 256 * baud);
 	}
 
@@ -258,17 +260,29 @@ static void mtk8250_shutdown(struct uart_port *port)
 	/* reset DLAB */
 	serial_port_out(port, UART_LCR, up->lcr);
 
-	if (baud > 460800) {
+	if (baud >= 115200) {
 		unsigned int tmp;
 
-		tmp = DIV_ROUND_CLOSEST(port->uartclk, quot * baud);
-		serial_port_out(port, UART_MTK_SAMPLE_COUNT, tmp - 1);
-		serial_port_out(port, UART_MTK_SAMPLE_POINT,
-					(tmp - 2) >> 1);
+		tmp = (port->uartclk / (baud *  quot)) - 1;
+		serial_port_out(port, MTK_UART_SAMPLE_COUNT, tmp);
+		serial_port_out(port, MTK_UART_SAMPLE_POINT,
+					(tmp >> 1) - 1);
+
+		/*count fraction to set fractoin register */
+		fraction = ((port->uartclk  * 100) / baud / quot) % 100;
+		fraction = DIV_ROUND_CLOSEST(fraction, 10);
+		serial_port_out(port, MTK_UART_FRACDIV_L,
+						fraction_L_mapping[fraction]);
+		serial_port_out(port, MTK_UART_FRACDIV_M,
+						fraction_M_mapping[fraction]);
 	} else {
-		serial_port_out(port, UART_MTK_SAMPLE_COUNT, 0x00);
-		serial_port_out(port, UART_MTK_SAMPLE_POINT, 0xff);
+		serial_port_out(port, MTK_UART_SAMPLE_COUNT, 0x00);
+		serial_port_out(port, MTK_UART_SAMPLE_POINT, 0xff);
+		serial_port_out(port, MTK_UART_FRACDIV_L, 0x00);
+		serial_port_out(port, MTK_UART_FRACDIV_M, 0x00);
 	}
+	if (uart_console(port))
+		up->port.cons->cflag = termios->c_cflag;
 
 	spin_unlock_irqrestore(&port->lock, flags);
 	/* Don't rewrite B0 */
-- 
1.7.9.5

