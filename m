Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED13C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51E4205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560248273;
	bh=q7wJtycKmnzcTXPIHMv0VJJqiXDTMo8DpT30ueYKVmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zxVvmXdPr+Ks8it5AGf95sjGCDJkY1YlnY/bEFYAL80+kBD897KtElwQ8n5h5hscO
	 Sx7O5gZwkGi1oJccSrpUl/ZMX4X8WVgBRZFjo7ZRthjGMUaNfgS5ujmNkGjzUgcIdx
	 W//pp/2auzjOZJc/c9/VILmphJfSkd4YPLoG4/sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405430AbfFKKRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405342AbfFKKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:27 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E31D208E3;
        Tue, 11 Jun 2019 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248245;
        bh=q7wJtycKmnzcTXPIHMv0VJJqiXDTMo8DpT30ueYKVmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5ynChVEXxKK3SLA8vfiAE+LiVJdlpMyzU4tA3Kdb8K61nMfuLTzH3GYi7vcP59p8
         77Pkz6uuN26oMYIoVb9zBd1rU3pHuy9Qun2aT2w82DijMgchyZqvswk7a+OrrQi4MS
         GyJLCEtHH6OiwGuyEkxh2Nx/fbhUTtl1S6Y6Qxro=
Received: by wens.tw (Postfix, from userid 1000)
        id 92AC060C86; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 21/25] clk: sunxi-ng: h6: Use local parent references for CLK_FIXED_FACTOR
Date:   Tue, 11 Jun 2019 18:16:54 +0800
Message-Id: <20190611101658.23855-22-wens@kernel.org>
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

A forward declaration for struct clk_fixed_factor pll_periph0_4x_clk
is added as the definitions of the fixed factor clocks appear much later
in the file. The position of fixed factor clock definitions will be
moved for all drivers at a later time, before the conversion of all
other clock types.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 69 ++++++++++++++++++----------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 9d3f98962779..207c65dc5d70 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -622,8 +622,9 @@ static SUNXI_CCU_GATE(bus_xhci_clk, "bus-xhci", "ahb3", 0xa8c, BIT(5), 0);
 static SUNXI_CCU_GATE(bus_ehci3_clk, "bus-ehci3", "ahb3", 0xa8c, BIT(7), 0);
 static SUNXI_CCU_GATE(bus_otg_clk, "bus-otg", "ahb3", 0xa8c, BIT(8), 0);
 
-static CLK_FIXED_FACTOR(pcie_ref_100m_clk, "pcie-ref-100M",
-			"pll-periph0-4x", 24, 1, 0);
+static struct clk_fixed_factor pll_periph0_4x_clk;
+static CLK_FIXED_FACTOR_HW(pcie_ref_100m_clk, "pcie-ref-100M",
+			   &pll_periph0_4x_clk.hw, 24, 1, 0);
 static SUNXI_CCU_GATE(pcie_ref_clk, "pcie-ref", "pcie-ref-100M",
 		      0xab0, BIT(31), 0);
 static SUNXI_CCU_GATE(pcie_ref_out_clk, "pcie-ref-out", "pcie-ref",
@@ -745,34 +746,52 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdcp_clk, "hdcp", hdcp_parents, 0xc40,
 static SUNXI_CCU_GATE(bus_hdcp_clk, "bus-hdcp", "ahb3", 0xc4c, BIT(0), 0);
 
 /* Fixed factor clocks */
-static CLK_FIXED_FACTOR(osc12M_clk, "osc12M", "osc24M", 2, 1, 0);
+static CLK_FIXED_FACTOR_FW_NAME(osc12M_clk, "osc12M", "hosc", 2, 1, 0);
+
+static const struct clk_hw *clk_parent_pll_audio[] = {
+	&pll_audio_base_clk.common.hw
+};
 
 /*
  * The divider of pll-audio is fixed to 8 now, as pll-audio-4x has a
  * fixed post-divider 2.
  */
-static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-			"pll-audio-base", 8, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_2x_clk, "pll-audio-2x",
-			"pll-audio-base", 4, 1, CLK_SET_RATE_PARENT);
-static CLK_FIXED_FACTOR(pll_audio_4x_clk, "pll-audio-4x",
-			"pll-audio-base", 2, 1, CLK_SET_RATE_PARENT);
-
-static CLK_FIXED_FACTOR(pll_periph0_4x_clk, "pll-periph0-4x",
-			"pll-periph0", 1, 4, 0);
-static CLK_FIXED_FACTOR(pll_periph0_2x_clk, "pll-periph0-2x",
-			"pll-periph0", 1, 2, 0);
-
-static CLK_FIXED_FACTOR(pll_periph1_4x_clk, "pll-periph1-4x",
-			"pll-periph1", 1, 4, 0);
-static CLK_FIXED_FACTOR(pll_periph1_2x_clk, "pll-periph1-2x",
-			"pll-periph1", 1, 2, 0);
-
-static CLK_FIXED_FACTOR(pll_video0_4x_clk, "pll-video0-4x",
-			"pll-video0", 1, 4, CLK_SET_RATE_PARENT);
-
-static CLK_FIXED_FACTOR(pll_video1_4x_clk, "pll-video1-4x",
-			"pll-video1", 1, 4, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
+			    clk_parent_pll_audio,
+			    8, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
+			    clk_parent_pll_audio,
+			    4, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio_4x_clk, "pll-audio-4x",
+			    clk_parent_pll_audio,
+			    2, 1, CLK_SET_RATE_PARENT);
+
+static const struct clk_hw pll_periph0_parents[] = {
+	&pll_periph0_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph0_4x_clk, "pll-periph0-4x",
+			    pll_periph0_parents,
+			    1, 4, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_2x_clk, "pll-periph0-2x",
+			    pll_periph0_parents,
+			    1, 2, 0);
+
+static const struct clk_hw pll_periph1_parents[] = {
+	&pll_periph1_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_4x_clk, "pll-periph1-4x",
+			    pll_periph1_parents,
+			    1, 4, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_2x_clk, "pll-periph1-2x",
+			    pll_periph1_parents,
+			    1, 2, 0);
+
+static CLK_FIXED_FACTOR_HW(pll_video0_4x_clk, "pll-video0-4x",
+			   &pll_video0_clk.common.hw,
+			   1, 4, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HW(pll_video1_4x_clk, "pll-video1-4x",
+			   &pll_video1_clk.common.hw,
+			   1, 4, CLK_SET_RATE_PARENT);
 
 static struct ccu_common *sun50i_h6_ccu_clks[] = {
 	&pll_cpux_clk.common,
-- 
2.20.1

