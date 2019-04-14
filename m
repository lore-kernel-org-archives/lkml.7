Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB836C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D8D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA/UUuyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDNSfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:35:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33931 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfDNSfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:35:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so7505679pgq.1;
        Sun, 14 Apr 2019 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2v1auJdkX5j9Jp73xL8KvPHgZOfWMd+3DFH+mb357Rs=;
        b=pA/UUuyF2mTumvIELnKUZVQWiUoaSJj2QMWLFntgIh4WB6e9/7GvipmvZtPAH78cxS
         I6A3f2ae2+gsHXgJmScmZ/fazIok0jtHxaNEH/rSSyIo6gRivivYdOAw3uFKu85ne2CB
         SvTHrwm1gnGxQwrHeRb91nCLm71jqB0UWGfzvnlQZxU6nXoK9BK02K8XjwGSJ22vyD5a
         lsgnp+yK01Z9GEM5JpnKN1cnt+bpYauCVVb3qch3OmOBPqyABG6J7pMJ0KUJH7tHEzmx
         u8Ty1cMBw29HMyF66XB6stE7Ltkn9jNof1DtpG6xrVYQzIHcj0Fad9iWcdXZaqBbwCkw
         nNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2v1auJdkX5j9Jp73xL8KvPHgZOfWMd+3DFH+mb357Rs=;
        b=fpjY7CogAzcaLtbvUDFVEbH+woNAa136b0pdkLR440ccglsO2xZ9ervOkX6s9jXyUd
         wCKnBAyna4U2P1JxwAF9oP0tWSwEfmLqicKo99ro5ZSPCSxrSVJNtL3U5qCRCR9cs+Wl
         en+LHRYdhgdGhc6y6JfjAuoMe+9D+5xP3JcNTqjGU5rhqmxX/eVdYRhiHjfp+uKc6zf2
         jPAj2tbQsBG/KGEYEn+y5En4Vh03FuZcb7aZKZ1gtEYQmKF6YkQjMNfWetOTUY5A9ueE
         sZXQryllFNcfX126BJU96aOX0Mbw+YvnLcdHKaNsZAh8bcD4ki7cAIT+uNRN0wZAOZor
         Rtow==
X-Gm-Message-State: APjAAAW5J8BAw1z4As3KQK4ACWUnNgve1g7v3dA7Nu0ie6/OYHNWohIo
        YHUNIdiwoESjISFH2I858OQe6h6p
X-Google-Smtp-Source: APXvYqx55PKo3H0pMyhcf2JjtDMBuTshQQLj4t1VaHivM/qi1I+J8TbC1L+kRaSmdApCO8rWIjMkjg==
X-Received: by 2002:a63:3fc3:: with SMTP id m186mr67796049pga.151.1555266916026;
        Sun, 14 Apr 2019 11:35:16 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p7sm83791758pfp.70.2019.04.14.11.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:35:15 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] iio: imx7d_adc: Simplify imx7d_adc_probe() with imx7d_adc_resume()
Date:   Sun, 14 Apr 2019 11:35:02 -0700
Message-Id: <20190414183504.23286-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183504.23286-1-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialization sequence performed in imx7d_adc_resume() is exactly the
same as the one being done in imx7d_adc_probe(). Make use of the
former in the latter to avoid code duplication. Rename
imx7d_adc_resume() to imx7d_adc_enable() for clarity while at it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 88 +++++++++++++++----------------------
 1 file changed, 36 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 147ee8575ad0..0922ee08546b 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -434,6 +434,33 @@ static void imx7d_adc_power_down(struct imx7d_adc *info)
 	writel(adc_cfg, info->regs + IMX7D_REG_ADC_ADC_CFG);
 }
 
+static int imx7d_adc_enable(struct device *dev)
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
+	ret = imx7d_adc_enable(&indio_dev->dev);
+	if (ret)
+		return ret;
 
 	ret = iio_device_register(indio_dev);
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
@@ -560,34 +571,7 @@ static int __maybe_unused imx7d_adc_suspend(struct device *dev)
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
-static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_resume);
+static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_enable);
 
 static struct platform_driver imx7d_adc_driver = {
 	.probe		= imx7d_adc_probe,
-- 
2.20.1

