Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A73C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E1C20872
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmyUlW07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfCaRzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:55:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43551 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfCaRzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so8883376wrx.10;
        Sun, 31 Mar 2019 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/RfgtwBI+t54Ojdppw2NSkmCK6ohRlVMNRwTukj3Vjc=;
        b=QmyUlW07Kb8FTocRb8/Ven7ojsQUit0VKz/TKrQYhVXyRypO5iEYXtFrFH9xZHvsUh
         zDJ0v+Lf0FEzfCyPxrnhLX6dUjNCtMqSGJF65rI19M3WF0fiqlyxTVnbdMLnrjQWUmzv
         TKNaloUbhqf1XPvTUdgmE643Ti7rTXRhzonDKsrZP8Cwt5vetLYKTC+XNwU5BPLbrpCw
         +UgdI43siqVwi0uGZayvwlDAgPFrB5mqTB6VJSb+0Hn0UWgGpKzl+ZkdQTsUm2nRCAfB
         GUGSN/ocgc2iAONE9ONHBMjGoK9DrWu93COOhb+Y2V8Oi86lBFnInXHGWEOEgJzAr49j
         STdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/RfgtwBI+t54Ojdppw2NSkmCK6ohRlVMNRwTukj3Vjc=;
        b=PPBm/NLpcqUQY62exhk6SZ7L48zt+c7sgf6unjNOyDqfNg6tnwQKpj1dkKBHZ2yrOq
         WQy7hWk0A4e0n4XhrJj38RB6vObzzEn9TQYIYDGYulo0UV0/VcO0+TSiQ2/peNB9LkYw
         0oslfeVDxKdQ+VEQfvCDI4MGThy33lvx9SMYOAYqTR+PIJIHfFROWTfzvKcVeEpvcwdr
         qJspLAifK+jP+zE7CcWrjkNzfA42LywEGQBILCs5bMgTg3IWPr3Ev3s/eZ8r4khF7me8
         u7YV66oyXCBz5Ev32a6IiXy1KBK7/M8SOqLds8W3O9i4nVhHn2WjGMWto/DJI9V5kgEW
         1puw==
X-Gm-Message-State: APjAAAVznz71jPlNX/TomcYk045liYiREvaiR2vUVSu+lhTnwnyLzR/I
        15uw2T9u3IXG7iPmZd/9BGkltvfTGEs=
X-Google-Smtp-Source: APXvYqxTjoC/2gfcQzYX+7k056BXWdnIdH6m70pPVq1Pruhb4LCmsR4fYXiCmLuQe1JaAimkDzwEvQ==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr4046936wrn.273.1554054944021;
        Sun, 31 Mar 2019 10:55:44 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:43 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH v3 19/25] leds: aat1290: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:55 +0200
Message-Id: <20190331175501.23471-20-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
References: <20190331175501.23471-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/leds-aat1290.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-aat1290.c b/drivers/leds/leds-aat1290.c
index 43bd8a43f36c..ba48f2805282 100644
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
+	struct led_init_data init_data = {};
 	struct aat1290_led_config_data led_cfg = {};
 	struct v4l2_flash_config v4l2_sd_cfg = {};
 	int ret;
@@ -497,8 +495,12 @@ static int aat1290_led_probe(struct platform_device *pdev)
 
 	aat1290_init_flash_timeout(led, &led_cfg);
 
+	init_data.fwnode = of_fwnode_handle(sub_node);
+	init_data.led_hw_name = AAT1290_NAME;
+
 	/* Register LED Flash class device */
-	ret = led_classdev_flash_register(&pdev->dev, fled_cdev);
+	ret = led_classdev_flash_register_ext(&pdev->dev, fled_cdev,
+					      &init_data);
 	if (ret < 0)
 		goto err_flash_register;
 
-- 
2.11.0

