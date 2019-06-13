Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD5C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A842080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiFpGG5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393084AbfFMQw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:52:58 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41296 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbfFMDFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:05:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id y185so7714322ywy.8;
        Wed, 12 Jun 2019 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myoxJzu/9GGD8CDA7Jss3DQ4pwILeQvRbCANtsG19pw=;
        b=YiFpGG5M4wKy3HRF/pP5FMtdCciPX4Trjz4ief8Xx5F3YkrXZsv/L9ctZSNUQ/To/m
         auB54GSjyhGZ9k41VPJ1Nm9jExldGaxu7UH3mYpGutyIr2Z2eASpFnWEfQyCdr+1tndx
         pOdoel4EnqFJoQaTZ1toTOJsInMUN1fTrCqBiMBErUas3hrPX3D+jWwl67W2r5ZEt4/z
         71og30607ygiI2uBOEZmOwK7ubFYmIsrLEHhYeVP7DD4E528IjqQc/mreAM956FGvu/6
         Gss6JGyRZEhsrnsZKA+OHJ/QwAAE/oGCME63FRaw0mk97Zq7ZO6uFHxaQcX2G6Ds3zGj
         A+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myoxJzu/9GGD8CDA7Jss3DQ4pwILeQvRbCANtsG19pw=;
        b=EBMkL9+sDW6B5FNHnvlSnDOvDZ5kvQsBTqeCvpII4X1/DvmkETZOvrxMA6n5YVtMqd
         j54Vj9XcwmjXQ7kB+HdTSsyDnAFSKAH8cOHvwK+C/aFmtLpn8PulAzmsFRpo7XruT4Wu
         FhPw78M4QpC56YxLCXGm8g9EhbHke2G3vALFIq9/3e6mqY5xIJMFYZW6rcOE3SY43707
         EjcmxYVaR2iOb7KluUq5jz7NYgMgaGj4wsrtg7k7NltfoiDTDXmZ7+GZ08ggv7Oad1g3
         c+3KKQ/8eHkx/0Lft4gssad3nkwB5ITxaRs9NjAXLF4ehcd/wVhCsCnNnUTUHZnwyZbC
         bU4g==
X-Gm-Message-State: APjAAAWTgNE9E2DG++sTsD145wUkRY0PTJSUvzKak+4zgd80WkaMJ89b
        BQEif3mTsOu1BMwcwWJMpg==
X-Google-Smtp-Source: APXvYqwMfUTh7v1bSfm2TC7qB5zZG+zAFVgIk0L2up9GYpWETsqpYMvG6u6+R0GIT4VLe+Ko9kda9Q==
X-Received: by 2002:a0d:d806:: with SMTP id a6mr45667997ywe.420.1560395102980;
        Wed, 12 Jun 2019 20:05:02 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.05.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:05:02 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 7/8] platform/x86: huawei-wmi: add sysfs interface support
Date:   Wed, 12 Jun 2019 23:04:14 -0400
Message-Id: <20190613030416.25807-9-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Battery charging thresholds and fn-lock are implemented as sysfs
attributes. Both have R/W permissions and set with root permission.
Although using Huawei Management Software in Windows gives access to
these features without admin privileges, user could use something like a
udev rule to change writing permissions of these attributes.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 87 +++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index aac9b80f9976..cc6745ff1bad 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/sysfs.h>
 #include <linux/wmi.h>
 
 /*
@@ -388,6 +389,80 @@ static int huawei_wmi_fn_lock_set(struct device *dev, int on)
 	return huawei_wmi_cmd(dev, *(u64 *)arg, NULL, NULL);
 }
 
+/* sysfs */
+
+static ssize_t charge_thresholds_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, low, high;
+
+	err = huawei_wmi_battery_get(dev, &low, &high);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d %d\n", low, high);
+}
+
+static ssize_t charge_thresholds_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int low, high, err;
+
+	if (sscanf(buf, "%d %d", &low, &high) != 2 ||
+			low < 0 || high > 100 ||
+			low > high)
+		return -EINVAL;
+
+	err = huawei_wmi_battery_set(dev, low, high);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static ssize_t fn_lock_state_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, on;
+
+	err = huawei_wmi_fn_lock_get(dev, &on);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%d\n", on);
+}
+
+static ssize_t fn_lock_state_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int on, err;
+
+	if (kstrtoint(buf, 10, &on) ||
+			on < 0 || on > 1)
+		return -EINVAL;
+
+	err = huawei_wmi_fn_lock_set(dev, on);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(charge_thresholds);
+static DEVICE_ATTR_RW(fn_lock_state);
+
+static struct attribute *huawei_wmi_attrs[] = {
+	&dev_attr_charge_thresholds.attr,
+	&dev_attr_fn_lock_state.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(huawei_wmi);
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -509,8 +584,16 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 	}
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+
 		mutex_init(&huawei->wmi_lock);
 		mutex_init(&huawei->battery_lock);
+
+		err = sysfs_create_group(&pdev->dev.kobj, &huawei_wmi_group);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to create sysfs interface\n");
+			return err;
+		}
+
 		err = huawei_wmi_leds_setup(&pdev->dev);
 		if (err)
 			dev_err(&pdev->dev, "Failed to setup leds\n");
@@ -526,6 +609,10 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 	if (wmi_has_guid(HWMI_EVENT_GUID))
 		wmi_remove_notify_handler(HWMI_EVENT_GUID);
 
+	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		sysfs_remove_group(&pdev->dev.kobj, &huawei_wmi_group);
+	}
+
 	return 0;
 }
 
-- 
2.20.1

