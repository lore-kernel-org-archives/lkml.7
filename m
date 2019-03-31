Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC859C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E08121841
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6OX7nQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfCaR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:56:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46430 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbfCaRz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:55:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so8866474wrw.13;
        Sun, 31 Mar 2019 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9UieC8SNUHtr0UeIZ9JjjndAyBPlP3CHDw+GpQuyQ5I=;
        b=n6OX7nQWbHuyBNwZpwgnL0yaaLElawzMwPgAY480woNbWmELdlyzuCFjpds6llUXk7
         +fC5sUfuWhbPQgQblHFfH59UDuFQRS2HeR5P+Mhc+KWRhxTLc0skVYNMUIQlfIMXr8nL
         8Wdour4vev3/nRYYT0s70BxYxMl9ZF7Ng6fbI73iCx26Nv9v6InckBlCp7cJvEWBqPtJ
         rI4H3FcryYOblzU5L/C2A7ypXf0mn0dXU0gydLyfg5fpr6M0bEhn2We6m5JRAfwAaZU4
         2qtRHTZCZ842oqTG/BxP/v3lzMAnon0VwvEDhZsD/8XN3xtiQ67pN7YLFnjuu0Nwv/qO
         aHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9UieC8SNUHtr0UeIZ9JjjndAyBPlP3CHDw+GpQuyQ5I=;
        b=rBP0CvFS2ra9K6Q0x155qaxt/UNBWrq0Y0t7Lcx74Kp1irub4ryg7uIvbAisesoqLE
         OITPIlPtpwlK2lPNoWqNt8c8IKLy9NvI0kccFeeRhuVQDme4snps4H6IBjHkfvTO14Kg
         ZiDx9peVbO+J7/M4fuidfKS/atKxBylaGJ+yVnpHnb0x2D0OKoId++KLFz6+3Zf7ZZ0U
         6SCQGMCI+hqlPAynnxbOBbM36bf1Iz9J8dkJU4ljpemw2b59VWgUqxGMGAZ/Ae40v8cE
         Bpa3EWvXj+kS9gRDtU2osRTFgUbZ0v9rkwXabMWxUTuPAWvHBAZ2BhtDTggeqJ/jdCm4
         fGZg==
X-Gm-Message-State: APjAAAWKOwyTdleWqtWwifMbqW7HAWMo4AWGsxU+/YeVTdaqWpuoAJcl
        IiY0u+KjPWpeYLvNWMh1wKw5jWQp
X-Google-Smtp-Source: APXvYqwTRFj7IWGaLQXR5A0hplS0/J57CoVTM2asgDak0/Zaxrp+f3hz8bdoJuG3iGzv0HpkHfqdyw==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr24199773wrn.23.1554054927742;
        Sun, 31 Mar 2019 10:55:27 -0700 (PDT)
Received: from myhost.home (bds153.neoplus.adsl.tpnet.pl. [83.28.4.153])
        by smtp.gmail.com with ESMTPSA id d7sm7473688wmf.31.2019.03.31.10.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:55:27 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 09/25] leds: lt3593: Use generic support for composing LED names
Date:   Sun, 31 Mar 2019 19:54:45 +0200
Message-Id: <20190331175501.23471-10-jacek.anaszewski@gmail.com>
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
Cc: Daniel Mack <daniel@zonque.org>
---
 drivers/leds/leds-lt3593.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
index 83e8e58d81cb..b72752f26b22 100644
--- a/drivers/leds/leds-lt3593.c
+++ b/drivers/leds/leds-lt3593.c
@@ -10,10 +10,10 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <uapi/linux/uleds.h>
+
+#define LED_LT3593_NAME "lt3593"
 
 struct lt3593_led_data {
-	char name[LED_MAX_NAME_SIZE];
 	struct led_classdev cdev;
 	struct gpio_desc *gpiod;
 };
@@ -66,6 +66,7 @@ static int lt3593_led_probe(struct platform_device *pdev)
 	struct lt3593_led_data *led_data;
 	struct fwnode_handle *child;
 	int ret, state = LEDS_GPIO_DEFSTATE_OFF;
+	struct led_init_data init_data;
 	const char *tmp;
 
 	if (!dev->of_node)
@@ -86,14 +87,6 @@ static int lt3593_led_probe(struct platform_device *pdev)
 
 	child = device_get_next_child_node(dev, NULL);
 
-	ret = fwnode_property_read_string(child, "label", &tmp);
-	if (ret < 0)
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593::");
-	else
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593:%s", tmp);
-
 	fwnode_property_read_string(child, "linux,default-trigger",
 				    &led_data->cdev.default_trigger);
 
@@ -102,11 +95,14 @@ static int lt3593_led_probe(struct platform_device *pdev)
 			state = LEDS_GPIO_DEFSTATE_ON;
 	}
 
-	led_data->cdev.name = led_data->name;
 	led_data->cdev.brightness_set_blocking = lt3593_led_set;
 	led_data->cdev.brightness = state ? LED_FULL : LED_OFF;
 
-	ret = devm_led_classdev_register(dev, &led_data->cdev);
+	init_data.fwnode = child;
+	init_data.led_hw_name = LED_LT3593_NAME;
+	init_data.default_label = ":";
+
+	ret = devm_led_classdev_register_ext(dev, &led_data->cdev, &init_data);
 	if (ret < 0) {
 		fwnode_handle_put(child);
 		return ret;
-- 
2.11.0

