Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69220C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B48520644
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OHA6ZMLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfH2OiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:38:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40670 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfH2OiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:38:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id t9so4117590wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgfAZbIXAtNJprrW3SR0FliLWlC8AUtP5591I4qRBtY=;
        b=OHA6ZMLqe/FTFL2xNuAXTK+TBgAKyi+kqTTKdnKXX1LoJLLUaqfpaIDH80qz5G53lj
         QOcrfIIT8VtYsVJ+uzUnnAr9ePxDPZ0U3SmOPSVHkGdgKBcBKeQkagn5uIrnyXbsXZ2S
         pk+qv3B052Jku7CFwX9WO3ZSvzmGoA4DQKbVXfjF0RIb8e/i5HDsR/eZFIxK8GhUnG+g
         veayX5RYCXnynnzo2FraoNmeHpg83yGR5Q+9H9MXM7iDDwOgDTQ1WkzUYSZEnFhEC8r2
         2zFaWnuJWNAoJPB6E2ykJqQ4W/wzlViTWG1Xw9469/MIt0hutmGw9FrgF+l4L7Zw7Cw8
         WYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgfAZbIXAtNJprrW3SR0FliLWlC8AUtP5591I4qRBtY=;
        b=Zy4dDxhRyYlvfg1Nn0e07UOPWagZYubAhkUVBOstc25qv2lJ8ZCWltSDT3NlNJjvLA
         lvCA8EvmdowWxIE8Wosd6RUx4pY6+QhLlRI0ivr+t5Qzn/Y7GRNbrosK7rW8SCECebKM
         aNFSKyEdTspFVOR2dZoOXeqsfb/727RPrnNtETROtv6WOG0Wdl8Q3niupafDmCVj9gEV
         3clNuXDZd3WYBq4rCLlc8dN2+RZLEKfdr7trFnSajzyMGPFsKuaZI+sLcMCkmywKfi4m
         q9U3OvJs8S5qBi4PaQiLluGBjNJUxUlhYlnpg/MLbGhmL2dUZShCvp75zMbq7fjIlHVe
         dBYA==
X-Gm-Message-State: APjAAAVBSAnUdf+VEmRk8TkhLoLmxST7el0ey58RFS9qs13WY6lgCjSj
        kk+VEmNGHRy5Mg21T5KQAXVaMA==
X-Google-Smtp-Source: APXvYqx+mVH1b84lDgcY8MIGudq3AQBFxK3n8O8b4xXyWDNctXSvSXo7mIwyPPqoRATFo5+lYE7kaQ==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr11652532wmj.71.1567089491346;
        Thu, 29 Aug 2019 07:38:11 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id g15sm3241925wrp.29.2019.08.29.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:38:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 7/9] gpio: htc-egpio: use devm_platform_ioremap_resource_nocache()
Date:   Thu, 29 Aug 2019 16:37:40 +0200
Message-Id: <20190829143742.24726-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143742.24726-1-brgl@bgdev.pl>
References: <20190829143742.24726-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new devm_platform_ioremap_resource_nocache() helper for memory
range mapping instead of devm_ioremap_nocache() combined with a call to
platform_get_resource().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-htc-egpio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-htc-egpio.c b/drivers/gpio/gpio-htc-egpio.c
index 9d3ac51a765c..7d8548e03226 100644
--- a/drivers/gpio/gpio-htc-egpio.c
+++ b/drivers/gpio/gpio-htc-egpio.c
@@ -295,14 +295,13 @@ static int __init egpio_probe(struct platform_device *pdev)
 		ei->chained_irq = res->start;
 
 	/* Map egpio chip into virtual address space. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	ei->base_addr = devm_platform_ioremap_resource_nocache(pdev, 0);
+	if (IS_ERR(ei->base_addr)) {
+		ret = PTR_ERR(ei->base_addr);
 		goto fail;
-	ei->base_addr = devm_ioremap_nocache(&pdev->dev, res->start,
-					     resource_size(res));
-	if (!ei->base_addr)
-		goto fail;
-	pr_debug("EGPIO phys=%08x virt=%p\n", (u32)res->start, ei->base_addr);
+	}
+	pr_debug("EGPIO phys=%08x virt=%p\n",
+		 virt_to_phys(ei->base_addr), ei->base_addr);
 
 	if ((pdata->bus_width != 16) && (pdata->bus_width != 32))
 		goto fail;
-- 
2.21.0

