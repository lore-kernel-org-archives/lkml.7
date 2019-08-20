Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BADC3A5A1
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057822CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="F5AGKIf4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGZdz9HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfHTDXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:21 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59901 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729115AbfHTDXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B26A63541;
        Mon, 19 Aug 2019 23:23:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=uVypQN0RkXDd2
        3sRZ3MoRC5WnYNW0CweKKlnGS7aNXs=; b=F5AGKIf4ORfxk8M/hdPFMrx5AfMtb
        9m5oxsaaG9XGMpZMEzbLr6IwTsSTacWFyXcQlZFr1JJ+IYPR88obOgJGtQDIBYxg
        0kWwFsF9g3jOwIxRh5eJyBC74aQ0oS40P2y4Q5SBtFqwIIpNZiTtN3C/JlbfUJ7E
        BddOoueTuCOQPsZq9YbF8okiRgnJ4EtuXS8vZxPSwQI9D0E20jZ5dMXvYWyJqy+n
        Xgna2sTQXDnPAau+aTqI0QaqOa38OpPVq2jkjwoVaA5Pb76BK2a9cw5mXEDzeJRp
        nUYEL44YY9UBBQS9H2o3F8q/8ryZbfQGylB47GtUgxKwg+EaT7l/hKY5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=uVypQN0RkXDd23sRZ3MoRC5WnYNW0CweKKlnGS7aNXs=; b=pGZdz9HI
        3a+66ty+G7isa6fD/EB9r7YcMWN1dYTDLWYOJB03DffgQDg6OxdGmqrJyfFo+fVG
        tpPl+M6VXgsczPMaNBmsMMgOTOU6zwCzHTGYm+zz7sdDbx5mfSARSxiGL+AiPOwv
        SUuTA6Lx6otUcndwxlAgQTNM4ypQvv4mgQvueg9Jy+M6On6M2TmzMI+I5Jwd087k
        dEabx7pswd3cPJQ/REoy7geH2tyHW0kvoYh/SDLUWXyn/V2ZHM8H4+AK7YBSbLC/
        RM7bvK7puf+N3/Tf2BurOuAMM3gaOP/cSnkpe+wlGt+C9Lk2Vh1iSGXaDfLtn9zR
        MYja+UqZIY6i5A==
X-ME-Sender: <xms:pWdbXVwsgRg27tqtCc-1fFAd9atzA743iY8kJgLO_BId1ztstlyViQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:pWdbXb3L8s9Qw_gWAe50wMmCvvpONSVqdmBuHP10Shaz1voPELvxIg>
    <xmx:pWdbXci5Mddsd4Zg_kAe3OG47GJ_qJWT3QjylUeiAlZnYspSBwckHw>
    <xmx:pWdbXZmrqg7gHmPzvngrPBQ912efLzArWzpUdSC_v41LikuJ0Kf9WQ>
    <xmx:pWdbXUkzf8Vv68xuTc0KYzY9MDt2NIX7u9fRORHgYzQ5YLwRcyoOog>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC39C80059;
        Mon, 19 Aug 2019 23:23:16 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 08/10] arm64: dts: allwinner: a64: Add msgbox node
Date:   Mon, 19 Aug 2019 22:23:09 -0500
Message-Id: <20190820032311.6506-9-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index ddb6f11e89df..428f539a091a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -487,6 +487,16 @@
 			reg = <0x1c14000 0x400>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun50i-a64-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-- 
2.21.0

