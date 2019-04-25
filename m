Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15381C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DDB2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWbfiphh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfDYXVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:21:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33619 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDYXV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:21:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id j11so1074989lfm.0;
        Thu, 25 Apr 2019 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZ1cEh8dKU062ETNm3DtfpguUM23925KSmCWyDQ/Img=;
        b=XWbfiphhjdzGFtP6X3JDbtURo/p83L212o4xwHrJ5ocxR31x9ibk7UuXKQuYNRsLGJ
         XIP5Nm5GGwOzgPJy7e8SZslHfPgGawU1oWjIK93qQzeXqj0ZiDta3CAfoK7fwV0Ml51M
         4xZ1khuM/SiQFkQoNspJUK53RMn2uVJaKUuNNbddDj1hqdDJZdZR2lq4S743vs+Ea6Xg
         8F4+Se+khx1OzCwCybVTncUO1jIHrdHJqwyIvMSF0/ZcILtQHBkwZhT74GyqHt9BNRNa
         J5fGC/xkA6ZdfV4FPTo/qwibjQSdHNK1f+vKE21vkPOkx9sxKt9pjqcecGNMTwRKp9EX
         3sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZ1cEh8dKU062ETNm3DtfpguUM23925KSmCWyDQ/Img=;
        b=j3xRdpj4jbfLl91C40n5BinQpHP8QwQxW1kvzBSFe0QQaP97Q6qZxSy38aOShLJuRJ
         CYSaZrTLAsytFl7eLYQ4NaGYLrl+2u4eu0Odx0lHkAFJSwu8dbP8UA9gzgFQ2+cJisdM
         dnLrYcYZa0nGO5iDE/sKoCiRX6hC2H5pCmeOn0kqKOrXosKhLbK9qK25SKOj/BRfof3H
         McbZqlXF3Nq2SR8vdl9bCfxOouzGN9FKeH+uKV9i3JsqWOitAdLxxm/S3YNCnYTqz8qM
         TGwjJ+GHgRK8mxNPA6UjIT0gd8hUM1qHhy/01tnWokEJfRyPiilez9WNVkdhJhB65zhL
         rNSA==
X-Gm-Message-State: APjAAAVWv9z6s+VDgpj7u++aFx3YP5I21d71rn1t2h7u9WCdwaMncarO
        bcensUl37aRACwJo/dgOX24=
X-Google-Smtp-Source: APXvYqyGvQEQUnKZvX5LPloduK3uYey8I/iniZKH0l1tgyTjSnc4yuhVB9+4W3Tol4N9aWJE2eI5wQ==
X-Received: by 2002:ac2:523a:: with SMTP id i26mr17951604lfl.118.1556234487429;
        Thu, 25 Apr 2019 16:21:27 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id j9sm4919609lja.92.2019.04.25.16.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 16:21:26 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] i2c-mux-gpio: Unpin the platform-specific GPIOs request code
Date:   Fri, 26 Apr 2019 02:20:27 +0300
Message-Id: <20190425232028.9333-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425232028.9333-1-fancer.lancer@gmail.com>
References: <20190425232028.9333-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIOs request loop can be safely moved to a separate function.
First of all it shall improve the code readability. Secondly the
initialization loop at this point is used for both of- and
platform_data-based initialization paths, but it will be changed in
the next patch, so by isolating the code we'll simplify the future
work.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
Changelog v2
- Create a dedicated initial_state field in the "gpiomux" structure to
  keep an initial channel selector state.
---
 drivers/i2c/muxes/i2c-mux-gpio.c | 113 +++++++++++++++++++------------
 1 file changed, 68 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 54158b825acd..e10f72706b99 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -20,7 +20,8 @@
 
 struct gpiomux {
 	struct i2c_mux_gpio_platform_data data;
-	unsigned gpio_base;
+	unsigned int gpio_base;
+	unsigned int initial_state;
 	struct gpio_desc **gpios;
 };
 
@@ -162,13 +163,68 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
 	return 0;
 }
 
+static int i2c_mux_gpio_request_plat(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
+	struct gpio_desc *gpio_desc;
+	struct i2c_adapter *root;
+	struct device *gpio_dev;
+	int i, ret;
+
+	root = i2c_root_adapter(&muxc->parent->dev);
+
+	for (i = 0; i < mux->data.n_gpios; i++) {
+		ret = gpio_request(mux->gpio_base + mux->data.gpios[i],
+				   "i2c-mux-gpio");
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
+				mux->data.gpios[i]);
+			goto err_request_gpio;
+		}
+
+		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
+					    mux->initial_state & (1 << i));
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to set direction of GPIO %d to output\n",
+				mux->data.gpios[i]);
+			i++;	/* gpio_request above succeeded, so must free */
+			goto err_request_gpio;
+		}
+
+		gpio_desc = gpio_to_desc(mux->gpio_base + mux->data.gpios[i]);
+		mux->gpios[i] = gpio_desc;
+
+		if (!muxc->mux_locked)
+			continue;
+
+		gpio_dev = &gpio_desc->gdev->dev;
+		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
+	}
+
+	return 0;
+
+err_request_gpio:
+	for (; i > 0; i--)
+		gpio_free(mux->gpio_base + mux->data.gpios[i - 1]);
+
+	return ret;
+}
+
+static void i2c_mux_gpio_free(struct gpiomux *mux)
+{
+	int i;
+
+	for (i = 0; i < mux->data.n_gpios; i++)
+		gpiod_free(mux->gpios[i]);
+}
+
 static int i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc;
 	struct gpiomux *mux;
 	struct i2c_adapter *parent;
-	struct i2c_adapter *root;
-	unsigned initial_state;
 	int i, ret;
 
 	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
@@ -198,48 +254,18 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, muxc);
 
-	root = i2c_root_adapter(&parent->dev);
-
 	muxc->mux_locked = true;
 
 	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
-		initial_state = mux->data.idle;
+		mux->initial_state = mux->data.idle;
 		muxc->deselect = i2c_mux_gpio_deselect;
 	} else {
-		initial_state = mux->data.values[0];
+		mux->initial_state = mux->data.values[0];
 	}
 
-	for (i = 0; i < mux->data.n_gpios; i++) {
-		struct device *gpio_dev;
-		struct gpio_desc *gpio_desc;
-
-		ret = gpio_request(mux->gpio_base + mux->data.gpios[i],
-				   "i2c-mux-gpio");
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to request GPIO %d\n",
-				mux->data.gpios[i]);
-			goto err_request_gpio;
-		}
-
-		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
-					    initial_state & (1 << i));
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to set direction of GPIO %d to output\n",
-				mux->data.gpios[i]);
-			i++;	/* gpio_request above succeeded, so must free */
-			goto err_request_gpio;
-		}
-
-		gpio_desc = gpio_to_desc(mux->gpio_base + mux->data.gpios[i]);
-		mux->gpios[i] = gpio_desc;
-
-		if (!muxc->mux_locked)
-			continue;
-
-		gpio_dev = &gpio_desc->gdev->dev;
-		muxc->mux_locked = i2c_root_adapter(gpio_dev) == root;
-	}
+	ret = i2c_mux_gpio_request_plat(mux, pdev);
+	if (ret)
+		goto alloc_failed;
 
 	if (muxc->mux_locked)
 		dev_info(&pdev->dev, "mux-locked i2c mux\n");
@@ -260,10 +286,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 add_adapter_failed:
 	i2c_mux_del_adapters(muxc);
-	i = mux->data.n_gpios;
-err_request_gpio:
-	for (; i > 0; i--)
-		gpio_free(mux->gpio_base + mux->data.gpios[i - 1]);
+
+	i2c_mux_gpio_free(mux);
+
 alloc_failed:
 	i2c_put_adapter(parent);
 
@@ -274,12 +299,10 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
 {
 	struct i2c_mux_core *muxc = platform_get_drvdata(pdev);
 	struct gpiomux *mux = i2c_mux_priv(muxc);
-	int i;
 
 	i2c_mux_del_adapters(muxc);
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_free(mux->gpio_base + mux->data.gpios[i]);
+	i2c_mux_gpio_free(mux);
 
 	i2c_put_adapter(muxc->parent);
 
-- 
2.21.0

