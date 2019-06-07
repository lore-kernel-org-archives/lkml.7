Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C04CC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C5A2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jz5mKAbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfFGI3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:29:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfFGI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:29:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id b17so1213339wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nQjqkj1EN8NC8Ay0yEHmwn6X2HJX2TtkXyONunIjoOQ=;
        b=jz5mKAbUNpc/2XrbWWbZCNJngHPyu1CFGXMDH3jsY6dBNiylltjRxlPmEIjFvwWsHB
         G1s9vbvPWlTLMh5h0UuE5dNLrvZd8+Wp+SJU3n9JXQdMMbvR7PNj6ikzJHB6SWy9kpgw
         2Mbhc2hqW2YDw+8oPUxyi4UcJXUWflUNc9hFXsZ94aEJWUlNlJDXYQuOkr5ViQaBGfUO
         Q/NM4GLddz0ePkHqkojIxiNV4cl1J5V09BxBngzM1H4LgO3x1dYkWq/fnUvODE4L8CQz
         E2IOMdqvU91OVm2QCcLf6C6cvnHAO30XIzPYH8mVqqnIYhNEs6SVCDupXrCIZMxiYhz6
         U6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nQjqkj1EN8NC8Ay0yEHmwn6X2HJX2TtkXyONunIjoOQ=;
        b=lBFoNxf767PppJIRLACE7SRWiatUL0osfWEZl2VzII4XG6U5Bd+DwscW8Qu1gZo19K
         1n88iTs69Szf2UbDmJX/u2Ma22ZunMRDRyEqB1+e6sf6o6dxfW9Dz9ZSEwKGZDHTBoMX
         K1uRQcUt9ybIsXvUFNhg2LL0YoluNPSD5ggluKsUS6xuU0w+dT1mpOoN7qmDpu7JPlDA
         2z7gbo9CkFi6LDhfoSNXKq0ZUD4zm98Qll09Mq1yiFmH1tv3E04NtKG8QO2VNIfhMDD/
         cMr6K3uYFMInJY6MA16AQX+iyhsLfsCxfAV9cul6FkfTa3N2AsOav9XiH1IFT7BYoKiE
         YPmQ==
X-Gm-Message-State: APjAAAX7mzgb5HhDH956G7vL8Xwa/ORcx9Qhh1alp1zRerzOhWSrEy/S
        vUuqzMFJeXqP7QrQv9qnAKtruw==
X-Google-Smtp-Source: APXvYqw3tK85mPCJtNwImGvxXwtTRJVHn4uSWnyncRx2pOscbKR2RIrb27s86mnFP4xtyzHXWFKbKQ==
X-Received: by 2002:adf:e691:: with SMTP id r17mr15939833wrm.67.1559896143573;
        Fri, 07 Jun 2019 01:29:03 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a3sm1092946wmb.35.2019.06.07.01.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 01:29:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 1/8] i2c: i2c-qcom-geni: Provide support for ACPI
Date:   Fri,  7 Jun 2019 09:28:54 +0100
Message-Id: <20190607082901.6491-1-lee.jones@linaro.org>
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

