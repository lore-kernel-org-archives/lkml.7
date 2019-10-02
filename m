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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4030C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ECC218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1o8WyOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfJBVs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:48:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41661 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:48:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so469551plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RFVF+j79EjljD0tVvhEtyc3AyrhKV124n0ydAPhrM+E=;
        b=s1o8WyOSTetOs7i/TyZ7bWKmiE5YytBY8KouyaeIsXVPy+x50AJu4eQwAOPEAb0wAn
         log2uzAGye9wdJeiOONQJkLrpzsYSavLUy644Md7fg0mGPL1xifKeJ288qFu9VzmbxPP
         4pJ3YhTgGh1RV8dbIckfBhTjOXYj7TRoA2laSVfLzmlqAdHqhHzqulJp6lFub9k4kliS
         JlIvvmqUq1gs9RajERkCcphcFACMCT4O7kbgRn+y3tmjaTeS6Go752MPSQPXHwoKA0jN
         IrvZcejgO4hGS3oK+bbaoNEXqcHGiOkSD86NC9AMwQ8kizxeuBOpVi87KUnESeKuvWqo
         KLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RFVF+j79EjljD0tVvhEtyc3AyrhKV124n0ydAPhrM+E=;
        b=ghqbj69lF9F1USHPCMit8e9Zp6r4F0BLv/JdHXflAuANA2FxkF6yfjKdSeiuHOx09t
         9x1lOIrbJB1bq8xc4/5pDyxYCxnH19cM+BxsTsX9SnseWjiE5uI2HJtedCRSEFowYyFJ
         nyWOGUmduoYagw75APDtf/B5t2eWIIWARxnVLo9n5TtopbV2GO2jj869VUBIsupza+T3
         d5Qa+IftjMGe9AS+SRuTlLdNdk8sDv82qgth2fVk9qlYYjFY8Szd3XpK89OVXcMBGeSe
         sNiOSKTYK0YvFCv2zY1jz+1xlXKA+NbyCjz4DSWeXkHTxdHX2G61Q80JI+jV1AoO7jXi
         YHUw==
X-Gm-Message-State: APjAAAVKIyxZyxnewJLOHtsHyO8X+xS64hlxcUlwyCpUHjOAg/3//e8y
        ky2NC0uuO+RShiNFpKHU86k=
X-Google-Smtp-Source: APXvYqxAfLm0/jfISiBS2nvwoxUKwsHgY8bnFrRyuhIUlGQnKXVFONyO3/7Q7F+XLp7oSm2O/fhsaA==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr6197015plc.167.1570052937135;
        Wed, 02 Oct 2019 14:48:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d4sm204525pjs.9.2019.10.02.14.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:48:56 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:48:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh/ams-input: switch to using input device polling
 mode
Message-ID: <20191002214854.GA114387@dtor-ws>
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
 drivers/macintosh/Kconfig         |  1 -
 drivers/macintosh/ams/ams-input.c | 37 +++++++++++++++----------------
 drivers/macintosh/ams/ams.h       |  4 ++--
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 574e122ae105..da6a943ad746 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -247,7 +247,6 @@ config PMAC_RACKMETER
 config SENSORS_AMS
 	tristate "Apple Motion Sensor driver"
 	depends on PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C)
-	select INPUT_POLLDEV
 	help
 	  Support for the motion sensor included in PowerBooks. Includes
 	  implementations for PMU and I2C.
diff --git a/drivers/macintosh/ams/ams-input.c b/drivers/macintosh/ams/ams-input.c
index 06a96b3f11de..0da493d449b2 100644
--- a/drivers/macintosh/ams/ams-input.c
+++ b/drivers/macintosh/ams/ams-input.c
@@ -25,9 +25,8 @@ MODULE_PARM_DESC(invert, "Invert input data on X and Y axis");
 
 static DEFINE_MUTEX(ams_input_mutex);
 
-static void ams_idev_poll(struct input_polled_dev *dev)
+static void ams_idev_poll(struct input_dev *idev)
 {
-	struct input_dev *idev = dev->input;
 	s8 x, y, z;
 
 	mutex_lock(&ams_info.lock);
@@ -59,14 +58,10 @@ static int ams_input_enable(void)
 	ams_info.ycalib = y;
 	ams_info.zcalib = z;
 
-	ams_info.idev = input_allocate_polled_device();
-	if (!ams_info.idev)
+	input = input_allocate_device();
+	if (!input)
 		return -ENOMEM;
 
-	ams_info.idev->poll = ams_idev_poll;
-	ams_info.idev->poll_interval = 25;
-
-	input = ams_info.idev->input;
 	input->name = "Apple Motion Sensor";
 	input->id.bustype = ams_info.bustype;
 	input->id.vendor = 0;
@@ -75,28 +70,32 @@ static int ams_input_enable(void)
 	input_set_abs_params(input, ABS_X, -50, 50, 3, 0);
 	input_set_abs_params(input, ABS_Y, -50, 50, 3, 0);
 	input_set_abs_params(input, ABS_Z, -50, 50, 3, 0);
+	input_set_capability(input, EV_KEY, BTN_TOUCH);
 
-	set_bit(EV_ABS, input->evbit);
-	set_bit(EV_KEY, input->evbit);
-	set_bit(BTN_TOUCH, input->keybit);
+	error = input_setup_polling(input, ams_idev_poll);
+	if (error)
+		goto err_free_input;
 
-	error = input_register_polled_device(ams_info.idev);
-	if (error) {
-		input_free_polled_device(ams_info.idev);
-		ams_info.idev = NULL;
-		return error;
-	}
+	input_set_poll_interval(input, 25);
 
+	error = input_register_device(input);
+	if (error)
+		goto err_free_input;
+
+	ams_info.idev = input;
 	joystick = true;
 
 	return 0;
+
+err_free_input:
+	input_free_device(input);
+	return error;
 }
 
 static void ams_input_disable(void)
 {
 	if (ams_info.idev) {
-		input_unregister_polled_device(ams_info.idev);
-		input_free_polled_device(ams_info.idev);
+		input_unregister_device(ams_info.idev);
 		ams_info.idev = NULL;
 	}
 
diff --git a/drivers/macintosh/ams/ams.h b/drivers/macintosh/ams/ams.h
index fe8d596f9845..935bdd9cd9a6 100644
--- a/drivers/macintosh/ams/ams.h
+++ b/drivers/macintosh/ams/ams.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/i2c.h>
-#include <linux/input-polldev.h>
+#include <linux/input.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -51,7 +51,7 @@ struct ams {
 #endif
 
 	/* Joystick emulation */
-	struct input_polled_dev *idev;
+	struct input_dev *idev;
 	__u16 bustype;
 
 	/* calibrated null values */
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
