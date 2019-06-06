Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4772FC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AF520684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFHl48wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFFCy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:54:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39130 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfFFCyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so451730pgc.6;
        Wed, 05 Jun 2019 19:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9qzxTtSrBQ5yiYZWANHKeD1gxX9yGCs4JtFgEEpNmLc=;
        b=NFHl48wdu8H54gDe3MgtK+zK2XtWsCKvwwV4Z+4p726sGav4e8v8zMWQwVrl1cRGb9
         S7uALOI2m3zWMVTxlKjFikWCCqtFYOWDsJeLI80Y2Tt21PAdXLJ8/8RmiVQnlmfHTTfK
         8oYbbIakk0wEep88Dui7DYGOGxIGJBRtGZ4zmKeFKsVtvMV+b+cPpaDXpSxYefBkQ7SQ
         UZITjleVI2SJoFqkTRHUR6ROdY1vEn26K/w71xDpwgqH71LE6ui+33E1A4awEkXZ8pu0
         rWv5GsuZ3u82xTjIH8jQk1g+dOKMeGhxfx7SDyEPTx7fY9qJQ02nhfEnCLSbtj8Fx2Ad
         WW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9qzxTtSrBQ5yiYZWANHKeD1gxX9yGCs4JtFgEEpNmLc=;
        b=YlXQyJoc95fuHK8Cz/3jhWBOFK/HOptdtb4FoRHkdF2yaarzphazFFhi5yPlaKxlru
         ZsUlsiLtdOMi6Yu9bIsMH2Yh+c5bXro+D+Rki01xkISls1kuUNLIIlKDzxbxoQZJUMNg
         qA6X+X8VjsYhNGk3zkC4FRgSO6i+yQdGtZhEe0um91eheg1v1+FPCH4otabv7p5zhpUE
         L7ZApYvaZDq545QZdG72bKegDhhgsFgI6wtzLqQ4qfwouBOXnv4DhPzW0A18XVtH3z6U
         2Zwvzbz4bOtXzIWPEawm184kYAlSJLogZa6LKBnJxL6xO6qDpAhffUeDoS3shVl8wwII
         8B5A==
X-Gm-Message-State: APjAAAW2wqc2QmGwf0YNeHvrIYRyoWLjwRdcOk02CWdIGnmBTg9PwvEb
        PXbebgg8BvjXYeLAgNoyC9E=
X-Google-Smtp-Source: APXvYqyvH2xV0j/BKNa3c3je66CbNvcNM+2U5qvxAcIIW8NMYNcHuH5hfA7X7p8VPs7YkggkXMn98Q==
X-Received: by 2002:a62:3006:: with SMTP id w6mr48521974pfw.159.1559789691779;
        Wed, 05 Jun 2019 19:54:51 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id j14sm304049pfe.10.2019.06.05.19.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:51 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 6/6] USB: serial: f81232: Add gpiolib to GPIO device
Date:   Thu,  6 Jun 2019 10:54:16 +0800
Message-Id: <1559789656-15847-7-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fintek F81534A series contains 3 GPIOs per UART and The max GPIOs
is 12x3 = 36 GPIOs.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 210 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 708d85c7d822..a53240bc164a 100644
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
@@ -132,6 +133,7 @@ struct f81232_private {
 
 struct f81534a_ctrl_private {
 	struct usb_interface *intf;
+	struct gpio_chip chip;
 	struct mutex lock;
 	int device_idx;
 };
@@ -1007,6 +1009,204 @@ static int f81534a_ctrl_set_register(struct usb_device *dev, u16 reg, u16 size,
 	return status;
 }
 
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
+#ifdef CONFIG_GPIOLIB
+static int f81534a_gpio_get(struct gpio_chip *chip, unsigned int gpio_num)
+{
+	struct f81534a_ctrl_private *priv = gpiochip_get_data(chip);
+	struct usb_interface *intf = priv->intf;
+	struct usb_device *dev = interface_to_usbdev(intf);
+	int status;
+	u8 tmp[2];
+	int set;
+	int idx;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+
+	status = mutex_lock_interruptible(&priv->lock);
+	if (status)
+		return -EINTR;
+
+	status = f81534a_ctrl_get_register(dev, F81534A_CTRL_GPIO_REG + set,
+							sizeof(tmp), tmp);
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
+	u8 mask;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+	mask = F81534A_GPIO_MODE0_DIR << idx;
+
+	status = mutex_lock_interruptible(&priv->lock);
+	if (status)
+		return -EINTR;
+
+	status = f81534a_ctrl_set_mask_register(dev, F81534A_CTRL_GPIO_REG +
+				set, mask, mask);
+	if (status) {
+		mutex_unlock(&priv->lock);
+		return status;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
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
+	u8 mask;
+	u8 data;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+	mask = (F81534A_GPIO_MODE0_DIR << idx) | BIT(idx);
+	data = val ? BIT(idx) : 0;
+
+	status = mutex_lock_interruptible(&priv->lock);
+	if (status)
+		return -EINTR;
+
+	status = f81534a_ctrl_set_mask_register(dev, F81534A_CTRL_GPIO_REG +
+				set, mask, data);
+	if (status) {
+		mutex_unlock(&priv->lock);
+		return status;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
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
+	u8 mask;
+
+	set = gpio_num / F81534A_CTRL_GPIO_MAX_PIN;
+	idx = gpio_num % F81534A_CTRL_GPIO_MAX_PIN;
+	mask = F81534A_GPIO_MODE0_DIR << idx;
+
+	status = mutex_lock_interruptible(&priv->lock);
+	if (status)
+		return -EINTR;
+
+	status = f81534a_ctrl_get_register(dev, F81534A_CTRL_GPIO_REG + set,
+							sizeof(tmp), tmp);
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
+	/* M0(SD)/M1/M2 */
+	priv->chip.ngpio = F81534A_CTRL_GPIO_MAX_PIN * F81534A_MAX_PORT;
+	priv->chip.base = -1;
+
+	priv->intf = intf;
+	mutex_init(&priv->lock);
+
+	status = devm_gpiochip_add_data(&intf->dev, &priv->chip, priv);
+	if (status) {
+		dev_err(&intf->dev, "%s: failed: %d\n", __func__, status);
+		return status;
+	}
+
+	return 0;
+}
+#else
+static int f81534a_prepare_gpio(struct usb_interface *intf)
+{
+	dev_warn(&intf->dev, "CONFIG_GPIOLIB is not enabled\n");
+	dev_warn(&intf->dev, "The GPIOLIB interface will not register\n");
+
+	return 0;
+}
+#endif
+
+static int f81534a_release_gpio(struct usb_interface *intf)
+{
+	return 0;
+}
+
 static int f81534a_ctrl_generate_ports(struct usb_interface *intf,
 					struct f81534a_device *device)
 {
@@ -1118,6 +1318,7 @@ static int f81534a_ctrl_probe(struct usb_interface *intf,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct f81534a_ctrl_private *priv;
 	struct f81534a_device *device;
+	int status;
 
 	priv = devm_kzalloc(&intf->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -1130,6 +1331,10 @@ static int f81534a_ctrl_probe(struct usb_interface *intf,
 	mutex_init(&priv->lock);
 	usb_set_intfdata(intf, priv);
 
+	status = f81534a_prepare_gpio(intf);
+	if (status)
+		return status;
+
 	INIT_LIST_HEAD(&device->list);
 	device->intf = intf;
 
@@ -1158,6 +1363,11 @@ static void f81534a_ctrl_disconnect(struct usb_interface *intf)
 
 			priv = usb_get_intfdata(intf);
 			dev = interface_to_usbdev(intf);
+
+			mutex_lock(&priv->lock);
+			f81534a_release_gpio(intf);
+			mutex_unlock(&priv->lock);
+
 			usb_put_dev(dev);
 			break;
 		}
-- 
2.7.4

