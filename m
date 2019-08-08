Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF322171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGcrcGuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfHHO05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:26:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40108 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfHHO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:26:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so44196505pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=md2OPGZk0nCv756Mrn9PJif0bN7aUiYeyoo+Xz7PdYE=;
        b=RGcrcGuU/OaUgSHbE78BfEVc9bZx1UvWtqQWxfNlsLkly64S1IvchY4VZgqriAGzPZ
         lRISbM1zSNQuRIk871EoOpWK6/RjjnYOVQGS9vGBZk8+AIIx9JU5v9uqTeh/SwcEGTwK
         q1A6Q2g/vFKmG92OceBjKRjRVp8yb9gg/1dqDM2OiIrtWOXpZa2yOGyNJFDDfTUaj0KF
         NeoCjHzRZG6lZSI2rzXI7kHLLF8KREs02p0NASgArhkP+Ovji7OyP94FtzJOjrgVphfq
         zv7AEHpsYP65+EDdccvh1R2mEJr5lcJygV7AQoPqPV84uT2XNxsrrhfiAXryL5G/UcML
         axtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=md2OPGZk0nCv756Mrn9PJif0bN7aUiYeyoo+Xz7PdYE=;
        b=tWlQEP5op72Iax2mOb5goBSRJ12rok1Egl95OAssq2uBLsW2l8BWFwCTDoKhsUvIOo
         mH/rvf19gobVcwePzwBj4u4uCZ6cVgTmAYUJhXlnom6ZYai/+TRC4fuTNECozhvaQz7G
         zMelRXndTtWV5nGC0RRR0BqxAzbMySog5DzeCAvRGH9Bz6og6KeKbyw4dGbAzAUuonUV
         LXHdfa9tOjfHkA6EqwRPXmqzII0bYO4iqZ6DZyhWN+buvbOo6U6XAhuVLyZJtAhQiQH9
         l/P9sHODGyFvPmEqvjQBvBVfzfteFJzGsUhq44Haa6m2MsGDaINep8mmicdy4Hpy3KyM
         vhTg==
X-Gm-Message-State: APjAAAX+7V1EGKLD6quawepTAVwAo/8G+kiw9+MYEcBHmWqfLbtf4VxV
        WuUbKIAF9kF/BVWNdRzyQUk=
X-Google-Smtp-Source: APXvYqwfXVielMoSb1WFWeRq8TWMnABH9ZbDPtNew3A40VqJcYgKvnifq7ihKwD3wS7PvTDqk8LrVA==
X-Received: by 2002:aa7:93a5:: with SMTP id x5mr15532929pff.87.1565274413336;
        Thu, 08 Aug 2019 07:26:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id cx22sm2374760pjb.25.2019.08.08.07.26.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 07:26:52 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: adc: max1027: Use device-managed APIs
Date:   Thu,  8 Aug 2019 22:26:46 +0800
Message-Id: <20190808142646.29567-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device-managed APIs to simplify the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/adc/max1027.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index da84adfdb819..f1b90c544b82 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -427,8 +427,9 @@ static int max1027_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 &max1027_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					&iio_pollfunc_store_time,
+					&max1027_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
 		return ret;
@@ -439,7 +440,7 @@ static int max1027_probe(struct spi_device *spi)
 	if (st->trig == NULL) {
 		ret = -ENOMEM;
 		dev_err(&indio_dev->dev, "Failed to allocate iio trigger\n");
-		goto fail_trigger_alloc;
+		return ret;
 	}
 
 	st->trig->ops = &max1027_trigger_ops;
@@ -454,7 +455,7 @@ static int max1027_probe(struct spi_device *spi)
 					spi->dev.driver->name, st->trig);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
-		goto fail_dev_register;
+		return ret;
 	}
 
 	/* Disable averaging */
@@ -462,33 +463,16 @@ static int max1027_probe(struct spi_device *spi)
 	ret = spi_write(st->spi, &st->reg, 1);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Failed to configure averaging register\n");
-		goto fail_dev_register;
-	}
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&indio_dev->dev, "Failed to register iio device\n");
-		goto fail_dev_register;
+		return ret;
 	}
 
-	return 0;
-
-fail_dev_register:
-fail_trigger_alloc:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static int max1027_remove(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
 	pr_debug("%s: remove(spi = 0x%p)\n", __func__, spi);
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
 	return 0;
 }
 
-- 
2.20.1

