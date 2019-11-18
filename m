Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1063FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED39218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKRRL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:11:58 -0500
Received: from pietrobattiston.it ([92.243.7.39]:50822 "EHLO
        jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbfKRRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:11:58 -0500
Received: from amalgama (pno-math-19.ulb.ac.be [164.15.133.19])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: giovanni)
        by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id A38F4E0544;
        Mon, 18 Nov 2019 18:11:53 +0100 (CET)
Received: by amalgama (Postfix, from userid 1000)
        id 3FF0F3C0244; Mon, 18 Nov 2019 18:11:53 +0100 (CET)
From:   Giovanni Mascellani <gio@debian.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Giovanni Mascellani <gio@debian.org>
Subject: [PATCH v4 1/2] dell-smm-hwmon: Add support for disabling automatic BIOS fan control
Date:   Mon, 18 Nov 2019 18:11:47 +0100
Message-Id: <20191118171148.76373-1-gio@debian.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports standard hwmon pwmX_enable sysfs attribute for
enabling or disabling automatic fan control by BIOS. Standard value
"1" is for disabling automatic BIOS fan control and value "2" for
enabling.

By default BIOS auto mode is enabled by laptop firmware.

When BIOS auto mode is enabled, custom fan speed value (set via hwmon
pwmX sysfs attribute) is overwritten by SMM in few seconds and
therefore any custom settings are without effect. So this is reason
why implementing option for disabling BIOS auto mode is needed.

So finally this patch allows kernel to set and control fan speed on
laptops, but it can be dangerous (like setting speed of other fans).

The SMM commands to enable or disable automatic fan control are not
documented and are not the same on all Dell laptops. Therefore a
whitelist is used to send the correct codes only on laptopts for which
they are known.

This patch was originally developed by Pali Rohár; later Giovanni
Mascellani implemented the whitelist.

Signed-off-by: Giovanni Mascellani <gio@debian.org>
Co-Developer-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/hwmon/dell-smm-hwmon.c | 114 ++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 4212d022d253..25d160b36a57 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
 static uint i8k_fan_max = I8K_FAN_HIGH;
 static bool disallow_fan_type_call;
 static bool disallow_fan_support;
+static unsigned int manual_fan;
+static unsigned int auto_fan;
 
 #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
 #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
@@ -300,6 +302,20 @@ static int i8k_get_fan_nominal_speed(int fan, int speed)
 	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * i8k_fan_mult;
 }
 
+/*
+ * Enable or disable automatic BIOS fan control support
+ */
+static int i8k_enable_fan_auto_mode(bool enable)
+{
+	struct smm_regs regs = { };
+
+	if (disallow_fan_support)
+		return -EINVAL;
+
+	regs.eax = enable ? auto_fan : manual_fan;
+	return i8k_smm(&regs);
+}
+
 /*
  * Set the fan speed (off, low, high). Returns the new fan status.
  */
@@ -726,6 +742,35 @@ static ssize_t i8k_hwmon_pwm_store(struct device *dev,
 	return err < 0 ? -EIO : count;
 }
 
+static ssize_t i8k_hwmon_pwm_enable_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	int err;
+	bool enable;
+	unsigned long val;
+
+	if (!auto_fan)
+		return -ENODEV;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val == 1)
+		enable = false;
+	else if (val == 2)
+		enable = true;
+	else
+		return -EINVAL;
+
+	mutex_lock(&i8k_mutex);
+	err = i8k_enable_fan_auto_mode(enable);
+	mutex_unlock(&i8k_mutex);
+
+	return err ? err : count;
+}
+
 static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
 static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
 static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
@@ -749,6 +794,7 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label, i8k_hwmon_temp_label, 9);
 static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
 static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
+static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
 static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
 static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
 static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
@@ -780,12 +826,13 @@ static struct attribute *i8k_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,	/* 20 */
 	&sensor_dev_attr_fan1_label.dev_attr.attr,	/* 21 */
 	&sensor_dev_attr_pwm1.dev_attr.attr,		/* 22 */
-	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 23 */
-	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 24 */
-	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 25 */
-	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 26 */
-	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 27 */
-	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 28 */
+	&sensor_dev_attr_pwm1_enable.dev_attr.attr,	/* 23 */
+	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 24 */
+	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 25 */
+	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 26 */
+	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 27 */
+	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 28 */
+	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 29 */
 	NULL
 };
 
@@ -828,16 +875,19 @@ static umode_t i8k_is_visible(struct kobject *kobj, struct attribute *attr,
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP10))
 		return 0;
 
-	if (index >= 20 && index <= 22 &&
+	if (index >= 20 && index <= 23 &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
 		return 0;
-	if (index >= 23 && index <= 25 &&
+	if (index >= 24 && index <= 26 &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
 		return 0;
-	if (index >= 26 && index <= 28 &&
+	if (index >= 27 && index <= 29 &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN3))
 		return 0;
 
+	if (index == 23 && !auto_fan)
+		return 0;
+
 	return attr->mode;
 }
 
@@ -1135,12 +1185,48 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
 	{ }
 };
 
+struct i8k_fan_control_data {
+	unsigned int manual_fan;
+	unsigned int auto_fan;
+};
+
+enum i8k_fan_controls {
+	I8K_FAN_34A3_35A3,
+};
+
+static const struct i8k_fan_control_data i8k_fan_control_data[] = {
+	[I8K_FAN_34A3_35A3] = {
+		.manual_fan = 0x34a3,
+		.auto_fan = 0x35a3,
+	},
+};
+
+static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
+	{
+		.ident = "Dell Precision 5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
+	{
+		.ident = "Dell Latitude E6440",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E6440"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
+	{ }
+};
+
 /*
  * Probe for the presence of a supported laptop.
  */
 static int __init i8k_probe(void)
 {
-	const struct dmi_system_id *id;
+	const struct dmi_system_id *id, *fan_control;
 	int fan, ret;
 
 	/*
@@ -1200,6 +1286,14 @@ static int __init i8k_probe(void)
 	i8k_fan_max = fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
 	i8k_pwm_mult = DIV_ROUND_UP(255, i8k_fan_max);
 
+	fan_control = dmi_first_match(i8k_whitelist_fan_control);
+	if (fan_control && fan_control->driver_data) {
+		const struct i8k_fan_control_data *fan_control_data = fan_control->driver_data;
+		manual_fan = fan_control_data->manual_fan;
+		auto_fan = fan_control_data->auto_fan;
+		pr_info("enabling support for setting automatic/manual fan control\n");
+	}
+
 	if (!fan_mult) {
 		/*
 		 * Autodetect fan multiplier based on nominal rpm
-- 
2.24.0

