Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A49C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CC221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU7hZ8V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfDCHD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:03:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36454 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfDCHDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:03:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so6655956pfn.3;
        Wed, 03 Apr 2019 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UanW9KkmJsWd7vTvVGIWm1rlHt42PgVmc/4x9rVyFLc=;
        b=eU7hZ8V0yhPwBMRz3qKiMzFvNN/CkUgRlP4Sb0mwBWE3hem/mgx+H/D/KtXJYk+2w4
         HlcXOliZgN/uiXf6XQ7aNicx1n+Sf5TWBqA8Dzz+Jud9NTQr2VCXxMhVBi5tUn0sKSG8
         xCN9CU69C0HLRNyYtDBwUHzd2SK3C+pAt2PSFXiMrfHkDavkj/szxqBPdbHSWpe2QJpC
         hYC3KXr8oF3xvuJo9+4rz4TH+vm/gmOIR834Hl09BNL2PgnXzzZEFlorsqKwbMCskfv0
         jGulLelwP1IAgHd3fQoa5mfli5qat2IZxjzfOAVDTOsG0XgbbT2K9y11bBV7191quqwr
         k5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UanW9KkmJsWd7vTvVGIWm1rlHt42PgVmc/4x9rVyFLc=;
        b=bK0kLhAoxzjMQAnybsCIIm2ryDR+/o5D92icwQyxDA5Jjw5Hz6QYKbDuPByVeuUmcn
         VGXTz3sPx/3E2BSzu2kyqcmgCMs/imEXoKsbQ8+EChOIG7lMIZ1PBN4/6jZPAfrXsEP0
         9R4qBiNCx6bq91rieDkDHF2z/OzkVcKOsxgS0BV9CraLMiWlwjpP/yRkiwkcOeAnF7Qo
         nrKuvWGkPGaqBqBjfcSOXNvKsUkBRbDzgtqxhYng82syP++pwlHlH66HXy96drlQixx/
         P2dl9v/RotU6MkMKt3wiIAaSYG77nhsS5K/03TwajkS4F4z7Q/PG91sVFz2+C35vjli7
         pc2w==
X-Gm-Message-State: APjAAAXfvozzzcbHl4uwOmTleTQ0VYMs6K15mPdXnwYuWNWnJJZrzcCG
        2TUZqCu6IpIANrA6fVYM+Hav4DGw
X-Google-Smtp-Source: APXvYqyr/q3jx0nUa6mpAp72yvXcDTBpHXDAcskc5a1UkcJyOmJYEbNxF1B9uS4AkosjtcOBvgQP3A==
X-Received: by 2002:a62:8381:: with SMTP id h123mr20481130pfe.226.1554275032493;
        Wed, 03 Apr 2019 00:03:52 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e22sm20602750pfi.126.2019.04.03.00.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:03:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] iio: imx7d_adc: Drop imx7d_adc_remove()
Date:   Wed,  3 Apr 2019 00:03:25 -0700
Message-Id: <20190403070325.1077-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403070325.1077-1-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since imx7d_adc_remove() does exactly the same thing as
imx7d_adc_suspend() we can use the latter together with
devm_add_action_or_reset() to get rid of the former.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 55 ++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index c2fa0ab923ee..ed95909eada2 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -461,6 +461,24 @@ static int imx7d_adc_resume(struct device *dev)
 	return 0;
 }
 
+static int imx7d_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx7d_adc *info = iio_priv(indio_dev);
+
+	imx7d_adc_power_down(info);
+
+	clk_disable_unprepare(info->clk);
+	regulator_disable(info->vref);
+
+	return 0;
+}
+
+static void __imx7d_adc_suspend(void *data)
+{
+	imx7d_adc_suspend(data);
+}
+
 static int imx7d_adc_probe(struct platform_device *pdev)
 {
 	struct imx7d_adc *info;
@@ -506,8 +524,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	init_completion(&info->completion);
 
 	indio_dev->name = dev_name(dev);
@@ -531,11 +547,13 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, __imx7d_adc_suspend,
+				       &indio_dev->dev);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
-		imx7d_adc_power_down(info);
-		clk_disable_unprepare(info->clk);
-		regulator_disable(info->vref);
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
 		return ret;
 	}
@@ -543,37 +561,10 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx7d_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct imx7d_adc *info = iio_priv(indio_dev);
-
-	imx7d_adc_power_down(info);
-
-	clk_disable_unprepare(info->clk);
-	regulator_disable(info->vref);
-
-	return 0;
-}
-
-static int __maybe_unused imx7d_adc_suspend(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct imx7d_adc *info = iio_priv(indio_dev);
-
-	imx7d_adc_power_down(info);
-
-	clk_disable_unprepare(info->clk);
-	regulator_disable(info->vref);
-
-	return 0;
-}
-
 static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_resume);
 
 static struct platform_driver imx7d_adc_driver = {
 	.probe		= imx7d_adc_probe,
-	.remove		= imx7d_adc_remove,
 	.driver		= {
 		.name	= "imx7d_adc",
 		.of_match_table = imx7d_adc_match,
-- 
2.20.1

