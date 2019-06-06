Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6EBC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3236C2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdR4iEgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfFFCyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:54:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44999 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFFCyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so289736pll.11;
        Wed, 05 Jun 2019 19:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6/441xpEsHRHk+TPPpQ71vkACQ7btLdEQ1tga7+tI0Q=;
        b=RdR4iEgIl9owu3eEOHa9RP0NJwO3Qp8aS2WOU4rZppvATYtyLWkqkUum1CI3OIdLuk
         OIz22VDufEFjFnoHvTOXVSFLKwEhnwGmFKGUTZlUjNI7+OJCbNpq6N41n/i40LDEdAyF
         qWYxzaJrm5iAqR7dUc5DTOD8Fg2wiBuRBsB3oT4sNOt0kadD7Zui3iQi6FfyojOs85Jj
         YKHnR8O826Hmm3MnaNhfMCvCMHjAyQfg4Fjs5d+gJH3qLpNpbpgSWnq7x9s6UryC93zm
         QMPZ6CfJmgGDtcaTwaZC1n0PHOH+j3yrwQWfQTO3URWuljD0dqI3xLz9w2SMORl+blJM
         iqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6/441xpEsHRHk+TPPpQ71vkACQ7btLdEQ1tga7+tI0Q=;
        b=djzuO3Dl4l+JFmfP78PiAYZt8kGgSA5KgA7VHLeCrSVt30/4LFV0ea8PEtgtP590Ul
         OMH8kXA2TX8fXrWvDQhdxvgNNBhEoxlegxmQiowcmM4hWEQpGj+vOCcKO86ssaOOW7C3
         KtAiBPsheAVCbTCq8dYMLJuN/wTDBAy3WdENDuehpocVQqKnXt6og6eI9WsMJH7bEyXe
         msTp+2wiz+xBLIrN/6jy0YyU7pBIWP9hLtPcoayA2diqU5K9XvTDbS8jh85peN+MY7mz
         e3+2bE0jcibX45xsy+L6EmWhGhha2o5ZINhH8QCLz+POV419412O7DmHsRj8qSHecntR
         vktw==
X-Gm-Message-State: APjAAAVCUHhd/u77iTEirfQxQs+/Sb60S9GB92pQlD9TicI7JX4eYpIj
        cMKe2O51YRqFO39L3IZnITOljbla
X-Google-Smtp-Source: APXvYqylosWyCIwVzbZaoOe/bP3PkZDEMeCJBNiHHokBgRXlgsbyLF7t72UbcXUdLOac+DJTFAY2hg==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr40728863plr.198.1559789679530;
        Wed, 05 Jun 2019 19:54:39 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id b35sm312923pjc.15.2019.06.05.19.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:38 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 1/6] USB: serial: f81232: Add F81534A support
Date:   Thu,  6 Jun 2019 10:54:11 +0800
Message-Id: <1559789656-15847-2-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device.
It's most same with F81232, the UART device is difference as follow:
	1. TX/RX bulk size is 128/512bytes
	2. RX bulk layout change:
		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
		F81534A:[LEN][Data.....][LSR]

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 153 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 144 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 43fa1f0716b7..84efcc66aa56 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Fintek F81232 USB to serial adaptor driver
+ * Fintek F81532A/534A/535/536 USB to 2/4/8/12 serial adaptor driver
  *
  * Copyright (C) 2012 Greg Kroah-Hartman (gregkh@linuxfoundation.org)
  * Copyright (C) 2012 Linux Foundation
@@ -22,7 +23,20 @@
 #include <linux/serial_reg.h>
 
 static const struct usb_device_id id_table[] = {
+	/* F81232 */
 	{ USB_DEVICE(0x1934, 0x0706) },
+
+	/* F81532A/534A/535/536 */
+	{ USB_DEVICE(0x2c42, 0x1602) },		/* In-Box 2 port UART device */
+	{ USB_DEVICE(0x2c42, 0x1604) },		/* In-Box 4 port UART device */
+	{ USB_DEVICE(0x2c42, 0x1605) },		/* In-Box 8 port UART device */
+	{ USB_DEVICE(0x2c42, 0x1606) },		/* In-Box 12 port UART device */
+	{ USB_DEVICE(0x2c42, 0x1608) },		/* Non-Flash type */
+
+	{ USB_DEVICE(0x2c42, 0x1632) },		/* 2 port UART device */
+	{ USB_DEVICE(0x2c42, 0x1634) },		/* 4 port UART device */
+	{ USB_DEVICE(0x2c42, 0x1635) },		/* 8 port UART device */
+	{ USB_DEVICE(0x2c42, 0x1636) },		/* 12 port UART device */
 	{ }					/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);
@@ -61,15 +75,25 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81232_CLK_14_77_MHZ		(BIT(1) | BIT(0))
 #define F81232_CLK_MASK			GENMASK(1, 0)
 
+#define F81534A_MODE_CONF_REG		0x107
+#define F81534A_TRIGGER_MASK		GENMASK(3, 2)
+#define F81534A_TRIGGER_MULTPILE_4X	BIT(3)
+#define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
+
+#define F81232_F81232_TYPE		1
+#define F81232_F81534A_TYPE		2
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
 	u8 shadow_lcr;
+	u8 device_type;
 	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
 	struct usb_serial_port *port;
+	void (*process_read_urb)(struct urb *urb);
 };
 
 static u32 const baudrate_table[] = { 115200, 921600, 1152000, 1500000 };
@@ -376,6 +400,78 @@ static void f81232_process_read_urb(struct urb *urb)
 	tty_flip_buffer_push(&port->port);
 }
 
+static void f81534a_process_read_urb(struct urb *urb)
+{
+	struct usb_serial_port *port = urb->context;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+	unsigned char *data = urb->transfer_buffer;
+	char tty_flag;
+	unsigned int i;
+	u8 lsr;
+	u8 len;
+
+	if (urb->status) {
+		dev_err(&port->dev, "urb->status: %d\n", urb->status);
+		return;
+	}
+
+	if (!urb->actual_length) {
+		dev_err(&port->dev, "urb->actual_length == 0\n");
+		return;
+	}
+
+	len = data[0];
+	if (len != urb->actual_length) {
+		dev_err(&port->dev, "len(%d) != urb->actual_length(%d)\n", len,
+				urb->actual_length);
+		return;
+	}
+
+	/* bulk-in data: [LEN][Data.....][LSR] */
+	tty_flag = TTY_NORMAL;
+
+	lsr = data[len - 1];
+	if (lsr & UART_LSR_BRK_ERROR_BITS) {
+		if (lsr & UART_LSR_BI) {
+			tty_flag = TTY_BREAK;
+			port->icount.brk++;
+			usb_serial_handle_break(port);
+		} else if (lsr & UART_LSR_PE) {
+			tty_flag = TTY_PARITY;
+			port->icount.parity++;
+		} else if (lsr & UART_LSR_FE) {
+			tty_flag = TTY_FRAME;
+			port->icount.frame++;
+		}
+
+		if (lsr & UART_LSR_OE) {
+			port->icount.overrun++;
+			schedule_work(&priv->lsr_work);
+			tty_insert_flip_char(&port->port, 0, TTY_OVERRUN);
+		}
+	}
+
+	for (i = 1; i < urb->actual_length - 1; i++) {
+		if (port->port.console && port->sysrq) {
+			if (usb_serial_handle_sysrq_char(port, data[i]))
+				continue;
+		}
+
+		tty_insert_flip_char(&port->port, data[i], tty_flag);
+	}
+
+	tty_flip_buffer_push(&port->port);
+}
+
+static void f81232_read_urb_proxy(struct urb *urb)
+{
+	struct usb_serial_port *port = urb->context;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+
+	if (priv->process_read_urb)
+		priv->process_read_urb(urb);
+}
+
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -487,13 +583,28 @@ static void f81232_set_baudrate(struct tty_struct *tty,
 
 static int f81232_port_enable(struct usb_serial_port *port)
 {
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
 	u8 val;
 	int status;
 
-	/* fifo on, trigger8, clear TX/RX*/
-	val = UART_FCR_TRIGGER_8 | UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
-			UART_FCR_CLEAR_XMIT;
+	if (port_priv->device_type != F81232_F81232_TYPE) {
+		val = F81534A_TRIGGER_MULTPILE_4X | F81534A_FIFO_128BYTE;
+		status = f81232_set_mask_register(port, F81534A_MODE_CONF_REG,
+				F81534A_TRIGGER_MASK | F81534A_FIFO_128BYTE,
+				val);
+		if (status) {
+			dev_err(&port->dev, "failed to set MODE_CONF_REG: %d\n",
+					status);
+			return status;
+		}
+
+		val = UART_FCR_TRIGGER_14;
+	} else {
+		val = UART_FCR_TRIGGER_8;
+	}
 
+	/* fifo on, clear TX/RX */
+	val |= UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
 	status = f81232_set_register(port, FIFO_CONTROL_REGISTER, val);
 	if (status) {
 		dev_err(&port->dev, "%s failed to set FCR: %d\n",
@@ -631,6 +742,16 @@ static int f81232_tiocmset(struct tty_struct *tty,
 	return f81232_set_mctrl(port, set, clear);
 }
 
+static void f81232_detect_device_type(struct usb_serial_port *port)
+{
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+
+	if (port->serial->dev->descriptor.idProduct == 0x0706)
+		port_priv->device_type = F81232_F81232_TYPE;
+	else
+		port_priv->device_type = F81232_F81534A_TYPE;
+}
+
 static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	int result;
@@ -731,6 +852,7 @@ static void f81232_lsr_worker(struct work_struct *work)
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
+	int status = 0;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -741,11 +863,26 @@ static int f81232_port_probe(struct usb_serial_port *port)
 	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
+	f81232_detect_device_type(port);
 
 	port->port.drain_delay = 256;
 	priv->port = port;
 
-	return 0;
+	switch (priv->device_type) {
+	case F81232_F81534A_TYPE:
+		priv->process_read_urb = f81534a_process_read_urb;
+		break;
+
+	case F81232_F81232_TYPE:
+		priv->process_read_urb = f81232_process_read_urb;
+		break;
+
+	default:
+		status = -ENODEV;
+		break;
+	}
+
+	return status;
 }
 
 static int f81232_port_remove(struct usb_serial_port *port)
@@ -797,12 +934,10 @@ static int f81232_resume(struct usb_serial *serial)
 static struct usb_serial_driver f81232_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
-		.name =		"f81232",
+		.name =		"f81232/f81534a",
 	},
 	.id_table =		id_table,
 	.num_ports =		1,
-	.bulk_in_size =		256,
-	.bulk_out_size =	256,
 	.open =			f81232_open,
 	.close =		f81232_close,
 	.dtr_rts =		f81232_dtr_rts,
@@ -813,7 +948,7 @@ static struct usb_serial_driver f81232_device = {
 	.tiocmget =		f81232_tiocmget,
 	.tiocmset =		f81232_tiocmset,
 	.tiocmiwait =		usb_serial_generic_tiocmiwait,
-	.process_read_urb =	f81232_process_read_urb,
+	.process_read_urb =	f81232_read_urb_proxy,
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
 	.port_remove =		f81232_port_remove,
@@ -828,7 +963,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 
 module_usb_serial_driver(serial_drivers, id_table);
 
-MODULE_DESCRIPTION("Fintek F81232 USB to serial adaptor driver");
+MODULE_DESCRIPTION("Fintek F81232/532A/534A/535/536 USB to serial driver");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
 MODULE_AUTHOR("Peter Hong <peter_hong@fintek.com.tw>");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

