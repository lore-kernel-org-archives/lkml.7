Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AF3C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E7420818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qi6MyDpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfEPQhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:37:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37546 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfEPQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:37:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so4154866wmo.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ThsUgCnRiH2xV7RaQ5eyyKQF0jGHePi2XouhM2DCtVc=;
        b=qi6MyDpzUBi/YhH3EIVRa9In2VP4i8/Rqo8r4u+l2ILm5g/G2aH1ZkO2/tkZJzAz+4
         fP3htptmdBLOK1x23VJVUHtY2KnUbze/RsIZyaDFGvx7uSAOWifUSoQUrBeEOo6Z9JEx
         UJBXkkffA169xraI5y96uDyl+P+i1AqTKrqfqcXDZeVKHP44f4+RfHrbVPDj2EzMhBij
         bZCJ7Po/trm6o16eQHuuiwHfXslowAzpx7CsB1A1XWwMYZo348VaoFUGdTxC8RnlSsB+
         /iCrhFXuRYx21k05rd3DgNt4GDVe4/Huxf5QAxwLlbuPQbm74I5EsNkyp3ap1yJF/89E
         OY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ThsUgCnRiH2xV7RaQ5eyyKQF0jGHePi2XouhM2DCtVc=;
        b=c3AbYEBH8DMRXJIBAbqhmii8kPNGNAWpg+GevE90LTxVkxXyPNYJyAfvcF+6sMOtn5
         4qtgwxG/mSZvIrFrREhi4tX1G1hGWiO+1+58kQX9JmhB4EBBf3MqcMObhXwYdVmdXo+9
         1caY1D896Vphy6F14rrv8brB1/klxmqIbz99TFM66Ra5VqZkaQCergpHi3mweQGvpfeA
         f/CDwBEkjSYGogRYPC65HN90qKgwHmJNh/OQG0PW1+0c+hz6ZRAlzYc+8bQ7khjiS2It
         EzTYoqaQRcBEyKMhsg5LwJGvPkFgD7lNUOKy3rc9Bg6lHGb8YIzoW28DwYOBajAuvfbt
         Yi+A==
X-Gm-Message-State: APjAAAX0AE7Aq2cBdJxVTHd2PpMxWxq6rvY7ov6daFZrY04gNoO61AVB
        kVr3P3on9jaTZujwrRIaKdTbzA==
X-Google-Smtp-Source: APXvYqybn3Y6301Af98XjzaiHZSg4KGov0qU7mWWN97Wd731o4jzd/edN9W3fJ1YKaXz9qJGZniWPg==
X-Received: by 2002:a1c:1f47:: with SMTP id f68mr18234178wmf.57.1558024632927;
        Thu, 16 May 2019 09:37:12 -0700 (PDT)
Received: from loys-ubuntu-BY1835A49200471.thefacebook.com ([2620:10d:c092:180::1:e504])
        by smtp.googlemail.com with ESMTPSA id x68sm2112515wmf.13.2019.05.16.09.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 May 2019 09:37:12 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Loys Ollivier <lollivier@baylibre.com>,
        Colin Ian King <colin.king@canonical.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        baylibre-upstreaming@groups.io
Subject: [PATCH v2] gnss: get serial speed from subdrivers
Date:   Thu, 16 May 2019 18:37:06 +0200
Message-Id: <1558024626-19395-1-git-send-email-lollivier@baylibre.com>
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

Changes since v1[0]
- Use u32 data types instead of uint

[0]: https://lore.kernel.org/lkml/1557322788-10403-1-git-send-email-lollivier@baylibre.com/

Cheers,
Loys

 drivers/gnss/mtk.c    |  7 ++++++-
 drivers/gnss/serial.c | 21 +++++++++++++--------
 drivers/gnss/serial.h |  3 ++-
 drivers/gnss/ubx.c    |  3 ++-
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
index d1fc55560daf..1d35bcb52072 100644
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
@@ -69,7 +73,8 @@ static int mtk_probe(struct serdev_device *serdev)
 	struct mtk_data *data;
 	int ret;
 
-	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	gserial = gnss_serial_allocate(serdev, sizeof(*data),
+				       (u32)serial_speed);
 	if (IS_ERR(gserial)) {
 		ret = PTR_ERR(gserial);
 		return ret;
diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index def64b36d994..3be799702291 100644
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
+	u32 speed;
 
-	of_property_read_u32(node, "current-speed", &speed);
+	of_property_read_u32(node, "default-speed", &speed);
 
 	gserial->speed = speed;
 
@@ -121,7 +117,8 @@ static int gnss_serial_parse_dt(struct serdev_device *serdev)
 }
 
 struct gnss_serial *gnss_serial_allocate(struct serdev_device *serdev,
-						size_t data_size)
+					 size_t data_size,
+					 u32 serial_speed)
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
index 980ffdc86c2a..17df61e399e6 100644
--- a/drivers/gnss/serial.h
+++ b/drivers/gnss/serial.h
@@ -33,7 +33,8 @@ struct gnss_serial_ops {
 extern const struct dev_pm_ops gnss_serial_pm_ops;
 
 struct gnss_serial *gnss_serial_allocate(struct serdev_device *gserial,
-						size_t data_size);
+					 size_t data_size,
+					 u32 serial_speed);
 void gnss_serial_free(struct gnss_serial *gserial);
 
 int gnss_serial_register(struct gnss_serial *gserial);
diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 7b05bc40532e..52ae6e4987e0 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -68,8 +68,9 @@ static int ubx_probe(struct serdev_device *serdev)
 	struct gnss_serial *gserial;
 	struct ubx_data *data;
 	int ret;
+	u32 speed = 4800;
 
-	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	gserial = gnss_serial_allocate(serdev, sizeof(*data), speed);
 	if (IS_ERR(gserial)) {
 		ret = PTR_ERR(gserial);
 		return ret;
-- 
2.7.4

