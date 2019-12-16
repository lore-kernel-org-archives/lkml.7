Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2312EC2D0CD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AED206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518697;
	bh=xIJPFwaVsfiybimS1JmchYwF0xTDBTHaSuyF1kELStE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KKOI4mrYiHyhyUVMtxPM1BYi+ZgxxMxKDwz6ehIFgXoiRRe4CRuqx+a9drnSC3uJu
	 6o6ryQD5OndB+AO50GJLmtMk9pSxBJYtxgU4JmRRRH3Qq7HyRa5gsWRrlmaplRPC7Z
	 6WXOSf+9fmdF+62gXcKe/83RxgM6nTwPVJ7GXDrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLPRvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:51:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfLPRvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63589206EC;
        Mon, 16 Dec 2019 17:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518692;
        bh=xIJPFwaVsfiybimS1JmchYwF0xTDBTHaSuyF1kELStE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXYjgBEXPIqydzYZhm3d2czZ0lNj3Lp55MbSNGl4yh26dELhecBgAl5tY677krc8y
         0F4FoBJ/Cm76mOY/NfB82r8cBxazHWrPKtBaf9iPhpV4BCwHlI4jCwEDqfrHLLH4qF
         cIlAChBTYYzsweL2GL9KU5B2kj2mF+KiJcZ/nmxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/267] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
Date:   Mon, 16 Dec 2019 18:45:54 +0100
Message-Id: <20191216174851.985963465@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@amarulasolutions.com>

[ Upstream commit ee678706e46d0d185c27cc214ad97828e0643159 ]

DSI DPHY gate bit on MIPI DSI clock register is bit 15
not bit 30.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 36a30a3cfad71..eaafc038368f5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -565,7 +565,7 @@ static const char * const dsi_dphy_parents[] = { "pll-video0", "pll-periph0" };
 static const u8 dsi_dphy_table[] = { 0, 2, };
 static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
 				       dsi_dphy_parents, dsi_dphy_table,
-				       0x168, 0, 4, 8, 2, BIT(31), CLK_SET_RATE_PARENT);
+				       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);
-- 
2.20.1



