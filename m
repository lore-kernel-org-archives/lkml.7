Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E104C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337402072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S5th8yDt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S2T1Kr0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKOJ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:56:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOJ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:56:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 76FA060D96; Fri, 15 Nov 2019 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573811788;
        bh=Slc9IF5dQX6uwoXbBqrzCLllWU271qMpL9I+h5dYbOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5th8yDtySj5ZfbBHLjlJvg3T9RCdWgfX4IQfMxE6nmtzMiuZ1cG3HJDA39/LNg9M
         ITKGyM4Evza9+K3MZPSf42Ad9sDNVBwRfqISBlh6bsg/4g7t5IS+b3lAugf83mJMBs
         WpdFZOFATUs4NYy7SUuinIMzA24PyjRaauo+6nKg=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12BC76030E;
        Fri, 15 Nov 2019 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573811787;
        bh=Slc9IF5dQX6uwoXbBqrzCLllWU271qMpL9I+h5dYbOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2T1Kr0vOM6Gkoz8jmLFEy5mG8Fi3GTgbEa6KxSfKVChLfL7Lo3L4itChHpX2P9iy
         GlqLag8AKjdHryCLTFh4bdGAtamJ2KS8EPDj4oOfKc6KsbX8Ongk9CRvXx6ztnTXoB
         Cf1ykhkllmI5eWCPqmk5KNVSv4+rduUV44NrtU1g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12BC76030E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 1/8] clk: qcom: alpha-pll: Remove useless read from set rate
Date:   Fri, 15 Nov 2019 15:26:01 +0530
Message-Id: <1573811768-21462-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573811768-21462-1-git-send-email-tdas@codeaurora.org>
References: <1573811768-21462-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLL_MODE read in fabia set rate is not required, thus remove the same.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 055318f..e39034d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1141,14 +1141,9 @@ static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
 						unsigned long prate)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
-	u32 val, l, alpha_width = pll_alpha_width(pll);
+	u32 l, alpha_width = pll_alpha_width(pll);
 	u64 a;
 	unsigned long rrate;
-	int ret = 0;
-
-	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
-	if (ret)
-		return ret;

 	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

