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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5495C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECCB206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+yF2qJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfITQEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:04:05 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46285 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387662AbfITQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:04:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id 201so2643022ywn.13;
        Fri, 20 Sep 2019 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4z8I/CXv1oEWkgFQw4hQrn5Fcq+os8zrDkpZFa+UqdA=;
        b=Q+yF2qJusMeBNSWw+Ly61QaiRxD3HniciFNWR9iRt7nqEJqGBliclCU6ZrPcSmXs/v
         3V8b/wW4H4LQeORg5RLEz/Gani24BvZusr5j+L51O0EMhyyC5CKm0n6FCQXUwR6GwEM3
         pWqB1xY7Lo3hATZk2F7LFihs8sgPipGistYOcNihgdWo6L5t++lTjULxc5Jh51IephKF
         yEmdALB+eewNA0T/TlR+sbVv/Q7DtBO6Y/vWeqnL93zQJLwVwMnhfjZlugj3EP0o3+6g
         l2JuhShlFL6AZwZpXd+0MHyuovR5ox4Pw4DT/2EOqabD++kFgfkQ6xBDVJnOAy7JhuuD
         zYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4z8I/CXv1oEWkgFQw4hQrn5Fcq+os8zrDkpZFa+UqdA=;
        b=BrM8SUmKwap9z8aCBndzU2mnuG54zE72fQj6kTk+nwsVuvsDJpxFTLISRXYa0tZXQK
         7aS+LGlZlUnIM1t/r3Uo9MD3zajV/+jeak+6wr/oSzKXQjyYdgFUHineD9PtkKWxRPy1
         H9Pdi+vPFy83uFDss0C9xE278BV346NkAfN7kmzlnX7boWn11m7EnQW/EsFAjK0WCqwL
         y6YzLAe/32Yk2iDGdXiL1S4ym5ufF7BJ+BdDWwLH1OdWvCqG1JRBtJCU+zyLxGBUan1Q
         2Qq9/pwdA87fb3Kh6XuWq+kgV6QK9oD2SYJe+g6/VhuzV7/qs0M4p8vGaSbin0j/ptJR
         qOqg==
X-Gm-Message-State: APjAAAXyRJCRzTVtQ50qY4r9J7Ljw1kJtaHj9oCZZJ/UXMtseqI53cPS
        XS8AASOaQQFu/fPX3gaYgQ==
X-Google-Smtp-Source: APXvYqwYC8UODFqvRVZpZK+sJLRAQ5xdLfARGCQ+RnZuqYOWXdqk97v5qDjguvexXO5N6Bslio9JAw==
X-Received: by 2002:a81:6043:: with SMTP id u64mr13850894ywb.104.1568995443860;
        Fri, 20 Sep 2019 09:04:03 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id 207sm518086ywu.106.2019.09.20.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:04:02 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] platform/x86: huawei-wmi: Add battery charging thresholds
Date:   Fri, 20 Sep 2019 12:02:37 -0400
Message-Id: <20190920160250.12510-5-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920160250.12510-1-ayman.bagabas@gmail.com>
References: <20190920160250.12510-1-ayman.bagabas@gmail.com>
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
index 41904b1cc284..e577786e6306 100644
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
@@ -49,10 +53,13 @@ struct quirk_entry {
 static struct quirk_entry *quirks;
 
 struct huawei_wmi {
+	bool battery_available;
+
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
 	struct platform_device *pdev;
 
+	struct mutex battery_lock;
 	struct mutex wmi_lock;
 };
 
@@ -300,6 +307,208 @@ static void huawei_wmi_leds_setup(struct device *dev)
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
@@ -420,8 +629,10 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		mutex_init(&huawei_wmi->wmi_lock);
+		mutex_init(&huawei_wmi->battery_lock);
 
 		huawei_wmi_leds_setup(&pdev->dev);
+		huawei_wmi_battery_setup(&pdev->dev);
 	}
 
 	return 0;
@@ -439,6 +650,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 	}
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		huawei_wmi_battery_exit(&pdev->dev);
 	}
 
 	return 0;
-- 
2.21.0

