Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C54C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E6221479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921151;
	bh=MAt0eWtiPJD9sNaSAtGSvl94lDluSFw3dMc0uqRUmEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d8zxxrJu5LEk6A8HDj0QQ/+zmIzXn9lnFh/Lon643Rb1G6bsjHCSWtinrhzEzE9fa
	 5i4YEMDcXM0sqhJjvDhkW86+LV6z27WF2RRo9CWcWaK9fPWXeB9F6UaUR9UFcb4ja+
	 tqWrFYJTMcRuX3tYD0zQThWJWi45A1bcqsV0td+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfKPQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbfKPPqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:19 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C222084D;
        Sat, 16 Nov 2019 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919178;
        bh=MAt0eWtiPJD9sNaSAtGSvl94lDluSFw3dMc0uqRUmEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1DkgWnIa7qXfUwItLd7VvFD7xTb9yNDxMYr6JsmrDQIshX+pVSoKFIZ8s0oAuC5C
         D1MXgljrdLWpakZhz1BwxpOuHsEIdYvRLKGMjYGxcjg0QMqumvrwiviHY41L11KQ16
         zDp7p2FIn5L7D/wlV8dNcjvApuH0uCiEwZwR5iYc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 188/237] clk: sunxi-ng: enable so-said LDOs for A64 SoC's pll-mipi clock
Date:   Sat, 16 Nov 2019 10:40:23 -0500
Message-Id: <20191116154113.7417-188-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

[ Upstream commit 859783d1390035e29ba850963bded2b4ffdf43b5 ]

In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
register is called "LDO{1,2}_EN", and according to the BSP source code
from Allwinner , the LDOs are enabled during the clock's enabling
process.

The clock failed to generate output if the two LDOs are not enabled.

Add the two bits to the clock's gate bits, so that the LDOs are enabled
when the PLL is enabled.

Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index ee9c12cf3f08c..2a60981799216 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -158,7 +158,12 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 #define SUN50I_A64_PLL_MIPI_REG		0x040
 
 static struct ccu_nkm pll_mipi_clk = {
-	.enable		= BIT(31),
+	/*
+	 * The bit 23 and 22 are called "LDO{1,2}_EN" on the SoC's
+	 * user manual, and by experiments the PLL doesn't work without
+	 * these bits toggled.
+	 */
+	.enable		= BIT(31) | BIT(23) | BIT(22),
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
-- 
2.20.1

