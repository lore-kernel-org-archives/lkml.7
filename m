Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686EA206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCGBpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:45:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56316 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbfCGBpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:45:49 -0500
X-UUID: ec475b71046746e3858104d659d0cf4b-20190307
X-UUID: ec475b71046746e3858104d659d0cf4b-20190307
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1050543428; Thu, 07 Mar 2019 09:45:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 7 Mar 2019 09:45:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 7 Mar 2019 09:45:42 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v11 4/4] serial: 8250-mtk: modify uart DMA rx
Date:   Thu, 7 Mar 2019 09:45:35 +0800
Message-ID: <1551923135-32479-5-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551923135-32479-1-git-send-email-long.cheng@mediatek.com>
References: <1551923135-32479-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify uart rx and complete for DMA.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c |   53 ++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index e2c4076..f9b2fd5 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -30,7 +30,6 @@
 #define MTK_UART_DMA_EN_TX	0x2
 #define MTK_UART_DMA_EN_RX	0x5
 
-#define MTK_UART_TX_SIZE	UART_XMIT_SIZE
 #define MTK_UART_RX_SIZE	0x8000
 #define MTK_UART_TX_TRIGGER	1
 #define MTK_UART_RX_TRIGGER	MTK_UART_RX_SIZE
@@ -64,28 +63,30 @@ static void mtk8250_dma_rx_complete(void *param)
 	struct mtk8250_data *data = up->port.private_data;
 	struct tty_port *tty_port = &up->port.state->port;
 	struct dma_tx_state state;
+	int copied, cnt, tmp;
 	unsigned char *ptr;
-	int copied;
 
-	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
-				dma->rx_size, DMA_FROM_DEVICE);
+	if (data->rx_status == DMA_RX_SHUTDOWN)
+		return;
 
 	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	cnt = dma->rx_size - state.residue;
+	tmp = cnt;
 
-	if (data->rx_status == DMA_RX_SHUTDOWN)
-		return;
+	if ((data->rx_pos + cnt) > dma->rx_size)
+		tmp = dma->rx_size - data->rx_pos;
 
-	if ((data->rx_pos + state.residue) <= dma->rx_size) {
-		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
-		copied = tty_insert_flip_string(tty_port, ptr, state.residue);
-	} else {
-		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
-		copied = tty_insert_flip_string(tty_port, ptr,
-						dma->rx_size - data->rx_pos);
+	ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
+	copied = tty_insert_flip_string(tty_port, ptr, tmp);
+	data->rx_pos += tmp;
+
+	if (cnt > tmp) {
 		ptr = (unsigned char *)(dma->rx_buf);
-		copied += tty_insert_flip_string(tty_port, ptr,
-				data->rx_pos + state.residue - dma->rx_size);
+		tmp = cnt - tmp;
+		copied += tty_insert_flip_string(tty_port, ptr, tmp);
+		data->rx_pos = tmp;
 	}
+
 	up->port.icount.rx += copied;
 
 	tty_flip_buffer_push(tty_port);
@@ -96,9 +97,7 @@ static void mtk8250_dma_rx_complete(void *param)
 static void mtk8250_rx_dma(struct uart_8250_port *up)
 {
 	struct uart_8250_dma *dma = up->dma;
-	struct mtk8250_data *data = up->port.private_data;
 	struct dma_async_tx_descriptor	*desc;
-	struct dma_tx_state	 state;
 
 	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
 					   dma->rx_size, DMA_DEV_TO_MEM,
@@ -113,12 +112,6 @@ static void mtk8250_rx_dma(struct uart_8250_port *up)
 
 	dma->rx_cookie = dmaengine_submit(desc);
 
-	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
-	data->rx_pos = state.residue;
-
-	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
-				   dma->rx_size, DMA_FROM_DEVICE);
-
 	dma_async_issue_pending(dma->rxchan);
 }
 
@@ -131,13 +124,13 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
 	if (data->rx_status != DMA_RX_START)
 		return;
 
-	dma->rxconf.direction		= DMA_DEV_TO_MEM;
-	dma->rxconf.src_addr_width	= dma->rx_size / 1024;
-	dma->rxconf.src_addr		= dma->rx_addr;
+	dma->rxconf.direction				= DMA_DEV_TO_MEM;
+	dma->rxconf.src_port_window_size	= dma->rx_size;
+	dma->rxconf.src_addr				= dma->rx_addr;
 
-	dma->txconf.direction		= DMA_MEM_TO_DEV;
-	dma->txconf.dst_addr_width	= MTK_UART_TX_SIZE / 1024;
-	dma->txconf.dst_addr		= dma->tx_addr;
+	dma->txconf.direction				= DMA_MEM_TO_DEV;
+	dma->txconf.dst_port_window_size	= UART_XMIT_SIZE;
+	dma->txconf.dst_addr				= dma->tx_addr;
 
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
 		UART_FCR_CLEAR_XMIT);
@@ -217,7 +210,7 @@ static void mtk8250_shutdown(struct uart_port *port)
 	 * Mediatek UARTs use an extra highspeed register (UART_MTK_HIGHS)
 	 *
 	 * We need to recalcualte the quot register, as the claculation depends
-	 * on the vaule in the highspeed register.
+	 * on the value in the highspeed register.
 	 *
 	 * Some baudrates are not supported by the chip, so we use the next
 	 * lower rate supported and update termios c_flag.
-- 
1.7.9.5

