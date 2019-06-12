Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD9C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0F820874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 04:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNVDRmDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfFLEch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 00:32:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45392 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfFLEcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 00:32:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id bi6so5668122plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 21:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Gi3mDxR3p0ZPS7IaY56ES2NCsCqRSQPkF06LoVX96Pc=;
        b=gNVDRmDWh7hw7//+H/pAoGU2CxvTHA3HycQQbqtGp5BpLIWi2rFWt23NR+vsdCm47y
         VZkHvvBIAXRWRrljCpcXkFSq/LBaVsjsdPimT8cbgglWabfWGiXOASXYsyio5qRY4Fdo
         Wc9n1nFKaVKFk14hlPRF1NaxmNhzqUDcZy4Nq38mlqe5Lslww7cPOfeR58sepMbv7cbN
         KqJK+DKX2HOady+ZUed7Ft50ECiKOeJUCKvM7UEBi7D/xzThzNndIyGYOPxVIxTUciQD
         m3ZAIkdMPGkmDrKCTaO60cLzpB05ycGsj/z8xndtJHy7sci2W1Hcdu3LtqgkVw+marwK
         6Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Gi3mDxR3p0ZPS7IaY56ES2NCsCqRSQPkF06LoVX96Pc=;
        b=UKn76lcBjJEVXQHJUq9KWMTBltO9Esn4u6Um5qcVMwR6xpPVkgyOqSDPRVbzlebvoU
         7eCO1iXsKYVjy4jRUB/RJylR1UqWbr21qyPs6LVoJJ8ycUhyxDLfThY9U22/TENrB2Vo
         yFaHjFZRyQLC/Ki05kC5CCw8YQ3qkhlu0Q6/J1Iho3YEz5X3MyxS4d+qpQl5zxL4oKR2
         BHihJtCwQ/HKT2StX8WS8fCJCkVX5UuiQPXSLvYroncqSzhOVSp3YVLFGXRs1CZ2z4ME
         7DaCOX6Mqc+WbNdboWzPjKdTB7fxefZwngPmF/XpC7b1+/ujHTE3Hg13lNC9qFtXO8NB
         e51g==
X-Gm-Message-State: APjAAAWuulEON03XtoatpUsHTDIGCppr8hkHt6U5AxXp4q6ddE+pJ5cn
        sfIKFAo2hXEqBKke4s4VRPY=
X-Google-Smtp-Source: APXvYqyeuILtzaoARRnenHNmShOEyKE52XbGxT5jLX6IelfR3GZQa2gB2Eo7nRtKHLFuooXYKI2Dtw==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr79707494pld.284.1560313955774;
        Tue, 11 Jun 2019 21:32:35 -0700 (PDT)
Received: from t-1000 ([185.245.87.246])
        by smtp.gmail.com with ESMTPSA id g13sm17479422pfi.93.2019.06.11.21.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 21:32:34 -0700 (PDT)
Date:   Tue, 11 Jun 2019 21:32:32 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     shobhitkukreti@gmail.com
Subject: [PATCH] video: backlight: Replace old GPIO APIs with GPIO Consumer
 APIs for sky81542-backlight driver
Message-ID: <20190612043229.GA18179@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port the sky81452-backlight driver to adhere to new gpio descriptor based
APIs. Modified the file sky81452-backlight.c and sky81452-backlight.h.
The gpio descriptor property in device tree should be "sky81452-en-gpios"

Removed unnecessary header files "linux/gpio.h" and "linux/of_gpio.h".

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/video/backlight/sky81452-backlight.c     | 24 ++++++++++++------------
 include/linux/platform_data/sky81452-backlight.h |  4 +++-
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index d414c7a..12ef628 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -19,12 +19,10 @@
 
 #include <linux/backlight.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/platform_data/sky81452-backlight.h>
@@ -193,7 +191,6 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	pdata->ignore_pwm = of_property_read_bool(np, "skyworks,ignore-pwm");
 	pdata->dpwm_mode = of_property_read_bool(np, "skyworks,dpwm-mode");
 	pdata->phase_shift = of_property_read_bool(np, "skyworks,phase-shift");
-	pdata->gpio_enable = of_get_gpio(np, 0);
 
 	ret = of_property_count_u32_elems(np, "led-sources");
 	if (ret < 0) {
@@ -274,13 +271,17 @@ static int sky81452_bl_probe(struct platform_device *pdev)
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
-
-	if (gpio_is_valid(pdata->gpio_enable)) {
-		ret = devm_gpio_request_one(dev, pdata->gpio_enable,
-					GPIOF_OUT_INIT_HIGH, "sky81452-en");
-		if (ret < 0) {
-			dev_err(dev, "failed to request GPIO. err=%d\n", ret);
-			return ret;
+	pdata->gpiod_enable = devm_gpiod_get(dev, "sk81452-en", GPIOD_OUT_HIGH);
+	if (IS_ERR(pdata->gpiod_enable)) {
+		long ret = PTR_ERR(pdata->gpiod_enable);
+
+		/**
+		 * gpiod_enable is optional in device tree.
+		 * Return error only if gpio was assigned in device tree
+		 */
+		if (ret != -ENOENT) {
+			dev_err(dev, "failed to request GPIO. err=%ld\n", ret);
+			return PTR_ERR(pdata->gpiod_enable);
 		}
 	}
 
@@ -323,8 +324,7 @@ static int sky81452_bl_remove(struct platform_device *pdev)
 	bd->props.brightness = 0;
 	backlight_update_status(bd);
 
-	if (gpio_is_valid(pdata->gpio_enable))
-		gpio_set_value_cansleep(pdata->gpio_enable, 0);
+	gpiod_set_value_cansleep(pdata->gpiod_enable, 0);
 
 	return 0;
 }
diff --git a/include/linux/platform_data/sky81452-backlight.h b/include/linux/platform_data/sky81452-backlight.h
index 1231e9b..dc4cb85 100644
--- a/include/linux/platform_data/sky81452-backlight.h
+++ b/include/linux/platform_data/sky81452-backlight.h
@@ -20,6 +20,8 @@
 #ifndef _SKY81452_BACKLIGHT_H
 #define _SKY81452_BACKLIGHT_H
 
+#include <linux/gpio/consumer.h>
+
 /**
  * struct sky81452_platform_data
  * @name:	backlight driver name.
@@ -34,7 +36,7 @@
  */
 struct sky81452_bl_platform_data {
 	const char *name;
-	int gpio_enable;
+	struct gpio_desc *gpiod_enable;
 	unsigned int enable;
 	bool ignore_pwm;
 	bool dpwm_mode;
-- 
2.7.4

