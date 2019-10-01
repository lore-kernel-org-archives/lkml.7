Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F5DECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3D120B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3s1t3zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfJAS7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:59:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40129 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfJAS7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:59:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so8717005pfb.7;
        Tue, 01 Oct 2019 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ue9WEiXN0NY6jDswgxK3rYiIr4dycJEw2xKtEKCD/z8=;
        b=M3s1t3zFecXww+PQpdEj9hd0XoRyPzEauJxiB9xDAAGeokvtFsroHcLMi6FlmBSal1
         scN/7Doijqf+UCHJyMh8Y/YWXq2XYlWvDSSOxS7vDHCYZvavvUCDJdIUS51aVqUqe9Ch
         cIckCNk+oUYsIXExE6e7Mti/9rDNG3weNi/3eJ1uG6K8xUuqG28ozRaJ6GA8Sg8eedYC
         k6wWQbIU2kbkkzEfKhgBRC6TiA+dRiXtAdh/mt4CE1TQOyD1oPdL6SMqt0VBJbLb7qrN
         OBxj2oPof51VrrWYByipmAn/HUL6QFvYB3gqtetHJsZTf6PiomK2ha/LjZgbAO7ZnHdZ
         xNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ue9WEiXN0NY6jDswgxK3rYiIr4dycJEw2xKtEKCD/z8=;
        b=lR9viI4VSgt5+zQoJyHpJa/SMd5gWHlDah5rxz6kDpcV7YaWAjSgFSXoQN6a/9dfyM
         WTiUSDJdUFaYoTg2YSIedjpPNli97SP44CsZdCK+AITkX1mR7s8mcF8lf0Ou6mIiTHTI
         RAZ5LWNKM+BVvZs/XvS6D956LvWJfTmjwjTK8mBPJ1ZEFqQl88PfGrviTtcKLNRWU2e7
         QGguPDEjWHi3bsAV7rPMq1tR65TH+g8+W3d1ggzAJtC/KZEuwMW8May50mLbUKtRbM/6
         XBMaO69PNemU+1cTM/EleRKdX3uCCXd/qG2x6bbbbmQsqFnJoQYuKWvsdvcDEBk+g4rX
         lvCw==
X-Gm-Message-State: APjAAAXwe7o4E54vx+zMaY4X1hgZS419OBHjind5Y15tp7JrAwlnXofG
        ZiVLhMp6ueeQw5TRzY0gA2e7ArCw
X-Google-Smtp-Source: APXvYqwGaaNpiSP++STc8GwOk+gPo2eLlhet3Xal3Q3FslMyU8gafFMdjSh+qkWbZiF6fr+lDW2JcQ==
X-Received: by 2002:a65:64d0:: with SMTP id t16mr32348196pgv.0.1569956380428;
        Tue, 01 Oct 2019 11:59:40 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x10sm26153087pfr.44.2019.10.01.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:59:39 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:59:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Frank Seidel <frank@f-seidel.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: hdaps: switch to using polled mode of input
 devices
Message-ID: <20191001185937.GA49109@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have added polled mode to the normal input devices with the intent of
retiring input_polled_dev. This converts hdaps driver to use the
polling mode of standard input devices and removes dependency on
INPUT_POLLDEV.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: include input.h instead of input-polldev.h

 drivers/platform/x86/Kconfig |  1 -
 drivers/platform/x86/hdaps.c | 40 +++++++++++++++++-------------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c703c78c59f3..8690e311f407 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -622,7 +622,6 @@ config THINKPAD_ACPI_HOTKEY_POLL
 config SENSORS_HDAPS
 	tristate "Thinkpad Hard Drive Active Protection System (hdaps)"
 	depends on INPUT
-	select INPUT_POLLDEV
 	help
 	  This driver provides support for the IBM Hard Drive Active Protection
 	  System (hdaps), which provides an accelerometer and other misc. data.
diff --git a/drivers/platform/x86/hdaps.c b/drivers/platform/x86/hdaps.c
index 3adcb0de0193..04c4da6692d7 100644
--- a/drivers/platform/x86/hdaps.c
+++ b/drivers/platform/x86/hdaps.c
@@ -18,7 +18,7 @@
 
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/input-polldev.h>
+#include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -59,7 +59,7 @@
 #define HDAPS_BOTH_AXES		(HDAPS_X_AXIS | HDAPS_Y_AXIS)
 
 static struct platform_device *pdev;
-static struct input_polled_dev *hdaps_idev;
+static struct input_dev *hdaps_idev;
 static unsigned int hdaps_invert;
 static u8 km_activity;
 static int rest_x;
@@ -318,9 +318,8 @@ static void hdaps_calibrate(void)
 	__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &rest_x, &rest_y);
 }
 
-static void hdaps_mousedev_poll(struct input_polled_dev *dev)
+static void hdaps_mousedev_poll(struct input_dev *input_dev)
 {
-	struct input_dev *input_dev = dev->input;
 	int x, y;
 
 	mutex_lock(&hdaps_mtx);
@@ -531,7 +530,6 @@ static const struct dmi_system_id hdaps_whitelist[] __initconst = {
 
 static int __init hdaps_init(void)
 {
-	struct input_dev *idev;
 	int ret;
 
 	if (!dmi_check_system(hdaps_whitelist)) {
@@ -559,31 +557,32 @@ static int __init hdaps_init(void)
 	if (ret)
 		goto out_device;
 
-	hdaps_idev = input_allocate_polled_device();
+	hdaps_idev = input_allocate_device();
 	if (!hdaps_idev) {
 		ret = -ENOMEM;
 		goto out_group;
 	}
 
-	hdaps_idev->poll = hdaps_mousedev_poll;
-	hdaps_idev->poll_interval = HDAPS_POLL_INTERVAL;
-
 	/* initial calibrate for the input device */
 	hdaps_calibrate();
 
 	/* initialize the input class */
-	idev = hdaps_idev->input;
-	idev->name = "hdaps";
-	idev->phys = "isa1600/input0";
-	idev->id.bustype = BUS_ISA;
-	idev->dev.parent = &pdev->dev;
-	idev->evbit[0] = BIT_MASK(EV_ABS);
-	input_set_abs_params(idev, ABS_X,
+	hdaps_idev->name = "hdaps";
+	hdaps_idev->phys = "isa1600/input0";
+	hdaps_idev->id.bustype = BUS_ISA;
+	hdaps_idev->dev.parent = &pdev->dev;
+	input_set_abs_params(hdaps_idev, ABS_X,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
-	input_set_abs_params(idev, ABS_Y,
+	input_set_abs_params(hdaps_idev, ABS_Y,
 			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
 
-	ret = input_register_polled_device(hdaps_idev);
+	ret = input_setup_polling(hdaps_idev, hdaps_mousedev_poll);
+	if (ret)
+		goto out_idev;
+
+	input_set_poll_interval(hdaps_idev, HDAPS_POLL_INTERVAL);
+
+	ret = input_register_device(hdaps_idev);
 	if (ret)
 		goto out_idev;
 
@@ -591,7 +590,7 @@ static int __init hdaps_init(void)
 	return 0;
 
 out_idev:
-	input_free_polled_device(hdaps_idev);
+	input_free_device(hdaps_idev);
 out_group:
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 out_device:
@@ -607,8 +606,7 @@ static int __init hdaps_init(void)
 
 static void __exit hdaps_exit(void)
 {
-	input_unregister_polled_device(hdaps_idev);
-	input_free_polled_device(hdaps_idev);
+	input_unregister_device(hdaps_idev);
 	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
 	platform_driver_unregister(&hdaps_driver);
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
