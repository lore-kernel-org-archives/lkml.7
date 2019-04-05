Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857BAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372DB21852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kIeSufOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfDEO3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:29:08 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35918 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:29:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35ET0Ym017756;
        Fri, 5 Apr 2019 09:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554474540;
        bh=kQ9yGq0FRE8DzLsV/xbidyqiOBbJHOlNfjsunDy7Sw8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kIeSufOO4aMHbpTEcDq3EKTdzWJNiZ//3ldSeO9MsTBPV235/AMB8BhnLOVHnhlIa
         qv6Xce8TmfxnHJCPloiMW5me3TGBKAFAvzZYSYbFVesLWYt+nQM9MtSgFz4Mzr4iH/
         ObanEpRlDyOXaZhqLAQlcKuHchhon4BBR8bPpG08=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35ET0qa038979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:29:00 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:29:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:29:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35ET0rg118463;
        Fri, 5 Apr 2019 09:29:00 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 6/6] leds: lm3697: Introduce the lm3697 driver
Date:   Fri, 5 Apr 2019 09:28:55 -0500
Message-ID: <20190405142855.3969-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190405142855.3969-1-dmurphy@ti.com>
References: <20190405142855.3969-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the lm3697 LED driver for backlighting and display.

Datasheet location:
http://www.ti.com/lit/ds/symlink/lm3697.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Made changes to get max_brightness from ti_lmu common code, fixed commit
message extra LF otherwise no additional changes - https://lore.kernel.org/patchwork/patch/1054503/

 drivers/leds/Kconfig       |   8 +-
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-lm3697.c | 395 +++++++++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 drivers/leds/leds-lm3697.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 3ae24eaf4cde..2d1576f4d5d6 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -776,9 +776,15 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
 
+config LEDS_LM3697
+	tristate "LED driver for LM3697"
+	depends on LEDS_TI_LMU_COMMON
+	help
+	  Say Y to enable the LM3697 LED driver for TI LMU devices.
+	  This supports the LED device LM3697.
+
 config LEDS_TI_LMU_COMMON
 	tristate "LED driver for TI LMU"
-	depends on REGMAP
 	help
           Say Y to enable the LED driver for TI LMU devices.
           This supports common features between the TI LM3532, LM3631, LM3632,
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 85fd449c002d..2eb0225d8dc6 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
 obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
+obj-$(CONFIG_LEDS_LM3697)		+= leds-lm3697.o
 obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= ti-lmu-led-common.o
 
 # LED SPI Drivers
diff --git a/drivers/leds/leds-lm3697.c b/drivers/leds/leds-lm3697.c
new file mode 100644
index 000000000000..101d49d2ad3f
--- /dev/null
+++ b/drivers/leds/leds-lm3697.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+// TI LM3697 LED chip family driver
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
+#include <linux/ti-lmu-led-common.h>
+
+#define LM3697_REV			0x0
+#define LM3697_RESET			0x1
+#define LM3697_OUTPUT_CONFIG		0x10
+#define LM3697_CTRL_A_RAMP		0x11
+#define LM3697_CTRL_B_RAMP		0x12
+#define LM3697_CTRL_A_B_RT_RAMP		0x13
+#define LM3697_CTRL_A_B_RAMP_CFG	0x14
+#define LM3697_CTRL_A_B_BRT_CFG		0x16
+#define LM3697_CTRL_A_FS_CURR_CFG	0x17
+#define LM3697_CTRL_B_FS_CURR_CFG	0x18
+#define LM3697_PWM_CFG			0x1c
+#define LM3697_CTRL_A_BRT_LSB		0x20
+#define LM3697_CTRL_A_BRT_MSB		0x21
+#define LM3697_CTRL_B_BRT_LSB		0x22
+#define LM3697_CTRL_B_BRT_MSB		0x23
+#define LM3697_CTRL_ENABLE		0x24
+
+#define LM3697_SW_RESET		BIT(0)
+
+#define LM3697_CTRL_A_EN	BIT(0)
+#define LM3697_CTRL_B_EN	BIT(1)
+#define LM3697_CTRL_A_B_EN	(LM3697_CTRL_A_EN | LM3697_CTRL_B_EN)
+
+#define LM3697_MAX_LED_STRINGS	3
+
+#define LM3697_CONTROL_A	0
+#define LM3697_CONTROL_B	1
+#define LM3697_MAX_CONTROL_BANKS 2
+
+/**
+ * struct lm3697_led -
+ * @hvled_strings: Array of LED strings associated with a control bank
+ * @label: LED label
+ * @led_dev: LED class device
+ * @priv: Pointer to the device struct
+ * @lmu_data: Register and setting values for common code
+ * @control_bank: Control bank the LED is associated to. 0 is control bank A
+ *		   1 is control bank B
+ */
+struct lm3697_led {
+	u32 hvled_strings[LM3697_MAX_LED_STRINGS];
+	char label[LED_MAX_NAME_SIZE];
+	struct led_classdev led_dev;
+	struct lm3697 *priv;
+	struct ti_lmu_bank lmu_data;
+	int control_bank;
+	int enabled;
+	int num_leds;
+};
+
+/**
+ * struct lm3697 -
+ * @enable_gpio: Hardware enable gpio
+ * @regulator: LED supply regulator pointer
+ * @client: Pointer to the I2C client
+ * @regmap: Devices register map
+ * @dev: Pointer to the devices device struct
+ * @lock: Lock for reading/writing the device
+ * @leds: Array of LED strings
+ */
+struct lm3697 {
+	struct gpio_desc *enable_gpio;
+	struct regulator *regulator;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+
+	int bank_cfg;
+
+	struct lm3697_led leds[];
+};
+
+static const struct reg_default lm3697_reg_defs[] = {
+	{LM3697_OUTPUT_CONFIG, 0x6},
+	{LM3697_CTRL_A_RAMP, 0x0},
+	{LM3697_CTRL_B_RAMP, 0x0},
+	{LM3697_CTRL_A_B_RT_RAMP, 0x0},
+	{LM3697_CTRL_A_B_RAMP_CFG, 0x0},
+	{LM3697_CTRL_A_B_BRT_CFG, 0x0},
+	{LM3697_CTRL_A_FS_CURR_CFG, 0x13},
+	{LM3697_CTRL_B_FS_CURR_CFG, 0x13},
+	{LM3697_PWM_CFG, 0xc},
+	{LM3697_CTRL_A_BRT_LSB, 0x0},
+	{LM3697_CTRL_A_BRT_MSB, 0x0},
+	{LM3697_CTRL_B_BRT_LSB, 0x0},
+	{LM3697_CTRL_B_BRT_MSB, 0x0},
+	{LM3697_CTRL_ENABLE, 0x0},
+};
+
+static const struct regmap_config lm3697_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = LM3697_CTRL_ENABLE,
+	.reg_defaults = lm3697_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(lm3697_reg_defs),
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int lm3697_brightness_set(struct led_classdev *led_cdev,
+				enum led_brightness brt_val)
+{
+	struct lm3697_led *led = container_of(led_cdev, struct lm3697_led,
+					      led_dev);
+	int ctrl_en_val = (1 << led->control_bank);
+	int ret;
+
+	mutex_lock(&led->priv->lock);
+
+	if (brt_val == LED_OFF) {
+		ret = regmap_update_bits(led->priv->regmap, LM3697_CTRL_ENABLE,
+					 ctrl_en_val, ~ctrl_en_val);
+		if (ret) {
+			dev_err(&led->priv->client->dev, "Cannot write ctrl register\n");
+			goto brightness_out;
+		}
+
+		led->enabled = LED_OFF;
+	} else {
+		ret = ti_lmu_common_set_brightness(&led->lmu_data, brt_val);
+		if (ret) {
+			dev_err(&led->priv->client->dev,
+				"Cannot write brightness\n");
+			goto brightness_out;
+		}
+
+		if (!led->enabled) {
+			ret = regmap_update_bits(led->priv->regmap,
+						 LM3697_CTRL_ENABLE,
+						 ctrl_en_val, ctrl_en_val);
+			if (ret) {
+				dev_err(&led->priv->client->dev,
+					"Cannot enable the device\n");
+				goto brightness_out;
+			}
+
+			led->enabled = brt_val;
+		}
+	}
+
+brightness_out:
+	mutex_unlock(&led->priv->lock);
+	return ret;
+}
+
+static int lm3697_init(struct lm3697 *priv)
+{
+	struct lm3697_led *led;
+	int i, ret;
+
+	if (priv->enable_gpio) {
+		gpiod_direction_output(priv->enable_gpio, 1);
+	} else {
+		ret = regmap_write(priv->regmap, LM3697_RESET, LM3697_SW_RESET);
+		if (ret) {
+			dev_err(&priv->client->dev, "Cannot reset the device\n");
+			goto out;
+		}
+	}
+
+	ret = regmap_write(priv->regmap, LM3697_CTRL_ENABLE, 0x0);
+	if (ret) {
+		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
+		goto out;
+	}
+
+	ret = regmap_write(priv->regmap, LM3697_OUTPUT_CONFIG, priv->bank_cfg);
+	if (ret)
+		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
+
+	for (i = 0; i < LM3697_MAX_CONTROL_BANKS; i++) {
+		led = &priv->leds[i];
+		ret = ti_lmu_common_set_ramp(&led->lmu_data);
+		if (ret)
+			dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
+	}
+out:
+	return ret;
+}
+
+static int lm3697_probe_dt(struct lm3697 *priv)
+{
+	struct fwnode_handle *child = NULL;
+	struct lm3697_led *led;
+	const char *name;
+	int control_bank;
+	size_t i = 0;
+	int ret = -EINVAL;
+	int j;
+
+	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
+						   "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->enable_gpio)) {
+		ret = PTR_ERR(priv->enable_gpio);
+		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
+			ret);
+		return ret;
+	}
+
+	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
+	if (IS_ERR(priv->regulator))
+		priv->regulator = NULL;
+
+	device_for_each_child_node(priv->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &control_bank);
+		if (ret) {
+			dev_err(&priv->client->dev, "reg property missing\n");
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		if (control_bank > LM3697_CONTROL_B) {
+			dev_err(&priv->client->dev, "reg property is invalid\n");
+			ret = -EINVAL;
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		led = &priv->leds[i];
+
+		ret = ti_lmu_common_get_brt_res(&priv->client->dev,
+						child, &led->lmu_data);
+		if (ret)
+			dev_warn(&priv->client->dev, "brightness resolution property missing\n");
+
+		led->control_bank = control_bank;
+		led->lmu_data.regmap = priv->regmap;
+		led->lmu_data.runtime_ramp_reg = LM3697_CTRL_A_RAMP +
+						 control_bank;
+		led->lmu_data.msb_brightness_reg = LM3697_CTRL_A_BRT_MSB +
+						   led->control_bank * 2;
+		led->lmu_data.lsb_brightness_reg = LM3697_CTRL_A_BRT_LSB +
+						   led->control_bank * 2;
+
+		led->num_leds = fwnode_property_read_u32_array(child,
+						       "led-sources",
+						       NULL, 0);
+
+		if (led->num_leds > LM3697_MAX_LED_STRINGS) {
+			dev_err(&priv->client->dev, "To many LED strings defined\n");
+			continue;
+		}
+
+		ret = fwnode_property_read_u32_array(child, "led-sources",
+						    led->hvled_strings,
+						    led->num_leds);
+		if (ret) {
+			dev_err(&priv->client->dev, "led-sources property missing\n");
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		for (j = 0; j < led->num_leds; j++)
+			priv->bank_cfg |=
+				(led->control_bank << led->hvled_strings[j]);
+
+		ret = ti_lmu_common_get_ramp_params(&priv->client->dev,
+						    child, &led->lmu_data);
+		if (ret)
+			dev_warn(&priv->client->dev, "runtime-ramp properties missing\n");
+
+		fwnode_property_read_string(child, "linux,default-trigger",
+					    &led->led_dev.default_trigger);
+
+		ret = fwnode_property_read_string(child, "label", &name);
+		if (ret)
+			snprintf(led->label, sizeof(led->label),
+				"%s::", priv->client->name);
+		else
+			snprintf(led->label, sizeof(led->label),
+				 "%s:%s", priv->client->name, name);
+
+		led->priv = priv;
+		led->led_dev.name = led->label;
+		led->led_dev.max_brightness = led->lmu_data.max_brightness;
+		led->led_dev.brightness_set_blocking = lm3697_brightness_set;
+
+		ret = devm_led_classdev_register(priv->dev, &led->led_dev);
+		if (ret) {
+			dev_err(&priv->client->dev, "led register err: %d\n",
+				ret);
+			fwnode_handle_put(child);
+			goto child_out;
+		}
+
+		i++;
+	}
+
+child_out:
+	return ret;
+}
+
+static int lm3697_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct lm3697 *led;
+	int count;
+	int ret;
+
+	count = device_get_child_node_count(&client->dev);
+	if (!count) {
+		dev_err(&client->dev, "LEDs are not defined in device tree!");
+		return -ENODEV;
+	}
+
+	led = devm_kzalloc(&client->dev, struct_size(led, leds, count),
+			   GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	mutex_init(&led->lock);
+	i2c_set_clientdata(client, led);
+
+	led->client = client;
+	led->dev = &client->dev;
+	led->regmap = devm_regmap_init_i2c(client, &lm3697_regmap_config);
+	if (IS_ERR(led->regmap)) {
+		ret = PTR_ERR(led->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = lm3697_probe_dt(led);
+	if (ret)
+		return ret;
+
+	return lm3697_init(led);
+}
+
+static int lm3697_remove(struct i2c_client *client)
+{
+	struct lm3697 *led = i2c_get_clientdata(client);
+	int ret;
+
+	ret = regmap_update_bits(led->regmap, LM3697_CTRL_ENABLE,
+				 LM3697_CTRL_A_B_EN, 0);
+	if (ret) {
+		dev_err(&led->client->dev, "Failed to disable the device\n");
+		return ret;
+	}
+
+	if (led->enable_gpio)
+		gpiod_direction_output(led->enable_gpio, 0);
+
+	if (led->regulator) {
+		ret = regulator_disable(led->regulator);
+		if (ret)
+			dev_err(&led->client->dev,
+				"Failed to disable regulator\n");
+	}
+
+	mutex_destroy(&led->lock);
+
+	return 0;
+}
+
+static const struct i2c_device_id lm3697_id[] = {
+	{ "lm3697", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm3697_id);
+
+static const struct of_device_id of_lm3697_leds_match[] = {
+	{ .compatible = "ti,lm3697", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_lm3697_leds_match);
+
+static struct i2c_driver lm3697_driver = {
+	.driver = {
+		.name	= "lm3697",
+		.of_match_table = of_lm3697_leds_match,
+	},
+	.probe		= lm3697_probe,
+	.remove		= lm3697_remove,
+	.id_table	= lm3697_id,
+};
+module_i2c_driver(lm3697_driver);
+
+MODULE_DESCRIPTION("Texas Instruments LM3697 LED driver");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

