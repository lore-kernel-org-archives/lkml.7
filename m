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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3454FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FB0215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beDXTU69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfJAS5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:57:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35279 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJAS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:57:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so8730756pfw.2;
        Tue, 01 Oct 2019 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QMuIShGrKhL+NfsiUAQoYc53XQ6eTBiB5py/hpqNtNU=;
        b=beDXTU69EMupXgVLcmBXNn8h7M4HfzlMU3Gqu2gbhpfFd9AO+8PBBYfnfy7UQJ1BRa
         IdBmKkxIL/YfvkY1500G185pp+LFfW899HZmgZGjFyMOx1GeT3bHyJ1NFsxehzltgY4E
         6DjCKlW7SFFFcUflKh9T3rRdHDAJIbGs2T0ffSXL7Piy2gFOygThZITBuqa9cPWXlC3g
         Ja1U+F2GekrA/ve37501N1w+MSZDL+Z6R91TnczxQLYX+TpJNyso+W8k1ehMcUpx+QaK
         WB6CfC5hr4PqrQqt+y17Dtbmy1t0pI39j73cUqpguGjhuaB8UxG80DynqH+OyHpiwXle
         RsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QMuIShGrKhL+NfsiUAQoYc53XQ6eTBiB5py/hpqNtNU=;
        b=YCPcj3aOo2A/Qfa/C1xiFwmE/kWJuPuZdMvFlsshSXLqV2Nv8Slxa2FkFHbWAwy0Qa
         GaJt7RjsjeLIIv8p7ktQnk8Y3TImLL0a6tNdzX2HR5tuXSIGIjC+kMjejG0DPSKBHOe1
         ciRkImkKFAk6NiAZlX12l6b1wsSQ8efSo/WzrxVNYCZs7Dvv5M0eCd+XFla24UFv2vG4
         MM+CbnnjO7Z5pf2LvbRrgLmzS0RSGvx6O/5+dd8L4ywlPCDY3Df2m/cZvci82D43raAn
         Siqnwm6+EFCDzn0BEU2APAfXTICPIAnxXwxogncY+RbzNRUQfhLals43nToL8kgvZIs+
         vSfA==
X-Gm-Message-State: APjAAAXhRyiGyzF/M6kvxsZ+DwDSE+UTt+8c76A6KR2LgicGz2TbzdGP
        UV9xSE4COZRK60LRMLrLrbU=
X-Google-Smtp-Source: APXvYqyjmj7cP3FSgWUgZFrcbJCTWbfH6ozD+0ThDxLqB2tuKfrLahHyUT4heqIV1AD5dmOLHJK/zQ==
X-Received: by 2002:aa7:92d9:: with SMTP id k25mr29621355pfa.155.1569956223628;
        Tue, 01 Oct 2019 11:57:03 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k15sm18949969pgt.66.2019.10.01.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:57:02 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:57:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net
Subject: [PATCH v2] platform/x86: asus-laptop: switch to using polled mode of
 input devices
Message-ID: <20191001185700.GA46611@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have added polled mode to the normal input devices with the intent of
retiring input_polled_dev. This converts Asus laptop driver to use the
polling mode of standard input devices and removes dependency on
INPUT_POLLDEV.

Also removed no longed needed set_bit(EV_ABS, ...) as
input_set_abs_oarams() does it for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: removed input-polldev.h include

 drivers/platform/x86/Kconfig       |  1 -
 drivers/platform/x86/asus-laptop.c | 71 +++++++++++++++---------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1b67bb578f9f..f0a93f630455 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -94,7 +94,6 @@ config ASUS_LAPTOP
 	depends on RFKILL || RFKILL = n
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	select INPUT_SPARSEKMAP
-	select INPUT_POLLDEV
 	---help---
 	  This is a driver for Asus laptops, Lenovo SL and the Pegatron
 	  Lucid tablet. It may also support some MEDION, JVC or VICTOR
diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 472af7edf0af..fc6446209854 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -34,7 +34,6 @@
 #include <linux/uaccess.h>
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
-#include <linux/input-polldev.h>
 #include <linux/rfkill.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
@@ -244,7 +243,7 @@ struct asus_laptop {
 
 	struct input_dev *inputdev;
 	struct key_entry *keymap;
-	struct input_polled_dev *pega_accel_poll;
+	struct input_dev *pega_accel_poll;
 
 	struct asus_led wled;
 	struct asus_led bled;
@@ -446,9 +445,9 @@ static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
 	return clamp_val((short)val, -PEGA_ACC_CLAMP, PEGA_ACC_CLAMP);
 }
 
-static void pega_accel_poll(struct input_polled_dev *ipd)
+static void pega_accel_poll(struct input_dev *input)
 {
-	struct device *parent = ipd->input->dev.parent;
+	struct device *parent = input->dev.parent;
 	struct asus_laptop *asus = dev_get_drvdata(parent);
 
 	/* In some cases, the very first call to poll causes a
@@ -457,10 +456,10 @@ static void pega_accel_poll(struct input_polled_dev *ipd)
 	 * device, and perhaps a firmware bug. Fake the first report. */
 	if (!asus->pega_acc_live) {
 		asus->pega_acc_live = true;
-		input_report_abs(ipd->input, ABS_X, 0);
-		input_report_abs(ipd->input, ABS_Y, 0);
-		input_report_abs(ipd->input, ABS_Z, 0);
-		input_sync(ipd->input);
+		input_report_abs(input, ABS_X, 0);
+		input_report_abs(input, ABS_Y, 0);
+		input_report_abs(input, ABS_Z, 0);
+		input_sync(input);
 		return;
 	}
 
@@ -471,25 +470,24 @@ static void pega_accel_poll(struct input_polled_dev *ipd)
 	/* Note transform, convert to "right/up/out" in the native
 	 * landscape orientation (i.e. the vector is the direction of
 	 * "real up" in the device's cartiesian coordinates). */
-	input_report_abs(ipd->input, ABS_X, -asus->pega_acc_x);
-	input_report_abs(ipd->input, ABS_Y, -asus->pega_acc_y);
-	input_report_abs(ipd->input, ABS_Z,  asus->pega_acc_z);
-	input_sync(ipd->input);
+	input_report_abs(input, ABS_X, -asus->pega_acc_x);
+	input_report_abs(input, ABS_Y, -asus->pega_acc_y);
+	input_report_abs(input, ABS_Z,  asus->pega_acc_z);
+	input_sync(input);
 }
 
 static void pega_accel_exit(struct asus_laptop *asus)
 {
 	if (asus->pega_accel_poll) {
-		input_unregister_polled_device(asus->pega_accel_poll);
-		input_free_polled_device(asus->pega_accel_poll);
+		input_unregister_device(asus->pega_accel_poll);
+		asus->pega_accel_poll = NULL;
 	}
-	asus->pega_accel_poll = NULL;
 }
 
 static int pega_accel_init(struct asus_laptop *asus)
 {
 	int err;
-	struct input_polled_dev *ipd;
+	struct input_dev *input;
 
 	if (!asus->is_pega_lucid)
 		return -ENODEV;
@@ -499,37 +497,39 @@ static int pega_accel_init(struct asus_laptop *asus)
 	    acpi_check_handle(asus->handle, METHOD_XLRZ, NULL))
 		return -ENODEV;
 
-	ipd = input_allocate_polled_device();
-	if (!ipd)
+	input = input_allocate_device();
+	if (!input)
 		return -ENOMEM;
 
-	ipd->poll = pega_accel_poll;
-	ipd->poll_interval = 125;
-	ipd->poll_interval_min = 50;
-	ipd->poll_interval_max = 2000;
-
-	ipd->input->name = PEGA_ACCEL_DESC;
-	ipd->input->phys = PEGA_ACCEL_NAME "/input0";
-	ipd->input->dev.parent = &asus->platform_device->dev;
-	ipd->input->id.bustype = BUS_HOST;
+	input->name = PEGA_ACCEL_DESC;
+	input->phys = PEGA_ACCEL_NAME "/input0";
+	input->dev.parent = &asus->platform_device->dev;
+	input->id.bustype = BUS_HOST;
 
-	set_bit(EV_ABS, ipd->input->evbit);
-	input_set_abs_params(ipd->input, ABS_X,
+	input_set_abs_params(input, ABS_X,
 			     -PEGA_ACC_CLAMP, PEGA_ACC_CLAMP, 0, 0);
-	input_set_abs_params(ipd->input, ABS_Y,
+	input_set_abs_params(input, ABS_Y,
 			     -PEGA_ACC_CLAMP, PEGA_ACC_CLAMP, 0, 0);
-	input_set_abs_params(ipd->input, ABS_Z,
+	input_set_abs_params(input, ABS_Z,
 			     -PEGA_ACC_CLAMP, PEGA_ACC_CLAMP, 0, 0);
 
-	err = input_register_polled_device(ipd);
+	err = input_setup_polling(input, pega_accel_poll);
 	if (err)
 		goto exit;
 
-	asus->pega_accel_poll = ipd;
+	input_set_poll_interval(input, 125);
+	input_set_min_poll_interval(input, 50);
+	input_set_max_poll_interval(input, 2000);
+
+	err = input_register_device(input);
+	if (err)
+		goto exit;
+
+	asus->pega_accel_poll = input;
 	return 0;
 
 exit:
-	input_free_polled_device(ipd);
+	input_free_device(input);
 	return err;
 }
 
@@ -1550,8 +1550,7 @@ static void asus_acpi_notify(struct acpi_device *device, u32 event)
 
 	/* Accelerometer "coarse orientation change" event */
 	if (asus->pega_accel_poll && event == 0xEA) {
-		kobject_uevent(&asus->pega_accel_poll->input->dev.kobj,
-			       KOBJ_CHANGE);
+		kobject_uevent(&asus->pega_accel_poll->dev.kobj, KOBJ_CHANGE);
 		return ;
 	}
 
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
