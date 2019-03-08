Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E06C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84F02081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="M3+0Z0d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCHGPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:15:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43629 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCHGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:15:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so13358257pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 22:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=G4xXGxWN9gs6z/ItOYkyXHmNhR64gT4zdf6vWPju1lE=;
        b=M3+0Z0d8lGfKMDlEHgBRhRBrEN7wEUH7ptdstyZxbwTmMTzdz17i9wHzdJeQOB9Tjw
         Ud2/FVf66UihfmII609frrfZvvzag3hamUI5HJLBWlEU4tQhURLLqr+3FYaw8fHOHA/s
         swnr/Dq+sEFpUkW+d1J1plWL6FAUXhX4Mw2b2PJngc44T0KxA2O5CaUJUEXBD5T6f+0j
         ywyKIVZv4DxXdcxMks8wpVjOBu5WuG5CKGYCNW/LK3YAqVf2GSKlttlerXuV10pzUO/d
         p0tRinDJV/DV8WfUBu7pGgfJzxu8oheUstOYbrKPIJcqexlr0Z8gwG29yJEI74+2OAco
         g8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G4xXGxWN9gs6z/ItOYkyXHmNhR64gT4zdf6vWPju1lE=;
        b=YFYI5ezFSvoAe2r/uhYTG8ZR1i6CgYNHLLOh0/5Cg6F+BHXOzszb0UcWKmHveveIAh
         vcMvxCtGZ1XgIKb/APQDAl++ec0KYsZaKU9gqh/BHjUU2/Ie91t5neuJ3uYNmG5KWNPU
         0+n4pAS0RQyUIfybZJVrQSTj03sRGNlPyjDe7islGzRwXMTEbYAKwQE/rYQAjwxpLXXu
         kBcf2gRM6+cjWV8CJf/opftgzB2dPRqAdgM2tabCXn8PZbunX/iugFiGWcHHpzWKsVHT
         j6GsSVB17Smg8i2sHeuDNwffB1Ede2tJl43FG3ZC/KnezVD9Go4ZysVGt/5CdVZ1IZ8s
         vT+A==
X-Gm-Message-State: APjAAAVX6TwjQ4pku2jdoXyPCbbJqtjQ5JlITt/vBFMXiJXz9zQxY5Jw
        H0b/Euvj9ZRBXp3sJRy1ryC1TQ==
X-Google-Smtp-Source: APXvYqynHBAGKAgrtQxrtYRWklRbF9Ld8w+/EynJFUiDCxz+irJv7TO/eBPciapTXeWrdHGeEQQZuA==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr2908895plb.69.1552025740969;
        Thu, 07 Mar 2019 22:15:40 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id b65sm11484765pfm.127.2019.03.07.22.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 22:15:40 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: gpio: Convert to devm_regulator_register
Date:   Fri,  8 Mar 2019 14:15:28 +0800
Message-Id: <20190308061529.31394-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regulator_register to simplify the code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/gpio-regulator.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 6157001df0a4..967338bf1dc1 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -36,7 +36,6 @@
 
 struct gpio_regulator_data {
 	struct regulator_desc desc;
-	struct regulator_dev *dev;
 
 	struct gpio_desc **gpiods;
 	int nr_gpios;
@@ -233,6 +232,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct gpio_regulator_data *drvdata;
 	struct regulator_config cfg = { };
+	struct regulator_dev *rdev;
 	enum gpiod_flags gflags;
 	int ptr, ret, state, i;
 
@@ -326,9 +326,9 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg.ena_gpiod))
 		return PTR_ERR(cfg.ena_gpiod);
 
-	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
-	if (IS_ERR(drvdata->dev)) {
-		ret = PTR_ERR(drvdata->dev);
+	rdev = devm_regulator_register(dev, &drvdata->desc, &cfg);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
 		dev_err(dev, "Failed to register regulator: %d\n", ret);
 		return ret;
 	}
@@ -338,15 +338,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpio_regulator_remove(struct platform_device *pdev)
-{
-	struct gpio_regulator_data *drvdata = platform_get_drvdata(pdev);
-
-	regulator_unregister(drvdata->dev);
-
-	return 0;
-}
-
 #if defined(CONFIG_OF)
 static const struct of_device_id regulator_gpio_of_match[] = {
 	{ .compatible = "regulator-gpio", },
@@ -357,7 +348,6 @@ MODULE_DEVICE_TABLE(of, regulator_gpio_of_match);
 
 static struct platform_driver gpio_regulator_driver = {
 	.probe		= gpio_regulator_probe,
-	.remove		= gpio_regulator_remove,
 	.driver		= {
 		.name		= "gpio-regulator",
 		.of_match_table = of_match_ptr(regulator_gpio_of_match),
-- 
2.17.1

