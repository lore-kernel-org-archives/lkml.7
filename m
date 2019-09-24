Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F18C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA324207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgAxngZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408755AbfIXCtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:49:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41684 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfIXCtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:49:21 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so303443vsr.8;
        Mon, 23 Sep 2019 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CIe9+K15TLzSO7/9vewvq0jPH+AJlq5+SBASSatS29s=;
        b=fgAxngZjCA9l6QwsNe9q4HEtXQqU/9ZS3h3qRGliO+trB75CVUCLhA6vWSES2yOFxp
         QE2DtW3WrkFsDmluvt2ksDiMFSrh2m34/h8SuRrX0QMDbZvXx+3LNI1+ccTLV+F/kgb3
         muLQ4+2WRX3A1Sg+D1xqmBkWNMGy/mS+skQ4FV5nfInNP3q6x/0fJ01YfcPi+E7HUYj3
         mTLjOaYjtZreVA2qiPvSMLQtFQCeaub1ZDL0zToQGxlTuK5bbdo/hoKUQ84WLVHfTmFb
         YZLC/ZJZ/0fLf8+GjRHbu8X+WyiF3IZQxAmSaoGYVqdo96VIaG76u41tSbJvDXPPA4B1
         VqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIe9+K15TLzSO7/9vewvq0jPH+AJlq5+SBASSatS29s=;
        b=gxnos3dY3atTdn1IBkXWTgCEmHz9aADTqPoT7xXakMgZOsEhf01L/NVjFmRp7+u2aR
         2+G6fIdtZmcIsMghT2U8FJeLKIWrBESlNM9YNkIHULrBucWMVOpiFMacVtegDt5Kz/8T
         ISBPAxghjfku7Em3l3AyrD8advZGgp5Cb/JxhshgPjhiUBgX3OcH8QePifTmp/gcEkPN
         nPh8fOTkYi1UjPfJoH0q36KtMaC6tye/kjuyfKXyKGOUb1xgOIJp8+uwdfCTY39B2b2V
         O6aRxgE/EHyGFwKohXm4zPwQHfjl7W8SPQTW5WTN/QangzSOPRboR5l3tOMv+8zio9i8
         xc2A==
X-Gm-Message-State: APjAAAV+/L2oBtF3W2D5B3efgc9IRzlH+wuItaw3ycBKQVjNdL48Phgj
        10K1rMEok0DtgMgclqC79Q==
X-Google-Smtp-Source: APXvYqwqkTq9n8L75Rw8hoKq5RqhAI5iyQ7YBXiyxEBllTaxWaVN9m3Q4Jn9UzmTPAd15lTwZWWorQ==
X-Received: by 2002:a67:f6d3:: with SMTP id v19mr280549vso.57.1569293360114;
        Mon, 23 Sep 2019 19:49:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id o16sm46547uar.2.2019.09.23.19.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 19:49:19 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] platform/x86: huawei-wmi: Add battery charging thresholds
Date:   Mon, 23 Sep 2019 22:48:09 -0400
Message-Id: <20190924024821.497-5-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924024821.497-1-ayman.bagabas@gmail.com>
References: <20190924024821.497-1-ayman.bagabas@gmail.com>
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
index 754405e19ef1..e64103789885 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1306,6 +1306,7 @@ config INTEL_ATOMISP2_PM
 
 config HUAWEI_WMI
 	tristate "Huawei WMI laptop extras driver"
+	depends on ACPI_BATTERY
 	depends on ACPI_WMI
 	depends on INPUT
 	select INPUT_SPARSEKMAP
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 41904b1cc284..6e791f9ffc26 100644
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
+	i = 0xff;
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

