Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A65C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D02220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjWzis3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbfIWCZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:25:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36117 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389942AbfIWCZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:25:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so8189481pfr.3;
        Sun, 22 Sep 2019 19:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JGKuHnPmGZm1puHgATQylobqDcGcrhmJSBMIZlLK5Fw=;
        b=GjWzis3U17iJ8mc0+s8K1nlBfufJz9fM+FEJo+oHciX9FE8qSnM/SCsxggaZvqJcrj
         M5H9e4HOGV1ps6nZAazrXS+1D82v7a4ngHEoY414h9n9ISoWU89Na8kWb4ZGV2tomG3W
         iXf6oopdJcQhwONMc2x0Vy6s0n8qtxF39qknXL1vyPE2opaFem3XNrvNBiHo0x0axCHm
         zcqUhbbbZavOgIt7LFdyRf1jEaWRschi997YX3iGHkvIvZzRd7CEn34fP8kEeiW670c0
         DIN4NqIEkhYtwPDfXOxjHEVfgHULH1PVQIQ20Tn9ENSQI5A5Cf6FMbP7XUXRvpISJGm/
         Ju1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JGKuHnPmGZm1puHgATQylobqDcGcrhmJSBMIZlLK5Fw=;
        b=Q6IYFPu334VwlVQ/Npo0qJiOdpSvowRqisF7289JISJ+I3dIlSmNM66RQjitO/zp4o
         yY5s/ztEUAWdF7q0ElQDtsvHp5QXm/pJR3OHVk5zxAg5espVuRR94uhe7GJtvGFm0DkH
         Mp+UCM0Y9KWMSrbKBbl1/ab4wuRyBvvjwyDaFEho2t9fQU3Oum1rFrxzjm98geFQjOMh
         hp9Qj2WA0BSaKJcEAKK4kK/LAAS1/6U4JvoE9oGbnqcme09OOj9ynaRUO3yrG8k0jbvZ
         aZilnV4592enAPGTIubULTWwecJDobsP3/ENMjVdNBBonBdNdXqSqkGvopMpR7KNOA+/
         4F7w==
X-Gm-Message-State: APjAAAVoeM+C7ld0nExX1qUymXyy35XdI4/0sTxkFoJZwo5NuQMn/+6x
        XyMqHc4sVtkOqX8FQO7NoCD/BoCt
X-Google-Smtp-Source: APXvYqwOEHsfzWvR6/JdKc6IG9wULFtnFE6wrFxDpQc+OLT7BqRftqLvu8QhlW+1qdRCl/HB8RSh3g==
X-Received: by 2002:a17:90a:c583:: with SMTP id l3mr17934540pjt.68.1569205504465;
        Sun, 22 Sep 2019 19:25:04 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id v32sm10141215pga.38.2019.09.22.19.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Sep 2019 19:25:03 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 4/7] USB: serial: f81232: Add F81534A support
Date:   Mon, 23 Sep 2019 10:24:46 +0800
Message-Id: <20190923022449.10952-5-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81532A/534A/535/536 is USB-to-2/4/8/12 serial ports device
and the serial port is default disabled when plugin computer.

The IC is contains devices as following:
	1. HUB (all devices is connected with this hub)
	2. GPIO/Control device. (enable serial port and control GPIOs)
	3. serial port 1 to x (2/4/8/12)

It's most same with F81232, the UART device is difference as follow:
	1. TX/RX bulk size is 128/512bytes
	2. RX bulk layout change:
		F81232: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...
		F81534A:[LEN][Data.....][LSR]

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 131 ++++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index e4db0aec9af0..36a17aedc2ae 100644
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
@@ -21,11 +22,36 @@
 #include <linux/usb/serial.h>
 #include <linux/serial_reg.h>
 
+#define F81232_ID		\
+	{ USB_DEVICE(0x1934, 0x0706) }	/* 1 port UART device */
+
+#define F81534A_SERIES_ID	\
+	{ USB_DEVICE(0x2c42, 0x1602) },	/* In-Box 2 port UART device */	\
+	{ USB_DEVICE(0x2c42, 0x1604) },	/* In-Box 4 port UART device */	\
+	{ USB_DEVICE(0x2c42, 0x1605) },	/* In-Box 8 port UART device */	\
+	{ USB_DEVICE(0x2c42, 0x1606) },	/* In-Box 12 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1608) },	/* Non-Flash type */ \
+	{ USB_DEVICE(0x2c42, 0x1632) },	/* 2 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1634) },	/* 4 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
+	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
+
 static const struct usb_device_id id_table[] = {
-	{ USB_DEVICE(0x1934, 0x0706) },
+	F81232_ID,
+	{ }					/* Terminating entry */
+};
+
+static const struct usb_device_id f81534a_id_table[] = {
+	F81534A_SERIES_ID,
+	{ }					/* Terminating entry */
+};
+
+static const struct usb_device_id all_serial_id_table[] = {
+	F81232_ID,
+	F81534A_SERIES_ID,
 	{ }					/* Terminating entry */
 };
-MODULE_DEVICE_TABLE(usb, id_table);
+MODULE_DEVICE_TABLE(usb, all_serial_id_table);
 
 /* Maximum baudrate for F81232 */
 #define F81232_MAX_BAUDRATE		1500000
@@ -35,6 +61,10 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81232_REGISTER_REQUEST		0xa0
 #define F81232_GET_REGISTER		0xc0
 #define F81232_SET_REGISTER		0x40
+#define F81534A_REGISTER_REQUEST	F81232_REGISTER_REQUEST
+#define F81534A_GET_REGISTER		F81232_GET_REGISTER
+#define F81534A_SET_REGISTER		F81232_SET_REGISTER
+#define F81534A_ACCESS_REG_RETRY	2
 
 #define SERIAL_BASE_ADDRESS		0x0120
 #define RECEIVE_BUFFER_REGISTER		(0x00 + SERIAL_BASE_ADDRESS)
@@ -61,6 +91,11 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81232_CLK_14_77_MHZ		(BIT(1) | BIT(0))
 #define F81232_CLK_MASK			GENMASK(1, 0)
 
+#define F81534A_MODE_CONF_REG		0x107
+#define F81534A_TRIGGER_MASK		GENMASK(3, 2)
+#define F81534A_TRIGGER_MULTPILE_4X	BIT(3)
+#define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
@@ -383,6 +418,46 @@ static void f81232_process_read_urb(struct urb *urb)
 	tty_flip_buffer_push(&port->port);
 }
 
+static void f81534a_process_read_urb(struct urb *urb)
+{
+	struct usb_serial_port *port = urb->context;
+	unsigned char *data = urb->transfer_buffer;
+	char tty_flag;
+	unsigned int i;
+	u8 lsr;
+	u8 len;
+
+	if (urb->actual_length < 3) {
+		dev_err(&port->dev, "error actual_length: %d\n",
+				urb->actual_length);
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
+	lsr = data[len - 1];
+	tty_flag = f81232_handle_lsr(port, lsr);
+
+	if (port->port.console && port->sysrq) {
+		for (i = 1; i < urb->actual_length - 1; ++i)
+			if (!usb_serial_handle_sysrq_char(port, data[i]))
+				tty_insert_flip_char(&port->port, data[i],
+						tty_flag);
+	} else {
+		tty_insert_flip_string_fixed_flag(&port->port, &data[1],
+							tty_flag,
+							urb->actual_length - 2);
+	}
+
+	tty_flip_buffer_push(&port->port);
+}
+
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
@@ -666,6 +741,23 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return 0;
 }
 
+static int f81534a_open(struct tty_struct *tty, struct usb_serial_port *port)
+{
+	int status;
+	u8 val;
+
+	val = F81534A_TRIGGER_MULTPILE_4X | F81534A_FIFO_128BYTE;
+	status = f81232_set_mask_register(port, F81534A_MODE_CONF_REG,
+			F81534A_TRIGGER_MASK | F81534A_FIFO_128BYTE, val);
+	if (status) {
+		dev_err(&port->dev, "failed to set MODE_CONF_REG: %d\n",
+				status);
+		return status;
+	}
+
+	return f81232_open(tty, port);
+}
+
 static void f81232_close(struct usb_serial_port *port)
 {
 	struct f81232_private *port_priv = usb_get_serial_port_data(port);
@@ -772,6 +864,11 @@ static int f81232_port_probe(struct usb_serial_port *port)
 	return 0;
 }
 
+static int f81534a_port_probe(struct usb_serial_port *port)
+{
+	return f81232_port_probe(port);
+}
+
 static int f81232_suspend(struct usb_serial *serial, pm_message_t message)
 {
 	struct usb_serial_port *port = serial->port[0];
@@ -835,14 +932,40 @@ static struct usb_serial_driver f81232_device = {
 	.resume =		f81232_resume,
 };
 
+static struct usb_serial_driver f81534a_device = {
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		"f81534a",
+	},
+	.id_table =		f81534a_id_table,
+	.num_ports =		1,
+	.open =			f81534a_open,
+	.close =		f81232_close,
+	.dtr_rts =		f81232_dtr_rts,
+	.carrier_raised =	f81232_carrier_raised,
+	.get_serial =		f81232_get_serial_info,
+	.break_ctl =		f81232_break_ctl,
+	.set_termios =		f81232_set_termios,
+	.tiocmget =		f81232_tiocmget,
+	.tiocmset =		f81232_tiocmset,
+	.tiocmiwait =		usb_serial_generic_tiocmiwait,
+	.tx_empty =		f81232_tx_empty,
+	.process_read_urb =	f81534a_process_read_urb,
+	.read_int_callback =	f81232_read_int_callback,
+	.port_probe =		f81534a_port_probe,
+	.suspend =		f81232_suspend,
+	.resume =		f81232_resume,
+};
+
 static struct usb_serial_driver * const serial_drivers[] = {
 	&f81232_device,
+	&f81534a_device,
 	NULL,
 };
 
-module_usb_serial_driver(serial_drivers, id_table);
+module_usb_serial_driver(serial_drivers, all_serial_id_table);
 
-MODULE_DESCRIPTION("Fintek F81232 USB to serial adaptor driver");
+MODULE_DESCRIPTION("Fintek F81232/532A/534A/535/536 USB to serial driver");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
 MODULE_AUTHOR("Peter Hong <peter_hong@fintek.com.tw>");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1

