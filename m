Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B92C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703B021920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oU2eWDds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfJBQZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37169 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfJBQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so20411254wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1RoqAjzF3G4A46AecyEHP/0DwVF1CG1yV8jnN1Ft9k=;
        b=oU2eWDdsPJbgkwBSAojF1ydsbfdXQ2H8oJVMQlUR9v2me8lZX+eAKBCfECS+hvIGne
         0f+rXqzuFBfcQgQ+tKAgPMXk1R8dNc6QSxo1T7K3jWrx4aBz+57GqNX92i05pg33Yf1U
         dKVivVkJ5zv44QsrhrowsRDSGZKJWElgs5MrATPmROEuqof74ourH11Ec+kdtU7rJ7Zp
         kFBE4CxrpWecvCy+/WTlmJ/QGHQSDM0CXkH+ZobVOOBRdK++u+FrLkgMfwkGl9Yys+xs
         LnaNuWuThRB+PWafhWKOehz9n4eK7jI+91BoZ9DRRgir5YioDNShbYztwR7Mrps7QYj9
         tvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1RoqAjzF3G4A46AecyEHP/0DwVF1CG1yV8jnN1Ft9k=;
        b=OW7ovQZJwe2DBYPsxO2kawVHoMRHVbS0M9zFxwqMG4ynd6S98DvEa2JQntBl//D0p+
         wvnL3ScEueXe3kM3nxFuLFQ5ZcF8ZzDjCW9CmZxg47kjKR2EXlE6BN+OFMEHpwOuQ9iO
         12fyM2VHEZoNCfbyarWE92X5P4C8nGOyQZxaOeoS3/p6KflQBWhgRSmghUH0/U4syTrT
         OsEfK9HQdfT25X58Xl7oVWeOV6Q9Os/5JTE3gmOOT3jPuUche8qfHGfTDWhX/3RiT0zV
         o4A3gkX2gCEnCpr+RqzLRb57G+mcwfvgdNeiVsDT9/BnnsRTyEjdYCSfYr3+UZZXg3lt
         ZliQ==
X-Gm-Message-State: APjAAAWwA/saOqOjEKk13IqCCFL9wy/fbmlWVXvIEg/S9Zlr2KRqDtoA
        Q//OCbwQ8PkVbYC0HLeOBr+jLw==
X-Google-Smtp-Source: APXvYqy8icFIcD1CSaKA1Gyz0LIthq4vwkjlhaKoQqDFQsV6hH7GekmZP/9sPZ0XD1f6Q00CbVn0DQ==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr3341719wrw.386.1570033545387;
        Wed, 02 Oct 2019 09:25:45 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id w9sm3482067wrt.62.2019.10.02.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:25:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 5/5] misc: sram: use devm_platform_ioremap_resource_wc()
Date:   Wed,  2 Oct 2019 18:25:34 +0200
Message-Id: <20191002162534.3967-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002162534.3967-1-brgl@bgdev.pl>
References: <20191002162534.3967-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the new devm_platform_ioremap_resource_wc() helper instead of
devm_ioremap_wc() combinded with a call to platform_get_resource().
Also use devm_platform_ioremap_resource() where applicable.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/sram.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index f30448bf3a63..6c1a23cb3e8c 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -340,8 +340,6 @@ static const struct of_device_id sram_dt_ids[] = {
 static int sram_probe(struct platform_device *pdev)
 {
 	struct sram_dev *sram;
-	struct resource *res;
-	size_t size;
 	int ret;
 	int (*init_func)(void);
 
@@ -351,25 +349,14 @@ static int sram_probe(struct platform_device *pdev)
 
 	sram->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(sram->dev, "found no memory resource\n");
-		return -EINVAL;
-	}
-
-	size = resource_size(res);
-
-	if (!devm_request_mem_region(sram->dev, res->start, size, pdev->name)) {
-		dev_err(sram->dev, "could not request region for resource\n");
-		return -EBUSY;
-	}
-
 	if (of_property_read_bool(pdev->dev.of_node, "no-memory-wc"))
-		sram->virt_base = devm_ioremap(sram->dev, res->start, size);
+		sram->virt_base = devm_platform_ioremap_resource(pdev, 0);
 	else
-		sram->virt_base = devm_ioremap_wc(sram->dev, res->start, size);
-	if (!sram->virt_base)
-		return -ENOMEM;
+		sram->virt_base = devm_platform_ioremap_resource_wc(pdev, 0);
+	if (IS_ERR(sram->virt_base)) {
+		dev_err(&pdev->dev, "could not map SRAM registers\n");
+		return PTR_ERR(sram->virt_base);
+	}
 
 	sram->pool = devm_gen_pool_create(sram->dev, ilog2(SRAM_GRANULARITY),
 					  NUMA_NO_NODE, NULL);
@@ -382,7 +369,8 @@ static int sram_probe(struct platform_device *pdev)
 	else
 		clk_prepare_enable(sram->clk);
 
-	ret = sram_reserve_regions(sram, res);
+	ret = sram_reserve_regions(sram,
+			platform_get_resource(pdev, IORESOURCE_MEM, 0));
 	if (ret)
 		goto err_disable_clk;
 
-- 
2.23.0

