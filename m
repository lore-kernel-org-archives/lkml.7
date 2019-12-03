Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1660FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D864A20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414720;
	bh=UrwV+/fwXSBpY1YoZJU5Of4gNpHAM4fNjoTfjtPcWBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2LVh3hKalAscyVnA4lM/reekzvXO+Y7uXeINUE7gG+FujbNXXeTBmpJ+vsDMgvhdh
	 vfLlY/YIV9SZcJsNTfzRDXazw8TwN6nz1ELCQp1DhiRZLxBph4mTte0TPhIKR8SqGZ
	 EJFsQexr/nsgWMsRlZw3OL6LWGDyqx7lR5+QH+z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfLCWk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfLCWkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:40:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A03920684;
        Tue,  3 Dec 2019 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412821;
        bh=UrwV+/fwXSBpY1YoZJU5Of4gNpHAM4fNjoTfjtPcWBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je02bISGallaB8QMIxZM9MXLuDuiSwgXtAeZ9A2wlOcN4dhi0S/28wRjaOBgq3zA3
         GMaecIYgb05oIkU+QMKxKkxgVaiTT/wgevSTqokiWSo2FIvfcLyFrQT3mjvtFRuIuJ
         mW+hTcJgRS1j6mA+3k6ASBa9rQLuhKCSub/QLMLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 029/135] clk: sunxi: Fix operator precedence in sunxi_divs_clk_setup
Date:   Tue,  3 Dec 2019 23:34:29 +0100
Message-Id: <20191203213011.737005692@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
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
index d3a43381a7927..27201fd26e442 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1080,8 +1080,8 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
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



