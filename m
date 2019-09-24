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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D720673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e20cDwLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408768AbfIXCtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:49:33 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43620 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfIXCtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:49:33 -0400
Received: by mail-ua1-f68.google.com with SMTP id k24so65983uag.10;
        Mon, 23 Sep 2019 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SpgBpX4VXc2mRrq3Kld275iMD1q97j2KoBSUgiUaAbM=;
        b=e20cDwLuQulr3EXkLtqNnSGh91cTs015w4rrx9g6PBODAPpzrWV/CwELDVjpji6UYW
         wdKYhdg5gq/ae3DQtHrNqAAdijAlwS/+VDUGfOUHrHdcC9mcAtoAmmrLhF51YFkB5Reh
         sBph/q0hLqVoVtCmShzz8Xh+VpKshy+mRD5w8BPPD2Jwd6qyUA9m48WpLXAQJM9ZyIws
         s9txhPT3k5gNjc+VeSKf4p50SmQz5OLU+2JzOKYx6LiaI6xFbCY/OiZArdV9ZXsju5At
         KKV/+3ydHsYwIYUmDOS0MBlXtVVRBw2f68LOq2l+LI0GJXsDgwbzWC8JTA1IbsPaNq7/
         ME6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpgBpX4VXc2mRrq3Kld275iMD1q97j2KoBSUgiUaAbM=;
        b=Em2LHXV8CIaWkwecmVFAKqrjUcTTOiOvl3T0PPBDLrxsQryTEMvJiHWUXesm6Bo8pb
         dGMrPJY/YYnEZYojzV3Do4hxrtJtJhfql3WRSpdB/BcW5SC91dbbtfvDuilWx6kgOets
         q0fU2jGI18iZqQsugbhZYKLmNjdTSGgODotaWNuZppXlgEWIgxs6Uv5wq/eBb+KlFWny
         IY/R5T09mWFdrGyfvwAGrsBMnag4ZJyKOnsc092ZZGmToekzNrVK+Pd9p9E0hEl5AxCW
         PgPEpCz5fOCyJhjO+Ev4TEUDGnL03lwznoN4o83Fazkylv7f3rcUqYThP0fsuBN3+21C
         6YEA==
X-Gm-Message-State: APjAAAW0rm0U73AeLDt47zu5R+PKqlwvOnSZtfQiXDx1tlO4QAc4q0uk
        H+bqPeqXsW+u3GpBHfeBsA==
X-Google-Smtp-Source: APXvYqwriIvpKwx2KyttprFDDg1W8lArz9QEm5aJ2jV7ERsqGdZ9dfjQC7qfN28UPTzs4yMfS+A8Zg==
X-Received: by 2002:ab0:28c4:: with SMTP id g4mr335582uaq.2.1569293371609;
        Mon, 23 Sep 2019 19:49:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id o16sm46547uar.2.2019.09.23.19.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 19:49:31 -0700 (PDT)
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
Subject: [PATCH v5 5/6] platform/x86: huawei-wmi: Add fn-lock support
Date:   Mon, 23 Sep 2019 22:48:10 -0400
Message-Id: <20190924024821.497-6-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924024821.497-1-ayman.bagabas@gmail.com>
References: <20190924024821.497-1-ayman.bagabas@gmail.com>
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
index 6e791f9ffc26..d550c63fcba7 100644
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
+	} while (i < 0xff && !ret[i++]);
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

