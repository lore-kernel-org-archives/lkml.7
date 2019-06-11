Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960CC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFAE205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560248299;
	bh=5gnZ7RL4snbiRFJv0YP+ig2Gvyd1uoJREtj+aDGIF0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=shYvD0W6eljmFO5u/RYHQSHeekqMQHuAX85a5zioy6dmfFWleYFtp3BUhOU00+L0d
	 7XxjYwtg5hlXf6a2V39Jg1or2ctDRDHXXSPzlJMAVzsjsiCoPGO/3kD7y4oOc/dCXS
	 uL3+eY84rdNS/VwT4VlHfGGN/gJEf3rVzFivJFmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405508AbfFKKST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405333AbfFKKR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:26 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F22421744;
        Tue, 11 Jun 2019 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248245;
        bh=5gnZ7RL4snbiRFJv0YP+ig2Gvyd1uoJREtj+aDGIF0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIQIn9ukET07VzaGZJD7zUHDAqKjx5EikgSgjt4PlmcWiUrfIgoHMPkWqfmdkn5YE
         wQDgxtJntYBNmsR1FH71P4DZ0/PPZSKN0VTja90k1tySyuvEvEbcX5W23NKQ3G3eiu
         ZhmPXCYGJv5jUDHMBkyPuRTcBKKKYOZ0rf+fJs9o=
Received: by wens.tw (Postfix, from userid 1000)
        id 872FD60C6E; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 19/25] clk: sunxi-ng: f1c100s: Use local parent references for CLK_FIXED_FACTOR
Date:   Tue, 11 Jun 2019 18:16:52 +0800
Message-Id: <20190611101658.23855-20-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611101658.23855-1-wens@kernel.org>
References: <20190611101658.23855-1-wens@kernel.org>
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

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 29 ++++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
index e748b8a6f3c5..f6b776ca8e49 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
@@ -374,16 +374,25 @@ static struct ccu_common *suniv_ccu_clks[] = {
 	&avs_clk.common,
 };
 
-static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
-			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
-			"pll-audio-base", 1, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_8x_clk, "pll-audio-8x",
-			"pll-audio-base", 1, 2, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_video_2x_clk, "pll-video-2x",
-			"pll-video", 1, 2, 0);
+static const struct clk_hw *clk_parent_pll_audio[] = {
+	&pll_audio_base_clk.common.hw
+};
+
+static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
+			    clk_parent_pll_audio
+			    4, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
+			    clk_parent_pll_audio
+			    2, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_4x_clk, "pll-audio-4x",
+			    clk_parent_pll_audio
+			    1, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_8x_clk, "pll-audio-8x",
+			    clk_parent_pll_audio
+			    1, 2, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HW(pll_video0_2x_clk, "pll-video0-2x",
+			   &pll_video0_clk.common.hw,
+			   1, 2, 0);
 
 static struct clk_hw_onecell_data suniv_hw_clks = {
 	.hws	= {
-- 
2.20.1

