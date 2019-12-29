Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBB1C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2025206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="cPVQUCSx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvthTO2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfL2C7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 21:59:39 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:32945 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbfL2C71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 21:59:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8AD8B53A;
        Sat, 28 Dec 2019 21:59:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 28 Dec 2019 21:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=HKgRKkpYDwYCc
        0C8LMU1d+PYGgyIFfDsSkTAmXEnnec=; b=cPVQUCSx2CGEVlOBuwU3gxSxkh0dB
        r/XL3nNXYBu/1hvp2HqAO3dJ3aMwg4KKNxpeDliAK4WZ1xOVzAu9wKEpSYk2F4Jd
        7rz5lCQ2ea3sbinnSbX8xFCajXVPWkR98NVjiftEOI5pF8jh8e6NC5JnxjGu0o1/
        aWobUtPXeLZRmZcCCv109sOjPj3UoufZwc3ug2cOWsG0TZBm6QzME+Nt+8/ne3+r
        iDLcztfsIREbyYU9WQN3vMjs+TFcFtwa3M7Vsc8PsMmU0A6OQlH+V82SJgzCJNi2
        Abk85YiNPxVe8LURlBc4wQl5ONPFvsjpHq1GBpBfVbzbZL1Ji1eb+hyBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=HKgRKkpYDwYCc0C8LMU1d+PYGgyIFfDsSkTAmXEnnec=; b=lvthTO2U
        yulNJ6YcTCTmRvuZf6pCCd8f8+WvPxIC5XVmK74Qn+tOd91dyqKh4FvYthQd6+GD
        IKZ2MlhW4cMCUsquj+ftUmZnEULis+ryHPgIkfLP+/vZ6bOzCErHbo7h/9GfY/k1
        YrjzcBnC2ZOVMpYv7b22eMxQvSZe2/Y8UGWtKvFiNk7Yqw92VycO/wXBqLRBLOte
        sLy/gDHr7tpILYY90igPxzF/wnXhUNo8I33ViyHtqutRIjnic/AB9Fj/SIytkJYD
        aL8ohUfx2gFHBeC4P5ISh9zWOnjZG/seSfpWf7BNCW6foWbFITst4NK0UwYcInW0
        A+T/MN8wwCZd2Q==
X-ME-Sender: <xms:jBYIXmA6Wbus9U-0DXDwdl5fcwJP39DrdArxKO6org_ULjjeOqhv1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdefuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:jBYIXkwQFaGsUQl6Hpz7nUVlOed-QPSmLFRc3izbBLw2p155S-jjsw>
    <xmx:jBYIXkklVzL3Jp5gJzs9ZLChc1bApY2GEwkOeDhZfgUqpcqnKk0OCQ>
    <xmx:jBYIXpF_5XbV5e5VvLRmTxo0hYSukcpQgcLXli6Vv_2qorvIyLa7Wg>
    <xmx:jRYIXuJpLDT0NP6GCSkvezb-rr4E2QSD-hVllc-Aoi7em4KmuX6bpQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE5573060A0F;
        Sat, 28 Dec 2019 21:59:23 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/3] clk: sunxi-ng: sun8i-r: Fix divider on APB0 clock
Date:   Sat, 28 Dec 2019 20:59:20 -0600
Message-Id: <20191229025922.46899-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191229025922.46899-1-samuel@sholland.org>
References: <20191229025922.46899-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the BSP source code, the APB0 clock on the H3 and H5 has a
normal M divider, not a power-of-two divider. This matches the hardware
in the A83T (as described in both the BSP source code and the manual).
Since the A83T and H3/A64 clocks are actually the same, we can merge the
definitions.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 4646fdc61053..4c8c491b87c2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -51,19 +51,7 @@ static struct ccu_div ar100_clk = {
 
 static CLK_FIXED_FACTOR_HW(ahb0_clk, "ahb0", &ar100_clk.common.hw, 1, 1, 0);
 
-static struct ccu_div apb0_clk = {
-	.div		= _SUNXI_CCU_DIV_FLAGS(0, 2, CLK_DIVIDER_POWER_OF_TWO),
-
-	.common		= {
-		.reg		= 0x0c,
-		.hw.init	= CLK_HW_INIT_HW("apb0",
-						 &ahb0_clk.hw,
-						 &ccu_div_ops,
-						 0),
-	},
-};
-
-static SUNXI_CCU_M(a83t_apb0_clk, "apb0", "ahb0", 0x0c, 0, 2, 0);
+static SUNXI_CCU_M(apb0_clk, "apb0", "ahb0", 0x0c, 0, 2, 0);
 
 /*
  * Define the parent as an array that can be reused to save space
@@ -127,7 +115,7 @@ static struct ccu_mp a83t_ir_clk = {
 
 static struct ccu_common *sun8i_a83t_r_ccu_clks[] = {
 	&ar100_clk.common,
-	&a83t_apb0_clk.common,
+	&apb0_clk.common,
 	&apb0_pio_clk.common,
 	&apb0_ir_clk.common,
 	&apb0_timer_clk.common,
@@ -167,7 +155,7 @@ static struct clk_hw_onecell_data sun8i_a83t_r_hw_clks = {
 	.hws	= {
 		[CLK_AR100]		= &ar100_clk.common.hw,
 		[CLK_AHB0]		= &ahb0_clk.hw,
-		[CLK_APB0]		= &a83t_apb0_clk.common.hw,
+		[CLK_APB0]		= &apb0_clk.common.hw,
 		[CLK_APB0_PIO]		= &apb0_pio_clk.common.hw,
 		[CLK_APB0_IR]		= &apb0_ir_clk.common.hw,
 		[CLK_APB0_TIMER]	= &apb0_timer_clk.common.hw,
@@ -282,9 +270,6 @@ static void __init sunxi_r_ccu_init(struct device_node *node,
 
 static void __init sun8i_a83t_r_ccu_setup(struct device_node *node)
 {
-	/* Fix apb0 bus gate parents here */
-	apb0_gate_parent[0] = &a83t_apb0_clk.common.hw;
-
 	sunxi_r_ccu_init(node, &sun8i_a83t_r_ccu_desc);
 }
 CLK_OF_DECLARE(sun8i_a83t_r_ccu, "allwinner,sun8i-a83t-r-ccu",
-- 
2.23.0

