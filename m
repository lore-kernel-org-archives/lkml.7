Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA9C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9AF20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfDVJWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:22:50 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34684 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfDVJWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:22:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B7A4200124;
        Mon, 22 Apr 2019 11:22:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DB6920001A;
        Mon, 22 Apr 2019 11:22:42 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 64D6B402ED;
        Mon, 22 Apr 2019 17:22:37 +0800 (SGT)
From:   andy.tang@nxp.com
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 2/2] clk: qoriq: add more PLL divider clocks support
Date:   Mon, 22 Apr 2019 17:15:09 +0800
Message-Id: <20190422091509.3181-2-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190422091509.3181-1-andy.tang@nxp.com>
References: <20190422091509.3181-1-andy.tang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

More PLL divider clocks are needed by clock consumer IP. So enlarge
the PLL divider array to accommodate more divider clocks.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 drivers/clk/clk-qoriq.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 1212a9b..5e2b3ac 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -34,6 +34,7 @@
 #define CGA_PLL4	4	/* only on clockgen-1.0, which lacks CGB */
 #define CGB_PLL1	4
 #define CGB_PLL2	5
+#define MAX_PLL_DIV	16
 
 struct clockgen_pll_div {
 	struct clk *clk;
@@ -41,7 +42,7 @@ struct clockgen_pll_div {
 };
 
 struct clockgen_pll {
-	struct clockgen_pll_div div[8];
+	struct clockgen_pll_div div[MAX_PLL_DIV];
 };
 
 #define CLKSEL_VALID	1
@@ -1128,7 +1129,7 @@ static void __init create_one_pll(struct clockgen *cg, int idx)
 		int ret;
 
 		/*
-		 * For platform PLL, there are 8 divider clocks.
+		 * For platform PLL, there are MAX_PLL_DIV divider clocks.
 		 * For core PLL, there are 4 divider clocks at most.
 		 */
 		if (idx != PLATFORM_PLL && i >= 4)
-- 
1.7.1

