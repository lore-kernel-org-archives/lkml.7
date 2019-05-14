Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2610C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE9F2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmQgrtf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfENKyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:54:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40114 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENKyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:54:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id h13so11487864lfc.7;
        Tue, 14 May 2019 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5gCf64f1i5mM+uxSTlPPa/WGFqpkB/FiHuLp6tdIK0=;
        b=lmQgrtf6mjqtnOJukqqvlof6qvhh7grPUQbMEbN+vaTqv9uWfiZJox5LbQ4IiYUl/o
         5594AFvH2C3+g1KlqAfB4aHp8g8sgO2Ph0P8g7r41NTEZREpB651Yaor+O0E+9m3nQj/
         wBPQM7OYwSwz5Xy6EQnsng4BYJQepxnLinJHipaR9QlMaO4vqd23T2xjr/KXqsIxA642
         AL26ootXNvXuRXRUVlp4ni51C7hqQqUarMqXaURxcSBmOrDwglUMhDea0vqeByOhUx3e
         /5YuqX97wsI8T+DSn8UseIO4XcRPalU2KydE8+ke/jDV/eGOOkwMVNSDFC/47t1dpJ0D
         L+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5gCf64f1i5mM+uxSTlPPa/WGFqpkB/FiHuLp6tdIK0=;
        b=IVeaLkGkHIhoguu5a0aOl9Sr6H195C2kwyVW4hoNPnK+xBkitO9nnQHKNuDi3ymn+8
         84dEqC31qQs6eLfZY2PRps08lhSJ2AZ5YGEFd7+IJBy2ENO4ktUMAErmweBWOXEVzOEC
         LRCLV2tr5VwfpTmeqCeSKeg4OC7oPClywhMHuqhdgxpCY4KftGpIuEk5ZknFKeMrrHan
         Ti6oDB4/zFSmChBucieCvMqHsIAmwgEg2OD0PZngYtSmeZkxRgCJ1KQOWDQMxsIeog4i
         kTRwwqEo0E7j24V4dHkS+G5F7bKHRyHJsj3xTl8McyxlSHAa9+K7dlPs5L8YV+HFyj+f
         39EA==
X-Gm-Message-State: APjAAAVi+bK4Pw+0angEpHW7bnV4fYMaeeNhHZWdOJBfgia9Z5dt+Ls0
        /vL1ls80qqILV1RAHnAKenO9NqGucYk=
X-Google-Smtp-Source: APXvYqwMcdkPLCuSYhYUsjIRzu5r2Xn+cWNNwTeG7Td/h8qREZL3iDZOTrFkK5nIkxQ3wzGtqjlOmA==
X-Received: by 2002:ac2:494f:: with SMTP id o15mr1995575lfi.22.1557831250000;
        Tue, 14 May 2019 03:54:10 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id j1sm665246lja.17.2019.05.14.03.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:54:09 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: cp210x: Add cp2108 GPIOs support
Date:   Tue, 14 May 2019 13:53:57 +0300
Message-Id: <20190514105358.18818-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each chip from the cp210x series got GPIOs on board. This commit
provides the support for sixteen ones placed on the cp2108 four-ports
serial console controller. All of the GPIOs are equally distributed
to four USB interfaces in accordance with GPIOs alternative functions
attachment.

cp2108 GPIOs can be either in open-drain or push-pull modes setup once
after reset was cleared. In this matter it doesn't differ from the rest
of cp210x devices supported by the driver. So with minor alterations the
standard output/intput GPIO interface is implemented for cp2108.

Aside from traditional GPIO functions like setting/getting pins value,
each GPIO is also multiplexed with alternative functions: TX/RX LEDs, RS485
TX-enable and Clocks source. These functions can't be activated on-fly.
Instead the chips firmware should be properly setup, so they would be
enabled in the ports-config structure at the controller logic startup.
Needless to say, that when the alternative functions are activated,
the GPIOs can't be used. Thus we need to check the GPIO pin config in the
request callback and deny the request if GPIO standard function is
disabled.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/usb/serial/Kconfig  |   2 +-
 drivers/usb/serial/cp210x.c | 158 ++++++++++++++++++++++++++++++++----
 2 files changed, 143 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 7d031911d04e..20bd4c0632c7 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -138,7 +138,7 @@ config USB_SERIAL_DIGI_ACCELEPORT
 config USB_SERIAL_CP210X
 	tristate "USB CP210x family of UART Bridge Controllers"
 	help
-	  Say Y here if you want to use a CP2101/CP2102/CP2103 based USB
+	  Say Y here if you want to use a CP2101/2/3/4/5/8 based USB
 	  to RS232 converters.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 979bef9bfb6b..a97f04d9e99f 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -505,6 +505,56 @@ struct cp210x_gpio_write {
 	u8	state;
 } __packed;
 
+/* CP2108 interfaces, gpio (per interface), port-blocks number, GPIO block. */
+#define CP2108_IFACE_NUM		4
+#define CP2108_GPIO_NUM			4
+#define CP2108_PB_NUM			5
+#define CP2108_GPIO_PB			1
+
+/*
+ * CP2108 default pins state. There are five PBs. Each one is with its specific
+ * pins-set (see USB Express SDK sources or SDK-based smt application
+ * https://github.com/fancer/smt-cp210x for details).
+ */
+struct cp2108_state {
+	__le16	mode[CP2108_PB_NUM];	/* 0 - Open-Drain, 1 - Push-Pull */
+	__le16	low_power[CP2108_PB_NUM];
+	__le16	latch[CP2108_PB_NUM];	/* 0 - Logic Low, 1 - Logic High */
+} __packed;
+
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 73 bytes.
+ * Reset/Suspend latches describe default states after reset/suspend of the
+ * pins. The rest are responsible for alternate functions settings of the
+ * chip pins (see USB Express SDK sources or SDK-based smt application
+ * https://github.com/fancer/smt-cp210x for details).
+ */
+struct cp2108_config {
+	struct cp2108_state reset_latch;
+	struct cp2108_state suspend_latch;
+	u8	ip_delay[CP2108_IFACE_NUM];
+	u8	enhanced_fxn[CP2108_IFACE_NUM];
+	u8	enhanced_fxn_dev;
+	u8	ext_clock_freq[CP2108_IFACE_NUM];
+} __packed;
+
+/* CP2108 port alternate functions fields */
+#define CP2108_GPIO_TXLED_MODE		BIT(0)
+#define CP2108_GPIO_RXLED_MODE		BIT(1)
+#define CP2108_GPIO_RS485_MODE		BIT(2)
+#define CP2108_GPIO_RS485_LOGIC		BIT(3)
+#define CP2108_GPIO_CLOCK_MODE		BIT(4)
+#define CP2108_DYNAMIC_SUSPEND		BIT(5)
+
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x4 bytes
+ * to CP2108 controller.
+ */
+struct cp2108_gpio_write {
+	__le16	mask;
+	__le16	state;
+} __packed;
+
 /*
  * Helper to get interface number when we only have struct usb_serial.
  */
@@ -1366,10 +1416,15 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	u8 req_type = REQTYPE_DEVICE_TO_HOST;
-	int result;
-	u8 buf;
-
-	if (priv->partnum == CP210X_PARTNUM_CP2105)
+	union {
+		u8 single;
+		__le16 dual;
+	} buf;
+	int result, bufsize = sizeof(buf.single);
+
+	if (priv->partnum == CP210X_PARTNUM_CP2108)
+		bufsize = sizeof(buf.dual);
+	else if (priv->partnum == CP210X_PARTNUM_CP2105)
 		req_type = REQTYPE_INTERFACE_TO_HOST;
 
 	result = usb_autopm_get_interface(serial->interface);
@@ -1377,39 +1432,51 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 		return result;
 
 	result = cp210x_read_vendor_block(serial, req_type,
-					  CP210X_READ_LATCH, &buf, sizeof(buf));
+					  CP210X_READ_LATCH, &buf, bufsize);
 	usb_autopm_put_interface(serial->interface);
 	if (result < 0)
 		return result;
 
-	return !!(buf & BIT(gpio));
+	if (priv->partnum == CP210X_PARTNUM_CP2108)
+		result = !!(le16_to_cpu(buf.dual) & BIT(gpio));
+	else
+		result = !!(buf.single & BIT(gpio));
+
+	return result;
 }
 
 static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
 {
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
-	struct cp210x_gpio_write buf;
 	int result;
 
-	if (value == 1)
-		buf.state = BIT(gpio);
-	else
-		buf.state = 0;
-
-	buf.mask = BIT(gpio);
-
 	result = usb_autopm_get_interface(serial->interface);
 	if (result)
 		goto out;
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105) {
+	if (priv->partnum == CP210X_PARTNUM_CP2108) {
+		struct cp2108_gpio_write buf;
+
+		buf.state = ((value == 1) ? cpu_to_le16(BIT(gpio)) : 0);
+		buf.mask = cpu_to_le16(BIT(gpio));
+
+		result = cp210x_write_vendor_block(serial,
+						   REQTYPE_HOST_TO_DEVICE,
+						   CP210X_WRITE_LATCH, &buf,
+						   sizeof(buf));
+	} else if (priv->partnum == CP210X_PARTNUM_CP2105) {
+		struct cp210x_gpio_write buf;
+
+		buf.state = ((value == 1) ? BIT(gpio) : 0);
+		buf.mask = BIT(gpio);
+
 		result = cp210x_write_vendor_block(serial,
 						   REQTYPE_HOST_TO_INTERFACE,
 						   CP210X_WRITE_LATCH, &buf,
 						   sizeof(buf));
 	} else {
-		u16 wIndex = buf.state << 8 | buf.mask;
+		u16 wIndex = ((value == 1) ? BIT(gpio) : 0) << 8 | BIT(gpio);
 
 		result = usb_control_msg(serial->dev,
 					 usb_sndctrlpipe(serial->dev, 0),
@@ -1489,6 +1556,62 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
 	return -ENOTSUPP;
 }
 
+/*
+ * CP2108 got 16 GPIOs, each of which can be configured either as input, or
+ * as open-drain with weak pulling up to VIO or as push-pull with strong
+ * pulling up to VIO. Similar to the rest of devices the open-drain mode
+ * with latch set high is treated as input mode. All GPIOs are equally
+ * distributed between four interfaces. Thanks to the mask-state based
+ * write-latch control message we don't need to worry about possible races.
+ */
+static int cp2108_gpioconf_init(struct usb_serial *serial)
+{
+	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
+	struct cp2108_config config;
+	u16 mode, latch;
+	u8 intf_num;
+	int result;
+
+	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
+					  CP210X_GET_PORTCONFIG, &config,
+					  sizeof(config));
+	if (result < 0)
+		return result;
+
+	/*
+	 * There are four interfaces with four GPIOs for each port. Here we
+	 * parse the device config data to comply with the driver interface.
+	 * Note that the mode can be changed only after reset, which cause
+	 * the driver reloading anyway. So we can safely read the config just
+	 * once at attach procedure.
+	 */
+	intf_num = cp210x_interface_num(serial);
+	mode = le16_to_cpu(config.reset_latch.mode[CP2108_GPIO_PB]);
+	latch = le16_to_cpu(config.reset_latch.latch[CP2108_GPIO_PB]);
+
+	priv->gpio_altfunc = config.enhanced_fxn[intf_num];
+	priv->gpio_pushpull = (mode >> (intf_num*CP2108_GPIO_NUM)) & 0x0f;
+	priv->gpio_input = (latch >> (intf_num*CP2108_GPIO_NUM)) & 0x0f;
+
+	/*
+	 * Move the GPIO clock alternative function bit value to the fourth bit
+	 * as the corresponding GPIO pin reside. It shall make the generic
+	 * cp210x GPIO request method being suitable for cp2108 as well.
+	 */
+	priv->gpio_altfunc &= ~BIT(3);
+	if (priv->gpio_altfunc & CP2108_GPIO_CLOCK_MODE)
+		priv->gpio_altfunc |= BIT(3);
+
+	/*
+	 * Open-drain mode in combination with a high latch value is used
+	 * to emulate the GPIO input pin.
+	 */
+	priv->gpio_input &= ~priv->gpio_pushpull;
+	priv->gc.ngpio = CP2108_GPIO_NUM;
+
+	return 0;
+}
+
 /*
  * This function is for configuring GPIO using shared pins, where other signals
  * are made unavailable by configuring the use of GPIO. This is believed to be
@@ -1713,6 +1836,9 @@ static int cp210x_gpio_init(struct usb_serial *serial)
 	case CP210X_PARTNUM_CP2105:
 		result = cp2105_gpioconf_init(serial);
 		break;
+	case CP210X_PARTNUM_CP2108:
+		result = cp2108_gpioconf_init(serial);
+		break;
 	case CP210X_PARTNUM_CP2102N_QFN28:
 	case CP210X_PARTNUM_CP2102N_QFN24:
 	case CP210X_PARTNUM_CP2102N_QFN20:
-- 
2.21.0

