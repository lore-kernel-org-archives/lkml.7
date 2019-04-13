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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01D3C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677DA218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 08:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWaKvEvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfDMI2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 04:28:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35652 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfDMI2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 04:28:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so6252583pfh.2;
        Sat, 13 Apr 2019 01:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqyqtoK3GtgMDfL06tkuGJvc1GAcOS/xIw9/fZv75Dc=;
        b=CWaKvEvqE/ZkGmUe7ZlweVMWuuv9thcD6wvJjqaU4wCiECWYRfg4eQ/VExI26NZ4rS
         URD49jAVRgZYVbwCzMGwn93lyp8CCJ70R8ZykS97XVkbSQQnkliNNZlfcpzcihUndmpH
         F3bHxjV0ePJNNsjyU3nIyMA+gZK6XbU1ofz3tga2znsSs+Cp63KNlYeuUyhjyK3Av2Kr
         mEs2rzZ61IxJxWJ9ZNfc5aIcMiuEfL6Mz1Q5byRp/3udt36IX4nG6EJlqMD08Fm04/8r
         RhKfzzwxn6xnGoloJlYUrkKFtL3ap39JGBD6G1NPHIOpkH9Kn/gsAPpAqTyiYSGezQbp
         1k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqyqtoK3GtgMDfL06tkuGJvc1GAcOS/xIw9/fZv75Dc=;
        b=oJFc32iFx+j6+/AsuJRAcWhe0FOZHzWpdilpVEVl7q5aeDTlrP3PuLA8ajWFgzcK+0
         u4xlG7Tp9VvGCEN2714HJNg97KFSueCvt0CP7MADRLpryMZKRBpSwU/tcALqsxdsPzeW
         OPoy/SVeuiXed7Mm2jh86dEUM71SVtdIDgdSl+j71052y/vgoDeF4CC3y7F4SpmjGoKH
         sx+bzckh2kL/3I3lRAZciggGNivZi/vTvgwaAtwFUIxb3Gf1SNIKaBHgwnsAiXhcikq9
         1lnj1EK4V5YD9le91gZesbqHFFaVYtnCsQ2YXHJlwUfz4vVovWJ56JgbWzUTCW6dDFeS
         0wRA==
X-Gm-Message-State: APjAAAULFBIQv3qa8+D4PAjDVZqR6zW2KsMs/bUOT86aBGG0rFVZCNaj
        pu6Xv5al+C5zQz2fTSA+GeltmaIl
X-Google-Smtp-Source: APXvYqwi9ijyU+mKtKqsmzCPgNVWiChKvDWQWB7FuS1nnz5A+ExYGvt6khlU3v0UZyDRcaU6D8iBag==
X-Received: by 2002:a63:9dc4:: with SMTP id i187mr54515057pgd.259.1555144094140;
        Sat, 13 Apr 2019 01:28:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z20sm58261328pgf.70.2019.04.13.01.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 01:28:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/12] thermal: qoriq: Convert driver to use devm_ioremap()
Date:   Sat, 13 Apr 2019 01:27:43 -0700
Message-Id: <20190413082748.29990-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190413082748.29990-1-andrew.smirnov@gmail.com>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
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

