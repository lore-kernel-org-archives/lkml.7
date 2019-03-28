Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC14121773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mjb4IHc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfC1KDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:03:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36884 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1KDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:03:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so3251117wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMcUmb2WHKV3LTF1MhO/0BXJVjoQCZxXAEv5GKcE4aE=;
        b=mjb4IHc2fPA0QZH185mM2bIHAlqtvojzI3daWo5LcFl4Oq4mlJHMvFATWpmT7boOUr
         +wyqd24YBsfeyYGb/49dv75EoOZFcB+xW/9MFykZTNXNffJ62ROSh3kt5YCRcBazcC/2
         nWKopJCdauxsnAAoHnp3jcEfP/Ba+oGa8RyNmEzCZ3Mb9F6OIdjKRVhnHoK9YFm1GzQe
         omCP+cMF7x7CbEecmisc4uUxlEenkmI6NCs56h+Ijx3ra9HJl3VGnyk4hy5Di7HwafHJ
         rLBHc4I4rxZk+CqEc8ct+LXyZ0d9p7wWuWo0wMq297WEpoZ5ICk6pNmasE99lJg2r1rt
         a0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMcUmb2WHKV3LTF1MhO/0BXJVjoQCZxXAEv5GKcE4aE=;
        b=jLmUMvo5FfwOgtoZTBW9lF0R3jYQOEYIglvLyDJHGtbPfEiwxcqN+veqaWEc4aQIcz
         P0aueuRoRUU/i6I9IDB08w4NVawI2imwASNntgpP6NdK5rBuLjrJb8wFc1CC05GWazy6
         u6FhetcgVAZ92H30RE8IuVYDmp8aHLZ79OwpBx21nJNNq9xaVOOEffss8cQr1pnzln6d
         DJxrbcXy7euQGgaBEAPmAKfm0qkyIL9U7DNDTx9s/wz66BikWub89RvV5GOUqq+6XRuo
         AvIVAfOr7kkNQkT6LC2nuMACwy7+++sCRyFtLSFih5Keaiuf/aY6qiQF+XBKVWrEWTQ6
         ZQdg==
X-Gm-Message-State: APjAAAXP7NUULlIBhoKfPL5TNXAkKGHZkhjhvKX4F8RDGUUr6NcrhKWD
        7gzZxr4cH34i3hwr4leNbgubVA==
X-Google-Smtp-Source: APXvYqx0mDwIytnNsq0aFeqQWfzjous4m5oeHjWs8lmQ2XePnkGqFfxG5wsCGsYs1g6hufZyp+5YCw==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr11338896wma.57.1553767396985;
        Thu, 28 Mar 2019 03:03:16 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q8sm1230315wmq.35.2019.03.28.03.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Mar 2019 03:03:16 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/1] gnss: get serial speed from subdrivers
Date:   Thu, 28 Mar 2019 11:03:09 +0100
Message-Id: <1553767389-22857-2-git-send-email-lollivier@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553767389-22857-1-git-send-email-lollivier@baylibre.com>
References: <1553767389-22857-1-git-send-email-lollivier@baylibre.com>
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
index 12568aebb7f6..6cfcb2eebdfd 100644
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

