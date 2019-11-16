Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8ABC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0E720859
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919498;
	bh=X93YxrL4e1zQIw8m5y0o6WIOY4hS2G+mT0DqMqffEj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PzR0DkKHR/Hcf449jvXunfaPcmvdKWtKBi6h2wIdlXMT1RwDC8eeXYFaCQEWhAYvW
	 7rMiF8CH2iVuy2oYWLFF7QSlhhwR6qU/n0hFjs4G3x4SR5MMf/tk46uAG0Odut8Vaa
	 hQTDszHuen4bpc4FZXmjwPbAgmtTl3lNGVtxRseI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfKPPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfKPPvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:51:32 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 516AF20723;
        Sat, 16 Nov 2019 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919491;
        bh=X93YxrL4e1zQIw8m5y0o6WIOY4hS2G+mT0DqMqffEj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KkSFJtffvbNXq/VkCGmwTq5yL4c2NBNrPvy0o70gruVn8zhhHuGV1Y5VpDRiq0JiZ
         WHsS1+InTLRJ8Ni2QvXPR85F0Pos+lnkYreL3+Cv6LtakgHz2rNLMHNzaEW+Wb9BlP
         39/EpbziF6+eDrxl+PzaHwvvAcFoydg7NCV9dbMg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/99] clk: mmp2: fix the clock id for sdh2_clk and sdh3_clk
Date:   Sat, 16 Nov 2019 10:49:44 -0500
Message-Id: <20191116155103.10971-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 4917fb90eec7c26dac1497ada3bd4a325f670fcc ]

A typo that makes it impossible to get the correct clocks for
MMP2_CLK_SDH2 and MMP2_CLK_SDH3.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Fixes: 1ec770d92a62 ("clk: mmp: add mmp2 DT support for clock driver")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 9adaf48aea231..061a9f10218b3 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -227,8 +227,8 @@ static struct mmp_param_gate_clk apmu_gate_clks[] = {
 	/* The gate clocks has mux parent. */
 	{MMP2_CLK_SDH0, "sdh0_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SDH0, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
 	{MMP2_CLK_SDH1, "sdh1_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SDH1, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
-	{MMP2_CLK_SDH1, "sdh2_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SDH2, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
-	{MMP2_CLK_SDH1, "sdh3_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SDH3, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
+	{MMP2_CLK_SDH2, "sdh2_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SDH2, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
+	{MMP2_CLK_SDH3, "sdh3_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SDH3, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
 	{MMP2_CLK_DISP0, "disp0_clk", "disp0_div", CLK_SET_RATE_PARENT, APMU_DISP0, 0x1b, 0x1b, 0x0, 0, &disp0_lock},
 	{MMP2_CLK_DISP0_SPHY, "disp0_sphy_clk", "disp0_sphy_div", CLK_SET_RATE_PARENT, APMU_DISP0, 0x1024, 0x1024, 0x0, 0, &disp0_lock},
 	{MMP2_CLK_DISP1, "disp1_clk", "disp1_div", CLK_SET_RATE_PARENT, APMU_DISP1, 0x1b, 0x1b, 0x0, 0, &disp1_lock},
-- 
2.20.1

