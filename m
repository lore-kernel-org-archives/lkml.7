Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C4AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709C22171F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyDo5hAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfGaUa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:30:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40348 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfGaU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:29:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so71053954wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=onetUiZPcKYw43ltVy2pax5WwMNPrRMe/eAwSVGynt4=;
        b=hyDo5hAhRc4QzuIX2tUpIKbH3IelBuPVusXpwSvSNMh9tzz94z/m8CQjhd4r5uATJ5
         IwiBzZESkY4K2MTQFADxZhMygATszMtZhDOOdYS00mhRA+Ghk8oOiibymHRGzOU+Rq5B
         0kSFzaZLM6YrI5Dg311b3EyUCJyOYsL8cp3ImiXtGIQ86tI+ob9HD3LLh8VJqvSWbF1q
         djifVGZBkToBzRoVMRMciAwyXobYowv0eANNZz6d1ZX7+rOu96bPEEgOcSbZQbWbvbU7
         0LI+p7KwSWs2S6a7C2EvLNXer9Mdq7XrKPpzat4dc6i5iig7t30hKa+U+utmJxSzVKpY
         0D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onetUiZPcKYw43ltVy2pax5WwMNPrRMe/eAwSVGynt4=;
        b=GFEuJ9LLSASynpwL8LNW36G30pNQJPoT8NsAG36NbaWdYjtynjLJPB89jncdq+r1Ow
         21hKQIc8Kfp5d5LIgKiOT6JpH/uNOQhUhwjTqQv9wg2i+IKbwxfSajTWiomrFOiB96c+
         OnPWNrtLat0c0KFoo4xDTrSh9GDb1i5uEJkgEOxIcCqPFAeNcHb0N5JbN2YSMMtWJPpF
         mHMmevCJE/R19ozm3pk+xhX/ucyTblm8Rm/+Y02rcV964YpUbQ2wf/VnIR6oSVM5Fs6J
         3jAhS8E5eABNuWWikoBMX/8e6zV6f0arSS26hbIDEarumLNs7UU3iolqMGJefjJJJ3ra
         QEWQ==
X-Gm-Message-State: APjAAAV6n/IH51JWpaLWmJJafg57HB9rZDGMYVBBHuBHAGyDdFsUbVoC
        4MLrbDDKezyHdawL8X6cyIRu4A==
X-Google-Smtp-Source: APXvYqy6YgTYQC3Fho4PDvDZwRFPnMUj0vZ+AbVsH4vJvPB20hp2gbPmVYNLKolRigmcbxZyhR8AIA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr19884717wro.307.1564604987154;
        Wed, 31 Jul 2019 13:29:47 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:46 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v4 07/13] clk: qcom: hfpll: register as clock provider
Date:   Wed, 31 Jul 2019 22:29:23 +0200
Message-Id: <20190731202929.16443-8-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
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
2.22.0

