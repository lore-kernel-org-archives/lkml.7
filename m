Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C260C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510FD21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1oZfadI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfDSTtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:49:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50221 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfDSTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:49:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so7294869wmi.0;
        Fri, 19 Apr 2019 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aJB9vZEivpTYcxe60Rw8TV3c7mATmB3KiJeMZf8AEvs=;
        b=R1oZfadI5D5jjZhwD5ag2OTCMfSJN6oA89fYGjdqBFMhTmADHFzNtPCX9FuvXWN34r
         T/FKoKVtnJ/eiauMpzTq0/NfjqDAatmjmqSVhyW0c8vdqOqqLOQfMIcuyExAJ/GfWoCU
         u62qAkRQL0PLbLRkplIaKxlcVObhzka83AOX84X9ZXovK5TRNblM1WJ+cULhRpsGSRRn
         8d3tM+otxZaaoin8yei3yLvxzknR0PGXt6WEMT2NzDVoVHavHce0Ru1QTkrLvPxazhnj
         my0H701I+AQO7+uWY7Xdyj4KQpDBm0lG5pY6v7Vn+1i4J7Z0lNi31/gBYub2BhfQiuNf
         oHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJB9vZEivpTYcxe60Rw8TV3c7mATmB3KiJeMZf8AEvs=;
        b=bSSjNC4VfwGDbJ8i0/rOL4aSfq4kku9IrruIFKWlX1OAn+XccKMDU3kNz1kP6LVWg/
         PtORPc/ZSgaWVSywYJy0h9tuGo1y7OK1BlY0X5YRphiGILvE/C2xV0a2mUXEl143IgkP
         OgrzGSYKsR8+2BITudmuweDDbEC/BO6S+UNdzHU8YesmoVmqHVkpSYsNdZu88x1fFfg/
         Cv6QM3PCtmt17GsBBx+HNUeCaBhGDmkR3Wx4rHiXf5/YWRPc/hvJ8HzXiEnM5Wro1tqY
         UZQGx9SSjtR9gNHgfy9/GIYNpWFLB3J10PSG5IfGbjlEH2pej3i+KJwMlxwYkLrvKgGk
         /aEw==
X-Gm-Message-State: APjAAAXdYHk1VEB2i32tQ/jKdhu4ejfdYJZ4SVZLNomw+WcPlCFHA3JB
        K3gZSv+rY0dxPbGKt09WdatknqnqeuM=
X-Google-Smtp-Source: APXvYqxGNWum+wkHzsDzSv5OqK3N+NQlfFiLVOm34MfLXY9Y42FHzEXmj+JAkaVBuqPXBUcA2q6z3Q==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr2126039wma.139.1555668948629;
        Fri, 19 Apr 2019 03:15:48 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id f16sm2697805wru.19.2019.04.19.03.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 03:15:47 -0700 (PDT)
Subject: [PATCH v3 10/11] platform/x86: asus-wmi: Switch fan boost mode
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Message-ID: <bc454e6f-58f5-f326-3037-56e843e96800@gmail.com>
Date:   Fri, 19 Apr 2019 12:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI exposes a write-only device ID where up to three fan modes modes
can be switched on some laptops (TUF Gaming FX505GM). There is a hotkey
combination Fn-F5 that does have a fan icon which is designed to toggle
between fan modes. The DSTS of the device ID returns information about the
presence of the device and the presence of each of the two additional fan
modes as a bitmask (0x01 - overboost present, 0x02 - silent present) [1].

Add a SysFS entry that reads the last written value and updates value in
WMI on write and a hotkey handler that toggles the modes taking into
account their availability according to DSTS.

Modes:
* 0x00 - normal or balanced,
* 0x01 - overboost, increased fan RPM,
* 0x02 - silent, decreased fan RPM

[1] https://lkml.org/lkml/2019/4/12/110

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Suggested-by: Daniel Drake <drake@endlessm.com>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  10 ++
 drivers/platform/x86/asus-wmi.c               | 149 +++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h    |   1 +
 3 files changed, 152 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 1cc54d5e3e10..6f396c4eabdc 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -97,3 +97,13 @@ Description:
 		Write changed RGB keyboard backlight parameters:
 			* 1 - permanently,
 			* 2 - temporarily.
+
+What:		/sys/devices/platform/<platform>/fan_mode
+Date:		Apr 2019
+KernelVersion:	5.1
+Contact:	"Yurii Pavlovskyi" <yurii.pavlovskyi@gmail.com>
+Description:
+		Fan boost mode:
+			* 0 - normal,
+			* 1 - overboost,
+			* 2 - silent
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 0a32079336d8..7974283b7b12 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -69,6 +69,7 @@ MODULE_LICENSE("GPL");
 #define NOTIFY_KBD_BRTUP		0xc4
 #define NOTIFY_KBD_BRTDWN		0xc5
 #define NOTIFY_KBD_BRTTOGGLE		0xc7
+#define NOTIFY_KBD_FBM			0x99
 
 #define ASUS_FAN_DESC			"cpu_fan"
 #define ASUS_FAN_MFUN			0x13
@@ -77,6 +78,13 @@ MODULE_LICENSE("GPL");
 #define ASUS_FAN_CTRL_MANUAL		1
 #define ASUS_FAN_CTRL_AUTO		2
 
+#define ASUS_FAN_MODE_NORMAL		0
+#define ASUS_FAN_MODE_OVERBOOST		1
+#define ASUS_FAN_MODE_OVERBOOST_MASK	0x01
+#define ASUS_FAN_MODE_SILENT		2
+#define ASUS_FAN_MODE_SILENT_MASK	0x02
+#define ASUS_FAN_MODES_MASK		0x03
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -198,6 +206,10 @@ struct asus_wmi {
 	int asus_hwmon_num_fans;
 	int asus_hwmon_pwm;
 
+	bool fan_mode_available;
+	u8 fan_mode_mask;
+	u8 fan_mode;
+
 	bool kbbl_rgb_available;
 	struct asus_kbbl_rgb kbbl_rgb;
 
@@ -1827,6 +1839,114 @@ static int asus_wmi_fan_init(struct asus_wmi *asus)
 	return 0;
 }
 
+/* Fan mode *******************************************************************/
+
+static int fan_mode_check_present(struct asus_wmi *asus)
+{
+	u32 result;
+	int err;
+
+	asus->fan_mode_available = false;
+
+	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_MODE, &result);
+	if (err) {
+		if (err == -ENODEV)
+			return 0;
+		else
+			return err;
+	}
+
+	if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+			(result & ASUS_FAN_MODES_MASK)) {
+		asus->fan_mode_available = true;
+		asus->fan_mode_mask = result & ASUS_FAN_MODES_MASK;
+	}
+
+	return 0;
+}
+
+static int fan_mode_write(struct asus_wmi *asus)
+{
+	int err;
+	u8 value;
+	u32 retval;
+
+	value = asus->fan_mode;
+
+	pr_info("Set fan mode: %u\n", value);
+	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_MODE, value, &retval);
+
+	if (err) {
+		pr_warn("Failed to set fan mode: %d\n", err);
+		return err;
+	}
+
+	if (retval != 1) {
+		pr_warn("Failed to set fan mode (retval): 0x%x\n", retval);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int fan_mode_switch_next(struct asus_wmi *asus)
+{
+	if (asus->fan_mode == ASUS_FAN_MODE_NORMAL) {
+		if (asus->fan_mode_mask & ASUS_FAN_MODE_OVERBOOST_MASK)
+			asus->fan_mode = ASUS_FAN_MODE_OVERBOOST;
+		else if (asus->fan_mode_mask & ASUS_FAN_MODE_SILENT_MASK)
+			asus->fan_mode = ASUS_FAN_MODE_SILENT;
+	} else if (asus->fan_mode == ASUS_FAN_MODE_OVERBOOST) {
+		if (asus->fan_mode_mask & ASUS_FAN_MODE_SILENT_MASK)
+			asus->fan_mode = ASUS_FAN_MODE_SILENT;
+		else
+			asus->fan_mode = ASUS_FAN_MODE_NORMAL;
+	} else {
+		asus->fan_mode = ASUS_FAN_MODE_NORMAL;
+	}
+
+	return fan_mode_write(asus);
+}
+
+static ssize_t fan_mode_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	return show_u8(asus->fan_mode, buf);
+}
+
+static ssize_t fan_mode_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int result;
+	u8 new_mode;
+
+	struct asus_wmi *asus = dev_get_drvdata(dev);
+
+	result = store_u8(&new_mode, buf, count);
+	if (result < 0)
+		return result;
+
+	if (new_mode == ASUS_FAN_MODE_OVERBOOST) {
+		if (!(asus->fan_mode_mask & ASUS_FAN_MODE_OVERBOOST_MASK))
+			return -EINVAL;
+	} else if (new_mode == ASUS_FAN_MODE_SILENT) {
+		if (!(asus->fan_mode_mask & ASUS_FAN_MODE_SILENT_MASK))
+			return -EINVAL;
+	} else if (new_mode != ASUS_FAN_MODE_NORMAL) {
+		return -EINVAL;
+	}
+
+	asus->fan_mode = new_mode;
+	fan_mode_write(asus);
+
+	return result;
+}
+
+// Fan mode: 0 - normal, 1 - overboost, 2 - silent
+static DEVICE_ATTR_RW(fan_mode);
+
 /* Backlight ******************************************************************/
 
 static int read_backlight_power(struct asus_wmi *asus)
@@ -2078,6 +2198,11 @@ static void asus_wmi_handle_notify_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
+	if (asus->fan_mode_available && code == NOTIFY_KBD_FBM) {
+		fan_mode_switch_next(asus);
+		return;
+	}
+
 	if (is_display_toggle(code) && asus->driver->quirks->no_display_toggle)
 		return;
 
@@ -2234,6 +2359,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_touchpad.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
+	&dev_attr_fan_mode.attr,
 	NULL
 };
 
@@ -2255,6 +2381,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
+	else if (attr == &dev_attr_fan_mode.attr)
+		ok = asus->fan_mode_available;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -2355,12 +2483,7 @@ static int asus_wmi_platform_init(struct asus_wmi *asus)
 		asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
 				      asus->driver->quirks->wapf, NULL);
 
-	return asus_wmi_sysfs_init(asus->platform_device);
-}
-
-static void asus_wmi_platform_exit(struct asus_wmi *asus)
-{
-	asus_wmi_sysfs_exit(asus->platform_device);
+	return 0;
 }
 
 /* debugfs ********************************************************************/
@@ -2539,6 +2662,14 @@ static int asus_wmi_add(struct platform_device *pdev)
 	if (err)
 		goto fail_platform;
 
+	err = fan_mode_check_present(asus);
+	if (err)
+		goto fail_fan_mode;
+
+	err = asus_wmi_sysfs_init(asus->platform_device);
+	if (err)
+		goto fail_sysfs;
+
 	err = asus_wmi_input_init(asus);
 	if (err)
 		goto fail_input;
@@ -2622,7 +2753,9 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_hwmon:
 	asus_wmi_input_exit(asus);
 fail_input:
-	asus_wmi_platform_exit(asus);
+	asus_wmi_sysfs_exit(asus->platform_device);
+fail_sysfs:
+fail_fan_mode:
 fail_platform:
 	kfree(asus);
 	return err;
@@ -2640,7 +2773,7 @@ static int asus_wmi_remove(struct platform_device *device)
 	kbbl_rgb_exit(asus);
 	asus_wmi_rfkill_exit(asus);
 	asus_wmi_debugfs_exit(asus);
-	asus_wmi_platform_exit(asus);
+	asus_wmi_sysfs_exit(asus->platform_device);
 	asus_hwmon_fan_set_auto(asus);
 
 	kfree(asus);
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index c8c6e939e196..fdf5839f64ad 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -59,6 +59,7 @@
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
 #define ASUS_WMI_DEVID_KBD_RGB		0x00100056
 #define ASUS_WMI_DEVID_KBD_RGB2		0x00100057
+#define ASUS_WMI_DEVID_FAN_MODE		0x00110018
 
 /* Misc */
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
-- 
2.17.1

