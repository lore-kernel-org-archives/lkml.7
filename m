Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D1C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wikC+rZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfFGI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:29:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40671 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfFGI3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:29:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so1228841wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ixa6PZM7Qd3yNTQ1/2lb9UJukHzNBYD4+3OM8ec4OSs=;
        b=wikC+rZdUqNR3zYa4TZ+AvztWEikBNz5wbZm7r65rxsnDyDgTfXlcYq+WBYqLs5jOj
         hr74PKupzOhMt9dxYf6nfiWkRnedKpch2Vvd51AjOYuHM9Sd+qNyIws2b/VS4SqYvvW/
         TVZsTX7wKv/zNdLjvgeu61VENnYiQR4EMDVwBn+sbW6KBtD/NpmwstvwzEddF2SEOiu1
         O1VU/WvDqteNLlGZQDiR725yriDo+UadwNwdtidpPyKmw4jNY53RybTW4UkDYFMuPBPk
         ZF3ChktwCFp49vXoN989jLPXyfMlgOlk9DRIVrUTXbWabbEqSsLw0HnmNMNlGZaZd+n7
         m4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ixa6PZM7Qd3yNTQ1/2lb9UJukHzNBYD4+3OM8ec4OSs=;
        b=nmIAJTgxBF/ck4lK8D5UfrKH4RmK5YgAaOksb4aClQUnuTOSyBq7jGERplobPQ3MHe
         Eg3Ord8oqqzWAnjrr96meaUfh8/fiYiWmMXs8QUMqcjklcsMCE1W84WuQyFib0QS7gEt
         YyKL45bUEpyY9y/DxpsfRnkVM9PfIQ6PYQQaK3SGibIN5PGRkoobSHq+AFQ7OBBHj7v8
         sLqNPVaLTqHqGC6ghwX27C7RbYFP4MJGAkp0jCJpya97MHoogcJkx6mFFnVMLS6sD++5
         rHAzoYxd4JUS32GbomaOpuP8Yzts2vB62/b3AjYORjcq7a4e81rvYl4DJb0AUVSFXk1B
         2oPw==
X-Gm-Message-State: APjAAAWKw++zXQca6a/UvdGgiwuZCMioceYBaNIwsl2T1nmj0fCTUoTS
        gLhrU/sP1C5dRW7J9J/76zFVFg==
X-Google-Smtp-Source: APXvYqyChDV4RwAoziCux2dyzIiqJh49IzYKRL5KUJXCLJZjX/vcFT6zQy7kquy2uTSLwjq9N/DShA==
X-Received: by 2002:adf:ab11:: with SMTP id q17mr18952194wrc.182.1559896148016;
        Fri, 07 Jun 2019 01:29:08 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a3sm1092946wmb.35.2019.06.07.01.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 01:29:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 5/8] soc: qcom: geni: Add support for ACPI
Date:   Fri,  7 Jun 2019 09:28:58 +0100
Message-Id: <20190607082901.6491-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607082901.6491-1-lee.jones@linaro.org>
References: <20190607082901.6491-1-lee.jones@linaro.org>
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
index 6b8ef01472e9..cff0a413e59a 100644
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
 
+	if (ACPI_HANDLE(se->dev))
+		return 0;
+
 	ret = pinctrl_pm_select_sleep_state(se->dev);
 	if (ret)
 		return ret;
@@ -487,6 +491,9 @@ int geni_se_resources_on(struct geni_se *se)
 {
 	int ret;
 
+	if (ACPI_HANDLE(se->dev))
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
+	if (!ACPI_HANDLE(&pdev->dev)) {
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

