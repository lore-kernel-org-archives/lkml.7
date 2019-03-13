Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD961C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AEF2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in4OR4yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCMMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:25:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44690 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMMZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:25:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id q128so1356697ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlBsHnptz3zRzAnNrHOWapsTdjSs3bPM60FFJR8pDRI=;
        b=in4OR4yr0odatAAOVT2sdwzdUrJH++Lp9FBZRaxQguafFvke4lE6A0LiS7eHil5/gz
         3y8hbp1WCGPg+J1Nkvh7gJkGC9tqtNBTESuOTBexmp1hJiP+uKySfJUU2k1YNGo4Y2c3
         PrfgjYRe/ws5yIxgN46fWIjRZcUJnjo+6DAfSg3i0WdxfxYlu/qww/NTR+MVF3Jkoagz
         +hqPJ+Pfyw/2KBs5zpPZZcX7cnseH6KXnkhITXaUPj+Y6uQDRZegQRzGZvHdQ+lk1XGW
         LVHgeqMP9QK+e2pASheUUNwAj+v98SGxe+jykC134BZugiNb6DYnf9lDhiYTZ7uBnr0S
         PeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JlBsHnptz3zRzAnNrHOWapsTdjSs3bPM60FFJR8pDRI=;
        b=ZAHNtJ3oSILIA3p/TJGHPO32d0d5t4PGYZ87lLhbH8/9tlOFmFSVot12mMw1AKcGBv
         4u13d0zJYBuXtcd6XfeDPLl8OQHXUqSGTsjpnZW3qd1ueqSG4VI0JrDdqg6tYoLIkJ4Q
         z4ggt7MBFkdYV174PIyxu4tDgpMgCK8P3KdZG1T+15ywojI15RSZoS2iU28aFf9y1xYv
         Zh01rZ2ZJ9JQBrlY7reSHjKs9fiBYsQORAoEtVJ1k4THF6P47B5xH5QqtXaUAg3oRDLq
         5/lA3nMoSXIXQVnYbChN/P8gPg37T6JV/DYIJM0XU2ghPlR1Zm98nbK299oH9Yiaspo3
         LF4w==
X-Gm-Message-State: APjAAAXJcI9ZwFcadlay9hOjljnRTHQmq0GbmzvkUXaaHEgopxi6o+rq
        T0Ybsbk7US2XyCBHwDYpiQATjSGXYVI=
X-Google-Smtp-Source: APXvYqxfxqAiOlK4kKZQmodFZbCJ+i9ypVUX5NsXI6VzQ2uUvmIMn8PD2oxyzmzctfpEJyACqdw4KA==
X-Received: by 2002:a2e:b1d1:: with SMTP id e17mr23335335lja.120.1552479945215;
        Wed, 13 Mar 2019 05:25:45 -0700 (PDT)
Received: from lamport.payandsurf.com ([192.36.80.8])
        by smtp.gmail.com with ESMTPSA id i185sm1953076lji.81.2019.03.13.05.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 05:25:44 -0700 (PDT)
From:   Armando Miraglia <arma2ff0@gmail.com>
X-Google-Original-From: Armando Miraglia <armax@google.com>
To:     neil@brown.name
Cc:     Armando Miraglia <armax@google.com>, gregkh@linuxfoundation.org,
        matthias.bgg@gmail.com, sr@denx.de, sankalpnegi2310@gmail.com,
        gch981213@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: mediatek: Attempt to address style issues in spi-mt7621.c
Date:   Wed, 13 Mar 2019 13:24:04 +0100
Message-Id: <20190313122403.248873-1-armax@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running Lindent on the mt7621-spi.c file in drivers/staging I noticed that the
file contained style issues. This change attempts to address such style
problems.

Signed-off-by: Armando Miraglia <armax@google.com>
---
NOTE: resend this patch to include all mainteners listed by get_mantainers.pl.
 drivers/staging/mt7621-spi/spi-mt7621.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index b509f9fe3346..03d53845f8c5 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -52,14 +52,14 @@
 #define MT7621_LSB_FIRST	BIT(3)
 
 struct mt7621_spi {
-	struct spi_master	*master;
-	void __iomem		*base;
-	unsigned int		sys_freq;
-	unsigned int		speed;
-	struct clk		*clk;
-	int			pending_write;
-
-	struct mt7621_spi_ops	*ops;
+	struct spi_master *master;
+	void __iomem *base;
+	unsigned int sys_freq;
+	unsigned int speed;
+	struct clk *clk;
+	int pending_write;
+
+	struct mt7621_spi_ops *ops;
 };
 
 static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
@@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
 	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
 
 	if ((spi->max_speed_hz == 0) ||
-		(spi->max_speed_hz > (rs->sys_freq / 2)))
+	    (spi->max_speed_hz > (rs->sys_freq / 2)))
 		spi->max_speed_hz = (rs->sys_freq / 2);
 
 	if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
@@ -316,9 +316,10 @@ static int mt7621_spi_setup(struct spi_device *spi)
 }
 
 static const struct of_device_id mt7621_spi_match[] = {
-	{ .compatible = "ralink,mt7621-spi" },
+	{.compatible = "ralink,mt7621-spi"},
 	{},
 };
+
 MODULE_DEVICE_TABLE(of, mt7621_spi_match);
 
 static int mt7621_spi_probe(struct platform_device *pdev)
@@ -408,9 +409,9 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
 
 static struct platform_driver mt7621_spi_driver = {
 	.driver = {
-		.name = DRIVER_NAME,
-		.of_match_table = mt7621_spi_match,
-	},
+		   .name = DRIVER_NAME,
+		   .of_match_table = mt7621_spi_match,
+		   },
 	.probe = mt7621_spi_probe,
 	.remove = mt7621_spi_remove,
 };
-- 
2.21.0.360.g471c308f928-goog

