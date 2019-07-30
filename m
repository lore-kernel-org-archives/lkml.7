Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9902BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6349D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSACxpa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfG3SQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44684 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbfG3SQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so30476475pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhlQQQRieJjZYYpCNNXjh1PcFW8kxorgZuS+lQtZq+Y=;
        b=jSACxpa/l1l0SJiz2itlvh8qq4HGxfu0TYhjkVFSiuqh3mrYA+3NLYCvHA/InNtfyg
         b0LwPgJbwXuLOARZSpJPZEmuYON8tMiuQUth73HtkX8xf9Et79VFek49+R0Hx7TA0kWr
         GJFmVw8nu6UxtGeW7U/vSr9avSTxP/lZh0OQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhlQQQRieJjZYYpCNNXjh1PcFW8kxorgZuS+lQtZq+Y=;
        b=AHUwh4boLpArb9WWfZP9BfEZ0X5Erstv0/zHDA0rliGeCtP74ggjXsZZ0SVxY2Mb2w
         51sH5guT0x00slkIg0r0SKU+ku6zqYCdD0HQuSPJm+rMxw5uDGTNohjOGzu2DwWXCk+v
         yXUmOTKgjQJKnbN+UHqtNtSoF8dL3HKsuCa558oHzMGGZHMJeNa19ym8oQQdp6S0Apu5
         gmSeFeGrZTF46TKycP86jQgcfVtkst4ZPwip78cNoUduFQKNodFJlgwjwtrHxxkjtc3i
         RTEYHM9NNVvvIyctAQZ3pLYOnvm1/uB7PgKaIQO+REFacskNTCGbuQh+r5UuOD9d7o1o
         HDEw==
X-Gm-Message-State: APjAAAVc9L7UosOdiIYDISFkg8BUQ6mqmOdKpWGaijUxaFAzZhAK2N0t
        PyKcStc9uhLdIUdDEd+8kZcMzc/24FM=
X-Google-Smtp-Source: APXvYqz7xG5/TzVgginBpKspeYk1y8zj5RrMxo/SBX08pFjFEe9OjBa/akNfaVtUsbTjOqfTpMIMyw==
X-Received: by 2002:a17:90a:30aa:: with SMTP id h39mr118951331pjb.32.1564510571937;
        Tue, 30 Jul 2019 11:16:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 15/57] gpio: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:15 -0700
Message-Id: <20190730181557.90391-16-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-gpio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/gpio/gpio-brcmstb.c       | 4 +---
 drivers/gpio/gpio-eic-sprd.c      | 4 +---
 drivers/gpio/gpio-grgpio.c        | 2 --
 drivers/gpio/gpio-max77620.c      | 4 +---
 drivers/gpio/gpio-pmic-eic-sprd.c | 4 +---
 drivers/gpio/gpio-sprd.c          | 4 +---
 drivers/gpio/gpio-tb10x.c         | 4 +---
 drivers/gpio/gpio-tegra.c         | 4 +---
 drivers/gpio/gpio-zx.c            | 1 -
 drivers/gpio/gpio-zynq.c          | 4 +---
 10 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index af936dcca659..05e3f99ae59c 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -636,10 +636,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 
 	if (of_property_read_bool(np, "interrupt-controller")) {
 		priv->parent_irq = platform_get_irq(pdev, 0);
-		if (priv->parent_irq <= 0) {
-			dev_err(dev, "Couldn't get IRQ");
+		if (priv->parent_irq <= 0)
 			return -ENOENT;
-		}
 	} else {
 		priv->parent_irq = -ENOENT;
 	}
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 7b9ac4a12c20..fe7a73f52329 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -584,10 +584,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	sprd_eic->type = pdata->type;
 
 	sprd_eic->irq = platform_get_irq(pdev, 0);
-	if (sprd_eic->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get EIC interrupt.\n");
+	if (sprd_eic->irq < 0)
 		return sprd_eic->irq;
-	}
 
 	for (i = 0; i < SPRD_EIC_MAX_BANK; i++) {
 		/*
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 0937b605e134..08234e64993a 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -408,8 +408,6 @@ static int grgpio_probe(struct platform_device *ofdev)
 				 * Continue without irq functionality for that
 				 * gpio line
 				 */
-				dev_err(priv->dev,
-					"Failed to get irq for offset %d\n", i);
 				continue;
 			}
 			priv->uirqs[lirq->index].uirq = ret;
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index b7d89e30131e..47d05e357e61 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -270,10 +270,8 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	int ret;
 
 	gpio_irq = platform_get_irq(pdev, 0);
-	if (gpio_irq <= 0) {
-		dev_err(&pdev->dev, "GPIO irq not available %d\n", gpio_irq);
+	if (gpio_irq <= 0)
 		return -ENODEV;
-	}
 
 	mgpio = devm_kzalloc(&pdev->dev, sizeof(*mgpio), GFP_KERNEL);
 	if (!mgpio)
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 24228cf79afc..05000cace9b2 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -305,10 +305,8 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	mutex_init(&pmic_eic->buslock);
 
 	pmic_eic->irq = platform_get_irq(pdev, 0);
-	if (pmic_eic->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get PMIC EIC interrupt.\n");
+	if (pmic_eic->irq < 0)
 		return pmic_eic->irq;
-	}
 
 	pmic_eic->map = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!pmic_eic->map)
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index f5c8b3a351d5..d7314d39ab65 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -226,10 +226,8 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sprd_gpio->irq = platform_get_irq(pdev, 0);
-	if (sprd_gpio->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get GPIO interrupt.\n");
+	if (sprd_gpio->irq < 0)
 		return sprd_gpio->irq;
-	}
 
 	sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sprd_gpio->base))
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index bd1f3f775ce9..5e375186f90e 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -171,10 +171,8 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 		struct irq_chip_generic *gc;
 
 		ret = platform_get_irq(pdev, 0);
-		if (ret < 0) {
-			dev_err(dev, "No interrupt specified.\n");
+		if (ret < 0)
 			return ret;
-		}
 
 		tb10x_gpio->gc.to_irq	= tb10x_gpio_to_irq;
 		tb10x_gpio->irq		= ret;
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 0f59161a4701..8a01d3694b28 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -624,10 +624,8 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 
 	for (i = 0; i < tgi->bank_count; i++) {
 		ret = platform_get_irq(pdev, i);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Missing IRQ resource: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 
 		bank = &tgi->bank_info[i];
 		bank->bank = i;
diff --git a/drivers/gpio/gpio-zx.c b/drivers/gpio/gpio-zx.c
index 8637adb6bc20..8d9b9bf8510a 100644
--- a/drivers/gpio/gpio-zx.c
+++ b/drivers/gpio/gpio-zx.c
@@ -253,7 +253,6 @@ static int zx_gpio_probe(struct platform_device *pdev)
 	writew_relaxed(0, chip->base + ZX_GPIO_IE);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "invalid IRQ\n");
 		gpiochip_remove(&chip->gc);
 		return -ENODEV;
 	}
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index f241b6c13dbe..86b0bd256c13 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -849,10 +849,8 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio->base_addr);
 
 	gpio->irq = platform_get_irq(pdev, 0);
-	if (gpio->irq < 0) {
-		dev_err(&pdev->dev, "invalid IRQ\n");
+	if (gpio->irq < 0)
 		return gpio->irq;
-	}
 
 	/* configure the gpio chip */
 	chip = &gpio->chip;
-- 
Sent by a computer through tubes

