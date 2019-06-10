Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F83BC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381B12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3IPYAnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfFJImu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:42:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51200 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbfFJImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:42:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so2726770wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9rm9ccpuGtAMzIOW1NWstMoYndtXNXfoUtRC4Q0MWiI=;
        b=O3IPYAnJIDAl9EBtH7E8TaBsbNYtCKJBzNXBhBSGchgmycGXMZ+SeXXWnHSJOF+E1x
         lQJx8GEVyLHbCQSfwQGcmlHAXj/qpJqdYd+xa6Ge30LjoqMMj+e3DI1Mf5jTQdOnB7lv
         qBdw4GPvolTSV9zkgu3+9mYCaajae+noAZGPuKK4G0hfX8CoHLO+xuJwymz43tAPCRTS
         oFAksS5WtCnQ7hjeAO1Bx0DsLKc7CGuGhzCCjiYBjfnFqYs9mTkBQ+gLf+CtMSny0UhA
         EEWQm6DVSKX1xMXFHmiAC7i0TC6/CjOQCe/Z53vgI+f5Bs62A+INNhrLfdctLDZ8DOfP
         EVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9rm9ccpuGtAMzIOW1NWstMoYndtXNXfoUtRC4Q0MWiI=;
        b=N6mKuNmwtx0k+ejeqUNbtOEq0h4iJRkXbXv8vK1Qu1iQ7jSSqcQKlM2HXU89qtwlW5
         oXZY+CS2qoRe0WU/H5cDe2P47xWoiCnai/YpY0KLFcw02eOxSQMYCZud6bP/VNvO6y0u
         ranns+lD6XWtdaHQodzQWVu69xN+4U5o7MDOLItlnL3nne4iftZdsIF7M2QRz4eaFCkT
         s4xbG1D2TkBtYWuKg73o9UFtbtmUUJiXg5ZhMq9K86FAZLRecCM0HT/iSRFsltC8CfOq
         /7M2DCrIfkHNc5GOiAYm+2f9KV7uGuaIGsKTn4ZJPs5eK/zIIiZCQltYD7gL7Cl3ljYb
         DFJg==
X-Gm-Message-State: APjAAAX+rmvmaYsgQ8nQaHIksxaJ3go0mJvmru4wroupmXdplsSp6tTC
        Qf+dQ1WuBbWzzj6lSBEQNd+uFw==
X-Google-Smtp-Source: APXvYqy0TzWjN//I98gsrjpi6bkDoeqKWl3h2z+48UmR2v8GC9sKAVPvXFf6vTUnnB6w26x9gz61Hg==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr13074978wma.114.1560156140428;
        Mon, 10 Jun 2019 01:42:20 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a125sm9929670wmf.42.2019.06.10.01.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:42:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 5/8] soc: qcom: geni: Add support for ACPI
Date:   Mon, 10 Jun 2019 09:42:10 +0100
Message-Id: <20190610084213.1052-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610084213.1052-1-lee.jones@linaro.org>
References: <20190610084213.1052-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with ACPI as the active set of configuration tables,
all; clocks, regulators, pin functions ect are expected to be at
their ideal values/levels/rates, thus the associated frameworks
are unavailable.  Ensure calls to these APIs are shielded when
ACPI is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 6b8ef01472e9..d5cf953b4337 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
@@ -450,6 +451,9 @@ int geni_se_resources_off(struct geni_se *se)
 {
 	int ret;
 
+	if (has_acpi_companion(se->dev))
+		return 0;
+
 	ret = pinctrl_pm_select_sleep_state(se->dev);
 	if (ret)
 		return ret;
@@ -487,6 +491,9 @@ int geni_se_resources_on(struct geni_se *se)
 {
 	int ret;
 
+	if (has_acpi_companion(se->dev))
+		return 0;
+
 	ret = geni_se_clks_on(se);
 	if (ret)
 		return ret;
@@ -724,12 +731,14 @@ static int geni_se_probe(struct platform_device *pdev)
 	if (IS_ERR(wrapper->base))
 		return PTR_ERR(wrapper->base);
 
-	wrapper->ahb_clks[0].id = "m-ahb";
-	wrapper->ahb_clks[1].id = "s-ahb";
-	ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
-	if (ret) {
-		dev_err(dev, "Err getting AHB clks %d\n", ret);
-		return ret;
+	if (!has_acpi_companion(&pdev->dev)) {
+		wrapper->ahb_clks[0].id = "m-ahb";
+		wrapper->ahb_clks[1].id = "s-ahb";
+		ret = devm_clk_bulk_get(dev, NUM_AHB_CLKS, wrapper->ahb_clks);
+		if (ret) {
+			dev_err(dev, "Err getting AHB clks %d\n", ret);
+			return ret;
+		}
 	}
 
 	dev_set_drvdata(dev, wrapper);
-- 
2.17.1

