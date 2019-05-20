Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D9CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F43B20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558339596;
	bh=2htx2UolyCeadnnxkFkXPr82L02MSZy7JTkEQdSL7Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r0xLK3/pB74Z6g+V/c8bkUbLMB7fkkvCEes0QHPY/8LrLXC/eEwpCPjYfnMMdaxTH
	 vWXHDW++qii03896AGBtaELvY4pylyQPyNLQSnoeOKy2PlGGHx8whT/06V4Kpzo7a9
	 ZmbPTDIed57gteRncmr+VUMLtZcKLJMGLIPqJVpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfETIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730916AbfETIFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:05:39 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA8821530;
        Mon, 20 May 2019 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558339539;
        bh=2htx2UolyCeadnnxkFkXPr82L02MSZy7JTkEQdSL7Jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBdsxMY8+h/r794raJBb1iqyhhMljyBV/DMBFoOoLUYK0P3QpmY4qKdnilgpDsEBr
         9620N4LqNRZTz2YRkHFWXS2LouFFEIcuMDqF963i+FqAKN9TmGt92sH3Ky3qkRvKav
         HxIk3+NuFKfpcTr19q2mTxoyhQn6PyyTYYbNHNGI=
Received: by wens.tw (Postfix, from userid 1000)
        id B3B8A6583F; Mon, 20 May 2019 16:05:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] clk: sunxi-ng: sun8i-r: Use local parent references for CLK_FIXED_FACTOR
Date:   Mon, 20 May 2019 16:04:14 +0800
Message-Id: <20190520080421.12575-19-wens@kernel.org>
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
 drivers/clk/sunxi-ng/ccu-sun8i-r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index a43e8de873d7..4a111c28b8c3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -57,7 +57,7 @@ static struct ccu_div ar100_clk = {
 	},
 };
 
-static CLK_FIXED_FACTOR(ahb0_clk, "ahb0", "ar100", 1, 1, 0);
+static CLK_FIXED_FACTOR_HW(ahb0_clk, "ahb0", &ar100_clk.common.hw, 1, 1, 0);
 
 static struct ccu_div apb0_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(0, 2, CLK_DIVIDER_POWER_OF_TWO),
-- 
2.20.1

