Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F3C74A50
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C7921019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hDRkpqgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfGKI3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:29:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46143 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfGKI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:29:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so5224143wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 01:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdHUqoEiI/8PFzP+nb28CeapgJPIaOc+zD/Fqu3mxsA=;
        b=hDRkpqgQiAzNXdREpgCryNPTTpkPxbaw2kKafW0BWjDICnyBpzULAh4PkGTmfT/Qb+
         OxHtAeKq6KLpAH+7IBPhIpFhpjblmzu3ovCNDSEhBaF9Ysa+VCyYTxIb+Wev658fvedi
         /ODbN7gEOOBry0AtyeoYvGDzvFYpiPGE0nyji8nrrCO2pRi3UqbLr61ee30Z3rWlfR6Q
         60g1qCgqxDvqQbfHLDkz+aX9Shl7IkFYfeI5cKjnjIVi8IETiVrQns/g/HSvFCDnNj8H
         xtq6UwHdRMxmNGfWNmhVLHeJiRNZI4niFsR4L/9sxg20TIAcJq2G7WgC2a5lJ4U/jgTm
         943A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FdHUqoEiI/8PFzP+nb28CeapgJPIaOc+zD/Fqu3mxsA=;
        b=oNybzhadfXJ2UiIZ34ju8ox7qG+27LkZflfTipCOH1Fqhx2e+KNv5JwkuSmUGqb/qe
         ksX4VOdUZJ2QoYe3GMGttMEoBn6vT/vvZvvv2Aegb/99qaINAJKm4g2kISCtVtnWeJt+
         svT+JW5LTHJ4AQjrK6BRrrYTs0xBlqqi8T+DGP2fl2MsVhbPlYnzQH9j3yDhfKfpb7UJ
         ewOfFOO1650VcYMsnbE1Szwz6YpAQ/GITqYkDcKhK2InSsy4CgMD2JK3e5T9cbyfMDJ3
         AIacYzUKqBAtHny30rjfXJYz45To1zsfJu+K7Hkv8HfvHtmHT8HzEk/1vNbANHsxdvxc
         EssA==
X-Gm-Message-State: APjAAAUwEVJ88d9J5Tv4w0nXsLDVkTbI1cIY7OixpSMq9jj9gonxR+Sh
        W7aXDt1xU3Et2m9kEmCTSGU=
X-Google-Smtp-Source: APXvYqwchytOtZ9tsjAn0HXoKcFxOTCKPL1ct7E9RABxwigkhJc8CkAKO3nNjvDrpBZVqamEnzg7bw==
X-Received: by 2002:adf:f888:: with SMTP id u8mr3343527wrp.238.1562833782970;
        Thu, 11 Jul 2019 01:29:42 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id x20sm9374781wrg.10.2019.07.11.01.29.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 01:29:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Reid <preid@electromag.com.au>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] gpio: em: remove the gpiochip before removing the irq domain
Date:   Thu, 11 Jul 2019 10:29:35 +0200
Message-Id: <20190711082936.8706-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In commit 8764c4ca5049 ("gpio: em: use the managed version of
gpiochip_add_data()") we implicitly altered the ordering of resource
freeing: since gpiochip_remove() calls gpiochip_irqchip_remove()
internally, we now can potentially use the irq_domain after it was
destroyed in the remove() callback (as devm resources are freed after
remove() has returned).

Use devm_add_action_or_reset() to keep the ordering right and entirely
kill the remove() callback in the driver.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 8764c4ca5049 ("gpio: em: use the managed version of gpiochip_add_data()")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- use devm_add_action_or_reset() to automatically remove the domain if
  the underlying devm_add_action() fails

 drivers/gpio/gpio-em.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index b6af705a4e5f..a87951293aaa 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -259,6 +259,13 @@ static const struct irq_domain_ops em_gio_irq_domain_ops = {
 	.xlate	= irq_domain_xlate_twocell,
 };
 
+static void em_gio_irq_domain_remove(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
 static int em_gio_probe(struct platform_device *pdev)
 {
 	struct em_gio_priv *p;
@@ -333,39 +340,30 @@ static int em_gio_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, em_gio_irq_domain_remove,
+				       p->irq_domain);
+	if (ret)
+		return ret;
+
 	if (devm_request_irq(&pdev->dev, irq[0]->start,
 			     em_gio_irq_handler, 0, name, p)) {
 		dev_err(&pdev->dev, "failed to request low IRQ\n");
-		ret = -ENOENT;
-		goto err1;
+		return -ENOENT;
 	}
 
 	if (devm_request_irq(&pdev->dev, irq[1]->start,
 			     em_gio_irq_handler, 0, name, p)) {
 		dev_err(&pdev->dev, "failed to request high IRQ\n");
-		ret = -ENOENT;
-		goto err1;
+		return -ENOENT;
 	}
 
 	ret = devm_gpiochip_add_data(&pdev->dev, gpio_chip, p);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add GPIO controller\n");
-		goto err1;
+		return ret;
 	}
 
 	return 0;
-
-err1:
-	irq_domain_remove(p->irq_domain);
-	return ret;
-}
-
-static int em_gio_remove(struct platform_device *pdev)
-{
-	struct em_gio_priv *p = platform_get_drvdata(pdev);
-
-	irq_domain_remove(p->irq_domain);
-	return 0;
 }
 
 static const struct of_device_id em_gio_dt_ids[] = {
@@ -376,7 +374,6 @@ MODULE_DEVICE_TABLE(of, em_gio_dt_ids);
 
 static struct platform_driver em_gio_device_driver = {
 	.probe		= em_gio_probe,
-	.remove		= em_gio_remove,
 	.driver		= {
 		.name	= "em_gio",
 		.of_match_table = em_gio_dt_ids,
-- 
2.21.0

