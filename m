Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA31C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6F120656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipDy77we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfDXGtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40014 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfDXGtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so8775547pfc.7;
        Tue, 23 Apr 2019 23:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pw50JgDhUcKkNYBloufZIdnXk6gV4pVeryvS+GkQqDw=;
        b=ipDy77weuN/EqZ6gkmnRLnAyfECks5d3X7gSLv8g8vLLV/57j9cKXii+/ljIv2O52H
         XmY9tfUm8vTamXzSLPy9VKV78rRXjAKQgTHY2QNA8oFLz/3QZf9caBM/S/5uMqrlgGGa
         nNZ1+eiUdbtkuFHBsL6GRQyKDM8v8FOm9PyxEHiup/n+LbeTwtNnxN+oMz1QbG/PWDjE
         Ri0e4dYzVfO3nWcSe2rFQR3P3cdaeAqUkd12t+5+KN1T2nhFY9EF01GFv7tPJfpWsoH0
         8A7U/dEel5dxr4d5rvH0BXlbPD6SeO2pE1K4MTlkdvdco0E+6TkD/ZsLdj10/Vo0x6kp
         6A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pw50JgDhUcKkNYBloufZIdnXk6gV4pVeryvS+GkQqDw=;
        b=QBXgD3Rm6lSW4l3OkFUPAFUB/IRAsbpuk5wZ/zmlAfPMZWDm4g9jVL7J+L69MRLF5L
         hFsV4ooXaceNroqYD6JvXtZCNbWm2ll0djSfarXn2XnWUOrgjIz/MfUqJeu1EczeAU6M
         zMYr6UymPhXbCT6nEp5WXzZQCwCTakMQCpfGnbWDa+J6rmXI+vF4XADOVTbAMKtlJRg7
         J6EX74dhEj95nn9Zm4OYQHoO8G7qaAEtR2K9gGQdjgvufVbZuSqOKFMXCE9NnSgi5Sbk
         YKHAmax4iDcE7PxHuNwn76/ra80Ges/yutvC5gH7KUEnHKUj+Eya1fKeUuBExZpOyQyO
         jKDA==
X-Gm-Message-State: APjAAAXt9F5utUnIl9oG2RqBCkPdoHn5KxEK/3Gl7GH4TVQhBH34kPP4
        wKayph6rtzH2KWBUQbxNITY/yNPDGqs=
X-Google-Smtp-Source: APXvYqySXbTUiGn3K88dMI7QJL1vMXv9TdR4llQU0+OCPYfX4OsrENUD3GvYlsuDjWm+YvKpZIjDew==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr29662970pgq.256.1556088556250;
        Tue, 23 Apr 2019 23:49:16 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:49:14 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/12] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Tue, 23 Apr 2019 23:48:24 -0700
Message-Id: <20190424064830.18179-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify error cleanup code if instead of passing a "struct
platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
pointers from it, we pass those pointers directly. This way we won't
be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
and consequently would be able to drop the "err_iomap" error path.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3419505a2f0a..0b6937bbc7d0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -122,16 +122,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 	return 0;
 }
 
-static int qoriq_tmu_calibration(struct platform_device *pdev)
+static int qoriq_tmu_calibration(struct device *dev,
+				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
 	u32 range[4];
 	const u32 *calibration;
-	struct device_node *np = pdev->dev.of_node;
-	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
+	struct device_node *np = dev->of_node;
 
 	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
-		dev_err(&pdev->dev, "missing calibration range.\n");
+		dev_err(dev, "missing calibration range.\n");
 		return -ENODEV;
 	}
 
@@ -143,7 +143,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-		dev_err(&pdev->dev, "invalid calibration data.\n");
+		dev_err(dev, "invalid calibration data.\n");
 		return -ENODEV;
 	}
 
@@ -181,20 +181,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
-
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
-	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
+	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
 		goto err_tmu;
 
@@ -202,17 +199,16 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-		goto err_iomap;
+		goto err_tmu;
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 
 err_tmu:
 	iounmap(data->regs);
 
-err_iomap:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
-- 
2.20.1

