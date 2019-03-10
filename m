Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B317C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A0420657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwJ60BcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfCJS32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:29:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34088 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCJS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id f14so2682588wrg.1;
        Sun, 10 Mar 2019 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cl/O8DTygtFJfzNJvUCsSbrxD87UKh7MysQNQV+jXNc=;
        b=IwJ60BcOHmlJd52J+mBqvVzMr3KUg0Ec2HDYkbazfScXE2xHBP/XGXrMnP2rs2cwO+
         CmqOkCarSpaYta3Iinac7onpFsyHThn3H8zZidEN+5DFOTOsOBchdeSC5EbGaGN6K23O
         x08hr1vMGo4nEma/j3pkeDLJVYONOxl94xCrxjY0snZjO1EKjD1IPMflQN0YFdlvhDhs
         o5eqt3dcfEKL8WdmGU8Nx5ssf9zqKxz3fvUkwQCVkz+ghu+/K/w1fccltakOO49LK2ZL
         HOFxdcskC0MAI+Fbg5p6rCBXAmXeUeXQ1FlPftC2VtQzxQO3T2NXICn+EQqUxag0CftR
         e4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cl/O8DTygtFJfzNJvUCsSbrxD87UKh7MysQNQV+jXNc=;
        b=PO/ROcC58BsBHWyYsLU0cMz91/hQMOyN1PEM4jlnNt+OHp+Gac64NTB3/5L6B+33pL
         K7r/3vKaRiYz5b3ckEwjENt3kzd7eh37hCHs0zOJV3MveIjl1U4zk9yHme51QcyGHfhI
         oPYJ92N7xINlSF4EDHpVYxayFuP1Ut63gykYS5cOhlKCXr+Q3+kNH70H0uATFqMhXR2p
         SUeYb22FOR9wvwUJOWxpMaIpIbmlHga0/fjkL4/c/5LaFlyqZOCZtSM7TRQZO85FHV/J
         jl17jhiep68abG5IarTN0kSCOAZaOKiajAFdrtpg+CP0Pz1cuhOjNhoVX1a1r8vZSRhV
         1ZDQ==
X-Gm-Message-State: APjAAAV9UMvcRQ3BH++xbAyYt8J3JAexfbyO0Nwyr7f7OSh/iVVMu6CO
        t4GchD0iYhBA2+WM8NHYLTT34whRYzM=
X-Google-Smtp-Source: APXvYqwcGGGM2BK+0/OPFsEvr8hNd8AyOJCZFH/HOjFhilwH+CS7muAIP5LnUGj82ytJ2RohPtt+iQ==
X-Received: by 2002:adf:dc10:: with SMTP id t16mr18277156wri.40.1552242561942;
        Sun, 10 Mar 2019 11:29:21 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:21 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 19/25] leds: aat1290: Use led_compose_name()
Date:   Sun, 10 Mar 2019 19:28:30 +0100
Message-Id: <20190310182836.20841-20-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/leds-aat1290.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-aat1290.c b/drivers/leds/leds-aat1290.c
index 43bd8a43f36c..9132a6ee551e 100644
--- a/drivers/leds/leds-aat1290.c
+++ b/drivers/leds/leds-aat1290.c
@@ -45,6 +45,8 @@
 #define AAT1290_FLASH_TM_NUM_LEVELS	16
 #define AAT1290_MM_CURRENT_SCALE_SIZE	15
 
+#define AAT1290_NAME			"aat1290"
+
 
 struct aat1290_led_config_data {
 	/* maximum LED current in movie mode */
@@ -78,7 +80,6 @@ struct aat1290_led {
 	int *mm_current_scale;
 	/* device mode */
 	bool movie_mode;
-
 	/* brightness cache */
 	unsigned int torch_brightness;
 };
@@ -218,7 +219,6 @@ static int aat1290_led_parse_dt(struct aat1290_led *led,
 			struct aat1290_led_config_data *cfg,
 			struct device_node **sub_node)
 {
-	struct led_classdev *led_cdev = &led->fled_cdev.led_cdev;
 	struct device *dev = &led->pdev->dev;
 	struct device_node *child_node;
 #if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
@@ -257,9 +257,6 @@ static int aat1290_led_parse_dt(struct aat1290_led *led,
 		return -EINVAL;
 	}
 
-	led_cdev->name = of_get_property(child_node, "label", NULL) ? :
-						child_node->name;
-
 	ret = of_property_read_u32(child_node, "led-max-microamp",
 				&cfg->max_mm_current);
 	/*
@@ -469,6 +466,7 @@ static int aat1290_led_probe(struct platform_device *pdev)
 	struct aat1290_led *led;
 	struct led_classdev *led_cdev;
 	struct led_classdev_flash *fled_cdev;
+	struct led_init_data init_data;
 	struct aat1290_led_config_data led_cfg = {};
 	struct v4l2_flash_config v4l2_sd_cfg = {};
 	int ret;
@@ -488,6 +486,12 @@ static int aat1290_led_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	init_data.fwnode = of_fwnode_handle(sub_node);
+	ret = led_compose_name(init_data.fwnode, AAT1290_NAME, NULL,
+			       init_data.name);
+	if (ret < 0)
+		return ret;
+
 	mutex_init(&led->lock);
 
 	/* Initialize LED Flash class device */
@@ -498,7 +502,8 @@ static int aat1290_led_probe(struct platform_device *pdev)
 	aat1290_init_flash_timeout(led, &led_cfg);
 
 	/* Register LED Flash class device */
-	ret = led_classdev_flash_register(&pdev->dev, fled_cdev);
+	ret = led_classdev_flash_register_ext(&pdev->dev, fled_cdev,
+					      &init_data);
 	if (ret < 0)
 		goto err_flash_register;
 
-- 
2.11.0

