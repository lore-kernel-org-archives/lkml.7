Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C4DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1053214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413147;
	bh=8s/D6N+MLCFZDqBWjmbNVUY9RQVu/I3sSk1MbvKERwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lFs0+xbAjF5N2OAe9yW1MQhBMZYfDrQ0jB3z0qOvIwi2Y46Z/klfX6awadfHXfScF
	 HF5spJn/cFQYqTynuAt6aHS/oOSRGC1Iur7fFtZjzeumTuhfPUcCkVUW5RflFQnIge
	 teqCRKhTWM9Ha67/ZeXGY6U9fmjpE7SoAsexOIcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfLCWpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbfLCWpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:45:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25E92080F;
        Tue,  3 Dec 2019 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413138;
        bh=8s/D6N+MLCFZDqBWjmbNVUY9RQVu/I3sSk1MbvKERwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=See+KfZ48Y5xt+G0Xogc6imvKVM0+s82b77lWBuI7zb0lyoQdjW8ZrNvKmKfdb1rw
         afoiMbRBj/+oFNTY9nNJCmlQ8CzcCB2I9AY9XFC0ebaWDUSBJdx9f/OgTrsK1K1Sxg
         pd2VWknT5dsg0J4XIvkNh6tklwckKRogAKZEzqUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/321] clk: sunxi: Fix operator precedence in sunxi_divs_clk_setup
Date:   Tue,  3 Dec 2019 23:31:20 +0100
Message-Id: <20191203223427.862800725@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit afdc74ed2d57e86c10b1d6831339770a802bab9a ]

r375326 in Clang exposes an issue with operator precedence in
sunxi_div_clk_setup:

drivers/clk/sunxi/clk-sunxi.c:1083:30: warning: operator '?:' has lower
precedence than '|'; '|' will be evaluated first
[-Wbitwise-conditional-parentheses]
                                                 data->div[i].critical ?
                                                 ~~~~~~~~~~~~~~~~~~~~~ ^
drivers/clk/sunxi/clk-sunxi.c:1083:30: note: place parentheses around
the '|' expression to silence this warning
                                                 data->div[i].critical ?
                                                                       ^
                                                                      )
drivers/clk/sunxi/clk-sunxi.c:1083:30: note: place parentheses around
the '?:' expression to evaluate it first
                                                 data->div[i].critical ?
                                                                       ^
                                                 (
1 warning generated.

It appears that the intention was for ?: to be evaluated first so that
CLK_IS_CRITICAL could be added to clkflags if the critical boolean was
set; right now, | is being evaluated first. Add parentheses around the
?: block to have it be evaluated first.

Fixes: 9919d44ff297 ("clk: sunxi: Use CLK_IS_CRITICAL flag for critical clks")
Link: https://github.com/ClangBuiltLinux/linux/issues/745
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 012714d94b429..004b411b640b3 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1086,8 +1086,8 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 						 rate_hw, rate_ops,
 						 gate_hw, &clk_gate_ops,
 						 clkflags |
-						 data->div[i].critical ?
-							CLK_IS_CRITICAL : 0);
+						 (data->div[i].critical ?
+							CLK_IS_CRITICAL : 0));
 
 		WARN_ON(IS_ERR(clk_data->clks[i]));
 	}
-- 
2.20.1



