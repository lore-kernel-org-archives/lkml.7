Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A30C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02F21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7+lgXcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfDCHEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:04:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfDCHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:03:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so1161987pgh.0;
        Wed, 03 Apr 2019 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VaF+9tRF16mxcQZUyyOPTNZbOsP9r8zQA2RySW0saCU=;
        b=i7+lgXcnlYQOA2Z9S0ib6RhbwzHnb9R+Lqa7Kh8hKzwVYk6VIkapGtDJA1u5kPIsrv
         8+L0heSuTk5K+7CC9oS46SM4GKpXgKJ/3LoGReTpxpHeIiguWTIlPe5zMB0f/oTUfClo
         3zcOZRFw5D/9JzVXM1Qq6Mu0fLlPXECncS3Gh90NCpa01fLK/K9CulkRm5JSikhNNBDE
         mtsxyLU97f9IPYl0mKVXaF757qpHauo4qOBlusyrfbv5ohR7xu6ibMQx9qm+nC59oRC3
         bgH8bsHhP9M/7TE6AOklTBFz6V67MMihOgncMW65uwwy+OkA9bYWZqbhYm06kySUMVe5
         WVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaF+9tRF16mxcQZUyyOPTNZbOsP9r8zQA2RySW0saCU=;
        b=JEILcf69wemAhp4bT9jAGG+lhWLy/l6N3+1hM4IEuHSlEI0FVnzPIG8GCKEh0IjF4C
         9dukhYfaQ3YzIhyz2O+gpmhz5C1LklUjHhZWutH0SsR0qfOp7oH+MG/1SE/8RV/NzIL/
         MMQpQEo5QEmpXxkFV/HdfVLolkKRih+ub2NqLa5Y581+Y7OSl8DeJjc7zoT1kJnTqjIP
         140ZPQRmvQjdtJQtsVt/u6PVteGPYZq4WWtTaDaWnhZ9GDKBJueKhvusMaZdRp3jngjq
         LZjBc7odrasqzewiWhlg9+HQUQ99MrfLrnVwujNQeTnBpXWPCNwrttQMf5TBXQqYmXSf
         oqrg==
X-Gm-Message-State: APjAAAXBKonD2pOwJbu4iidJlJ/wpHrwti84H5aDUhLouQPoeUWtFZM+
        hFXaFom9EoYUuznlGj3XJw1D2wVS
X-Google-Smtp-Source: APXvYqycINRhUa22A4txqlZLUAIzzvxyDmb1V+OfPMU0ACCXJPcfOKbl9g11tOlq88snOMneBSvTjg==
X-Received: by 2002:aa7:9151:: with SMTP id 17mr37393380pfi.192.1554275031187;
        Wed, 03 Apr 2019 00:03:51 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e22sm20602750pfi.126.2019.04.03.00.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:03:50 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iio: imx7d_adc: Use imx7d_adc_resume() in imx7d_adc_probe()
Date:   Wed,  3 Apr 2019 00:03:24 -0700
Message-Id: <20190403070325.1077-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403070325.1077-1-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization sequence performed in imx7d_adc_resume() is exactley
the same as what's being done in imx7d_adc_probe(). Make use of the
former in the latter to avoid code duplication.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 86 +++++++++++++++----------------------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 8bba92611d54..c2fa0ab923ee 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -434,6 +434,33 @@ static void imx7d_adc_power_down(struct imx7d_adc *info)
 	writel(adc_cfg, info->regs + IMX7D_REG_ADC_ADC_CFG);
 }
 
+static int imx7d_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx7d_adc *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(info->vref);
+	if (ret) {
+		dev_err(info->dev,
+			"Can't enable adc reference top voltage, err = %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret) {
+		dev_err(info->dev,
+			"Could not prepare or enable clock.\n");
+		regulator_disable(info->vref);
+		return ret;
+	}
+
+	imx7d_adc_hw_init(info);
+
+	return 0;
+}
+
 static int imx7d_adc_probe(struct platform_device *pdev)
 {
 	struct imx7d_adc *info;
@@ -479,14 +506,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regulator_enable(info->vref);
-	if (ret) {
-		dev_err(dev,
-			"Can't enable adc reference top voltage, err = %d\n",
-			ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, indio_dev);
 
 	init_completion(&info->completion);
@@ -498,38 +517,30 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = imx7d_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(imx7d_adc_iio_channels);
 
-	ret = clk_prepare_enable(info->clk);
-	if (ret) {
-		dev_err(dev, "Could not prepare or enable the clock.\n");
-		goto error_adc_clk_enable;
-	}
-
 	ret = devm_request_irq(dev, irq,
 			       imx7d_adc_isr, 0,
 			       dev_name(dev), info);
 	if (ret < 0) {
 		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
-		goto error_iio_device_register;
+		return ret;
 	}
 
 	imx7d_adc_feature_config(info);
-	imx7d_adc_hw_init(info);
+
+	ret = imx7d_adc_resume(&indio_dev->dev);
+	if (ret)
+		return ret;
 
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
 		imx7d_adc_power_down(info);
+		clk_disable_unprepare(info->clk);
+		regulator_disable(info->vref);
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
-		goto error_iio_device_register;
+		return ret;
 	}
 
 	return 0;
-
-error_iio_device_register:
-	clk_disable_unprepare(info->clk);
-error_adc_clk_enable:
-	regulator_disable(info->vref);
-
-	return ret;
 }
 
 static int imx7d_adc_remove(struct platform_device *pdev)
@@ -558,33 +569,6 @@ static int __maybe_unused imx7d_adc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused imx7d_adc_resume(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct imx7d_adc *info = iio_priv(indio_dev);
-	int ret;
-
-	ret = regulator_enable(info->vref);
-	if (ret) {
-		dev_err(info->dev,
-			"Can't enable adc reference top voltage, err = %d\n",
-			ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(info->clk);
-	if (ret) {
-		dev_err(info->dev,
-			"Could not prepare or enable clock.\n");
-		regulator_disable(info->vref);
-		return ret;
-	}
-
-	imx7d_adc_hw_init(info);
-
-	return 0;
-}
-
 static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_resume);
 
 static struct platform_driver imx7d_adc_driver = {
-- 
2.20.1

