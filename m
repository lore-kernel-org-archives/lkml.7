Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86936C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E01C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTPQ4SjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbfG3SQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40021 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbfG3SQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so30255676pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwX6Q3petjt7ZHxXHJxp143s71CD7WUkzNEZtVWduK0=;
        b=WTPQ4SjIDQc7S5fxLNjZEL8vhGML5akjZ79EhRwpnAwq++KnpnzLADN8z1MfRuE+Wa
         0A0f27jMKdtozURfODEAXfhCXJvIhS62w4M1SMor6Wqfl5AzuEJuNc4mF5dJxpBD+ktZ
         3sAWYXcpMnNZuKUToYIhV1TdOPaaYsuJRdZ8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwX6Q3petjt7ZHxXHJxp143s71CD7WUkzNEZtVWduK0=;
        b=a79WyhUpXd9C+KhWKg13wBS52g16FlpbIPVHo0CUMXoZV1+c8cWj/uYXs2FXLxSi1H
         pXoDEbke7xm7eG8Pa7CJNjuUOSefnOBhBju1HyHLeU6xeeH2u4/BJf0/4qELozNBG9Rf
         ZKz+Ucan4nncNr2Of/O3+9hBSamadXX2m9B0oticXpcuMaT1evzdDDHZZRO5MterPiId
         1aPbaVsNp8kS4Sa8V43jZsOWPHfrSM9l3OCHdndRZB/14sxdI9/wACFvpcFGjHqo1aS+
         /l6aG/gtfqLLMVJ80ivMmzDzbCcnGvewCL61REHmleyQrqQDwXLvKRae1Qa3xHcWzYrp
         smrA==
X-Gm-Message-State: APjAAAWVeHtqfC6DAwc4lzs15uVR3GNrYS3ViaGUi+s5kRj7FmwAlfTl
        148hTxiHfVm3DFj6BNdYQJ94UuaJK3E=
X-Google-Smtp-Source: APXvYqwL4b6ZNTaezqxxCk/3M3n2NXZXHjxCxKd02HRT48oxIoFWo4TjBBEb2lKuD3hHRWRGRFEHbQ==
X-Received: by 2002:a62:6dc2:: with SMTP id i185mr43778140pfc.40.1564510581377;
        Tue, 30 Jul 2019 11:16:21 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 27/57] mfd: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:27 -0700
Message-Id: <20190730181557.90391-28-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/mfd/ab8500-debugfs.c       |  8 ++------
 drivers/mfd/db8500-prcmu.c         |  4 +---
 drivers/mfd/fsl-imx25-tsadc.c      |  4 +---
 drivers/mfd/intel_soc_pmic_bxtwc.c |  4 +---
 drivers/mfd/jz4740-adc.c           | 11 +++--------
 drivers/mfd/qcom_rpm.c             | 12 +++---------
 drivers/mfd/sm501.c                |  4 +---
 7 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index d24c6ecccb88..e44a582050f2 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2682,16 +2682,12 @@ static int ab8500_debug_probe(struct platform_device *plf)
 	irq_ab8500 = res->start;
 
 	irq_first = platform_get_irq_byname(plf, "IRQ_FIRST");
-	if (irq_first < 0) {
-		dev_err(&plf->dev, "First irq not found, err %d\n", irq_first);
+	if (irq_first < 0)
 		return irq_first;
-	}
 
 	irq_last = platform_get_irq_byname(plf, "IRQ_LAST");
-	if (irq_last < 0) {
-		dev_err(&plf->dev, "Last irq not found, err %d\n", irq_last);
+	if (irq_last < 0)
 		return irq_last;
-	}
 
 	ab8500_dir = debugfs_create_dir(AB8500_NAME_STRING, NULL);
 	if (!ab8500_dir)
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3f21e26b8d36..2f4c9c9ed80f 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3128,10 +3128,8 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 	writel(ALL_MBOX_BITS, PRCM_ARM_IT1_CLR);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "no prcmu irq provided\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	err = request_threaded_irq(irq, prcmu_irq_handler,
 	        prcmu_irq_thread_fn, IRQF_NO_SUSPEND, "prcmu", NULL);
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 20791cab7263..a016b39fe9b0 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -69,10 +69,8 @@ static int mx25_tsadc_setup_irq(struct platform_device *pdev,
 	int irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Failed to get irq\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
 					      tsadc);
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 6310c3bdb991..739cfb5b69fe 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -450,10 +450,8 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Invalid IRQ\n");
+	if (ret < 0)
 		return ret;
-	}
 	pmic->irq = ret;
 
 	dev_set_drvdata(&pdev->dev, pmic);
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index 082f16917519..18344cd08ede 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -208,17 +208,12 @@ static int jz4740_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adc->irq = platform_get_irq(pdev, 0);
-	if (adc->irq < 0) {
-		ret = adc->irq;
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
-		return ret;
-	}
+	if (adc->irq < 0)
+		return adc->irq;
 
 	irq_base = platform_get_irq(pdev, 1);
-	if (irq_base < 0) {
-		dev_err(&pdev->dev, "Failed to get irq base: %d\n", irq_base);
+	if (irq_base < 0)
 		return irq_base;
-	}
 
 	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem_base) {
diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 4d7e9008628c..71bc34b74bc9 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -561,22 +561,16 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 	clk_prepare_enable(rpm->ramclk); /* Accepts NULL */
 
 	irq_ack = platform_get_irq_byname(pdev, "ack");
-	if (irq_ack < 0) {
-		dev_err(&pdev->dev, "required ack interrupt missing\n");
+	if (irq_ack < 0)
 		return irq_ack;
-	}
 
 	irq_err = platform_get_irq_byname(pdev, "err");
-	if (irq_err < 0) {
-		dev_err(&pdev->dev, "required err interrupt missing\n");
+	if (irq_err < 0)
 		return irq_err;
-	}
 
 	irq_wakeup = platform_get_irq_byname(pdev, "wakeup");
-	if (irq_wakeup < 0) {
-		dev_err(&pdev->dev, "required wakeup interrupt missing\n");
+	if (irq_wakeup < 0)
 		return irq_wakeup;
-	}
 
 	match = of_match_device(qcom_rpm_of_match, &pdev->dev);
 	if (!match)
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 9b9b06d36cb1..d5e34a5eb250 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1394,10 +1394,8 @@ static int sm501_plat_probe(struct platform_device *dev)
 	sm->platdata = dev_get_platdata(&dev->dev);
 
 	ret = platform_get_irq(dev, 0);
-	if (ret < 0) {
-		dev_err(&dev->dev, "failed to get irq resource\n");
+	if (ret < 0)
 		goto err_res;
-	}
 	sm->irq = ret;
 
 	sm->io_res = platform_get_resource(dev, IORESOURCE_MEM, 1);
-- 
Sent by a computer through tubes

