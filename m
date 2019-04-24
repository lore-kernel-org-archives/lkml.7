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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C080C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C14120656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1VF/2wV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfDXGtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:49:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37669 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbfDXGtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:49:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so8792337ply.4;
        Tue, 23 Apr 2019 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jj7xWSCu2Jvjzo3iEjqtPAm50x1l724NJndLXKBO4U=;
        b=e1VF/2wV2sS+0wFTgirKUMj8faG2UC7kXbI2dSsc8Wglit8rvKTgNVM1CejJNT05pa
         gEt5iEqYoLCiPSEO7xDAJpc5UWBCtWBFqXyD+gIQb2DYAEPxl2dz48yRSE2lsTZfVgkJ
         bD9BOtuIK117DWpx65qQQdW5n0cP1GRt/Zeqp9UMJqa6PuWSTzvTKGYhEQGjHUFeMkmx
         56cengUfcBIGJOdkS68cChJGUcPhPEqD4F72Y/78T7TzNBYbI4Yk3VJSNEY1Nnpe/qsr
         8RY3OWGiJSZy5qUf2KgHC6R48OnQ8bPXG0ZXc5ZzehE2Ek3BFFNcvXW0OodI/Gk3YZ/y
         0Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jj7xWSCu2Jvjzo3iEjqtPAm50x1l724NJndLXKBO4U=;
        b=Torv9jasNAa6F/PR7E0EmKQBL76Cm/KfNRxxr5SKbJ9jfDr9y02GNP2oIvPD9j1xrP
         9VZqGQ2wn8mtq1pZB7ZPGUiq7C/svKlYw2SMg+HtQ5LrX2y1zhn+RG5WJ984K0+NbEqw
         irghqnOaJdI+3ViDeEDYmNjqcXbXdCOJ2OI1E2tPNH9nWboBtCAMJReOezriXNdjAWNw
         ek5ZsUP4Pb6Ut04SSZmq+k3Cil3afR81cUZgXByjMfM0DnTQMmXLdJPUIhTchjpH6Kkx
         SAMGNlFO4x7hJsGxEGyKyTWg2lPaJsfwccwiWYbRI072aQMZMIcyHiz8lHr/Lw0w4Z5v
         aG1Q==
X-Gm-Message-State: APjAAAXETLZuYDF6ZpttvADjLZ85M8coWq534QXsJdjURjRbxjK+q3Nh
        bCHJ4MubIBEGunz9g9E5rC9g9rdkqrY=
X-Google-Smtp-Source: APXvYqz44S4ts5ZAZvjah058KnwXd4auOAzS8js0AdTIjoZ0LclKHCDe4lnyFfqEVuBPHsAzjqyStw==
X-Received: by 2002:a17:902:a582:: with SMTP id az2mr31258983plb.315.1556088557553;
        Tue, 23 Apr 2019 23:49:17 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e13sm26332457pgb.37.2019.04.23.23.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 23:49:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/12] thermal: qoriq: Convert driver to use devm_ioremap()
Date:   Tue, 23 Apr 2019 23:48:25 -0700
Message-Id: <20190424064830.18179-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424064830.18179-1-andrew.smirnov@gmail.com>
References: <20190424064830.18179-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use devm_ioremap() to simplify memory deallocation
and error handling code. No functional change intended.

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
 drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 0b6937bbc7d0..64cad6d4c1d7 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -175,6 +175,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct resource *io;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
@@ -183,7 +184,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
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
@@ -193,23 +200,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
-		goto err_tmu;
+		return ret;
 
 	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
-		ret = -ENODEV;
-		goto err_tmu;
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
@@ -219,7 +220,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-	iounmap(data->regs);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.20.1

