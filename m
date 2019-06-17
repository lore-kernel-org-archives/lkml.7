Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87841C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACEE208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFQMDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:03:02 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:39590 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFQMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:03:02 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id Ro2p2000l3XaVaC06o2pRY; Mon, 17 Jun 2019 14:02:56 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcqLZ-0001dS-7R; Mon, 17 Jun 2019 14:02:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcqLZ-0002VQ-5X; Mon, 17 Jun 2019 14:02:49 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: Simplify clk_core_can_round()
Date:   Mon, 17 Jun 2019 14:02:48 +0200
Message-Id: <20190617120248.9590-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A boolean expression already evaluates to true or false, so there is no
need to check the result and return true or false explicitly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d695b3..c68bc5f695912bf5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1324,10 +1324,7 @@ static void clk_core_init_rate_req(struct clk_core * const core,
 
 static bool clk_core_can_round(struct clk_core * const core)
 {
-	if (core->ops->determine_rate || core->ops->round_rate)
-		return true;
-
-	return false;
+	return core->ops->determine_rate || core->ops->round_rate;
 }
 
 static int clk_core_round_rate_nolock(struct clk_core *core,
-- 
2.17.1

