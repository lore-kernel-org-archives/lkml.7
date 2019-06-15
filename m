Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DEBC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E0E2183F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 23:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvdkV5cG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfFOXEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 19:04:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39009 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOXEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 19:04:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so5831814ljh.6;
        Sat, 15 Jun 2019 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NONQBdb+pfcHYzENH5Odw1Xp8uPTi/+xwRXbGtULsKI=;
        b=gvdkV5cGaNPTsv2GoOMfCJNj1Gz9YgnfXbEwmrV+2zz6Wkr4/onEZVloqprgYq3TZG
         brekeYNFWIX0Tg6x2t7f2op06H6BKzLgZ/aFCCzDwcjh5e7TY6h2AaTwxjRI7yBvJ0oa
         IV37MlQaLLH6swuYmEyUaFSZSFwqOB/8Bzo6TZIPr86mMIJzaL7BEYcs+lV6NcBJ5ulM
         wbJOfuZ1kKQYd7JuU51Hd63kSDtyLx3mIG9gFi1PsxVC7MpbxNVlsPZ5jlxtSPj9X61b
         8B/fU0rds6DWU9pbH+GRL2R/2EZ0UZ3yjivHRp5nGbeMwKxDvlz9KRG2PULpS4njh5aL
         ot6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NONQBdb+pfcHYzENH5Odw1Xp8uPTi/+xwRXbGtULsKI=;
        b=npNi7i8gHolItv0GgSpor5b02oOajPwZx1JqPsxafFJ/MG7NPMamRQALJ1UhS2zwjc
         Yps1eKzXyK8vjTP/KNOROtbDu+L+bjBki+Vir4Em2+wKFFjP09gFo02YYZYm98kjKqS+
         YVvvYyWys1ts9kOWNsi8o45IermMVrd9sX/4nLvbfzlaPNNvDYpRsvaSP4R6my0+Se7n
         /TaYIvOrwKoHGnvTX6yqloZ7M0AX2g8rA7tOCOwaLOaEQRhuIkW9DFWlMg+0OYxuj3wQ
         CoMGg99qhxyyHAwx1NBW2Zi3v6DhshDWAfXAjSgelwSuHyA6rBoVRrXp+P7nvhDddZ0X
         5QtQ==
X-Gm-Message-State: APjAAAWQdkyKyEPBVYDeUr1Lp0T4VVIT7Hj+zfpWTlo0jHfawtgZZ5Ya
        hXu45VmpOTVntU+3GecxfG46mEbn
X-Google-Smtp-Source: APXvYqxa9/GyMnvXWzcGDbgTfDAzBHueNRsc4rveX4bBtk9V4OLrFalV/TShl28uOX1oKCXK1CcoFA==
X-Received: by 2002:a2e:9010:: with SMTP id h16mr44705760ljg.49.1560639868949;
        Sat, 15 Jun 2019 16:04:28 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id u13sm1034442lfl.61.2019.06.15.16.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 16:04:28 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: cp210x: Add cp2108 GPIOs support
Date:   Sun, 16 Jun 2019 02:02:15 +0300
Message-Id: <20190615230214.30061-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514105358.18818-1-fancer.lancer@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each chip from the cp210x series got GPIOs on board. This commit
provides the support for sixteen ones placed on the cp2108 four-ports
serial console controller. Since all GPIOs are accessible via any
cp2108 USB interface we manually and equally distributed them between
all interfaces in accordance with GPIOs alternative functions attachment.
So the driver provides four GPIOs per each cp2108 USB interface.

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

Changelog v2:
- Rebase onto kernel 5.2.0-rc4.
- Move USB_SERIAL_CP210X config descriptor modification to a separate patch.
- Add more descriptive info of cp2108 state and config structures.
- Replace _NUM suffix with _CNT.
- Add _IDX suffix to CP2108_GPIO_PB macro.
- Add _MODE suffix to CP2108_DYNAMIC_SUSPEND macro.
- Discard __packed attribute from struct cp2108_gpio_write.
- Discard CP2108_GPIO_CNT macro and use literal 4 instead.
- Simplify cp210x_gpio_get() method by replacing the union with a u16 buffer.
- Replace ternary operations of cp210x_gpio_set() with a conditional statement.
- Add more descriptive comments regarding the gpio_altfunc bits collection.
- Fix a bug in the GPIOs setter/getter methods of invalid bit being utilized
to set/get GPIO values.
---
 drivers/usb/serial/cp210x.c | 178 +++++++++++++++++++++++++++++++++---
 1 file changed, 164 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 979bef9bfb6b..32f0a4273abb 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -505,6 +505,60 @@ struct cp210x_gpio_write {
 	u8	state;
 } __packed;
 
+/*
+ * Number of CP2108 USB interfaces, port-blocks and GPIO port-block index,
+ * where port-blocks are the internal pins containers of the chip.
+ */
+#define CP2108_IFACE_CNT		4
+#define CP2108_PB_CNT			5
+#define CP2108_GPIO_PB_IDX		1
+
+/*
+ * CP2108 default pins state. There are five port-blocks (PB). Each one is with
+ * it' specific pins-set: Port 0 - UART 0 and 1, Port 1 - GPIOs, Port 2 - chip
+ * suspend and a part of UART 2 pins, Port 3 and 4 - UART 2 and 3 pins
+ * (for details see USB Express SDK sources or SDK-based smt application
+ * accessible here https://github.com/fancer/smt-cp210x).
+ */
+struct cp2108_state {
+	__le16	mode[CP2108_PB_CNT];	/* 0 - Open-Drain, 1 - Push-Pull */
+	__le16	low_power[CP2108_PB_CNT];
+	__le16	latch[CP2108_PB_CNT];	/* 0 - Logic Low, 1 - Logic High */
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
+	u8	ip_delay[CP2108_IFACE_CNT];
+	u8	enhanced_fxn[CP2108_IFACE_CNT];
+	u8	enhanced_fxn_dev;
+	u8	ext_clock_freq[CP2108_IFACE_CNT];
+} __packed;
+
+/* CP2108 port alternate functions fields. */
+#define CP2108_GPIO_TXLED_MODE		BIT(0)
+#define CP2108_GPIO_RXLED_MODE		BIT(1)
+#define CP2108_GPIO_RS485_MODE		BIT(2)
+#define CP2108_GPIO_RS485_LOGIC		BIT(3)
+#define CP2108_GPIO_CLOCK_MODE		BIT(4)
+#define CP2108_DYNAMIC_SUSPEND_MODE	BIT(5)
+
+/*
+ * CP210X_VENDOR_SPECIFIC, CP210X_WRITE_LATCH call writes these 0x4 bytes
+ * to CP2108 controller.
+ */
+struct cp2108_gpio_write {
+	__le16	mask;
+	__le16	state;
+};
+
 /*
  * Helper to get interface number when we only have struct usb_serial.
  */
@@ -1366,10 +1420,13 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 	struct usb_serial *serial = gpiochip_get_data(gc);
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
 	u8 req_type = REQTYPE_DEVICE_TO_HOST;
+	int bufsize = 1;
 	int result;
-	u8 buf;
+	u16 buf;
 
-	if (priv->partnum == CP210X_PARTNUM_CP2105)
+	if (priv->partnum == CP210X_PARTNUM_CP2108)
+		bufsize = 2;
+	else if (priv->partnum == CP210X_PARTNUM_CP2105)
 		req_type = REQTYPE_INTERFACE_TO_HOST;
 
 	result = usb_autopm_get_interface(serial->interface);
@@ -1377,39 +1434,62 @@ static int cp210x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 		return result;
 
 	result = cp210x_read_vendor_block(serial, req_type,
-					  CP210X_READ_LATCH, &buf, sizeof(buf));
+					  CP210X_READ_LATCH, &buf, bufsize);
 	usb_autopm_put_interface(serial->interface);
 	if (result < 0)
 		return result;
 
-	return !!(buf & BIT(gpio));
+	if (priv->partnum == CP210X_PARTNUM_CP2108) {
+		u8 intf_num = cp210x_interface_num(serial);
+
+		gpio += intf_num * 4;
+	}
+
+	return !!(le16_to_cpu(buf) & BIT(gpio));
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
+		u8 intf_num = cp210x_interface_num(serial);
+		struct cp2108_gpio_write buf;
+
+		buf.mask = cpu_to_le16(BIT(intf_num * 4 + gpio));
+		if (value == 1)
+			buf.state = buf.mask;
+		else
+			buf.state = 0;
+
+		result = cp210x_write_vendor_block(serial,
+						   REQTYPE_HOST_TO_DEVICE,
+						   CP210X_WRITE_LATCH, &buf,
+						   sizeof(buf));
+	} else if (priv->partnum == CP210X_PARTNUM_CP2105) {
+		struct cp210x_gpio_write buf;
+
+		buf.mask = BIT(gpio);
+		if (value == 1)
+			buf.state = buf.mask;
+		else
+			buf.state = 0;
+
 		result = cp210x_write_vendor_block(serial,
 						   REQTYPE_HOST_TO_INTERFACE,
 						   CP210X_WRITE_LATCH, &buf,
 						   sizeof(buf));
 	} else {
-		u16 wIndex = buf.state << 8 | buf.mask;
+		u16 wIndex = BIT(gpio);
+
+		if (value == 1)
+			wIndex |= (BIT(gpio) << 8);
 
 		result = usb_control_msg(serial->dev,
 					 usb_sndctrlpipe(serial->dev, 0),
@@ -1489,6 +1569,73 @@ static int cp210x_gpio_set_config(struct gpio_chip *gc, unsigned int gpio,
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
+	 * There are four interfaces with four GPIOs manually distributed for
+	 * each of them. Here we parse the device config data to comply with
+	 * the driver interface. Note that the mode (push-pull, open-drain,
+	 * etc) can be changed only after reset, which causes the driver
+	 * reloading anyway. So we can safely read the config just once at the
+	 * device attachment procedure.
+	 */
+	intf_num = cp210x_interface_num(serial);
+	if (intf_num >= CP2108_IFACE_CNT)
+		return -ENODEV;
+	mode = le16_to_cpu(config.reset_latch.mode[CP2108_GPIO_PB_IDX]);
+	latch = le16_to_cpu(config.reset_latch.latch[CP2108_GPIO_PB_IDX]);
+
+	priv->gpio_altfunc = config.enhanced_fxn[intf_num];
+	priv->gpio_pushpull = (mode >> (intf_num * 4)) & 0x0f;
+	priv->gpio_input = (latch >> (intf_num * 4)) & 0x0f;
+	priv->gc.ngpio = 4;
+
+	/*
+	 * Each GPIO[i*4 + x] can have an alternative function enabled
+	 * (x = 0 - UART i TX toggle, x = 1 - UART i RX toggle, x = 2 - UART i
+	 * RS485 mode and x = 3  - clock output i), in which case the GPIO
+	 * functionality isn't available. If it is switched on we deny the GPIO
+	 * requests. GPIO alternative functions state resides the
+	 * enhanced_fxn[i] bitfield, where each bit linearly corresponds to
+	 * the specific GPIO, except GPIO[3] - clock output function, which
+	 * alas is placed at fourth bit, while the third bit is busy with RS485
+	 * logic mode flag. In order to make the generic cp210x GPIO request
+	 * method being suitable for cp2108, lets copy the GPIO[4] clock
+	 * alternative function state bit to the GPIO[3] RS485 logic mode bit.
+	 */
+	priv->gpio_altfunc &= ~CP2108_GPIO_RS485_LOGIC;
+	if (priv->gpio_altfunc & CP2108_GPIO_CLOCK_MODE)
+		priv->gpio_altfunc |= CP2108_GPIO_RS485_LOGIC;
+
+	/*
+	 * Open-drain mode in combination with a high latch value is used
+	 * to emulate the GPIO input pin.
+	 */
+	priv->gpio_input &= ~priv->gpio_pushpull;
+
+	return 0;
+}
+
 /*
  * This function is for configuring GPIO using shared pins, where other signals
  * are made unavailable by configuring the use of GPIO. This is believed to be
@@ -1713,6 +1860,9 @@ static int cp210x_gpio_init(struct usb_serial *serial)
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

