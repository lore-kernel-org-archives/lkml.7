Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1146020836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQTY0zI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfCDI7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:59:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33953 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfCDI73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:59:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so2538657pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aeWDJRG7hZOzbbXpp+NNARTTNCvkcfGhEcCkUTMq2xQ=;
        b=XQTY0zI/l4el8QFaWYEWmMYg87nmmb0Iw6seTxU89/QgdbnDGS8ozXlVkHLULZRBW1
         GREcAuGsZ0rlA3qV+xupj+OLWzc62CTayv/XyRfzMf5qFPYIkD/SnCOxuq2dYgZzF8TN
         w1nNoCpmljrd2Io7KtftdN9wcCkLhcOmFoAr417oxN6OpCE9+SSKT9k70+GoCJ+QhX1I
         TCPpWLbByHdiSHroA0XXvoWOaL7oSzsqG19N37ml7NZ4i5k8uIDnc7EDeafFjd/WrioW
         +0P42DR5Ii0YG6G1VfybQjcq0157Gj0nx+lRo4oFoMQ82VUSwijlxpUfIACEgxPkCRya
         siqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aeWDJRG7hZOzbbXpp+NNARTTNCvkcfGhEcCkUTMq2xQ=;
        b=RuQSPjs9F4zfROVi9PX3UG6Gu0kWAdqTtbQJ1wsqj5QPEd91wzbcroHTdGtqVEQEAU
         KQ9H2R/MuZ9Wt4anNjO6f/VKFnoqVjzb1eoLLl/bKj2/2gfFVHOt/wi+mBGYsuPRk/zb
         gy1SwobwoV/piAmldw5ohyIYs7Vo9hDV8HdmiRGECrZvYeR1DpjayAHnC63dtsKf+Emc
         TAPRUJf+Rin+QV76Lmal6va0onz6/bALQq8uiC4MGVXtggdtPjtRKShSXDRS6KltBMXH
         UxG+gK2euChKs1wTBj4WThM97MCRYobEMBHB+pkcrgOl4j+Sw7CqvuHZt9lVyUKbcxww
         pATg==
X-Gm-Message-State: AHQUAuan6li94g8VuzQJvVQruzWROdT+TsoGxZaD69Zj6f0X75/HWrwC
        53h/Z5iM8p6Tyuwc4BgJ95R9a+k+jpEyqw==
X-Google-Smtp-Source: AHgI3IZ1KerbT41uj3S7yhgZBNppoaRLoBWfLWwZl3VUHjeDAYHlIrZK0o6wEvCzE7NjSzg7FlORiA==
X-Received: by 2002:a62:e017:: with SMTP id f23mr18828951pfh.152.1551689968412;
        Mon, 04 Mar 2019 00:59:28 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k8sm7395523pgg.75.2019.03.04.00.59.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 00:59:27 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] serial: sprd: Add DMA mode support
Date:   Mon,  4 Mar 2019 16:58:24 +0800
Message-Id: <218b01d086e4e1aef85cd3c50ef784e29bd161ff.1551689518.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

Add DMA mode support for the Spreadtrum serial controller.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |  440 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 426 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 8f45b66..6aebd77 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -10,6 +10,9 @@
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/sprd-dma.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
@@ -75,6 +78,7 @@
 
 /* control register 1 */
 #define SPRD_CTL1		0x001C
+#define SPRD_DMA_EN		BIT(15)
 #define RX_HW_FLOW_CTL_THLD	BIT(6)
 #define RX_HW_FLOW_CTL_EN	BIT(7)
 #define TX_HW_FLOW_CTL_EN	BIT(8)
@@ -86,6 +90,7 @@
 #define THLD_TX_EMPTY		0x40
 #define THLD_TX_EMPTY_SHIFT	8
 #define THLD_RX_FULL		0x40
+#define THLD_RX_FULL_MASK	GENMASK(6, 0)
 
 /* config baud rate register */
 #define SPRD_CLKD0		0x0024
@@ -102,15 +107,36 @@
 #define SPRD_IMSR_TIMEOUT	BIT(13)
 #define SPRD_DEFAULT_SOURCE_CLK	26000000
 
+#define SPRD_RX_DMA_STEP	1
+#define SPRD_RX_FIFO_FULL	1
+#define SPRD_TX_FIFO_FULL	0x20
+#define SPRD_UART_RX_SIZE	(UART_XMIT_SIZE / 4)
+
+struct sprd_uart_dma {
+	struct dma_chan *chn;
+	unsigned char *virt;
+	dma_addr_t phys_addr;
+	dma_cookie_t cookie;
+	u32 trans_len;
+	bool enable;
+};
+
 struct sprd_uart_port {
 	struct uart_port port;
 	char name[16];
 	struct clk *clk;
+	struct sprd_uart_dma tx_dma;
+	struct sprd_uart_dma rx_dma;
+	dma_addr_t pos;
+	unsigned char *rx_buf_tail;
 };
 
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
 static int sprd_ports_num;
 
+static int sprd_start_dma_rx(struct uart_port *port);
+static int sprd_tx_dma_config(struct uart_port *port);
+
 static inline unsigned int serial_in(struct uart_port *port,
 				     unsigned int offset)
 {
@@ -141,45 +167,389 @@ static void sprd_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	/* nothing to do */
 }
 
-static void sprd_stop_tx(struct uart_port *port)
+static void sprd_stop_rx(struct uart_port *port)
 {
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
 	unsigned int ien, iclr;
 
+	if (sp->rx_dma.enable)
+		dmaengine_terminate_all(sp->rx_dma.chn);
+
 	iclr = serial_in(port, SPRD_ICLR);
 	ien = serial_in(port, SPRD_IEN);
 
-	iclr |= SPRD_IEN_TX_EMPTY;
-	ien &= ~SPRD_IEN_TX_EMPTY;
+	ien &= ~(SPRD_IEN_RX_FULL | SPRD_IEN_BREAK_DETECT);
+	iclr |= SPRD_IEN_RX_FULL | SPRD_IEN_BREAK_DETECT;
 
-	serial_out(port, SPRD_ICLR, iclr);
 	serial_out(port, SPRD_IEN, ien);
+	serial_out(port, SPRD_ICLR, iclr);
 }
 
-static void sprd_start_tx(struct uart_port *port)
+static void sprd_uart_dma_enable(struct uart_port *port, bool enable)
 {
-	unsigned int ien;
+	u32 val = serial_in(port, SPRD_CTL1);
 
-	ien = serial_in(port, SPRD_IEN);
-	if (!(ien & SPRD_IEN_TX_EMPTY)) {
-		ien |= SPRD_IEN_TX_EMPTY;
-		serial_out(port, SPRD_IEN, ien);
+	if (enable)
+		val |= SPRD_DMA_EN;
+	else
+		val &= ~SPRD_DMA_EN;
+
+	serial_out(port, SPRD_CTL1, val);
+}
+
+static void sprd_stop_tx_dma(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct circ_buf *xmit = &port->state->xmit;
+	struct dma_tx_state state;
+	u32 trans_len;
+
+	dmaengine_pause(sp->tx_dma.chn);
+
+	dmaengine_tx_status(sp->tx_dma.chn, sp->tx_dma.cookie, &state);
+	if (state.residue) {
+		trans_len = state.residue - sp->tx_dma.phys_addr;
+		xmit->tail = (xmit->tail + trans_len) & (UART_XMIT_SIZE - 1);
+		port->icount.tx += trans_len;
+		dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
+				 sp->tx_dma.trans_len, DMA_TO_DEVICE);
 	}
+
+	dmaengine_terminate_all(sp->tx_dma.chn);
+	sp->tx_dma.trans_len = 0;
 }
 
-static void sprd_stop_rx(struct uart_port *port)
+static int sprd_tx_buf_remap(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct circ_buf *xmit = &port->state->xmit;
+
+	sp->tx_dma.trans_len =
+		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
+
+	sp->tx_dma.phys_addr = dma_map_single(port->dev,
+					      (void *)&(xmit->buf[xmit->tail]),
+					      sp->tx_dma.trans_len,
+					      DMA_TO_DEVICE);
+	return dma_mapping_error(port->dev, sp->tx_dma.phys_addr);
+}
+
+static void sprd_complete_tx_dma(void *data)
+{
+	struct uart_port *port = (struct uart_port *)data;
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
+			 sp->tx_dma.trans_len, DMA_TO_DEVICE);
+
+	xmit->tail = (xmit->tail + sp->tx_dma.trans_len) & (UART_XMIT_SIZE - 1);
+	port->icount.tx += sp->tx_dma.trans_len;
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit) || sprd_tx_buf_remap(port) ||
+	    sprd_tx_dma_config(port))
+		sp->tx_dma.trans_len = 0;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int sprd_uart_dma_submit(struct uart_port *port,
+				struct sprd_uart_dma *ud, u32 trans_len,
+				enum dma_transfer_direction direction,
+				dma_async_tx_callback callback)
 {
+	struct dma_async_tx_descriptor *dma_des;
+	unsigned long flags;
+
+	flags = SPRD_DMA_FLAGS(SPRD_DMA_CHN_MODE_NONE,
+			       SPRD_DMA_NO_TRG,
+			       SPRD_DMA_FRAG_REQ,
+			       SPRD_DMA_TRANS_INT);
+
+	dma_des = dmaengine_prep_slave_single(ud->chn, ud->phys_addr, trans_len,
+					      direction, flags);
+	if (!dma_des)
+		return -ENODEV;
+
+	dma_des->callback = callback;
+	dma_des->callback_param = port;
+
+	ud->cookie = dmaengine_submit(dma_des);
+	if (dma_submit_error(ud->cookie))
+		return dma_submit_error(ud->cookie);
+
+	dma_async_issue_pending(ud->chn);
+
+	return 0;
+}
+
+static int sprd_tx_dma_config(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	u32 burst = sp->tx_dma.trans_len > SPRD_TX_FIFO_FULL ?
+		SPRD_TX_FIFO_FULL : sp->tx_dma.trans_len;
+	int ret;
+	struct dma_slave_config cfg = {
+		.dst_addr = port->mapbase + SPRD_TXD,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
+		.src_maxburst = burst,
+	};
+
+	ret = dmaengine_slave_config(sp->tx_dma.chn, &cfg);
+	if (ret < 0)
+		return ret;
+
+	return sprd_uart_dma_submit(port, &sp->tx_dma, sp->tx_dma.trans_len,
+				    DMA_MEM_TO_DEV, sprd_complete_tx_dma);
+}
+
+static void sprd_start_tx_dma(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct circ_buf *xmit = &port->state->xmit;
+
+	if (port->x_char) {
+		serial_out(port, SPRD_TXD, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+		return;
+	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		sprd_stop_tx_dma(port);
+		return;
+	}
+
+	if (sp->tx_dma.trans_len)
+		return;
+
+	if (sprd_tx_buf_remap(port) || sprd_tx_dma_config(port))
+		sp->tx_dma.trans_len = 0;
+}
+
+static void sprd_rx_full_thld(struct uart_port *port, u32 thld)
+{
+	u32 val = serial_in(port, SPRD_CTL2);
+
+	val &= ~THLD_RX_FULL_MASK;
+	val |= thld & THLD_RX_FULL_MASK;
+	serial_out(port, SPRD_CTL2, val);
+}
+
+static int sprd_rx_alloc_buf(struct sprd_uart_port *sp)
+{
+	sp->rx_dma.virt = dma_alloc_coherent(sp->port.dev, SPRD_UART_RX_SIZE,
+					     &sp->rx_dma.phys_addr, GFP_KERNEL);
+	if (!sp->rx_dma.virt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void sprd_rx_free_buf(struct sprd_uart_port *sp)
+{
+	if (sp->rx_dma.virt)
+		dma_free_coherent(sp->port.dev, SPRD_UART_RX_SIZE,
+				  sp->rx_dma.virt, sp->rx_dma.phys_addr);
+
+}
+
+static int sprd_rx_dma_config(struct uart_port *port, u32 burst)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct dma_slave_config cfg = {
+		.src_addr = port->mapbase + SPRD_RXD,
+		.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
+		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
+		.src_maxburst = burst,
+	};
+
+	return dmaengine_slave_config(sp->rx_dma.chn, &cfg);
+}
+
+static void sprd_uart_dma_rx(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct tty_port *tty = &port->state->port;
+
+	port->icount.rx += sp->rx_dma.trans_len;
+	tty_insert_flip_string(tty, sp->rx_buf_tail, sp->rx_dma.trans_len);
+	tty_flip_buffer_push(tty);
+}
+
+static void sprd_uart_dma_irq(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct dma_tx_state state;
+	enum dma_status status;
+
+	status = dmaengine_tx_status(sp->rx_dma.chn,
+				     sp->rx_dma.cookie, &state);
+	if (status == DMA_ERROR)
+		sprd_stop_rx(port);
+
+	if (!state.residue && sp->pos == sp->rx_dma.phys_addr)
+		return;
+
+	if (!state.residue) {
+		sp->rx_dma.trans_len = SPRD_UART_RX_SIZE +
+			sp->rx_dma.phys_addr - sp->pos;
+		sp->pos = sp->rx_dma.phys_addr;
+	} else {
+		sp->rx_dma.trans_len = state.residue - sp->pos;
+		sp->pos = state.residue;
+	}
+
+	sprd_uart_dma_rx(port);
+	sp->rx_buf_tail += sp->rx_dma.trans_len;
+}
+
+static void sprd_complete_rx_dma(void *data)
+{
+	struct uart_port *port = (struct uart_port *)data;
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	struct dma_tx_state state;
+	enum dma_status status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	status = dmaengine_tx_status(sp->rx_dma.chn,
+				     sp->rx_dma.cookie, &state);
+	if (status != DMA_COMPLETE) {
+		sprd_stop_rx(port);
+		spin_unlock_irqrestore(&port->lock, flags);
+		return;
+	}
+
+	if (sp->pos != sp->rx_dma.phys_addr) {
+		sp->rx_dma.trans_len =  SPRD_UART_RX_SIZE +
+			sp->rx_dma.phys_addr - sp->pos;
+		sprd_uart_dma_rx(port);
+		sp->rx_buf_tail += sp->rx_dma.trans_len;
+	}
+
+	if (sprd_start_dma_rx(port))
+		sprd_stop_rx(port);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int sprd_start_dma_rx(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+	int ret;
+
+	if (!sp->rx_dma.enable)
+		return 0;
+
+	sp->pos = sp->rx_dma.phys_addr;
+	sp->rx_buf_tail = sp->rx_dma.virt;
+	sprd_rx_full_thld(port, SPRD_RX_FIFO_FULL);
+	ret = sprd_rx_dma_config(port, SPRD_RX_DMA_STEP);
+	if (ret)
+		return ret;
+
+	return sprd_uart_dma_submit(port, &sp->rx_dma, SPRD_UART_RX_SIZE,
+				    DMA_DEV_TO_MEM, sprd_complete_rx_dma);
+}
+
+static void sprd_release_dma(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+
+	sprd_uart_dma_enable(port, false);
+
+	if (sp->rx_dma.enable)
+		dma_release_channel(sp->rx_dma.chn);
+
+	if (sp->tx_dma.enable)
+		dma_release_channel(sp->tx_dma.chn);
+
+	sp->tx_dma.enable = false;
+	sp->rx_dma.enable = false;
+}
+
+static void sprd_request_dma(struct uart_port *port)
+{
+	struct sprd_uart_port *sp =
+		container_of(port, struct sprd_uart_port, port);
+
+	sp->tx_dma.enable = true;
+	sp->rx_dma.enable = true;
+
+	sp->tx_dma.chn = dma_request_chan(port->dev, "tx");
+	if (IS_ERR(sp->tx_dma.chn)) {
+		dev_err(port->dev, "request TX DMA channel failed, ret = %ld\n",
+			PTR_ERR(sp->tx_dma.chn));
+		sp->tx_dma.enable = false;
+	}
+
+	sp->rx_dma.chn = dma_request_chan(port->dev, "rx");
+	if (IS_ERR(sp->rx_dma.chn)) {
+		dev_err(port->dev, "request RX DMA channel failed, ret = %ld\n",
+			PTR_ERR(sp->tx_dma.chn));
+		sp->rx_dma.enable = false;
+	}
+}
+
+static void sprd_stop_tx(struct uart_port *port)
+{
+	struct sprd_uart_port *sp = container_of(port, struct sprd_uart_port,
+						 port);
 	unsigned int ien, iclr;
 
+	if (sp->tx_dma.enable) {
+		sprd_stop_tx_dma(port);
+		return;
+	}
+
 	iclr = serial_in(port, SPRD_ICLR);
 	ien = serial_in(port, SPRD_IEN);
 
-	ien &= ~(SPRD_IEN_RX_FULL | SPRD_IEN_BREAK_DETECT);
-	iclr |= SPRD_IEN_RX_FULL | SPRD_IEN_BREAK_DETECT;
+	iclr |= SPRD_IEN_TX_EMPTY;
+	ien &= ~SPRD_IEN_TX_EMPTY;
 
 	serial_out(port, SPRD_IEN, ien);
 	serial_out(port, SPRD_ICLR, iclr);
 }
 
+static void sprd_start_tx(struct uart_port *port)
+{
+	struct sprd_uart_port *sp = container_of(port, struct sprd_uart_port,
+						 port);
+	unsigned int ien;
+
+	if (sp->tx_dma.enable) {
+		sprd_start_tx_dma(port);
+		return;
+	}
+
+	ien = serial_in(port, SPRD_IEN);
+	if (!(ien & SPRD_IEN_TX_EMPTY)) {
+		ien |= SPRD_IEN_TX_EMPTY;
+		serial_out(port, SPRD_IEN, ien);
+	}
+}
+
 /* The Sprd serial does not support this function. */
 static void sprd_break_ctl(struct uart_port *port, int break_state)
 {
@@ -220,9 +590,16 @@ static int handle_lsr_errors(struct uart_port *port,
 
 static inline void sprd_rx(struct uart_port *port)
 {
+	struct sprd_uart_port *sp = container_of(port, struct sprd_uart_port,
+						 port);
 	struct tty_port *tty = &port->state->port;
 	unsigned int ch, flag, lsr, max_count = SPRD_TIMEOUT;
 
+	if (sp->rx_dma.enable) {
+		sprd_uart_dma_irq(port);
+		return;
+	}
+
 	while ((serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK) &&
 	       max_count--) {
 		lsr = serial_in(port, SPRD_LSR);
@@ -306,6 +683,25 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void sprd_uart_dma_startup(struct uart_port *port,
+				  struct sprd_uart_port *sp)
+{
+	int ret;
+
+	sprd_request_dma(port);
+	if (!(sp->rx_dma.enable || sp->tx_dma.enable))
+		return;
+
+	ret = sprd_start_dma_rx(port);
+	if (ret) {
+		sp->rx_dma.enable = false;
+		dma_release_channel(sp->rx_dma.chn);
+		dev_warn(port->dev, "fail to start RX dma mode\n");
+	}
+
+	sprd_uart_dma_enable(port, true);
+}
+
 static int sprd_startup(struct uart_port *port)
 {
 	int ret = 0;
@@ -334,6 +730,9 @@ static int sprd_startup(struct uart_port *port)
 	/* allocate irq */
 	sp = container_of(port, struct sprd_uart_port, port);
 	snprintf(sp->name, sizeof(sp->name), "sprd_serial%d", port->line);
+
+	sprd_uart_dma_startup(port, sp);
+
 	ret = devm_request_irq(port->dev, port->irq, sprd_handle_irq,
 			       IRQF_SHARED, sp->name, port);
 	if (ret) {
@@ -348,7 +747,9 @@ static int sprd_startup(struct uart_port *port)
 	/* enable interrupt */
 	spin_lock_irqsave(&port->lock, flags);
 	ien = serial_in(port, SPRD_IEN);
-	ien |= SPRD_IEN_RX_FULL | SPRD_IEN_BREAK_DETECT | SPRD_IEN_TIMEOUT;
+	ien |= SPRD_IEN_BREAK_DETECT | SPRD_IEN_TIMEOUT;
+	if (!sp->rx_dma.enable)
+		ien |= SPRD_IEN_RX_FULL;
 	serial_out(port, SPRD_IEN, ien);
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -357,6 +758,7 @@ static int sprd_startup(struct uart_port *port)
 
 static void sprd_shutdown(struct uart_port *port)
 {
+	sprd_release_dma(port);
 	serial_out(port, SPRD_IEN, 0);
 	serial_out(port, SPRD_ICLR, ~0);
 	devm_free_irq(port->dev, port->irq, port);
@@ -687,6 +1089,8 @@ static int sprd_remove(struct platform_device *dev)
 	if (!sprd_ports_num)
 		uart_unregister_driver(&sprd_uart_driver);
 
+	sprd_rx_free_buf(sup);
+
 	return 0;
 }
 
@@ -775,6 +1179,14 @@ static int sprd_probe(struct platform_device *pdev)
 	}
 	up->irq = irq;
 
+	/*
+	 * Allocate one dma buffer to prepare for receive transfer, in case
+	 * memory allocation failure at runtime.
+	 */
+	ret = sprd_rx_alloc_buf(sprd_port[index]);
+	if (ret)
+		return ret;
+
 	if (!sprd_ports_num) {
 		ret = uart_register_driver(&sprd_uart_driver);
 		if (ret < 0) {
-- 
1.7.9.5

