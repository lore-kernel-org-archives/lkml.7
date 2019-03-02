Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A958C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADB520857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="UxmpdSvH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoCrbG4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfCBEai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:38 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35099 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728039AbfCBE37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C4F652212D;
        Fri,  1 Mar 2019 23:29:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=kwfuUztxUlhsG
        6MYLzQmOvXZRpx67dgCMPLH+uawJkc=; b=UxmpdSvHwPtKCR/w4U6iD3T5zck2m
        sBdUpmhwqiAiXzGYyz5IkGC9LyrzkGgExdlVrMN7YxZ5s9uEKihiTYRqJYbJ9Lnl
        QYE3tI436MulETdVbBP4ytsSW66lNhf7bWV+CS+vVah9BblXTXijQcnTVI5+eNgA
        559j9OtTLQtEBC246eiOCKptnCq3MXkbzaqNDmS5RexRj6qcy160R4u0fFfJ4iMD
        xSkaom8PQn+UpoJYdJXZNVA0/aR46VTqmioIKaM5+xV84BL7/AH7nCuKWIwS+XJ/
        fv70ppMTcVeq/mdDaidSa07jcwXGmNvs7dLVrX5PJsuClZKiW08ma26CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=kwfuUztxUlhsG6MYLzQmOvXZRpx67dgCMPLH+uawJkc=; b=JoCrbG4Y
        VgCr1TJ8HYv/ne/9yBybpApIf7NbtlDUHafGT3uMJAdjlDZQepcMHLWGKyMa+dqJ
        ZaRDQK2SQHkDaJ8K+dKEqKxRulj64gmvWbwmDtjurVeO/pOWy34iHRo7al6v+Y30
        uXSfvhQAXQCdcsQvPqlwz8wAbHIpScSGeorp/QBlSTOIaVrnn+cVmaeJbMiBf61p
        X5Bzobh22s5NJqQW94aL4LF1pHeYwSZkz/2+MLsV+pkzvf5dL9A9wZP/vp+HgaBu
        CQN8tV5dPUVzIkkwTF1/9CzJEvbZ7hKzAG3FY9e/RleAkKSzEUx2CpKYtk6ozUi2
        pzGYbH9Mf02wOw==
X-ME-Sender: <xms:xgZ6XLuZ4JsKoCVj5WXj4EwNmF-EbJBZezXDJ8N_MUHXh5Lnoz6SGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:xgZ6XNtX0QiksiNbHDDu-PbCZYJzrjqjhogL2XBplcj8e5xl-DQ0yg>
    <xmx:xgZ6XHp9GPtG2_uqP2RxRseEuWk72_4eBl59vyDucvNQxeyWeQROUA>
    <xmx:xgZ6XBPzW0fElht5LWT5EbIEbpTFkpcpeRhFs3Ca1tfMZzMuP2qc5Q>
    <xmx:xgZ6XJIqFBJX-wMTFFZ1gmqR9uq3AIedjk_5LIYIRgAkUOhWvXRiXg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D93D810310;
        Fri,  1 Mar 2019 23:29:57 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 10/15] [NOT FOR MERGE] clk: sunxi-ng: sun8i: Avoid turning off unused PRCM gates
Date:   Fri,  1 Mar 2019 22:29:46 -0600
Message-Id: <20190302042951.53671-11-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware attached to AHB0/APB0 and controlled in the PRCM is designed to
be used by firmware running on the ARISC core. However, some devices in
this block (specifically the I2C, RSB, PIO, and CIR-RX) have native
Linux drivers and are already in the device tree. In particular, the RSB
and I2C buses may have sound chips and display bridges hanging off of
them that cannot easily be driven from firmware.

To facilitate sharing this hardware block between Linux and system
firmware, avoid turning off PRCM clock gates that are unreferenced in
the device tree. We assume that firmware has already optimally
configured these clocks before booting Linux.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 90b3530e2c18..603de1e853e9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -92,19 +92,19 @@ static struct ccu_div apb0_clk = {
 static SUNXI_CCU_M(a83t_apb0_clk, "apb0", "ahb0", 0x0c, 0, 2, 0);
 
 static SUNXI_CCU_GATE(apb0_pio_clk,	"apb0-pio",	"apb0",
-		      0x28, BIT(0), 0);
+		      0x28, BIT(0), CLK_IGNORE_UNUSED);
 static SUNXI_CCU_GATE(apb0_ir_clk,	"apb0-ir",	"apb0",
-		      0x28, BIT(1), 0);
+		      0x28, BIT(1), CLK_IGNORE_UNUSED);
 static SUNXI_CCU_GATE(apb0_timer_clk,	"apb0-timer",	"apb0",
-		      0x28, BIT(2), 0);
+		      0x28, BIT(2), CLK_IGNORE_UNUSED);
 static SUNXI_CCU_GATE(apb0_rsb_clk,	"apb0-rsb",	"apb0",
-		      0x28, BIT(3), 0);
+		      0x28, BIT(3), CLK_IGNORE_UNUSED);
 static SUNXI_CCU_GATE(apb0_uart_clk,	"apb0-uart",	"apb0",
-		      0x28, BIT(4), 0);
+		      0x28, BIT(4), CLK_IGNORE_UNUSED);
 static SUNXI_CCU_GATE(apb0_i2c_clk,	"apb0-i2c",	"apb0",
-		      0x28, BIT(6), 0);
+		      0x28, BIT(6), CLK_IGNORE_UNUSED);
 static SUNXI_CCU_GATE(apb0_twd_clk,	"apb0-twd",	"apb0",
-		      0x28, BIT(7), 0);
+		      0x28, BIT(7), CLK_IGNORE_UNUSED);
 
 static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
 static SUNXI_CCU_MP_WITH_MUX_GATE(ir_clk, "ir",
@@ -113,7 +113,7 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(ir_clk, "ir",
 				  16, 2,	/* P */
 				  24, 2,	/* mux */
 				  BIT(31),	/* gate */
-				  0);
+				  CLK_IGNORE_UNUSED);
 
 static const char *const a83t_r_mod0_parents[] = { "osc16M", "osc24M" };
 static const struct ccu_mux_fixed_prediv a83t_ir_predivs[] = {
@@ -138,7 +138,7 @@ static struct ccu_mp a83t_ir_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("ir",
 						      a83t_r_mod0_parents,
 						      &ccu_mp_ops,
-						      0),
+						      CLK_IGNORE_UNUSED),
 	},
 };
 
-- 
2.19.2

