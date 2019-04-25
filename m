Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02ACC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED41420717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjVd32B2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfDYXVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:21:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37569 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfDYXVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:21:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so1181798ljk.4;
        Thu, 25 Apr 2019 16:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCyHOO8OquTiABOe6VlVOA3htMwlp2az2GZDhqfzYwQ=;
        b=GjVd32B2uoFlmJyGwMAGI6NKXBsvTLouutAr8dtKxAf4A5zEaQwZt5Br+sXcgkQXDq
         ehFa3QzT2LQR0FNBEIGyD+FXsITfMcLSvbAnhlqkTsv/8KyntugWo4PUDgQmGrLEFo8i
         WGiPUmeyLwNoax6Oxhdztb53Vrv6yfC0vXeGBTYhGLctVU3JSh110EknX80M6F9s1WuR
         k9jGQ7ItYXX0rCut+D/ovIYm6SkA6ZXPnbDFsgugl4hiUbVw/bI+e8LN275c/2EiERdP
         8e8/1nb/3JImzrG73CM8r2tGD6TTyiz/yAAUJ+aHJx9VX6o7+RRqosM8waHpeJEhOZPB
         Eizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCyHOO8OquTiABOe6VlVOA3htMwlp2az2GZDhqfzYwQ=;
        b=iNRxoY/zlN6nDbvoRdsU8OoO5xUuHJ8zBI9jBXQ6UUcNTOe75dSCOL0g5Snzz3rlyr
         GfKeZw6QUHYcw6Z5qwrId54lN0VumHM/RGwPO5famek38pzDbZXltGVybObOYsZTlpny
         uuK2manPTAiNr/3kA1aWYHcqT47oeFVz29nEoJz1MagORojJjOCHhMkVeshMkKvU1gb1
         mmLh4DTXRRweLz78Q+cljo3ZaEWfs247DllUpvRaX/z7dA4hZpmSM5CThbkKhJWtj3FJ
         Xt6ieQVPkm2uvjC3Meh1EFML4psd/DXaXD7mcz1QriITuoNgE/yT8e7MXl5Ep9D4v09i
         I5vw==
X-Gm-Message-State: APjAAAXFsX7aR/asmp/C6YasTC7IPl3HMT8O7Jmayj4yuVmaSKtUo7WU
        jl8vPdn/sRyavoDN3k476V0=
X-Google-Smtp-Source: APXvYqxe2s+PqUbQpV6u8+eSfi29gUEboiE/DAz/gatqI66k5SfZTlTjJ7Ohke1SOvQHdKoBpSChRw==
X-Received: by 2002:a2e:8e93:: with SMTP id z19mr3510568ljk.159.1556234488910;
        Thu, 25 Apr 2019 16:21:28 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id j9sm4919609lja.92.2019.04.25.16.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 16:21:28 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] i2c-mux-gpio: Create of-based GPIOs request method
Date:   Fri, 26 Apr 2019 02:20:28 +0300
Message-Id: <20190425232028.9333-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425232028.9333-1-fancer.lancer@gmail.com>
References: <20190425232028.9333-1-fancer.lancer@gmail.com>
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
i2c-gpio-muxes with active low, push-pull, open drain or open source
GPIOs connected.

It is fixed by implementing a dedicated method for full dts-based
GPIOs requests. It is mostly similar to the platform one, but
utilizes the gpiod_get_from_of_node() method to request the GPIOs.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
Changelog v2
- Remove fallback pattern when selecting the dt- or plat-based GPIOs
  request methods.
- Use a dedicated initial_state field in the "gpiomux" structure to
  select a proper channel initially.
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 68 ++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index e10f72706b99..d1a9c56fa1ec 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -66,8 +66,8 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *adapter_np, *child;
 	struct i2c_adapter *adapter;
-	unsigned *values, *gpios;
-	int i = 0, ret;
+	unsigned int *values;
+	int i = 0;
 
 	if (!np)
 		return -ENODEV;
@@ -110,24 +110,48 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
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
+		if (mux->initial_state & (1 << i))
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
+
+		if (!muxc->mux_locked)
+			continue;
 
-	mux->data.gpios = gpios;
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
@@ -135,6 +159,12 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
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
@@ -172,6 +202,9 @@ static int i2c_mux_gpio_request_plat(struct gpiomux *mux,
 	struct device *gpio_dev;
 	int i, ret;
 
+	if (!mux->data.gpios)
+		return -EINVAL;
+
 	root = i2c_root_adapter(&muxc->parent->dev);
 
 	for (i = 0; i < mux->data.n_gpios; i++) {
@@ -263,7 +296,10 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 		mux->initial_state = mux->data.values[0];
 	}
 
-	ret = i2c_mux_gpio_request_plat(mux, pdev);
+	if (!dev_get_platdata(&pdev->dev))
+		ret = i2c_mux_gpio_request_dt(mux, pdev);
+	else
+		ret = i2c_mux_gpio_request_plat(mux, pdev);
 	if (ret)
 		goto alloc_failed;
 
-- 
2.21.0

