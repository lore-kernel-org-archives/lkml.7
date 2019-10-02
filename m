Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E94C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8506B207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCmTTtec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfJBVnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:43:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40736 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfJBVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:43:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so398019pgl.7;
        Wed, 02 Oct 2019 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=u/eOIELt7gNata89qdA7zmMkPHM01Dj9Gg56uDrZMFA=;
        b=CCmTTtec1va1iVb0HV1/eXABf8lL94pXkNZ2yrj2BlOxKmIBnCDo35DxtgBIKmBkjH
         50s6k96g3RysSgjrlBe6VxdaiBU3z8tuibr7+htwTvKaw9GgV+R2c4Uft1dLvrJCpvNA
         mE/KVxZSJNajwr31RvfPboz/oykr8eecQyyTbF3DGb9bsjE6EAgbNAbYkXq+sT2RD/62
         mROK7K55bq5yAisgStcCTuHhhM1VdoL76LmZg9GLUwZX1+7AteVNwLrFUkZsrST0qpgg
         D5Qke1fB0MaQ+xs7cvkB1P+HjBPChPa36IfpruGsbf7oeUAc9Rz1DWltsQ84L9D7aLaH
         6cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=u/eOIELt7gNata89qdA7zmMkPHM01Dj9Gg56uDrZMFA=;
        b=GGeQ0OB2wW8MyKHUXqhVXg9MoG8JDnyTCArLYga47aV6K3SYfWybtF8pkFfjuN1bIQ
         du+nZF7O1nA0dwFWyLx2DBeqwP4j2IikPIDZ67ZIXyzSXaQfHIkwjoHSSPuAvlZ18rfU
         OHdbXK5OaxKAEq5epoxZ9eJIV2nsq8TjNeX19XU3Lm1H3ovrTns6KOGnlmEuHGnZcmjY
         ldd+q0m9jol6pVY4HpRo8gokFXzUy/ctvdp9j5ev+i7wqPtJkYdxFuMc5uP2nxMfNdtN
         RTwYi3a2tBtfi+4f8acbEXOgXfbUNZEoBHda0Gko96t4ZOVHJFd9CgqEKCXnEzRrKyKS
         ULiQ==
X-Gm-Message-State: APjAAAUfMS2zcRDbX8OXxRatZX1klJ6gpyPi7mcvfkmIT+8I+g6MbUXf
        ko9d+eb6OJnieSoGWADq7FNs4xPf
X-Google-Smtp-Source: APXvYqwSezL2GXVn3yDFsxyeWzkMcLMsvHxdauwoqgPCKjsK1zNzxmGYwZAaUQeoUzIf9yfnqDa3Gg==
X-Received: by 2002:a63:89c1:: with SMTP id v184mr4903671pgd.326.1570052628814;
        Wed, 02 Oct 2019 14:43:48 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s1sm228200pjs.31.2019.10.02.14.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:43:47 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:43:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Nicolas Boichat <nicolas@boichat.ch>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: applesmc: switch to using input device polling mode
Message-ID: <20191002214345.GA108728@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that instances of input_dev support polling mode natively,
we no longer need to create input_polled_dev instance.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hwmon/Kconfig    |  1 -
 drivers/hwmon/applesmc.c | 38 ++++++++++++++++++--------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 650dd71f9724..c5adca9cd465 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -299,7 +299,6 @@ config SENSORS_APPLESMC
 	depends on INPUT && X86
 	select NEW_LEDS
 	select LEDS_CLASS
-	select INPUT_POLLDEV
 	help
 	  This driver provides support for the Apple System Management
 	  Controller, which provides an accelerometer (Apple Sudden Motion
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 183ff3d25129..ec93b8d673f5 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -19,7 +19,7 @@
 
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/input-polldev.h>
+#include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -140,7 +140,7 @@ static s16 rest_y;
 static u8 backlight_state[2];
 
 static struct device *hwmon_dev;
-static struct input_polled_dev *applesmc_idev;
+static struct input_dev *applesmc_idev;
 
 /*
  * Last index written to key_at_index sysfs file, and value to use for all other
@@ -681,9 +681,8 @@ static void applesmc_calibrate(void)
 	rest_x = -rest_x;
 }
 
-static void applesmc_idev_poll(struct input_polled_dev *dev)
+static void applesmc_idev_poll(struct input_dev *idev)
 {
-	struct input_dev *idev = dev->input;
 	s16 x, y;
 
 	if (applesmc_read_s16(MOTION_SENSOR_X_KEY, &x))
@@ -1134,7 +1133,6 @@ static int applesmc_create_nodes(struct applesmc_node_group *groups, int num)
 /* Create accelerometer resources */
 static int applesmc_create_accelerometer(void)
 {
-	struct input_dev *idev;
 	int ret;
 
 	if (!smcreg.has_accelerometer)
@@ -1144,37 +1142,38 @@ static int applesmc_create_accelerometer(void)
 	if (ret)
 		goto out;
 
-	applesmc_idev = input_allocate_polled_device();
+	applesmc_idev = input_allocate_device();
 	if (!applesmc_idev) {
 		ret = -ENOMEM;
 		goto out_sysfs;
 	}
 
-	applesmc_idev->poll = applesmc_idev_poll;
-	applesmc_idev->poll_interval = APPLESMC_POLL_INTERVAL;
-
 	/* initial calibrate for the input device */
 	applesmc_calibrate();
 
 	/* initialize the input device */
-	idev = applesmc_idev->input;
-	idev->name = "applesmc";
-	idev->id.bustype = BUS_HOST;
-	idev->dev.parent = &pdev->dev;
-	idev->evbit[0] = BIT_MASK(EV_ABS);
-	input_set_abs_params(idev, ABS_X,
+	applesmc_idev->name = "applesmc";
+	applesmc_idev->id.bustype = BUS_HOST;
+	applesmc_idev->dev.parent = &pdev->dev;
+	input_set_abs_params(applesmc_idev, ABS_X,
 			-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
-	input_set_abs_params(idev, ABS_Y,
+	input_set_abs_params(applesmc_idev, ABS_Y,
 			-256, 256, APPLESMC_INPUT_FUZZ, APPLESMC_INPUT_FLAT);
 
-	ret = input_register_polled_device(applesmc_idev);
+	ret = input_setup_polling(applesmc_idev, applesmc_idev_poll);
+	if (ret)
+		goto out_idev;
+
+	input_set_poll_interval(applesmc_idev, APPLESMC_POLL_INTERVAL);
+
+	ret = input_register_device(applesmc_idev);
 	if (ret)
 		goto out_idev;
 
 	return 0;
 
 out_idev:
-	input_free_polled_device(applesmc_idev);
+	input_free_device(applesmc_idev);
 
 out_sysfs:
 	applesmc_destroy_nodes(accelerometer_group);
@@ -1189,8 +1188,7 @@ static void applesmc_release_accelerometer(void)
 {
 	if (!smcreg.has_accelerometer)
 		return;
-	input_unregister_polled_device(applesmc_idev);
-	input_free_polled_device(applesmc_idev);
+	input_unregister_device(applesmc_idev);
 	applesmc_destroy_nodes(accelerometer_group);
 }
 
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
