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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253B5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41B221907
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8+4qccv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394497AbfITAkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:40:55 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33307 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbfITAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:40:55 -0400
Received: by mail-yw1-f68.google.com with SMTP id i188so1524035ywf.0;
        Thu, 19 Sep 2019 17:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aQSk775q1feKYpb6MaNUDEQvmeqn7p7J8OSj2R1kBy4=;
        b=V8+4qccvfb89IgNf3gbjHpacnjCwTr5vF2zJAEmZ0zkPYHvUww0DMQFBCKT1lN9+im
         N1N2OibxW5fyhYjjSX+sPKMLT/55da1hy4N2RsCWmfs1SOc7MLy7YrlwjvTQ/ZsHNe4Z
         ekAGHGYvXvss/z5jOdQIYu9MoML46mI4byjDx6+pfZWBl3LYnfzdU38F+h1izWZDbLJG
         YTKGy+gnqU0Jz9+2MVWguzm9VY4a+bcbd0w0bQZJR+bek+ZlHjCNpXB8NREwrYgzgBqn
         oWEnNI31kTduaGHI+nG/F/wVcyrbEfrO0dDszMmopISiBgNN3u1Q6RUJFPsVNGKO76h5
         4Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQSk775q1feKYpb6MaNUDEQvmeqn7p7J8OSj2R1kBy4=;
        b=ffbefuML+sPgDvcPC3LQvF1atcVSNcXhwi6xNHegDeMgCSztgeXEqzkzu+/9RU5vPZ
         4hCqM8Z8AdMHbVn8i9Cyn0Gp44jQZ0+G/qlw3Z0oQUkdwLN5CAbHwOPecfkLYgz1mSaM
         /Dav47/TX6sROCZZMKzWxyo+WkGz74cjIKDqkt5aWMMRLn3MLlxSwaIYIsCxFZOdBCXO
         DAe3zJnnfQ+ypMZyYwpy/KEdPKNeL/rOHyCsZlqdBlPBd+U/acvt+NsfzFeGjxHj5tEZ
         R57QBgeR/B8oQzGkMwVrqIdhyJIv5TzcJNB/gEpXOWjyRcUjFon84RRgus+jJKeGRpq9
         NX5g==
X-Gm-Message-State: APjAAAUrqHkecAeAdI2/WhVWfAVAomk74dLEivcOSJjfwS5DGLvjN1Ue
        STazhoQuxKlf5MS35Rv5EA==
X-Google-Smtp-Source: APXvYqy5mCZ791yHnhfT2O8o8iYehWvwyPf+Y9pE/iSuyebRfrl0y3AwTnNtsNrUlXDASrc9iieyUQ==
X-Received: by 2002:a81:2b54:: with SMTP id r81mr10547277ywr.163.1568940054097;
        Thu, 19 Sep 2019 17:40:54 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id r63sm102802ywg.36.2019.09.19.17.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 17:40:53 -0700 (PDT)
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
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] platform/x86: huawei-wmi: Add fn-lock support
Date:   Thu, 19 Sep 2019 20:39:10 -0400
Message-Id: <20190920003938.21617-6-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920003938.21617-1-ayman.bagabas@gmail.com>
References: <20190920003938.21617-1-ayman.bagabas@gmail.com>
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
index 4ca1a6896766..8fc11a296357 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -59,6 +59,7 @@ struct huawei_wmi_debug {
 
 struct huawei_wmi {
 	bool battery_available;
+	bool fn_lock_available;
 
 	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
@@ -515,6 +516,88 @@ static void huawei_wmi_battery_exit(struct device *dev)
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
@@ -638,6 +721,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 		mutex_init(&huawei_wmi->battery_lock);
 
 		huawei_wmi_leds_setup(&pdev->dev);
+		huawei_wmi_fn_lock_setup(&pdev->dev);
 		huawei_wmi_battery_setup(&pdev->dev);
 	}
 
@@ -657,6 +741,7 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 
 	if (wmi_has_guid(HWMI_METHOD_GUID)) {
 		huawei_wmi_battery_exit(&pdev->dev);
+		huawei_wmi_fn_lock_exit(&pdev->dev);
 	}
 
 	return 0;
-- 
2.21.0

