Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A344C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDB820665
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfFKOFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:21 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55776 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfFKOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:04 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOW-0003vU-6D; Tue, 11 Jun 2019 15:05:00 +0100
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
Subject: [PATCH v1 11/11] ti949: Add support for configuration via device properties
Date:   Tue, 11 Jun 2019 15:04:12 +0100
Message-Id: <20190611140412.32151-12-michael.drake@codethink.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611140412.32151-1-michael.drake@codethink.co.uk>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the device to be configured for the board in
device tree, or in ACPI tables.  The device node properties
can provide an array of register addresses and values to be
written to configure the device for the board.

The config is written to the device on probe and on PM resume.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Nate Case <ncase@tesla.com>
---
 drivers/gpu/drm/bridge/ti949.c | 120 +++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti949.c b/drivers/gpu/drm/bridge/ti949.c
index 04618ca5f25e..57dcecd10ace 100644
--- a/drivers/gpu/drm/bridge/ti949.c
+++ b/drivers/gpu/drm/bridge/ti949.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <linux/i2c.h>
 
 /* Number of times to try checking for device on bringup. */
@@ -127,10 +128,22 @@ enum ti949_reg {
 	TI949_REG_TX_ID_5                               = 0xF5,
 };
 
+/**
+ * struct ti949_reg_val - ti949 register value
+ * @addr:     The address of the register
+ * @value:    The initial value of the register
+ */
+struct ti949_reg_val {
+	u8 addr;
+	u8 value;
+};
+
 /**
  * struct ti949_ctx - ti949 driver context
  * @i2c:         Handle for the device's i2c client.
  * @regmap:      Handle for the device's regmap.
+ * @config:      Array of register values loaded from device properties.
+ * @config_len:  Number of entries in config.
  * @reg_names:   Array of regulator names, or NULL.
  * @regs:        Array of regulators, or NULL.
  * @reg_count:   Number of entries in reg_names and regs arrays.
@@ -138,6 +151,8 @@ enum ti949_reg {
 struct ti949_ctx {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
+	struct ti949_reg_val *config;
+	size_t config_len;
 	const char **reg_names;
 	struct regulator **regs;
 	size_t reg_count;
@@ -214,6 +229,42 @@ static const struct regmap_config ti949_regmap_config = {
 	.writeable_reg = ti949_writeable_reg,
 };
 
+static int ti949_write_sequence(
+		struct ti949_ctx *ti949,
+		const struct ti949_reg_val *sequence,
+		u32 entries)
+{
+	int i;
+
+	for (i = 0; i < entries; i++) {
+		const struct ti949_reg_val *r = sequence + i;
+		int ret = regmap_write(ti949->regmap, r->addr, r->value);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ti949_write_config_seq(struct ti949_ctx *ti949)
+{
+	int ret;
+
+	if (ti949->config == NULL) {
+		dev_info(&ti949->i2c->dev, "No config for ti949 device\n");
+		return 0;
+	}
+
+	ret = ti949_write_sequence(ti949, ti949->config, ti949->config_len);
+	if (ret < 0)
+		return ret;
+
+	dev_info(&ti949->i2c->dev, "Successfully configured ti949\n");
+
+	return ret;
+}
+
 static inline u8 ti949_device_address(struct ti949_ctx *ti949)
 {
 	return ti949->i2c->addr;
@@ -347,6 +398,12 @@ static int ti949_pm_resume(struct device *dev)
 	if (ret != 0)
 		return ret;
 
+	ret = ti949_write_config_seq(ti949);
+	if (ret != 0)
+		return ret;
+
+	/* Extend 200ms after ti949 init for display HW tolerance. */
+	msleep(200);
 	return 0;
 }
 
@@ -436,6 +493,65 @@ static int ti949_get_regulators(struct ti949_ctx *ti949)
 	return 0;
 }
 
+static int ti949_get_config(struct ti949_ctx *ti949)
+{
+	int i;
+	int ret;
+	u8 *config;
+	size_t config_len;
+
+	ret = device_property_read_u8_array(&ti949->i2c->dev,
+			"config", NULL, 0);
+	if (ret == -EINVAL ||
+	    ret == -ENODATA ||
+	    ret == 0) {
+		/* "config" property was either:
+		 *   - unset
+		 *   - valueless
+		 *   - set to empty list
+		 * Not an error; continue without config.
+		 */
+		dev_info(&ti949->i2c->dev, "No config defined for device.\n");
+		return 0;
+
+	} else if (ret < 0) {
+		return ret;
+	} else if (ret & 0x1) {
+		dev_err(&ti949->i2c->dev,
+			"Device property 'config' needs even entry count.\n");
+		return -EINVAL;
+	}
+
+	config_len = ret;
+
+	config = kmalloc_array(config_len, sizeof(*config), GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	ret = device_property_read_u8_array(&ti949->i2c->dev, "config",
+			config, config_len);
+	if (ret < 0) {
+		kfree(config);
+		return ret;
+	}
+
+	ti949->config = devm_kmalloc_array(&ti949->i2c->dev,
+			config_len / 2, sizeof(*ti949->config), GFP_KERNEL);
+	if (!ti949->config) {
+		kfree(config);
+		return -ENOMEM;
+	}
+
+	ti949->config_len = config_len / 2;
+	for (i = 0; i < config_len; i += 2) {
+		ti949->config[i / 2].addr = config[i];
+		ti949->config[i / 2].value = config[i + 1];
+	}
+	kfree(config);
+
+	return 0;
+}
+
 static int ti949_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -458,6 +574,10 @@ static int ti949_probe(struct i2c_client *client,
 	if (ret != 0)
 		return ret;
 
+	ret = ti949_get_config(ti949);
+	if (ret != 0)
+		return ret;
+
 	i2c_set_clientdata(client, ti949);
 
 	ret = ti949_pm_resume(&client->dev);
-- 
2.20.1

