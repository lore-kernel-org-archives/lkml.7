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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5252ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898212133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti9+bb5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfJASc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:32:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39932 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJASc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:32:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so8659970pff.6;
        Tue, 01 Oct 2019 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LMdi2McCDxZRbLnAN862GjfxKtXUKfDyQePozoGYyBs=;
        b=Ti9+bb5zBdC5dlCGFIxdxeBoDU5fCGmb4wuhM1tvxL4hVUQG+tDO79ExKQoRyWnlco
         BeFUtsFE8BYt+hQfysi8Cy5XSD3lqTAZNC4DP/b4aVEBgcfqNHK8GxtMKyXG23v1bc3I
         XH39eV0sOwkb5bn414EYun6EsqUhTk6vxX0Ty0UJoeCGIowzTDnh4Dn7YaGtxs3L43b/
         P3psXAAatSkQebMjHB47bPYV+9w2cfp2CNSfZYmeSlMHAwm8aZeCKIeEz0jyyEMLPnxd
         VzXDCd1B6D9VUelLzMnDlmfoxhOvCMIBzc0Wd+Z5/1q3VE3OO5A0JKyFEYlo46KA4IFr
         vDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LMdi2McCDxZRbLnAN862GjfxKtXUKfDyQePozoGYyBs=;
        b=n/UJ2alu2TTqgT427tWBfu1zDHARjlKrSUtWQ3m7Bs3H8/zOTRNotRYCCltqZ9KEFv
         WOcyPVi1BFBei/lrZad+g0ERtzjmpXJngIvUfBNw1vaSZUTZ+94EhUmZ8NNIdcj33qCW
         KykxCaNM+w4St7HOBuMflpCNeEVLLQE6RB0iN/ZUh3KPgoN9IwqcBKG3dkiQg9gwMWcQ
         tRkmQI2Ooy6OZk9csgNfWpJ8QXpuNPP3ersJiKHHFt+vnP7eiAK92rgNVJQDNm1UX5T8
         7+vQOLqgEzdHkPbElnUJd6wsGQrLFmwO2U0k39+Z3ZwO37oIhNxr0FS+KHzh98UnEk9j
         B2Jg==
X-Gm-Message-State: APjAAAWD6Bxi2OjR4sSdDP+uV348Xv+ksRE1M3oiGO3nk6I1FWQQ041g
        rvqzTA+XxAvAJERn3bU+JqHSwb2O
X-Google-Smtp-Source: APXvYqzKWSV5NEYPbEjGqCLEeDvVhX8Z538/VlsY/SmWH0FH4C5YS4kzVXj2fhi+LcQ9qw3Hz1QIDQ==
X-Received: by 2002:a17:90a:24a1:: with SMTP id i30mr7490024pje.128.1569954777087;
        Tue, 01 Oct 2019 11:32:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m19sm3146373pjl.28.2019.10.01.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:32:55 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:32:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Frank Seidel <frank@f-seidel.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hdaps: switch to using polled mode of input
 devices
Message-ID: <20191001183253.GA2344@dtor-ws>
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
 drivers/platform/x86/Kconfig |  1 -
 drivers/platform/x86/hdaps.c | 38 +++++++++++++++++-------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

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
index 3adcb0de0193..84d3d0af4e40 100644
--- a/drivers/platform/x86/hdaps.c
+++ b/drivers/platform/x86/hdaps.c
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
