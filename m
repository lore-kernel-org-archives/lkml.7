Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F898C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0033020715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKNVWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:22:12 -0500
Received: from pietrobattiston.it ([92.243.7.39]:57368 "EHLO
        jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbfKNVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:22:12 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2019 16:22:09 EST
Received: from amalgama (94.105.105.79.dyn.edpnet.net [94.105.105.79])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: giovanni)
        by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id DF12EE1E18;
        Thu, 14 Nov 2019 22:14:27 +0100 (CET)
Received: by amalgama (Postfix, from userid 1000)
        id 7025C3C01EF; Thu, 14 Nov 2019 22:14:27 +0100 (CET)
From:   Giovanni Mascellani <gio@debian.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Giovanni Mascellani <gio@debian.org>
Subject: [PATCH] hwmon: (dell-smm-hwmon) Disable BIOS fan control on SET_FAN
Date:   Thu, 14 Nov 2019 22:14:08 +0100
Message-Id: <20191114211408.22123-1-gio@debian.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Dell laptops the BIOS directly controls fan speed, ignoring
SET_FAN commands. Also, the BIOS controller often happens to be buggy,
failing to increase fan speed when the CPU is under heavy load and
setting fan at full speed even when the CPU is idle and relatively
cool.

Disable BIOS fan control on such laptops as soon as a SET_FAN command
is issued, and re-enable it at module unloading, so that a userspace
controller like i8kmon can take control of the fan.

There is a missing feature: interaction with PM; I think that when
suspending on RAM the fans should be stopped (this BIOS doesn't always
do this automatically, neither when fan control is enabled nor when it
is disabled); when recovering from hibernation to disk, also, the
command to disable BIOS fan control should be issued again, because
the computer will have had a power cycle in the meantime.

I don't know how to implement these two actions; can someone suggest a
way? Also, I would be happy to know from more experienced people if
these actions are sensible.

Signed-off-by: Giovanni Mascellani <gio@debian.org>
---
 drivers/hwmon/dell-smm-hwmon.c | 64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 4212d022d253..6d72e207076f 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -32,6 +32,12 @@
 
 #include <linux/i8k.h>
 
+/*
+ * The code for enabling and disabling BIOS fan control were found by
+ * trial and error with the program at
+ *  https://github.com/clopez/dellfan.
+ */
+
 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
 #define I8K_SMM_SET_FAN		0x01a3
@@ -43,6 +49,8 @@
 #define I8K_SMM_GET_TEMP_TYPE	0x11a3
 #define I8K_SMM_GET_DELL_SIG1	0xfea3
 #define I8K_SMM_GET_DELL_SIG2	0xffa3
+#define I8K_SMM_DISABLE_BIOS	0x30a3
+#define I8K_SMM_ENABLE_BIOS	0x31a3
 
 #define I8K_FAN_MULT		30
 #define I8K_FAN_MAX_RPM		30000
@@ -68,6 +76,8 @@ static uint i8k_pwm_mult;
 static uint i8k_fan_max = I8K_FAN_HIGH;
 static bool disallow_fan_type_call;
 static bool disallow_fan_support;
+static bool disable_bios;
+static bool bios_disabled;
 
 #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
 #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
@@ -419,6 +429,26 @@ static int i8k_get_power_status(void)
 	return (regs.eax & 0xff) == I8K_POWER_AC ? I8K_AC : I8K_BATTERY;
 }
 
+/*
+ * Disable BIOS fan control.
+ */
+static int i8k_disable_bios(void)
+{
+	struct smm_regs regs = { .eax = I8K_SMM_DISABLE_BIOS, .ebx = 0 };
+
+	return i8k_smm(&regs) ? : regs.eax & 0xff;
+}
+
+/*
+ * Enable BIOS fan control.
+ */
+static int i8k_enable_bios(void)
+{
+	struct smm_regs regs = { .eax = I8K_SMM_ENABLE_BIOS, .ebx = 0 };
+
+	return i8k_smm(&regs) ? : regs.eax & 0xff;
+}
+
 /*
  * Procfs interface
  */
@@ -488,6 +518,13 @@ i8k_ioctl_unlocked(struct file *fp, unsigned int cmd, unsigned long arg)
 		if (copy_from_user(&speed, argp + 1, sizeof(int)))
 			return -EFAULT;
 
+                if (disable_bios && !bios_disabled) {
+			val = i8k_disable_bios();
+			if (val < 0)
+				return val;
+			bios_disabled = true;
+                }
+
 		val = i8k_set_fan(val, speed);
 		break;
 
@@ -1135,6 +1172,22 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
 	{ }
 };
 
+/*
+ * On some machines the BIOS disregards all SET_FAN commands unless it
+ * is explicitly disabled.
+ * See bug: https://bugzilla.kernel.org/show_bug.cgi?id=200949
+ */
+static struct dmi_system_id i8k_disable_bios_dmi_table[] __initdata = {
+	{
+		.ident = "Dell Precision 5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
+		},
+	},
+	{ }
+};
+
 /*
  * Probe for the presence of a supported laptop.
  */
@@ -1169,6 +1222,11 @@ static int __init i8k_probe(void)
 			disallow_fan_type_call = true;
 	}
 
+	if (dmi_check_system(i8k_disable_bios_dmi_table)) {
+		pr_warn("broken Dell BIOS detected, will disable BIOS fan control\n");
+		disable_bios = true;
+	}
+
 	strlcpy(bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION),
 		sizeof(bios_version));
 	strlcpy(bios_machineid, i8k_get_dmi_data(DMI_PRODUCT_SERIAL),
@@ -1241,6 +1299,12 @@ static void __exit i8k_exit(void)
 {
 	hwmon_device_unregister(i8k_hwmon_dev);
 	i8k_exit_procfs();
+
+	if (bios_disabled) {
+		pr_warn("re-enabling BIOS fan control\n");
+		if (i8k_enable_bios())
+			pr_warn("could not re-enable BIOS fan control\n");
+	}
 }
 
 module_init(i8k_init);
-- 
2.24.0

