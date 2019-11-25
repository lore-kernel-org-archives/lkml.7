Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE496C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843952084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k9ZRUQYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfKYN7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:59:42 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40847 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfKYN7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:59:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id v24so11088221lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4n0b7csmummMNxZyeaSszKbcnCZgkdyzjnJK7yDR57M=;
        b=k9ZRUQYDRGLuJPThscWn5IqxsfcWQDaQNqRK8f+eV8GDXkdsHk7cLxpS1kIb7q/TK9
         doPl76pMJCXckPDBFOzdRQr3C7Wi2JVgxyFnVsl7NOXHGiUQoa8fEXoybWLyMiJqjo8U
         s+pKy6+ty7tBmr8QqFWAzRuvPPvh9/EbUX8nXGO8HBjTHjiK6ciyITdid+9OZI7nLLQe
         1jjYyrsMn/ufrJQ4b5A36nNfwz4R/PxnMoNRUGPOUYogvGMIUnC53s5VZFGg2vON5xag
         tDndGeXXm/WjVSYKyWx9qXaO8zaMxqOaTVUNQhMmGG+vWczNUwpjQBAqquoO3sJ5m7gI
         n/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4n0b7csmummMNxZyeaSszKbcnCZgkdyzjnJK7yDR57M=;
        b=HWbmCwt/weg94LSO4g11znZXqS5UmSmO9OOg/XYrmZym9sZe54qOgl/l8ptJTcLPEP
         TISCG9xUhMTmD/oLjPvoTIXIJxVrABMxl35n22kzoXmEuWXLHbqP8vfKhFpN6Ez1eGyh
         Zetqp/+L195TjqJseOKmVMDDzQg42zKKiAwnu8g5piL44+Uepml7+yaXmh9QjOGI7O/7
         Ynnsy2QOuDv20QNtz+Dt55wtOFc4kAcvgPlVunuetAPguKrHvgaqAcojMPvo+fykZOje
         npIOFpYKaOEincWo0OfAUQv88O/O4nqXojJyQLTrrzcCZvDz7HMxI2iyi+ZaU0mQG8Xw
         m0eA==
X-Gm-Message-State: APjAAAUuE023jamUHT5i2Af834pP7UOHEWuNyzbO3DdnoUqo08Fuuf4h
        a21t9qQ0ubOnk1ybnXLO6qwErQ==
X-Google-Smtp-Source: APXvYqyiHXeKNwXqDrb4oHFdRVQdKpRXMlAbnVYruSqWq4Q1yyx/xP5Xtz1cAP8usAyVBwZR4O49+w==
X-Received: by 2002:ac2:5305:: with SMTP id c5mr20326251lfh.55.1574690374722;
        Mon, 25 Nov 2019 05:59:34 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id s23sm4041871ljm.20.2019.11.25.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:59:34 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] clk: qcom: hfpll: use clk_parent_data to specify the parent
Date:   Mon, 25 Nov 2019 14:59:07 +0100
Message-Id: <20191125135910.679310-6-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125135910.679310-1-niklas.cassel@linaro.org>
References: <20191125135910.679310-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

This permits extending the driver to other platforms without having to
modify its source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
Changes since v2:
-None

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

