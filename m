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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDDC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4DF20848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiXwvUGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDNSf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:35:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41818 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDNSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:35:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so7485344pgs.8;
        Sun, 14 Apr 2019 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KAdyp+JPi7Q9jVcJlf9GXumZrfag/OiEwj4npOoESg=;
        b=EiXwvUGnFjQgwAgOd3heAusEAqwPiyex+t4QT5Y1sgFg+psOG7W99XFtlOQWSMN2GZ
         dz6AQEvOeHfPdPY7cRIP00lsSDoJmzU45OQkoakBoXm0E8Atla1cQ76arb7cA/Lc1p9/
         t04zn+e/74hqh3xQe+zxtVgtXgc4bXAQr42KbGPKA4fVLZ79CgSB6i4ukZuNoTRT31ra
         9KbXv1Eu/ROZVBPdWotkMQRO/1InQrlVgqsINrSxA9Vh2pe2XTB+fbxIhD6NII8S/anT
         X9r1M46Z3aSQTZNrwUJwZJVU0+BpzRGlARObCCj9fM/zHju+fgUohn/NZEUjx6Gpyq5q
         jDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KAdyp+JPi7Q9jVcJlf9GXumZrfag/OiEwj4npOoESg=;
        b=Yld4MRQTwbUqCtrPhJcZ22ZxpnerXTv4TUTkdLq9/Zs+HdRk+tQaqWVAxe7iRwt4ue
         Pz52ZRIrOQzyzDL2Szs9FdrYL3paJZk0iDwnc7Jaywtq6fcICjNSYK9clyjUK0oHNxjU
         y8l1APDh0K5k2lq+3APZLIofGt0OjcIoCUpuWlHs1ugVib0sOIvzE4VpBNsQs/oo/Cop
         okl0OkeCbZatkZsrYzHt1Emt6h9DJP/xN9p2sM1gcvJXQ30HVmIkamSJNHAhSlP7qt3f
         j6IIBXcwN+iIz0vhHvQypQ4wPDz5yuO24NL28m9uwHBy/pharnbKni+SzEcifD78JpGP
         B2DA==
X-Gm-Message-State: APjAAAXRPZQ8MYuKAz6hWxvJFX6kofcQ4m9gmFM++F3jtzMnay+ieALO
        nbD8GxiWPF0emOS7TXm0cq+V3U0C
X-Google-Smtp-Source: APXvYqyyTWtGoihA9MH0VakP0ZhgDuSrkQm3HMIZZ45nOFot/9jPIFgz1VA6Ao727IyD23vS3Aw7TA==
X-Received: by 2002:a65:4048:: with SMTP id h8mr54679184pgp.6.1555266917334;
        Sun, 14 Apr 2019 11:35:17 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p7sm83791758pfp.70.2019.04.14.11.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:35:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] iio: imx7d_adc: Simplify imx7d_adc_remove() with imx7d_adc_suspend()
Date:   Sun, 14 Apr 2019 11:35:03 -0700
Message-Id: <20190414183504.23286-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183504.23286-1-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since imx7d_adc_remove() does exactly the same thing as
imx7d_adc_suspend() we can use the latter together with
devm_add_action_or_reset() to simplify the former. Rename
imx7d_adc_suspend() to imx7d_adc_disable() for clarity while at it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/imx7d_adc.c | 46 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 0922ee08546b..c5b0dc7d0e49 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -461,6 +461,24 @@ static int imx7d_adc_enable(struct device *dev)
 	return 0;
 }
 
+static int imx7d_adc_disable(struct device *dev)
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
+static void __imx7d_adc_disable(void *data)
+{
+	imx7d_adc_disable(data);
+}
+
 static int imx7d_adc_probe(struct platform_device *pdev)
 {
 	struct imx7d_adc *info;
@@ -531,11 +549,13 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, __imx7d_adc_disable,
+				       &indio_dev->dev);
+	if (ret)
+		return ret;
+
 	ret = iio_device_register(indio_dev);
 	if (ret) {
-		imx7d_adc_power_down(info);
-		clk_disable_unprepare(info->clk);
-		regulator_disable(info->vref);
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
 		return ret;
 	}
@@ -546,32 +566,14 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 static int imx7d_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct imx7d_adc *info = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
-	imx7d_adc_power_down(info);
-
-	clk_disable_unprepare(info->clk);
-	regulator_disable(info->vref);
-
 	return 0;
 }
 
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
 
-static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_enable);
+static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_disable, imx7d_adc_enable);
 
 static struct platform_driver imx7d_adc_driver = {
 	.probe		= imx7d_adc_probe,
-- 
2.20.1

