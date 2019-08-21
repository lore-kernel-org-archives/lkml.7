Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DACC41514
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D102332B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pucFcgN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfHUCkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:40:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36177 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfHUCkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:40:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so393816pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=pucFcgN1fWrC8ETrL4iTGcbEQjQsh6oQjzZCjUPUq9bxlFw0y88Bw+K8LbfKHGQC15
         f0tluknyHRejt1yPMcuVKxsdPSJPSqvjXrt2fDLuFO/5iJ2SlXuDvoPatf/C24ch5ttF
         hIWoG99makuXMf7Dzw8opP48Hob4C9dqASXQVO7Ry8wwhW+gig/gkkqsxMXFT4BoZjtp
         AviH/ca2HbQlGXlXTVSdzt7uY6mtTqCdyJFOz5nTYKGyyp64JiImDWUVEHPC+BcDaaEb
         sPrLx74lt95lpxYpF6BHWQjw9SEJhCjMtFa7FsEeg991GiPk42FWzid9pyZj+UvXw8lK
         PW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hn9ny8/GLVF+YVcbiT4jfW3YxcXYEYikLYvYoEONj7Y=;
        b=tn6vFBxsjei84WzV6f7remvwOpFguqqzPMbFyrdZ9qkX3V/eX14WZKz+/p4GOZza5a
         duRVEorrtXlVL21QBkRR2/mAw+zR5OHP646+NAENSE+Zh2v4SpMUSF+wd6ldNvnsFfXo
         6kHYW1M02KoXJcNhaBMgrhtt+ME0T/whN2PbePPuSwJU/Q+BJvbUA/tUhBm9JWt0KIpH
         OC6+abSm1BeGUp2CdwYd/MLtNOXyVP23RJC/Xb9cCTCoKGpnZGh2yINZKx9IuBstjgMC
         r+6xIHJzuH0V14GqMdjk07TYC95D5vEdi0c+VOPn4xmYW7eo9oazmt5ij+hs96WgpSv7
         O5iA==
X-Gm-Message-State: APjAAAXwyKOEdGOJW1UNrA7fQ1WpmB2NPJ3+0uCSvc97CvLno1tckLVL
        UbXp1Wy1afF9RdXBvZgMXWD3HBvHHw==
X-Google-Smtp-Source: APXvYqwqK2deXjgneC4tJPgel+d3O7JA1/h4LlAF/xl3gkQy8XD9LK1JHI+ZadItk89DPE8MFlKFTw==
X-Received: by 2002:a17:90a:23c8:: with SMTP id g66mr3038864pje.123.1566355240941;
        Tue, 20 Aug 2019 19:40:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:40:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/7] clk: actions: Fix factor clk struct member access
Date:   Wed, 21 Aug 2019 08:10:08 +0530
Message-Id: <20190821024014.14070-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the helper "owl_factor_helper_round_rate" is shared between factor
and composite clocks, using the factor clk specific helper function
like "hw_to_owl_factor" to access its members will create issues when
called from composite clk specific code. Hence, pass the "factor_hw"
struct pointer directly instead of fetching it using factor clk specific
helpers.

This issue has been observed when a composite clock like "sd0_clk" tried
to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
error.

While we are at it, let's rename the "clk_val_best" function to
"owl_clk_val_best" since this is an owl SoCs specific helper.

Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/actions/owl-factor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
index 317d4a9e112e..f15e2621fa18 100644
--- a/drivers/clk/actions/owl-factor.c
+++ b/drivers/clk/actions/owl-factor.c
@@ -64,11 +64,10 @@ static unsigned int _get_table_val(const struct clk_factor_table *table,
 	return val;
 }
 
-static int clk_val_best(struct clk_hw *hw, unsigned long rate,
+static int owl_clk_val_best(const struct owl_factor_hw *factor_hw,
+			struct clk_hw *hw, unsigned long rate,
 			unsigned long *best_parent_rate)
 {
-	struct owl_factor *factor = hw_to_owl_factor(hw);
-	struct owl_factor_hw *factor_hw = &factor->factor_hw;
 	const struct clk_factor_table *clkt = factor_hw->table;
 	unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
 	unsigned long parent_rate_saved = *best_parent_rate;
@@ -126,7 +125,7 @@ long owl_factor_helper_round_rate(struct owl_clk_common *common,
 	const struct clk_factor_table *clkt = factor_hw->table;
 	unsigned int val, mul = 0, div = 1;
 
-	val = clk_val_best(&common->hw, rate, parent_rate);
+	val = owl_clk_val_best(factor_hw, &common->hw, rate, parent_rate);
 	_get_table_div_mul(clkt, val, &mul, &div);
 
 	return *parent_rate * mul / div;
-- 
2.17.1

