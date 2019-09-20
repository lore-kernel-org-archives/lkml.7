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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1AFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525A5206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL/wudyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbfITQER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:04:17 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33475 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387662AbfITQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:04:16 -0400
Received: by mail-yb1-f196.google.com with SMTP id z7so2835293ybg.0;
        Fri, 20 Sep 2019 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hFTvBwgfUH9STxKzxO5lst19eGkZ0SUa5KmMQ8gPWJc=;
        b=EL/wudyG1wF378lU33lu1PQIltktXtNyL93l03GjpKP87yRy37glIbC48zsn9jJGfL
         jdhy5UtGH1lElgPlav6z1ihzO4Id41bvhtVyK5Lq4xZSriWCqZZ8rn4b9rqqbZuRG1rV
         VDoaRfKvUdVWrYmNW5Yw8pbd4EKW8bi4jv07ebpgL7sOwoPiYIF/JywQuJNsGv2nOvt3
         MznZ+c9SDjQiQ/8iJOcnLHXW77iXuR5vz9GKENA9QwKhaasTNxarQ52HRV+dPk5NemgN
         ZEzRf9nWtlZB0Q39c+8xcu2qnsIIjbmcRWktu0p12q8nyT5lFE99nv71AnMKf9Pv6o4D
         A47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFTvBwgfUH9STxKzxO5lst19eGkZ0SUa5KmMQ8gPWJc=;
        b=F8JucA+RMsdC6QiPHcbCLwCNNqEXaQ/3vTebD6JxXFLm365xULsuM2Feukqrl5jivP
         NXItNkOwYop9K1fs0P2nZCtFcosVn6VFFonzBXHi02emVBkriFEgs45zdSTjdT5nMPoy
         YY9pVWcGvrYI4+Bs0XnYn/EOz0x+uTcxywVVtGqe+/dJ04dTwUbSksAQUocm8GI+75GC
         75b9oTt0g2yTlYqS6AszmZpjEyD5aAg/9Goj4GzdkHNQtLYSGeQvpsQyCP2g+q0wQ+6k
         CAZd0VcAvtcqY/Ml5s5EvLwcbVAyGdwbxiQKu6dNYaEoG7bfVprEbAXcxlHFw99gV1xl
         /+Pg==
X-Gm-Message-State: APjAAAVgf2xDcDVSxcvS605l8uWaHwqOXphi16bUExcz3nnWL1Wy6iyH
        HQK/gZ+Umy96/Cu6hijDdg==
X-Google-Smtp-Source: APXvYqxYbKo2+znHlegpWlJsOORlZCZyYD3/Jc+vZranlNmoAeCVjkYNgiX4STkLdkOP6o+CRXxfvw==
X-Received: by 2002:a25:7e81:: with SMTP id z123mr10839615ybc.230.1568995455381;
        Fri, 20 Sep 2019 09:04:15 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id 207sm518086ywu.106.2019.09.20.09.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:04:14 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] platform/x86: huawei-wmi: Add fn-lock support
Date:   Fri, 20 Sep 2019 12:02:38 -0400
Message-Id: <20190920160250.12510-6-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920160250.12510-1-ayman.bagabas@gmail.com>
References: <20190920160250.12510-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huawei Matebook laptops uses Fn key and toggle to access F1-F12 keys.
Along with that, there is this feature called fn-lock that inverts the
behavior of this Fn key and the F1-F12 row.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei-wmi.c | 85 +++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index e577786e6306..56697d49377d 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -54,6 +54,7 @@ static struct quirk_entry *quirks;
 
 struct huawei_wmi {
 	bool battery_available;
+	bool fn_lock_available;
 
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
@@ -509,6 +510,88 @@ static void huawei_wmi_battery_exit(struct device *dev)
 	}
 }
 
+/* Fn lock */
+
+static int huawei_wmi_fn_lock_get(int *on)
+{
+	u8 ret[0x100] = { 0 };
+	int err, i;
+
+	err = huawei_wmi_cmd(FN_LOCK_GET, ret, 0x100);
+	if (err)
+		return err;
+
+	/* Find the first non-zero value. Return status is ignored. */
+	i = 1;
+	do {
+		if (on)
+			*on = ret[i] - 1; // -1 undefined, 0 off, 1 on.
+	} while (i < 0x100 && !ret[i++]);
+
+	return 0;
+}
+
+static int huawei_wmi_fn_lock_set(int on)
+{
+	union hwmi_arg arg;
+
+	arg.cmd = FN_LOCK_SET;
+	arg.args[2] = on + 1; // 0 undefined, 1 off, 2 on.
+
+	return huawei_wmi_cmd(arg.cmd, NULL, 0);
+}
+
+static ssize_t fn_lock_state_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int err, on;
+
+	err = huawei_wmi_fn_lock_get(&on);
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
+	err = huawei_wmi_fn_lock_set(on);
+	if (err)
+		return err;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(fn_lock_state);
+
+static void huawei_wmi_fn_lock_setup(struct device *dev)
+{
+	struct huawei_wmi *huawei = dev_get_drvdata(dev);
+
+	huawei->fn_lock_available = true;
+	if (huawei_wmi_fn_lock_get(NULL)) {
+		huawei->fn_lock_available = false;
+		return;
+	}
+
+	device_create_file(dev, &dev_attr_fn_lock_state);
+}
+
+static void huawei_wmi_fn_lock_exit(struct device *dev)
+{
+	if (huawei_wmi->fn_lock_available)
+		device_remove_file(dev, &dev_attr_fn_lock_state);
+}
+
 /* Input */
 
 static void huawei_wmi_process_key(struct input_dev *idev, int code)
@@ -632,6 +715,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		mutex_init(&huawei_wmi->battery_lock);
 
 		huawei_wmi_leds_setup(&pdev->dev);
+		huawei_wmi_fn_lock_setup(&pdev->dev);
 		huawei_wmi_battery_setup(&pdev->dev);
 	}
 
@@ -651,6 +735,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		huawei_wmi_battery_exit(&pdev->dev);
+		huawei_wmi_fn_lock_exit(&pdev->dev);
 	}
 
 	return 0;
-- 
2.21.0

