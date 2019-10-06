Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B430C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9E420867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zlR7f3v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfJFFjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:39:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33581 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJFFjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:39:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so6180165pgb.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 22:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+2cCkacS0/wsdoq+AhwYBV7HAjDIr1+29FN1l6fATg=;
        b=zlR7f3v6X6VUHlmDnEU4rDms8pwdJwwfFhghIIGBJMCzHM+Mj8Y7hUSVAPN0Cb3JOg
         Gm1vfy2oFYliCkbSbasts3bHObYD0QK3/P+QRlH+MLIu6JUPoNPUJX3DII2meRrAWwGr
         YjFpHV0GPS32lYoKZOyL5VPwSibzj5KfsIxaHChxOFonp1xGLXserUJLx0Xkcf6/tvbT
         NMM/+taLAaPaayKF7G4IdbGr711z5zaq516AdwGkTIp4VT57hPZnoPGCcu7WBQv1ZFXG
         qzMnxm4i8bUffPu72P/i3mrXDqUB3N/0jNUtK8frmZxI4vCCOIhbpGhZSJCbx8+SKI3H
         Bwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+2cCkacS0/wsdoq+AhwYBV7HAjDIr1+29FN1l6fATg=;
        b=BPj6tlNBVJ8hX0eUBV2oqZPRBiM+Cle6WE+JAbt6gQTvNH7AQboWOylzcx/xLcQLXz
         CAQ2Sia2lo1cuK9KykAnSNWn97OOF0Y1UiIjo+n1iGNjffTTb3obkpXG0kJJt/aSKNhb
         fUMRg/9PYNfi1oShKdgQn53MsXLyh2LQZJqHS8JaU22rKybp+H1c+FbcNyzhPPpRzmxX
         La4c9TmVJoFW/6JCt+Fa8dpypN+RPeK6A4Pi7x4lyfb48cmU8WWmaEv6JDWeDoY3aQ5r
         rYhJGMEkUnY1ljiaKG41z2b7gpkUwlAnSR4TsSCAcRvUcmMQUYkOyBpkAxEDIEpUKLwK
         G8Tg==
X-Gm-Message-State: APjAAAWK9sSuivsX4dNcVxlIy1LmpuirtmtRZtaW3npNet3Em9z+B+TN
        RIndhl8wh1NA0j0YA4/hDdQjbg==
X-Google-Smtp-Source: APXvYqxK3lP1b5O5P9pkwJr2DSVKlg5gfYiK+vKbxwea7k+/ZUAKfLagdWTvWlycO53oE5WA3dKsUQ==
X-Received: by 2002:aa7:99da:: with SMTP id v26mr26356523pfi.258.1570340385338;
        Sat, 05 Oct 2019 22:39:45 -0700 (PDT)
Received: from debian-brgl.local (50-255-47-209-static.hfc.comcastbusiness.net. [50.255.47.209])
        by smtp.gmail.com with ESMTPSA id q30sm10019320pja.18.2019.10.05.22.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 22:39:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 8/8] gpio: tegra186: use devm_platform_ioremap_resource_byname()
Date:   Sun,  6 Oct 2019 07:39:16 +0200
Message-Id: <20191006053916.8849-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006053916.8849-1-brgl@bgdev.pl>
References: <20191006053916.8849-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-tegra186.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index a9058fda187e..ef40fbe923cf 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -407,7 +407,6 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	unsigned int i, j, offset;
 	struct gpio_irq_chip *irq;
 	struct tegra_gpio *gpio;
-	struct resource *res;
 	char **names;
 	int err;
 
@@ -417,8 +416,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 
 	gpio->soc = of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpio");
-	gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	gpio->base = devm_platform_ioremap_resource_byname(pdev, "gpio");
 	if (IS_ERR(gpio->base))
 		return PTR_ERR(gpio->base);
 
-- 
2.23.0

