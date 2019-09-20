Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDF9214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJWx5Ujz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394488AbfITAko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:40:44 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35545 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbfITAkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:40:43 -0400
Received: by mail-yw1-f68.google.com with SMTP id r134so1941322ywg.2;
        Thu, 19 Sep 2019 17:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KWVIp469lW4+EScBOPQlrmE0QLON/OsspQQ20Ex+qXI=;
        b=TJWx5Ujz1nUHCPnZiYE5vbWqh2OhCvxiaw3mjNvnFn/kHa7twQcFDTwcJWRTwcbmJL
         /POAmfYslqPXUHUYBQKnmekqRIVKikkqJCql1E3ljRHT6FlPYULevyOmVp/cvYthLkxe
         z8PdhrhhdBQsd9BsDj9t+EC3QdPgLqgERKFN14oQa8syBovQMV7VU3ffkEd98BUNQsJq
         48AyXEuEmkZBbiQ6oHD3zmGPtwoRUSoJfv1NF+ocUl67lCLuirld4iu+vgLoILBVb09f
         wf6SDKcEZk4F0WNQSMpZNEnW6NBQ/C04NgGgWxdWQFItsq2NycqBCpEYuuXGXJz8G9SM
         LXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWVIp469lW4+EScBOPQlrmE0QLON/OsspQQ20Ex+qXI=;
        b=oHmsRtm1g1DtXqvYlq+34Uhcsb7M19ojjP9CMZyHlqGp6GgCT0p4jowqf767nStmhk
         xf9OziZox8lMyKoX4Hu+/xgRJMQVQNjuwJ5caK5mJqdRlwMWSgQdNkPeA2ZiXYiFNwP4
         ao3w9lYOxecdJ2agrQJCGSw8Dz9u1fddNzzUc5WgwtNklNl5nADwfyMcyRaPjdU9CJf8
         20ouTSzaUZlEnAL8Tr9efCgGrBWx5K8jB25vVOe2g+kQqvlzpCdjdbW4DqRCEbkEcqJ+
         CGYtlhMlLC9dX7ggindT/qfy8XojftXQHVpympHAnnawMXXxik6KWkmY1/sAQ5ZYLsHF
         hvKA==
X-Gm-Message-State: APjAAAVwk0Ungkt31qwbr3JJLiAcQxu+N1Rf9jV/4UlfvolbCgjwW3I5
        4sNB+ozTj41llIzB/qj+JgmUjh9B1A==
X-Google-Smtp-Source: APXvYqx0MlhDIAFvnF7mj0bnxiZvkNGncD0IfNRW71zZ6S7GNC3Obb6614/tRMfsOw1evUP8tAoA8w==
X-Received: by 2002:a81:37c8:: with SMTP id e191mr10232770ywa.142.1568940042616;
        Thu, 19 Sep 2019 17:40:42 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id r63sm102802ywg.36.2019.09.19.17.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 17:40:42 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] platform/x86: huawei-wmi: Add battery charging thresholds
Date:   Thu, 19 Sep 2019 20:39:09 -0400
Message-Id: <20190920003938.21617-5-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920003938.21617-1-ayman.bagabas@gmail.com>
References: <20190920003938.21617-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control battery charge thresholds through the battery API and driver's
attributes.

Setting battery charging thresholds can introduce a race condition with
MACH-WX9 where two or more threads are trying to read/write values
from/to EC memory.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |   1 +
 drivers/platform/x86/huawei-wmi.c | 212 ++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 61bf180d25c7..0659589e46bb 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1305,6 +1305,7 @@ config INTEL_ATOMISP2_PM
 
 config HUAWEI_WMI
 	tristate "Huawei WMI laptop extras driver"
+	depends on ACPI_BATTERY
 	depends on ACPI_WMI
 	depends on INPUT
 	select INPUT_SPARSEKMAP
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 63e79b5f8282..4ca1a6896766 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
@@ -13,7 +14,10 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/sysfs.h>
 #include <linux/wmi.h>
+#include <acpi/battery.h>
 
 /*
  * Huawei WMI GUIDs
@@ -54,11 +58,14 @@ struct huawei_wmi_debug {
 };
 
 struct huawei_wmi {
+	bool battery_available;
+
 	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	struct platform_device *pdev;
 
+	struct mutex battery_lock;
 	struct mutex wmi_lock;
 };
 
@@ -306,6 +313,208 @@ static void huawei_wmi_leds_setup(struct device *dev)
 	devm_led_classdev_register(dev, &huawei->cdev);
 }
 
+/* Battery protection */
+
+static int huawei_wmi_battery_get(int *start, int *end)
+{
+	u8 ret[0x100];
+	int err, i;
+
+	err = huawei_wmi_cmd(BATTERY_THRESH_GET, ret, 0x100);
+	if (err)
+		return err;
+
+	/* Find the last two non-zero values. Return status is ignored. */
+	i = 0x100;
+	do {
+		if (start)
+			*start = ret[i-1];
+		if (end)
+			*end = ret[i];
+	} while (i > 2 && !ret[i--]);
+
+	return 0;
+}
+
+static int huawei_wmi_battery_set(int start, int end)
+{
+	union hwmi_arg arg;
+	int err;
+
+	if (start < 0 || end > 100)
+		return -EINVAL;
+
+	arg.cmd = BATTERY_THRESH_SET;
+	arg.args[2] = start;
+	arg.args[3] = end;
+
+	/* This is an edge case were some models turn battery protection
+	 * off without changing their thresholds values. We clear the
+	 * values before turning off protection. Sometimes we need a sleep delay to
+	 * make sure these values make their way to EC memory.
+	 */
+	if (quirks && quirks->battery_reset && start == 0 && end == 100) {
+		err = huawei_wmi_battery_set(0, 0);
+		if (err)
+			return err;
+
+		msleep(1000);
+	}
+
+	err = huawei_wmi_cmd(arg.cmd, NULL, 0);
+
+	return err;
+}
+
+static ssize_t charge_control_start_threshold_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, start;
+
+	err = huawei_wmi_battery_get(&start, NULL);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", start);
+}
+
+static ssize_t charge_control_end_threshold_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, end;
+
+	err = huawei_wmi_battery_get(NULL, &end);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", end);
+}
+
+static ssize_t charge_control_thresholds_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, start, end;
+
+	err = huawei_wmi_battery_get(&start, &end);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d %d\n", start, end);
+}
+
+static ssize_t charge_control_start_threshold_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int err, start, end;
+
+	err = huawei_wmi_battery_get(NULL, &end);
+	if (err)
+		return err;
+
+	if (sscanf(buf, "%d", &start) != 1)
+		return -EINVAL;
+
+	err = huawei_wmi_battery_set(start, end);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t charge_control_end_threshold_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int err, start, end;
+
+	err = huawei_wmi_battery_get(&start, NULL);
+	if (err)
+		return err;
+
+	if (sscanf(buf, "%d", &end) != 1)
+		return -EINVAL;
+
+	err = huawei_wmi_battery_set(start, end);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t charge_control_thresholds_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int err, start, end;
+
+	if (sscanf(buf, "%d %d", &start, &end) != 2)
+		return -EINVAL;
+
+	err = huawei_wmi_battery_set(start, end);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(charge_control_start_threshold);
+static DEVICE_ATTR_RW(charge_control_end_threshold);
+static DEVICE_ATTR_RW(charge_control_thresholds);
+
+static int huawei_wmi_battery_add(struct power_supply *battery)
+{
+	/* Huawei laptops come with one battery only */
+	if (strcmp(battery->desc->name, "BAT") != 1)
+		return -ENODEV;
+
+	device_create_file(&battery->dev, &dev_attr_charge_control_start_threshold);
+	device_create_file(&battery->dev, &dev_attr_charge_control_end_threshold);
+
+	return 0;
+}
+
+static int huawei_wmi_battery_remove(struct power_supply *battery)
+{
+	device_remove_file(&battery->dev, &dev_attr_charge_control_start_threshold);
+	device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold);
+
+	return 0;
+}
+
+static struct acpi_battery_hook huawei_wmi_battery_hook = {
+	.add_battery = huawei_wmi_battery_add,
+	.remove_battery = huawei_wmi_battery_remove,
+	.name = "Huawei Battery Extension"
+};
+
+static void huawei_wmi_battery_setup(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	huawei->battery_available = true;
+	if (huawei_wmi_battery_get(NULL, NULL)) {
+		huawei->battery_available = false;
+		return;
+	}
+
+	battery_hook_register(&huawei_wmi_battery_hook);
+	device_create_file(dev, &dev_attr_charge_control_thresholds);
+}
+
+static void huawei_wmi_battery_exit(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	if (huawei->battery_available) {
+		battery_hook_unregister(&huawei_wmi_battery_hook);
+		device_remove_file(dev, &dev_attr_charge_control_thresholds);
+	}
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -426,8 +635,10 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		mutex_init(&huawei_wmi->wmi_lock);
+		mutex_init(&huawei_wmi->battery_lock);
 
 		huawei_wmi_leds_setup(&pdev->dev);
+		huawei_wmi_battery_setup(&pdev->dev);
 	}
 
 	return 0;
@@ -445,6 +656,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 	}
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		huawei_wmi_battery_exit(&pdev->dev);
 	}
 
 	return 0;
-- 
2.21.0

