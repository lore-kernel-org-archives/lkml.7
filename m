Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788BCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA36206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi9PYp43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGaRxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:53:38 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40535 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfGaRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:53:33 -0400
Received: by mail-yw1-f65.google.com with SMTP id b143so25249472ywb.7;
        Wed, 31 Jul 2019 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCO4bB5RG1i1zaVkyEc6qftvnA4HN0QLB0O4PI95vVE=;
        b=Oi9PYp43hhSDGj6Pl+Nbl3ZXdbcKnXBqlsfWNZ53GxMveGmDH/kzGpsdtWkWtzdy0s
         OzHKylRvNphRRWBOak0gnWmft6TU1IxEYxbTzlu3yUdyFvronv0p0d1yy8OvswIa15Mr
         emMjC4sRUZCm+sao/hmBcXQRv79fyeTnrM5+5o2KIYWSfgq/YddYg96dge+8hYFnUYX3
         hTyj6Dpx06d83Q8j8kiS7rxtgjDWeVsu6B4jo1sESmzeoNYd9wv0cf7DMsKkycjcpqqu
         bmvKtzk43YeUThy2gD34yRWG2KIbXMOr5MFfetLykQW1JYt2LWUA/VdQHu7aBavmwLT9
         jRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCO4bB5RG1i1zaVkyEc6qftvnA4HN0QLB0O4PI95vVE=;
        b=sIVW9w4Il78J7X0w5O0vNCmeETwvUX45k8LSQ87tUtm/Rl3Ia3LVE2HT9Yvagri2d4
         zNOBQK9fulR7xIPHwswmn5f5gM1YxzXHsFd9lZhdTi5Gr7BzqOVM4y8iyEQC1J8UeWs6
         0HxxhfVMJiQFgNdbKgijvbQ9x7zQSJOmmHugh7ayvmq7r67KTdtOSJbDz7YEDUoclBWm
         dXTLypK4aiL3XCCTOciHJjHocFm9B8aZt5pgsq4WN3/KHRGWCMe0DRtpb2l1h56Dn0e7
         SLHeLTZTaXoEdEhE+uUrCK1MnFQ6xuxrxog5ESBClr3C9+qEO25f55+1IpZC3jRJPHEc
         0H/A==
X-Gm-Message-State: APjAAAXmU6QKsRESPcUbnRBcDzZhgltqpd6OcSQpeyqEA1Gh3M+FJ3qQ
        hKKj0GK4npiv5JAKv9119Q==
X-Google-Smtp-Source: APXvYqxXQu/KM/sG9siSkXFwxDRnlm4Sap9pwHPuXLupJo0etFZsC1P95pTWUELx9y29+Tzhp6tKHw==
X-Received: by 2002:a81:3b4a:: with SMTP id i71mr80000529ywa.395.1564595612224;
        Wed, 31 Jul 2019 10:53:32 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w193sm10517294ywa.72.2019.07.31.10.53.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:53:31 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 8/9] platform/x86: huawei-wmi: Add sysfs interface support
Date:   Wed, 31 Jul 2019 13:52:54 -0400
Message-Id: <20190731175255.25676-9-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731175255.25676-1-ayman.bagabas@gmail.com>
References: <20190731175255.25676-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
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


