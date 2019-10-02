Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82261C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569A82086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Y/tPOogz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfJBRDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:03:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36935 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJBRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so7738248wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssSGrDoEZXjC6vgHTplGH5VegZUKxz/uV2LEv4gtU9A=;
        b=Y/tPOogzRhUsBcTwTzXUpCbmuvxZ3KvnL73hp9GwV9FY6WfOwPwoqsKTE8vZD4RzHt
         e/XpWlMT0xwZtFnTrrFm5FIZx+vssgmb7m4HeJe9n9XoOIIIfaOsabQh4R1KFe6jnk3d
         El/pNBmQqhtIFukCw4X3ui7E0Pd587xFmqR7XeiLK7I1XYpVv9iyxBVffh4zgY0F8C9d
         noflppDrZkRvrj8ww2YrDcg/Khk1ccnY+kB+R9j9X/nFscAS4oD22dyZb+qEMkml2WNq
         e8SgA6dNBBJ/p+sUm89G2sN7mwYf56ktUjqM4LJIDdjVippWood/orglHiGVoerjw8tE
         8uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssSGrDoEZXjC6vgHTplGH5VegZUKxz/uV2LEv4gtU9A=;
        b=afMWSMA2meys3ea1lD2o9k3OFeSI2/WvbWGoCHiyQk6HvDDM3P0OyGbuH74fjKDE/n
         4U/Y0bVh5s5r9CA6PDqrM8BGZhZ4DlI8k3XzhIV1UK9P10dQdiKA1apQ4xYht1YP7qcT
         56BiyPLQ75GBuSRGKBYLcZoU13f6LusgTGH0Ek28/9Wt0mRBqCY0VmLH/Do3gZB0NwgK
         ECWSVc/jSeC00bQVQ5+QpU77y/rrytEvX/z6VCIWChVcHlG8iqL+XLC1NbNU2FzJneRL
         EgiWq5L5EOFM+bv6ZOCW7qCW/X9ucil5DHQDIV164MKuEslR7wlhZklghvVXRCnJoK1v
         1R8g==
X-Gm-Message-State: APjAAAXUBViyMG/hCssllQWFCizI4kVXiY0D4ugOA4wE0MmY6whd3m+w
        0olYjmgezibDLZHPFa9mSMT8Rg==
X-Google-Smtp-Source: APXvYqxSag048je5/Sf/lXiTUZWfGX0HUpCiIJloHGTbYyS9k10IQQh6x04dsCgii2F1d5i49hUYMA==
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr3867317wmo.67.1570035781189;
        Wed, 02 Oct 2019 10:03:01 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b62sm11188575wmc.13.2019.10.02.10.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:03:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alban Bedel <albeu@free.fr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/6] gpio: em: use devm_platform_ioremap_resource()
Date:   Wed,  2 Oct 2019 19:02:46 +0200
Message-Id: <20191002170249.17366-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002170249.17366-1-brgl@bgdev.pl>
References: <20191002170249.17366-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no need to use the nocache variant of ioremap(). Switch to
using devm_platform_ioremap_resource().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-em.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 620f25b7efb4..674ebebaf90b 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -269,7 +269,7 @@ static void em_gio_irq_domain_remove(void *data)
 static int em_gio_probe(struct platform_device *pdev)
 {
 	struct em_gio_priv *p;
-	struct resource *io[2], *irq[2];
+	struct resource *irq[2];
 	struct gpio_chip *gpio_chip;
 	struct irq_chip *irq_chip;
 	struct device *dev = &pdev->dev;
@@ -285,25 +285,21 @@ static int em_gio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 	spin_lock_init(&p->sense_lock);
 
-	io[0] = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	io[1] = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	irq[0] = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	irq[1] = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
 
-	if (!io[0] || !io[1] || !irq[0] || !irq[1]) {
+	if (!irq[0] || !irq[1]) {
 		dev_err(dev, "missing IRQ or IOMEM\n");
 		return -EINVAL;
 	}
 
-	p->base0 = devm_ioremap_nocache(dev, io[0]->start,
-					resource_size(io[0]));
-	if (!p->base0)
-		return -ENOMEM;
+	p->base0 = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(p->base0))
+		return PTR_ERR(p->base0);
 
-	p->base1 = devm_ioremap_nocache(dev, io[1]->start,
-				   resource_size(io[1]));
-	if (!p->base1)
-		return -ENOMEM;
+	p->base1 = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(p->base1))
+		return PTR_ERR(p->base1);
 
 	if (of_property_read_u32(dev->of_node, "ngpios", &ngpios)) {
 		dev_err(dev, "Missing ngpios OF property\n");
-- 
2.23.0

