Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6994C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A443B21726
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601744;
	bh=KRT4iiK2EgNX4OEQ7ZhpMKAep0nZDdwNZwi5gNl3yaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ymCBBrkgQ+xWYWm7w7mtQrpdrDL5psY4ZZPd/ps0g5SEAc61UQ+0Tez6ZHBA8qGWM
	 EEkhEeNdnMl9kcEtLP4BZVCDNCsiJvGWW7QzBOXW9mGqSI8mk3Rflmw671C4itWJUe
	 aLaO1OGXlGmAQAyei4r081Iq9OxK44X7dhZhiyRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfGaTfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbfGaTfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:21 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659C421773;
        Wed, 31 Jul 2019 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601720;
        bh=KRT4iiK2EgNX4OEQ7ZhpMKAep0nZDdwNZwi5gNl3yaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaZU9ZFez26c0DKOS1sDUmYp3J5kASW43JqAwprDu1RGDTvRp482qWuau4Lio25lO
         mO88uIFWtfJ1YLt+ApDuWS8Q/zWBQGL0baKPm6SKk36tIW/T4czmyfNLxzwvwGqL5/
         JF9u5FHRj6iAH15Bja+LXHL1apfw5Pij9J1JW3ts=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 6/9] clk: socfpga: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:14 -0700
Message-Id: <20190731193517.237136-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190731193517.237136-1-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/socfpga/clk-gate.c       | 21 +++++++++++----------
 drivers/clk/socfpga/clk-periph-a10.c |  7 ++++---
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 3966cd43b552..b3c8143909dc 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -31,20 +31,20 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 	u32 l4_src;
 	u32 perpll_src;
 
-	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
+	if (streq(name, SOCFPGA_L4_MP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
 		return l4_src &= 0x1;
 	}
-	if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
+	if (streq(name, SOCFPGA_L4_SP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
 		return !!(l4_src & 2);
 	}
 
 	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-	if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
+	if (streq(name, SOCFPGA_MMC_CLK))
 		return perpll_src &= 0x3;
-	if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
-			streq(hwclk->init->name, SOCFPGA_NAND_X_CLK))
+	if (streq(name, SOCFPGA_NAND_CLK) ||
+			streq(name, SOCFPGA_NAND_X_CLK))
 			return (perpll_src >> 2) & 3;
 
 	/* QSPI clock */
@@ -55,24 +55,25 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
 {
 	u32 src_reg;
+	const char *name = clk_hw_get_name(hwclk);
 
-	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
+	if (streq(name, SOCFPGA_L4_MP_CLK)) {
 		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
 		src_reg &= ~0x1;
 		src_reg |= parent;
 		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
-	} else if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
+	} else if (streq(name, SOCFPGA_L4_SP_CLK)) {
 		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
 		src_reg &= ~0x2;
 		src_reg |= (parent << 1);
 		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
 	} else {
 		src_reg = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-		if (streq(hwclk->init->name, SOCFPGA_MMC_CLK)) {
+		if (streq(name, SOCFPGA_MMC_CLK)) {
 			src_reg &= ~0x3;
 			src_reg |= parent;
-		} else if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
-			streq(hwclk->init->name, SOCFPGA_NAND_X_CLK)) {
+		} else if (streq(name, SOCFPGA_NAND_CLK) ||
+			streq(name, SOCFPGA_NAND_X_CLK)) {
 			src_reg &= ~0xC;
 			src_reg |= (parent << 2);
 		} else {/* QSPI clock */
diff --git a/drivers/clk/socfpga/clk-periph-a10.c b/drivers/clk/socfpga/clk-periph-a10.c
index a8ff7229611d..3e0c55727b89 100644
--- a/drivers/clk/socfpga/clk-periph-a10.c
+++ b/drivers/clk/socfpga/clk-periph-a10.c
@@ -40,11 +40,12 @@ static u8 clk_periclk_get_parent(struct clk_hw *hwclk)
 {
 	struct socfpga_periph_clk *socfpgaclk = to_socfpga_periph_clk(hwclk);
 	u32 clk_src;
+	const char *name = clk_hw_get_name(hwclk);
 
 	clk_src = readl(socfpgaclk->hw.reg);
-	if (streq(hwclk->init->name, SOCFPGA_MPU_FREE_CLK) ||
-	    streq(hwclk->init->name, SOCFPGA_NOC_FREE_CLK) ||
-	    streq(hwclk->init->name, SOCFPGA_SDMMC_FREE_CLK))
+	if (streq(name, SOCFPGA_MPU_FREE_CLK) ||
+	    streq(name, SOCFPGA_NOC_FREE_CLK) ||
+	    streq(name, SOCFPGA_SDMMC_FREE_CLK))
 		return (clk_src >> CLK_MGR_FREE_SHIFT) &
 			CLK_MGR_FREE_MASK;
 	else
-- 
Sent by a computer through tubes

