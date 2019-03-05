Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED223C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AB720848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfCELqr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:46:47 -0500
Received: from mail.hanoverdisplays.com ([81.145.148.229]:35787 "EHLO
        mail.hanoverdisplays.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCELqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:46:47 -0500
Received: from builder.hanover.local (192.168.0.21) by
 mail.hanoverdisplays.com (192.168.0.30) with Microsoft SMTP Server (TLS) id
 14.3.435.0; Tue, 5 Mar 2019 11:46:42 +0000
From:   Christina Quast <cquast@hanoverdisplays.com>
CC:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <u.kleine-koenig@pengutronix.de>,
        Christina Quast <cquast@hanoverdisplays.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] serial: imx: Rename URTX0 to UTXD, URXD0 to URXD
Date:   Tue, 5 Mar 2019 11:45:55 +0000
Message-ID: <20190305114555.16882-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222205520.fvqpttlzq5lycbvu@pengutronix.de>
References: <20190222205520.fvqpttlzq5lycbvu@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [192.168.0.21]
X-GFI-SMTP-Submission: 1
X-GFI-SMTP-HelloDomain: builder.hanover.local
X-GFI-SMTP-RemoteIP: 192.168.0.21
X-GFIME-MASPAM: SPAM
Disclaimer: hanoverdisplays.com
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename to be coherent with the datasheet.

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 drivers/tty/serial/imx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff75dc94731..8edb368690d9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -39,8 +39,8 @@
 #include "serial_mctrl_gpio.h"
 
 /* Register definitions */
-#define URXD0 0x0  /* Receiver Register */
-#define URTX0 0x40 /* Transmitter Register */
+#define URXD 0x0  /* Receiver Register */
+#define UTXD 0x40 /* Transmitter Register */
 #define UCR1  0x80 /* Control Register 1 */
 #define UCR2  0x84 /* Control Register 2 */
 #define UCR3  0x88 /* Control Register 3 */
@@ -502,7 +502,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 
 	if (sport->port.x_char) {
 		/* Send next char */
-		imx_uart_writel(sport, sport->port.x_char, URTX0);
+		imx_uart_writel(sport, sport->port.x_char, UTXD);
 		sport->port.icount.tx++;
 		sport->port.x_char = 0;
 		return;
@@ -536,7 +536,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 	       !(imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL)) {
 		/* send xmit->buf[xmit->tail]
 		 * out the port here */
-		imx_uart_writel(sport, xmit->buf[xmit->tail], URTX0);
+		imx_uart_writel(sport, xmit->buf[xmit->tail], UTXD);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		sport->port.icount.tx++;
 	}
@@ -743,7 +743,7 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 		flg = TTY_NORMAL;
 		sport->port.icount.rx++;
 
-		rx = imx_uart_readl(sport, URXD0);
+		rx = imx_uart_readl(sport, URXD);
 
 		usr2 = imx_uart_readl(sport, USR2);
 		if (usr2 & USR2_BRCD) {
@@ -870,7 +870,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 	 * the respective irq source is enabled. This prevents some undesired
 	 * actions, for example if a character that sits in the RX FIFO and that
 	 * should be fetched via DMA is tried to be fetched using PIO. Or the
-	 * receiver is currently off and so reading from URXD0 results in an
+	 * receiver is currently off and so reading from URXD results in an
 	 * exception. So just mask the (raw) status bits for disabled irqs.
 	 */
 	if ((ucr1 & UCR1_RRDYEN) == 0)
@@ -1231,7 +1231,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	}
 
 	slave_config.direction = DMA_DEV_TO_MEM;
-	slave_config.src_addr = sport->port.mapbase + URXD0;
+	slave_config.src_addr = sport->port.mapbase + URXD;
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	/* one byte less than the watermark level to enable the aging timer */
 	slave_config.src_maxburst = RXTL_DMA - 1;
@@ -1257,7 +1257,7 @@ static int imx_uart_dma_init(struct imx_port *sport)
 	}
 
 	slave_config.direction = DMA_MEM_TO_DEV;
-	slave_config.dst_addr = sport->port.mapbase + URTX0;
+	slave_config.dst_addr = sport->port.mapbase + UTXD;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 	slave_config.dst_maxburst = TXTL_DMA;
 	ret = dmaengine_slave_config(sport->dma_chan_tx, &slave_config);
@@ -1798,7 +1798,7 @@ static int imx_uart_poll_get_char(struct uart_port *port)
 	if (!(imx_uart_readl(sport, USR2) & USR2_RDR))
 		return NO_POLL_CHAR;
 
-	return imx_uart_readl(sport, URXD0) & URXD_RX_DATA;
+	return imx_uart_readl(sport, URXD) & URXD_RX_DATA;
 }
 
 static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
@@ -1812,7 +1812,7 @@ static void imx_uart_poll_put_char(struct uart_port *port, unsigned char c)
 	} while (~status & USR1_TRDY);
 
 	/* write */
-	imx_uart_writel(sport, c, URTX0);
+	imx_uart_writel(sport, c, UTXD);
 
 	/* flush */
 	do {
@@ -1894,7 +1894,7 @@ static void imx_uart_console_putchar(struct uart_port *port, int ch)
 	while (imx_uart_readl(sport, imx_uart_uts_reg(sport)) & UTS_TXFULL)
 		barrier();
 
-	imx_uart_writel(sport, ch, URTX0);
+	imx_uart_writel(sport, ch, UTXD);
 }
 
 /*
@@ -2091,7 +2091,7 @@ static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
 	while (imx_uart_readl(sport, IMX21_UTS) & UTS_TXFULL)
 		cpu_relax();
 
-	imx_uart_writel(sport, ch, URTX0);
+	imx_uart_writel(sport, ch, UTXD);
 }
 
 static void imx_uart_console_early_write(struct console *con, const char *s,
-- 
2.20.1




 
Please consider the environment before printing this email
 

 
 
 
The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibited.
If you received this in error, please contact the sender or postmaster (postmaster@hanoverdisplays.com) and delete the material from any computer.
Although we routinely screen for viruses, addressees should check this e-mail and any attachment for viruses. We make no warranty as to absence of viruses in this e-mail or any attachments.
Our Company's email policy is to permit incidental personal use. If this email is of a personal nature, it must not be relied upon as expressing the views or opinions of the company.

