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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2445C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649E72168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvEJ6IYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfJAS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:29:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41864 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJAS3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:29:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so8648998pfh.8;
        Tue, 01 Oct 2019 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ja9C7M5sFJjoPKU4RR/Wi/K8l9IsDkFus8luOrSez3g=;
        b=NvEJ6IYsI8JNz/qRxedwgpW6PcfOMYLQasklUAkdS2Z0ykPRFweDnQS9zHNfyz3Zzf
         KYnnFDz+Yz9U6k5Ee0IP1jQI6TiNixz5Rorv5MxLLz2tbcnPolUHPtDyDHYhWN8JA9D5
         e7elZXs2H7nUDJpKbAMog8X52lbaAu4oiENnHKgsBR9Dn5oeUq5Q9wlZ+H1H6yx7Bj9h
         D1eoOiAP2lQ3CyC/SSsYdsIcmDUbHd/GumDbgD2icRDRmPl7eUN/cm4ZMCmDYrzSkdm6
         ynIdJ2088kPv7uH4d1tI494YX+DGP6y4fbu9qjmzlxW0HrOMI78C6GEfBdtLLL+wdJ5Z
         aOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ja9C7M5sFJjoPKU4RR/Wi/K8l9IsDkFus8luOrSez3g=;
        b=TUm3qvLvwaAk3kQInbr7dJJRYjfvY7QqfGcy0gfdp+CVBqCoqDBZjDG2rgewN8PDxA
         gDKy3HuVJoqhz4uU8/jhCKCVl5bGIDSg5vea1VyGw6+YGxndjmu1g+K9PvD6xhecH7Gf
         ux+D8w/hhXJi/XMtmo7hgXTf9usSdHXyJQYHmtRBYWV9noofUHbYotZG8+XGygXU+Wq7
         bt2xYS4+kJ6tBQ5lm8AGx4jZTePgI9dIAtGjaGGqainFdb9jkssQS5PSLkXB05oaf8PW
         QN6YsUircP8xBEYwaE2Zy61vLqwbc5x2g/Eht115fx06sfA5VEpVq2ig8yFXFRZeJdXv
         9DNg==
X-Gm-Message-State: APjAAAUI7QH/KnK5ajTzIfoIrcULk51cykiKYm5Af6pYYxWpmiKZ1YzD
        S71L6Xzrc3YQf19QlE2PBX8L/7OH
X-Google-Smtp-Source: APXvYqyZV01Wif1VcyCXD8ruBQ6Jh5eygEXOsJIeQztQ51OcTUeQbA4pJ1IqES/tpVDO6dSt3bIjzQ==
X-Received: by 2002:aa7:9e05:: with SMTP id y5mr30491157pfq.38.1569954548966;
        Tue, 01 Oct 2019 11:29:08 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k5sm26262875pfp.109.2019.10.01.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:29:08 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:29:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net
Subject: [PATCH] platform/x86: asus-laptop: switch to using polled mode of
 input devices
Message-ID: <20191001182905.GA260106@dtor-ws>
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
input_set_abs_params() does it for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/Kconfig       |  1 -
 drivers/platform/x86/asus-laptop.c | 70 +++++++++++++++---------------
 2 files changed, 35 insertions(+), 36 deletions(-)

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
index 472af7edf0af..537e5f6f16d3 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -244,7 +244,7 @@ struct asus_laptop {
 
 	struct input_dev *inputdev;
 	struct key_entry *keymap;
-	struct input_polled_dev *pega_accel_poll;
+	struct input_dev *pega_accel_poll;
 
 	struct asus_led wled;
 	struct asus_led bled;
@@ -446,9 +446,9 @@ static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
 	return clamp_val((short)val, -PEGA_ACC_CLAMP, PEGA_ACC_CLAMP);
 }
 
-static void pega_accel_poll(struct input_polled_dev *ipd)
+static void pega_accel_poll(struct input_dev *input)
 {
-	struct device *parent = ipd->input->dev.parent;
+	struct device *parent = input->dev.parent;
 	struct asus_laptop *asus = dev_get_drvdata(parent);
 
 	/* In some cases, the very first call to poll causes a
@@ -457,10 +457,10 @@ static void pega_accel_poll(struct input_polled_dev *ipd)
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
 
@@ -471,25 +471,24 @@ static void pega_accel_poll(struct input_polled_dev *ipd)
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
@@ -499,37 +498,39 @@ static int pega_accel_init(struct asus_laptop *asus)
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
 
@@ -1550,8 +1551,7 @@ static void asus_acpi_notify(struct acpi_device *device, u32 event)
 
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
