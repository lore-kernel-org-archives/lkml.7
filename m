Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FE9C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF91621783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573598909;
	bh=+en04kJbGD/4Q5Lx1nthQ15q2am7O5vjhEjhXQRVEkw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pi/XYbvYCx7f8gM50bL39nfZPMag5+Lw1vQZWqZxizTGpSbfCDyg0qV+i7wGCC9f3
	 jUTwc5W7Dm8JUXobeCGUxWw3bxh6CThYobYybCTvS44oaXusBIotxKPoA6uo/bdKUb
	 kXcgG5/7R6ZqLBUqLCXDoSdkDvfs3sFXgTHQ6gMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLWs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfKLWs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:48:28 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 920D721925;
        Tue, 12 Nov 2019 22:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573598906;
        bh=+en04kJbGD/4Q5Lx1nthQ15q2am7O5vjhEjhXQRVEkw=;
        h=From:To:Cc:Subject:Date:From;
        b=si7/fFccCgJlHzEqui8TK1eFk7EYdzN5sEaeOtun7E3uxlED8T408EA6NDzYB25c3
         xrPYMEtrIlPliubRC6AvgLae0L5G8gOhmz0rjLXsB1yiSBjlzYH4GMZJnJeWfzkBG9
         hzGOdA2Lvsz7bFOb2pOF7ptuFk+iX4LWyR8UgmSg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: gcc-sm8150: Drop non-DT fallback parent names
Date:   Tue, 12 Nov 2019 14:48:26 -0800
Message-Id: <20191112224826.177413-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .name field of clk_parent_data should only be specified if the DT
node doesn't have the proper 'clocks' and 'clock-names' properties. For
this driver the DT has always had the correct properties so these fields
have been unnecessary.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-sm8150.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 20877214acff..5165f4d0f004 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -49,7 +49,6 @@ static struct clk_alpha_pll gpll0 = {
 			.name = "gpll0",
 			.parent_data = &(const struct clk_parent_data){
 				.fw_name = "bi_tcxo",
-				.name = "bi_tcxo",
 			},
 			.num_parents = 1,
 			.ops = &clk_trion_fixed_pll_ops,
@@ -76,7 +75,6 @@ static struct clk_alpha_pll_postdiv gpll0_out_even = {
 		.name = "gpll0_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.fw_name = "bi_tcxo",
-			.name = "bi_tcxo",
 		},
 		.num_parents = 1,
 		.ops = &clk_trion_pll_postdiv_ops,
@@ -95,7 +93,6 @@ static struct clk_alpha_pll gpll7 = {
 			.name = "gpll7",
 			.parent_data = &(const struct clk_parent_data){
 				.fw_name = "bi_tcxo",
-				.name = "bi_tcxo",
 			},
 			.num_parents = 1,
 			.ops = &clk_trion_fixed_pll_ops,
@@ -115,7 +112,6 @@ static struct clk_alpha_pll gpll9 = {
 			.name = "gpll9",
 			.parent_data = &(const struct clk_parent_data){
 				.fw_name = "bi_tcxo",
-				.name = "bi_tcxo",
 			},
 			.num_parents = 1,
 			.ops = &clk_trion_fixed_pll_ops,
@@ -131,7 +127,7 @@ static const struct parent_map gcc_parent_map_0[] = {
 };
 
 static const struct clk_parent_data gcc_parents_0[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .fw_name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
 	{ .fw_name = "core_bi_pll_test_se" },
@@ -146,9 +142,9 @@ static const struct parent_map gcc_parent_map_1[] = {
 };
 
 static const struct clk_parent_data gcc_parents_1[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .fw_name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
-	{ .fw_name = "sleep_clk", .name = "sleep_clk" },
+	{ .fw_name = "sleep_clk" },
 	{ .hw = &gpll0_out_even.clkr.hw },
 	{ .fw_name = "core_bi_pll_test_se" },
 };
@@ -160,8 +156,8 @@ static const struct parent_map gcc_parent_map_2[] = {
 };
 
 static const struct clk_parent_data gcc_parents_2[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
-	{ .fw_name = "sleep_clk", .name = "sleep_clk" },
+	{ .fw_name = "bi_tcxo" },
+	{ .fw_name = "sleep_clk" },
 	{ .fw_name = "core_bi_pll_test_se" },
 };
 
@@ -172,7 +168,7 @@ static const struct parent_map gcc_parent_map_3[] = {
 };
 
 static const struct clk_parent_data gcc_parents_3[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .fw_name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
 	{ .fw_name = "core_bi_pll_test_se"},
 };
@@ -183,7 +179,7 @@ static const struct parent_map gcc_parent_map_4[] = {
 };
 
 static const struct clk_parent_data gcc_parents_4[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .fw_name = "bi_tcxo" },
 	{ .fw_name = "core_bi_pll_test_se" },
 };
 
@@ -196,7 +192,7 @@ static const struct parent_map gcc_parent_map_5[] = {
 };
 
 static const struct clk_parent_data gcc_parents_5[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .fw_name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll7.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
@@ -212,7 +208,7 @@ static const struct parent_map gcc_parent_map_6[] = {
 };
 
 static const struct clk_parent_data gcc_parents_6[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .fw_name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
 	{ .hw = &gpll9.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
@@ -228,9 +224,9 @@ static const struct parent_map gcc_parent_map_7[] = {
 };
 
 static const struct clk_parent_data gcc_parents_7[] = {
-	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
+	{ .fw_name = "bi_tcxo" },
 	{ .hw = &gpll0.clkr.hw },
-	{ .fw_name = "aud_ref_clk", .name = "aud_ref_clk" },
+	{ .fw_name = "aud_ref_clk" },
 	{ .hw = &gpll0_out_even.clkr.hw },
 	{ .fw_name = "core_bi_pll_test_se" },
 };
-- 
Sent by a computer through tubes

