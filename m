Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB05CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318BF2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CfqlIoo8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MD/4wgbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfJ2Rsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:48:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58992 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfJ2Rsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:48:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E737E60F7B; Tue, 29 Oct 2019 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572371330;
        bh=Bv52zoG1yUwsLTDP8YRJdB1oLS50hHY8teFP3i3xLWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfqlIoo8MCPeOosSy3t9vIocxSHAFYNWyFshjOIwT/c/VYcCw6efpA5+GXLKv6m+8
         3LLCr9+H9hpTY002UErvvN9U0XSP/AUXLHSkPO+T0LpaWG1VhQ4Vw0QoOOujnA0QsU
         YRuxoYUM9AUK2qfgvQBGIS7d34saiLhM3lpkA0uc=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCE2960F7B;
        Tue, 29 Oct 2019 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572371329;
        bh=Bv52zoG1yUwsLTDP8YRJdB1oLS50hHY8teFP3i3xLWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MD/4wgbedBgyoJrDGC84uH15rjYR4ONCJc1ET1Zz/CtynPGHWHDbG13ov4BrHABxV
         r3MwZ8XmS+8FHPx2xy+ZV4THKyTfBQxpnvWXOpdhihn5513qmvswISlFOaylRDtyVM
         tax0AVeeE1K6nST4lIGwsTc7hfcdoxtqmxvF5yv8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCE2960F7B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 3/3] clk: qcom: clk-rpmh: Add support for RPMHCC for SC7180
Date:   Tue, 29 Oct 2019 23:18:19 +0530
Message-Id: <1572371299-16774-4-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572371299-16774-1-git-send-email-tdas@codeaurora.org>
References: <1572371299-16774-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for clock RPMh driver to vote for ARC and VRM managed
clock resources.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rpmh.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 20d4258..3f3e08b 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -391,6 +391,24 @@ static const struct clk_rpmh_desc clk_rpmh_sm8150 = {
 	.num_clks = ARRAY_SIZE(sm8150_rpmh_clocks),
 };

+static struct clk_hw *sc7180_rpmh_clocks[] = {
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
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sc7180 = {
+	.clks = sc7180_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sc7180_rpmh_clocks),
+};
+
 static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 					 void *data)
 {
@@ -471,6 +489,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
 	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
+	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

