Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98007C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D05B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkrrzxTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfDXMel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:34:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33555 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730179AbfDXMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:34:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so14533594lfm.0;
        Wed, 24 Apr 2019 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+tI0Q1OGQBkYUEkcCnHn7Px/HZGg+Sa4rTg9VRP4b8=;
        b=JkrrzxTmbVRS8a3h6Yhhpi37YJ3I4vLZOtoKvRcP1uWGHAzjgglp/MnGdxho+3c1vl
         EYJXmZT0yiKU84iXTC6WlYkRXK3Hyafsm7uhusuD0cS7T86geQcIC7Gxk//l5AaP17S3
         yGZPXWR27+Niherd0G1CW2grBE64VaA6xPhSDiSMyl+Dv/NkzzzR2cSlVeHmGVmJPRfX
         5dCUgJnjUOBdtH5a2IeINKZMZtQn4ZZoFqJSn7QruGYnHeIuCQXLT4v15Wle+362rrfD
         JdrGFD+IqYo3J5g9Y7gn7PaieOInA6ZGAwwDVrAWZOfo7tCYV+r7OBwdvCkRRiYWMkRj
         tiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+tI0Q1OGQBkYUEkcCnHn7Px/HZGg+Sa4rTg9VRP4b8=;
        b=Kcs7wYf8ZcEM/476x4ssWHJdy4Atjh68KeNu+iNUeixptCbUfrqwQ5bSoLqQ1Tc0mc
         5E6/p1CH8HCbzST62u1qUkfQu2TiOwNrm0MnAvcT2RPzA6Ak8GXfbLxTKk0l0KKVQKTl
         qrm0jYKPZKDsouhxeod30gFmcdxpBxEaEG2DKwpXix4LM0am2g7yWne/hfFSLRrCpbhT
         G5lQQkz+hIPUxeXUP1fxdr9UbqmR/pkzzbS6Hr+xAzvkuZO4GE1sjZ+meT693mT1unbs
         TfByaZRX/zZl3PlylBEa/FCmO3GDscyiy8aH7h6UXiiWkQWOCk6a6ys41KV0z/vP4Rdk
         +ZyA==
X-Gm-Message-State: APjAAAWs9bRgVlR6RSWO43LthWE88jojSfTkAM2exaa2ltlPkWYaDNsm
        GrSWfJgdQYOHHsC7/uye1ZfyJId5LT4=
X-Google-Smtp-Source: APXvYqycaq60cJsOdTkAU6dlTdGRC5+M3wPvTU2oADAD2jKti2MVOgSlOzIYJd7xRdahfmyckjk6mQ==
X-Received: by 2002:a19:2943:: with SMTP id p64mr18735911lfp.0.1556109272895;
        Wed, 24 Apr 2019 05:34:32 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id t14sm3765962lji.33.2019.04.24.05.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:34:32 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] i2c-mux-gpio: Create of-based GPIOs request method
Date:   Wed, 24 Apr 2019 15:34:14 +0300
Message-Id: <20190424123414.25311-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most modern platforms provide a dts with description of the devices
available in the system. It may also include i2c-gpio-mux'es.
Up until now the i2c-mux-gpio driver supported it' dts nodes, but
performed the GPIOs request by means of legacy GPIO API, which by design
and due to being legacy doesn't know anything about of/dtb/fdt/dts stuff.
It means even though the i2c-gpio-mux dts nodes are successfully mapped
to the kernel i2c-mux devices, the GPIOs used for initialization are
requested without OF_GPIO_* flags setup. It causes problems on the
platforms which fully rely on dts and reside, for instance,
i2c-gpio-muxes with active low or open drain GPIOs connected.

It is fixed by implementing a dedicated method for full dts-based
GPIOs requests. It is mostly similar to the platform one, but
utilizes the gpiod_get_from_of_node() method to request the GPIOs.

Finally the platform code i2c-gpio-mux devices are also supported.
So the fallback to dtb is performed only if array with GPIOs isn't
detected.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 65 ++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 317c019e1415..e5e10ba35ad9 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -65,8 +65,8 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *adapter_np, *child;
 	struct i2c_adapter *adapter;
-	unsigned *values, *gpios;
-	int i = 0, ret;
+	unsigned int *values;
+	int i = 0;
 
 	if (!np)
 		return -ENODEV;
@@ -109,24 +109,48 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 		return -EINVAL;
 	}
 
-	gpios = devm_kcalloc(&pdev->dev,
-			     mux->data.n_gpios, sizeof(*mux->data.gpios),
-			     GFP_KERNEL);
-	if (!gpios) {
-		dev_err(&pdev->dev, "Cannot allocate gpios array");
-		return -ENOMEM;
-	}
+	return 0;
+}
+
+static int i2c_mux_gpio_request_dt(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct i2c_adapter *root;
+	struct device *gpio_dev;
+	enum gpiod_flags dflags;
+	int i, ret;
+
+	root = i2c_root_adapter(&muxc->parent->dev);
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
-		ret = of_get_named_gpio(np, "mux-gpios", i);
-		if (ret < 0)
-			return ret;
-		gpios[i] = ret;
-	}
+		if (mux->data.idle & (1 << i))
+			dflags = GPIOD_OUT_HIGH;
+		else
+			dflags = GPIOD_OUT_LOW;
+
+		mux->gpios[i] = gpiod_get_from_of_node(np, "mux-gpios", i,
+						       dflags, "i2c-mux-gpio");
+		if (IS_ERR(mux->gpios[i])) {
+			ret = PTR_ERR(mux->gpios[i]);
+			goto err_request_gpio;
+		}
 
-	mux->data.gpios = gpios;
+		if (!muxc->mux_locked)
+			continue;
+
+		gpio_dev = &mux->gpios[i]->gdev->dev;
+		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
+	}
 
 	return 0;
+
+err_request_gpio:
+	for (i--; i >= 0; i--)
+		gpiod_free(mux->gpios[i]);
+
+	return ret;
 }
 #else
 static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
@@ -134,6 +158,12 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 {
 	return -EINVAL;
 }
+
+static int i2c_mux_gpio_request_dt(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	return -EINVAL;
+}
 #endif
 
 static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
@@ -174,6 +204,9 @@ static int i2c_mux_gpio_request_plat(struct gpiomux *mux,
 	struct device *gpio_dev;
 	int i, ret;
 
+	if (!mux->data.gpios)
+		return -EINVAL;
+
 	root = i2c_root_adapter(&muxc->parent->dev);
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
@@ -267,6 +300,8 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		mux->data.idle = mux->data.values[0];
 
 	ret = i2c_mux_gpio_request_plat(mux, pdev);
+	if (ret)
+		ret = i2c_mux_gpio_request_dt(mux, pdev);
 	if (ret)
 		goto alloc_failed;
 
-- 
2.21.0

