Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A283C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60992208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iHdKedEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfG3SSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:18:50 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:47024 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbfG3SQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:29 -0400
Received: by mail-pl1-f175.google.com with SMTP id c2so29180785plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dxzi6qRWZtE1A4EggL+8bGGsb/uTQ63GAhxBds2vrjg=;
        b=iHdKedEcqrKIdDeNns4uJ5MTtZt7XQVmYor2fxPqeOCcd40osFo7LUrRWVKsmz+k+W
         n+HDAGoMd3SKtRQs7wzpQx2cFjOraqqXXnh/Km85v6nnjYd6UfwL3UqTjGRWa6ZHYxys
         UaewM55WvB0pZ1LLVl8V8IdBtd9dRfUJx+wVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dxzi6qRWZtE1A4EggL+8bGGsb/uTQ63GAhxBds2vrjg=;
        b=sltQGOsmJEQthxhqt9ga5o8ofYmxrgpgXl6IUV0Y53uZvqKEPyFyGVNB3WupOsIZt/
         xIxFerfDOh2SX/8TB4a8gJ4SCJIIJgn0z8DaXRzTuZXq917cQ337JISIuRJ+V4/B16ux
         Y4Cxy8H3YYa5WZsTnacvtn22X4WDPpZXlAWD/ovoEgdVaxb26dEtqra3qz3motQL/Jw/
         L8sruQ2Jt9Lj7jFxN4V+YW6Jucld23z0jnW2q7GeQPd1ypNDxb6pEBbcqBZwP74Q1LIU
         xYIX21L/09EVgX41vAbqyxcj6KcU4zgi8HUUrfvzZPjxKKbJtBm+tsNsse5A01HhxgKo
         weWg==
X-Gm-Message-State: APjAAAXlyA3QJjCrDh+4YTvbETed+CVy/WlgZ+JmSv16LK9dnOwQmG/+
        P82Ab0t+tbsPVi7LNqshILrQJp1/wZsE7w==
X-Google-Smtp-Source: APXvYqxcKGkUIAWddOr04ve0iW5YfQgA6u/YFk42386pZNmZAB7mp0UgjFyZDd5rJe9ckus/uob0rA==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr118531328pls.128.1564510587888;
        Tue, 30 Jul 2019 11:16:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Allison Randal <allison@lohutok.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v6 35/57] power: supply: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:35 -0700
Message-Id: <20190730181557.90391-36-swboyd@chromium.org>
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

Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Allison Randal <allison@lohutok.net>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/power/supply/88pm860x_battery.c  | 8 ++------
 drivers/power/supply/axp288_charger.c    | 4 +---
 drivers/power/supply/bd70528-charger.c   | 5 +----
 drivers/power/supply/da9150-charger.c    | 8 ++------
 drivers/power/supply/da9150-fg.c         | 1 -
 drivers/power/supply/goldfish_battery.c  | 4 +---
 drivers/power/supply/jz4740-battery.c    | 4 +---
 drivers/power/supply/qcom_smbb.c         | 5 +----
 drivers/power/supply/sc27xx_fuel_gauge.c | 4 +---
 9 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 5ca047b3f58f..1308f3a185f3 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -919,16 +919,12 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->irq_cc = platform_get_irq(pdev, 0);
-	if (info->irq_cc <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (info->irq_cc <= 0)
 		return -EINVAL;
-	}
 
 	info->irq_batt = platform_get_irq(pdev, 1);
-	if (info->irq_batt <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (info->irq_batt <= 0)
 		return -EINVAL;
-	}
 
 	info->chip = chip;
 	info->i2c =
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 1bbba6bba673..cb14d41b53e9 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -825,10 +825,8 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
 		pirq = platform_get_irq(info->pdev, i);
-		if (pirq < 0) {
-			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
+		if (pirq < 0)
 			return pirq;
-		}
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
 		if (info->irq[i] < 0) {
 			dev_warn(&info->pdev->dev,
diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index 1bb32b7226d7..0d456fd28b21 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -168,11 +168,8 @@ static int bd70528_get_irqs(struct platform_device *pdev,
 
 	for (i = 0; i < ARRAY_SIZE(bd70528_chg_irqs); i++) {
 		irq = platform_get_irq_byname(pdev, bd70528_chg_irqs[i].n);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "Bad IRQ information for %s (%d)\n",
-				bd70528_chg_irqs[i].n, irq);
+		if (irq < 0)
 			return irq;
-		}
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						bd70528_chg_irqs[i].h,
 						IRQF_ONESHOT,
diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index f9314cc0cd75..a9c1af2706ab 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -466,10 +466,8 @@ static int da9150_charger_register_irq(struct platform_device *pdev,
 	int irq, ret;
 
 	irq = platform_get_irq_byname(pdev, irq_name);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, irq_name,
 				   charger);
@@ -487,10 +485,8 @@ static void da9150_charger_unregister_irq(struct platform_device *pdev,
 	int irq;
 
 	irq = platform_get_irq_byname(pdev, irq_name);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
+	if (irq < 0)
 		return;
-	}
 
 	free_irq(irq, charger);
 }
diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 6e367826aae9..026a98741c12 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -514,7 +514,6 @@ static int da9150_fg_probe(struct platform_device *pdev)
 	/* Register IRQ */
 	irq = platform_get_irq_byname(pdev, "FG");
 	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ FG: %d\n", irq);
 		ret = irq;
 		goto irq_fail;
 	}
diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index c2644a9fe80f..427347ce3841 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -221,10 +221,8 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	}
 
 	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
+	if (data->irq < 0)
 		return -ENODEV;
-	}
 
 	ret = devm_request_irq(&pdev->dev, data->irq,
 			       goldfish_battery_interrupt,
diff --git a/drivers/power/supply/jz4740-battery.c b/drivers/power/supply/jz4740-battery.c
index 6366bd61ea9f..517265ad3d70 100644
--- a/drivers/power/supply/jz4740-battery.c
+++ b/drivers/power/supply/jz4740-battery.c
@@ -258,10 +258,8 @@ static int jz_battery_probe(struct platform_device *pdev)
 	jz_battery->cell = mfd_get_cell(pdev);
 
 	jz_battery->irq = platform_get_irq(pdev, 0);
-	if (jz_battery->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
+	if (jz_battery->irq < 0)
 		return jz_battery->irq;
-	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index c890e1cec720..84cc9fba029d 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -929,11 +929,8 @@ static int smbb_charger_probe(struct platform_device *pdev)
 		int irq;
 
 		irq = platform_get_irq_byname(pdev, smbb_charger_irqs[i].name);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "failed to get irq '%s'\n",
-				smbb_charger_irqs[i].name);
+		if (irq < 0)
 			return irq;
-		}
 
 		smbb_charger_irqs[i].handler(irq, chg);
 
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 24895cc3b41e..04b9e8bb981f 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1030,10 +1030,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource specified\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(data->dev, irq, NULL,
 					sc27xx_fgu_interrupt,
-- 
Sent by a computer through tubes

