Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C46C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16F20665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890445;
	bh=L9YHeN7DCGEZ+iGnvQLvZwPgOC6kkntnCWZ1Zw5ZInw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S3TKFqm3XpCH0+aJ9jySbHWrGQtjdSeqQkhZrb0CRhz3eTlRA/d+YHLQCAEWAsqn+
	 2c05xam7SJElksCD1MVHNv+a9GMTvqHI1RXOGe2NypjhcwMWIqA2ZemXf8CKGZAfZZ
	 Ap6nCljXzw3l76wsvhr+JXtaUlVDZSqICz1SV5Hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfK0Uv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbfK0UvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:51:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E841A219F6;
        Wed, 27 Nov 2019 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887882;
        bh=L9YHeN7DCGEZ+iGnvQLvZwPgOC6kkntnCWZ1Zw5ZInw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D61Uf3pNkp+THjvL8DF/fjlJl6eLp+gzPKm4bSylLMaBO16D2DrDXeu1KE8uU2o9+
         v7DchFAsdz2UCTZfD9csDiRX2HC12byDYm95QrgZX2fEBvSJLJQsICMii6BJJyb4dj
         vH3OS2QCxlmrC9XQ644TH1EVAL49wmLZWEDDCkik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 130/211] clk: sunxi-ng: enable so-said LDOs for A64 SoCs pll-mipi clock
Date:   Wed, 27 Nov 2019 21:31:03 +0100
Message-Id: <20191127203106.362299381@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 2bb4cabf802f0..36a30a3cfad71 100644
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



