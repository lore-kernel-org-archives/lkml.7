Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74780C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C15E206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6sHKkfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfGaU3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:29:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfGaU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:29:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so17922050wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BoMlESuV3B6tPWN9XWP2L6fpdT8XV6yqfKxT2xNxK2o=;
        b=n6sHKkfaAZlka5CATr3XtZRARQ3pNoD6Mf1sXo2WWw8trtUv/46OA3woHnhBMu0b0E
         6b/b/Mt+v3BxRwqJeBaAfR4dXduuxA/gGaZDNGnwJDnYsQDkRBImyl8xD0eYnPo+yxQ0
         jBT/Pi0Zfg9u4jQoFELZbrv8WqznsZuz5aa/ykhC6JiyiEK74G4O0cvTMGLdKpqvOBTQ
         tA9D56Ag6WUbe6fuL75YnPpHQItr6F7A4lcd/PmjTlUSnOlmJXhua5N7P5eFsOkVJ7zC
         t0POw5bAvNfWz2eiMONKgBWktBxCeUV2NMKlOuupDWYmfCz8YKl16g1UYi5xdIoRKuBQ
         8lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BoMlESuV3B6tPWN9XWP2L6fpdT8XV6yqfKxT2xNxK2o=;
        b=dVTv+JrJOJo/DRGwtoGxaMwE+Vd7MjpPWvanNsNmiqlLm5KtdVMFqBoBdgmovsvzKF
         tWftj34oCmqnRKlTxKV+bGCQtbz3DGK8qwMKXvsS51Ggk1uqMPJpf84mL4njMvJ5ZW+0
         5kVM9c/gD6kh0LQTwbs1bQUhXCzhAgq6jvHxam1d2ihltoTLDUbK+moDi2GCHlQPk/af
         XvCUSb8dGOLB6ambe9+lCLaaOfjt9SRd1u3W3j6ndd+VFSg55NaBSCjIHOLbkf3cqTcY
         NdOovWi2JpcHPsSevqtJkhHO4Y4aXocL3EzEqKY4DGgyqN/qD+BxB8uNx5pE50ls0KMS
         UEXQ==
X-Gm-Message-State: APjAAAWo+OD+C8ywsAcMILZxmFuXqWRAnk7N87ModzRf5ddi02iEWBQ1
        1RHr9V4aKOvkyqw2iUM6bhjG0w==
X-Google-Smtp-Source: APXvYqwpQEfh6lRzSLC7qveHzHmaJHjlrp6uAR1UHcFOtEzkTfXHHYUkxxhDNW/ynLeN4Zqrid8yeg==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr54956154wrr.170.1564604985426;
        Wed, 31 Jul 2019 13:29:45 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:44 -0700 (PDT)
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
Subject: [PATCH v4 06/13] clk: qcom: hfpll: get parent clock names from DT
Date:   Wed, 31 Jul 2019 22:29:22 +0200
Message-Id: <20190731202929.16443-7-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow accessing the parent clock name required for the driver
operation using the device tree node.

This permits extending the driver to other platforms without having to
modify its source code.

For backwards compatibility leave the previous value as default.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index a6de7101430c..87b7f46d27e0 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -52,6 +52,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct regmap *regmap;
 	struct clk_hfpll *h;
+	struct clk *pclk;
 	struct clk_init_data init = {
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
@@ -75,6 +76,13 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 					  0, &init.name))
 		return -ENODEV;
 
+	/* get parent clock from device tree (optional) */
+	pclk = devm_clk_get(dev, "xo");
+	if (!IS_ERR(pclk))
+		init.parent_names = (const char *[]){ __clk_get_name(pclk) };
+	else if (PTR_ERR(pclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	h->d = &hdata;
 	h->clkr.hw.init = &init;
 	spin_lock_init(&h->lock);
-- 
2.22.0

