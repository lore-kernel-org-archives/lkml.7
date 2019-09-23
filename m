Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2309BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAB220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCCaaKEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404213AbfIWCZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:25:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37481 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404127AbfIWCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:25:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so8185335pfo.4;
        Sun, 22 Sep 2019 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m2Jm8H+k+T9Y9bpQG3jtDNyGk+0U+Plvy/NdnRGLxT0=;
        b=vCCaaKEA15fTyVj6g3hsk+I78MOez77YEMhwJbxgTWTrF9nQHRzliKL1sZ8mAQgWpT
         OWdVsa0T27Ym/ic62FY4O7elCq3EyvFWz1BUXLgX60HxYMizNNgw5cdCweuI1seYPQJS
         q0KJwe6poBBFPfW6dEFpp+yo0o/2OX3/X7Am//j7YtpPtfjiVsPVxlVWV810OoiYCPMe
         /RhSBWoiP16BVgjndIvyOB6pj1bb7T5wXcFBrwRhJdK6CnvM4fndo2DJ1QSfgZMtYOEe
         hOTTCMO0iaKwWZo3KfpdoG/xu6l1px/V4rMLqk2hCV3Qughmitq69c8A0qX59Npt1rUb
         XNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m2Jm8H+k+T9Y9bpQG3jtDNyGk+0U+Plvy/NdnRGLxT0=;
        b=PZdw1N/1y1aZ17aejhwOV5Xt+bzhOo8HoXsO2OSjYkWJuk9eO5/qnUlrHWklWyfMuO
         B1crVt/vnsbNnf2DM0gvc1zasKBAeQ/yzh78E7JeePzsOUOz7orL9KDrcn2RMFGpeS/8
         7Qqnf44A1v66wR4C3q4LLZ2OxXsGYhGP+g8QxSllAUfP5SSn4Msa50S2FmmG7cAFYREN
         0nJne9fJ4cbBRtN7zFRn6Em8+8PGbtdwue/m669BF1tmzgkeuv+qlvpkxMW8eHdN0jJb
         TPpC+G1zE1vwdSk9EhfeGNwxdY+bz8AXsP5ZzFJXCtCc/j1zStZYD5plO0SlRGR87580
         SJxA==
X-Gm-Message-State: APjAAAXezEmsuK5psBwKqRpj2wozLEWwS1Cc0qs6wf8aiaxBozMxX3K/
        uucMpriiPFhPJpxY3q2kggo=
X-Google-Smtp-Source: APXvYqznEq2X3ueRTvigAoVd36h8hWhaaqpD/3VxLXGmXk4aUOwisrAxoWcM32nXRyNI9fVdZeyZKQ==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr26477024pga.72.1569205509548;
        Sun, 22 Sep 2019 19:25:09 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id 20sm9759647pfp.153.2019.09.22.19.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Sep 2019 19:25:08 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 6/7] USB: serial: f81232: Add generator for F81534A
Date:   Mon, 23 Sep 2019 10:24:48 +0800
Message-Id: <20190923022449.10952-7-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
but the UART is default disable and need enabled by GPIO device(2c42/16F8).

When F81534A plug to host, we can only see 1 HUB & 1 GPIO device and we
need write 0x8fff to GPIO device register F81534A_CMD_ENABLE_PORT(116h)
to enable all available serial ports.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 135 +++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 01cb5a5ea1d2..82cc1e6cff62 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -36,6 +36,9 @@
 	{ USB_DEVICE(0x2c42, 0x1635) },	/* 8 port UART device */ \
 	{ USB_DEVICE(0x2c42, 0x1636) }	/* 12 port UART device */
 
+#define F81534A_CTRL_ID		\
+	{ USB_DEVICE(0x2c42, 0x16f8) }	/* Global control device */
+
 static const struct usb_device_id id_table[] = {
 	F81232_ID,
 	{ }					/* Terminating entry */
@@ -46,6 +49,11 @@ static const struct usb_device_id f81534a_id_table[] = {
 	{ }					/* Terminating entry */
 };
 
+static const struct usb_device_id f81534a_ctrl_id_table[] = {
+	F81534A_CTRL_ID,
+	{ }					/* Terminating entry */
+};
+
 static const struct usb_device_id all_serial_id_table[] = {
 	F81232_ID,
 	F81534A_SERIES_ID,
@@ -105,6 +113,8 @@ MODULE_DEVICE_TABLE(usb, all_serial_id_table);
 #define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
 #define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
 
+#define F81534A_CMD_ENABLE_PORT		0x116
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
@@ -853,6 +863,95 @@ static void f81232_lsr_worker(struct work_struct *work)
 		dev_warn(&port->dev, "read LSR failed: %d\n", status);
 }
 
+static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
+					void *val)
+{
+	int retry = F81534A_ACCESS_REG_RETRY;
+	int status;
+	u8 *tmp;
+
+	tmp = kmalloc(size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	memcpy(tmp, val, size);
+
+	while (retry--) {
+		status = usb_control_msg(dev,
+					usb_sndctrlpipe(dev, 0),
+					F81534A_REGISTER_REQUEST,
+					F81534A_SET_REGISTER,
+					reg,
+					0,
+					tmp,
+					size,
+					USB_CTRL_SET_TIMEOUT);
+		if (status != size) {
+			status = usb_translate_errors(status);
+			if (status == -EIO)
+				continue;
+
+			status = -EIO;
+		} else {
+			status = 0;
+		}
+
+		break;
+	}
+
+	if (status) {
+		dev_err(&dev->dev, "set ctrl reg: %x, failed status: %d\n", reg,
+				status);
+	}
+
+	kfree(tmp);
+	return status;
+}
+
+static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	unsigned char enable[2];
+	int status;
+
+	/* enable all available serial ports */
+	enable[0] = 0xff;
+	enable[1] = 0x8f;
+
+	status = f81534a_ctrl_set_register(dev, F81534A_CMD_ENABLE_PORT,
+			sizeof(enable), enable);
+	if (status)
+		dev_warn(&dev->dev, "set CMD_ENABLE_PORT failed: %d\n", status);
+
+	return status;
+}
+
+static int f81534a_ctrl_probe(struct usb_interface *intf,
+				const struct usb_device_id *id)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int status;
+
+	status = f81534a_ctrl_enable_all_ports(intf);
+	if (status)
+		return status;
+
+	dev = usb_get_dev(dev);
+	return 0;
+}
+
+static void f81534a_ctrl_disconnect(struct usb_interface *intf)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+
+	usb_put_dev(dev);
+}
+
+static int f81534a_ctrl_resume(struct usb_interface *intf)
+{
+	return f81534a_ctrl_enable_all_ports(intf);
+}
+
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
@@ -980,7 +1079,41 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	NULL,
 };
 
-module_usb_serial_driver(serial_drivers, all_serial_id_table);
+static struct usb_driver f81534a_ctrl_driver = {
+	.name =		"f81534a_ctrl",
+	.id_table =	f81534a_ctrl_id_table,
+	.probe =	f81534a_ctrl_probe,
+	.disconnect =	f81534a_ctrl_disconnect,
+	.resume =	f81534a_ctrl_resume,
+};
+
+static int __init f81232_init(void)
+{
+	int status;
+
+	status = usb_register_driver(&f81534a_ctrl_driver, THIS_MODULE,
+			KBUILD_MODNAME);
+	if (status)
+		return status;
+
+	status = usb_serial_register_drivers(serial_drivers, KBUILD_MODNAME,
+			all_serial_id_table);
+	if (status) {
+		usb_deregister(&f81534a_ctrl_driver);
+		return status;
+	}
+
+	return 0;
+}
+
+static void __exit f81232_exit(void)
+{
+	usb_serial_deregister_drivers(serial_drivers);
+	usb_deregister(&f81534a_ctrl_driver);
+}
+
+module_init(f81232_init);
+module_exit(f81232_exit);
 
 MODULE_DESCRIPTION("Fintek F81232/532A/534A/535/536 USB to serial driver");
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
-- 
2.17.1

