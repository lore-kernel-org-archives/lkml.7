Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53564C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20465217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfDYIly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:41:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63329 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbfDYIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:41:53 -0400
X-UUID: 0c3b7fb4ee24452aa898271b36eba5db-20190425
X-UUID: 0c3b7fb4ee24452aa898271b36eba5db-20190425
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1054018054; Thu, 25 Apr 2019 16:41:37 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 25 Apr 2019 16:41:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 25 Apr 2019 16:41:35 +0800
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
Subject: [PATCH 2/2] serial: 8250-mtk: modify baudrate setting
Date:   Thu, 25 Apr 2019 16:41:31 +0800
Message-ID: <1556181691-10293-3-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com>
References: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9BCFE159B135E749B2F86214D9E511DAB2E50153D76EBD17E8A61F441291CCAB2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In termios function, add Fractional divider to adjust baudrate.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c |  102 ++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 959fd85..417c7c8 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -25,13 +25,28 @@
 #define MTK_UART_SAMPLE_COUNT	0x0a	/* Sample count register */
 #define MTK_UART_SAMPLE_POINT	0x0b	/* Sample point register */
 #define MTK_UART_RATE_FIX	0x0d	/* UART Rate Fix Register */
+#define MTK_UART_ESCAPE_DAT	0x10	/* Escape Character register */
+#define MTK_UART_ESCAPE_EN	0x11	/* Escape Enable register */
 #define MTK_UART_DMA_EN		0x13	/* DMA Enable register */
 #define MTK_UART_RXTRI_AD	0x14	/* RX Trigger address */
 #define MTK_UART_FRACDIV_L	0x15	/* Fractional divider LSB address */
 #define MTK_UART_FRACDIV_M	0x16	/* Fractional divider MSB address */
+#define MTK_UART_IER_XOFFI	0x20	/* Enable XOFF character interrupt */
+#define MTK_UART_IER_RTSI	0x40	/* Enable RTS Modem status interrupt */
+#define MTK_UART_IER_CTSI	0x80	/* Enable CTS Modem status interrupt */
+
+#define MTK_UART_EFR_EN		0x10	/* Enable enhancement feature */
+#define MTK_UART_EFR_RTS	0x40	/* Enable hardware rx flow control */
+#define MTK_UART_EFR_CTS	0x80	/* Enable hardware tx flow control */
+#define MTK_UART_EFR_NO_SW_FC	0x0	/* no sw flow control */
+#define MTK_UART_EFR_XON1_XOFF1	0xa	/* XON1/XOFF1 as sw flow control */
+#define MTK_UART_EFR_XON2_XOFF2	0x5	/* XON2/XOFF2 as sw flow control */
+#define MTK_UART_EFR_SW_FC_MASK	0xf	/* Enable CTS Modem status interrupt */
+#define MTK_UART_EFR_HW_FC	(MTK_UART_EFR_RTS | MTK_UART_EFR_CTS)
 #define MTK_UART_DMA_EN_TX	0x2
 #define MTK_UART_DMA_EN_RX	0x5
 
+#define MTK_UART_ESCAPE_CHAR	0x77	/* Escape char added under sw fc */
 #define MTK_UART_TX_SIZE	UART_XMIT_SIZE
 #define MTK_UART_RX_SIZE	0x8000
 #define MTK_UART_TX_TRIGGER	1
@@ -57,6 +72,13 @@ struct mtk8250_data {
 #endif
 };
 
+/* flow control mode */
+enum {
+	MTK_UART_FC_NONE,
+	MTK_UART_FC_SW,
+	MTK_UART_FC_HW,
+};
+
 #ifdef CONFIG_SERIAL_8250_DMA
 static void mtk8250_rx_dma(struct uart_8250_port *up);
 
@@ -195,6 +217,75 @@ static void mtk8250_shutdown(struct uart_port *port)
 	return serial8250_do_shutdown(port);
 }
 
+static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
+{
+	serial_out(up, UART_IER, serial_in(up, UART_IER) & (~mask));
+}
+
+static void mtk8250_enable_intrs(struct uart_8250_port *up, int mask)
+{
+	serial_out(up, UART_IER, serial_in(up, UART_IER) | mask);
+}
+
+static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
+{
+	struct uart_port *port = &up->port;
+	int lcr = serial_in(up, UART_LCR);
+
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, UART_EFR_ECB);
+	serial_out(up, UART_LCR, lcr);
+	lcr = serial_in(up, UART_LCR);
+
+	switch (mode) {
+	case MTK_UART_FC_NONE:
+		serial_out(up, MTK_UART_ESCAPE_DAT, MTK_UART_ESCAPE_CHAR);
+		serial_out(up, MTK_UART_ESCAPE_EN, 0x00);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_EFR, serial_in(up, UART_EFR) &
+			(~(MTK_UART_EFR_HW_FC | MTK_UART_EFR_SW_FC_MASK)));
+		serial_out(up, UART_LCR, lcr);
+		mtk8250_disable_intrs(up, MTK_UART_IER_XOFFI |
+			MTK_UART_IER_RTSI | MTK_UART_IER_CTSI);
+		break;
+
+	case MTK_UART_FC_HW:
+		serial_out(up, MTK_UART_ESCAPE_DAT, MTK_UART_ESCAPE_CHAR);
+		serial_out(up, MTK_UART_ESCAPE_EN, 0x00);
+		serial_out(up, UART_MCR, UART_MCR_RTS);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+		/*enable hw flow control*/
+		serial_out(up, UART_EFR, MTK_UART_EFR_HW_FC |
+			(serial_in(up, UART_EFR) &
+			(~(MTK_UART_EFR_HW_FC | MTK_UART_EFR_SW_FC_MASK))));
+
+		serial_out(up, UART_LCR, lcr);
+		mtk8250_disable_intrs(up, MTK_UART_IER_XOFFI);
+		mtk8250_enable_intrs(up, MTK_UART_IER_CTSI | MTK_UART_IER_RTSI);
+		break;
+
+	case MTK_UART_FC_SW:	/*MTK software flow control */
+		serial_out(up, MTK_UART_ESCAPE_DAT, MTK_UART_ESCAPE_CHAR);
+		serial_out(up, MTK_UART_ESCAPE_EN, 0x01);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+		/*enable sw flow control */
+		serial_out(up, UART_EFR, MTK_UART_EFR_XON1_XOFF1 |
+			(serial_in(up, UART_EFR) &
+			(~(MTK_UART_EFR_HW_FC | MTK_UART_EFR_SW_FC_MASK))));
+
+		serial_out(up, UART_XON1, START_CHAR(port->state->port.tty));
+		serial_out(up, UART_XOFF1, STOP_CHAR(port->state->port.tty));
+		serial_out(up, UART_LCR, lcr);
+		mtk8250_disable_intrs(up, MTK_UART_IER_CTSI|MTK_UART_IER_RTSI);
+		mtk8250_enable_intrs(up, MTK_UART_IER_XOFFI);
+		break;
+	default:
+		break;
+	}
+}
+
 static void
 mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
@@ -208,6 +299,7 @@ static void mtk8250_shutdown(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int baud, quot, fraction;
 	unsigned long flags;
+	int mode;
 
 #ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma) {
@@ -281,6 +373,16 @@ static void mtk8250_shutdown(struct uart_port *port)
 		serial_port_out(port, MTK_UART_FRACDIV_L, 0x00);
 		serial_port_out(port, MTK_UART_FRACDIV_M, 0x00);
 	}
+
+	if ((termios->c_cflag & CRTSCTS) && (!(termios->c_iflag & CRTSCTS)))
+		mode = MTK_UART_FC_HW;
+	else if (termios->c_iflag & CRTSCTS)
+		mode = MTK_UART_FC_SW;
+	else
+		mode = MTK_UART_FC_NONE;
+
+	mtk8250_set_flow_ctrl(up, mode);
+
 	if (uart_console(port))
 		up->port.cons->cflag = termios->c_cflag;
 
-- 
1.7.9.5

