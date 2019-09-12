Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536EC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A926E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2GJVGuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbfILOPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:15:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37158 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbfILOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:15:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so28071167wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdN/u39fDQLfzd7rtHJ5JZYMbTkaxu/Gufv+LpTjgaQ=;
        b=A2GJVGuROuKBhePAYuM1kJnzZ+T14oTz0SyhSmH80VaUITfhegPebyeXbV6zE62Xfx
         +M2+4fBhZJiqH6grq1qnhtyv9iCXLAEJ3YvfzPvaucKSiPMCw3XxfbpdjR8Q2oGG7+mw
         5R9RIDjiEly/GhYj2fbusH1rUkt5OJDOkzd7cCa6q2O/xAg7F6XKVlTumb8lyqTRP9E8
         dJThiRkX/FmBDYymYDrK3hkiKYDhOB2nbqf0RTKWXmXRHZ6uoP2Ivhb3VTnRaeluPL5f
         KrgTDkK6zTN2LuuCR5cMrv5xKhvqmBhTWmW1kqolkHpJpTNakCw8x9uzqGVF6e7haIYV
         drdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdN/u39fDQLfzd7rtHJ5JZYMbTkaxu/Gufv+LpTjgaQ=;
        b=BMAt1J8pDmo4zQ2GGasnonD6eoWUnffr4alQ80ha/IjtKWUh/pAZ9n1l0teaLvohsB
         2qGpS4ANbzkBRuTP4cRo5jqiYAJd7nnDx+Bpv4mXvy4kSxtWHxTvZ99qgw80fw21eoT4
         YnZYIGsnC8vzAIes2SEGmfrDVGCq+xGoA5dY1EXvHePiN1KbXhlg6T9hQmtYdDDXF4Rz
         1MfVImWDOuEYvd4wPE7s2zRQb0N1N8CH4/obfB29VS9hOrgM2vzuHMnSyjXvaaetZbbD
         PhwUuf/ckHy4L5yo1A7A50s2yo4XFhoskTze5bPEd5+O/3vv8tjL+uig8jGy35VyhDHO
         Y3qQ==
X-Gm-Message-State: APjAAAVV3L1TQKubeMnKUqSK5Ddj7rUotnyhMuV4dooPuoL/3L0lI6Ea
        ZXMBh7EpEChAVGO6bKIeeIvZcw==
X-Google-Smtp-Source: APXvYqzIkZwKxEVHrRQ41dj/lt5Mk78L/Xym8U4DEVgQKBW37ME6sYuep4Kx7a8QwJJr4NDczBlSnA==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr37475923wru.27.1568297744791;
        Thu, 12 Sep 2019 07:15:44 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id p23sm137599wma.18.2019.09.12.07.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 07:15:44 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        agross@kernel.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] clk: qcom: hfpll: use clk_parent_data to specify the parent
Date:   Thu, 12 Sep 2019 16:15:33 +0200
Message-Id: <20190912141534.28870-5-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912141534.28870-1-jorge.ramirez-ortiz@linaro.org>
References: <20190912141534.28870-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend support to platorms using different parents.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 225c675f6779..5ff7f5a60620 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -53,7 +53,6 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_hfpll *h;
 	struct clk_init_data init = {
-		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_ops_hfpll,
 		/*
@@ -65,6 +64,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 		.flags = CLK_IGNORE_UNUSED,
 	};
 	int ret;
+	struct clk_parent_data pdata = { .index = 0 };
 
 	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
 	if (!h)
@@ -83,6 +83,8 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 					  0, &init.name))
 		return -ENODEV;
 
+	init.parent_data = &pdata;
+
 	h->d = &hdata;
 	h->clkr.hw.init = &init;
 	spin_lock_init(&h->lock);
-- 
2.23.0

