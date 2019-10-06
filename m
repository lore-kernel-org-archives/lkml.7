Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B766C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E2A20700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383604;
	bh=UAfTYj9dSSWlNwqhJHR1m9xmDES6sax0XfOL7/szap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R+oSLETCeusAk64n46WohpKAwxlDl71dyjQpNrHlVTXROVoh0FSE3t7dW4qW5Enu9
	 oCUM1hawOUj+efBkdcsuFzU1diXWNmAaxUv8M98NcGQotejdu7wyUmgwIwcz5taM83
	 jP4UHmqJv0/2LTktQnWApt5AoMfy5LiViqSlXtw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfJFRkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbfJFRkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:40:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9B92087E;
        Sun,  6 Oct 2019 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383600;
        bh=UAfTYj9dSSWlNwqhJHR1m9xmDES6sax0XfOL7/szap8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG+Re7QleUuPwYWPTGjOlV+Mt4LswALube3/NKTmJ0KekTWKj89k3Ya/OU5UbUGiZ
         S2xgvZZcLyE0e/A7NVaTHiZjeQIw5eULn8Ko1ZWYTxOePmAC3STuocqvxI1MqBDGQh
         upfH4rBNQuN+gmsMDIZZhzzueB4ODoCiVMc1uTyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 026/166] clk: ingenic/jz4740: Fix "pll half" divider not read/written properly
Date:   Sun,  6 Oct 2019 19:19:52 +0200
Message-Id: <20191006171215.318003328@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 568b9de48d80bcf1a92e2c4fa67651abbb8ebfe2 ]

The code was setting the bit 21 of the CPCCR register to use a divider
of 2 for the "pll half" clock, and clearing the bit to use a divider
of 1.

This is the opposite of how this register field works: a cleared bit
means that the /2 divider is used, and a set bit means that the divider
is 1.

Restore the correct behaviour using the newly introduced .div_table
field.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lkml.kernel.org/r/20190701113606.4130-1-paul@crapouillou.net
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ingenic/jz4740-cgu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 4c0a20949c2c2..9b27d75d9485c 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -53,6 +53,10 @@ static const u8 jz4740_cgu_cpccr_div_table[] = {
 	1, 2, 3, 4, 6, 8, 12, 16, 24, 32,
 };
 
+static const u8 jz4740_cgu_pll_half_div_table[] = {
+	2, 1,
+};
+
 static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	/* External clocks */
@@ -86,7 +90,10 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 	[JZ4740_CLK_PLL_HALF] = {
 		"pll half", CGU_CLK_DIV,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1,
+			jz4740_cgu_pll_half_div_table,
+		},
 	},
 
 	[JZ4740_CLK_CCLK] = {
-- 
2.20.1



