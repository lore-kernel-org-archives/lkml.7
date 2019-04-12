Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C99C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB662171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="RVQqGRic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDLPGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:06:52 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:54076 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfDLPGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:06:51 -0400
Received: from localhost.localdomain (91-115-28-155.adsl.highway.telekom.at [91.115.28.155])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7B50BC1D25;
        Fri, 12 Apr 2019 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1555081607; bh=mb/Pa72wyJ0PcrhnP2ZlEnW8lyfwGgDv5HFS5ca8JQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RVQqGRicT1sVDaI8EpudODyyA2UapDTmlolcqSo3Z+Ci4G/7EoBKC4100oTsf5C7N
         2s5d2z90i2OI5r293Zn6HA/l40Np5l4sDvFdwRL2f33HJMIIr/MGjqsX4odcg/5Lou
         ace15y76GPhQFAm66inAECePBNYsmNPgaLci4VuQ=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v3 2/3] Input: add a driver for GPIO controllable vibrators
Date:   Fri, 12 Apr 2019 17:06:24 +0200
Message-Id: <20190412150625.28384-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412150625.28384-1-luca@z3ntu.xyz>
References: <20190412150625.28384-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple driver for GPIO controllable vibrators.
It will be used by the Fairphone 2.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/Kconfig      |  12 ++
 drivers/input/misc/Makefile     |   1 +
 drivers/input/misc/gpio-vibra.c | 209 ++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/input/misc/gpio-vibra.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index e15ed1bb8558..6dfe9e2fe5b1 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -290,6 +290,18 @@ config INPUT_GPIO_DECODER
 	 To compile this driver as a module, choose M here: the module
 	 will be called gpio_decoder.
 
+config INPUT_GPIO_VIBRA
+	tristate "GPIO vibrator support"
+	depends on GPIOLIB || COMPILE_TEST
+	select INPUT_FF_MEMLESS
+	help
+	  Say Y here to get support for GPIO based vibrator devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gpio-vibra.
+
 config INPUT_IXP4XX_BEEPER
 	tristate "IXP4XX Beeper support"
 	depends on ARCH_IXP4XX
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index b936c5b1d4ac..f38ebbdb05e2 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_INPUT_DRV2667_HAPTICS)	+= drv2667.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
 obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
+obj-$(CONFIG_INPUT_GPIO_VIBRA)		+= gpio-vibra.o
 obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vibra.c
new file mode 100644
index 000000000000..3fd2dfd4f670
--- /dev/null
+++ b/drivers/input/misc/gpio-vibra.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  GPIO vibrator driver
+ *
+ *  Copyright (C) 2019 Luca Weiss <luca@z3ntu.xyz>
+ *
+ *  Based on PWM vibrator driver:
+ *  Copyright (C) 2017 Collabora Ltd.
+ *
+ *  Based on previous work from:
+ *  Copyright (C) 2012 Dmitry Torokhov <dmitry.torokhov@gmail.com>
+ *
+ *  Based on PWM beeper driver:
+ *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+struct gpio_vibrator {
+	struct input_dev *input;
+	struct gpio_desc *gpio;
+	struct regulator *vcc;
+
+	struct work_struct play_work;
+	bool running;
+	bool vcc_on;
+};
+
+static int gpio_vibrator_start(struct gpio_vibrator *vibrator)
+{
+	struct device *pdev = vibrator->input->dev.parent;
+	int err;
+
+	if (!vibrator->vcc_on) {
+		err = regulator_enable(vibrator->vcc);
+		if (err) {
+			dev_err(pdev, "failed to enable regulator: %d", err);
+			return err;
+		}
+		vibrator->vcc_on = true;
+	}
+
+	gpiod_set_value_cansleep(vibrator->gpio, 1);
+
+	return 0;
+}
+
+static void gpio_vibrator_stop(struct gpio_vibrator *vibrator)
+{
+	gpiod_set_value_cansleep(vibrator->gpio, 0);
+
+	if (vibrator->vcc_on) {
+		regulator_disable(vibrator->vcc);
+		vibrator->vcc_on = false;
+	}
+}
+
+static void gpio_vibrator_play_work(struct work_struct *work)
+{
+	struct gpio_vibrator *vibrator =
+		container_of(work, struct gpio_vibrator, play_work);
+
+	if (vibrator->running)
+		gpio_vibrator_start(vibrator);
+	else
+		gpio_vibrator_stop(vibrator);
+}
+
+static int gpio_vibrator_play_effect(struct input_dev *dev, void *data,
+				     struct ff_effect *effect)
+{
+	struct gpio_vibrator *vibrator = input_get_drvdata(dev);
+
+	int level = effect->u.rumble.strong_magnitude;
+
+	if (!level)
+		level = effect->u.rumble.weak_magnitude;
+
+	if (level)
+		vibrator->running = true;
+	else
+		vibrator->running = false;
+
+	schedule_work(&vibrator->play_work);
+
+	return 0;
+}
+
+static void gpio_vibrator_close(struct input_dev *input)
+{
+	struct gpio_vibrator *vibrator = input_get_drvdata(input);
+
+	cancel_work_sync(&vibrator->play_work);
+	gpio_vibrator_stop(vibrator);
+	vibrator->running = false;
+}
+
+static int gpio_vibrator_probe(struct platform_device *pdev)
+{
+	struct gpio_vibrator *vibrator;
+	int err;
+
+	vibrator = devm_kzalloc(&pdev->dev, sizeof(*vibrator), GFP_KERNEL);
+	if (!vibrator)
+		return -ENOMEM;
+
+	vibrator->input = devm_input_allocate_device(&pdev->dev);
+	if (!vibrator->input)
+		return -ENOMEM;
+
+	vibrator->vcc = devm_regulator_get(&pdev->dev, "vcc");
+	err = PTR_ERR_OR_ZERO(vibrator->vcc);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to request regulator: %d",
+				err);
+		return err;
+	}
+
+	vibrator->gpio = devm_gpiod_get(&pdev->dev, "enable", GPIOD_OUT_LOW);
+	err = PTR_ERR_OR_ZERO(vibrator->gpio);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to request main gpio: %d",
+				err);
+		return err;
+	}
+
+	INIT_WORK(&vibrator->play_work, gpio_vibrator_play_work);
+
+	vibrator->input->name = "gpio-vibrator";
+	vibrator->input->id.bustype = BUS_HOST;
+	vibrator->input->close = gpio_vibrator_close;
+
+	input_set_drvdata(vibrator->input, vibrator);
+	input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
+
+	err = input_ff_create_memless(vibrator->input, NULL,
+				      gpio_vibrator_play_effect);
+	if (err) {
+		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
+		return err;
+	}
+
+	err = input_register_device(vibrator->input);
+	if (err) {
+		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, vibrator);
+
+	return 0;
+}
+
+static int __maybe_unused gpio_vibrator_suspend(struct device *dev)
+{
+	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
+
+	cancel_work_sync(&vibrator->play_work);
+	if (vibrator->running)
+		gpio_vibrator_stop(vibrator);
+
+	return 0;
+}
+
+static int __maybe_unused gpio_vibrator_resume(struct device *dev)
+{
+	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
+
+	if (vibrator->running)
+		gpio_vibrator_start(vibrator);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(gpio_vibrator_pm_ops,
+			 gpio_vibrator_suspend, gpio_vibrator_resume);
+
+#ifdef CONFIG_OF
+static const struct of_device_id gpio_vibra_dt_match_table[] = {
+	{ .compatible = "gpio-vibrator" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gpio_vibra_dt_match_table);
+#endif
+
+static struct platform_driver gpio_vibrator_driver = {
+	.probe	= gpio_vibrator_probe,
+	.driver	= {
+		.name	= "gpio-vibrator",
+		.pm	= &gpio_vibrator_pm_ops,
+		.of_match_table = of_match_ptr(gpio_vibra_dt_match_table),
+	},
+};
+module_platform_driver(gpio_vibrator_driver);
+
+MODULE_AUTHOR("Luca Weiss <luca@z3ntu.xy>");
+MODULE_DESCRIPTION("GPIO vibrator driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gpio-vibrator");
-- 
2.21.0

