Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764CC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5614F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHC5mM/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFFCyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:54:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36594 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFFCyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so460786pgb.3;
        Wed, 05 Jun 2019 19:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICKBhKiZHRuK25W4lcIycKKRNXDv1c9lm2aVXCsX6zM=;
        b=aHC5mM/DHFs2zQ3zvh9RP7NxAkd9n84pqPpEz6MF5YaWY6k2T8/6KTeWs7bizvYvgf
         R7UPs62bRZEhrpMYs1IHdygqcb1hqwOy7106WZ70FqLlwFWH0D7OrnMUvcgXtQwg2BeA
         BBAlLsaBFj3FP/rGx7imp6Zg9OnanzaIzZ8du1YcHpM32pKzIzPPGbJ7TTEEjpmFzXsL
         sOmvZ12yLkxzoxMtJTr/81pyxYIXjajStJ0L0CJYrMiF2rjCTSShfIuRiGKEd39TZXgA
         pO0UM3hfokFBNTQcF8VdMnXMMrTnFDgahZZCz4vszyJcNo6N1hgy4OiUmDh9e2OaMHyp
         Ar+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICKBhKiZHRuK25W4lcIycKKRNXDv1c9lm2aVXCsX6zM=;
        b=Q9VY00zkWiQcwRGiXRYEgpMnmtrRM09WgdQq2bWUmOFNU+TI4r6fGZ/YuHFSSWlMy9
         gkG9pi+c3CUuWKnV7zq5DetUlvCA9iZbpu0FCOSN40KUcN83qd0Jo6Q8RegFflm2kOOU
         X3hi3yONBhW0wVy3HQEHqLscLZXL0Z7kb6C98RARSzWcm44fo+xaHUUAfC8/InIQot1w
         zDXHsHEZ/U13gyO/hIDEZG628+4FQQPPT8Gbr2DZEzDsLK/ehjU/Ah9fUQY6Ct1wY3LP
         gc3gexx8Rlej5QfrcLaeFO5BGSCCoV8BKcbdsS4JKFQzNF5vxh1+qGE+LeIug8kEBBZm
         S9yw==
X-Gm-Message-State: APjAAAWl7jSUYAx6Vg7GYhy36OfmAkEySLcWA/DqITdX0ao5Ima/eAjn
        8rQ33xoEc2cGIG1dyjauKto=
X-Google-Smtp-Source: APXvYqzgYUhXCTtDSeVd1Zy01PWMxTAD+rlBfLVn3tf+5xgQA5IE7Uqtj9Y3i1t1hhLJ5+X7aHyCBw==
X-Received: by 2002:a17:90a:6505:: with SMTP id i5mr48080029pjj.47.1559789684685;
        Wed, 05 Jun 2019 19:54:44 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id f13sm330613pje.11.2019.06.05.19.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:44 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 3/6] USB: serial: f81232: Add generator for F81534A
Date:   Thu,  6 Jun 2019 10:54:13 +0800
Message-Id: <1559789656-15847-4-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
but the UART is default disable and need enabled by GPIO device(2c42/16F8).
When F81534A plug to host, we can only see 1 HUB & 1 GPIO device, add
GPIO device USB interface to device_list and trigger generate worker,
f81534a_generate_worker to run f81534a_ctrl_generate_ports().

The operation in f81534a_ctrl_generate_ports() as following:
	1: Write 0x8fff to F81534A_CMD_ENABLE_PORT register for enable all
	   UART device.

	2: Read port existence & current status from F81534A_CMD_PORT_STATUS
	   register. the higher 16bit will indicate the UART existence. If the
	   UART is existence, we'll check it GPIO mode as long as not default
	   value (default is all input mode).

	3: 1 GPIO device will check with max 15s and check next GPIO device when
	   timeout. (F81534A_CTRL_RETRY * F81534A_CTRL_TIMER)

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 356 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 355 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 75dfc0b9ef30..e9470fb0d691 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -41,6 +41,12 @@ static const struct usb_device_id id_table[] = {
 };
 MODULE_DEVICE_TABLE(usb, id_table);
 
+static const struct usb_device_id f81534a_ctrl_id_table[] = {
+	{ USB_DEVICE(0x2c42, 0x16f8) },		/* Global control device */
+	{ }					/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(usb, f81534a_ctrl_id_table);
+
 /* Maximum baudrate for F81232 */
 #define F81232_MAX_BAUDRATE		1500000
 #define F81232_DEF_BAUDRATE		9600
@@ -49,6 +55,10 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81232_REGISTER_REQUEST		0xa0
 #define F81232_GET_REGISTER		0xc0
 #define F81232_SET_REGISTER		0x40
+#define F81534A_REGISTER_REQUEST	F81232_REGISTER_REQUEST
+#define F81534A_GET_REGISTER		F81232_GET_REGISTER
+#define F81534A_SET_REGISTER		F81232_SET_REGISTER
+#define F81534A_ACCESS_REG_RETRY	2
 
 #define SERIAL_BASE_ADDRESS		0x0120
 #define RECEIVE_BUFFER_REGISTER		(0x00 + SERIAL_BASE_ADDRESS)
@@ -83,6 +93,10 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81232_F81232_TYPE		1
 #define F81232_F81534A_TYPE		2
 
+#define F81534A_MAX_PORT		12
+#define F81534A_CTRL_TIMER		1000
+#define F81534A_CTRL_RETRY		15
+
 /* Serial port self GPIO control, 2bytes [control&output data][input data] */
 #define F81534A_GPIO_REG		0x10e
 #define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
@@ -92,6 +106,16 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
 #define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
 
+#define F81534A_CMD_ENABLE_PORT		0x116
+#define F81534A_CMD_PORT_STATUS		0x117
+
+/*
+ * Control device global GPIO control,
+ * 2bytes [control&output data][input data]
+ */
+#define F81534A_CTRL_GPIO_REG		0x1601
+#define F81534A_CTRL_GPIO_MAX_PIN	3
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
@@ -106,10 +130,27 @@ struct f81232_private {
 	void (*process_read_urb)(struct urb *urb);
 };
 
+struct f81534a_ctrl_private {
+	struct usb_interface *intf;
+	struct mutex lock;
+	int device_idx;
+};
+
+struct f81534a_device {
+	struct list_head list;
+	struct usb_interface *intf;
+	int check_index;
+	int check_retry;
+};
+
 static u32 const baudrate_table[] = { 115200, 921600, 1152000, 1500000 };
 static u8 const clock_table[] = { F81232_CLK_1_846_MHZ, F81232_CLK_14_77_MHZ,
 				F81232_CLK_18_46_MHZ, F81232_CLK_24_MHZ };
 
+struct delayed_work f81534a_generate_worker;
+static DEFINE_MUTEX(device_mutex);
+static LIST_HEAD(device_list);
+
 static int calc_baud_divisor(speed_t baudrate, speed_t clockrate)
 {
 	if (!baudrate)
@@ -859,6 +900,281 @@ static void f81232_lsr_worker(struct work_struct *work)
 		dev_warn(&port->dev, "read LSR failed: %d\n", status);
 }
 
+static int f81534a_ctrl_get_register(struct usb_device *dev, u16 reg, u16 size,
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
+	while (retry--) {
+		status = usb_control_msg(dev,
+					usb_rcvctrlpipe(dev, 0),
+					F81534A_REGISTER_REQUEST,
+					F81534A_GET_REGISTER,
+					reg,
+					0,
+					tmp,
+					size,
+					USB_CTRL_GET_TIMEOUT);
+		if (status != size) {
+			status = usb_translate_errors(status);
+			if (status == -EIO)
+				continue;
+
+			status = -EIO;
+		} else {
+			status = 0;
+			memcpy(val, tmp, size);
+		}
+
+		break;
+	}
+
+	if (status) {
+		dev_err(&dev->dev, "get reg: %x, failed status: %d\n", reg,
+				status);
+	}
+
+	kfree(tmp);
+	return status;
+}
+
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
+static int f81534a_ctrl_generate_ports(struct usb_interface *intf,
+					struct f81534a_device *device)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	uint32_t port_status;
+	u8 enable[2];
+	u8 tmp;
+	u8 mask;
+	int status;
+
+	/* enable all ports */
+	mask = F81534A_GPIO_MODE2_DIR | F81534A_GPIO_MODE1_DIR |
+			F81534A_GPIO_MODE0_DIR;
+	enable[0] = 0xff;
+	enable[1] = 0x8f;
+
+	status = f81534a_ctrl_set_register(dev, F81534A_CMD_ENABLE_PORT,
+			sizeof(enable), enable);
+	if (status) {
+		dev_warn(&dev->dev, "set CMD_ENABLE_PORT failed: %d\n", status);
+		return status;
+	}
+
+	/* get port state */
+	status = f81534a_ctrl_get_register(dev,
+			F81534A_CMD_PORT_STATUS, sizeof(port_status),
+			&port_status);
+	if (status) {
+		dev_warn(&dev->dev, "get CMD_PORT_STATUS failed: %d\n", status);
+		return status;
+	}
+
+	port_status >>= 16;
+
+	for (; device->check_index < F81534A_MAX_PORT; ++device->check_index) {
+		/* check port is exist, skip when not exist */
+		if (!(port_status & BIT(device->check_index)))
+			continue;
+
+		/*
+		 * All gpio for a port is default to input mode. It'll change
+		 * to RS232 mode after f81232_port_probe()/f81534a_port_init()
+		 * (2 output 0 & 1 input with pull high).
+		 */
+		status = f81534a_ctrl_get_register(dev,
+					F81534A_CTRL_GPIO_REG +
+					device->check_index, sizeof(tmp), &tmp);
+		if (status) {
+			dev_warn(&dev->dev, "get CTRL_GPIO_REG failed: %d\n",
+					status);
+			return status;
+		}
+
+		/* Check port had inited by f81232_port_probe() */
+		if ((tmp & mask) == mask)
+			break;
+	}
+
+	if (device->check_index < F81534A_MAX_PORT)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static void f81534a_ctrl_generate_worker(struct work_struct *work)
+{
+	struct f81534a_device *device;
+	int status;
+
+	mutex_lock(&device_mutex);
+	list_for_each_entry(device, &device_list, list) {
+		if (device->check_index >= F81534A_MAX_PORT)
+			continue;
+
+		if (device->check_retry >= F81534A_CTRL_RETRY)
+			continue;
+
+		device->check_retry++;
+
+		status = f81534a_ctrl_generate_ports(device->intf, device);
+		if (status == -EAGAIN) {
+			dev_dbg(&device->intf->dev, "delayed generating: %d\n",
+					device->check_retry);
+
+			schedule_delayed_work(&f81534a_generate_worker,
+					msecs_to_jiffies(F81534A_CTRL_TIMER));
+			break;
+		} else if (!status) {
+			/* make this device generated */
+			device->check_index = F81534A_MAX_PORT;
+
+			dev_dbg(&device->intf->dev, "generated complete\n");
+		} else {
+			/* skip this device to generate */
+			device->check_index = F81534A_MAX_PORT;
+
+			dev_err(&device->intf->dev,
+					"error: %d, do next device generate\n",
+					status);
+		}
+	}
+
+	mutex_unlock(&device_mutex);
+}
+
+static int f81534a_ctrl_probe(struct usb_interface *intf,
+				const struct usb_device_id *id)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct f81534a_ctrl_private *priv;
+	struct f81534a_device *device;
+
+	priv = devm_kzalloc(&intf->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	device = devm_kzalloc(&intf->dev, sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
+	usb_set_intfdata(intf, priv);
+
+	INIT_LIST_HEAD(&device->list);
+	device->intf = intf;
+
+	mutex_lock(&device_mutex);
+	list_add_tail(&device->list, &device_list);
+	mutex_unlock(&device_mutex);
+
+	dev = usb_get_dev(dev);
+	schedule_delayed_work(&f81534a_generate_worker,
+				msecs_to_jiffies(F81534A_CTRL_TIMER));
+
+	return 0;
+}
+
+static void f81534a_ctrl_disconnect(struct usb_interface *intf)
+{
+	struct f81534a_ctrl_private *priv;
+	struct f81534a_device *device;
+	struct usb_device *dev;
+
+	mutex_lock(&device_mutex);
+
+	list_for_each_entry(device, &device_list, list) {
+		if (device->intf == intf) {
+			list_del(&device->list);
+
+			priv = usb_get_intfdata(intf);
+			dev = interface_to_usbdev(intf);
+			usb_put_dev(dev);
+			break;
+		}
+	}
+
+	mutex_unlock(&device_mutex);
+}
+
+static int f81534a_ctrl_suspend(struct usb_interface *intf,
+					pm_message_t message)
+{
+	struct f81534a_device *device;
+
+	flush_delayed_work(&f81534a_generate_worker);
+
+	mutex_lock(&device_mutex);
+
+	list_for_each_entry(device, &device_list, list) {
+		device->check_index = 0;
+		device->check_retry = 0;
+	}
+
+	mutex_unlock(&device_mutex);
+
+	return 0;
+}
+
+static int f81534a_ctrl_resume(struct usb_interface *intf)
+{
+	schedule_delayed_work(&f81534a_generate_worker,
+				msecs_to_jiffies(F81534A_CTRL_TIMER));
+
+	return 0;
+}
+
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
@@ -976,7 +1292,45 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	NULL,
 };
 
-module_usb_serial_driver(serial_drivers, id_table);
+static struct usb_driver f81534a_ctrl_driver = {
+	.name =		"f81534a_ctrl",
+	.id_table =	f81534a_ctrl_id_table,
+	.probe =	f81534a_ctrl_probe,
+	.disconnect =	f81534a_ctrl_disconnect,
+	.suspend =	f81534a_ctrl_suspend,
+	.resume =	f81534a_ctrl_resume,
+};
+
+static int __init f81232_init(void)
+{
+	int status;
+
+	INIT_DELAYED_WORK(&f81534a_generate_worker,
+			f81534a_ctrl_generate_worker);
+
+	status = usb_register_driver(&f81534a_ctrl_driver, THIS_MODULE,
+			KBUILD_MODNAME);
+	if (status)
+		return status;
+
+	status = usb_serial_register_drivers(serial_drivers, KBUILD_MODNAME,
+			id_table);
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
2.7.4

