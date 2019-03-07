Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76058C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB1520684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="eh3iD0fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCGMxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:53:22 -0500
Received: from mail.nic.cz ([217.31.204.67]:34476 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfCGMxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:53:19 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 8EFA7634E4;
        Thu,  7 Mar 2019 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551963195; bh=Gt/+zJChSnEI4vf37cU58LW2NybdFoX4tqxzImGhrCM=;
        h=From:To:Date;
        b=eh3iD0frNZFwN3ZuhNPzSUNVwiwwb9vU9aoofcXFusSPyHdTDh7eNXfPJBzMctydT
         DJf9umWdBa4ilLnXBDia0GlE6hBG+VWtX9CPvdCdWA9ecmkbls4+D7KOD8dQvis+cM
         Y4mHIJSOdWoo33uwinwjta45TVtRVqlyCibZzfO4=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v4 armsoc/drivers/bus+gpio 4/5] drivers: gpio: Add support for GPIOs over Moxtet bus
Date:   Thu,  7 Mar 2019 13:52:50 +0100
Message-Id: <20190307125251.724-5-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307125251.724-1-marek.behun@nic.cz>
References: <20190307125251.724-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for interpreting the input and output bits of one
device on Moxtet bus as GPIOs.
This is needed for example by the SFP cage module of Turris Mox.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                |   1 +
 drivers/gpio/Kconfig       |   9 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-moxtet.c | 179 +++++++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/gpio/gpio-moxtet.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 43de8eaa284b..6af384154ce5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1507,6 +1507,7 @@ F:	Documentation/ABI/testing/sysfs-bus-moxtet-devices
 F:	Documentation/devicetree/bindings/bus/moxtet.txt
 F:	include/linux/moxtet.h
 F:	drivers/bus/moxtet.c
+F:	drivers/gpio/gpio-moxtet.c
 
 ARM/EBSA110 MACHINE SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5a2845347ec..2c9ffa0e2287 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1400,6 +1400,15 @@ config GPIO_XRA1403
 	help
 	  GPIO driver for EXAR XRA1403 16-bit SPI-based GPIO expander.
 
+config GPIO_MOXTET
+	tristate "Turris Mox Moxtet bus GPIO expander"
+	depends on MOXTET
+	help
+	  Say yes here if you are building for the Turris Mox router.
+	  This is the driver needed for configuring the GPIOs via the Moxtet
+	  bus. For example the Mox module with SFP cage needs this driver
+	  so that phylink can use corresponding GPIOs.
+
 endmenu
 
 menu "USB GPIO expanders"
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 37628f8dbf70..3d0b28cbf62c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)      += gpio-mockup.o
+obj-$(CONFIG_GPIO_MOXTET)	+= gpio-moxtet.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
 obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
diff --git a/drivers/gpio/gpio-moxtet.c b/drivers/gpio/gpio-moxtet.c
new file mode 100644
index 000000000000..3fd729994a38
--- /dev/null
+++ b/drivers/gpio/gpio-moxtet.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Turris Mox Moxtet GPIO expander
+ *
+ *  Copyright (C) 2018 Marek Behun <marek.behun@nic.cz>
+ */
+
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/moxtet.h>
+#include <linux/module.h>
+
+#define MOXTET_GPIO_NGPIOS	12
+#define MOXTET_GPIO_INPUTS	4
+
+struct moxtet_gpio_desc {
+	u16 in_mask;
+	u16 out_mask;
+};
+
+static const struct moxtet_gpio_desc descs[] = {
+	[TURRIS_MOX_MODULE_SFP] = {
+		.in_mask = GENMASK(2, 0),
+		.out_mask = GENMASK(5, 4),
+	},
+};
+
+struct moxtet_gpio_chip {
+	struct device			*dev;
+	struct gpio_chip		gpio_chip;
+	const struct moxtet_gpio_desc	*desc;
+};
+
+static int moxtet_gpio_get_value(struct gpio_chip *gc, unsigned int offset)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+	int ret;
+
+	if (chip->desc->in_mask & BIT(offset)) {
+		ret = moxtet_device_read(chip->dev);
+	} else if (chip->desc->out_mask & BIT(offset)) {
+		ret = moxtet_device_written(chip->dev);
+		if (ret >= 0)
+			ret <<= MOXTET_GPIO_INPUTS;
+	} else {
+		return -EINVAL;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & BIT(offset));
+}
+
+static void moxtet_gpio_set_value(struct gpio_chip *gc, unsigned int offset,
+				  int val)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+	int state;
+
+	state = moxtet_device_written(chip->dev);
+	if (state < 0)
+		return;
+
+	offset -= MOXTET_GPIO_INPUTS;
+
+	if (val)
+		state |= BIT(offset);
+	else
+		state &= ~BIT(offset);
+
+	moxtet_device_write(chip->dev, state);
+}
+
+static int moxtet_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+
+	/* All lines are hard wired to be either input or output, not both. */
+	if (chip->desc->in_mask & BIT(offset))
+		return 1;
+	else if (chip->desc->out_mask & BIT(offset))
+		return 0;
+	else
+		return -EINVAL;
+}
+
+static int moxtet_gpio_direction_input(struct gpio_chip *gc,
+				       unsigned int offset)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+
+	if (chip->desc->in_mask & BIT(offset))
+		return 0;
+	else if (chip->desc->out_mask & BIT(offset))
+		return -ENOTSUPP;
+	else
+		return -EINVAL;
+}
+
+static int moxtet_gpio_direction_output(struct gpio_chip *gc,
+					unsigned int offset, int val)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+
+	if (chip->desc->out_mask & BIT(offset))
+		moxtet_gpio_set_value(gc, offset, val);
+	else if (chip->desc->in_mask & BIT(offset))
+		return -ENOTSUPP;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int moxtet_gpio_probe(struct device *dev)
+{
+	struct moxtet_gpio_chip *chip;
+	struct device_node *nc = dev->of_node;
+	int id;
+
+	id = to_moxtet_device(dev)->id;
+
+	if (id >= ARRAY_SIZE(descs)) {
+		dev_err(dev, "%pOF Moxtet device id 0x%x is not supported by gpio-moxtet driver\n",
+			nc, id);
+		return -ENOTSUPP;
+	}
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = dev;
+	chip->gpio_chip.parent = dev;
+	chip->desc = &descs[id];
+
+	dev_set_drvdata(dev, chip);
+
+	chip->gpio_chip.label = dev_name(dev);
+	chip->gpio_chip.get_direction = moxtet_gpio_get_direction;
+	chip->gpio_chip.direction_input = moxtet_gpio_direction_input;
+	chip->gpio_chip.direction_output = moxtet_gpio_direction_output;
+	chip->gpio_chip.get = moxtet_gpio_get_value;
+	chip->gpio_chip.set = moxtet_gpio_set_value;
+	chip->gpio_chip.base = -1;
+
+	chip->gpio_chip.ngpio = MOXTET_GPIO_NGPIOS;
+
+	chip->gpio_chip.can_sleep = true;
+	chip->gpio_chip.owner = THIS_MODULE;
+
+	return devm_gpiochip_add_data(dev, &chip->gpio_chip, chip);
+}
+
+static const struct of_device_id moxtet_gpio_dt_ids[] = {
+	{ .compatible = "cznic,moxtet-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, moxtet_gpio_dt_ids);
+
+static const enum turris_mox_module_id moxtet_gpio_module_table[] = {
+	TURRIS_MOX_MODULE_SFP,
+	0,
+};
+
+static struct moxtet_driver moxtet_gpio_driver = {
+	.driver = {
+		.name		= "moxtet-gpio",
+		.of_match_table	= moxtet_gpio_dt_ids,
+		.probe		= moxtet_gpio_probe,
+	},
+	.id_table = moxtet_gpio_module_table,
+};
+module_moxtet_driver(moxtet_gpio_driver);
+
+MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_DESCRIPTION("Turris Mox Moxtet GPIO expander");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

