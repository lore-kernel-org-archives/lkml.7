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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200D2C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E986F2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHXWTh2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfFMQxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:53:18 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35343 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbfFMDFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:05:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id k128so7722218ywf.2;
        Wed, 12 Jun 2019 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=maWSYYRrvybYLk/ZwWvDJFQUXbxnczUBvQ66MuAR1dc=;
        b=VHXWTh2mZ0oAsXy17t6u1QflJMPukrCoBzvL9WuTHC8D+AHupnXjAB/LeT3RpTZ3sC
         iOOEwf8Xi3ADTgIWVAQ+8Gg9wrhOeWRCnJS/JaTUIDbTpkNwVAmrU2hj8hYHGistWht3
         er3TxXYJgi5K32kJbaKxmqYfiK2487FfbqBsYm8esStBaNxAyQbemBSdYVFQmRuleyoO
         QEVFbQ6U5vtVmQsM6MqUSUFvnJRybJ9bHy8kr77e7w5q2l7maA6lpYR4XjzxFfsMqOeu
         Ie9LqaGuRQTVk7DYW5FbLovrMyQ0ijYjhmXY104yCkm9bpePQevfjtMW19yH7HTBbkaP
         LPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=maWSYYRrvybYLk/ZwWvDJFQUXbxnczUBvQ66MuAR1dc=;
        b=T/piU1+rcSNXmHeQOGuadLDC6xQFpY9Sinhqalj9OnnRFI+LITHzoVM6NCObwBzF2N
         m+q6BOT3cBKLTslEXzR7W1KhDsZZcFtHKM7wss1ixI/4d2atnJBTxL94L8a0K8d9q70m
         jyHgJgkgjvxBNt3QKzAhuUlImLXw2iqvdNB+HHRqxyvMD2ECIxT4nskh7kaxe9gRZfLo
         V3mK8WbIz1j7E14L5k9M0NOYx+cEk5MFK0zSI1rS6nr8B0z1DpQzS4rKjADsyc/WvyeS
         NiIxiSGwRs7PH3fGr16oWbkTqTb3gkYQXeUcPbl23wJ+cmHY305ttftZ91oL5g5RTZpG
         4LSA==
X-Gm-Message-State: APjAAAWK56vdmr3U9I0YQ4TDnE5xMgyj+shpx/F2W4Qg3+WqbRQ99wOs
        kHEdJV7paB3BISxVELW2mg==
X-Google-Smtp-Source: APXvYqwalc9ioEK569U58MgtvdylDr75TJ1pfhNP9M1+ymoS432VWYMQYU2WFK7KGp9WIIZ1vRywXQ==
X-Received: by 2002:a81:4786:: with SMTP id u128mr46699794ywa.43.1560395100453;
        Wed, 12 Jun 2019 20:05:00 -0700 (PDT)
Received: from 960.localdomain ([71.46.56.3])
        by smtp.gmail.com with ESMTPSA id j184sm424831ywf.8.2019.06.12.20.04.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:05:00 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v2 5/8] platform/x86: huawei-wmi: add battery charging protection support
Date:   Wed, 12 Jun 2019 23:04:12 -0400
Message-Id: <20190613030416.25807-7-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some models that implement the new WMI management interface can control
battery charging thresholds where it limits charging the battery once it
reaches certain thresholds. This feature is not present in MateBook X
(2017).

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 56 +++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 358d9d168300..06d83e613504 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
@@ -48,6 +49,7 @@ struct huawei_wmi {
 	struct led_classdev cdev;
 	struct input_dev *idev[2];
 	struct mutex wmi_lock;
+	struct mutex battery_lock;
 	struct platform_device *pdev;
 };
 
@@ -302,6 +304,59 @@ static int huawei_wmi_leds_setup(struct device *dev)
 	return devm_led_classdev_register(dev, &huawei->cdev);
 }
 
+/* Battery protection */
+
+static int huawei_wmi_battery_get(struct device *dev, int *low, int *high)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+	u8 ret[0x100];
+	int err, i;
+
+	mutex_lock(&huawei->battery_lock);
+	err = huawei_wmi_cmd(dev, BATTERY_THRESH_GET, ret, 0x100);
+	mutex_unlock(&huawei->battery_lock);
+	if (err) {
+		return err;
+	}
+
+	/* Find the last two non-zero values. Return status is ignored. */
+	i = 0x100;
+	do {
+		*low = ret[i-1];
+		*high = ret[i];
+	} while (i > 2 && !ret[i--]);
+
+	return 0;
+}
+
+static int huawei_wmi_battery_set(struct device *dev, int low, int high)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+	u8 arg[8];
+	int err;
+
+	*(u64 *)arg = BATTERY_THRESH_SET;
+	arg[2] = low;
+	arg[3] = high;
+
+	/* This is an edge case were some models turn battery protection
+	 * off without changing their thresholds values. We clear the
+	 * values before turning off protection. Sometimes we need a sleep delay to
+	 * make sure these values make their way to EC memory.
+	 */
+	if (low == 0 && high == 100) {
+		huawei_wmi_battery_set(dev, 0, 0);
+	}
+
+	mutex_lock(&huawei->battery_lock);
+	err = huawei_wmi_cmd(dev, *(u64 *)arg, NULL, NULL);
+	if (quirks && quirks->battery_sleep)
+		msleep(1000);
+	mutex_unlock(&huawei->battery_lock);
+
+	return err;
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -424,6 +479,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		mutex_init(&huawei->wmi_lock);
+		mutex_init(&huawei->battery_lock);
 		err = huawei_wmi_leds_setup(&pdev->dev);
 		if (err)
 			dev_err(&pdev->dev, "Failed to setup leds\n");
-- 
2.20.1

