Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2222D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opjj36S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfDXMee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:34:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42199 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbfDXMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:34:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id i186so2776490lji.9;
        Wed, 24 Apr 2019 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wf7ZRFtlZtJ8GcqpzCHA0EDoifX2NsdN7Z4criiz7iY=;
        b=opjj36S251P/wxnDnNH1ylzmwC26Q19UTYlBIMgpUd/S7G5j1oPMa9uiAQvQVuyCky
         MwOv2Vfx7nkEIJLbTAfB0sD5EIY+GSLtlcU0lcunyimdV1DQiOlcS47E9NvcaAg3fzKf
         mrAYf3ZYk2YetGq/4aJo5/rBsJT7uTV6Xg5Rvtr7aCm0a/6u8Dvp/ngxdpRFRi6ZhSC5
         1vJ8oKtvAkkR0TUIQtOqnMCIGSXK+Px/6KeI8o6O/sKZ5LEpGBunVdmU8/lnWnMgqPWb
         Vm5xhdh2/ZKPlQD/bCDpaC5K8A39oItYkTMuaRiZylcinOSsLLafz+3yYh0OcLSs2wfu
         v6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wf7ZRFtlZtJ8GcqpzCHA0EDoifX2NsdN7Z4criiz7iY=;
        b=ezA9iYuqib217tQyX3FWrg4W9rOCcW8Sf3B0N4szNJWTJDwt7txgkYaxy5kCygQUCf
         48RiZcRhFm8E6YMYx5iqrCX6PdDhsbwp5LtudENDEeYKDvVzhMW/NuCCaunKQ7pz5VV1
         dX0I1GeZUNPc429H8mvL/1dpc0h/9UFcrP6hb7t0WbJyRGsV31qMYh1ODFowgwvB1Ihu
         Sn2LzSz9A6r78fuk57KCvxo5E8LezeK1SGg1RkNqQSqNnfyLZURZ75cHhVrj33flEia3
         wIty3QG+qmImoAvrkP0GTvn69TOZLH+ZNPq8p1yq4g7Mimq9pPuhQWt1HnSZE1oFouP/
         J3VQ==
X-Gm-Message-State: APjAAAUwrJra20IGBRrMHq2cS30vx4WLfxh85EyiEB5InwUkkA5M9DTH
        07pZeTUi089sWMIXREvcCwc=
X-Google-Smtp-Source: APXvYqwWJihLtO71OddV96Wq9YTgrCnq8TKmn+DEVQrnS+cGY+FzMNncvS62s283f3zU8dtC+aahVw==
X-Received: by 2002:a2e:309:: with SMTP id 9mr18068680ljd.114.1556109267833;
        Wed, 24 Apr 2019 05:34:27 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id t14sm3765962lji.33.2019.04.24.05.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:34:27 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] i2c-mux-gpio: Unpin a platform-based device initialization
Date:   Wed, 24 Apr 2019 15:34:10 +0300
Message-Id: <20190424123414.25311-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
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

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 67 ++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 13882a2a4f60..24cf6ec02e75 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -136,44 +136,51 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
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
+	if (ret < 0)
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

