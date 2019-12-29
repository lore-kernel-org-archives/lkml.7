Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477ECC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AF4206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="LgkOV0Mb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Odyaqsd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfL2C72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 21:59:28 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56067 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbfL2C71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 21:59:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8A301539;
        Sat, 28 Dec 2019 21:59:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 28 Dec 2019 21:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ZDD1dMfJwP1vA
        w3RuR4Ni3oZSNxXqSku28CF47THuAw=; b=LgkOV0MbOV8eNPqF2wiRqAs4SQ49B
        ltrc83h6Yql5M7Wu0BWbmSPMu/vCAcDk99IFGoWqzRw0EZVFUP04gfFusaTipro+
        Wp2S2iKduGZkvoShMNiXHyEw8mgD3XzstpyefuoaqHDKmJMH/6YfvPj6q2nL4Ltl
        hZ80Jwguo8Z+rn2jq4vk47mq/zqbJJr3IDvykrnUmdSNxQf+fqb57dyGApqqSZ6M
        7sE+h+4AGcgX8O0+AUCAgyNqIxwsB973yx4Y2PD1o3jZOIk7WeeveZjL0NHsbgN+
        +N7NNVMDFO3uTGFkwwvXl7qAoKwIantHVRY9s2DnAwI95mt6PS4ES7qfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZDD1dMfJwP1vAw3RuR4Ni3oZSNxXqSku28CF47THuAw=; b=Odyaqsd+
        h71U9919/FEsIAhGUBci826x69IhiSnMWvdCDG9Rs5VTLdBFGjANDjJS7DxnPEaf
        IBJDNSTaHY7Td1IDeUyjeTUlpPgZ3Tu4Y+v6+OU9N+Z3fE0aA2B3IB8412vocqsD
        YxMPpAv3LuEcv/56pew1E1LS8hont/voGgaEUjYMy695KSKY0DvHkZtffpCxbADN
        kH6IELgM884rVAGh7uU1vHBjt9xq5D4nrJazpgix5cEhkLnoXFA8Ucg9M5v2bc8R
        0XuWTtcE3NZa8YcWXt3lzDb05u95pALhpekDkETIFbFcwj6MSkBqIZ/sLh1hyuW+
        MKVNX/4CQ3HJEw==
X-ME-Sender: <xms:jBYIXuy3ZFbiUYxiQwAamqftm8ZnhfYtOHqQBDkQZfik4Ar3zqyp8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdefuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:jBYIXpVSGQoP4L7AYDOCsj0DiMb7S057eNwdWmvrmfUykdacdNw_Tg>
    <xmx:jBYIXmjF4ve3tsevV3rryfBDKuaAKI4Mz8xspAIMzlQSjwKVsA_-NA>
    <xmx:jBYIXhCbsummRnaL7UFqq_wfxcYeF8VceJH3ImP9I2YtpEpOGeWxkg>
    <xmx:jRYIXohliOiVCCGXzeXCMr7is5URLuL11sbRc0LUxp-f16Xu54bZBw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B96A3060A15;
        Sat, 28 Dec 2019 21:59:24 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/3] clk: sunxi-ng: h6-r: Simplify R_APB1 clock definition
Date:   Sat, 28 Dec 2019 20:59:21 -0600
Message-Id: <20191229025922.46899-3-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191229025922.46899-1-samuel@sholland.org>
References: <20191229025922.46899-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the APB0 clock on previous chips, this is a simple single-parent
clock with an M divider. Use the equivalent helper macro instead of
writing out the whole clock description manually.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 45a1ed3fe674..df9c01831699 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -51,17 +51,7 @@ static struct ccu_div ar100_clk = {
 
 static CLK_FIXED_FACTOR_HW(r_ahb_clk, "r-ahb", &ar100_clk.common.hw, 1, 1, 0);
 
-static struct ccu_div r_apb1_clk = {
-	.div		= _SUNXI_CCU_DIV(0, 2),
-
-	.common		= {
-		.reg		= 0x00c,
-		.hw.init	= CLK_HW_INIT("r-apb1",
-					      "r-ahb",
-					      &ccu_div_ops,
-					      0),
-	},
-};
+static SUNXI_CCU_M(r_apb1_clk, "r-apb1", "r-ahb", 0x00c, 0, 2, 0);
 
 static struct ccu_div r_apb2_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
-- 
2.23.0

