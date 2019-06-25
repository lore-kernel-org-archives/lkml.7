Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B1FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0DC204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVQI7uw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfFYQr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:47:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47073 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbfFYQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:47:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so18627998wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hb0DqlkBsrvPKyzItQugKJEv/KIpj1AeWcG12Ck6UPE=;
        b=iVQI7uw+9TJW1LUgkZIdU1khMT6YRAAAPFeP5xoXOMCjxxssCK6FX5y45dwYFhuBZf
         ad3dkl4ahiYiMS4+ngzduIaDly+kPD09FVDHnAs0RoGCnyMn1o+50xfWF+XX+a1Li4Nh
         4OQO3uDVRwDEbuJPELgvTWKDROygls1JdxY4iB0FNAZfd2rwmUKGzr5YA7wOq6SCJIms
         5GV8aV3fa5LB5VSXLFvr2r7hpHzE0ckwCLsXV1Cw5Q4aazezsX5eWUunXfNfMjw2hHO+
         OP3fvGC6HYSIkBSgfs1509UnyTeAyHKTzn1OnT/2JXW2GlGQyinlzjw1F9T1uymYEvmw
         xRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hb0DqlkBsrvPKyzItQugKJEv/KIpj1AeWcG12Ck6UPE=;
        b=FBbsrTTBlfe6QYBz4VA+AVL28iVMZf99svbu0mO2VCCuKcRj+QngFe8/fcFJSZHH/h
         ltL6ISDzlbZqHqt3osVRhv2u4XzxDpEmppiMeepsEqyiR7/6yOB+zKmIuBeqI01lWGrO
         0SowJsDZ0tcf/n+VCuki08cH32RvyQ8Ji5BdGO7h+XMwoYuACQlRh6YPM77VsxEdU30W
         X0/OGpwj1tzx7Y2uUs8jOxLz5Xy3LnbTCrnkLZVz4NimDL3vhrBeJIOOWfBcctS9j45S
         lznoSrIoimZyVrG8MxSxW7WZVTJNGE7xb2eVao6Lde4WZlwUMbt90iixRRlEDbZjTcVc
         lOjg==
X-Gm-Message-State: APjAAAU6BNsPuJXK++CTDManE9fSQnpEHHk2tU97VTArZ5nOWjpKww4N
        lBgRPff568GtXWR3eyqS4nNGvg==
X-Google-Smtp-Source: APXvYqz8+v1c8nAuEU127PL7q6EUv4iK4qRsCJaWUaXoCqhPm/o+SmElE/RNDaRh0QSWCS9bF3xtZQ==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr100970085wrq.333.1561481269628;
        Tue, 25 Jun 2019 09:47:49 -0700 (PDT)
Received: from localhost.localdomain (30.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.30])
        by smtp.gmail.com with ESMTPSA id d18sm42594476wrb.90.2019.06.25.09.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 09:47:49 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v3 07/14] clk: qcom: hfpll: register as clock provider
Date:   Tue, 25 Jun 2019 18:47:26 +0200
Message-Id: <20190625164733.11091-8-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org>
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
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/hfpll.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 87b7f46d27e0..0ffed0d41c50 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -53,6 +53,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_hfpll *h;
 	struct clk *pclk;
+	int ret;
 	struct clk_init_data init = {
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
@@ -87,7 +88,14 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
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
2.21.0

