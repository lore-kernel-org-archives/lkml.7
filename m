Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A1FC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2DF20665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbfFKOFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55726 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389903AbfFKOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:03 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOV-0003vU-65; Tue, 11 Jun 2019 15:04:59 +0100
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
Subject: [PATCH v1 09/11] ti949: i2c device driver for TI DS90UB949-Q1
Date:   Tue, 11 Jun 2019 15:04:10 +0100
Message-Id: <20190611140412.32151-10-michael.drake@codethink.co.uk>
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

  TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer

It supports instantiation via device tree / ACPI table.

A list of regulators to enable for use of the device (e.g.
GPIOs for turning on power) may be provided as device tree
properties.  These are enabled on probe and PM resume.
They are disabled on remove and PM suspend.

Datasheet: http://www.ti.com/lit/ds/symlink/ds90ub949-q1.pdf

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 drivers/gpu/drm/bridge/Kconfig  |   8 +
 drivers/gpu/drm/bridge/Makefile |   1 +
 drivers/gpu/drm/bridge/ti949.c  | 511 ++++++++++++++++++++++++++++++++
 3 files changed, 520 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/ti949.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 149692dc8d48..fbc0eddda8f0 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -89,6 +89,14 @@ config DRM_TI948
 	  This is a driver for the TI DS90UB948-Q1 device.
 	  It converts video signals from FPD-Link III to OpenLDI.
 
+config DRM_TI949
+	tristate "TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer"
+	select DRM_KMS_HELPER
+	select REGMAP_I2C
+	help
+	  This is a driver for the TI DS90UB949-Q1 device.
+	  It converts video signals from HDMI to FPD-Link III.
+
 config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 3fb37bbe10e1..1788b5efe234 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
 obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
 obj-$(CONFIG_DRM_TI948) += ti948.o
+obj-$(CONFIG_DRM_TI949) += ti949.o
 obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
 obj-$(CONFIG_DRM_SII902X) += sii902x.o
 obj-$(CONFIG_DRM_SII9234) += sii9234.o
diff --git a/drivers/gpu/drm/bridge/ti949.c b/drivers/gpu/drm/bridge/ti949.c
new file mode 100644
index 000000000000..04618ca5f25e
--- /dev/null
+++ b/drivers/gpu/drm/bridge/ti949.c
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer driver
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
+#define TI949_DEVICE_ID_TRIES 10
+
+/**
+ * enum ti949_reg - TI949 registers.
+ *
+ * DS90UB949-Q1: 8.6 Register Maps: Table 10. Serial Control Bus Registers
+ *
+ * http://www.ti.com/lit/ds/snls452/snls452.pdf
+ */
+enum ti949_reg {
+	TI949_REG_I2C_DEVICE_ID                         = 0x00,
+	TI949_REG_RESET                                 = 0x01,
+	TI949_REG_GENERAL_CONFIGURATION                 = 0x03,
+	TI949_REG_MODE_SELECT                           = 0x04,
+	TI949_REG_I2C_CONTROL                           = 0x05,
+	TI949_REG_DES_ID                                = 0x06,
+	TI949_REG_SLAVE_ID                              = 0x07,
+	TI949_REG_SLAVE_ALIAS                           = 0x08,
+	TI949_REG_CRC_ERRORS_A                          = 0x0A,
+	TI949_REG_CRC_ERRORS_B                          = 0x0B,
+	TI949_REG_GENERAL_STATUS                        = 0x0C,
+	TI949_REG_GPIO0_CONFIGURATION                   = 0x0D,
+	TI949_REG_GPIO1_AND_2_CONFIGURATION             = 0x0E,
+	TI949_REG_GPIO3_CONFIGURATION                   = 0x0F,
+	TI949_REG_GPIO5_REG_AND_GPIO6_REG_CONFIGURATION = 0x10,
+	TI949_REG_GPIO7_REG_AND_GPIO8_REG_CONFIGURATION = 0x11,
+	TI949_REG_DATA_PATH_CONTROL                     = 0x12,
+	TI949_REG_GENERAL_PURPOSE_CONTROL               = 0x13,
+	TI949_REG_BIST_CONTROL                          = 0x14,
+	TI949_REG_I2C_VOLTAGE_SELECT                    = 0x15,
+	TI949_REG_BCC_WATCHDOG_CONTROL                  = 0x16,
+	TI949_REG_I2C_CONTROL2                          = 0x17,
+	TI949_REG_SCL_HIGH_TIME                         = 0x18,
+	TI949_REG_SCL_LOW_TIME                          = 0x19,
+	TI949_REG_DATA_PATH_CONTROL_2                   = 0x1A,
+	TI949_REG_BIST_BC_ERROR_COUNT                   = 0x1B,
+	TI949_REG_GPIO_PIN_STATUS_1                     = 0x1C,
+	TI949_REG_GPIO_PIN_STATUS_2                     = 0x1D,
+	TI949_REG_TRANSMITTER_PORT_SELECT               = 0x1E,
+	TI949_REG_FREQUENCY_COUNTER                     = 0x1F,
+	TI949_REG_DESERIALIZER_CAPABILITIES_1           = 0x20,
+	TI949_REG_DESERIALIZER_CAPABILITIES_2           = 0x21,
+	TI949_REG_LINK_DETECT_CONTROL                   = 0x26,
+	TI949_REG_SCLK_CTRL                             = 0x30,
+	TI949_REG_AUDIO_CTS0                            = 0x31,
+	TI949_REG_AUDIO_CTS1                            = 0x32,
+	TI949_REG_AUDIO_CTS2                            = 0x33,
+	TI949_REG_AUDIO_N0                              = 0x34,
+	TI949_REG_AUDIO_N1                              = 0x35,
+	TI949_REG_AUDIO_N2_COEFF                        = 0x36,
+	TI949_REG_CLK_CLEAN_STS                         = 0x37,
+	TI949_REG_ANA_IA_CNTL                           = 0x40,
+	TI949_REG_ANA_IA_ADDR                           = 0x41,
+	TI949_REG_ANA_IA_CTL                            = 0x42,
+	TI949_REG_APB_CTL                               = 0x48,
+	TI949_REG_APB_ADR0                              = 0x49,
+	TI949_REG_APB_ADR1                              = 0x4A,
+	TI949_REG_APB_DATA0                             = 0x4B,
+	TI949_REG_APB_DATA1                             = 0x4C,
+	TI949_REG_APB_DATA2                             = 0x4D,
+	TI949_REG_APB_DATA3                             = 0x4E,
+	TI949_REG_BRIDGE_CTL                            = 0x4F,
+	TI949_REG_BRIDGE_STS                            = 0x50,
+	TI949_REG_EDID_ID                               = 0x51,
+	TI949_REG_EDID_CFG0                             = 0x52,
+	TI949_REG_EDID_CFG1                             = 0x53,
+	TI949_REG_BRIDGE_CFG                            = 0x54,
+	TI949_REG_AUDIO_CFG                             = 0x55,
+	TI949_REG_DUAL_STS                              = 0x5A,
+	TI949_REG_DUAL_CTL1                             = 0x5B,
+	TI949_REG_DUAL_CTL2                             = 0x5C,
+	TI949_REG_FREQ_LOW                              = 0x5D,
+	TI949_REG_FREQ_HIGH                             = 0x5E,
+	TI949_REG_HDMI_FREQUENCY                        = 0x5F,
+	TI949_REG_SPI_TIMING1                           = 0x60,
+	TI949_REG_SPI_TIMING2                           = 0x61,
+	TI949_REG_SPI_CONFIG                            = 0x62,
+	TI949_REG_PATTERN_GENERATOR_CONTROL             = 0x64,
+	TI949_REG_PATTERN_GENERATOR_CONFIGURATION       = 0x65,
+	TI949_REG_PGIA                                  = 0x66,
+	TI949_REG_PGID                                  = 0x67,
+	TI949_REG_SLAVE_ID1                             = 0x70,
+	TI949_REG_SLAVE_ID2                             = 0x71,
+	TI949_REG_SLAVE_ID3                             = 0x72,
+	TI949_REG_SLAVE_ID4                             = 0x73,
+	TI949_REG_SLAVE_ID5                             = 0x74,
+	TI949_REG_SLAVE_ID6                             = 0x75,
+	TI949_REG_SLAVE_ID7                             = 0x76,
+	TI949_REG_SLAVE_ALIAS1                          = 0x77,
+	TI949_REG_SLAVE_ALIAS2                          = 0x78,
+	TI949_REG_SLAVE_ALIAS3                          = 0x79,
+	TI949_REG_SLAVE_ALIAS4                          = 0x7A,
+	TI949_REG_SLAVE_ALIAS5                          = 0x7B,
+	TI949_REG_SLAVE_ALIAS6                          = 0x7C,
+	TI949_REG_SLAVE_ALIAS7                          = 0x7D,
+	TI949_REG_ICR                                   = 0xC6,
+	TI949_REG_ISR                                   = 0xC7,
+	TI949_REG_TX_ID_0                               = 0xF0,
+	TI949_REG_TX_ID_1                               = 0xF1,
+	TI949_REG_TX_ID_2                               = 0xF2,
+	TI949_REG_TX_ID_3                               = 0xF3,
+	TI949_REG_TX_ID_4                               = 0xF4,
+	TI949_REG_TX_ID_5                               = 0xF5,
+};
+
+/**
+ * struct ti949_ctx - ti949 driver context
+ * @i2c:         Handle for the device's i2c client.
+ * @regmap:      Handle for the device's regmap.
+ * @reg_names:   Array of regulator names, or NULL.
+ * @regs:        Array of regulators, or NULL.
+ * @reg_count:   Number of entries in reg_names and regs arrays.
+ */
+struct ti949_ctx {
+	struct i2c_client *i2c;
+	struct regmap *regmap;
+	const char **reg_names;
+	struct regulator **regs;
+	size_t reg_count;
+};
+
+static bool ti949_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TI949_REG_I2C_DEVICE_ID ... TI949_REG_DESERIALIZER_CAPABILITIES_2:
+		/*fall through*/
+	case TI949_REG_LINK_DETECT_CONTROL:
+		/*fall through*/
+	case TI949_REG_SCLK_CTRL     ... TI949_REG_CLK_CLEAN_STS:
+		/*fall through*/
+	case TI949_REG_ANA_IA_CNTL   ... TI949_REG_ANA_IA_CTL:
+		/*fall through*/
+	case TI949_REG_APB_CTL       ... TI949_REG_AUDIO_CFG:
+		/*fall through*/
+	case TI949_REG_DUAL_STS      ... TI949_REG_SPI_CONFIG:
+		/*fall through*/
+	case TI949_REG_PATTERN_GENERATOR_CONTROL ... TI949_REG_PGID:
+		/*fall through*/
+	case TI949_REG_SLAVE_ID1     ... TI949_REG_SLAVE_ALIAS7:
+		/*fall through*/
+	case TI949_REG_ICR           ... TI949_REG_ISR:
+		/*fall through*/
+	case TI949_REG_TX_ID_0       ... TI949_REG_TX_ID_5:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ti949_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case TI949_REG_I2C_DEVICE_ID       ... TI949_REG_SLAVE_ALIAS:
+		/*fall through*/
+	case TI949_REG_GPIO0_CONFIGURATION ... TI949_REG_DATA_PATH_CONTROL:
+		/*fall through*/
+	case TI949_REG_BIST_CONTROL        ... TI949_REG_DATA_PATH_CONTROL_2:
+		/*fall through*/
+	case TI949_REG_TRANSMITTER_PORT_SELECT ...
+			TI949_REG_DESERIALIZER_CAPABILITIES_2:
+		/*fall through*/
+	case TI949_REG_LINK_DETECT_CONTROL:
+		/*fall through*/
+	case TI949_REG_SCLK_CTRL           ... TI949_REG_AUDIO_N2_COEFF:
+		/*fall through*/
+	case TI949_REG_ANA_IA_CNTL         ... TI949_REG_ANA_IA_CTL:
+		/*fall through*/
+	case TI949_REG_APB_CTL             ... TI949_REG_BRIDGE_CTL:
+		/*fall through*/
+	case TI949_REG_EDID_ID             ... TI949_REG_AUDIO_CFG:
+		/*fall through*/
+	case TI949_REG_DUAL_CTL1           ... TI949_REG_SPI_CONFIG:
+		/*fall through*/
+	case TI949_REG_PATTERN_GENERATOR_CONTROL ... TI949_REG_PGID:
+		/*fall through*/
+	case TI949_REG_SLAVE_ID1           ... TI949_REG_SLAVE_ALIAS7:
+		/*fall through*/
+	case TI949_REG_ICR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config ti949_regmap_config = {
+	.val_bits      = 8,
+	.reg_bits      = 8,
+	.max_register  = TI949_REG_TX_ID_5,
+	.readable_reg  = ti949_readable_reg,
+	.writeable_reg = ti949_writeable_reg,
+};
+
+static inline u8 ti949_device_address(struct ti949_ctx *ti949)
+{
+	return ti949->i2c->addr;
+}
+
+static inline u8 ti949_device_expected_id(struct ti949_ctx *ti949)
+{
+	return ti949_device_address(ti949) << 1;
+}
+
+static int ti949_device_check(struct ti949_ctx *ti949)
+{
+	unsigned int i2c_device_id;
+	int ret;
+
+	ret = regmap_read(ti949->regmap, TI949_REG_I2C_DEVICE_ID,
+			&i2c_device_id);
+	if (ret < 0) {
+		dev_err(&ti949->i2c->dev,
+				"Failed to read device id. (error %d)\n", ret);
+		return -ENODEV;
+	}
+
+	if (i2c_device_id != ti949_device_expected_id(ti949)) {
+		dev_err(&ti949->i2c->dev,
+				"Bad device ID: Got: %x, Expected: %x\n",
+				i2c_device_id, ti949_device_expected_id(ti949));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/**
+ * ti949_device_await() - Repeatedly check the ti949's device ID.
+ * @ti949: ti949 context to check.
+ *
+ * Repeatedly check the ti949's device ID to verify that the ti949 can be
+ * communicated with, and that it is the correct version.
+ *
+ * This function can also be used to wait until the ti949 is ready, after
+ * reset.
+ *
+ * Returns: 0 on success, negative on failure.
+ */
+static int ti949_device_await(struct ti949_ctx *ti949)
+{
+	int tries = 0;
+	int ret;
+
+	do {
+		ret = ti949_device_check(ti949);
+		if (ret < 0)
+			mdelay(1);
+		else
+			break;
+	} while (++tries < TI949_DEVICE_ID_TRIES);
+
+	if (tries >= TI949_DEVICE_ID_TRIES)
+		dev_err(&ti949->i2c->dev,
+				"Failed to read id after %d attempt(s)\n",
+				tries);
+
+	return ret;
+}
+
+static int ti949_power_on(struct ti949_ctx *ti949)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ti949->reg_count; i++) {
+		dev_info(&ti949->i2c->dev, "Enabling %s regulator\n",
+				ti949->reg_names[i]);
+		ret = regulator_enable(ti949->regs[i]);
+		if (ret < 0) {
+			dev_err(&ti949->i2c->dev,
+					"Could not enable regulator %s: %d\n",
+					ti949->reg_names[i], ret);
+			return ret;
+		}
+
+		msleep(100);
+	}
+
+	ret = ti949_device_await(ti949);
+	if (ret != 0)
+		return ret;
+
+	msleep(500);
+
+	return 0;
+}
+
+static int ti949_power_off(struct ti949_ctx *ti949)
+{
+	int i;
+	int ret;
+
+	for (i = ti949->reg_count; i > 0; i--) {
+		dev_info(&ti949->i2c->dev, "Disabling %s regulator\n",
+				ti949->reg_names[i - 1]);
+		ret = regulator_disable(ti949->regs[i - 1]);
+		if (ret < 0) {
+			dev_err(&ti949->i2c->dev,
+					"Could not disable regulator %s: %d\n",
+					ti949->reg_names[i - 1], ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static inline struct ti949_ctx *ti949_ctx_from_dev(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return i2c_get_clientdata(client);
+}
+
+static int ti949_pm_resume(struct device *dev)
+{
+	struct ti949_ctx *ti949 = ti949_ctx_from_dev(dev);
+	int ret;
+
+	if (ti949 == NULL)
+		return 0;
+
+	ret = ti949_power_on(ti949);
+	if (ret != 0)
+		return ret;
+
+	return 0;
+}
+
+static int ti949_pm_suspend(struct device *dev)
+{
+	struct ti949_ctx *ti949 = ti949_ctx_from_dev(dev);
+
+	if (ti949 == NULL)
+		return 0;
+
+	return ti949_power_off(ti949);
+}
+
+static int ti949_get_regulator(struct device *dev, const char *id,
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
+static int ti949_get_regulators(struct ti949_ctx *ti949)
+{
+	int i;
+	int ret;
+	size_t regulator_count;
+
+	ret = device_property_read_string_array(&ti949->i2c->dev,
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
+		dev_info(&ti949->i2c->dev,
+				"No regulators listed for device.\n");
+		return 0;
+
+	} else if (ret < 0) {
+		return ret;
+	}
+
+	regulator_count = ret;
+
+	ti949->reg_names = devm_kmalloc_array(&ti949->i2c->dev,
+			regulator_count, sizeof(*ti949->reg_names), GFP_KERNEL);
+	if (!ti949->reg_names)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(&ti949->i2c->dev, "regulators",
+			ti949->reg_names, regulator_count);
+	if (ret < 0)
+		return ret;
+
+	ti949->regs = devm_kmalloc_array(&ti949->i2c->dev,
+			regulator_count, sizeof(*ti949->regs), GFP_KERNEL);
+	if (!ti949->regs)
+		return -ENOMEM;
+
+	for (i = 0; i < regulator_count; i++) {
+		ret = ti949_get_regulator(&ti949->i2c->dev,
+				ti949->reg_names[i], &ti949->regs[i]);
+		if (ret != 0)
+			return ret;
+	}
+
+	ti949->reg_count = regulator_count;
+
+	return 0;
+}
+
+static int ti949_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct ti949_ctx *ti949;
+	int ret;
+
+	dev_info(&client->dev, "Begin probe (addr: %x)\n", client->addr);
+
+	ti949 = devm_kzalloc(&client->dev, sizeof(*ti949), GFP_KERNEL);
+	if (!ti949)
+		return -ENOMEM;
+
+	ti949->i2c = client;
+
+	ti949->regmap = devm_regmap_init_i2c(ti949->i2c, &ti949_regmap_config);
+	if (IS_ERR(ti949->regmap))
+		return PTR_ERR(ti949->regmap);
+
+	ret = ti949_get_regulators(ti949);
+	if (ret != 0)
+		return ret;
+
+	i2c_set_clientdata(client, ti949);
+
+	ret = ti949_pm_resume(&client->dev);
+	if (ret != 0)
+		return -EPROBE_DEFER;
+
+	dev_info(&ti949->i2c->dev, "End probe (addr: %x)\n", ti949->i2c->addr);
+
+	return 0;
+}
+
+static int ti949_remove(struct i2c_client *client)
+{
+	return ti949_pm_suspend(&client->dev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ti949_of_match[] = {
+	{ .compatible = "ti,ds90ub949" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ti949_of_match);
+#endif
+
+static const struct i2c_device_id ti949_i2c_id[] = {
+	{"ti949", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ti949_i2c_id);
+
+static const struct dev_pm_ops ti949_pm_ops = {
+	.resume  = ti949_pm_resume,
+	.suspend = ti949_pm_suspend,
+};
+
+static struct i2c_driver ti949_driver = {
+	.driver = {
+		.name  = "ti949",
+		.owner = THIS_MODULE,
+		.pm    = &ti949_pm_ops,
+		.of_match_table = of_match_ptr(ti949_of_match),
+	},
+	.id_table = ti949_i2c_id,
+	.probe    = ti949_probe,
+	.remove   = ti949_remove,
+};
+module_i2c_driver(ti949_driver);
+
+MODULE_AUTHOR("Michael Drake <michael.drake@codethink.co.uk");
+MODULE_DESCRIPTION("TI DS90UB949-Q1 1080p HDMI to FPD-Link III bridge serializer driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

