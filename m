Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAB8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C042420851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlodvgAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfCHR7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:59:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52190 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfCHR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:59:50 -0500
Received: by mail-it1-f194.google.com with SMTP id e24so22178304itl.1;
        Fri, 08 Mar 2019 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XggsLnkmq9eFvX40c5Ts8sC0GNXJ5eOMbPch1+L71OY=;
        b=KlodvgAqzWhz3dkXP0+PfYzKir26fDk1osmK8HqSGUBEfYqg7NwSFfsX4E1u4BtvV8
         0cd29R8oQ7BNILqpwim729nrrzq7H+R9+lQfn1E3qiyZz3r5LOEZsc3qxDJ8CJw+NmSI
         jRrM/yQcOl+6sjU5369e1jgf7RQRyCVGe6OAkv0OfQpO32+MF9cIniosUDs7tpjnJdCQ
         Gx98+y1+/XnPeRojP8OH5Nc8jFzCCV/SubTtTzEsL4Mt01sdToy0UVKq9ZdlC5/GyYl/
         9Wap8hdYT+6w68YdRysgL48q8my+Gdewye81Mxi09ybFzr4R9C1s/tr1wJY+348WToAn
         gSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XggsLnkmq9eFvX40c5Ts8sC0GNXJ5eOMbPch1+L71OY=;
        b=JGbr8EK/AsvvQgliha4tKvA61BvXPPQU+qr3B1is+yYMPfm3FjgKUxBhnzyjYXj8EW
         IMsfts1O0B/0vmCz0xPQtpOZ3YHDuQHeOWVNgSQt06QIea8o5VZtvA0tl02q0mpr9bF8
         doj1yIr0EuNKMKhlMlrnUF6gqiSWnZyyfCGSZntQig8pbVCyU0/1obbRfV/zDJleMlHZ
         8ozOZJd50JslenNG0d1svevJObeUSzaOHG+d38nsgtQvVPgCF6pb5ghjERG4V2VvZY2K
         +aIYuH+/Eyaxvs1taJvzv7lX6qaPnNLagvVkAHUfmmiCMO2+89/C+nUWwZqz4nuJhIDV
         g29g==
X-Gm-Message-State: APjAAAWl1+N2/gmhE/PvHOQ7+NL9Z3NNC7NgqwYF8n7kIwkaTRHAF58N
        oCVGElJ6d7d+F3SY45RRTaE=
X-Google-Smtp-Source: APXvYqyNPNU7zy7BmIhHgZ7oLENo60cVjbDJmD09TGt7LVgXRHTxP8obx97oyrNnhm8EeNdafjYkGg==
X-Received: by 2002:a24:79d1:: with SMTP id z200mr9873111itc.53.1552067988790;
        Fri, 08 Mar 2019 09:59:48 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id z10sm3331758iol.30.2019.03.08.09.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 09:59:48 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2] iio: proximity: as3935: fix use-after-free on device remove
Date:   Fri,  8 Mar 2019 12:59:35 -0500
Message-Id: <20190308175935.21904-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver's probe() uses a mix of devm_ and non-devm_ functions. This
means that the remove order will not be the exact opposite of the probe
order.

Remove order:
1. remove() executes:
	iio_device_unregister
	iio_triggered_buffer_cleanup
	iio_trigger_unregister
	(A)
2. core frees devm resources in reverse order:
	free_irq
	iio_trigger_free
	iio_device_free

In (A) the trigger has been unregistered, but the irq handler is still
registered and active, so the trigger may still be touched via
interrupt -> as3935_event_work. This is a potential use-after-unregister.

Given that the delayed work is never canceled explicitly, it may run even
after iio_device_free. This is a potential use-after-free.

Solution: convert all probe functions to their devm_ equivalents.
Add a devm callback, called by the core on remove right after irq_free,
which explicitly cancels the delayed work. This will guarantee that all
resources are freed in the correct order.

As an added bonus, some boilerplate code can be removed.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/iio/proximity/as3935.c | 49 ++++++++++++++--------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index f130388a16a0..6e366e772164 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -345,6 +345,14 @@ static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
 #define AS3935_PM_OPS NULL
 #endif
 
+static void as3935_stop_work(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct as3935_state *st = iio_priv(indio_dev);
+
+	cancel_delayed_work_sync(&st->work);
+}
+
 static int as3935_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -368,7 +376,6 @@ static int as3935_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
-	INIT_DELAYED_WORK(&st->work, as3935_event_work);
 
 	ret = of_property_read_u32(np,
 			"ams,tuning-capacitor-pf", &st->tune_cap);
@@ -414,22 +421,27 @@ static int as3935_probe(struct spi_device *spi)
 	iio_trigger_set_drvdata(trig, indio_dev);
 	trig->ops = &iio_interrupt_trigger_ops;
 
-	ret = iio_trigger_register(trig);
+	ret = devm_iio_trigger_register(&spi->dev, trig);
 	if (ret) {
 		dev_err(&spi->dev, "failed to register trigger\n");
 		return ret;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-		&as3935_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+		iio_pollfunc_store_time, as3935_trigger_handler, NULL);
 
 	if (ret) {
 		dev_err(&spi->dev, "cannot setup iio trigger\n");
-		goto unregister_trigger;
+		return ret;
 	}
 
 	calibrate_as3935(st);
 
+	INIT_DELAYED_WORK(&st->work, as3935_event_work);
+	ret = devm_add_action(&spi->dev, as3935_stop_work, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&spi->dev, spi->irq,
 				&as3935_interrupt_handler,
 				IRQF_TRIGGER_RISING,
@@ -438,35 +450,15 @@ static int as3935_probe(struct spi_device *spi)
 
 	if (ret) {
 		dev_err(&spi->dev, "unable to request irq\n");
-		goto unregister_buffer;
+		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "unable to register device\n");
-		goto unregister_buffer;
+		return ret;
 	}
 	return 0;
-
-unregister_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-unregister_trigger:
-	iio_trigger_unregister(st->trig);
-
-	return ret;
-}
-
-static int as3935_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct as3935_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	iio_trigger_unregister(st->trig);
-
-	return 0;
 }
 
 static const struct of_device_id as3935_of_match[] = {
@@ -488,7 +480,6 @@ static struct spi_driver as3935_driver = {
 		.pm	= AS3935_PM_OPS,
 	},
 	.probe		= as3935_probe,
-	.remove		= as3935_remove,
 	.id_table	= as3935_id,
 };
 module_spi_driver(as3935_driver);
-- 
2.17.1

