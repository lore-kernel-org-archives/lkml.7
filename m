Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24247C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C15208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601728;
	bh=qzMII9C4EWOSO7lbnevf4fOV8Y+qXeGKUcDdf3nXVQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kFoUnarqL2P78OW75m8/dlxUen6zD/G2veTFGnQLmStHI2VZRO876Eo7GGulFyTyc
	 0AP/xv8au49tlXgufkxYBTepPp1EFkBM9SgvwUhGaIRpbjLzmulHizfoQRhoRiyDRz
	 4tOPY5YV6YBWkaY78x7bhd8FovK5Wm5xfygIo3ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfGaTf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfGaTfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:20 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F461214DA;
        Wed, 31 Jul 2019 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601720;
        bh=qzMII9C4EWOSO7lbnevf4fOV8Y+qXeGKUcDdf3nXVQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tv9xfchJ0rXsxthJuJYEAz1/My4p/z5i1kIZcz5nOvWm6j1Xy8A3cEGA6bfKK6zH
         XX6nztHNBJsISD67r0Np9FUO3fqLYYMTu5nNhE2Vt9i2anbK68/erNylNmXk1wTKC5
         1Z8Hj3LCfatUkklXsng1UUkW5c7dPvKcZ6MxU4n4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Guo Zeng <Guo.Zeng@csr.com>, Barry Song <Baohua.Song@csr.com>
Subject: [PATCH 5/9] clk: sirf: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:13 -0700
Message-Id: <20190731193517.237136-6-sboyd@kernel.org>
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

Cc: Guo Zeng <Guo.Zeng@csr.com>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/sirf/clk-common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index ad7951b6b285..dcf4e25a0216 100644
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
Sent by a computer through tubes

