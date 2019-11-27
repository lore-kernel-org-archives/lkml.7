Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABCAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2931720637
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888629;
	bh=MAt0eWtiPJD9sNaSAtGSvl94lDluSFw3dMc0uqRUmEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mszfhOfgNW/cJ25wVsfsWJF6jdPCs9MwZHUsJK2chaNo9E5lp+JB6oXviYtChRCM2
	 Ve5TKtNBGd9fbtD3WGgzdAuMbUI4wS+4rNeMoT6jhg/Ty8FOtJy7aBGhkCWizLznmB
	 RHurlfAhIZ2UW+tvvrV9lJKc7/HS+9nWCoEnAQQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfK0VDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731599AbfK0VDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:03:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F57521771;
        Wed, 27 Nov 2019 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888618;
        bh=MAt0eWtiPJD9sNaSAtGSvl94lDluSFw3dMc0uqRUmEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsKRX/I2NgVYFcXiVGmW5c3RuhBIToXU9XkpoHUI3p1ii4q0wMRSjHF2aNrvjx0Tb
         cOFCUirMZlYf3AN1SyuFzhMTntasqE4QWXUyMMpIiqqlQfeKYWORu0U4VqQKPYCMC1
         LVQJItCddHdMLjIyZkWdjO5xG0B6qpJu5chs6cqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 205/306] clk: sunxi-ng: enable so-said LDOs for A64 SoCs pll-mipi clock
Date:   Wed, 27 Nov 2019 21:30:55 +0100
Message-Id: <20191127203130.120409599@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
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



