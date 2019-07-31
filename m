Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A6C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F369321726
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/M0HVfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfGaU3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:29:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34800 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfGaU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:29:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so2067436wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AduWeROQMDkKls+kl/fLswGL+rHZfEiqcyM0mR/LCMQ=;
        b=k/M0HVfeNBuPo+VT6LzsO154/layPjQ0BQjQ1FFLye6ZzLKSs9A3C1xWB1r1myjpdq
         VsGHmcwTky6N2aoUIcOBvHs3Dr0Hq+Df+PFt33LCiPqEU7s/m3/C4bW8Sdd0qYvdjyvL
         6cX+bIGf0Nkuhy1V84m5xfa/Cqm+S9MwUgxShE72HrcBEuvo0tGCt/aw23hRAgtNwH7a
         zI2PhMl2zV9kX8z9UVzHuNDJlXQ5VjZaBkhKiqmUGqTCguZkYX/DmsRhFlRG6YrSUTnC
         bXz4oKCCe71Q2ifNJard7uAi+9PPyrbCFYcz+XmGnXz6htC3D0vHb6qNDUa6NJBINyiO
         r4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AduWeROQMDkKls+kl/fLswGL+rHZfEiqcyM0mR/LCMQ=;
        b=MtIAu2l3ZUJQgCPSmDz8ROp6huW1yGY+M/VWml1/EJVOxYp3SfV89diqRDZNTtKkul
         1iZncMnqXG4QIaq6FKKUtNuul6s4ms3uRbBQA8mz5+qCNH3/18yhcJztldGCTNJJZDx/
         80TuVSaSm6PCBbp/WQIMsFIoHS8grPQ6yQT0nSD6CH0ytb4qkiHZk7mMlb8CTFWTxUio
         L0gzRDijOm09cVjUDR+DKEuBrGGth98kpywaskaiSqgolILEaQs2YiPZRX91ygML/BWA
         FfNVyr98jXV0p20UOdkQLzNT7jbDAgyeQ37wsuF8pmMEOQYl4uW1g7ZJsJpiFx0adyWu
         /upQ==
X-Gm-Message-State: APjAAAWUAXFw8dZt6v4jUNDwE1KlAf7TCvYDMaNnlmG/SwbnX0XfTp1G
        eO3AzcVwAmny3ff4jekRAfwNBA==
X-Google-Smtp-Source: APXvYqw/ot9U03TpeI7X60P6SYKQcEDn5iziVJjTikkQkab39pGBlt5kTQ3vo31YrhMRUB4IxxUwaw==
X-Received: by 2002:a1c:cb0a:: with SMTP id b10mr110875853wmg.41.1564604989405;
        Wed, 31 Jul 2019 13:29:49 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:48 -0700 (PDT)
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
Subject: [PATCH v4 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Date:   Wed, 31 Jul 2019 22:29:24 +0200
Message-Id: <20190731202929.16443-9-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
to keep the software model of the clock in line with reality, the
framework transverses the clock tree and disables those clocks that
were enabled by the firmware but have not been enabled by any device
driver.

If CPUFREQ is enabled, early during the system boot, it might attempt
to change the CPU frequency ("set_rate"). If the HFPLL is selected as
a provider, it will then change the rate for this clock.

As boot continues, clk_disable_unused_subtree will run. Since it wont
find a valid counter (enable_count) for a clock that is actually
enabled it will attempt to disable it which will cause the CPU to
stop. Notice that in this driver, calls to check whether the clock is
enabled are routed via the is_enabled callback which queries the
hardware.

The following commit, rather than marking the clock critical and
forcing the clock to be always enabled, addresses the above scenario
making sure the clock is not disabled but it continues to rely on the
firmware to enable the clock.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 0ffed0d41c50..d5fd27938e7b 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -58,6 +58,13 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_ops_hfpll,
+		/*
+		 * rather than marking the clock critical and forcing the clock
+		 * to be always enabled, we make sure that the clock is not
+		 * disabled: the firmware remains responsible of enabling this
+		 * clock (for more info check the commit log)
+		 */
+		.flags = CLK_IGNORE_UNUSED,
 	};
 
 	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
-- 
2.22.0

