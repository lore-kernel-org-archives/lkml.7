Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E99620820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQb2Ef8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404362AbfIWCZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:25:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41956 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404136AbfIWCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:25:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so8169522pfh.8;
        Sun, 22 Sep 2019 19:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aYTIb5+HeXvcNODzGlkiruxjeMT6SF7+WnXVgect7+c=;
        b=JQb2Ef8HDbkf2q+B56wFJAtwl43uTQ/7YjMyMie5A0OUkG5NV2j1LBRAXpk3uI76Im
         0yH6WI2CMzuBdFdqzwk7URfj71sYpE9offwa6gIXqNqIiWtYO6/1DJqOGUSJX9CyOIZM
         eHzofP4gDUvH14hXFztPN3ShQrYsjk2nXKL1LqZ4ERbyfV3PBFFLh7pAS8ySLr3zZuHO
         yC80CAEUQYdDnlbkwnoJQe20fdiOM7dK4CxqiqhOrqXxTNDF2GOUED6Gv40Irm3ixSSZ
         xa2JV3EegnsM253skPuP+/n7meKwAUBlhgWHvZ5SkVGym9/Lv5i9sc6LRd8goZ9L/AGy
         Jc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aYTIb5+HeXvcNODzGlkiruxjeMT6SF7+WnXVgect7+c=;
        b=d+lMZsBJ+MJUZCnLyJnxiaB0qsJFonMB2IE22kqhpjlnwBzGGs+DDVcZ32ze3WthDT
         hO3ounYpfphw0vEluq4jsBNIiOUMGpYIwUxUsm4OQAIudtjcMnI70VQRDm1R7VMu7xtv
         vEUDU4kLfoApS9u6nvObcgAMiGqUAwmUlcZC7zcg6gpN6wknU//gO37b40kTnzuFdMx0
         YxWnk4OPInKvRr/sNFp2tfwAGJQcIlT/A9UBSuALImTJYiyOVls/SL+ljRBHbzdk+H8D
         rhUUNR1ggxX99sWXthoSb7Fsz2dnnVGpWs39g+rU3JF89aSNmuPQAjrzApy8CpOnItRZ
         DlAg==
X-Gm-Message-State: APjAAAWtW1wPeYf9ak0TbAbr9DYHOKa0kzBYIYTrjlhWum+AS4Jv/ck8
        IyAHKpR5yW3leb5G+I2oF9iY+mVK
X-Google-Smtp-Source: APXvYqyO6FF61b2fEjY4lrea5JdKPhIY1Vn9x+3qqiapoACQpFLE9nkfJucV5PK8GtNlid4dZwaTBw==
X-Received: by 2002:a17:90a:bf0e:: with SMTP id c14mr17660886pjs.69.1569205512042;
        Sun, 22 Sep 2019 19:25:12 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id a17sm9305366pfi.178.2019.09.22.19.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Sep 2019 19:25:11 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 7/7] USB: serial: f81232: Add gpiolib to GPIO device
Date:   Mon, 23 Sep 2019 10:24:49 +0800
Message-Id: <20190923022449.10952-8-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81534A series contains 3 GPIOs per UART and The max GPIOs
is 12x3 = 36 GPIOs and this patch will implements GPIO device as a
gpiochip to control all GPIO pins even transforms to transceiver pins.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 249 ++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 82cc1e6cff62..dc9b28738b80 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -18,6 +18,7 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/uaccess.h>
+#include <linux/gpio.h>
 #include <linux/usb.h>
 #include <linux/usb/serial.h>
 #include <linux/serial_reg.h>
@@ -104,6 +105,8 @@ MODULE_DEVICE_TABLE(usb, all_serial_id_table);
 #define F81534A_TRIGGER_MULTPILE_4X	BIT(3)
 #define F81534A_FIFO_128BYTE		(BIT(1) | BIT(0))
 
+#define F81534A_MAX_PORT		12
+
 /* Serial port self GPIO control, 2bytes [control&output data][input data] */
 #define F81534A_GPIO_REG		0x10e
 #define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
@@ -115,6 +118,13 @@ MODULE_DEVICE_TABLE(usb, all_serial_id_table);
 
 #define F81534A_CMD_ENABLE_PORT		0x116
 
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
@@ -126,6 +136,12 @@ struct f81232_private {
 	struct usb_serial_port *port;
 };
 
+struct f81534a_ctrl_private {
+	struct usb_interface *intf;
+	struct gpio_chip chip;
+	struct mutex lock;
+};
+
 static u32 const baudrate_table[] = { 115200, 921600, 1152000, 1500000 };
 static u8 const clock_table[] = { F81232_CLK_1_846_MHZ, F81232_CLK_14_77_MHZ,
 				F81232_CLK_18_46_MHZ, F81232_CLK_24_MHZ };
@@ -863,6 +879,50 @@ static void f81232_lsr_worker(struct work_struct *work)
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
 static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
 					void *val)
 {
@@ -908,6 +968,182 @@ static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
 	return status;
 }
 
+#ifdef CONFIG_GPIOLIB
+static int f81534a_ctrl_set_mask_register(struct usb_device *dev, u16 reg,
+		u8 mask, u8 val)
+{
+	int status;
+	u8 tmp;
+
+	status = f81534a_ctrl_get_register(dev, reg, 1, &tmp);
+	if (status)
+		return status;
+
+
+	tmp = (tmp & ~mask) | (val & mask);
+
+	status = f81534a_ctrl_set_register(dev, reg, 1, &tmp);
+	if (status)
+		return status;
+
+	return 0;
+}
+
+static int f81534a_gpio_get(struct gpio_chip *chip, unsigned int gpio_num)
+{
+	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
+	struct usb_interface *intf = priv->intf;
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int status;
+	u8 tmp[2];
+	int set;
+	int idx;
+	int reg;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+	reg = F81534A_CTRL_GPIO_REG + set;
+
+	mutex_lock(&priv->lock);
+
+	status = f81534a_ctrl_get_register(dev, reg, sizeof(tmp), tmp);
+	if (status) {
+		mutex_unlock(&priv->lock);
+		return status;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return !!(tmp[1] & BIT(idx));
+}
+
+static int f81534a_gpio_direction_in(struct gpio_chip *chip,
+					unsigned int gpio_num)
+{
+	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
+	struct usb_interface *intf = priv->intf;
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int status;
+	int set;
+	int idx;
+	int reg;
+	u8 mask;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+	mask = F81534A_GPIO_MODE0_DIR << idx;
+	reg = F81534A_CTRL_GPIO_REG + set;
+
+	mutex_lock(&priv->lock);
+	status = f81534a_ctrl_set_mask_register(dev, reg, mask, mask);
+	mutex_unlock(&priv->lock);
+
+	return status;
+}
+
+static int f81534a_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned int gpio_num, int val)
+{
+	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
+	struct usb_interface *intf = priv->intf;
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int status;
+	int set;
+	int idx;
+	int reg;
+	u8 mask;
+	u8 data;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+	mask = (F81534A_GPIO_MODE0_DIR << idx) | BIT(idx);
+	reg = F81534A_CTRL_GPIO_REG + set;
+	data = val ? BIT(idx) : 0;
+
+	mutex_lock(&priv->lock);
+	status = f81534a_ctrl_set_mask_register(dev, reg, mask, data);
+	mutex_unlock(&priv->lock);
+
+	return status;
+}
+
+static void f81534a_gpio_set(struct gpio_chip *chip, unsigned int gpio_num,
+				int val)
+{
+	f81534a_gpio_direction_out(chip, gpio_num, val);
+}
+
+static int f81534a_gpio_get_direction(struct gpio_chip *chip,
+				unsigned int gpio_num)
+{
+	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
+	struct usb_interface *intf = priv->intf;
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int status;
+	u8 tmp[2];
+	int set;
+	int idx;
+	int reg;
+	u8 mask;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+	mask = F81534A_GPIO_MODE0_DIR << idx;
+	reg = F81534A_CTRL_GPIO_REG + set;
+
+	mutex_lock(&priv->lock);
+
+	status = f81534a_ctrl_get_register(dev, reg, sizeof(tmp), tmp);
+	if (status) {
+		mutex_unlock(&priv->lock);
+		return status;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	if (tmp[0] & mask)
+		return GPIOF_DIR_IN;
+
+	return GPIOF_DIR_OUT;
+}
+
+static int f81534a_prepare_gpio(struct usb_interface *intf)
+{
+	struct f81534a_ctrl_private *priv = usb_get_intfdata(intf);
+	int status;
+
+	priv->chip.parent = &intf->dev;
+	priv->chip.owner = THIS_MODULE;
+	priv->chip.get_direction = f81534a_gpio_get_direction,
+	priv->chip.get = f81534a_gpio_get;
+	priv->chip.direction_input = f81534a_gpio_direction_in;
+	priv->chip.set = f81534a_gpio_set;
+	priv->chip.direction_output = f81534a_gpio_direction_out;
+	priv->chip.label = "f81534a";
+	priv->chip.can_sleep = true;
+	/* M0(SD)/M1/M2 */
+	priv->chip.ngpio = F81534A_CTRL_GPIO_MAX_PIN * F81534A_MAX_PORT;
+	priv->chip.base = -1;
+
+	priv->intf = intf;
+	mutex_init(&priv->lock);
+
+	status = devm_gpiochip_add_data(&intf->dev, &priv->chip, priv);
+	if (status) {
+		dev_err(&intf->dev, "failed to register gpiochip: %d\n",
+				status);
+		return status;
+	}
+
+	return 0;
+}
+#else
+static int f81534a_prepare_gpio(struct usb_interface *intf)
+{
+	return 0;
+}
+#endif
+
 static int f81534a_ctrl_enable_all_ports(struct usb_interface *intf)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -930,8 +1166,21 @@ static int f81534a_ctrl_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
+	struct f81534a_ctrl_private *priv;
 	int status;
 
+	priv = devm_kzalloc(&intf->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
+	usb_set_intfdata(intf, priv);
+	priv->intf = intf;
+
+	status = f81534a_prepare_gpio(intf);
+	if (status)
+		return status;
+
 	status = f81534a_ctrl_enable_all_ports(intf);
 	if (status)
 		return status;
-- 
2.17.1

