Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94CCC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A9420872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343530;
	bh=vNJVuAcZSGd4JfMJeT1HcCWqm+jXlfUf9xrhXZuLZQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KDb3aYdsPAIvqVBcbB4CZcLysma9Lo7rxzhjRWFf3fec+Xad6/JB8Xv6eOaRYF80S
	 HClcLCYXp+07F/lHMjRatkZL2jb/UpWR0W+9l+28NTeS3sVy++P2tCJupsbyF+6zi6
	 Uh/qTON9gznsKA3r85AAcYYgutR7/c8sxpbBPXBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403904AbfIXQp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391453AbfIXQp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:45:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D7C20872;
        Tue, 24 Sep 2019 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343527;
        bh=vNJVuAcZSGd4JfMJeT1HcCWqm+jXlfUf9xrhXZuLZQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JjFmLxoRe5KEaa0ie6iqXLEP96e1UCQb06KieFOGezO+Bhiry1zpXeAn+ZipIsKv
         kkTh5i5uUO+sPDXCLlTUbnDVDT0bTXMO2Mf4WOX5PeUy0bqyHnIbTB5CdmTBqDw0pM
         koVR/22SpvFQPI7ywphHDwr4cGVHTIIfxKaDIb6A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 78/87] clk: imx: clk-pll14xx: unbypass PLL by default
Date:   Tue, 24 Sep 2019 12:41:34 -0400
Message-Id: <20190924164144.25591-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit a9aa8306074d9519dd6e5fdf07240b01bac72e04 ]

When registering the PLL, unbypass the PLL.
The PLL has two bypass control bit, BYPASS and EXT_BYPASS.
we will expose EXT_BYPASS to clk driver for mux usage, and keep
BYPASS inside pll14xx usage. The PLL has a restriction that
when M/P change, need to RESET/BYPASS pll to avoid glitch, so
we could not expose BYPASS.

To make it easy for clk driver usage, unbypass PLL which does
not hurt current function.

Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lkml.kernel.org/r/1568043491-20680-3-git-send-email-peng.fan@nxp.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-pll14xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 656f48b002dd3..7a815ec76aa5c 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -368,6 +368,7 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 	struct clk_pll14xx *pll;
 	struct clk *clk;
 	struct clk_init_data init;
+	u32 val;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -399,6 +400,10 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 	pll->rate_table = pll_clk->rate_table;
 	pll->rate_count = pll_clk->rate_count;
 
+	val = readl_relaxed(pll->base + GNRL_CTL);
+	val &= ~BYPASS_MASK;
+	writel_relaxed(val, pll->base + GNRL_CTL);
+
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to register pll %s %lu\n",
-- 
2.20.1

