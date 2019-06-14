Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C78C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7F12183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560535843;
	bh=RoVrUcyIWDYlQsDoGzut/rOUiJEZ7mu/TgpgJsHQHY8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BXvyrsezDuGwjzMwhyFHBGkBCsNxKSNQYBepp9+vFG7jCdZ+3dlA3w3InKeGtnGnr
	 7ZEn5qiQGm4+5z4zXiExIUCgSU0pEOGdmr3tMZzzCTp5XsDK73mkEXbx6c3AFhVwGg
	 7cvJ2xyUctdK/e3BO5KoicugtKYboXcpUe0gf7D4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfFNSKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFNSKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:10:41 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA732064A;
        Fri, 14 Jun 2019 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560535841;
        bh=RoVrUcyIWDYlQsDoGzut/rOUiJEZ7mu/TgpgJsHQHY8=;
        h=From:To:Cc:Subject:Date:From;
        b=ksDHq0Gwp9gG1l4rQ1nQWfs9ZcUDYHJMCe5LpSoBebGt3Q3D2paO0qReGMOGznmsC
         bgDpCeeWPaoL0Y7rS4NNrx3l3EnuupBIdX3pDErhpB9wndlZBFWie8tMt2scJicbxI
         t8F1yjxfKhF1UwP6OvmPcN+v/O9wMd2FhQILEiCw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] clk: Do a DT parent lookup even when index < 0
Date:   Fri, 14 Jun 2019 11:10:40 -0700
Message-Id: <20190614181040.67326-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to allow the parent lookup to happen even if the index is some
value less than 0. This may be the case if a clk provider only specifies
the .name member to match a string in the "clock-names" DT property. We
shouldn't require that the index be >= 0 to make this use case work.

Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..87b410d6e51d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -368,7 +368,7 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct device_node *np = core->of_node;
 
-	if (np && index >= 0)
+	if (np && (name || index >= 0))
 		hw = of_clk_get_hw(np, index, name);
 
 	/*
-- 
Sent by a computer through tubes

