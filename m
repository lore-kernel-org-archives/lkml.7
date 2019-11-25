Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2FDC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BEE207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSp7Ol94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfKYN75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:59:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36151 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfKYN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:59:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id f16so11121744lfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 05:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXy+WuvOjN2rxo0woDxe37oYVujdXQVJsXHamcAJo8s=;
        b=pSp7Ol94mVOT8XSa+yWvPEG7xUJEajtbNYMQyAaZdDVkeRekCsbedXVcnvPoSUieBn
         P/tLgljfOm7z0c6wH2TS8UMcwLqPFrPDehoM8jVdnnKgc5w77nQdjnB12JytOPc3nA6Q
         YFbGrKPyq2H15ektCpj8/4MeEJKfOsbPJ87kXqS5OA/cjTkSA/UFHxDEGF6B1DHwe81m
         GX0fEADDRQHmsdsyhIdT8PmmO9eIXM6DFb0kaYuoPvswX1QUh0EssgW2gXcK+Kqo5ObC
         +gqngfzNrQqNpk0Ff9kgQoOKZ4mkBd3aJbWNUQUDS/tDesp/kYgGJf8/WgST3sutuVof
         BqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXy+WuvOjN2rxo0woDxe37oYVujdXQVJsXHamcAJo8s=;
        b=nagx4kVViE7+I8yY1/LfZC7eCqbjknEolUSds8Ov3pq21BmGzT/32l+SNIi4fLgv1u
         tJixgStJi0wmJUKDww2tkR5ga3OpRwvkAxf7OpQXPP/klxmqol+lNaCKeLPcIqtjMzYe
         99bnEE7wXcJX4UpC4YRV/DojYCiNlnnS1capRF6GS+6WWEjT5lUuEPDqw0H3cUrWbMGj
         0cEYFFLY2u0CQ5nN9NCc99HaykiKBBfgkvBmiEU8REFFTF4KaGNzpYJq7Kk7QILvcNEp
         JSVpYUvefmud4fA0GBeD38EEmCz0ot8EvK96INovCzLMjHoepF3lKX68jOh5JDDhXGv9
         7I4w==
X-Gm-Message-State: APjAAAWS0PkMCmBf2sUpNK50nQOhh4I74+o+I+DWcr2PXi3IjuWibivn
        Jkq5kH2qaSGpUyag/zXopBqAwg==
X-Google-Smtp-Source: APXvYqyPjIvoOQFy64CzwfgIBIRTJ2G/GgebuJdA8M/WZlUJOpD7akE7Mk5euVGlZgzV+RlHm5XUBQ==
X-Received: by 2002:a19:7d02:: with SMTP id y2mr19657341lfc.86.1574690392148;
        Mon, 25 Nov 2019 05:59:52 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id g11sm3688529lfb.94.2019.11.25.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 05:59:51 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        sboyd@kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] clk: qcom: apcs-msm8916: use clk_parent_data to specify the parent
Date:   Mon, 25 Nov 2019 14:59:09 +0100
Message-Id: <20191125135910.679310-8-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125135910.679310-1-niklas.cassel@linaro.org>
References: <20191125135910.679310-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow accessing the parent clock names required for the driver
operation by using the device tree node, while falling back to
the previous method of using names in the global name space.

This permits extending the driver to other platforms without having to
modify its source code.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since v2:
-Use clk_parent_data when specifying clock parents.

 drivers/clk/qcom/apcs-msm8916.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index 46061b3d230e..bb91644edc00 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -19,9 +19,9 @@
 
 static const u32 gpll0_a53cc_map[] = { 4, 5 };
 
-static const char * const gpll0_a53cc[] = {
-	"gpll0_vote",
-	"a53pll",
+static const struct clk_parent_data pdata[] = {
+	{ .fw_name = "aux", .name = "gpll0_vote", },
+	{ .fw_name = "pll", .name = "a53pll", },
 };
 
 /*
@@ -51,6 +51,19 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	struct clk_init_data init = { };
 	int ret = -ENODEV;
 
+	/*
+	 * This driver is defined by the devicetree binding
+	 * Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt,
+	 * however, this driver is registered as a platform device by
+	 * qcom-apcs-ipc-mailbox.c. Because of this, when this driver
+	 * uses dev_get_regmap() and devm_clk_get(), it has to send the parent
+	 * device as argument.
+	 * When registering with the clock framework, we cannot use this trick,
+	 * since the clock framework always looks at dev->of_node when it tries
+	 * to find parent clock names using clk_parent_data.
+	 */
+	dev->of_node = parent->of_node;
+
 	regmap = dev_get_regmap(parent, NULL);
 	if (!regmap) {
 		dev_err(dev, "failed to get regmap: %d\n", ret);
@@ -62,8 +75,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	init.name = "a53mux";
-	init.parent_names = gpll0_a53cc;
-	init.num_parents = ARRAY_SIZE(gpll0_a53cc);
+	init.parent_data = pdata;
+	init.num_parents = ARRAY_SIZE(pdata);
 	init.ops = &clk_regmap_mux_div_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 
-- 
2.23.0

