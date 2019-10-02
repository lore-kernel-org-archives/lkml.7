Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D5FC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D2A2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MWVzQOQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfJBRDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 13:03:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54490 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfJBRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so8003623wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ay1R6FhENJS8iuSt2hpBFZDMGFIotJho7ukRf5r3dck=;
        b=MWVzQOQN+uVNRPqyDGE93yTy5SoALgAqpLtzI7wvkE7DSnqH4tkxj6RbzO4XraolUb
         ma9o+W+VQJ0XgwIgfsDHYifdihGE9/VS3e1vL+8r3uQn876yl+lXcwg8MepgJpWnCdfA
         IL7Dvc/R5z9kD1C/6i9E2SsUg5rjAxoaXZtjMOkWGaGsTThQcGCoNX+jSAe2MB6Esmit
         8R7SCTcZnZe3S6O+W21LtAzfagisBoyWTBUiNtzrqb1pGX7hINXwmSLYnTA4m0tf0FA6
         CQmrWF/DLXj2KE9iXXop4VOauA3jsJQIRqBe+UqaojMJdyN1saBYLO1QWZgF4bJ8zPGr
         bgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ay1R6FhENJS8iuSt2hpBFZDMGFIotJho7ukRf5r3dck=;
        b=MNobgB0jNuZrMpYGHetcXLe9l/mFtDVZRm43hws3juwGH949xbt9zk0wYMYpwAJc8P
         u/QS9wsBnH6XlO2Dc8o7SU5e4QZaTnT2dTmjwKZu+U2qf6F83z+AI9YymUTlKGd+rgSO
         U1zR50Szfls1gl6ObtxRTcWJxtivKw4VXFuNPCzFTXsse6Sk82FIq5csSYhCbw41SsPj
         LZufcpolwWacmmFzwkMyoja5JXstM3YqLjJ1uKVLODZN4dusD+8WSy+G3PDjFIzg+X5O
         OOPEkGO77iNI3WNUtDBQx2vRKT2MiGFDi9YSMwxmSNcfwM3XVVd+RikPbKknRlI1E5xv
         wBug==
X-Gm-Message-State: APjAAAUsw5hobtVM1QJGqGJJ8r0M0RQy7LUB+lqsVmrJAhrZb8s61Hlh
        aE2XCLz0MoKX8MrYE7YrcTOBkA==
X-Google-Smtp-Source: APXvYqz22BjvpDGrKPhqCAJTVhgzXE+CXeU8J/gVwlnoocSXs5j7yKxbBPTecnnvvmjh8rOlPzlRpQ==
X-Received: by 2002:a1c:c14a:: with SMTP id r71mr3812504wmf.46.1570035783552;
        Wed, 02 Oct 2019 10:03:03 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b62sm11188575wmc.13.2019.10.02.10.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 10:03:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alban Bedel <albeu@free.fr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/6] gpio: htc-egpio: use devm_platform_ioremap_resource()
Date:   Wed,  2 Oct 2019 19:02:48 +0200
Message-Id: <20191002170249.17366-6-brgl@bgdev.pl>
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
 drivers/gpio/gpio-htc-egpio.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-htc-egpio.c b/drivers/gpio/gpio-htc-egpio.c
index 6eb56f7ab9c9..2d4b0b888f66 100644
--- a/drivers/gpio/gpio-htc-egpio.c
+++ b/drivers/gpio/gpio-htc-egpio.c
@@ -281,14 +281,9 @@ static int __init egpio_probe(struct platform_device *pdev)
 		ei->chained_irq = res->start;
 
 	/* Map egpio chip into virtual address space. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	ei->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ei->base_addr))
 		goto fail;
-	ei->base_addr = devm_ioremap_nocache(&pdev->dev, res->start,
-					     resource_size(res));
-	if (!ei->base_addr)
-		goto fail;
-	pr_debug("EGPIO phys=%08x virt=%p\n", (u32)res->start, ei->base_addr);
 
 	if ((pdata->bus_width != 16) && (pdata->bus_width != 32))
 		goto fail;
-- 
2.23.0

