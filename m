Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F377C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B16206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2LsHJ3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbfILOPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:15:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50756 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbfILOPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:15:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id c10so257786wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U94LXB0H1SLchTUsgjMZwjp3h0cafdMB0BynvaN+clQ=;
        b=c2LsHJ3tBEwEu++rxVvsn78g0L8UGdn7yiC4/N4WA91klnp22ccVAB1m6chQL/Onzq
         RhHrr9XFtyyqbHwCu1B1W+g94jvzJjkTfeDlIRm1O27WepyHaoth/Gs16hJe+L0Z9pbo
         njNWTGxQCTm1gyfrIhwhNHhqw+frkZfE4FpyYuoXtKj2XdpxVE/NV4Y4VvX/AakWvjys
         v8tipJcte9cSWKsE9GIJCbTR/X74OPRpl09XBDpkPW9vo/zKKDTtXStOUMoe4g4o6n9k
         xZxx0QvX8cFKWC00/Y1UN+WXaYKiXKNDC7V+qx0/JFXxnzziXfJBQM+gb9Y2DGDnJ1r+
         tTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U94LXB0H1SLchTUsgjMZwjp3h0cafdMB0BynvaN+clQ=;
        b=j3vtV/LD+GZdQ5wBxBYVvTo3cAvWJtenmrRvE9RlphNwdPvwuoIbOA0ibScJECjjpm
         YSrbVPalDH0ixSMWGW+23/dtIwNbmiFNr0pNYGKm5r+JJ+SmtVY+O1B8uLrSOxSdG/J3
         qgNnySw5slj8u1e+lozgYVkA0E9NcmWvdf6sHS2iRoTZrYlXth/A2t/gZzmMYzTqhcUA
         26pLAycnFj7SUiyOOgUpeHSd9Ay3shAHPHl/Oce3IDe+c5cloQfMwdew2LoOwGBhSCyi
         5KwXAP/ofMAfV6GkTCjpBiALKyDBXT5EpZYofg3eTnIb48fUntE8flyn5b8XMvyXy9ER
         yDBQ==
X-Gm-Message-State: APjAAAWVZ2Yf4/ZCCP/0bGXVAi2je0wGUn7pHRu0IefPh9lZ2js1Ui6W
        /cdg5lWKA6H5hokAwTQSKwCGUg==
X-Google-Smtp-Source: APXvYqy70e0LTKSHReHGBTwSYaCcOtPua5H4LToUok6GoIgFi9Fwo1Yl8Gyg5lX985HrVLB3xIj4Bw==
X-Received: by 2002:a1c:7a14:: with SMTP id v20mr197811wmc.75.1568297745884;
        Thu, 12 Sep 2019 07:15:45 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id p23sm137599wma.18.2019.09.12.07.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 07:15:45 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        agross@kernel.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] clk: qcom: apcs-msm8916: get parent clock names from DT
Date:   Thu, 12 Sep 2019 16:15:34 +0200
Message-Id: <20190912141534.28870-6-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912141534.28870-1-jorge.ramirez-ortiz@linaro.org>
References: <20190912141534.28870-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow accessing the parent clock names required for the driver
operation by using the device tree node.

This permits extending the driver to other platforms without having to
modify its source code.

For backwards compatibility leave previous values as default.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/apcs-msm8916.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index a6c89a310b18..099b028dbc20 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -19,7 +19,7 @@
 
 static const u32 gpll0_a53cc_map[] = { 4, 5 };
 
-static const char * const gpll0_a53cc[] = {
+static const char *gpll0_a53cc[] = {
 	"gpll0_vote",
 	"a53pll",
 };
@@ -50,6 +50,7 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_init_data init = { };
 	int ret = -ENODEV;
+	const char *parents[2];
 
 	regmap = dev_get_regmap(parent, NULL);
 	if (!regmap) {
@@ -61,6 +62,9 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	if (!a53cc)
 		return -ENOMEM;
 
+	if (of_clk_parent_fill(parent->of_node, parents, 2) == 2)
+		memcpy(gpll0_a53cc, parents, sizeof(parents));
+
 	init.name = "a53mux";
 	init.parent_names = gpll0_a53cc;
 	init.num_parents = ARRAY_SIZE(gpll0_a53cc);
@@ -76,10 +80,11 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	a53cc->src_shift = 8;
 	a53cc->parent_map = gpll0_a53cc_map;
 
-	a53cc->pclk = devm_clk_get(parent, NULL);
+	a53cc->pclk = of_clk_get(parent->of_node, 0);
 	if (IS_ERR(a53cc->pclk)) {
 		ret = PTR_ERR(a53cc->pclk);
-		dev_err(dev, "failed to get clk: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get clk: %d\n", ret);
 		return ret;
 	}
 
@@ -87,6 +92,7 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	ret = clk_notifier_register(a53cc->pclk, &a53cc->clk_nb);
 	if (ret) {
 		dev_err(dev, "failed to register clock notifier: %d\n", ret);
+		clk_put(a53cc->pclk);
 		return ret;
 	}
 
@@ -109,6 +115,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 
 err:
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
+	clk_put(a53cc->pclk);
+
 	return ret;
 }
 
@@ -117,6 +125,7 @@ static int qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
 	struct clk_regmap_mux_div *a53cc = platform_get_drvdata(pdev);
 
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
+	clk_put(a53cc->pclk);
 
 	return 0;
 }
-- 
2.23.0

