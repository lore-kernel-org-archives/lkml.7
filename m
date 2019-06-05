Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BFEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEBA20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RH78oA+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfFELnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:43:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33326 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfFELnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so6686562wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nQjqkj1EN8NC8Ay0yEHmwn6X2HJX2TtkXyONunIjoOQ=;
        b=RH78oA+NxoAk2QUd4m2HOQ8dyN2sCxrVo+FvNDasZKbmuqv5dUteK2nYHr3AU8dZY2
         lL6O731jO9kBau+KvwCnnF2pv2zQNFqiUY9zOrc3A4LrxHgl9/zAkEPJlQwGcvHZMo/w
         T5Q+bajSnI9mx+6X4Pf9VCvK19Rxr/TWdt13E2G4DlLn2iW89yA4kT0OaSSfHFXfqVw2
         wsqz5uFfMcqQjg4rZ9X+5QJeBFThsy8V7siule0Y3MR04je8W6A0+CQYQsv0XPB0SH1t
         zd6JjCDEnS9YTtARJbgAB90xZpf4QrVjQTx3SGk0eBWm1D1i41b7bUq302Rnt1ZCH8ac
         ByZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nQjqkj1EN8NC8Ay0yEHmwn6X2HJX2TtkXyONunIjoOQ=;
        b=ogJbfAkZCh87WqAlAU2InIsUXQ3wWtQ1/Ff1gVtj4vFawj1/LOuRYijovrnFkexOVc
         4uqt2IuzfhqrCFwW1efklaWfo1gD3Awlkk7JL5rZ7LN+2wyNW4hIFgOomaKZmiGTtnDw
         d6IdWoXaNj33ppOajO9N3oAoY2exjDwAQVj7Kc2l9fqvwEMqDmz8u5P5ERsIV19bpY+V
         xC38CbfQtPbgMhXQmqyzBkAXq/hB5dKyRTrlZfR+1OdrcUi8EQOyS9BoSSQrYtLf0STQ
         1TOElCEIfAiIr7hJetN5BzQWAAOKclQdytZc1A42FPTy7cGbb1nGL0T5gtaej6YeP5B6
         rkAA==
X-Gm-Message-State: APjAAAWXGhklFA/2Teq9Yfi59QoV446WZFrVh/4ruvzQQLIuDTvlMIS0
        0nfFwBph28Sk8tDVIwtGOZpolQ==
X-Google-Smtp-Source: APXvYqzW/Zk1QYpnjxkfpZRt3FJnFpmA3XMOWzcM86U3SMvvL1uOdSy1dK3RIaWGRhxFidbFe5xSCw==
X-Received: by 2002:a5d:5702:: with SMTP id a2mr9341914wrv.89.1559734987545;
        Wed, 05 Jun 2019 04:43:07 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 34sm27718740wre.32.2019.06.05.04.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 04:43:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date:   Wed,  5 Jun 2019 12:42:55 +0100
Message-Id: <20190605114302.22509-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a match table to allow automatic probing of ACPI device
QCOM0220.  Ignore clock attainment errors.  Set default clock
frequency value.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index db075bc0d952..0fa93b448e8d 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -483,6 +484,12 @@ static const struct i2c_algorithm geni_i2c_algo = {
 	.functionality	= geni_i2c_func,
 };
 
+static const struct acpi_device_id geni_i2c_acpi_match[] = {
+	{ "QCOM0220"},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, geni_i2c_acpi_match);
+
 static int geni_i2c_probe(struct platform_device *pdev)
 {
 	struct geni_i2c_dev *gi2c;
@@ -502,7 +509,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(gi2c->se.base);
 
 	gi2c->se.clk = devm_clk_get(&pdev->dev, "se");
-	if (IS_ERR(gi2c->se.clk)) {
+	if (IS_ERR(gi2c->se.clk) && !ACPI_HANDLE(&pdev->dev)) {
 		ret = PTR_ERR(gi2c->se.clk);
 		dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
 		return ret;
@@ -510,12 +517,19 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
 							&gi2c->clk_freq_out);
-	if (ret) {
+	if (ret && !ACPI_HANDLE(&pdev->dev)) {
 		dev_info(&pdev->dev,
 			"Bus frequency not specified, default to 100kHz.\n");
 		gi2c->clk_freq_out = KHZ(100);
 	}
 
+	if (ACPI_HANDLE(&pdev->dev)) {
+		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(&pdev->dev));
+
+		/* Using default, same as the !ACPI case above */
+		gi2c->clk_freq_out = KHZ(100);
+	}
+
 	gi2c->irq = platform_get_irq(pdev, 0);
 	if (gi2c->irq < 0) {
 		dev_err(&pdev->dev, "IRQ error for i2c-geni\n");
@@ -660,6 +674,7 @@ static struct platform_driver geni_i2c_driver = {
 		.name = "geni_i2c",
 		.pm = &geni_i2c_pm_ops,
 		.of_match_table = geni_i2c_dt_match,
+		.acpi_match_table = ACPI_PTR(geni_i2c_acpi_match),
 	},
 };
 
-- 
2.17.1

