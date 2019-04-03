Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5548C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46422084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7j6MPR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDCEB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:01:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45032 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCEBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:01:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so7441246pfm.11;
        Tue, 02 Apr 2019 21:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXdsa+2KWn8DAZgbfHHYyO+0se1bIoGL2CFNu28TrmY=;
        b=a7j6MPR7XLKdGlqUQuEnwGPzcOTUBmf9eLl0p5ceJwDl6DF/dLwa0iON/Wo3bHD8IJ
         pt/YCBBNjrtSySM76empw64qwzk8JBfOryyse3zj5mO2t7Vhrf4laSF6EOKU3UhLGLUY
         o6Pzb9TqXD5Plj9H25j3UDQmVopFjcdB2UU7An7VJtsvsNIG7FGEveIG3uSv79eYmZYi
         q0WPUq3MyW3N271Rs5erfJTnDhMslZTN7DrRkizvY4C5B2fMbSxsOzyill+hGRUgXni5
         aqzxeDSPk038NcvYNYIJsB+78UyRXFC7/g4UEckMgzjWLKJPczhUnR7BgSntSM2GvKFT
         slww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXdsa+2KWn8DAZgbfHHYyO+0se1bIoGL2CFNu28TrmY=;
        b=auaUOU/PsaBKnXxToe26xw3WfvdoUBuEzq4r7kFR9RKucC9rDk3dvjGH9TUIIibHTn
         4Da4gr4Ns3HypZ8HaQIaUd3zCGU0lAx1lSt9AD95JdRg+eBHIipDZHxHNybvMaKd/1r2
         j5vbvqhtEA6PFbwo9VQUCcU4jGwM9yIXfBkQH83GmO0kt13M3/FCZCE9cbKIH03P6A7s
         J2I4e9pnLv2dMeJ8ILzAd4DZ8Psl16CivZVciBxAwpyDcuJQFd7zEXAESaOYAnykYELr
         bR6dXdOaexUTE79OD8Lszo4N7q8RHdZXepciNgqXZmJrlTRU4vz6DQl0g9MarBN+SzjV
         GJ7A==
X-Gm-Message-State: APjAAAWNLHo7IGE9/7b88+udivnBFd+29lOGO5F8/LG+7ZUtuzCxPM+J
        B/9FkNYwwvMT+3fA2Sd0404S6z7n
X-Google-Smtp-Source: APXvYqx/JygKJndt7MjAfGuoPWrbcrV+adfQo/TrlVGGlJvLtg1o+1mtz7iqwqukMbay6Mdy+GOSBA==
X-Received: by 2002:a63:5e43:: with SMTP id s64mr9729024pgb.15.1554264112696;
        Tue, 02 Apr 2019 21:01:52 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k14sm16278064pfb.125.2019.04.02.21.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:01:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] spi: gpio: Add local struct device pointer in spi_gpio_probe()
Date:   Tue,  2 Apr 2019 21:01:23 -0700
Message-Id: <20190403040133.1459-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct device *dev" in spi_gpio_probe() for brevity. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-gpio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 675fd65ebf1d..2869af5ff936 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -379,6 +379,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
+	struct device			*dev = &pdev->dev;
 	u16 master_flags = 0;
 	bool use_of = 0;
 
@@ -388,19 +389,19 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status > 0)
 		use_of = 1;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	pdata = dev_get_platdata(dev);
 #ifdef GENERIC_BITBANG
 	if (!pdata || (!use_of && !pdata->num_chipselect))
 		return -ENODEV;
 #endif
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio));
+	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
 		return -ENOMEM;
 
 	spi_gpio = spi_master_get_devdata(master);
 
-	spi_gpio->cs_gpios = devm_kcalloc(&pdev->dev,
+	spi_gpio->cs_gpios = devm_kcalloc(dev,
 				pdata->num_chipselect,
 				sizeof(*spi_gpio->cs_gpios),
 				GFP_KERNEL);
@@ -416,7 +417,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (pdata)
 		spi_gpio->pdata = *pdata;
 
-	status = spi_gpio_request(&pdev->dev, spi_gpio,
+	status = spi_gpio_request(dev, spi_gpio,
 				  pdata->num_chipselect, &master_flags);
 	if (status)
 		return status;
@@ -431,7 +432,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
 #ifdef CONFIG_OF
-	master->dev.of_node = pdev->dev.of_node;
+	master->dev.of_node = dev->of_node;
 #endif
 
 	spi_gpio->bitbang.master = master;
-- 
2.20.1

