Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD53C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB4120717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esWJp5u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfDYXVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:21:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41748 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:21:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id k8so1158567lja.8;
        Thu, 25 Apr 2019 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5unOTGTYjPq/YaacusOqWe2upWmJasD+CYebIMJG8+g=;
        b=esWJp5u6w8pDArcVpK1/APIfZnNz/YtZ5u1KosRDaxyCB+IN0VHVmCLnvsSg+TOq2S
         Oiyr5MM2WiZELobv/w4cxZxQ0xhm70wJKkEBGbNxVsqT+QU7ASI4oZmdHLdDZYxqI8/2
         h/A8Y73wztld8L1RzwYEmC/dItCIUE6hJ2h9E+g2zbDb+v6JblXawQS+exGKTzhZrUp0
         ++kCXBHuvLNlkmxb5njUvleaioZG7nrgZwf6VM3hZplFI9eVnztsqc7tRLREaFbM4SsQ
         JGGREHMhXEBUmR49x6Ye9R+xeefs2bBeeFuyC8WCunI9AFZTW1XQE4zPzVTc6OrYERH2
         9o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5unOTGTYjPq/YaacusOqWe2upWmJasD+CYebIMJG8+g=;
        b=s02qRfG0+4ZSGhhdMeh/gp5vvhu28XtTv6WE/qhAcM6bVZFZKMojtSYdk38pJ9I4yk
         zOd7SMUgDe6EY1O1IjZfP7t3cGEuuVl2WEsdZ1GUny1/VG+U+8BYRdoaT0FEwrI4/bge
         WR1fKSZmAz/zw0+QrJ6QN84dw2BLM3YDjJCcO6sDYhpqdc8WXJUdrFokfelx9bbx+DI1
         DSsh3WSCdUkY7HgaamNN96H7TDRqaekdjfzEQe0buoSH7pRyu88roJTzKWlEhWVvU6E3
         OJB9f3CCKlAzDkxPbkmZVJlq4iQb64O3H1OnSbmQ083k+FGZ9Rq3Y/rEGp1Q0Y+j39a/
         T/+Q==
X-Gm-Message-State: APjAAAUPZJKj8YDNRajCX1l9sOPYCBrznTy7gKjL5uj6ZLBTOoKXiHpz
        hwdPdvv4fkw+4v59dgeyLvSRShkE
X-Google-Smtp-Source: APXvYqz0FQn2S7CvjThUHNDl5l4gT6GXw6Xfi+FKBtPYljGFXLEGYzIrmiYOZecyGQgsMjaS7n+VPw==
X-Received: by 2002:a2e:9895:: with SMTP id b21mr22777681ljj.183.1556234485729;
        Thu, 25 Apr 2019 16:21:25 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id j9sm4919609lja.92.2019.04.25.16.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 16:21:25 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] i2c-mux-gpio: Unpin a platform-based device initialization
Date:   Fri, 26 Apr 2019 02:20:26 +0300
Message-Id: <20190425232028.9333-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425232028.9333-1-fancer.lancer@gmail.com>
References: <20190425232028.9333-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can unpin a code specific for i2c-mux-gpio device declared
as platform device. In this case the platform data just needs to be
copied to the private storage and if GPIO chip pointer is referring to
a valid GPIO chip descriptor save it' base number for further GPIOs
request and initialization. The rest of the code is common for both
platform and OF-based setups.

It's also pointless and might be even errors prone to proceed with
further initialization if OF kernel config is disabled and plat-based
initialization isn't defined. Just return an error in this case.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
Changelog v2
- Return an error if OF kconfig is disabled while dt-based GPIOs probe
  is called.
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 69 ++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 13882a2a4f60..54158b825acd 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -132,48 +132,55 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 					struct platform_device *pdev)
 {
-	return 0;
+	return -EINVAL;
 }
 #endif
 
+static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	struct i2c_mux_gpio_platform_data *data = dev_get_platdata(&pdev->dev);
+	struct gpio_chip *gpio;
+
+	/*
+	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
+	 * relative to its base GPIO number. Otherwise they are absolute.
+	 */
+	if (data->gpio_chip) {
+		gpio = gpiochip_find(data->gpio_chip,
+				     match_gpio_chip_by_label);
+		if (!gpio)
+			return -EPROBE_DEFER;
+
+		mux->gpio_base = gpio->base;
+	} else {
+		mux->gpio_base = 0;
+	}
+
+	memcpy(&mux->data, data, sizeof(mux->data));
+
+	return 0;
+}
+
 static int i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc;
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
 	struct i2c_adapter *root;
-	unsigned initial_state, gpio_base;
+	unsigned initial_state;
 	int i, ret;
 
 	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
 		return -ENOMEM;
 
-	if (!dev_get_platdata(&pdev->dev)) {
+	if (!dev_get_platdata(&pdev->dev))
 		ret = i2c_mux_gpio_probe_dt(mux, pdev);
-		if (ret < 0)
-			return ret;
-	} else {
-		memcpy(&mux->data, dev_get_platdata(&pdev->dev),
-			sizeof(mux->data));
-	}
-
-	/*
-	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
-	 * relative to its base GPIO number. Otherwise they are absolute.
-	 */
-	if (mux->data.gpio_chip) {
-		struct gpio_chip *gpio;
-
-		gpio = gpiochip_find(mux->data.gpio_chip,
-				     match_gpio_chip_by_label);
-		if (!gpio)
-			return -EPROBE_DEFER;
-
-		gpio_base = gpio->base;
-	} else {
-		gpio_base = 0;
-	}
+	else
+		ret = i2c_mux_gpio_probe_plat(mux, pdev);
+	if (ret)
+		return ret;
 
 	parent = i2c_get_adapter(mux->data.parent);
 	if (!parent)
@@ -194,7 +201,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	root = i2c_root_adapter(&parent->dev);
 
 	muxc->mux_locked = true;
-	mux->gpio_base = gpio_base;
 
 	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
 		initial_state = mux->data.idle;
@@ -207,14 +213,15 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		struct device *gpio_dev;
 		struct gpio_desc *gpio_desc;
 
-		ret = gpio_request(gpio_base + mux->data.gpios[i], "i2c-mux-gpio");
+		ret = gpio_request(mux->gpio_base + mux->data.gpios[i],
+				   "i2c-mux-gpio");
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
 				mux->data.gpios[i]);
 			goto err_request_gpio;
 		}
 
-		ret = gpio_direction_output(gpio_base + mux->data.gpios[i],
+		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
 					    initial_state & (1 << i));
 		if (ret) {
 			dev_err(&pdev->dev,
@@ -224,7 +231,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 			goto err_request_gpio;
 		}
 
-		gpio_desc = gpio_to_desc(gpio_base + mux->data.gpios[i]);
+		gpio_desc = gpio_to_desc(mux->gpio_base + mux->data.gpios[i]);
 		mux->gpios[i] = gpio_desc;
 
 		if (!muxc->mux_locked)
@@ -256,7 +263,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	i = mux->data.n_gpios;
 err_request_gpio:
 	for (; i > 0; i--)
-		gpio_free(gpio_base + mux->data.gpios[i - 1]);
+		gpio_free(mux->gpio_base + mux->data.gpios[i - 1]);
 alloc_failed:
 	i2c_put_adapter(parent);
 
-- 
2.21.0

