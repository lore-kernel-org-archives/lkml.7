Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145722171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTp8qRSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbfB1OZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:25:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42864 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732841AbfB1OZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:25:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id u7so14432483qtg.9;
        Thu, 28 Feb 2019 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7IjTEn/vSJKDmLNmxTfgAiOgC0kjjMvr7wAaLhI+NQw=;
        b=tTp8qRSXsofJF+XuoEKGP3DhVSrrCLPYQim2iMK9FbzOojDAMcBqp4a9N1PyyMkMX6
         X3HmpjMyMptSfQOgAu3gBtHmVuVZIBkxMNbjpVNjTaoy0X2VKzhTlwBfBaZAdGsKhUUY
         o2XK13B4eY7AqcMq8CmywCL00gyACUsqpf6/rfWvxkTvOET6FTFCxdY3C2fgO5V/Un8Q
         tvYSSjNOLkKqQyTmgUE2tk7R8B6UE185ZMQ3Yz79OjKnfX1MDMHLOycZMEVDbe8xfmMt
         +wvwBi8eFC7uOTbavvWln3bAGKzhk+jjCVFAeQWdxmbveM0x5E4ofg5mWM89Ptbwtjoq
         EbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7IjTEn/vSJKDmLNmxTfgAiOgC0kjjMvr7wAaLhI+NQw=;
        b=iLDp+nJ4ZN+bfhzjwzvdFLf/c0NUEXZcZChFVz5zbRp5YOl1WqpeO2CXDH9htKbKQJ
         Ca1kOoFjxQgGH42vC/JWFHbwuMcSTVkK7bubcW8giAiwRT3C269qzuDMPm6NYrD8Ptod
         kocYx3mGndWrdynJ+bUNl+671F2ESGHiB+uXmewPN3EZ/Vsfugu6aYi+9JM4DaJlf3x1
         yxzZGVWXt6dQHed5zmx6UuJda9bctsPM89is2pP/W71s2AztgandeZZoc6uCXoJxJ5sG
         kWzWeoPj0REQb5uXsQhas+vxXgNv7XVQbxztYUtpTcdmR212BoeyP5JhvA7ckMIeFu6+
         yiQQ==
X-Gm-Message-State: AHQUAuZDOwNluXEQw6YaQOe4YeDTmq60JgfWTir4LwW45iJPGrMYE+fZ
        IykDuD+ix3ZpOU71VJZwI+d1HeSbGfE=
X-Google-Smtp-Source: AHgI3IZKH/KcRhkXWV3NEWKKP/hULaaU1gfc7Gn7mS4D4fsTmW3F4mQLWFHA7xWHToxqPINP434b8w==
X-Received: by 2002:ac8:2314:: with SMTP id a20mr6523370qta.127.1551363915303;
        Thu, 28 Feb 2019 06:25:15 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p64sm3673740qkc.62.2019.02.28.06.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 06:25:15 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:25:09 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v4 5/9] staging: iio: ad7780: move regulator to after GPIO
 init
Message-ID: <93cabb081605ac356f2f0d9a9a41d5bc5e63820d.1551358569.git.renatogeh@gmail.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1551358569.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To maintain consistency between ad7780_probe and ad7780_remove orders,
regulator initialization has been moved to after GPIO initializations.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index ad7617a3a141..12aef0f101bc 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -255,16 +255,6 @@ static int ad7780_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
 
-	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
-
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -284,7 +274,7 @@ static int ad7780_probe(struct spi_device *spi)
 		ret = PTR_ERR(st->powerdown_gpio);
 		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
 			ret);
-		goto error_disable_reg;
+		return ret;
 	}
 
 	if (st->chip_info->is_ad778x) {
@@ -295,7 +285,7 @@ static int ad7780_probe(struct spi_device *spi)
 			ret = PTR_ERR(st->gain_gpio);
 			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
 				ret);
-			goto error_disable_reg;
+			return ret;
 		}
 
 		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
@@ -306,10 +296,20 @@ static int ad7780_probe(struct spi_device *spi)
 			dev_err(&spi->dev,
 				"Failed to request filter GPIO: %d\n",
 				ret);
-			goto error_disable_reg;
+			return ret;
 		}
 	}
 
+	st->reg = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		return ret;
+	}
+
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
 		goto error_disable_reg;
-- 
2.21.0

