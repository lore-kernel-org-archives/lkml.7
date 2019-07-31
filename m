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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F4C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DC3206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPdCfARi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfGaRxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:53:54 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40535 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbfGaRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:53:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id b143so25249430ywb.7;
        Wed, 31 Jul 2019 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4B7kxSwn+Y6/oG1SY2GzSzP2SB2pWwxeXqv90tBjdMY=;
        b=WPdCfARiuE/+FieBaeEbT9g9k7rBNDO1TEU1Cy2KOqt+f/g/HD+V3Errd+85gJBSBi
         UKERBgBCWu9KRovzNAuYwBayKOe8Zs4Sf+gza/QxgNuylDnl0gLfLufuEdqA6F5q1zII
         lHLsxHxKP+/PtcGTTAkwWiTUCalSm8H9yjjFjN9DOwZyvehEEFgHTocaXBc2BC/PWSmP
         hyHqmuoT6YcpHZ5Z/Pr+5GSIkNJP8rEMSrIp81yZgMXmij26ab+gzIoCiXotMzQIPdFh
         gf9CrDxECfMn6/xwYKo163IZQjADURPnqkwatET3bpxvT03PppdPCUITp01YU2KsLsK7
         U4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4B7kxSwn+Y6/oG1SY2GzSzP2SB2pWwxeXqv90tBjdMY=;
        b=C0ScOOjhDFvZsKFqNyqrb9Lz9W80WxyGsedEGZcEwlYq5RRmkcQJRBVWZgCTs+z3Ga
         WvTp8DFk6MBQpJqHHmrK8zkoA0UleLEzrjlWkdBdTOUSXyg1zNTnDXRfwtKOqnj+3AzX
         sNb640of1I7iPQj/wDNOzWDsue6tldpfFLXR7rxxXtdoRiMUwRe6X4ekHxmm+UaK4Nvg
         X3Db/5hsOISWM5krf1ILWKcyuwuiS3wGuSkpMg+/qLRO5mTWq0fAVPq+ZbI+YLhIqojp
         Y31ITQsOj0orntWVj12JKGFvvEUKmr7K3xyoDaqx/pGv/yWK6oYADSwdTmJgb4ucQ6fW
         KUAQ==
X-Gm-Message-State: APjAAAVwwalhT+BTkAbnjfPYHRg+vs+O3n5jAYS8GkZNRb4wtVLuFqok
        Ilo3PJwg74f/7nS8yDHymw==
X-Google-Smtp-Source: APXvYqxQWi9XR3MxBQ8RjOAMiby7njxIJdp2+VJ/SxtuAxUx0hoOPljgoBq9QMoYKiiuk1bWJVcd+w==
X-Received: by 2002:a81:7b89:: with SMTP id w131mr76298619ywc.462.1564595609261;
        Wed, 31 Jul 2019 10:53:29 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id w193sm10517294ywa.72.2019.07.31.10.53.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:53:28 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [RFC 6/9] platform/x86: huawei-wmi: Add battery charging thresholds
Date:   Wed, 31 Jul 2019 13:52:52 -0400
Message-Id: <20190731175255.25676-7-ayman.bagabas@gmail.com>
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

Implement battery charging thresholds functionality to be used with
sysfs interface support that is implemented in this series.

Setting battery charging thresholds can introduce a race condition where
two are trying to read/write values from/to EC memory. Even though a
mutex is used, this doesn't guarantee that these values will make it to
EC so a blocking sleep is necessary.

This sleep is enforced on the MACH-WX9 model since turning off battery
protection using (0,100) doesn't change the values in the EC memory,
instead it only disables the protection. So a workaround is to set the
thresholds to (0,0) before setting it to (0,100). This will ensure
that we update these values in EC memory and then turning it off with
(0,100). Thus, the msleep(1000).

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
In huawei_wmi_battery_get and later in huawei_wmi_fn_lock_get, 256 bytes
buffer is allocated dynamically on the stack. Now I know this is
discouraged, should it be changed to use kmalloc?

 drivers/platform/x86/huawei-wmi.c | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 9013a05d2832..da3986cd0428 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
@@ -46,6 +47,7 @@ static struct quirk_entry *quirks;
 struct huawei_wmi_priv {
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
+	struct mutex battery_lock;
 	struct mutex wmi_lock;
 	struct platform_device *pdev;
 };
@@ -298,6 +300,57 @@ static int huawei_wmi_leds_setup(struct device *dev)
 	return devm_led_classdev_register(dev, &priv->cdev);
 }
 
+/* Battery protection */
+
+static int huawei_wmi_battery_get(struct device *dev, int *low, int *high)
+{
+	struct huawei_wmi_priv *priv = dev_get_drvdata(dev);
+	u8 ret[0x100];
+	int err, i;
+
+	mutex_lock(&priv->battery_lock);
+	err = huawei_wmi_cmd(dev, BATTERY_THRESH_GET, ret, 0x100);
+	mutex_unlock(&priv->battery_lock);
+	if (err)
+		return err;
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
+	struct huawei_wmi_priv *priv = dev_get_drvdata(dev);
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
+	if (low == 0 && high == 100)
+		huawei_wmi_battery_set(dev, 0, 0);
+
+	mutex_lock(&priv->battery_lock);
+	err = huawei_wmi_cmd(dev, *(u64 *)arg, NULL, NULL);
+	if (quirks && quirks->battery_sleep)
+		msleep(1000);
+	mutex_unlock(&priv->battery_lock);
+
+	return err;
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -418,6 +471,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		mutex_init(&priv->wmi_lock);
+		mutex_init(&priv->battery_lock);
 
 		err = huawei_wmi_leds_setup(&pdev->dev);
 		if (err) {
-- 
2.20.1


