Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBD2214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742670;
	bh=GXdADwZEBjuvQpjX+3cVw4RFiPjdVdX7ULLcRI1Ssrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/PE+r+/aKXoVG/lUBeWVIa5Zem1PgeP5dZmTrxd26tyF2hm+BGX3oe+ayq42fiOy
	 5DRbE6ynLkSGFJY974lqVKfoVPc5lWXkWnXlJWIWPau6DcH1lChJjr2TPQad+KnvNb
	 jDFmVYQ2lvhAzzMXHDbFf9/KRna86qEe1r1FU8lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfDHQ5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:57:49 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:43720 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDHQ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:57:49 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id AE7EC5FD53; Tue,  9 Apr 2019 00:57:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/6] clk: sunxi-ng: a83t: Add pll-video0 as parent of csi-mclk
Date:   Tue,  9 Apr 2019 00:57:39 +0800
Message-Id: <20190408165744.11672-2-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408165744.11672-1-wens@kernel.org>
References: <20190408165744.11672-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Allwinner's BSP for the A83T lists pll-video0 as the first parent to
csi-mclk with index 0. This parent is not listed in the datasheet, but
actually works, and makes more sense considering the index is the
default value out of reset.

Add pll-video0 as a parent to csi-mclk with index 0.

Fixes: 05359be1176b ("clk: sunxi-ng: Add driver for A83T CCU")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 2d6555d73170..5f714b4d8ee4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -513,8 +513,9 @@ static SUNXI_CCU_GATE(csi_misc_clk, "csi-misc", "osc24M", 0x130, BIT(16), 0);
 
 static SUNXI_CCU_GATE(mipi_csi_clk, "mipi-csi", "osc24M", 0x130, BIT(31), 0);
 
-static const char * const csi_mclk_parents[] = { "pll-de", "osc24M" };
-static const u8 csi_mclk_table[] = { 3, 5 };
+static const char * const csi_mclk_parents[] = { "pll-video0", "pll-de",
+						 "osc24M" };
+static const u8 csi_mclk_table[] = { 0, 3, 5 };
 static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(csi_mclk_clk, "csi-mclk",
 				       csi_mclk_parents, csi_mclk_table,
 				       0x134,
-- 
2.20.1

