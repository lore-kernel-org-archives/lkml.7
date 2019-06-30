Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C388DC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973A7208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Claumc/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfF3Fly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:54 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41847 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfF3Flv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:51 -0400
Received: by mail-vs1-f65.google.com with SMTP id 2so6745600vso.8;
        Sat, 29 Jun 2019 22:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCO4bB5RG1i1zaVkyEc6qftvnA4HN0QLB0O4PI95vVE=;
        b=Claumc/bSvhmkaPdNUpy8Taf8SARFzxVzvtqYvLmkI2NV4GXM7R2dyhMyHEtq8F+3m
         QA8a7r0Y7kNbRP70KFXgC57/X6IZIIN888k9nUAFdeEMPV0PpZbW0w1j0kGx8VU7Qvjc
         P3GUvKFI/gNV2B3ZkzRHvvKlG04vjmtZbuXb8dtK1rYHrssFUw+icgJMQY+prnr13obe
         fXFSrmsaOccryExTJS+mUzMrgqEhW7gkUrGQlNLI+grA1aMu2aodYNQjvqytvvndPorM
         OI/DkstzT1a2KCgggq2ZWuRIX6suDZUvj+vY7Nl4wbh64fR//iRSEDFKHl71+/qUeMIm
         ligA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCO4bB5RG1i1zaVkyEc6qftvnA4HN0QLB0O4PI95vVE=;
        b=fStxABud1fY0kReOIXkS+1UibCUSydnelDW0JPKQLuXyJwpFyfqf5WQLCzT5J9rBye
         36CrOVggVp+D8//uAqJy8CixFAgNeWESmswGD2sUnwN4L8y2l/nQSrvjtOStdIAhqQ20
         w442F3v8PnJPkeNYhtUQJZ/zh88ZoxLybd5E/z1EGZd+JmYjFlQhv+4upCUQO1U9nsVS
         lN5POixLKTveUwTJwRNYFMDo6tpG/Sdi4OfPKG0urWOygGHuDoqEF+gBDC8cNTCiCVNZ
         aJN+G7+tuRjtIahCDbKqyXSL1iB7/wpfplnZP3sQMwXKR1BtO0CLHoP+u0oOE9EhbqFC
         Y5pQ==
X-Gm-Message-State: APjAAAXiRPBG/cimFre9Q2u/RWQHJAITIc9WV52M84AGw1xpavNx9wfT
        uGoTkk2P+aWaQ/MiTtoE3A==
X-Google-Smtp-Source: APXvYqxzpzthH1VQv9WA2DronCje4ZVLbcQZRCXt43nVNtNZmb/vNqpgGZ88zd8CfHLPLKS4sSUTmg==
X-Received: by 2002:a67:887:: with SMTP id 129mr11361418vsi.82.1561873309837;
        Sat, 29 Jun 2019 22:41:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:49 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 8/9] platform/x86: huawei-wmi: Add sysfs interface support
Date:   Sun, 30 Jun 2019 01:41:07 -0400
Message-Id: <20190630054108.19205-9-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190630054108.19205-1-ayman.bagabas@gmail.com>
References: <20190630054108.19205-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs interface to enable the use of battery charging thresholds and
fn-lock support introduced in this series.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 4159e10bda26..f7041fb71026 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/sysfs.h>
 #include <linux/wmi.h>
 
 /*
@@ -381,6 +382,80 @@ static int huawei_wmi_fn_lock_set(struct device *dev, int on)
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
@@ -508,6 +583,12 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Failed to setup leds\n");
 			return err;
 		}
+
+		err = sysfs_create_groups(&pdev->dev.kobj, huawei_wmi_groups);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to create sysfs interface\n");
+			return err;
+		}
 	}
 
 	return 0;
@@ -522,6 +603,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 		wmi_remove_notify_handler(HWMI_EVENT_GUID);
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
+		sysfs_remove_groups(&pdev->dev.kobj, huawei_wmi_groups);
 	}
 
 	return 0;
-- 
2.20.1

