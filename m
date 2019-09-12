Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCEBC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7405F206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeRGnx9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbfILOQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:16:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732455AbfILOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:15:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so28693421wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MyCCet13LkijoDqtWJYtA/7gCLRctgr20CN4r0Zl6Mg=;
        b=zeRGnx9Jl5O3X7Jd4SHlQ0k/Z1HyWXgLVZ7K6qOsjBO4t7cEJY2Atb4S61Y5e3Mo6W
         iWDKSfGYbBtsw95T7xSReKUHHARk8fx+5BXT/9kojZfo59vSEZSPnc2wZ9aUNFXPeMP/
         RINSZZ69wStZe3kzgVNrCS91tG3fuWI5h2eLczRUzzFwqMa07Gq61x0B+SrvNdSKcjfo
         SqRqCApVvCoEaKoQVY9nOuo8uF5McNy0JGG5JK3XWfuRBQD1ZyPeC0a87DJM9uPD1Pki
         qHGktZH0ZQNDu91OGL8XwkLY2jGn/6jD0LHwROdyPaApTNV3bmnJRIhst4z7rAZW5ZG3
         l7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyCCet13LkijoDqtWJYtA/7gCLRctgr20CN4r0Zl6Mg=;
        b=X/9JvB7jCUbnhTmZroP/hogWUY0iMXrpaC/G5oYVj29KLV74+2TpV1qYDmh45cgSzq
         eUmPZaysFweg+n+M6ZNqjWrO7n8fff2HPjFwjeQingwJhDzi6EZKhAlV3zHu/40gCDQC
         CL/Sq1w0zQA4QVrfrn6ia/in5tIF58+6xNcNeOMxyE7zd7TA1ZQQIFMJimAKwRcDOsB7
         xFfI4HEEIcEhKJ3p+CfEiQDefmGS2qR00BYNq4EpK216D/Hy4BO3cBLfPl8ZkOSKeVOQ
         kfYxh2qRWfiJIkl/hBBBlkurSkrFgL380p3yk0gjks3mEbGYO+spRiuWjoPg9qwzIhuy
         aWRw==
X-Gm-Message-State: APjAAAWdIxPZRUtqsTWPfCvfXbZo3VSepNzl9UeKHtmhN1dqCx/pHF8h
        3f5LsajJEHFzR53sjHz+jGMpiA==
X-Google-Smtp-Source: APXvYqwwqholtaKN+KyTW+G3hH4nfqJZ2659cgwFzkvHppKcYvHrcYjQj1TbkApkjUg1z3nZ2ylJjw==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr36896685wrp.281.1568297742744;
        Thu, 12 Sep 2019 07:15:42 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id p23sm137599wma.18.2019.09.12.07.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 07:15:42 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        agross@kernel.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] clk: qcom: hfpll: register as clock provider
Date:   Thu, 12 Sep 2019 16:15:31 +0200
Message-Id: <20190912141534.28870-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912141534.28870-1-jorge.ramirez-ortiz@linaro.org>
References: <20190912141534.28870-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the output of the high frequency pll a clock provider.
On the QCS404 this PLL controls cpu frequency scaling.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/hfpll.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index a6de7101430c..e64c0fd82fe4 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -57,6 +57,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 		.num_parents = 1,
 		.ops = &clk_ops_hfpll,
 	};
+	int ret;
 
 	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
 	if (!h)
@@ -79,7 +80,14 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 	h->clkr.hw.init = &init;
 	spin_lock_init(&h->lock);
 
-	return devm_clk_register_regmap(&pdev->dev, &h->clkr);
+	ret = devm_clk_register_regmap(dev, &h->clkr);
+	if (ret) {
+		dev_err(dev, "failed to register regmap clock: %d\n", ret);
+		return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &h->clkr.hw);
 }
 
 static struct platform_driver qcom_hfpll_driver = {
-- 
2.23.0

