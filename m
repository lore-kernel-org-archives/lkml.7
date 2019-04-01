Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF5B213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+LdseyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfDAEPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:15:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43573 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbfDAEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so3798263plt.10;
        Sun, 31 Mar 2019 21:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcVZ9OMRJU05n4zXXPXJIKJBB2/Xdz76YG0qUSn0BhM=;
        b=K+LdseyPNH++px/I69Uuqq/qRYCmF0BOvFQG1pYnYZWl9wEBTO92f6CAZUy/bnkLkX
         f9MHNNI0JNmw9T22VsjVIZ0naQh2A9A1WEjlVYFBmyOMqrvGhw803si35mR8BIG9YFH1
         46nl3XWQM8xuRibq2/1QGIWP+y1iMihsZOMJRH60cUqe4gjcyFTjOCjAAjnS7aNceMdq
         dkFc16WyIrNcC233YYG+ToOXt3vuXbq4edClCGxzQgUDsCEBcoqkaqWsE4WJ1zKJH0G7
         FfJWbfYyrxXrjZehvxg7kQZIgYQcWQ9alNSt+0dpcCrTfxJigig+7AxH6qQFK2uGNVo+
         lv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcVZ9OMRJU05n4zXXPXJIKJBB2/Xdz76YG0qUSn0BhM=;
        b=oYD7N8B26DlF4llz1yIQicL740Q6t8S8F3iFKN3zGhF00rWbuSUzthIR/4RkYirDXN
         GemwCulotj0Tl5XcN+CQfRhsHSN+itHWkwTRGedEItDwzL1hDt7VHU7Tn/YOzyQMHBVw
         IwWCX3zHQ7wqdeSJ3J0ISrSitVEgdhEEgmIl1ki5tPWr/RHqOH/H1nWZihVxOaW4tQ+z
         bkfVAKCHTJsFK+a6wJIB/5TGf75u6tGBtKVyfL3YbPddh7FoBFDfniTZsci97qQ3VIXw
         jp4XnAdeoprMRTG5Umcf26VjO5NsEN8Esgp4xVRsFlnRWp7D9YCN09XHtGzK2U9m3GeR
         6Q3Q==
X-Gm-Message-State: APjAAAXBNzaTsx9U+bOBOkPeGp388drK0QPfCYZ0Iuz1iZmtnVdke+wh
        j41xptDujqyYQ1tUYSibYQflOLzn
X-Google-Smtp-Source: APXvYqwKTcGjNqUQOujICbWg3w7DgAv6flx8VHWReP8KIwXu3ViWTFAfHJDA1rJwJcZvG/wP84+4qQ==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr61315607plp.247.1554092085209;
        Sun, 31 Mar 2019 21:14:45 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:44 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/13] thermal: qoriq: Convert driver to use devm_ioremap()
Date:   Sun, 31 Mar 2019 21:14:13 -0700
Message-Id: <20190401041418.5999-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use devm_ioremap() to simplify memory deallocation
and error handling code. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index a3ddb55740e4..4f9a2543f9c3 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -192,6 +192,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct resource *io;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
@@ -200,7 +201,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
-	data->regs = of_iomap(np, 0);
+	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!io) {
+		dev_err(dev, "Failed to get memory region\n");
+		return -ENODEV;
+	}
+
+	data->regs = devm_ioremap(dev, io->start, resource_size(io));
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
@@ -210,23 +217,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
-		goto err_tmu;
+		return ret;
 
 	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	platform_set_drvdata(pdev, data);
 
 	return 0;
-
-err_tmu:
-	iounmap(data->regs);
-
-	return ret;
 }
 
 static int qoriq_tmu_remove(struct platform_device *pdev)
@@ -236,7 +237,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-	iounmap(data->regs);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.20.1

