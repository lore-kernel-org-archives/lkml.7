Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEBEC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BAD2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573162821;
	bh=EDAqi25SHtXpQvaMB7rqtcUVESWv2xHjqs6Tu/AI09I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i937Jwq9qRRWc6QOB5uLNOHXYgCXuFE9KrCmIGqb+6oTRGNtgnJChlv8ny92aYT06
	 scwc0jvVZDhhqUeL9gdSb9y6vTiwjZdgKfYlCel3Tt1sn86YFhlKNjanYyuN2dKzqH
	 34cYxCQVdc7bEF1GaUZaNPVrtE7n13k5JPEkm3fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfKGVkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfKGVkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:40:20 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9920F2178F;
        Thu,  7 Nov 2019 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573162818;
        bh=EDAqi25SHtXpQvaMB7rqtcUVESWv2xHjqs6Tu/AI09I=;
        h=From:To:Cc:Subject:Date:From;
        b=QPjkVJpVAqUdXN82EgihxLyW87YEVBzRue/KEUVoHEuCOjeRhvEgdiGB3tjAE+St3
         QImaW6VlzT5bg+4CQt/+ByquPA/GQrhLZGUV4E5qb5FRPpzn/6Yeo1Qq5ApPk8uyRa
         t2egbDKtAFNOjNgOaAem6mopKP12gul6mZ5DjwIs=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH] clk: qcom: rpmh: Reuse sdm845 clks for sm8150
Date:   Thu,  7 Nov 2019 13:40:18 -0800
Message-Id: <20191107214018.184105-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8150 list of clks is almost the same as the list for SDM845,
except there isn't an IPA clk. Just point to the SDM845 clks from the
SM8150 list for now so we can reduce the amount of struct bloat in this
driver.

Suggested-by: Vinod Koul <vkoul@kernel.org>
Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-rpmh.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 7301c7739f29..2dbbe47e8d4f 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -334,13 +334,14 @@ static const struct clk_ops clk_rpmh_bcm_ops = {
 	.recalc_rate	= clk_rpmh_bcm_recalc_rate,
 };
 
-/* Resource name must match resource id present in cmd-db. */
+/* Resource name must match resource id present in cmd-db */
 DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 2);
 DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 2);
 DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk3, ln_bb_clk3_ao, "lnbclka3", 2);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
+DEFINE_CLK_RPMH_VRM(sm8150, rf_clk3, rf_clk3_ao, "rfclka3", 1);
 DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
 
 static struct clk_hw *sdm845_rpmh_clocks[] = {
@@ -364,26 +365,19 @@ static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
 	.num_clks = ARRAY_SIZE(sdm845_rpmh_clocks),
 };
 
-DEFINE_CLK_RPMH_ARC(sm8150, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 2);
-DEFINE_CLK_RPMH_VRM(sm8150, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 2);
-DEFINE_CLK_RPMH_VRM(sm8150, ln_bb_clk3, ln_bb_clk3_ao, "lnbclka3", 2);
-DEFINE_CLK_RPMH_VRM(sm8150, rf_clk1, rf_clk1_ao, "rfclka1", 1);
-DEFINE_CLK_RPMH_VRM(sm8150, rf_clk2, rf_clk2_ao, "rfclka2", 1);
-DEFINE_CLK_RPMH_VRM(sm8150, rf_clk3, rf_clk3_ao, "rfclka3", 1);
-
 static struct clk_hw *sm8150_rpmh_clocks[] = {
-	[RPMH_CXO_CLK]		= &sm8150_bi_tcxo.hw,
-	[RPMH_CXO_CLK_A]	= &sm8150_bi_tcxo_ao.hw,
-	[RPMH_LN_BB_CLK2]	= &sm8150_ln_bb_clk2.hw,
-	[RPMH_LN_BB_CLK2_A]	= &sm8150_ln_bb_clk2_ao.hw,
-	[RPMH_LN_BB_CLK3]	= &sm8150_ln_bb_clk3.hw,
-	[RPMH_LN_BB_CLK3_A]	= &sm8150_ln_bb_clk3_ao.hw,
-	[RPMH_RF_CLK1]		= &sm8150_rf_clk1.hw,
-	[RPMH_RF_CLK1_A]	= &sm8150_rf_clk1_ao.hw,
-	[RPMH_RF_CLK2]		= &sm8150_rf_clk2.hw,
-	[RPMH_RF_CLK2_A]	= &sm8150_rf_clk2_ao.hw,
-	[RPMH_RF_CLK3]		= &sm8150_rf_clk3.hw,
-	[RPMH_RF_CLK3_A]	= &sm8150_rf_clk3_ao.hw,
+	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
+	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &sdm845_ln_bb_clk2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &sdm845_ln_bb_clk2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &sdm845_ln_bb_clk3.hw,
+	[RPMH_LN_BB_CLK3_A]	= &sdm845_ln_bb_clk3_ao.hw,
+	[RPMH_RF_CLK1]		= &sdm845_rf_clk1.hw,
+	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
+	[RPMH_RF_CLK2]		= &sdm845_rf_clk2.hw,
+	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
+	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
+	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sm8150 = {
-- 
Sent by a computer through tubes

