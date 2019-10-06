Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D97C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E5020867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hrHDoGWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfJFFj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:39:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34704 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfJFFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:39:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so6452022pfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 22:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGpHJMNJmt0D2CtlAvF0BB0ayFvc7p4D4pLv8EbvGc0=;
        b=hrHDoGWgArLcjoy0hg4PkXWTSixMvbFbwkcCa91SIAZRFyGz1B9nRGPJWh7Yy7Ywkt
         e6JGXS3ykmBB5j1QyCEgvzPT77oLwZygN10YdkakXwi5qIw8CbuIVg0P3a2nS2uDk//r
         G18E/AHje4wYYlglCW7eN2fGPGHs5R1Bhm9FeNgF1LKq/J89/nwylmdNe6e08m2sEPPJ
         xU67f7DAAqMtaxiQssJRcLTQ21fI83dyecuUxXZD9VW/qE7B0iQM7+kZ4A1uGJUKxyLW
         Becd1uwkUIwNeh190VTOY7YdSa2bfjdB9WBlXpw9z66aR8H2fnZQnv0CPMgx31dpjJgM
         RyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGpHJMNJmt0D2CtlAvF0BB0ayFvc7p4D4pLv8EbvGc0=;
        b=Sl1D4l4xrLcUKnG3lTIEGhh5PjnUhcVh076txzCW/Lk5vHrB5dtwv4qZCZYyDu7Fc1
         cDMPPFin2UMfP0o1gvBlqQWmIUp4hokhgZKXdo8MZUqhwC8aHZWVXcMWXNh3V6FLDjK0
         VAnW7nlKNKFbJ7cd6qMySHXnhNrKa07h+UG4NtogI+E6yItOTUhuxQaJ8BMplbh+XcO3
         1MtmyvJD++6/vTOsXkSzXdpZp54pdDRkPKq3IW+EEEhXETgBx7YjwGFUfn9mbx1SU2Z4
         t2rZ70qalKbMJbNaSYgBWgrNbXnOZC5/0zDxD+7VHhfZnzsMpM4VktdBBBMsQmTub83Z
         wMTw==
X-Gm-Message-State: APjAAAVnzFjBcOEZ72H+0LC5i8BEKUu5dOCJcPoYrowncAsumI7QLtiu
        088Z0UAoLleRo4LW8ashnxeiqfxiyhIpew==
X-Google-Smtp-Source: APXvYqyZkMteRPmIT4lYcc/6t8ZvthXPr2H8kcWCAOiHeEc0hH0NUfT8n8WaSRKA29NDI6H98rKhmw==
X-Received: by 2002:a17:90a:f487:: with SMTP id bx7mr25496934pjb.83.1570340384435;
        Sat, 05 Oct 2019 22:39:44 -0700 (PDT)
Received: from debian-brgl.local (50-255-47-209-static.hfc.comcastbusiness.net. [50.255.47.209])
        by smtp.gmail.com with ESMTPSA id q30sm10019320pja.18.2019.10.05.22.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 22:39:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 7/8] gpio: mvebu: use devm_platform_ioremap_resource_byname()
Date:   Sun,  6 Oct 2019 07:39:15 +0200
Message-Id: <20191006053916.8849-8-brgl@bgdev.pl>
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

Use devm_platform_ioremap_resource_byname() instead of calling
platform_get_resource_byname() and devm_ioremap_resource() separately.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mvebu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6c0687694341..2f0f50336b9a 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -773,23 +773,12 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
-	struct resource *res;
 	u32 set;
 
 	if (!of_device_is_compatible(mvchip->chip.of_node,
 				     "marvell,armada-370-gpio"))
 		return 0;
 
-	/*
-	 * There are only two sets of PWM configuration registers for
-	 * all the GPIO lines on those SoCs which this driver reserves
-	 * for the first two GPIO chips. So if the resource is missing
-	 * we can't treat it as an error.
-	 */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
-	if (!res)
-		return 0;
-
 	if (IS_ERR(mvchip->clk))
 		return PTR_ERR(mvchip->clk);
 
@@ -812,7 +801,13 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
 
-	mvpwm->membase = devm_ioremap_resource(dev, res);
+	/*
+	 * There are only two sets of PWM configuration registers for
+	 * all the GPIO lines on those SoCs which this driver reserves
+	 * for the first two GPIO chips. So if the resource is missing
+	 * we can't treat it as an error.
+	 */
+	mvpwm->membase = devm_platform_ioremap_resource_byname(pdev, "pwm");
 	if (IS_ERR(mvpwm->membase))
 		return PTR_ERR(mvpwm->membase);
 
-- 
2.23.0

