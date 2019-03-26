Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9960BC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FE420866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfCZOnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:43:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:38113 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731495AbfCZOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:43:01 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 26 Mar 2019 16:42:56 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x2QEgtak017688;
        Tue, 26 Mar 2019 10:42:55 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x2QEgt1s016632;
        Tue, 26 Mar 2019 10:42:55 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/1] gpio: add driver for Mellanox BlueField GPIO controller
Date:   Tue, 26 Mar 2019 10:42:48 -0400
Message-Id: <6f15dd02091f5b97ef76c22b425ba6575ffa1b1a.1553610690.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1553610690.git.sramani@mellanox.com>
References: <cover.1553610690.git.sramani@mellanox.com>
In-Reply-To: <cover.1553610690.git.sramani@mellanox.com>
References: <cover.1553610690.git.sramani@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by Mellanox
BlueField SOCs.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
---
 drivers/gpio/Kconfig      |   7 +++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-mlxbf.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3f50526..0d9ddff 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1316,6 +1316,13 @@ config GPIO_MERRIFIELD
 	help
 	  Say Y here to support Intel Merrifield GPIO.
 
+config GPIO_MLXBF
+	tristate "Mellanox BlueField SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField SoC.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 54d5527..db8d854 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_GPIO_MENZ127)	+= gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)	+= gpio-merrifield.o
 obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
 obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
+obj-$(CONFIG_GPIO_MLXBF)	+= gpio-mlxbf.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)      += gpio-mockup.o
diff --git a/drivers/gpio/gpio-mlxbf.c b/drivers/gpio/gpio-mlxbf.c
new file mode 100644
index 0000000..d428f42
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/resource.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+/* Number of pins on BlueField */
+#define MLXBF_GPIO_NR 54
+
+/* Pad Electrical Controls. */
+#define MLXBF_GPIO_PAD_CONTROL_FIRST_WORD 0x0700
+#define MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD 0x0708
+#define MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD 0x0710
+#define MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD 0x0718
+
+#define MLXBF_GPIO_PIN_DIR_I 0x1040
+#define MLXBF_GPIO_PIN_DIR_O 0x1048
+#define MLXBF_GPIO_PIN_STATE 0x1000
+#define MLXBF_GPIO_SCRATCHPAD 0x20
+
+#ifdef CONFIG_PM
+struct mlxbf_gpio_context_save_regs {
+	u64 scratchpad;
+	u64 pad_control[MLXBF_GPIO_NR];
+	u64 pin_dir_i;
+	u64 pin_dir_o;
+};
+#endif
+
+/* Device state structure. */
+struct mlxbf_gpio_state {
+	struct gpio_chip gc;
+
+	/* Memory Address */
+	void __iomem *base;
+
+#ifdef CONFIG_PM
+	struct mlxbf_gpio_context_save_regs csave_regs;
+#endif
+};
+
+static int mlxbf_gpio_probe(struct platform_device *pdev)
+{
+	struct mlxbf_gpio_state *gs;
+	struct device *dev = &pdev->dev;
+	struct gpio_chip *gc;
+	int ret;
+
+	gs = devm_kzalloc(&pdev->dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	gs->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(gs->base))
+		return PTR_ERR(gs->base);
+
+	gc = &gs->gc;
+	ret = bgpio_init(gc, dev, 8,
+			 gs->base + MLXBF_GPIO_PIN_STATE,
+			 NULL,
+			 NULL,
+			 gs->base + MLXBF_GPIO_PIN_DIR_O,
+			 gs->base + MLXBF_GPIO_PIN_DIR_I,
+			 0);
+	if (ret)
+		return -ENODEV;
+
+	gc->owner = THIS_MODULE;
+	gc->ngpio = MLXBF_GPIO_NR;
+
+	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed adding memory mapped gpiochip\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, gs);
+	dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mlxbf_gpio_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mlxbf_gpio_state *gs = platform_get_drvdata(pdev);
+
+	gs->csave_regs.scratchpad = readq(gs->base + MLXBF_GPIO_SCRATCHPAD);
+	gs->csave_regs.pad_control[0] =
+		readq(gs->base + MLXBF_GPIO_PAD_CONTROL_FIRST_WORD);
+	gs->csave_regs.pad_control[1] =
+		readq(gs->base + MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD);
+	gs->csave_regs.pad_control[2] =
+		readq(gs->base + MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD);
+	gs->csave_regs.pad_control[3] =
+		readq(gs->base + MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD);
+	gs->csave_regs.pin_dir_i = readq(gs->base + MLXBF_GPIO_PIN_DIR_I);
+	gs->csave_regs.pin_dir_o = readq(gs->base + MLXBF_GPIO_PIN_DIR_O);
+
+	return 0;
+}
+
+static int mlxbf_gpio_resume(struct platform_device *pdev)
+{
+	struct mlxbf_gpio_state *gs = platform_get_drvdata(pdev);
+
+	writeq(gs->csave_regs.scratchpad, gs->base + MLXBF_GPIO_SCRATCHPAD);
+	writeq(gs->csave_regs.pad_control[0],
+	       gs->base + MLXBF_GPIO_PAD_CONTROL_FIRST_WORD);
+	writeq(gs->csave_regs.pad_control[1],
+	       gs->base + MLXBF_GPIO_PAD_CONTROL_1_FIRST_WORD);
+	writeq(gs->csave_regs.pad_control[2],
+	       gs->base + MLXBF_GPIO_PAD_CONTROL_2_FIRST_WORD);
+	writeq(gs->csave_regs.pad_control[3],
+	       gs->base + MLXBF_GPIO_PAD_CONTROL_3_FIRST_WORD);
+	writeq(gs->csave_regs.pin_dir_i, gs->base + MLXBF_GPIO_PIN_DIR_I);
+	writeq(gs->csave_regs.pin_dir_o, gs->base + MLXBF_GPIO_PIN_DIR_O);
+
+	return 0;
+}
+#endif
+
+static const struct acpi_device_id mlxbf_gpio_acpi_match[] = {
+	{ "MLNXBF02", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf_gpio_acpi_match);
+
+static struct platform_driver mlxbf_gpio_driver = {
+	.driver = {
+		.name = "mlxbf_gpio",
+		.acpi_match_table = ACPI_PTR(mlxbf_gpio_acpi_match),
+	},
+	.probe    = mlxbf_gpio_probe,
+#ifdef CONFIG_PM
+	.suspend  = mlxbf_gpio_suspend,
+	.resume   = mlxbf_gpio_resume,
+#endif
+};
+
+module_platform_driver(mlxbf_gpio_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField GPIO Driver");
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL");
-- 
2.1.2

