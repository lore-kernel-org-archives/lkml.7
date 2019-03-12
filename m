Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B4C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413338;
	bh=7nlxmL3NhxMuZY/2yZPB+024HKnW17YOPNP2a1U1Q7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=toIcvzQYTifIws5Utuxa7XP9vSNXtLISdPGVbS0EMGm2jQkovCFljKcWyPjX0rSab
	 36IRSSk1s3MqR/Eg3jFa4qw7DxDMhNhzJvh8qGinMCIo4YO9El9z0U8EjLrnK9A4vp
	 uxaKGo0VHJHI7XrrSb55PmpyJ0RjiTD8fbgCIjUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfCLRzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbfCLROC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:02 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2986E217F9;
        Tue, 12 Mar 2019 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410842;
        bh=7nlxmL3NhxMuZY/2yZPB+024HKnW17YOPNP2a1U1Q7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJWUni5J2GwojRbFYbVVIWIBfboWfXLDaJxeOdwtJ8rfw6PRuawyqilO3RsGpHj50
         LyquzFUrcxdXSywoqWqjiYvTG9VAP83k6/vNIATRWbyxkxYa4FVtg8wqeMVsi+q9d3
         hHiPaCT6ggilYRx0f5dk78fwvS5BDFM7PASBd+R8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/149] clk: qcom: gcc: Use active only source for CPUSS clocks
Date:   Tue, 12 Mar 2019 10:07:12 -0700
Message-Id: <20190312170350.765836812@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9ff1a3b4912528f853048ccd9757ba6a2cc75557 ]

The clocks of the CPUSS such as "gcc_cpuss_ahb_clk_src" is a CRITICAL
clock and needs to vote on the active only source of XO, so as to keep
the vote as long as CPUSS is active. Similar rbcpr_clk_src is also has
the same requirement.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Fixes: 06391eddb60a ("clk: qcom: Add Global Clock controller (GCC) driver for SDM845")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index fa1a196350f1..3bf11a620094 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -131,8 +131,8 @@ static const char * const gcc_parent_names_6[] = {
 	"core_bi_pll_test_se",
 };
 
-static const char * const gcc_parent_names_7[] = {
-	"bi_tcxo",
+static const char * const gcc_parent_names_7_ao[] = {
+	"bi_tcxo_ao",
 	"gpll0",
 	"gpll0_out_even",
 	"core_bi_pll_test_se",
@@ -144,6 +144,12 @@ static const char * const gcc_parent_names_8[] = {
 	"core_bi_pll_test_se",
 };
 
+static const char * const gcc_parent_names_8_ao[] = {
+	"bi_tcxo_ao",
+	"gpll0",
+	"core_bi_pll_test_se",
+};
+
 static const struct parent_map gcc_parent_map_10[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
@@ -226,7 +232,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_names = gcc_parent_names_7,
+		.parent_names = gcc_parent_names_7_ao,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -245,7 +251,7 @@ static struct clk_rcg2 gcc_cpuss_rbcpr_clk_src = {
 	.freq_tbl = ftbl_gcc_cpuss_rbcpr_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_rbcpr_clk_src",
-		.parent_names = gcc_parent_names_8,
+		.parent_names = gcc_parent_names_8_ao,
 		.num_parents = 3,
 		.ops = &clk_rcg2_ops,
 	},
-- 
2.19.1



