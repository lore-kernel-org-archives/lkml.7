Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0CFC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671A520842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0OwbsFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfJBV5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:57:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33850 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfJBV5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:57:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id y35so447584pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=72uuKkThcryWQd8SFJsXSDWZ+q+6121naYFLC9+lzuk=;
        b=l0OwbsFxiSlyUIZ4QdQomoHctqQ4na2ZZUHlQw+W0teG686avDR8VXDrNmvirk5y+a
         FduOf/ivCEGxrSyYpOKd8drib5wIvsQ7qYeTlnELUf9802YDg0pinmVXfFvDzTyDqteV
         ylxPG4XeF1ZR99W/A9XcuasywbGYpNCJdYbi/y079wv9ic2/UhrQmaoYje/FCPYvvLqF
         qWNP4qrMngIOxoh2eUQWuXZepAzRqOQfX3kUKAlDRag+/HKusFp6rOUSHuWSFP8nzFLF
         STL6Ilms+zRtuXtY6lsX53tKt6d2oWhZHS802W9bFEhgNuMIomXggJgUMrNQMA4Uwg8a
         8dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=72uuKkThcryWQd8SFJsXSDWZ+q+6121naYFLC9+lzuk=;
        b=Wgt0X3bCXQSsVoQ+MPXIkjC19BfAydcMs6C8PWPZR5ruk/gXNq3EPhM6qjyOrLC6FA
         tspntI5Xm6j06/6h2in6ZKOqoe3s8W7OmjgXB05L9gZ3aTaVdsn/3t3e9kFL7icjK6cx
         1rqaMW9RRUZpEWZ06N00s+Ipi8Oafmnl6EfMTuAx2p4E8/qu2f7MXDHvKwm7kEFzOzbd
         MHyUjHxO9OIP+uWdZfhXPDBDhI8FPLyw3+/1eNgD1YKheEobvUdlepfhd+Kq4bCg8VwT
         JFPMtvAD4SMApD4yPRgqjWG/0nq7ZO7zAyZhRVGGe4d9HDob4F/iVP673ViPkqUVNN/u
         f7/w==
X-Gm-Message-State: APjAAAWEdtfuJ7yHO2NA8m9UECbzRy/6iE77lLzN3wMtYVM2cIBLPkcQ
        ud1V5GaIsLW+vE5LKy7BG6R74oGR
X-Google-Smtp-Source: APXvYqxJqr02b2WU69kfuOSW1YziwzZNRETkyanAYNEiTOks/K6yYGA1umuDIf8bQCJBTRZy4OS/9Q==
X-Received: by 2002:a62:170b:: with SMTP id 11mr6947759pfx.243.1570053421007;
        Wed, 02 Oct 2019 14:57:01 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x37sm324345pgl.18.2019.10.02.14.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:57:00 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:56:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Eric Piel <eric.piel@tremplin-utc.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lis3lv02d: switch to using input device polling mode
Message-ID: <20191002215658.GA134561@dtor-ws>
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
 drivers/misc/Kconfig               |  1 -
 drivers/misc/lis3lv02d/lis3lv02d.c | 80 ++++++++++++++++--------------
 drivers/misc/lis3lv02d/lis3lv02d.h |  4 +-
 3 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 16900357afc2..02c53b20c632 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -8,7 +8,6 @@ menu "Misc devices"
 config SENSORS_LIS3LV02D
 	tristate
 	depends on INPUT
-	select INPUT_POLLDEV
 
 config AD525X_DPOT
 	tristate "Analog Devices Digital Potentiometers"
diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 057d7bbde402..dd65cedf3b12 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -16,7 +16,7 @@
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-#include <linux/input-polldev.h>
+#include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/poll.h>
@@ -434,23 +434,23 @@ int lis3lv02d_poweron(struct lis3lv02d *lis3)
 EXPORT_SYMBOL_GPL(lis3lv02d_poweron);
 
 
-static void lis3lv02d_joystick_poll(struct input_polled_dev *pidev)
+static void lis3lv02d_joystick_poll(struct input_dev *input)
 {
-	struct lis3lv02d *lis3 = pidev->private;
+	struct lis3lv02d *lis3 = input_get_drvdata(input);
 	int x, y, z;
 
 	mutex_lock(&lis3->mutex);
 	lis3lv02d_get_xyz(lis3, &x, &y, &z);
-	input_report_abs(pidev->input, ABS_X, x);
-	input_report_abs(pidev->input, ABS_Y, y);
-	input_report_abs(pidev->input, ABS_Z, z);
-	input_sync(pidev->input);
+	input_report_abs(input, ABS_X, x);
+	input_report_abs(input, ABS_Y, y);
+	input_report_abs(input, ABS_Z, z);
+	input_sync(input);
 	mutex_unlock(&lis3->mutex);
 }
 
-static void lis3lv02d_joystick_open(struct input_polled_dev *pidev)
+static int lis3lv02d_joystick_open(struct input_dev *input)
 {
-	struct lis3lv02d *lis3 = pidev->private;
+	struct lis3lv02d *lis3 = input_get_drvdata(input);
 
 	if (lis3->pm_dev)
 		pm_runtime_get_sync(lis3->pm_dev);
@@ -461,12 +461,14 @@ static void lis3lv02d_joystick_open(struct input_polled_dev *pidev)
 	 * Update coordinates for the case where poll interval is 0 and
 	 * the chip in running purely under interrupt control
 	 */
-	lis3lv02d_joystick_poll(pidev);
+	lis3lv02d_joystick_poll(input);
+
+	return 0;
 }
 
-static void lis3lv02d_joystick_close(struct input_polled_dev *pidev)
+static void lis3lv02d_joystick_close(struct input_dev *input)
 {
-	struct lis3lv02d *lis3 = pidev->private;
+	struct lis3lv02d *lis3 = input_get_drvdata(input);
 
 	atomic_set(&lis3->wake_thread, 0);
 	if (lis3->pm_dev)
@@ -497,7 +499,7 @@ static irqreturn_t lis302dl_interrupt(int irq, void *data)
 
 static void lis302dl_interrupt_handle_click(struct lis3lv02d *lis3)
 {
-	struct input_dev *dev = lis3->idev->input;
+	struct input_dev *dev = lis3->idev;
 	u8 click_src;
 
 	mutex_lock(&lis3->mutex);
@@ -677,26 +679,19 @@ int lis3lv02d_joystick_enable(struct lis3lv02d *lis3)
 	if (lis3->idev)
 		return -EINVAL;
 
-	lis3->idev = input_allocate_polled_device();
-	if (!lis3->idev)
+	input_dev = input_allocate_device();
+	if (!input_dev)
 		return -ENOMEM;
 
-	lis3->idev->poll = lis3lv02d_joystick_poll;
-	lis3->idev->open = lis3lv02d_joystick_open;
-	lis3->idev->close = lis3lv02d_joystick_close;
-	lis3->idev->poll_interval = MDPS_POLL_INTERVAL;
-	lis3->idev->poll_interval_min = MDPS_POLL_MIN;
-	lis3->idev->poll_interval_max = MDPS_POLL_MAX;
-	lis3->idev->private = lis3;
-	input_dev = lis3->idev->input;
-
 	input_dev->name       = "ST LIS3LV02DL Accelerometer";
 	input_dev->phys       = DRIVER_NAME "/input0";
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->id.vendor  = 0;
 	input_dev->dev.parent = &lis3->pdev->dev;
 
-	set_bit(EV_ABS, input_dev->evbit);
+	input_dev->open = lis3lv02d_joystick_open;
+	input_dev->close = lis3lv02d_joystick_close;
+
 	max_val = (lis3->mdps_max_val * lis3->scale) / LIS3_ACCURACY;
 	if (lis3->whoami == WAI_12B) {
 		fuzz = LIS3_DEFAULT_FUZZ_12B;
@@ -712,17 +707,32 @@ int lis3lv02d_joystick_enable(struct lis3lv02d *lis3)
 	input_set_abs_params(input_dev, ABS_Y, -max_val, max_val, fuzz, flat);
 	input_set_abs_params(input_dev, ABS_Z, -max_val, max_val, fuzz, flat);
 
+	input_set_drvdata(input_dev, lis3);
+	lis3->idev = input_dev;
+
+	err = input_setup_polling(input_dev, lis3lv02d_joystick_poll);
+	if (err)
+		goto err_free_input;
+
+	input_set_poll_interval(input_dev, MDPS_POLL_INTERVAL);
+	input_set_min_poll_interval(input_dev, MDPS_POLL_MIN);
+	input_set_max_poll_interval(input_dev, MDPS_POLL_MAX);
+
 	lis3->mapped_btns[0] = lis3lv02d_get_axis(abs(lis3->ac.x), btns);
 	lis3->mapped_btns[1] = lis3lv02d_get_axis(abs(lis3->ac.y), btns);
 	lis3->mapped_btns[2] = lis3lv02d_get_axis(abs(lis3->ac.z), btns);
 
-	err = input_register_polled_device(lis3->idev);
-	if (err) {
-		input_free_polled_device(lis3->idev);
-		lis3->idev = NULL;
-	}
+	err = input_register_device(lis3->idev);
+	if (err)
+		goto err_free_input;
 
+	return 0;
+
+err_free_input:
+	input_free_device(input_dev);
+	lis3->idev = NULL;
 	return err;
+
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_joystick_enable);
 
@@ -738,8 +748,7 @@ void lis3lv02d_joystick_disable(struct lis3lv02d *lis3)
 
 	if (lis3->irq)
 		misc_deregister(&lis3->miscdev);
-	input_unregister_polled_device(lis3->idev);
-	input_free_polled_device(lis3->idev);
+	input_unregister_device(lis3->idev);
 	lis3->idev = NULL;
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_joystick_disable);
@@ -895,10 +904,9 @@ static void lis3lv02d_8b_configure(struct lis3lv02d *lis3,
 			(p->click_thresh_y << 4));
 
 		if (lis3->idev) {
-			struct input_dev *input_dev = lis3->idev->input;
-			input_set_capability(input_dev, EV_KEY, BTN_X);
-			input_set_capability(input_dev, EV_KEY, BTN_Y);
-			input_set_capability(input_dev, EV_KEY, BTN_Z);
+			input_set_capability(lis3->idev, EV_KEY, BTN_X);
+			input_set_capability(lis3->idev, EV_KEY, BTN_Y);
+			input_set_capability(lis3->idev, EV_KEY, BTN_Z);
 		}
 	}
 
diff --git a/drivers/misc/lis3lv02d/lis3lv02d.h b/drivers/misc/lis3lv02d/lis3lv02d.h
index 1b0c99883c57..c394c0b08519 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.h
+++ b/drivers/misc/lis3lv02d/lis3lv02d.h
@@ -6,7 +6,7 @@
  *  Copyright (C) 2008-2009 Eric Piel
  */
 #include <linux/platform_device.h>
-#include <linux/input-polldev.h>
+#include <linux/input.h>
 #include <linux/regulator/consumer.h>
 #include <linux/miscdevice.h>
 
@@ -281,7 +281,7 @@ struct lis3lv02d {
 					* (1/1000th of earth gravity)
 					*/
 
-	struct input_polled_dev	*idev;     /* input device */
+	struct input_dev	*idev;     /* input device */
 	struct platform_device	*pdev;     /* platform device */
 	struct regulator_bulk_data regulators[2];
 	atomic_t		count;     /* interrupt count after last read */
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
