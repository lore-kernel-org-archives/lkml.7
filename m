Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CB6C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECD120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mshvlYNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfDCECK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:02:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37702 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfDCECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:02:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so7459715pfr.4;
        Tue, 02 Apr 2019 21:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HOj5AcsPPIUP9eNWZ5uQOH1gzbtnepnAaSzlGF2WO8=;
        b=mshvlYNL7Y3Ctd1PpKGF/38N3zF4DnPDyUJmXs7lu14zGu+fgPkReT7E8vx3wEBIIi
         LRMXuv5JsRITmYy+5R0uGqhF2D5wsvZp4HKiQwi7eIWPS/0el7yIw0lRN5OOFnrGPQs6
         EY+eAXlZQMlegGl8GD8wApevIG9qwr3yl8YB14Daa08F49bvnv0+tSiyFo0aff2j4G9T
         WESqkAK7u/9VuBjJf9kmRUPAEQxtCb1Vywv14hPfbbLqTYJQyciHWzwV5nBgpUxRaI9T
         1TT/5StA8t9A+PPXtdulLhUMMYZe5NnvWstvrL1eUUdxY6EQOUTNKEP1xNXaKb13lhdL
         0bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HOj5AcsPPIUP9eNWZ5uQOH1gzbtnepnAaSzlGF2WO8=;
        b=mWns6ZRQsPjmoKIB8fiFyr3J36dnERek1JmQcv8nr14dV0cKmVrKv9850t7PCJlUzw
         2jk4jdNjMCOHAzJUethEFlXSC5vhYHL8yhyu1DPapZQlqDJk7B54ZRcBRrWJOWC4rSur
         feH6Ct/pMLSkQmRkpmQuOgIYROUPg81NyM86u43MSn3Eb3F8cKjYIjhqrEPywX6+9IXJ
         xrzAPN0ZdYD/9FiGHcA5/deod+NXciePWCt/fz5tRVEAPZ5gVvxeKzjKCXaSc2ARHMxo
         KqUyi9MIAQ4JM5C+3omLUodGi9O41iTysllrOZFlgzjp/k86zvqgXXtfY1pnZpbOgJI8
         VPiw==
X-Gm-Message-State: APjAAAUi6d7V1xUhI41SnSmS3FVCu1VUCpvt4RpruibvZ9oHF95Jy1E4
        KR3AGsApz+X7uaWgGCv7V591bLet
X-Google-Smtp-Source: APXvYqwVaJX8j3M/byMDW7Q8RRDk3NV2jI8WNad7Iz7Y92HtWj+VNLoxmtQdPklCl8I8wky/Zps6vQ==
X-Received: by 2002:a63:c706:: with SMTP id n6mr37001637pgg.310.1554264125998;
        Tue, 02 Apr 2019 21:02:05 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:02:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] spi: gpio: Use devm_spi_register_master()
Date:   Tue,  2 Apr 2019 21:01:33 -0700
Message-Id: <20190403040133.1459-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spi_bitbang_start() with a combination of spi_bitbang_init()
and devm_spi_register_master() and drop all of the explicit
cleanup-related code that's no longer necessary.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 668f2cd82d98..674432bbbbc2 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -397,8 +397,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 
 	spi_gpio = spi_master_get_devdata(master);
 
-	platform_set_drvdata(pdev, spi_gpio);
-
 	status = spi_gpio_request(dev, spi_gpio);
 	if (status)
 		return status;
@@ -438,19 +436,11 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	}
 	bb->setup_transfer = spi_bitbang_setup_transfer;
 
-	return spi_bitbang_start(&spi_gpio->bitbang);
-}
-
-static int spi_gpio_remove(struct platform_device *pdev)
-{
-	struct spi_gpio			*spi_gpio;
-
-	spi_gpio = platform_get_drvdata(pdev);
-
-	/* stop() unregisters child devices too */
-	spi_bitbang_stop(&spi_gpio->bitbang);
+	status = spi_bitbang_init(&spi_gpio->bitbang);
+	if (status)
+		return status;
 
-	return 0;
+	return devm_spi_register_master(&pdev->dev, spi_master_get(master));
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
@@ -461,7 +451,6 @@ static struct platform_driver spi_gpio_driver = {
 		.of_match_table = of_match_ptr(spi_gpio_dt_ids),
 	},
 	.probe		= spi_gpio_probe,
-	.remove		= spi_gpio_remove,
 };
 module_platform_driver(spi_gpio_driver);
 
-- 
2.20.1

