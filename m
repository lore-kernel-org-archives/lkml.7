Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8FAC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D18218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxC3zisH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfDWVl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:41:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42539 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfDWVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:41:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id i186so947983lji.9;
        Tue, 23 Apr 2019 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dciPz5i6iUOQEqd4ga8rNmP9MhHw7ebjWpQwl/EYfys=;
        b=pxC3zisHehdHyB7pttEznE1NWYSq+qP2woYKXnOOItXCV9U1oZ8yLoMgBRROZ8x5ki
         on9V7lRSaen2Ht7dQ0nVOhkUQtpKQy6wz2Rpkwfe8oqjeRlnBBXbx+t2P6fBk6hflBiY
         ObNXmyM7Cjv4vxGtgeDJnQsQj+9Sqh39AK4YlO6rFxPCorYou2ZyDi5GpHE39u67hiFy
         nW8mp23QmGwU1oklZ97u0878TrrCIEjYP3s/WQkDRANkHidIFHDujCociAzXIeunMVGV
         hWPKCDmROQWNisDb8QvoCdDsl5+fnlyBaau1CgqHJegYYkOv+PVmJWmXVzEYIygIPV9m
         qalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dciPz5i6iUOQEqd4ga8rNmP9MhHw7ebjWpQwl/EYfys=;
        b=XZCKn3ObZQ3JoNFg7JH6cyYwszYZ38s/ckUx/EFcSezr4OySUUnQfG+CxYZGEPUjRe
         VBJZqTqo5Elpl0w6jKfiJI2V3e5gqf1L64THC+Huf+hhwvDrvzi41SV5Mq7u4mexeva+
         Z6WWjWOwgbfaOfnRdbRSPST1CikO0tIVTaYWhxG4O7F/PGwvD8R9mXKlBcWNnUz143Zw
         wCP9yEppQV2OLLdSXydfd06l00bQhdYIeuKy62WzHaQi5O5jTele+pQ2QHaZfBTnFqXd
         MK/UOZF/sg6/RnZAs5/0XqCieS5x0xNSuNnzo0qr9NZHS2CHHzTphU7PnhUBicFQZ4d/
         zSJA==
X-Gm-Message-State: APjAAAX1TxMEQuWi85CzrW6jUjlrd32vRRe/iVwbHx7Wy6f6lmOznthu
        FP9ZoyYI4FXSVymXWzv9axo=
X-Google-Smtp-Source: APXvYqxf4wWlY+g4Um3q4mKER31sS2ZwDo1AgjkcwMMwhKEMZHZbmMH0mEuGlffsZrwYL5/0LGpm4g==
X-Received: by 2002:a2e:7a03:: with SMTP id v3mr4259620ljc.142.1556055683873;
        Tue, 23 Apr 2019 14:41:23 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id p11sm985798lfh.27.2019.04.23.14.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 14:41:23 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     dagmcr@gmail.com, javier@dowhile0.org,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: accel: kxsd9: declare missing of table
Date:   Tue, 23 Apr 2019 23:40:59 +0200
Message-Id: <1556055659-14658-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/accel/kxsd9-spi.ko  | grep alias
alias:          spi:kxsd9

After this patch:
modinfo drivers/iio/accel/kxsd9-spi.ko  | grep alias
alias:          spi:kxsd9
alias:          of:N*T*Ckionix,kxsd9C*
alias:          of:N*T*Ckionix,kxsd9

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/accel/kxsd9-spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index b7d0078..3027917 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -1,5 +1,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -40,10 +42,17 @@ static const struct spi_device_id kxsd9_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
 
+static const struct of_device_id kxsd9_of_match[] = {
+        { .compatible = "kionix,kxsd9" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, kxsd9_of_match);
+
 static struct spi_driver kxsd9_spi_driver = {
 	.driver = {
 		.name = "kxsd9",
 		.pm = &kxsd9_dev_pm_ops,
+		.of_match_table = kxsd9_of_match,
 	},
 	.probe = kxsd9_spi_probe,
 	.remove = kxsd9_spi_remove,
-- 
2.7.4

