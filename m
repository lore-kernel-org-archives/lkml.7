Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3638BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01FA218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJJjFEUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfDWVlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:41:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46249 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfDWVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:41:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so12874216lfj.13;
        Tue, 23 Apr 2019 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TbVR3poIYZWQSIC2YhkiQWBZSkY7aCtM0WVr1BRU9qY=;
        b=dJJjFEUoe0NPCcDTkbfxiR7GESFo/tDc9+9omEvNbvcIMjcSQngH4A7tCUb6p/f6JR
         WvMlrFjLlQ742Xyc9h83Kt4RXM8K3QzbNB3mW00mvla4aMJzwjrtgv8ao4oVWbW4Zu7X
         +ocu2lvOC+NhmPVpAJ9m4oFrv8CI+9out7up72vaweOkQWJ17fXQpvHLZp2KyyYjyjjy
         J1f0yizMViO5Cq4r7yWSmGLHuONsaYNx6XiH4gx6ZY2Xb6IrjqKT71f3492ci0fP1iZO
         aK5LVGMDNAFT6PfGtML/vu7l3jQnISXD8fGH62aeFUEtH1QbUtOH+fxCAQLv68GaGlmz
         JNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TbVR3poIYZWQSIC2YhkiQWBZSkY7aCtM0WVr1BRU9qY=;
        b=qC7PnOHQlEaeGfEZ7yDrFHm03Z2zE8TrbkHfkEvdcMLVhifhJcAcG0W6wj04NGaXsV
         9fjUy695uEgAmXQlAmyWnYFiwVwW7hTFu/r5vGAsyEDX+r5nexCmA9EB7vHYp/N4cJ2R
         qymmn12RUaqa8YZVgsvVh0MS+w4V796e/cpS/4qHxgthc2V97AIUzqmdha20fthVjAo3
         WlTvN419RBygqk0hnrBdtrehsejI+lvl4kVEVorUn4yzNwZFuqmsf4bjL3OGWszMvpss
         YPs6tkQoebgofd8mZFC2Kzdns4uR3QWnD6D7Yki52ta1g3U1aVvyQJaQE0B7gW9e08K5
         oVIg==
X-Gm-Message-State: APjAAAWcJB7a8xR38eggKo2AOgmcqTA4dTXQluqtRLzyRtEsDAZqfzj8
        75+7ty0hXSDgWX8UgRlEsVk=
X-Google-Smtp-Source: APXvYqxEFUYDkIFPZ6hb6LvlGQVeCFHpHHJcTn1f2v6bJyy2iYjOGU20/UaSQMSyULmP/ZOS98EfSw==
X-Received: by 2002:ac2:545c:: with SMTP id d28mr14884155lfn.144.1556055708492;
        Tue, 23 Apr 2019 14:41:48 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id l22sm3601691lja.97.2019.04.23.14.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 14:41:48 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     dagmcr@gmail.com, javier@dowhile0.org,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: adxl372: declare missing of table
Date:   Tue, 23 Apr 2019 23:41:37 +0200
Message-Id: <1556055697-14723-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/accel/adxl372_spi.ko | grep alias

After this patch:
modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
alias:          spi:adxl372
alias:          of:N*T*Cadi,adxl372C*
alias:          of:N*T*Cadi,adxl372

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/accel/adxl372_spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index e14e655..3ef7e3a 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -7,6 +7,8 @@
 
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
 #include "adxl372.h"
@@ -37,9 +39,16 @@ static const struct spi_device_id adxl372_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
 
+static const struct of_device_id adxl372_of_match[] = {
+        { .compatible = "adi,adxl372" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, adxl372_of_match);
+
 static struct spi_driver adxl372_spi_driver = {
 	.driver = {
 		.name = "adxl372_spi",
+		.of_match_table = adxl372_of_match,
 	},
 	.probe = adxl372_spi_probe,
 	.id_table = adxl372_spi_id,
-- 
2.7.4

