Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE80C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F8A20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmgWdTfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfKYN7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:59:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46085 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfKYN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:59:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so15944815ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFx2G6rwu7kpdvcXD41l6BM92KOVYIpnpySewMnY058=;
        b=zmgWdTfearD+sHjWeRlK/bx0dgy/bakLlEYxv8GGf+siHKTg8Pd29fjMZvoTWR5uS7
         Pv7/bI+YTelbau7+aLwKBalnifKR5722jLwOg9/+0nRfFVE4bv7QWmUyupBm123opiZw
         LzPE7f/aWEugYp1FYSUNUyfZCVWJXnrAwcsjeR3p5f3LWlTfuY3uLWhx4HjaCtjW1INw
         3bAMgT0va6MHiOYgdrTP5MQQT0R/aODxvK/vi3aFRW+tojJkrsJPMlMf+gy/UmteOfbF
         W2/HXRW/Nnod0De3hIAseGbAiGbExUflxWVqtbM9uXV1rjs/qC/1TtDPoiOabAAmvqTQ
         lzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFx2G6rwu7kpdvcXD41l6BM92KOVYIpnpySewMnY058=;
        b=k6C9maWKNFR1VJTWijCuPzknxTJM7Y5lAWXvWI/ECeCXN8yRfBKN4QRjUINv/QD8ks
         dOjE+HFPXxvfo6dfhlJhOsPE+PD3rkdqIXbc6/ejR76OxqGAmIROxtSmtDRIeVEKf7ah
         vvv5fOxSXlAXj/2M5+I83kTreUDgeNlfc1SNLSuWqPek1myIgdvmO+YhnliUBlCfhCOf
         qQa8SkU+HU5kYIOaukQmnlI6rGHiIgW/tzarbLaSc8qMvjlfv8Bmx6J4ulQxHpqwUEx4
         VYlmZOMTwBurrG2tnjEI0YTB3NOODpkQza4uibWaEQIQ0+WJar1Hnc+bhqPsTA0Y4u5A
         o5EQ==
X-Gm-Message-State: APjAAAVqSc5jQ4S7CZYW+FETyWNFhvfGJbIu/WEOrmHO6FUlRwlhXVnE
        jnddOEW4PPhOMvM8eoeXeM7lNQ==
X-Google-Smtp-Source: APXvYqxGNrTj7vs2qjFmDS+0SCPs2ZtKT71xpKo78ewxlVGZ16eFWb8x11iJovyeZ7uQJznUoZr7Yg==
X-Received: by 2002:a2e:7016:: with SMTP id l22mr22669006ljc.227.1574690371750;
        Mon, 25 Nov 2019 05:59:31 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id s23sm4041871ljm.20.2019.11.25.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:59:31 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] clk: qcom: hfpll: register as clock provider
Date:   Mon, 25 Nov 2019 14:59:05 +0100
Message-Id: <20191125135910.679310-4-niklas.cassel@linaro.org>
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

Make the output of the high frequency pll a clock provider.
On the QCS404 this PLL controls cpu frequency scaling.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
Changes since v2:
-None

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

