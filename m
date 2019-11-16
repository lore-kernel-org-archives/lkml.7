Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89880C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647F3206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 14:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfKPOHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 09:07:03 -0500
Received: from pietrobattiston.it ([92.243.7.39]:50996 "EHLO
        jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727551AbfKPOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 09:07:02 -0500
Received: from amalgama (unknown [IPv6:2a02:578:85b0:500:2a18:9d59:67ec:cc90])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: giovanni)
        by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id 0DE43E1E98;
        Sat, 16 Nov 2019 15:06:58 +0100 (CET)
Received: by amalgama (Postfix, from userid 1000)
        id 38C513C0071; Sat, 16 Nov 2019 15:06:57 +0100 (CET)
From:   Giovanni Mascellani <gio@debian.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Giovanni Mascellani <gio@debian.org>
Subject: [PATCH v2] dell-smm-hwmon: Add support for disabling automatic BIOS fan control
Date:   Sat, 16 Nov 2019 15:06:49 +0100
Message-Id: <20191116140649.114592-1-gio@debian.org>
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
 drivers/hwmon/dell-smm-hwmon.c | 111 ++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 4212d022d253..67b8c0adede8 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
 static uint i8k_fan_max = I8K_FAN_HIGH;
 static bool disallow_fan_type_call;
 static bool disallow_fan_support;
+static unsigned int smm_manual_fan;
+static unsigned int smm_auto_fan;
 
 #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
 #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
@@ -300,6 +302,17 @@ static int i8k_get_fan_nominal_speed(int fan, int speed)
 	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * i8k_fan_mult;
 }
 
+/*
+ * Enable or disable automatic BIOS fan control support
+ */
+static int i8k_enable_fan_auto_mode(bool enable)
+{
+	struct smm_regs regs = { };
+
+	regs.eax = enable ? smm_auto_fan : smm_manual_fan;
+	return i8k_smm(&regs);
+}
+
 /*
  * Set the fan speed (off, low, high). Returns the new fan status.
  */
@@ -726,6 +739,35 @@ static ssize_t i8k_hwmon_pwm_store(struct device *dev,
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
+	if (!smm_auto_fan)
+		return -ENODEV;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val == 0)
+		return -EINVAL;
+	if (val > 2)
+		return -EINVAL;
+
+	enable = (val != 1);
+
+	mutex_lock(&i8k_mutex);
+	err = i8k_enable_fan_auto_mode(enable);
+	mutex_unlock(&i8k_mutex);
+
+	return err ? -EIO : count;
+}
+
 static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
 static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
 static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
@@ -749,12 +791,15 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label, i8k_hwmon_temp_label, 9);
 static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
 static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
+static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
 static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
 static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
 static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
+static SENSOR_DEVICE_ATTR_WO(pwm2_enable, i8k_hwmon_pwm_enable, 0);
 static SENSOR_DEVICE_ATTR_RO(fan3_input, i8k_hwmon_fan, 2);
 static SENSOR_DEVICE_ATTR_RO(fan3_label, i8k_hwmon_fan_label, 2);
 static SENSOR_DEVICE_ATTR_RW(pwm3, i8k_hwmon_pwm, 2);
+static SENSOR_DEVICE_ATTR_WO(pwm3_enable, i8k_hwmon_pwm_enable, 0);
 
 static struct attribute *i8k_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,	/* 0 */
@@ -780,12 +825,15 @@ static struct attribute *i8k_attrs[] = {
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
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,	/* 27 */
+	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 28 */
+	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 29 */
+	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 30 */
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,	/* 31 */
 	NULL
 };
 
@@ -828,13 +876,13 @@ static umode_t i8k_is_visible(struct kobject *kobj, struct attribute *attr,
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP10))
 		return 0;
 
-	if (index >= 20 && index <= 22 &&
+	if (index >= 20 && index <= 23 &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
 		return 0;
-	if (index >= 23 && index <= 25 &&
+	if (index >= 24 && index <= 27 &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
 		return 0;
-	if (index >= 26 && index <= 28 &&
+	if (index >= 28 && index <= 31 &&
 	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN3))
 		return 0;
 
@@ -1135,12 +1183,48 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
 	{ }
 };
 
+struct i8k_manual_fan_data {
+	unsigned int smm_manual_fan;
+	unsigned int smm_auto_fan;
+};
+
+enum i8k_manual_fans {
+	I8K_FAN_34A3_35A3,
+};
+
+static const struct i8k_manual_fan_data i8k_manual_fan_data[] = {
+	[I8K_FAN_34A3_35A3] = {
+		.smm_manual_fan = 0x34a3,
+		.smm_auto_fan = 0x35a3,
+	},
+};
+
+static struct dmi_system_id i8k_whitelist_manual_fan[] __initdata = {
+	{
+		.ident = "Dell Precision 5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
+		},
+		.driver_data = (void *)&i8k_manual_fan_data[I8K_FAN_34A3_35A3],
+	},
+	{
+		.ident = "Dell Latitude E6440",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E6440"),
+		},
+		.driver_data = (void *)&i8k_manual_fan_data[I8K_FAN_34A3_35A3],
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
+	const struct dmi_system_id *id, *manual_fan;
 	int fan, ret;
 
 	/*
@@ -1200,6 +1284,13 @@ static int __init i8k_probe(void)
 	i8k_fan_max = fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
 	i8k_pwm_mult = DIV_ROUND_UP(255, i8k_fan_max);
 
+	manual_fan = dmi_first_match(i8k_whitelist_manual_fan);
+	if (manual_fan && manual_fan->driver_data) {
+		const struct i8k_manual_fan_data *manual_fan_data = manual_fan->driver_data;
+		smm_manual_fan = manual_fan_data->smm_manual_fan;
+		smm_auto_fan = manual_fan_data->smm_auto_fan;
+	}
+
 	if (!fan_mult) {
 		/*
 		 * Autodetect fan multiplier based on nominal rpm
-- 
2.24.0

