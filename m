Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7419C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D412077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077890;
	bh=+tUap1Kb/lal8rHG71c3bSLAIRXCJ/bSSaakJcTY2To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dm9J4ba7/KSLffZfptb1UVHdZAw3n09E96+CpkTZ4E+sD0W3AyQSOAzJs9ZzeUsY1
	 QxtCQUGf2blwq6uRLFF4rsVJGVoOL6lPHzq3ApLrHlwZGc1YIwUNGSLGpYDcIr3qP6
	 EzY/WfwHM6v0qzggRCjTyOc0k4PIxoT89cbfVdpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbfLKPYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732876AbfLKPYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:24:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED0FC208C3;
        Wed, 11 Dec 2019 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077883;
        bh=+tUap1Kb/lal8rHG71c3bSLAIRXCJ/bSSaakJcTY2To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ypNoi5fJkzQemzPtOwp2BRyYdtEWrX7TZyihQl1iVXxIrSuGOAIye6rZ+qZuY6UdM
         IYecHrjCG2tsKxSsz1jmhKzpbEFZ8gbMxAjUIGq/PpVp6qp8hOMsuG4NFj9MkhU/sb
         L8EOh+j9ut7e/9gZnyHfIDMpjUSlz0uhqvCPcBHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 190/243] clk: renesas: rcar-gen3: Set state when registering SD clocks
Date:   Wed, 11 Dec 2019 16:05:52 +0100
Message-Id: <20191211150351.996407413@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit ecda0a09fa9933bcd67e33c952f778f0872392ed ]

The driver tries to figure out which state a SD clock is in when the
clock is registered, instead of setting a known state. This can be
problematic for two reasons.

1. If the clock driver can't figure out the state of the clock,
   registration of the clock fails, and setting of a known state by a
   clock user is not possible.

2. The state of the clock depends on if and how the bootloader
   configured it. The driver only checks that the rate is known, not if
   the clock is stopped or not for example.

Fix this by setting a known state and making sure the clock is stopped.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 628b63b85d3f0..9ace7d39cd1b5 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -361,7 +361,7 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	struct sd_clock *clock;
 	struct clk *clk;
 	unsigned int i;
-	u32 sd_fc;
+	u32 val;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
 	if (!clock)
@@ -378,17 +378,9 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	clock->div_table = cpg_sd_div_table;
 	clock->div_num = ARRAY_SIZE(cpg_sd_div_table);
 
-	sd_fc = readl(clock->csn.reg) & CPG_SD_FC_MASK;
-	for (i = 0; i < clock->div_num; i++)
-		if (sd_fc == (clock->div_table[i].val & CPG_SD_FC_MASK))
-			break;
-
-	if (WARN_ON(i >= clock->div_num)) {
-		kfree(clock);
-		return ERR_PTR(-EINVAL);
-	}
-
-	clock->cur_div_idx = i;
+	val = readl(clock->csn.reg) & ~CPG_SD_FC_MASK;
+	val |= CPG_SD_STP_MASK | (clock->div_table[0].val & CPG_SD_FC_MASK);
+	writel(val, clock->csn.reg);
 
 	clock->div_max = clock->div_table[0].div;
 	clock->div_min = clock->div_max;
-- 
2.20.1



