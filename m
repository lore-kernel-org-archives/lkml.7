Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE275C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC7E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAFBqdQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfCFRqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:46:05 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42344 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCFRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:46:05 -0500
Received: by mail-io1-f68.google.com with SMTP id p196so10931661iod.9;
        Wed, 06 Mar 2019 09:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9YO8SR86inZc1b2mQpXlAZ6SeDpN9rzGMQWtwqV89Ew=;
        b=QAFBqdQ5i6qs5Tmji+oH95X1zm5AKq3g2QMADW+3FVDsSAKUl0w6GbnSiRmaWhsUpy
         tRLEQeKKq0IaT4f77T4uQ3WYJ5RxSXUEkFIye6Dx4eXv8a7uA4aLihh043ZPb04bqL9O
         ay/sfWXeF5EnhEQuYNDMwUeS7/3sEqb/lWKuDa25xCsRt2eUZx9pemeT4ZxhgdN3FbKa
         Fmwfwm74bpNOYoiilvs8nZTCuXN7wgOUQrnvisJZpm/ly2zQ/te+87z4FhJ+y5z/RGbp
         qh98L0cQFeAH57HEyA092gq/Kt2VMwI5GLfTkjA0NU3tei2s6MMD93VVrrm0XZn1ZZsj
         +MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9YO8SR86inZc1b2mQpXlAZ6SeDpN9rzGMQWtwqV89Ew=;
        b=QDfxLAlVdaTanxwR03xUQZIz+xeaE4gSekoFAEVrTG+lwnuzfDfnvU7P7GCx1SngA+
         Y14yyJ8lyVVDSgeJwjZAn0Cf0NwcZGL8c1d1udDIJg3XLu7i7ZN2I2N7uJviqnSING3O
         fgpSMLNGd0IBDuF1oACe/830Gqy9MbSa2yj7lT07utiTYxcoeDuiddqs7fwgidBS5eVj
         6mOHbU0jupFy8tP6MYXMPpRhqESjOQSOV2bOdOw8KFa6MJtejCmVy/gc7LEkLSLjGcvI
         rKv5Q3HuIDWSx4mRy2u2xSfd0LlM9ArPl5hLtST1lui5w9KNkgb6FSFILmsEU/ENvAMT
         iYZQ==
X-Gm-Message-State: APjAAAXtqaseYt2o+9+SDOjjV/tPDYeq5ybnVW9/O9CJrW7xDNSbHuxN
        y3tLmrio5J1VHpnYD1lpxV8=
X-Google-Smtp-Source: APXvYqwStjxtcIbFvVFhKN8/AZg037K8J5WzqiVN5r0GR7a6I1PW+QgF6ljII8/ru/K7ihlX/tiWVg==
X-Received: by 2002:a5d:8d02:: with SMTP id p2mr4040658ioj.113.1551894363874;
        Wed, 06 Mar 2019 09:46:03 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id p4sm760763ioj.36.2019.03.06.09.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:46:03 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: proximity: as3935: fix use-after-free on device remove
Date:   Wed,  6 Mar 2019 12:45:59 -0500
Message-Id: <20190306174559.17362-1-TheSven73@gmail.com>
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

While we're here, remove redundant &'s in front of function names when
passing a pointer-to-function.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/iio/proximity/as3935.c | 53 ++++++++++++++--------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index f130388a16a0..e33334ea2830 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -213,7 +213,7 @@ static int as3935_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info as3935_info = {
 	.attrs = &as3935_attribute_group,
-	.read_raw = &as3935_read_raw,
+	.read_raw = as3935_read_raw,
 };
 
 static irqreturn_t as3935_trigger_handler(int irq, void *private)
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
@@ -414,59 +421,44 @@ static int as3935_probe(struct spi_device *spi)
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
-				&as3935_interrupt_handler,
+				as3935_interrupt_handler,
 				IRQF_TRIGGER_RISING,
 				dev_name(&spi->dev),
 				indio_dev);
 
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

