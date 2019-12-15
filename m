Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C67C2D0D5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD5A2465E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="cILIeY3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dg8URCxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLOEZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:25:03 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60083 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbfLOEZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:25:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9263F5AE5;
        Sat, 14 Dec 2019 23:25:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=8789/HvoJo8OL
        hH4D97+su6QiBZWTXGYa2xCWRaRHwI=; b=cILIeY3Z4KXPzFGl0PtaP3J12xU/i
        sBAlIji5BtRUFCc4hGfyR6DQM1pLGL2YVPBerB2V/RimH695drH9RZLt6uSdSNFe
        ntM60qiHWAiNvj39hxAIVDrvrk2qfLk/8TVDuRHpn1BUlRNlWby6GFLI8MVUOwCJ
        xiK04nHlN0Ihkn9Hdo8dGSC1aAvj7RURf3PngByfcY5rYA0hr3UJ9XFYCjR7LPHl
        BWh7YYvf2pVQin+W/F8PSAzRGibkmzSQXxgkjSYiWRqoUf4xAGMBrYK48Vwua/0c
        /iA8fOIiGJrqYLAVF2TlcN6/4hdHhmOpTeVNCxqHAkFCfzPKnGujnYl/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=8789/HvoJo8OLhH4D97+su6QiBZWTXGYa2xCWRaRHwI=; b=Dg8URCxD
        RdRp+j1QEzh7Fci2mGoiruU0VNPcJ8impL1Pua5EcheDrm//0lPnN36w3lWNe4ua
        rLZry2x7mb54p8lUWpeGHDNUoLk41lEM2jB6EKaHzPT8kwr68Hfy5BEs0oiz2nWr
        Zcj4m9jstXdeirSlYpOPqD+SGX760otvr0cACjydkmealuBe+pz+EQ8pbaN61e3g
        qCAseNBnrFVjrTbK75ot1GAF3lCHrSKovnj/4pZ9s1czsDenXTP9H6ePnxD3e3Ve
        tgX80tEFRLclcsWa6d4gUoWpEiT5fW7ZVJH1R7NGcQEWjG+PJinzMv2t5zLHHizP
        gFfB+fInb8u/EQ==
X-ME-Sender: <xms:nbX1XYfF0dSesqG6yEA7zCV6RT81JSkM67v6xf0aBSrm9du6wP15Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:nbX1XXtcrgsqVaryJlhgH4NoRuZVe1M9sbntBgGBF0-QW9s_cFiLbA>
    <xmx:nbX1Xf2ipNlAkXqU3E60ZrfyAhqxUyhbJVEaaK7-qp4LlbgRzcUQGg>
    <xmx:nbX1XVHbtGMH8LvVVGZUh-XkxGcZtoSjv5d2y5f2lHjp5MUgTH_b9g>
    <xmx:nbX1XYGbnck0lgGMl_E0tQNNthMDRP3JUp3-Ie7qBKsQgCOWafAWPw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A99738005C;
        Sat, 14 Dec 2019 23:25:00 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 5/8] ARM: dts: sunxi: h3/h5: Add msgbox node
Date:   Sat, 14 Dec 2019 22:24:52 -0600
Message-Id: <20191215042455.51001-6-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191215042455.51001-1-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 and H5 SoCs contain a message box that can be used to send
messages and interrupts back and forth between the ARM application CPUs
and the ARISC coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 0afea59486c2..6c5b283962a1 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -233,6 +233,16 @@
 			reg = <0x1c14000 0x400>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-h3-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
-- 
2.23.0

