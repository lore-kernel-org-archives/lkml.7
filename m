Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7438C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718F02073F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEV+Os0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKXOH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 09:07:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33529 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfKXOH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 09:07:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so12692291ljk.0;
        Sun, 24 Nov 2019 06:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kfm4fhMUyyQjD49i5oCuMgOLOcR8Qd3E7xVozwk/t6s=;
        b=GEV+Os0Slrm6W94dxpftCi+sm/5Gp2HZhWXIB6wkLFX6/YnIxXcqx13cVs8g+PX7LY
         yab1dsvaUMb0+k/Z26tWvlX6iLbV5CR7IqDaCv30Ko9SVreneCNI1b9Ni85tIdxoWvWo
         Y1KGdIhPpfLpLTCFOph9hko15SVVdbpuQxCBg2ufK2VXURTKVsFcgT8eFaKOK9l0L2oz
         cjmbpNyZVm7gAV3ciO4GWG4eQZ2cKxSHvJOz3vCnQrVOT/qxeXtuoJvCAYRmIq3mKck9
         gikKmFN+Ggv/Vn49GG0HBPYVgHbpQ/D7ptH5pstaQwB85241zW6jpqy6P8eh9RZOuKJv
         wiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kfm4fhMUyyQjD49i5oCuMgOLOcR8Qd3E7xVozwk/t6s=;
        b=aGSzwpKOUO+51zndqCyVBIqWu+ElFij9C38I/Th5opEzk8rJrpToUEYOXWA0nk7NRt
         4l6NpLQ7/s8KcVa+dbLlicnRh9Y5pIQE6ENXBns0JaUYpcXhtWgLY1piOCxvVwYxMkar
         DqdP9+eQQVgX/vqiLP2Vr5ZeS8lD58Sp6J+ZQg+10c/KRhmWbw/PM0MAnENSllTT63Cq
         gNhpL83i/HHMlNaqkOnCuRS0b/NcP0AZFZRNmzSfLVKexIkhEG2zUE3TqXZYvor5zlr0
         E7nrXNX7VQue276fhmFqmbW6sa5tEi1aaiRSHUsLC8LJEQ7I5KfDc54QyWRTN8xi4QUW
         SAVg==
X-Gm-Message-State: APjAAAU8Ws/d3dgwgDoSeFR8mGbrmTgxZMQt8L7pWXNW6ftAQR8YVAyw
        JmxTQZ+xlyRzEeJL1BLzTV8wTU91XcQ=
X-Google-Smtp-Source: APXvYqx9HIyNYz3CHvTQJb0h4dshMcdINztsplPWIG0wMYA0uxlfFZVe7IQ4fLpry+YBimCx3mSUFQ==
X-Received: by 2002:a2e:b5c4:: with SMTP id g4mr18902837ljn.169.1574604476113;
        Sun, 24 Nov 2019 06:07:56 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id t7sm2267449ljg.59.2019.11.24.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 06:07:55 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        kristian@klausen.dk, andy@infradead.org, dvhart@infradead.org,
        corentin.chary@gmail.com, Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v5 1/2] platform/x86 asus_wmi: Support throttle thermal policy
Date:   Sun, 24 Nov 2019 16:07:44 +0200
Message-Id: <20191124140744.20830-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191124140625.20736-1-leonmaxx@gmail.com>
References: <20191124140625.20736-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Throttle thermal policy ACPI device is used to control CPU cooling and
throttling. This patch adds sysfs entry for setting current mode and
Fn+F5 hotkey that switches to next.

Policy modes:
* 0x00 - default
* 0x01 - overboost
* 0x02 - silent

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c            | 117 +++++++++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   1 +
 2 files changed, 118 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..88faea6 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -61,6 +61,7 @@
 #define NOTIFY_KBD_BRTDWN		0xc5
 #define NOTIFY_KBD_BRTTOGGLE		0xc7
 #define NOTIFY_KBD_FBM			0x99
+#define NOTIFY_KBD_TTP			0xae
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -81,6 +82,10 @@
 #define ASUS_FAN_BOOST_MODE_SILENT_MASK		0x02
 #define ASUS_FAN_BOOST_MODES_MASK		0x03
 
+#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT	0
+#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
+#define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -198,6 +203,9 @@ struct asus_wmi {
 	u8 fan_boost_mode_mask;
 	u8 fan_boost_mode;
 
+	bool throttle_thermal_policy_available;
+	u8 throttle_thermal_policy_mode;
+
 	// The RSOC controls the maximum charging percentage.
 	bool battery_rsoc_available;
 
@@ -1724,6 +1732,102 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
 static DEVICE_ATTR_RW(fan_boost_mode);
 
+/* Throttle thermal policy ****************************************************/
+
+static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->throttle_thermal_policy_available = false;
+
+	err = asus_wmi_get_devstate(asus,
+				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+				    &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		else
+			return err;
+	}
+
+	if ((result & ASUS_WMI_DSTS_PRESENCE_BIT))
+		asus->throttle_thermal_policy_available = true;
+
+	return 0;
+}
+
+static int throttle_thermal_policy_write(struct asus_wmi *asus)
+{
+	int err;
+	u8 value;
+	u32 retval;
+
+	value = asus->throttle_thermal_policy_mode;
+
+	pr_info("Set throttle thermal policy: %u\n", value);
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+				    value, &retval);
+	if (err) {
+		pr_warn("Failed to set throttle thermal policy: %d\n", err);
+		return err;
+	}
+
+	if (retval != 1) {
+		pr_warn("Failed to set throttle thermal policy (retval): 0x%x\n",
+			retval);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
+{
+	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
+
+	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
+
+	asus->throttle_thermal_policy_mode = new_mode;
+	return throttle_thermal_policy_write(asus);
+}
+
+static ssize_t throttle_thermal_policy_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 asus->throttle_thermal_policy_mode);
+}
+
+static ssize_t throttle_thermal_policy_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int result;
+	u8 new_mode;
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = kstrtou8(buf, 10, &new_mode);
+	if (result < 0) {
+		pr_warn("Trying to store invalid value\n");
+		return result;
+	}
+
+	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+		return -EINVAL;
+
+	asus->throttle_thermal_policy_mode = new_mode;
+	throttle_thermal_policy_write(asus);
+
+	return count;
+}
+
+// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+static DEVICE_ATTR_RW(throttle_thermal_policy);
+
 /* Backlight ******************************************************************/
 
 static int read_backlight_power(struct asus_wmi *asus)
@@ -2005,6 +2109,11 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
+	if (asus->throttle_thermal_policy_available && code == NOTIFY_KBD_TTP) {
+		throttle_thermal_policy_switch_next(asus);
+		return;
+	}
+
 	if (is_display_toggle(code) && asus->driver->quirks->no_display_toggle)
 		return;
 
@@ -2155,6 +2264,7 @@ static ssize_t cpufv_store(struct device *dev, struct device_attribute *attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
+	&dev_attr_throttle_thermal_policy.attr,
 	NULL
 };
 
@@ -2178,6 +2288,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
+	else if (attr == &dev_attr_throttle_thermal_policy.attr)
+		ok = asus->throttle_thermal_policy_available;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -2437,6 +2549,10 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_fan_boost_mode;
 
+	err = throttle_thermal_policy_check_present(asus);
+	if (err)
+		goto fail_throttle_thermal_policy;
+
 	err = asus_wmi_sysfs_init(asus->platform_device);
 	if (err)
 		goto fail_sysfs;
@@ -2521,6 +2637,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_input:
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
+fail_throttle_thermal_policy:
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 60249e2..d39fc65 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -58,6 +58,7 @@
 #define ASUS_WMI_DEVID_LIGHT_SENSOR	0x00050022 /* ?? */
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
+#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
 
 /* Misc */
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
-- 
1.8.3.1

