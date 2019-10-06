Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F44DECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076762173B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383298;
	bh=BwH26qSMRuY2Or+00XXUuLtnuq5qjhb/CwLUsd9ahE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qEGvDUwN2VU9qsPRkwS0ofR7WriFEbzUvSwGLGqM2SZX9UThyjQaPK+s0cnkU/oH0
	 Vq838BsNmUtkio073lShUHVKXqalDIgahKbSfR/2g/nuO3kI4wxUzK8Om60SL9V2ok
	 vCBu0KmuZu4sKyITCLk/pib+NurAG5Spdx/MIJxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfJFRe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfJFReu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:34:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F212133F;
        Sun,  6 Oct 2019 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383289;
        bh=BwH26qSMRuY2Or+00XXUuLtnuq5qjhb/CwLUsd9ahE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H13CVK2qY90OPaWFG9JD1jLXblNn2Rl52m2p53Qpc1S1jQtuu9jF07u9jnVfaQCCz
         Z5GIoJ/0L6+VzWxPLlWEd/m09RrrgZ9fohVJ/PyD285PQZ7lIu7s6UFM/KymzIi8+0
         o82U/9Dxgc3LTvFC1ca4xrEF1SheDqBBc0tRX7sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Zeng <Guo.Zeng@csr.com>,
        Barry Song <Baohua.Song@csr.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 050/137] clk: sirf: Dont reference clk_init_data after registration
Date:   Sun,  6 Oct 2019 19:20:34 +0200
Message-Id: <20191006171212.961123871@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit af55dadfbce35b4f4c6247244ce3e44b2e242b84 ]

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Guo Zeng <Guo.Zeng@csr.com>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190731193517.237136-6-sboyd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sirf/clk-common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index ad7951b6b285e..dcf4e25a02168 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -297,9 +297,10 @@ static u8 dmn_clk_get_parent(struct clk_hw *hw)
 {
 	struct clk_dmn *clk = to_dmnclk(hw);
 	u32 cfg = clkc_readl(clk->regofs);
+	const char *name = clk_hw_get_name(hw);
 
 	/* parent of io domain can only be pll3 */
-	if (strcmp(hw->init->name, "io") == 0)
+	if (strcmp(name, "io") == 0)
 		return 4;
 
 	WARN_ON((cfg & (BIT(3) - 1)) > 4);
@@ -311,9 +312,10 @@ static int dmn_clk_set_parent(struct clk_hw *hw, u8 parent)
 {
 	struct clk_dmn *clk = to_dmnclk(hw);
 	u32 cfg = clkc_readl(clk->regofs);
+	const char *name = clk_hw_get_name(hw);
 
 	/* parent of io domain can only be pll3 */
-	if (strcmp(hw->init->name, "io") == 0)
+	if (strcmp(name, "io") == 0)
 		return -EINVAL;
 
 	cfg &= ~(BIT(3) - 1);
@@ -353,7 +355,8 @@ static long dmn_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	unsigned long fin;
 	unsigned ratio, wait, hold;
-	unsigned bits = (strcmp(hw->init->name, "mem") == 0) ? 3 : 4;
+	const char *name = clk_hw_get_name(hw);
+	unsigned bits = (strcmp(name, "mem") == 0) ? 3 : 4;
 
 	fin = *parent_rate;
 	ratio = fin / rate;
@@ -375,7 +378,8 @@ static int dmn_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_dmn *clk = to_dmnclk(hw);
 	unsigned long fin;
 	unsigned ratio, wait, hold, reg;
-	unsigned bits = (strcmp(hw->init->name, "mem") == 0) ? 3 : 4;
+	const char *name = clk_hw_get_name(hw);
+	unsigned bits = (strcmp(name, "mem") == 0) ? 3 : 4;
 
 	fin = parent_rate;
 	ratio = fin / rate;
-- 
2.20.1



