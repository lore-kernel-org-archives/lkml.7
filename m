Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F8C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBE7206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391617AbfFKOFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:05:44 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55682 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbfFKOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:05:01 -0400
Received: from [167.98.27.226] (helo=happy.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hahOS-0003vU-K7; Tue, 11 Jun 2019 15:04:56 +0100
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
Subject: [PATCH v1 04/11] ti948: Add support for configuration via device properties
Date:   Tue, 11 Jun 2019 15:04:05 +0100
Message-Id: <20190611140412.32151-5-michael.drake@codethink.co.uk>
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
 drivers/gpu/drm/bridge/ti948.c | 106 ++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti948.c b/drivers/gpu/drm/bridge/ti948.c
index c22252036bbe..9cb37215f049 100644
--- a/drivers/gpu/drm/bridge/ti948.c
+++ b/drivers/gpu/drm/bridge/ti948.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <linux/i2c.h>
 
 /* Number of times to try checking for device on bringup. */
@@ -122,6 +123,8 @@ struct ti948_reg_val {
  * struct ti948_ctx - ti948 driver context
  * @i2c:         Handle for the device's i2c client.
  * @regmap:      Handle for the device's regmap.
+ * @config:      Array of register values loaded from device properties.
+ * @config_len:  Number of entries in config.
  * @reg_names:   Array of regulator names, or NULL.
  * @regs:        Array of regulators, or NULL.
  * @reg_count:   Number of entries in reg_names and regs arrays.
@@ -129,6 +132,8 @@ struct ti948_reg_val {
 struct ti948_ctx {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
+	struct ti948_reg_val *config;
+	size_t config_len;
 	const char **reg_names;
 	struct regulator **regs;
 	size_t reg_count;
@@ -212,6 +217,42 @@ static const struct regmap_config ti948_regmap_config = {
 	.writeable_reg = ti948_writeable_reg,
 };
 
+static int ti948_write_sequence(
+		struct ti948_ctx *ti948,
+		const struct ti948_reg_val *sequence,
+		u32 entries)
+{
+	int i;
+
+	for (i = 0; i < entries; i++) {
+		const struct ti948_reg_val *r = sequence + i;
+		int ret = regmap_write(ti948->regmap, r->addr, r->value);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ti948_write_config_seq(struct ti948_ctx *ti948)
+{
+	int ret;
+
+	if (ti948->config == NULL) {
+		dev_info(&ti948->i2c->dev, "No config for ti948 device\n");
+		return 0;
+	}
+
+	ret = ti948_write_sequence(ti948, ti948->config, ti948->config_len);
+	if (ret < 0)
+		return ret;
+
+	dev_info(&ti948->i2c->dev, "Successfully configured ti948\n");
+
+	return ret;
+}
+
 static inline u8 ti948_device_address(struct ti948_ctx *ti948)
 {
 	return ti948->i2c->addr;
@@ -345,7 +386,7 @@ static int ti948_pm_resume(struct device *dev)
 	if (ret != 0)
 		return ret;
 
-	return 0;
+	return ti948_write_config_seq(ti948);
 }
 
 static int ti948_pm_suspend(struct device *dev)
@@ -434,6 +475,65 @@ static int ti948_get_regulators(struct ti948_ctx *ti948)
 	return 0;
 }
 
+static int ti948_get_config(struct ti948_ctx *ti948)
+{
+	int i;
+	int ret;
+	u8 *config;
+	size_t config_len;
+
+	ret = device_property_read_u8_array(&ti948->i2c->dev,
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
+		dev_info(&ti948->i2c->dev, "No config defined for device.\n");
+		return 0;
+
+	} else if (ret < 0) {
+		return ret;
+	} else if (ret & 0x1) {
+		dev_err(&ti948->i2c->dev,
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
+	ret = device_property_read_u8_array(&ti948->i2c->dev, "config",
+			config, config_len);
+	if (ret < 0) {
+		kfree(config);
+		return ret;
+	}
+
+	ti948->config = devm_kmalloc_array(&ti948->i2c->dev,
+			config_len / 2, sizeof(*ti948->config), GFP_KERNEL);
+	if (!ti948->config) {
+		kfree(config);
+		return -ENOMEM;
+	}
+
+	ti948->config_len = config_len / 2;
+	for (i = 0; i < config_len; i += 2) {
+		ti948->config[i / 2].addr = config[i];
+		ti948->config[i / 2].value = config[i + 1];
+	}
+	kfree(config);
+
+	return 0;
+}
+
 static int ti948_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -456,6 +556,10 @@ static int ti948_probe(struct i2c_client *client,
 	if (ret != 0)
 		return ret;
 
+	ret = ti948_get_config(ti948);
+	if (ret != 0)
+		return ret;
+
 	i2c_set_clientdata(client, ti948);
 
 	ret = ti948_pm_resume(&client->dev);
-- 
2.20.1

