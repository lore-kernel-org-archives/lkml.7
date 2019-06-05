Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CB0C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A14A206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jp/JdV2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFELnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:43:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54667 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfFELnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so1922168wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ixa6PZM7Qd3yNTQ1/2lb9UJukHzNBYD4+3OM8ec4OSs=;
        b=Jp/JdV2yn/wqzzWfOfRwb4FDVYCujOYkpzb+HCTUS8NJcsoL4RrGPGuKPM8+By8ldP
         jPZZn5cDvQZM4hPjpBYEHrh/IeOX0Z7r4dvWciU3vsimgp8YD0BNAI+Gw25gu1z4Gz8Y
         D3ui/SE5BXLU3wep3K6tbv585rzPvuk4KGIyNY5pTZ73EYHFKqL0ETq7VHveP0ik1XbP
         vRjdeVso0R3Qf3fg30cUV1JGbZ9rPnx5URfNBjQnyBqMB1vL7SrpnuPWfhxvEodve6a9
         nxKo++m195buCgkzC5hyYHqa6Y2fqKDvoQRgatziZq1/c9ycvazbtDPQschW4lFDaiTC
         3eXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ixa6PZM7Qd3yNTQ1/2lb9UJukHzNBYD4+3OM8ec4OSs=;
        b=E0VrYRsnTg3wQ5CjxRm5aiV31ACNnUgIWKV0/hUXmHL3nY0envy2VPbM+pgz9uJQ6t
         UInWgzhRSkZDKakOrENKykc/04MtFstrRr3n1n4/Y1hkFe5CGCt4Jaugvqa5ziUTzI02
         dvNFyUaqrGl3BTmKQoMSlKTZgQOGTVcigAvF8cKAzZWTS7fTvX/u1DlZuz6nxMI+flzU
         5D6NdZPxB8zphbfthkkXvfBTdWowjDoPRnEqEpGSG6idsgpEarHBe46rzybutcE2O23a
         M0W9Md4DkLsjIGvPTr1cxL5k9I46a0zoPLxw4ztrMErFIqlTSXiQCvjQFNtP1Q71EKWn
         XwAA==
X-Gm-Message-State: APjAAAUuCHUxj689VBXzofn3BMNOA7s9YP+/53VkEk2bilXYV74DuM1f
        R2HbvKCglDbAyvtJ+NATzdVmPA==
X-Google-Smtp-Source: APXvYqyl2gwOWbUGVEnYEh9X8OzB/jrJfkYNgjV/h4onDE5kOB10EdAyUcgxHPRB9QKTfy4UfkQugg==
X-Received: by 2002:a1c:e3c1:: with SMTP id a184mr1175742wmh.24.1559734991651;
        Wed, 05 Jun 2019 04:43:11 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 34sm27718740wre.32.2019.06.05.04.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 04:43:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/8] soc: qcom: geni: Add support for ACPI
Date:   Wed,  5 Jun 2019 12:42:59 +0100
Message-Id: <20190605114302.22509-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605114302.22509-1-lee.jones@linaro.org>
References: <20190605114302.22509-1-lee.jones@linaro.org>
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

