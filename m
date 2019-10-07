Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A29ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681EE2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570454475;
	bh=/ew1iTFSPFJl1GZ94sCBI0f4pcTvUs1Ne8ccMb1v1Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7Y4t8VEY4VLpNHnBCWtJcW52kQn+m/T9UlsGKkiJuOk5vtZmRRdnSlWYeMWbK0FG
	 hG9K2j7FSz5JUcpfzKyOTjO+WXskZ0hxlXEV3p9GYtZS5ahqGzjqmb6QjbTrHlDlB2
	 yk6zN7Yzns3SpHyz2tOnswuxQpE/sH2V/XpoH1Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfJGNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:21:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37014 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfJGNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:21:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so9267555lff.4;
        Mon, 07 Oct 2019 06:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GX+ni17mNRYs8d+zDraCFt5XjyO8QrKC7e0GjBCgxpI=;
        b=CHYrG2G8fWBGdJvgo67uDoIed/9CPtwZPTYTNmjRF9kZFAu2rdIFyrO9ixoD1IcKkQ
         kscz1pUoiQxOtb6Cf2hgDC4GEx1X1FENNT7kcdpQpua3+bWbhADJfBCkWizWtzqVko1l
         iMiC+jkj3j++4/Hp3GLOCe145LAefo9txz3HF8RO1iD0up8c1/2mgx+w6fVRxoPvQFeN
         feqCDHrrcSEycsRn0yMjNFqaIVivh8F2Jczw5PfS789CdElZYHk1kK5ekwn14jUvD95W
         DkcA1Vl9p0Bc9k0g5kAI6eKbvRkQkw2L06VIsySsg+5ubrLjXch2QjzzKOYhzN43iBJM
         3wFg==
X-Gm-Message-State: APjAAAV1OPAeKq7h/bhc6hlhHqEsXr4noHt+TorhWL11ZICvPnabg6F4
        +bNxpfWdS0hllHK706GqYKI=
X-Google-Smtp-Source: APXvYqwlE8mz5IqyFoGHNe1iuu0hWCBGRHHravGVWOyYThgV5dMLWivqXmj1Cc/4oxMSs0RrQq+SSg==
X-Received: by 2002:ac2:48af:: with SMTP id u15mr17147302lfg.75.1570454470551;
        Mon, 07 Oct 2019 06:21:10 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id z14sm2687360lfh.30.2019.10.07.06.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:21:09 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Subject: [PATCH v7 3/6] media: ad5820: Add support for enable pin
Date:   Mon,  7 Oct 2019 15:20:44 +0200
Message-Id: <20191007132050.27298-7-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007132050.27298-1-ribalda@kernel.org>
References: <20191007132050.27298-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for a programmable enable pin. It can be used in
situations where the ANA-vcc is not configurable (dummy-regulator), or
just to have a more fine control of the power saving.

The use of the enable pin is optional.

Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/Kconfig  |  2 +-
 drivers/media/i2c/ad5820.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 78dc64d7b0e7..30d460844dff 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -975,7 +975,7 @@ if MEDIA_CAMERA_SUPPORT
 
 config VIDEO_AD5820
 	tristate "AD5820 lens voice coil support"
-	depends on I2C && VIDEO_V4L2 && MEDIA_CONTROLLER
+	depends on GPIOLIB && I2C && VIDEO_V4L2 && MEDIA_CONTROLLER
 	help
 	  This is a driver for the AD5820 camera lens voice coil.
 	  It is used for example in Nokia N900 (RX-51).
diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index 7a49651f4d1f..76aab651f217 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
@@ -47,6 +48,8 @@ struct ad5820_device {
 	u32 focus_ramp_time;
 	u32 focus_ramp_mode;
 
+	struct gpio_desc *enable_gpio;
+
 	struct mutex power_lock;
 	int power_count;
 
@@ -114,6 +117,8 @@ static int ad5820_power_off(struct ad5820_device *coil, bool standby)
 		ret = ad5820_update_hw(coil);
 	}
 
+	gpiod_set_value_cansleep(coil->enable_gpio, 0);
+
 	ret2 = regulator_disable(coil->vana);
 	if (ret)
 		return ret;
@@ -128,6 +133,8 @@ static int ad5820_power_on(struct ad5820_device *coil, bool restore)
 	if (ret < 0)
 		return ret;
 
+	gpiod_set_value_cansleep(coil->enable_gpio, 1);
+
 	if (restore) {
 		/* Restore the hardware settings. */
 		coil->standby = false;
@@ -138,6 +145,7 @@ static int ad5820_power_on(struct ad5820_device *coil, bool restore)
 	return 0;
 
 fail:
+	gpiod_set_value_cansleep(coil->enable_gpio, 0);
 	coil->standby = true;
 	regulator_disable(coil->vana);
 
@@ -304,6 +312,15 @@ static int ad5820_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	coil->enable_gpio = devm_gpiod_get_optional(&client->dev, "enable",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(coil->enable_gpio)) {
+		ret = PTR_ERR(coil->enable_gpio);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&client->dev, "could not get enable gpio\n");
+		return ret;
+	}
+
 	mutex_init(&coil->power_lock);
 
 	v4l2_i2c_subdev_init(&coil->subdev, client, &ad5820_ops);
-- 
2.23.0

