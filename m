Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D7AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C873E20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbfFKOFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:11 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55714 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389868AbfFKOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:03 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOR-0003vU-Iu; Tue, 11 Jun 2019 15:04:55 +0100
From:   Michael Drake <michael.drake@codethink.co.uk>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Drake <michael.drake@codethink.co.uk>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: [PATCH v1 02/11] ti948: i2c device driver for TI DS90UB948-Q1
Date:   Tue, 11 Jun 2019 15:04:03 +0100
Message-Id: <20190611140412.32151-3-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611140412.32151-1-michael.drake@codethink.co.uk>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regmap i2c device driver for:

  TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer

It supports instantiation via device tree / ACPI table.

A list of regulators to enable for use of the device (e.g.
GPIOs for turning on power) may be provided as device tree
properties.  These are enabled on probe and PM resume.
They are disabled on remove and PM suspend.

Datasheet: http://www.ti.com/lit/ds/symlink/ds90ub948-q1.pdf

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 drivers/gpu/drm/bridge/Kconfig  |   8 +
 drivers/gpu/drm/bridge/Makefile |   1 +
 drivers/gpu/drm/bridge/ti948.c  | 509 ++++++++++++++++++++++++++++++++
 3 files changed, 518 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/ti948.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index ee777469293a..149692dc8d48 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -81,6 +81,14 @@ config DRM_PARADE_PS8622
 	---help---
 	  Parade eDP-LVDS bridge chip driver.
 
+config DRM_TI948
+	tristate "TI DS90UB948-Q1 FPD-Link III to OpenLDI Deserializer"
+	select DRM_KMS_HELPER
+	select REGMAP_I2C
+	help
+	  This is a driver for the TI DS90UB948-Q1 device.
+	  It converts video signals from FPD-Link III to OpenLDI.
+
 config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 4934fcf5a6f8..3fb37bbe10e1 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
 obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
+obj-$(CONFIG_DRM_TI948) += ti948.o
 obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
 obj-$(CONFIG_DRM_SII902X) += sii902x.o
 obj-$(CONFIG_DRM_SII9234) += sii9234.o
diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
new file mode 100644
index 000000000000..c22252036bbe
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti948.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer driver
+ *
+ * Copyright (C) 2019 Tesla Motors, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+
+/* Number of times to try checking for device on bringup. */
+#define TI948_DEVICE_ID_TRIES 10
+
+/**
+ * enum ti948_reg - TI948 registers.
+ *
+ * DS90UB948-Q1: 7.7: Table 11 DS90UB948-Q1 Registers
+ *
+ * http://www.ti.com/lit/ds/symlink/ds90ub948-q1.pdf
+ */
+enum ti948_reg {
+	TI948_REG_I2C_DEVICE_ID                 = 0x00,
+	TI948_REG_RESET                         = 0x01,
+	TI948_REG_GENERAL_CONFIGURATION_0       = 0x02,
+	TI948_REG_GENERAL_CONFIGURATION_1       = 0x03,
+	TI948_REG_BCC_WATCHDOG_CONTROL          = 0x04,
+	TI948_REG_I2C_CONTROL_1                 = 0x05,
+	TI948_REG_I2C_CONTROL_2                 = 0x06,
+	TI948_REG_REMOTE_ID                     = 0x07,
+	TI948_REG_SLAVEID_0                     = 0x08,
+	TI948_REG_SLAVEID_1                     = 0x09,
+	TI948_REG_SLAVEID_2                     = 0x0A,
+	TI948_REG_SLAVEID_3                     = 0x0B,
+	TI948_REG_SLAVEID_4                     = 0x0C,
+	TI948_REG_SLAVEID_5                     = 0x0D,
+	TI948_REG_SLAVEID_6                     = 0x0E,
+	TI948_REG_SLAVEID_7                     = 0x0F,
+	TI948_REG_SLAVEALIAS_0                  = 0x10,
+	TI948_REG_SLAVEALIAS_1                  = 0x11,
+	TI948_REG_SLAVEALIAS_2                  = 0x12,
+	TI948_REG_SLAVEALIAS_3                  = 0x13,
+	TI948_REG_SLAVEALIAS_4                  = 0x14,
+	TI948_REG_SLAVEALIAS_5                  = 0x15,
+	TI948_REG_SLAVEALIAS_6                  = 0x16,
+	TI948_REG_SLAVEALIAS_7                  = 0x17,
+	TI948_REG_MAILBOX_18                    = 0x18,
+	TI948_REG_MAILBOX_19                    = 0x19,
+	TI948_REG_GPIO_9_AND_GLOBAL_GPIO_CONFIG = 0x1A,
+	TI948_REG_FREQUENCY_COUNTER             = 0x1B,
+	TI948_REG_GENERAL_STATUS                = 0x1C,
+	TI948_REG_GPIO0_CONFIG                  = 0x1D,
+	TI948_REG_GPIO1_2_CONFIG                = 0x1E,
+	TI948_REG_GPIO3_CONFIG                  = 0x1F,
+	TI948_REG_GPIO5_6_CONFIG                = 0x20,
+	TI948_REG_GPIO7_8_CONFIG                = 0x21,
+	TI948_REG_DATAPATH_CONTROL              = 0x22,
+	TI948_REG_RX_MODE_STATUS                = 0x23,
+	TI948_REG_BIST_CONTROL                  = 0x24,
+	TI948_REG_BIST_ERROR_COUNT              = 0x25,
+	TI948_REG_SCL_HIGH_TIME                 = 0x26,
+	TI948_REG_SCL_LOW_TIME                  = 0x27,
+	TI948_REG_DATAPATH_CONTROL_2            = 0x28,
+	TI948_REG_FRC_CONTROL                   = 0x29,
+	TI948_REG_WHITE_BALANCE_CONTROL         = 0x2A,
+	TI948_REG_I2S_CONTROL                   = 0x2B,
+	TI948_REG_PCLK_TEST_MODE                = 0x2E,
+	TI948_REG_DUAL_RX_CTL                   = 0x34,
+	TI948_REG_AEQ_TEST                      = 0x35,
+	TI948_REG_MODE_SEL                      = 0x37,
+	TI948_REG_I2S_DIVSEL                    = 0x3A,
+	TI948_REG_EQ_STATUS                     = 0x3B,
+	TI948_REG_LINK_ERROR_COUNT              = 0x41,
+	TI948_REG_HSCC_CONTROL                  = 0x43,
+	TI948_REG_ADAPTIVE_EQ_BYPASS            = 0x44,
+	TI948_REG_ADAPTIVE_EQ_MIN_MAX           = 0x45,
+	TI948_REG_FPD_TX_MODE                   = 0x49,
+	TI948_REG_LVDS_CONTROL                  = 0x4B,
+	TI948_REG_CML_OUTPUT_CTL1               = 0x52,
+	TI948_REG_CML_OUTPUT_ENABLE             = 0x56,
+	TI948_REG_CML_OUTPUT_CTL2               = 0x57,
+	TI948_REG_CML_OUTPUT_CTL3               = 0x63,
+	TI948_REG_PGCTL                         = 0x64,
+	TI948_REG_PGCFG                         = 0x65,
+	TI948_REG_PGIA                          = 0x66,
+	TI948_REG_PGID                          = 0x67,
+	TI948_REG_PGDBG                         = 0x68,
+	TI948_REG_PGTSTDAT                      = 0x69,
+	TI948_REG_GPI_PIN_STATUS_1              = 0x6E,
+	TI948_REG_GPI_PIN_STATUS_2              = 0x6F,
+	TI948_REG_RX_ID0                        = 0xF0,
+	TI948_REG_RX_ID1                        = 0xF1,
+	TI948_REG_RX_ID2                        = 0xF2,
+	TI948_REG_RX_ID3                        = 0xF3,
+	TI948_REG_RX_ID4                        = 0xF4,
+	TI948_REG_RX_ID5                        = 0xF5
+};
+
+/**
+ * struct ti948_reg_val - ti948 register value
+ * @addr:     The address of the register
+ * @value:    The initial value of the register
+ */
+struct ti948_reg_val {
+	u8 addr;
+	u8 value;
+};
+
+/**
+ * struct ti948_ctx - ti948 driver context
+ * @i2c:         Handle for the device's i2c client.
+ * @regmap:      Handle for the device's regmap.
+ * @reg_names:   Array of regulator names, or NULL.
+ * @regs:        Array of regulators, or NULL.
+ * @reg_count:   Number of entries in reg_names and regs arrays.
+ */
+struct ti948_ctx {
+	struct i2c_client *i2c;
+	struct regmap *regmap;
+	const char **reg_names;
+	struct regulator **regs;
+	size_t reg_count;
+};
+
+static bool ti948_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TI948_REG_I2C_DEVICE_ID     ... TI948_REG_I2S_CONTROL:
+		/*fall through*/
+	case TI948_REG_PCLK_TEST_MODE:
+		/*fall through*/
+	case TI948_REG_DUAL_RX_CTL       ... TI948_REG_AEQ_TEST:
+		/*fall through*/
+	case TI948_REG_MODE_SEL:
+		/*fall through*/
+	case TI948_REG_I2S_DIVSEL        ... TI948_REG_EQ_STATUS:
+		/*fall through*/
+	case TI948_REG_LINK_ERROR_COUNT:
+		/*fall through*/
+	case TI948_REG_HSCC_CONTROL      ... TI948_REG_ADAPTIVE_EQ_MIN_MAX:
+		/*fall through*/
+	case TI948_REG_FPD_TX_MODE:
+		/*fall through*/
+	case TI948_REG_LVDS_CONTROL:
+		/*fall through*/
+	case TI948_REG_CML_OUTPUT_CTL1:
+		/*fall through*/
+	case TI948_REG_CML_OUTPUT_ENABLE ... TI948_REG_CML_OUTPUT_CTL2:
+		/*fall through*/
+	case TI948_REG_CML_OUTPUT_CTL3   ... TI948_REG_PGTSTDAT:
+		/*fall through*/
+	case TI948_REG_GPI_PIN_STATUS_1  ... TI948_REG_GPI_PIN_STATUS_2:
+		/*fall through*/
+	case TI948_REG_RX_ID0            ... TI948_REG_RX_ID5:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ti948_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TI948_REG_I2C_DEVICE_ID     ... TI948_REG_FREQUENCY_COUNTER:
+		/*fall through*/
+	case TI948_REG_GPIO0_CONFIG      ... TI948_REG_BIST_CONTROL:
+		/*fall through*/
+	case TI948_REG_SCL_HIGH_TIME     ... TI948_REG_I2S_CONTROL:
+		/*fall through*/
+	case TI948_REG_PCLK_TEST_MODE:
+		/*fall through*/
+	case TI948_REG_DUAL_RX_CTL       ... TI948_REG_AEQ_TEST:
+		/*fall through*/
+	case TI948_REG_I2S_DIVSEL:
+		/*fall through*/
+	case TI948_REG_LINK_ERROR_COUNT:
+		/*fall through*/
+	case TI948_REG_HSCC_CONTROL      ... TI948_REG_ADAPTIVE_EQ_MIN_MAX:
+		/*fall through*/
+	case TI948_REG_FPD_TX_MODE:
+		/*fall through*/
+	case TI948_REG_LVDS_CONTROL:
+		/*fall through*/
+	case TI948_REG_CML_OUTPUT_CTL1:
+		/*fall through*/
+	case TI948_REG_CML_OUTPUT_ENABLE ... TI948_REG_CML_OUTPUT_CTL2:
+		/*fall through*/
+	case TI948_REG_CML_OUTPUT_CTL3   ... TI948_REG_PGDBG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config ti948_regmap_config = {
+	.val_bits      = 8,
+	.reg_bits      = 8,
+	.max_register  = TI948_REG_RX_ID5,
+	.readable_reg  = ti948_readable_reg,
+	.writeable_reg = ti948_writeable_reg,
+};
+
+static inline u8 ti948_device_address(struct ti948_ctx *ti948)
+{
+	return ti948->i2c->addr;
+}
+
+static inline u8 ti948_device_expected_id(struct ti948_ctx *ti948)
+{
+	return ti948_device_address(ti948) << 1;
+}
+
+static int ti948_device_check(struct ti948_ctx *ti948)
+{
+	unsigned int i2c_device_id;
+	int ret;
+
+	ret = regmap_read(ti948->regmap, TI948_REG_I2C_DEVICE_ID,
+			&i2c_device_id);
+	if (ret < 0) {
+		dev_err(&ti948->i2c->dev,
+				"Failed to read device id. (error %d)\n", ret);
+		return -ENODEV;
+	}
+
+	if (i2c_device_id != ti948_device_expected_id(ti948)) {
+		dev_err(&ti948->i2c->dev,
+				"Bad device ID: Got: %x, Expected: %x\n",
+				i2c_device_id, ti948_device_expected_id(ti948));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/**
+ * ti948_device_await() - Repeatedly check the ti948's device ID.
+ * @ti948: ti948 context to check.
+ *
+ * Repeatedly check the ti948's device ID to verify that the ti948 can be
+ * communicated with, and that it is the correct version.
+ *
+ * This function can also be used to wait until the ti948 is ready, after
+ * reset.
+ *
+ * Returns: 0 on success, negative on failure.
+ */
+static int ti948_device_await(struct ti948_ctx *ti948)
+{
+	int tries = 0;
+	int ret;
+
+	do {
+		ret = ti948_device_check(ti948);
+		if (ret < 0)
+			mdelay(1);
+		else
+			break;
+	} while (++tries < TI948_DEVICE_ID_TRIES);
+
+	if (tries >= TI948_DEVICE_ID_TRIES)
+		dev_err(&ti948->i2c->dev,
+				"Failed to read id after %d attempt(s)\n",
+				tries);
+
+	return ret;
+}
+
+static int ti948_power_on(struct ti948_ctx *ti948)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ti948->reg_count; i++) {
+		dev_info(&ti948->i2c->dev, "Enabling %s regulator\n",
+				ti948->reg_names[i]);
+		ret = regulator_enable(ti948->regs[i]);
+		if (ret < 0) {
+			dev_err(&ti948->i2c->dev,
+					"Could not enable regulator %s: %d\n",
+					ti948->reg_names[i], ret);
+			return ret;
+		}
+
+		msleep(100);
+	}
+
+	ret = ti948_device_await(ti948);
+	if (ret != 0)
+		return ret;
+
+	msleep(500);
+
+	return 0;
+}
+
+static int ti948_power_off(struct ti948_ctx *ti948)
+{
+	int i;
+	int ret;
+
+	for (i = ti948->reg_count; i > 0; i--) {
+		dev_info(&ti948->i2c->dev, "Disabling %s regulator\n",
+				ti948->reg_names[i - 1]);
+		ret = regulator_disable(ti948->regs[i - 1]);
+		if (ret < 0) {
+			dev_err(&ti948->i2c->dev,
+					"Could not disable regulator %s: %d\n",
+					ti948->reg_names[i - 1], ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static inline struct ti948_ctx *ti948_ctx_from_dev(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return i2c_get_clientdata(client);
+}
+
+static int ti948_pm_resume(struct device *dev)
+{
+	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
+	int ret;
+
+	if (ti948 == NULL)
+		return 0;
+
+	ret = ti948_power_on(ti948);
+	if (ret != 0)
+		return ret;
+
+	return 0;
+}
+
+static int ti948_pm_suspend(struct device *dev)
+{
+	struct ti948_ctx *ti948 = ti948_ctx_from_dev(dev);
+
+	if (ti948 == NULL)
+		return 0;
+
+	return ti948_power_off(ti948);
+}
+
+static int ti948_get_regulator(struct device *dev, const char *id,
+		struct regulator **reg_out)
+{
+	struct regulator *reg;
+
+	reg = devm_regulator_get(dev, id);
+	if (IS_ERR(reg)) {
+		int ret = PTR_ERR(reg);
+
+		dev_err(dev, "Error requesting %s regulator: %d\n", id, ret);
+		return ret;
+	}
+
+	if (reg == NULL)
+		dev_warn(dev, "Could not get %s regulator\n", id);
+	else
+		dev_info(dev, "Got regulator %s\n", id);
+
+	*reg_out = reg;
+	return 0;
+}
+
+static int ti948_get_regulators(struct ti948_ctx *ti948)
+{
+	int i;
+	int ret;
+	size_t regulator_count;
+
+	ret = device_property_read_string_array(&ti948->i2c->dev,
+			"regulators", NULL, 0);
+	if (ret == -EINVAL ||
+	    ret == -ENODATA ||
+	    ret == 0) {
+		/* "regulators" property was either:
+		 *   - unset
+		 *   - valueless
+		 *   - set to empty list
+		 * Not an error; continue without regulators.
+		 */
+		dev_info(&ti948->i2c->dev,
+				"No regulators listed for device.\n");
+		return 0;
+
+	} else if (ret < 0) {
+		return ret;
+	}
+
+	regulator_count = ret;
+
+	ti948->reg_names = devm_kmalloc_array(&ti948->i2c->dev,
+			regulator_count, sizeof(*ti948->reg_names), GFP_KERNEL);
+	if (!ti948->reg_names)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(&ti948->i2c->dev, "regulators",
+			ti948->reg_names, regulator_count);
+	if (ret < 0)
+		return ret;
+
+	ti948->regs = devm_kmalloc_array(&ti948->i2c->dev,
+			regulator_count, sizeof(*ti948->regs), GFP_KERNEL);
+	if (!ti948->regs)
+		return -ENOMEM;
+
+	for (i = 0; i < regulator_count; i++) {
+		ret = ti948_get_regulator(&ti948->i2c->dev,
+				ti948->reg_names[i], &ti948->regs[i]);
+		if (ret != 0)
+			return ret;
+	}
+
+	ti948->reg_count = regulator_count;
+
+	return 0;
+}
+
+static int ti948_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct ti948_ctx *ti948;
+	int ret;
+
+	dev_info(&client->dev, "Begin probe (addr: %x)\n", client->addr);
+
+	ti948 = devm_kzalloc(&client->dev, sizeof(*ti948), GFP_KERNEL);
+	if (!ti948)
+		return -ENOMEM;
+
+	ti948->i2c = client;
+
+	ti948->regmap = devm_regmap_init_i2c(ti948->i2c, &ti948_regmap_config);
+	if (IS_ERR(ti948->regmap))
+		return PTR_ERR(ti948->regmap);
+
+	ret = ti948_get_regulators(ti948);
+	if (ret != 0)
+		return ret;
+
+	i2c_set_clientdata(client, ti948);
+
+	ret = ti948_pm_resume(&client->dev);
+	if (ret != 0)
+		return -EPROBE_DEFER;
+
+	dev_info(&ti948->i2c->dev, "End probe (addr: %x)\n", ti948->i2c->addr);
+
+	return 0;
+}
+
+static int ti948_remove(struct i2c_client *client)
+{
+	return ti948_pm_suspend(&client->dev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ti948_of_match[] = {
+	{ .compatible = "ti,ds90ub948" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ti948_of_match);
+#endif
+
+static const struct i2c_device_id ti948_i2c_id[] = {
+	{"ti948", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ti948_i2c_id);
+
+static const struct dev_pm_ops ti948_pm_ops = {
+	.resume  = ti948_pm_resume,
+	.suspend = ti948_pm_suspend,
+};
+
+static struct i2c_driver ti948_driver = {
+	.driver = {
+		.name  = "ti948",
+		.owner = THIS_MODULE,
+		.pm    = &ti948_pm_ops,
+		.of_match_table = of_match_ptr(ti948_of_match),
+	},
+	.id_table = ti948_i2c_id,
+	.probe    = ti948_probe,
+	.remove   = ti948_remove,
+};
+module_i2c_driver(ti948_driver);
+
+MODULE_AUTHOR("Michael Drake <michael.drake@codethink.co.uk");
+MODULE_DESCRIPTION("TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

