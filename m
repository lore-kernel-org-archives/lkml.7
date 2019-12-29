Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D35C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEBB2176D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="HfLeF8aL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvpznrSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfL2C71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 21:59:27 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49349 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfL2C71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 21:59:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9057B542;
        Sat, 28 Dec 2019 21:59:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 28 Dec 2019 21:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=NwHOl9r2jOmJg
        JvC0fW2SeeCz3WaxtKWL9iSQCd7ocM=; b=HfLeF8aLCBciifaADKWL9e/+rj6Sg
        PL+rFqHNXg6wC61FFil1fNtmvAublyFRsjhvIc9jWkxBUzHDoyyhfRpJYbknnfvC
        f1/cxx3zJ9KN+BFi5s8c4s2HEHyfkfb+AF+buDN83id+hJc44N0mf8Kx2wYVtWkK
        gC1mw/FOtEz0xaoH2E+CyiGfm/Ggg6aQmk3RCf2smiqVXQxlb1Wiwu4ummp0qaGs
        naZXDP5BjTSGJh/1Dp9QQtbla980Ly9yrmoihEmtilkSLiyyH84vZuuEaVOu5DlR
        4zkXNjfprV+9ym6W4IMnu4zRkDhSzIym/NnEjbk+DmM8aiR19Z6gue08g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NwHOl9r2jOmJgJvC0fW2SeeCz3WaxtKWL9iSQCd7ocM=; b=jvpznrSy
        0c1ULk1LXDfiWtqFXqygbe+vBDBQJBiWWjF69zaGmb0cE5fdwYa5dniLTFjhE8HZ
        bgoltdiPqQFkRE9frU/tZilhcCGOl5yKx1rwREnjbJfg26RkFEAC7SgxCuim0X9e
        6t+TgbbfxQny8Wlb4VAj23jNXZkIOUFsWYgecCfZnLJsbQ6UuPyXF7P9WTH+FYn4
        GS6Ao+9rHmEpG52o42xeFdzhqfOp1NoVV3EkW8x4Y3qGtK7RPuHuemBolFoKygVX
        QZ5LMbYxwLvaiLNPosDK6Ypes0+5Tsxm35YGgduF755o3iRQpGcKgCDVUmH/5F6n
        zCt+dhBGy7Guqg==
X-ME-Sender: <xms:jRYIXgBJZvp5IfAEYJrO83pzFxDVqnBfbqYoxO1xWKOeI8mtmqCuXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdefuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:jRYIXto6nzVpeG7P2CYc0voZvqV08WZrxopxs9rjjt9nFoJWp1RlPA>
    <xmx:jRYIXo8FLlv4TtByjcq0nk09tgoqsx3kwOMsGs9Tig5fBhjqYEj1CA>
    <xmx:jRYIXmmXsE2GMrafeveknWYzqK10bvktFZnLQX457uZCaIWNIqH8Vg>
    <xmx:jRYIXuZF8ZZYNBrYbrqtKiSqRQU7nn6gzYB4IVKsjS19joPaol4gfg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC897306099E;
        Sat, 28 Dec 2019 21:59:24 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/3] clk: sunxi-ng: h6-r: Fix AR100/R_APB2 parent order
Date:   Sat, 28 Dec 2019 20:59:22 -0600
Message-Id: <20191229025922.46899-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191229025922.46899-1-samuel@sholland.org>
References: <20191229025922.46899-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the BSP source code, both the AR100 and R_APB2 clocks have
PLL_PERIPH0 as mux index 3, not 2 as it was on previous chips. The pre-
divider used for PLL_PERIPH0 should be changed to index 3 to match.

This was verified by running a rough benchmark on the AR100 with various
clock settings:

        | mux | pre-divider | iterations/second | clock source |
        |=====|=============|===================|==============|
        |   0 |           0 |  19033   (stable) |       osc24M |
        |   2 |           5 |  11466 (unstable) |  iosc/osc16M |
        |   2 |          17 |  11422 (unstable) |  iosc/osc16M |
        |   3 |           5 |  85338   (stable) |  pll-periph0 |
        |   3 |          17 |  27167   (stable) |  pll-periph0 |

The relative performance numbers all match up (with pll-periph0 running
at its default 600MHz).

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index df9c01831699..50f8d1bc7046 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -23,9 +23,9 @@
  */
 
 static const char * const ar100_r_apb2_parents[] = { "osc24M", "osc32k",
-					     "pll-periph0", "iosc" };
+						     "iosc", "pll-periph0" };
 static const struct ccu_mux_var_prediv ar100_r_apb2_predivs[] = {
-	{ .index = 2, .shift = 0, .width = 5 },
+	{ .index = 3, .shift = 0, .width = 5 },
 };
 
 static struct ccu_div ar100_clk = {
-- 
2.23.0

