Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57E221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKNV3gMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfDCHDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:03:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:47101 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:03:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so7549070pll.13;
        Wed, 03 Apr 2019 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vb9uAQH/o2De1YmvUYnPDAc0vIUTfBsphA2YuXBH1ZI=;
        b=VKNV3gMuZvYBIxh+lUcJJSwq1yWv0brZuWe+GN3oK7LPLUtyqY+TG3omPWbOZOas8b
         K9i8JYMxsD37cjJ9T9i5q5RB4EEByiAfuf6v3DkWZ+Rz3d8Ft3NR4WTKS7fcYcKaGHL8
         hLPoVIWE2RKLgy41hclKX0JsoMBqYKO4btyLIVTuEGMUBDPnCKaLDDEPzqtsw7i448WY
         q40FbsV4QXKW0+yP4pSslnIzUd/VoFeGtc+FvElGzz/hycMv84BQVq186veXBzKy9NTN
         2miuovwGcP26SBlA8pEWkqDWMF2rpkYpcG8GWLEvUWC3iHc87VEeZDY9SPS8GGdvQf4e
         xBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vb9uAQH/o2De1YmvUYnPDAc0vIUTfBsphA2YuXBH1ZI=;
        b=pwgQkfNlFWHFUdVKFyFTzbwWrFdNwR+rJxtabiiaW9TIJIGJNouO+yDE2zuh1uBYPN
         GSQjdk5RFJICbwaeJg3wlgpe/zxUeBWXiYpA4I7l7Xe8r8+XM63gn4pqBIbkanpMfGFc
         cNBWL8ofj5/8QacGuE9si/3baZMigtG382lbtwUBIAVqaAYnejxRudf0FQwvw22lo/n1
         JEnO3LqUZfuuD37iV9EzODij9AVxppB6NyHC7jo4Yo++UM76BEvYdr8cQcAn+xaMjGa7
         rqqoAUwW7JB+VpY8MmzVp24VhwowLfTIVdbG+aNj1GD16MI0g+8mcvEyDVsBvBL0IOAS
         QzAw==
X-Gm-Message-State: APjAAAUXppWZYoTaFjOibgCkeR4TAv5qLLmoGt1nqfSio0eTFH4YskgG
        fxHnNScgmqX/ohKww4dWNPnIsMmb
X-Google-Smtp-Source: APXvYqyiQOYj0u/lWX/a0Z5WBu9oY2XExn8qPDtP0TLrNOH7LaMo5uQnwREt8HhucYdZROZXPwQvsQ==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr73100619pla.120.1554275025308;
        Wed, 03 Apr 2019 00:03:45 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e22sm20602750pfi.126.2019.04.03.00.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:03:44 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] iio: imx7d_adc: Add local struct device pointer in imx7d_adc_probe()
Date:   Wed,  3 Apr 2019 00:03:20 -0700
Message-Id: <20190403070325.1077-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403070325.1077-1-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct device *dev" in imx7d_adc_probe() for brevity. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index ad6764fb2a23..3bbd657409d5 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -438,51 +438,51 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	struct imx7d_adc *info;
 	struct iio_dev *indio_dev;
 	struct resource *mem;
+	struct device *dev = &pdev->dev;
 	int irq;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
 	if (!indio_dev) {
 		dev_err(&pdev->dev, "Failed allocating iio device\n");
 		return -ENOMEM;
 	}
 
 	info = iio_priv(indio_dev);
-	info->dev = &pdev->dev;
+	info->dev = dev;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->regs = devm_ioremap_resource(&pdev->dev, mem);
+	info->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(info->regs)) {
 		ret = PTR_ERR(info->regs);
-		dev_err(&pdev->dev,
-			"Failed to remap adc memory, err = %d\n", ret);
+		dev_err(dev, "Failed to remap adc memory, err = %d\n", ret);
 		return ret;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No irq resource?\n");
+		dev_err(dev, "No irq resource?\n");
 		return irq;
 	}
 
-	info->clk = devm_clk_get(&pdev->dev, "adc");
+	info->clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(info->clk)) {
 		ret = PTR_ERR(info->clk);
-		dev_err(&pdev->dev, "Failed getting clock, err = %d\n", ret);
+		dev_err(dev, "Failed getting clock, err = %d\n", ret);
 		return ret;
 	}
 
-	info->vref = devm_regulator_get(&pdev->dev, "vref");
+	info->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(info->vref)) {
 		ret = PTR_ERR(info->vref);
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Failed getting reference voltage, err = %d\n", ret);
 		return ret;
 	}
 
 	ret = regulator_enable(info->vref);
 	if (ret) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Can't enable adc reference top voltage, err = %d\n",
 			ret);
 		return ret;
@@ -492,8 +492,8 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 
 	init_completion(&info->completion);
 
-	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
 	indio_dev->info = &imx7d_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = imx7d_adc_iio_channels;
@@ -501,16 +501,15 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(info->clk);
 	if (ret) {
-		dev_err(&pdev->dev,
-			"Could not prepare or enable the clock.\n");
+		dev_err(dev, "Could not prepare or enable the clock.\n");
 		goto error_adc_clk_enable;
 	}
 
-	ret = devm_request_irq(info->dev, irq,
-				imx7d_adc_isr, 0,
-				dev_name(&pdev->dev), info);
+	ret = devm_request_irq(dev, irq,
+			       imx7d_adc_isr, 0,
+			       dev_name(dev), info);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed requesting irq, irq = %d\n", irq);
+		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
 		goto error_iio_device_register;
 	}
 
-- 
2.20.1

