Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379D6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E6A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYqs94DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfDQUzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:55:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33685 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbfDQUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so19949767lfm.0;
        Wed, 17 Apr 2019 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mNUa4Q74sWMlbuA+Luekegt5vyvzTiTnxq6eslLTj90=;
        b=CYqs94DIvyhOxyWuL+5n1naRBj3YTHKETZGTh6iJJ6iwFyDamdrcxFb1lSMs9ZQzZL
         NovmRDf9PzLzfDRzqfWUtd1ZtpjcTwNy3ZCPI3xtVsPbb1qxiQ4YKV9KnY4964XqrEwf
         PfOBwwg7YWS6DPJDzhrwK/akxQE8oMEnMTay076t8YyqMOQofRnM7Qoh8nCzLgxlcGLU
         Rwpl2Lxn5KAgQXTXSQ7KDLD2VcSVTCkM5upXz043mecEFEy1yOwwZvq9G/fIqRVsED8t
         c0ny9P0ooOJ2ViseU10khACnnb8GrOOjbVPCzhoIOVh6+lsXvPcRB2LiR2qFkFKVIIJf
         vGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mNUa4Q74sWMlbuA+Luekegt5vyvzTiTnxq6eslLTj90=;
        b=Qfbdm9MoEAKlHC3/B3oVs3cFcOwz8zIdrq4Gwd/MGyNT01qMmMmQ/rFqGlxostO5ew
         A8Gq3aA2FSYP/s21JZWhamEz/rl8K/P4NpL8G56T5mFHlU/kn5+JjCTGB1e6fH6A5k0C
         2TNe7SPUfTyrsL27Am2Z4LlXW9Fd+GMNJb8bNaPa8mCtsFsNnI0FaWhEJnqRHDZ6bo8B
         5+0WWaD+FozRtRObYVpIpjnZ7OqufPx0u86b5dSQwI3W7kCj71tpj1eLZ+n9EmCCv0Qi
         silYlCJUvlnGEnSjOdEfGUEarNAJNnDOg/ilbF3ZKfNSebwkBaNUyqbsFeIFvmyysbZg
         5+9Q==
X-Gm-Message-State: APjAAAXYbbg1Lm+kmFtFJHGWAN9XFSjMhfhlsBcxglFK8BpaPRJqt7gZ
        V33VuoE0gy99fXEINWyFo6Y23tzu54s=
X-Google-Smtp-Source: APXvYqyLcFwJvjoxVh5RdV1qRfb7bLSxRVq6i3CCLXea28ngPdgoUNgWVUxOppWwaegGPhAT6MVXhQ==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr31432561lfi.46.1555534530937;
        Wed, 17 Apr 2019 13:55:30 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:55:30 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com
Subject: [PATCH v4 20/26] leds: aat1290: Use generic support for composing LED names
Date:   Wed, 17 Apr 2019 22:54:33 +0200
Message-Id: <20190417205439.17685-21-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
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
index 43bd8a43f36c..17d96f055a87 100644
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
+	init_data.devicename = AAT1290_NAME;
+
 	/* Register LED Flash class device */
-	ret = led_classdev_flash_register(&pdev->dev, fled_cdev);
+	ret = led_classdev_flash_register_ext(&pdev->dev, fled_cdev,
+					      &init_data);
 	if (ret < 0)
 		goto err_flash_register;
 
-- 
2.11.0

