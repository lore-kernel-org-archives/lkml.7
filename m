Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1300BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C311820811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD30lbVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfDXMei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:34:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45804 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbfDXMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:34:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so14513691lfl.12;
        Wed, 24 Apr 2019 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9M/tOm0l7xcRJSE038y20vsgQZbIvMnyyQr45cZvG0A=;
        b=kD30lbVM0SpLODmOvZ2HqS8KiXE0qs5E/MNE86hqfLl7UvB5hdcN00sjovKLsdt3k2
         1eI8to0M3Jj7sqElbIXW4DOMxsY6Xu4PqJwvYulPD4y7NN2QdHxL3gcOiXRMJYWCRsQL
         6VRdHflz7qOoQWr9daVH0KaRkuWv4TyOPHiaP7MDZMS7tj1XqSJ1Ev/W2aKIe+cTLAlw
         7n7veGxhSfYvUyN0D0edvCdntSxcnMZVzyTqG0aNlDS84QPUHzkE/5C5Rjg0ibWXE/Ue
         DL1388HnhXUu0ExE63gPPT5Rr6h/zuXq+EbMi6XqUE62UmeORAiTtw1gfBhl7+meIzzA
         H85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9M/tOm0l7xcRJSE038y20vsgQZbIvMnyyQr45cZvG0A=;
        b=Xr1x5eboXMTNtyCJNIyNg5mOkWIjKulqrQzDZvz/WrL0QvUlP30+OijD5rc1g6kDoZ
         CJpmbDxyEuROk7dhmku/k3ZYlUEdzFQefBLbJfAQBLPvc8c2jvvQTlt3ApWupJBoRoT6
         Bk1U7H6PnlgfabdoIZcxL56ag830SBR1UXn3ZS/cwHiIQhF8LJwTfxjBcWOtkBUpdYei
         kyN7m4eB3Q0nRIDJDCBwlJcZBwunHI2h87aLlciyJ0jtla2vg/JMCCa+GmuiV8oExhme
         F6lWjEOCgAmmSiL68ecKoZu5UndEUI9FYdtYnYGWQInfyaX83O4Uz5WeYs1kaoCfFbem
         WY9Q==
X-Gm-Message-State: APjAAAVO7mKMZZuXQLGOd2tW8W6cQOANrJH4b0wS/oLe3QMKoa88pC1H
        +35BHgXtULbs0GC698CIp00=
X-Google-Smtp-Source: APXvYqwPjMAHNQkagANpF1GNWXg7lWPLa0iL6rtyoEK7eaTYaPCrvkESIcorussVIFRZ4fFFcPff9A==
X-Received: by 2002:ac2:4186:: with SMTP id z6mr16915147lfh.50.1556109271706;
        Wed, 24 Apr 2019 05:34:31 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id t14sm3765962lji.33.2019.04.24.05.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:34:31 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] i2c-mux-gpio: Unpin the platform-specific GPIOs request code
Date:   Wed, 24 Apr 2019 15:34:13 +0300
Message-Id: <20190424123414.25311-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424123414.25311-1-fancer.lancer@gmail.com>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
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
 drivers/i2c/muxes/i2c-mux-gpio.c | 105 +++++++++++++++++++------------
 1 file changed, 64 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 535c83c43371..317c019e1415 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -165,12 +165,68 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
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
+					    mux->data.idle & (1 << i));
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
 	int i, ret;
 
 	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
@@ -199,8 +255,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, muxc);
 
-	root = i2c_root_adapter(&parent->dev);
-
 	muxc->mux_locked = true;
 
 	/*
@@ -212,37 +266,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	else
 		mux->data.idle = mux->data.values[0];
 
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
-					    mux->data.idle & (1 << i));
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
@@ -263,10 +289,9 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 
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
 
@@ -277,12 +302,10 @@ static int i2c_mux_gpio_remove(struct platform_device *pdev)
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

