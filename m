Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DF7C41514
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A2E21883
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KabsJLk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfHZQpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:45:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732761AbfHZQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:45:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so15951495wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BoMlESuV3B6tPWN9XWP2L6fpdT8XV6yqfKxT2xNxK2o=;
        b=KabsJLk1ZzmKq1DlMZEp/k29ZN2rr4yrR+8FbU+6lJZgjPEJAUiZYYegw4EjL9CI/+
         HUracAwaQVCCkTBDakDUb5s4M8ROZsTl3Zz72EdmhuUkE8xP2r+Xrq8kFBZUjwmIxYiF
         4SukMlm006PTTDVg8EHnqFDH81vNuIk3jCy+dKF//AF6TRPrgC60ZBONZKv9I4B9NvC+
         jEfHHjGd1OlGPoh+dGeRIJnJPHBq+wKiJa6nzTxmailqFW308PmAKHWn5EtbCyIVBFvf
         0yMEtDR9P+bt1hi+IWD19RTpVBIovgRJ0hlnV9jz0OLdtnyWZ3nn2SQOrjHtYhg/asOX
         f5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BoMlESuV3B6tPWN9XWP2L6fpdT8XV6yqfKxT2xNxK2o=;
        b=K3IlMO25kdKJwX0tfyVE3rBDMDPIhs/x/gg7jnETWOIMUkvDxcoSD6Vu/cPdGHRasa
         6x1PQ1UDTMb2Xznght5iMHCeh8p8a2cndQwo+zMU0kmRlQoKoswxw3EvBHO/CUJDlLQK
         5S6RbwploHrRRk8XfDqByfRJw/R6NDLeX7v6i56D21zkSUaePg0RXy60siaqLu2/+5Eg
         fvVbRQFHrm9/5jmgceUdg+ZWGQcTMXh5Yro9bSNtnYars4V5fZ9hQCh5RgNd5q6RhRL0
         dlKx9SFzJwDDIEG8xIF4Mx3oMWNxY+NQb+b1NPEO+s07uHiQAW4/viQmGIOJWcIacnPn
         SWbg==
X-Gm-Message-State: APjAAAUP7di9qn3/aL0vVt8KCzwzGPi9CtykGgqGxgc5qobwgj6pcKrj
        xGxCD/oVAlpfvoZwtprhxsw/jg==
X-Google-Smtp-Source: APXvYqyoNuv9DfnZpQxM6zKbeFAGmBOoB6lJfzBvGkL4tsUO2eT/X3klfLwalxdAz9fxpImq8/nBtg==
X-Received: by 2002:a5d:4490:: with SMTP id j16mr23161619wrq.335.1566837916391;
        Mon, 26 Aug 2019 09:45:16 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id l62sm77872wml.13.2019.08.26.09.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:45:15 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        agross@kernel.org, mturquette@baylibre.com
Cc:     bjorn.andersson@linaro.org, niklas.cassel@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] clk: qcom: hfpll: get parent clock names from DT
Date:   Mon, 26 Aug 2019 18:45:08 +0200
Message-Id: <20190826164510.6425-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org>
References: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org>
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

