Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5B2C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284D0222F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563781522;
	bh=Uzwq5/4J5MdKAccI6gISq/8RUt+kwmeDRELR7MXlFbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WT7qXjfwsK4rNt4E77a8s928Er2HJa/+I4cBntl0BZRs9zY0x4BFgVT2XaZgZq1mc
	 uj9G6KyblwaICe353gc6QUOBEKiLBI+QWpAW0CIqMbjIBvOjeOe78/X7A20gSSjLDl
	 ZTY0v71GYTmI4bLiWR+lHuQVmndcN37ULX6lAaXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfGVHpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVHpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:45:19 -0400
Received: from localhost.localdomain (unknown [223.226.98.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78448222F9;
        Mon, 22 Jul 2019 07:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563781518;
        bh=Uzwq5/4J5MdKAccI6gISq/8RUt+kwmeDRELR7MXlFbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSYrcq+bfRHUpfls88+m04dCVsD2Eg9nPtp47qM0KYmJje4lw6RWGWpZ1lIBvo1Aq
         bTlj/7+HQX+XsQnRRzCGSqPGUaryqwZQGm93Jfp4CeG9XKXO7jTZmfIid4CqsLS5Ry
         +NUXjm+YCx2reicYnAmSyjwIkW4pLg8x3wJYfytk=
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
Subject: [PATCH v4 1/5] clk: qcom: clk-alpha-pll: Remove unnecessary cast
Date:   Mon, 22 Jul 2019 13:13:44 +0530
Message-Id: <20190722074348.29582-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722074348.29582-1-vkoul@kernel.org>
References: <20190722074348.29582-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8f9fab480c7a ("linux/kernel.h: fix overflow for
DIV_ROUND_UP_ULL") fixed the overflow for DIV_ROUND_UP_ULL, so we no
longer need the cast for DIV_ROUND_UP_ULL, so remove the unnecessary
u64 casts.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 0ced4a5a9a17..b48707693ffd 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -832,7 +832,7 @@ static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 
 	/* 16 -> 0xf, 8 -> 0x7, 4 -> 0x3, 2 -> 0x1, 1 -> 0x0 */
-	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate) - 1;
+	div = DIV_ROUND_UP_ULL(parent_rate, rate) - 1;
 
 	return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
 				  PLL_POST_DIV_MASK(pll) << PLL_POST_DIV_SHIFT,
@@ -1094,7 +1094,7 @@ static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
 		return -EINVAL;
 	}
 
-	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	div = DIV_ROUND_UP_ULL(parent_rate, rate);
 	for (i = 0; i < pll->num_post_div; i++) {
 		if (pll->post_div_table[i].div == div) {
 			val = pll->post_div_table[i].val;
-- 
2.20.1

