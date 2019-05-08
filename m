Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FA6C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29518214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kiAi5r4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfEHNkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:40:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36207 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfEHNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:39:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so3339804wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p0DIC9RoOTp6SzQmmO8Edvcsn7tr0urB+LYy5B+wiis=;
        b=kiAi5r4hnzo2DMsXy9EeVN564hgsEzALAvkBuFWKjvCsjTiPNXJubqo4k9Nom946/w
         FzWDLuiFoWejHVJ1Xw54rZVeGj0JhSLkHWRL2u6rMLvKlnOTX+1TX06G/BptEkqCSHl7
         CEvdAF0VrlLnqvoTm6wd85Md7LHejrWWzh4ICC/7hqS/Cx31XqIPyPXT0enZbvF9OCCD
         6ha+lhi0ptpWGlhOadaA3HEpenAjNVibEp5AYK7tJ/FcaVV3njwL4AUGcaA9+mDvYR3X
         2IkLUnqfy3xam3MmQL/+wWcGQrqDNrV8Hn4KwIrWmpQXusif34TXjc7EtoNUALGrApaj
         PAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p0DIC9RoOTp6SzQmmO8Edvcsn7tr0urB+LYy5B+wiis=;
        b=mY1nNyA0LYEM1hrwIAsJU/Tw+HDMd8hp5hvb+7vfLYmGMhD8Jb+UePUS3X3NTmc/TC
         UFUrF3FsxhCCjUcubvkgTHFgGMoUn48m+uuKlbRt6+XgfTX3mv23g2ZptVNVncX/VbvT
         BdgV+lJOLeEKTSWz0cEoesSHlUTIraq9pLHUCwWeCuqn7wd0J/VAdQMvTiw84hsCoPbz
         mFxtstQJPasO+epOLljAd+KPXm7r0Br3P1YxeMo0ZaWOKT95ScOW8HF8KijN004ASgha
         qYwmkE2Tt9LeLrVKEd04hw8jFxLD6Y4YhARlxC+uyv9JeFkJy7IBkxRnZ7Zpq12uM3Qb
         LDng==
X-Gm-Message-State: APjAAAWpIOc9P1+r7W9ykwwhZQhr7tIyMxH9UkkIFvP4o/9abw+xI6iW
        iyqhTRtSpkghJx0TV1X3spz4Zw==
X-Google-Smtp-Source: APXvYqztyBWRZRTM8YEZX/QDkF5TkOozNVED+JH3xbn0pn6zJMQtLN5K+O70+NmUkBxM3lB1H59mKw==
X-Received: by 2002:a1c:7f97:: with SMTP id a145mr3226937wmd.139.1557322796137;
        Wed, 08 May 2019 06:39:56 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:3d10])
        by smtp.googlemail.com with ESMTPSA id 19sm1633060wmf.44.2019.05.08.06.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 May 2019 06:39:55 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] gnss: get serial speed from subdrivers
Date:   Wed,  8 May 2019 15:39:48 +0200
Message-Id: <1557322788-10403-1-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default serial speed was hardcoded in the code.
Rename current-speed to default-speed.
Add a function parameter that lets the subdrivers specify their
default speed.
If not specified fallback to the device-tree default-speed.

Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
Hello,

This patch moves the currently hardcoded, default serial speed
to the subdrivers.
If the default speed is not specified by the subdriver then it is read
from the device tree.

Cheers,
Loys

 drivers/gnss/mtk.c    |  6 +++++-
 drivers/gnss/serial.c | 21 +++++++++++++--------
 drivers/gnss/serial.h |  3 ++-
 drivers/gnss/ubx.c    |  3 ++-
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
index d1fc55560daf..a1a89f0cc75c 100644
--- a/drivers/gnss/mtk.c
+++ b/drivers/gnss/mtk.c
@@ -16,6 +16,10 @@
 
 #include "serial.h"
 
+static uint serial_speed = 9600; /* Serial speed (baud rate) */
+module_param(serial_speed, uint, 0644);
+MODULE_PARM_DESC(serial_speed, "Serial baud rate (bit/s), (default = 9600)");
+
 struct mtk_data {
 	struct regulator *vbackup;
 	struct regulator *vcc;
@@ -69,7 +73,7 @@ static int mtk_probe(struct serdev_device *serdev)
 	struct mtk_data *data;
 	int ret;
 
-	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	gserial = gnss_serial_allocate(serdev, sizeof(*data), serial_speed);
 	if (IS_ERR(gserial)) {
 		ret = PTR_ERR(gserial);
 		return ret;
diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index def64b36d994..706fc5b46811 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -103,17 +103,13 @@ static int gnss_serial_set_power(struct gnss_serial *gserial,
 	return gserial->ops->set_power(gserial, state);
 }
 
-/*
- * FIXME: need to provide subdriver defaults or separate dt parsing from
- * allocation.
- */
 static int gnss_serial_parse_dt(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
 	struct device_node *node = serdev->dev.of_node;
-	u32 speed = 4800;
+	uint speed;
 
-	of_property_read_u32(node, "current-speed", &speed);
+	of_property_read_u32(node, "default-speed", &speed);
 
 	gserial->speed = speed;
 
@@ -121,7 +117,8 @@ static int gnss_serial_parse_dt(struct serdev_device *serdev)
 }
 
 struct gnss_serial *gnss_serial_allocate(struct serdev_device *serdev,
-						size_t data_size)
+					 size_t data_size,
+					 uint serial_speed)
 {
 	struct gnss_serial *gserial;
 	struct gnss_device *gdev;
@@ -146,10 +143,18 @@ struct gnss_serial *gnss_serial_allocate(struct serdev_device *serdev,
 	serdev_device_set_drvdata(serdev, gserial);
 	serdev_device_set_client_ops(serdev, &gnss_serial_serdev_ops);
 
-	ret = gnss_serial_parse_dt(serdev);
+	/* Serial speed provided by subdriver takes precedence over dt*/
+	if (!serial_speed)
+		ret = gnss_serial_parse_dt(serdev);
+	else
+		gserial->speed = serial_speed;
+
 	if (ret)
 		goto err_put_device;
 
+	if (!gserial->speed)
+		return -EINVAL;
+
 	return gserial;
 
 err_put_device:
diff --git a/drivers/gnss/serial.h b/drivers/gnss/serial.h
index 980ffdc86c2a..29212b57a739 100644
--- a/drivers/gnss/serial.h
+++ b/drivers/gnss/serial.h
@@ -33,7 +33,8 @@ struct gnss_serial_ops {
 extern const struct dev_pm_ops gnss_serial_pm_ops;
 
 struct gnss_serial *gnss_serial_allocate(struct serdev_device *gserial,
-						size_t data_size);
+					 size_t data_size,
+					 uint serial_speed);
 void gnss_serial_free(struct gnss_serial *gserial);
 
 int gnss_serial_register(struct gnss_serial *gserial);
diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 7b05bc40532e..26a278c7e2fd 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -68,8 +68,9 @@ static int ubx_probe(struct serdev_device *serdev)
 	struct gnss_serial *gserial;
 	struct ubx_data *data;
 	int ret;
+	uint speed = 4800;
 
-	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	gserial = gnss_serial_allocate(serdev, sizeof(*data), speed);
 	if (IS_ERR(gserial)) {
 		ret = PTR_ERR(gserial);
 		return ret;
-- 
2.7.4

