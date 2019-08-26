Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848CCC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA321848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+SxFN6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfHZQpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:45:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55953 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732625AbfHZQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:45:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so170076wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cw8s/YHZ7PvnoGSE9VFOJmJ7OcBZMxXJRhzFX2CFS/0=;
        b=W+SxFN6UOnhMQyfKYi//GVhcYoZ3i/nD7OtSMRn5jp7t/KwVidshqc3GGhsEelYCS/
         bka02/KN4t8bjYa/TDX+woe/EE53FiG8xCNCJvwzfyJjX7FRDDVKR6IUkcynrIanziVm
         p76IcKZrk8LC1mr63MLlRIkEqYk4vmRVho6v5i2kRiTuG4yujVFh4wKFmgiQHU0VpxHB
         1y0UeMI0pHRjUzyCky6UKE34gzrxy20ZHC+dQpRgSuWOOwN7JLJcHCM6ld6z0ebFr0PK
         5tArhVKZkmYvIXu9hIqEzuDAGjRFmo93BnY59OCELg3wfsFC49d839C8QBz689yKzLor
         XPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cw8s/YHZ7PvnoGSE9VFOJmJ7OcBZMxXJRhzFX2CFS/0=;
        b=Mjr7R3WpMb7g8+dkHzjOp7+izoCohH+fkj6xI4t0stWBZUBcjgNrwknLPnZtZfHBxp
         3aMWEnWLyb665XKGEniPfNKJZvywYoo0j21Yl6TC4rdy+4iybIkOXOh04Etu8cAsnS2v
         qVrd2vDNLfbYVo5Axu9BXuyJ5XNRbSS5pOc+/tzt/2w1wnS1wPs1SCk1TOSdUmXo2ihq
         +v7P/hd0aLmoCmWXuPFbE5XBbk55L/VIGtK9f/dMhiXvF0WEQWfng3t5W7GCgl6J0yv1
         VUE7Hk13pIqAA5kUzrXvGguyRKrcoMyiILSvZvRz30ERli4d4V2VnYrRkYhstfkWOuDm
         ZtYg==
X-Gm-Message-State: APjAAAWF+ToAx8LqAlwW92XvAWYwelknsH2uat475rl7Ij6CistNOrw3
        EoeXg3hXOT7RN08c7V3rknsEsA==
X-Google-Smtp-Source: APXvYqypld9ggLNrMKVt7wpQNxzd+rJq3YngYT287XmHw/uezGkbsvjvHScJk81jHJJBt8TnrajMAA==
X-Received: by 2002:a1c:494:: with SMTP id 142mr22155343wme.12.1566837915356;
        Mon, 26 Aug 2019 09:45:15 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id l62sm77872wml.13.2019.08.26.09.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:45:14 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        agross@kernel.org, mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, niklas.cassel@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] clk: qcom: apcs-msm8916: get parent clock names from DT
Date:   Mon, 26 Aug 2019 18:45:07 +0200
Message-Id: <20190826164510.6425-2-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org>
References: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org>
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
 drivers/clk/qcom/apcs-msm8916.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index a6c89a310b18..dd82eb1e5202 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -19,7 +19,7 @@
 
 static const u32 gpll0_a53cc_map[] = { 4, 5 };
 
-static const char * const gpll0_a53cc[] = {
+static const char *gpll0_a53cc[] = {
 	"gpll0_vote",
 	"a53pll",
 };
@@ -50,6 +50,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_init_data init = { };
 	int ret = -ENODEV;
+	const char *parents[2];
+	int pll_index = 0;
 
 	regmap = dev_get_regmap(parent, NULL);
 	if (!regmap) {
@@ -61,6 +63,16 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	if (!a53cc)
 		return -ENOMEM;
 
+	/* legacy bindings only defined the pll parent clock (index = 0) with no
+	 * name; when both of the parents are specified in the bindings, the
+	 * pll is the second one (index = 1).
+	 */
+	if (of_clk_parent_fill(parent->of_node, parents, 2) == 2) {
+		gpll0_a53cc[0] = parents[0];
+		gpll0_a53cc[1] = parents[1];
+		pll_index = 1;
+	}
+
 	init.name = "a53mux";
 	init.parent_names = gpll0_a53cc;
 	init.num_parents = ARRAY_SIZE(gpll0_a53cc);
@@ -76,10 +88,11 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	a53cc->src_shift = 8;
 	a53cc->parent_map = gpll0_a53cc_map;
 
-	a53cc->pclk = devm_clk_get(parent, NULL);
+	a53cc->pclk = of_clk_get(parent->of_node, pll_index);
 	if (IS_ERR(a53cc->pclk)) {
 		ret = PTR_ERR(a53cc->pclk);
-		dev_err(dev, "failed to get clk: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get clk: %d\n", ret);
 		return ret;
 	}
 
@@ -87,6 +100,7 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	ret = clk_notifier_register(a53cc->pclk, &a53cc->clk_nb);
 	if (ret) {
 		dev_err(dev, "failed to register clock notifier: %d\n", ret);
+		clk_put(a53cc->pclk);
 		return ret;
 	}
 
@@ -109,6 +123,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 
 err:
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
+	clk_put(a53cc->pclk);
+
 	return ret;
 }
 
@@ -117,6 +133,7 @@ static int qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
 	struct clk_regmap_mux_div *a53cc = platform_get_drvdata(pdev);
 
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
+	clk_put(a53cc->pclk);
 
 	return 0;
 }
-- 
2.22.0

