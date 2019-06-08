Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8900FC468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559E12168B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994753;
	bh=DqdJoUiOexOk1nezwmUags9JJP3MTaMWMU/KBAzLsXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hxcggmu64f5hTKWYN79WPYmqNsQ7bIFqVeO8JkJ67FDeqhaSL8fFabuiYGaiLimLA
	 tfuC7Ki2BCLzr1aoYsONFTopgPtfw7LNZelJJXWXbwkx1JNCp+RP0VEt25I0mZnWrB
	 ec+RbQAJg+dXXoO+Bl5Pm2qi4xCBBx32gf7PO3P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfFHLwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfFHLrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:47:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84E821530;
        Sat,  8 Jun 2019 11:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994425;
        bh=DqdJoUiOexOk1nezwmUags9JJP3MTaMWMU/KBAzLsXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsJMVijlqzaWle/QLLBJXdLewvF7sT/Tscix21FkzvZPrgCwGuw4Pe5ZDbkJJNJTo
         DOwpeZk09VSeCoZ55tC41FZ2meVZd/E8oCnoxbq2J600AAiOuoyy54m1bEGXMqhWLc
         BJeWrCKfNnbAIBTzw7stLneCUyVHPNVGoDm5JtQE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/31] clk: ti: clkctrl: Fix clkdm_clk handling
Date:   Sat,  8 Jun 2019 07:46:17 -0400
Message-Id: <20190608114646.9415-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114646.9415-1-sashal@kernel.org>
References: <20190608114646.9415-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 1cc54078d104f5b4d7e9f8d55362efa5a8daffdb ]

We need to always call clkdm_clk_enable() and clkdm_clk_disable() even
the clkctrl clock(s) enabled for the domain do not have any gate register
bits. Otherwise clockdomains may never get enabled except when devices get
probed with the legacy "ti,hwmods" devicetree property.

Fixes: 88a172526c32 ("clk: ti: add support for clkctrl clocks")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clkctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 53e71d0503ec..82e4d5cccf84 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -124,9 +124,6 @@ static int _omap4_clkctrl_clk_enable(struct clk_hw *hw)
 	int ret;
 	union omap4_timeout timeout = { 0 };
 
-	if (!clk->enable_bit)
-		return 0;
-
 	if (clk->clkdm) {
 		ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
 		if (ret) {
@@ -138,6 +135,9 @@ static int _omap4_clkctrl_clk_enable(struct clk_hw *hw)
 		}
 	}
 
+	if (!clk->enable_bit)
+		return 0;
+
 	val = ti_clk_ll_ops->clk_readl(&clk->enable_reg);
 
 	val &= ~OMAP4_MODULEMODE_MASK;
@@ -166,7 +166,7 @@ static void _omap4_clkctrl_clk_disable(struct clk_hw *hw)
 	union omap4_timeout timeout = { 0 };
 
 	if (!clk->enable_bit)
-		return;
+		goto exit;
 
 	val = ti_clk_ll_ops->clk_readl(&clk->enable_reg);
 
-- 
2.20.1

