Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50BC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C1E20859
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339549;
	bh=PhBmKtxTxx8I3oL/+mtaeyEVJsEH/irrYiLTee+PY7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=idbap0hCLqYW3tlIgEVBWvK9dTeA0wCmLj5RM3rx19+fGv8F8fbpIlT4wdGJpJfHr
	 gaWxkYlDQflz2xF1+5nXpax4FcN0UV6QgNQ9sEjP0k9yvrWKPY//3yMyaWQdaQ//AO
	 Er+tiBlawT1evXUciuj1ynxL75Fk2gAt0c6Vkn1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfETIFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbfETIFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:40 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 687C321721;
        Mon, 20 May 2019 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339539;
        bh=PhBmKtxTxx8I3oL/+mtaeyEVJsEH/irrYiLTee+PY7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVmprhBAuXUJYz4nrGjnrrxxaybLcfGu/fl8sL9LfdAewjLK+Po4KMiargqlNca2l
         69wpldoMtSDxV6WSuP0oLNax7q5XOWJ+d3I5nF8NmYDUD9eM3JeixR1Vthq7qwpg6q
         ioenPXwnTmZ8e0FXMPBph39Un8QlGts7307S+Tyc=
Received: by wens.tw (Postfix, from userid 1000)
        id D2F286584F; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] clk: sunxi-ng: h6-r: Use local parent references for CLK_FIXED_FACTOR
Date:   Mon, 20 May 2019 16:04:18 +0800
Message-Id: <20190520080421.12575-23-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520080421.12575-1-wens@kernel.org>
References: <20190520080421.12575-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code and CLK_FIXED_FACTOR_{HW,FW_NAME}
macros, we can reference parents locally via pointers to struct clk_hw
or DT clock-names.

Convert existing CLK_FIXED_FACTOR definitions to either the _HW or
_FW_NAME variant based on whether the parent clock is internal or
external to the CCU.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 27554eaf6929..36cd25bfd8da 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -49,7 +49,7 @@ static struct ccu_div ar100_clk = {
 	},
 };
 
-static CLK_FIXED_FACTOR(r_ahb_clk, "r-ahb", "ar100", 1, 1, 0);
+static CLK_FIXED_FACTOR_HW(r_ahb_clk, "r-ahb", &ar100_clk.common.hw, 1, 1, 0);
 
 static struct ccu_div r_apb1_clk = {
 	.div		= _SUNXI_CCU_DIV(0, 2),
-- 
2.20.1

