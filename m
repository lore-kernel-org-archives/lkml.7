Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C765C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7FB206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563781526;
	bh=ThDUQGLkiZFV8s3UVa/+fp6cv15nSVozJaEPWJMXkoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xTCB8bpecnOEYqjoNa7RZ5oIO+26LwChA7HxAj7rgzUI7ShzsJNs3FbD0kkdIBB9J
	 W/A72XUXdGPOm3KBUAIEk3bt+i8T8R38dLnwmvY/0L4fKrLRrvlwdYTrYJIrzxUvhF
	 PuOlXbLcxK/RD/qNBz3luc+wxYv0N7V94/AapgkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfGVHpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVHpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:45:23 -0400
Received: from localhost.localdomain (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3595B206DD;
        Mon, 22 Jul 2019 07:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563781522;
        bh=ThDUQGLkiZFV8s3UVa/+fp6cv15nSVozJaEPWJMXkoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wtPz2KmqJvU/00CEKi/a4YS9fiaWcViqBxFcIpD0N7q6aoDzdpijCr+x7KsVoNqVE
         5GXeYWXDAEnbGXoiF+9Ri9TuM3hELC+HQRFBnTPl0jxEHWvU+s9mLomIexsDvOkWhy
         suRPuOdIFZTiNwoIxOPH2wh7F4o2L6u0d5s9UwpQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Deepak Katragadda <dkatraga@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] clk: qcom: clk-alpha-pll: Remove post_div_table checks
Date:   Mon, 22 Jul 2019 13:13:45 +0530
Message-Id: <20190722074348.29582-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722074348.29582-1-vkoul@kernel.org>
References: <20190722074348.29582-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want users to code properly and fix the post_div_table missing and
not rely on core to check. So remove the post_div_table check.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index b48707693ffd..2c6773188761 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1036,11 +1036,6 @@ static unsigned long clk_alpha_pll_postdiv_fabia_recalc_rate(struct clk_hw *hw,
 	u32 i, div = 1, val;
 	int ret;
 
-	if (!pll->post_div_table) {
-		pr_err("Missing the post_div_table for the PLL\n");
-		return -EINVAL;
-	}
-
 	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
 	if (ret)
 		return ret;
@@ -1063,11 +1058,6 @@ static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
 {
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 
-	if (!pll->post_div_table) {
-		pr_err("Missing the post_div_table for the PLL\n");
-		return -EINVAL;
-	}
-
 	return divider_round_rate(hw, rate, prate, pll->post_div_table,
 				pll->width, CLK_DIVIDER_ROUND_CLOSEST);
 }
@@ -1089,11 +1079,6 @@ static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
 	if (val & PLL_VOTE_FSM_ENA)
 		return 0;
 
-	if (!pll->post_div_table) {
-		pr_err("Missing the post_div_table for the PLL\n");
-		return -EINVAL;
-	}
-
 	div = DIV_ROUND_UP_ULL(parent_rate, rate);
 	for (i = 0; i < pll->num_post_div; i++) {
 		if (pll->post_div_table[i].div == div) {
-- 
2.20.1

