Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE08C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25D6208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgB4aGP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfFULON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:14:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46342 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFULON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:14:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so4759302lfh.13;
        Fri, 21 Jun 2019 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAFUeQgRqiq5835qRT0xA/XCdxftwvYwU8sY38f//kM=;
        b=vgB4aGP9v6YxPmwRI7vJDMblHZeoHF9AkNv0FFQtk1GQZp6gUogof8b8tIbcEOgp17
         HXr+9woPZ+S97O1N3HPF0IJBFi0fePky7xjBnpOHvayDTy2qYQTb45lRyUYVazl+Dy8+
         39weXkSnHivtkqE3zNJSu4MHws7L2KyJtib4MFEwFoBX0v2H30ViVr4u5FtIZDwGFJYM
         6Z8QqZ1XNJRHK+Ry8Hs41ANsuGZhOJu7Io6t5w4BPWstyUICR9ZHLmyQ0W1ZB6VWYahN
         ItMaxa7fUM66wSJNZpnLIS7dDBYVqt3g3ctIQ0a/+gc8jiDQy3S4OpcJ1IpO01JczUHg
         93pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAFUeQgRqiq5835qRT0xA/XCdxftwvYwU8sY38f//kM=;
        b=e80YeZvYbW/muRkXs+p7ipY1pJ4V6184ZUuUodHQhUGc1GpXSt+lDQNxlaiZSDcW0d
         YUlIbQbf5N36biRIcQcAM4GidwyH51WMjrTiS1Qi9aqIzVQlPHP3P6kDUJtFUPydJhNS
         1koDFu/x+UrFjZL99O/GXJXOdSTZhCQ5b4C8CiO8FFm9YPGIR9CNGVSzc0egfynfbv3L
         JRSPN3kIUttpsjynBn9oiGd5ECeh1Z8lBZlPL2QXb9MTDmuwz5tFQYS3Da4x2LQcOnz5
         fBvDJMkmfrL5VRXvdhZEGfrRYUxGLJGA9B/BSRlzE05UWQf2CyseKOrLKiFtWei+5dLb
         Z4UA==
X-Gm-Message-State: APjAAAVuIkcAQFHrs+BuRi3DVhGC3cmCtcaSwaYgF1SuZxfP+uFYD87Z
        8GEZg+/v3WcYaX0+LAsHM98=
X-Google-Smtp-Source: APXvYqzXJG0ShnUDZHD5PvQ8wucnO/mRZKC4oOuGKDoT7dPndCb1a6/lULKlxpIidynbmUqaiNI5Wg==
X-Received: by 2002:ac2:54ae:: with SMTP id w14mr3974325lfk.124.1561115649691;
        Fri, 21 Jun 2019 04:14:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:a5e4:32fe:c6e4:d5eb])
        by smtp.googlemail.com with ESMTPSA id l11sm391202lfc.18.2019.06.21.04.13.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 04:13:59 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 2/2] extcon: Add fsa9480 extcon driver
Date:   Fri, 21 Jun 2019 13:13:52 +0200
Message-Id: <20190621111352.22976-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190621111352.22976-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds extcon driver for Fairchild Semiconductor FSA9480
microUSB switch.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Remove license sentences
  - Remove custom sysfs entries
  - Remove manual switch code (it was used by sysfs code)
  - Switch to using regmap api
  - Select REGMAP_I2C and IRQ_DOMAIN
---
 drivers/extcon/Kconfig          |  12 +
 drivers/extcon/Makefile         |   1 +
 drivers/extcon/extcon-fsa9480.c | 395 ++++++++++++++++++++++++++++++++
 3 files changed, 408 insertions(+)
 create mode 100644 drivers/extcon/extcon-fsa9480.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 6f5af4196b8d..8aa83c6274a0 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -37,6 +37,18 @@ config EXTCON_AXP288
 	  Say Y here to enable support for USB peripheral detection
 	  and USB MUX switching by X-Power AXP288 PMIC.
 
+config EXTCON_FSA9480
+	tristate "FSA9480 EXTCON Support"
+	depends on INPUT
+	select IRQ_DOMAIN
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Fairchild Semiconductor
+	  FSA9480 microUSB switch and accessory detector chip. The FSA9480 is a USB
+	  port accessory detector and switch. The FSA9480 is fully controlled using
+	  I2C and enables USB data, stereo and mono audio, video, microphone
+	  and UART data to use a common connector port.
+
 config EXTCON_GPIO
 	tristate "GPIO extcon support"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index d3941a735df3..52096fd8a216 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -8,6 +8,7 @@ extcon-core-objs		+= extcon.o devres.o
 obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
 obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
 obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
+obj-$(CONFIG_EXTCON_FSA9480)	+= extcon-fsa9480.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
 obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
 obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
new file mode 100644
index 000000000000..845f5e366083
--- /dev/null
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * extcon-fsa9480.c - Fairchild Semiconductor FSA9480 extcon driver
+ *
+ * Copyright (c) 2014 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Loosely based on old fsa9480 misc-device driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/kobject.h>
+#include <linux/extcon-provider.h>
+#include <linux/irqdomain.h>
+#include <linux/regmap.h>
+
+/* FSA9480 I2C registers */
+#define FSA9480_REG_DEVID               0x01
+#define FSA9480_REG_CTRL                0x02
+#define FSA9480_REG_INT1                0x03
+#define FSA9480_REG_INT2                0x04
+#define FSA9480_REG_INT1_MASK           0x05
+#define FSA9480_REG_INT2_MASK           0x06
+#define FSA9480_REG_ADC                 0x07
+#define FSA9480_REG_TIMING1             0x08
+#define FSA9480_REG_TIMING2             0x09
+#define FSA9480_REG_DEV_T1              0x0a
+#define FSA9480_REG_DEV_T2              0x0b
+#define FSA9480_REG_BTN1                0x0c
+#define FSA9480_REG_BTN2                0x0d
+#define FSA9480_REG_CK                  0x0e
+#define FSA9480_REG_CK_INT1             0x0f
+#define FSA9480_REG_CK_INT2             0x10
+#define FSA9480_REG_CK_INTMASK1         0x11
+#define FSA9480_REG_CK_INTMASK2         0x12
+#define FSA9480_REG_MANSW1              0x13
+#define FSA9480_REG_MANSW2              0x14
+#define FSA9480_REG_END                 0x15
+
+/* Control */
+#define CON_SWITCH_OPEN         (1 << 4)
+#define CON_RAW_DATA            (1 << 3)
+#define CON_MANUAL_SW           (1 << 2)
+#define CON_WAIT                (1 << 1)
+#define CON_INT_MASK            (1 << 0)
+#define CON_MASK                (CON_SWITCH_OPEN | CON_RAW_DATA | \
+				 CON_MANUAL_SW | CON_WAIT)
+
+/* Device Type 1 */
+#define DEV_USB_OTG             7
+#define DEV_DEDICATED_CHG       6
+#define DEV_USB_CHG             5
+#define DEV_CAR_KIT             4
+#define DEV_UART                3
+#define DEV_USB                 2
+#define DEV_AUDIO_2             1
+#define DEV_AUDIO_1             0
+
+#define DEV_T1_USB_MASK         (DEV_USB_OTG | DEV_USB)
+#define DEV_T1_UART_MASK        (DEV_UART)
+#define DEV_T1_CHARGER_MASK     (DEV_DEDICATED_CHG | DEV_USB_CHG)
+
+/* Device Type 2 */
+#define DEV_AV                  14
+#define DEV_TTY                 13
+#define DEV_PPD                 12
+#define DEV_JIG_UART_OFF        11
+#define DEV_JIG_UART_ON         10
+#define DEV_JIG_USB_OFF         9
+#define DEV_JIG_USB_ON          8
+
+#define DEV_T2_USB_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON)
+#define DEV_T2_UART_MASK        (DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
+#define DEV_T2_JIG_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON | \
+				 DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
+
+/*
+ * Manual Switch
+ * D- [7:5] / D+ [4:2]
+ * 000: Open all / 001: USB / 010: AUDIO / 011: UART / 100: V_AUDIO
+ */
+#define SW_VAUDIO               ((4 << 5) | (4 << 2))
+#define SW_UART                 ((3 << 5) | (3 << 2))
+#define SW_AUDIO                ((2 << 5) | (2 << 2))
+#define SW_DHOST                ((1 << 5) | (1 << 2))
+#define SW_AUTO                 ((0 << 5) | (0 << 2))
+
+/* Interrupt 1 */
+#define INT1_MASK               (0xff << 0)
+#define INT_DETACH              (1 << 1)
+#define INT_ATTACH              (1 << 0)
+
+/* Interrupt 2 mask */
+#define INT2_MASK               (0x1f << 0)
+
+/* Timing Set 1 */
+#define TIMING1_ADC_500MS       (0x6 << 0)
+
+struct fsa9480_usbsw {
+	struct device *dev;
+	struct regmap *regmap;
+	struct extcon_dev *edev;
+	u16 cable;
+};
+
+static const unsigned int fsa9480_extcon_cable[] = {
+	EXTCON_USB_HOST,
+	EXTCON_USB,
+	EXTCON_CHG_USB_DCP,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_CHG_USB_ACA,
+	EXTCON_JACK_LINE_OUT,
+	EXTCON_JACK_VIDEO_OUT,
+	EXTCON_JIG,
+
+	EXTCON_NONE,
+};
+
+static const u64 cable_types[] = {
+	[DEV_USB_OTG] = BIT_ULL(EXTCON_USB_HOST),
+	[DEV_DEDICATED_CHG] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_DCP),
+	[DEV_USB_CHG] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
+	[DEV_CAR_KIT] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP)
+			| BIT_ULL(EXTCON_JACK_LINE_OUT),
+	[DEV_UART] = BIT_ULL(EXTCON_JIG),
+	[DEV_USB] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
+	[DEV_AUDIO_2] = BIT_ULL(EXTCON_JACK_LINE_OUT),
+	[DEV_AUDIO_1] = BIT_ULL(EXTCON_JACK_LINE_OUT),
+	[DEV_AV] = BIT_ULL(EXTCON_JACK_LINE_OUT)
+		   | BIT_ULL(EXTCON_JACK_VIDEO_OUT),
+	[DEV_TTY] = BIT_ULL(EXTCON_JIG),
+	[DEV_PPD] = BIT_ULL(EXTCON_JACK_LINE_OUT) | BIT_ULL(EXTCON_CHG_USB_ACA),
+	[DEV_JIG_UART_OFF] = BIT_ULL(EXTCON_JIG),
+	[DEV_JIG_UART_ON] = BIT_ULL(EXTCON_JIG),
+	[DEV_JIG_USB_OFF] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
+	[DEV_JIG_USB_ON] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
+};
+
+/* Define regmap configuration of FSA9480 for I2C communication  */
+static bool fsa9480_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FSA9480_REG_INT1_MASK:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static const struct regmap_config fsa9480_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.volatile_reg	= fsa9480_volatile_reg,
+	.max_register	= FSA9480_REG_END,
+};
+
+static int fsa9480_write_reg(struct fsa9480_usbsw *usbsw, int reg, int value)
+{
+	int ret;
+
+	ret = regmap_write(usbsw->regmap, reg, value);
+	if (ret < 0)
+		dev_err(usbsw->dev, "%s: err %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int fsa9480_read_reg(struct fsa9480_usbsw *usbsw, int reg)
+{
+	int ret, val;
+
+	ret = regmap_read(usbsw->regmap, reg, &val);
+	if (ret < 0) {
+		dev_err(usbsw->dev, "%s: err %d\n", __func__, ret);
+		return ret;
+	}
+
+	return val;
+}
+
+static int fsa9480_read_irq(struct fsa9480_usbsw *usbsw, int *value)
+{
+	u8 regs[2];
+	int ret;
+
+	ret = regmap_bulk_read(usbsw->regmap, FSA9480_REG_INT1, regs, 2);
+	if (ret < 0)
+		dev_err(usbsw->dev, "%s: err %d\n", __func__, ret);
+
+	*value = regs[1] << 8 | regs[0];
+	return ret;
+}
+
+static void fsa9480_handle_change(struct fsa9480_usbsw *usbsw,
+				  u16 mask, bool attached)
+{
+	while (mask) {
+		int dev = fls64(mask) - 1;
+		u64 cables = cable_types[dev];
+
+		while (cables) {
+			int cable = fls64(cables) - 1;
+
+			extcon_set_state_sync(usbsw->edev, cable, attached);
+			cables &= ~BIT_ULL(cable);
+		}
+
+		mask &= ~BIT_ULL(dev);
+	}
+}
+
+static void fsa9480_detect_dev(struct fsa9480_usbsw *usbsw)
+{
+	int val1, val2;
+	u16 val;
+
+	val1 = fsa9480_read_reg(usbsw, FSA9480_REG_DEV_T1);
+	val2 = fsa9480_read_reg(usbsw, FSA9480_REG_DEV_T2);
+	if (val1 < 0 || val2 < 0) {
+		dev_err(usbsw->dev, "%s: failed to read registers", __func__);
+		return;
+	}
+	val = val2 << 8 | val1;
+
+	dev_info(usbsw->dev, "dev1: 0x%x, dev2: 0x%x\n", val1, val2);
+
+	/* handle detached cables first */
+	fsa9480_handle_change(usbsw, usbsw->cable & ~val, false);
+
+	/* then handle attached ones */
+	fsa9480_handle_change(usbsw, val & ~usbsw->cable, true);
+
+	usbsw->cable = val;
+}
+
+static irqreturn_t fsa9480_irq_handler(int irq, void *data)
+{
+	struct fsa9480_usbsw *usbsw = data;
+	int intr = 0;
+
+	/* clear interrupt */
+	fsa9480_read_irq(usbsw, &intr);
+	if (!intr)
+		return IRQ_NONE;
+
+	/* device detection */
+	fsa9480_detect_dev(usbsw);
+
+	return IRQ_HANDLED;
+}
+
+static int fsa9480_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct fsa9480_usbsw *info;
+	int ret;
+
+	if (!client->irq) {
+		dev_err(&client->dev, "no interrupt provided\n");
+		return -EINVAL;
+	}
+
+	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->dev = &client->dev;
+
+	i2c_set_clientdata(client, info);
+
+	/* External connector */
+	info->edev = devm_extcon_dev_allocate(info->dev,
+					      fsa9480_extcon_cable);
+	if (IS_ERR(info->edev)) {
+		dev_err(info->dev, "failed to allocate memory for extcon\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	ret = devm_extcon_dev_register(info->dev, info->edev);
+	if (ret) {
+		dev_err(info->dev, "failed to register extcon device\n");
+		return ret;
+	}
+
+	info->regmap = devm_regmap_init_i2c(client, &fsa9480_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		ret = PTR_ERR(info->regmap);
+		dev_err(info->dev, "failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* ADC Detect Time: 500ms */
+	fsa9480_write_reg(info, FSA9480_REG_TIMING1, TIMING1_ADC_500MS);
+
+	/* configure automatic switching */
+	fsa9480_write_reg(info, FSA9480_REG_CTRL, CON_MASK);
+
+	/* unmask interrupt (attach/detach only) */
+	fsa9480_write_reg(info, FSA9480_REG_INT1_MASK,
+			  INT1_MASK & ~(INT_ATTACH | INT_DETACH));
+	fsa9480_write_reg(info, FSA9480_REG_INT2_MASK, INT2_MASK);
+
+	ret = devm_request_threaded_irq(info->dev, client->irq, NULL,
+					fsa9480_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"fsa9480", info);
+	if (ret) {
+		dev_err(info->dev, "failed to request IRQ\n");
+		return ret;
+	}
+
+	device_init_wakeup(info->dev, true);
+	fsa9480_detect_dev(info);
+
+	return 0;
+}
+
+static int fsa9480_remove(struct i2c_client *client)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int fsa9480_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev) && client->irq)
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int fsa9480_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev) && client->irq)
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops fsa9480_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsa9480_suspend, fsa9480_resume)
+};
+
+static const struct i2c_device_id fsa9480_id[] = {
+	{ "fsa9480", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, fsa9480_id);
+
+static const struct of_device_id fsa9480_of_match[] = {
+	{ .compatible = "fcs,fsa9480", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fsa9480_of_match);
+
+static struct i2c_driver fsa9480_i2c_driver = {
+	.driver			= {
+		.name		= "fsa9480",
+		.pm		= &fsa9480_pm_ops,
+		.of_match_table = fsa9480_of_match,
+	},
+	.probe			= fsa9480_probe,
+	.remove			= fsa9480_remove,
+	.id_table		= fsa9480_id,
+};
+
+static int __init fsa9480_module_init(void)
+{
+	return i2c_add_driver(&fsa9480_i2c_driver);
+}
+subsys_initcall(fsa9480_module_init);
+
+static void __exit fsa9480_module_exit(void)
+{
+	i2c_del_driver(&fsa9480_i2c_driver);
+}
+module_exit(fsa9480_module_exit);
+
+MODULE_DESCRIPTION("Fairchild Semiconductor FSA9480 extcon driver");
+MODULE_AUTHOR("Tomasz Figa <tomasz.figa@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

