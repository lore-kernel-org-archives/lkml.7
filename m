Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6CC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF4720850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvWa+WCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfDMI2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34746 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDMI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so6300185pgq.1;
        Sat, 13 Apr 2019 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=670khlUAQ7b+mdcFjnUxliytjVghTmzI+4tSFDYoDV0=;
        b=JvWa+WCJ0nQFxcMDztgL7cvTETI04o6f+/1mbkfxufljKmEZy2ar2pER3ypM3qbk+H
         rwbQBRT7q7TJjCPwAqyTNQitFIo1kCyAY1xJdDIgi0VsDQjtKw9vkN1riBXggfUz6U45
         ew5a7vsUu3GCf3bm2b2c8n1hjXT0+5koE69pBrkJOYURdmHh5kSHm7KyESm2FL7DSnxK
         iSxJ5RAB4bMXKm/ARzaUvtNMQwcvavsxXxmbsEhwZtYia9v+lrzxjqntBvsG7Z+w0Rnb
         2D+gbDX7IZyH7sA3hnES8cC03bDBE7WxbNTL4z2YlemU4tUboSX49l1ILhRPhUleCnDl
         ZQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=670khlUAQ7b+mdcFjnUxliytjVghTmzI+4tSFDYoDV0=;
        b=hzYH18YVq2zixfri350xU25BJieoJI+S9Ue1LxZGzi+S78qLWV3KRxP+tOhftHKjcg
         w7Y/TyrfrzfW418BHWwZxWk7D1rHbZPz2k2gPlZxoQyrIajXX1KSLoaOAPtFmSEEJa25
         oEIftbaZd+mCN08KHvrSyme3nWwe8GiWLYWm4hu87b4dQ5bvzBSNdFDk/2MlyBSX0G+Y
         oi1KKHpmtbQGirJUTQI87sz76q3a10MYhxfIH2nXzaZh6iJfzmKfXlBQTgLGG9dWGYIZ
         FjLDv9aWJN/e8BfK07vwHnnNC7cStllfkgqjGH4XeazbvWYmxFm/QcJb80SE33HkM2wW
         g05g==
X-Gm-Message-State: APjAAAUZin4qDcl4enlqGwMfqbpSOHhGcBsbk0A9kqB1cSmef8JxiSd+
        WZ/nQvVpC1H88QzX5+YU+3WQOYre
X-Google-Smtp-Source: APXvYqzVYY+QIRzorwF85Ykxn4Sf20tppXUzmJuSrznaXTq3AxzncPxaILKvwd8kdMfc6mfnfLkMiw==
X-Received: by 2002:a65:648c:: with SMTP id e12mr58730486pgv.346.1555144092845;
        Sat, 13 Apr 2019 01:28:12 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:11 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/12] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Sat, 13 Apr 2019 01:27:42 -0700
Message-Id: <20190413082748.29990-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
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

