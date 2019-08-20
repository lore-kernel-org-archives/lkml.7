Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A08C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC7C22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="o1Xys5oz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7uByfs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfHTDXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:36 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35461 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729075AbfHTDXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 69B4A3548;
        Mon, 19 Aug 2019 23:23:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=da/HA5aDX/4ws
        o/bGdIpUQMMjVTdDBI9MxYlR95dyfU=; b=o1Xys5ozKYozQOOKg3kxuH3Bo2Kph
        YBJQayYXzdJK1upxZzcXlbxsPU87i1k/BiMPS98DuV8lcfudZKYGuWrS8rmwdRde
        j0dqN7oZBssq/3H2SHIXgBuw++fO+46m2cRLGSSAYHDQJ4kwCLbUHQkXSW1tMVtE
        ct3MmUDMK9FytRE+fyBh6mpzcSrxqfrgocJKSYhaBKyJIwRRASCyY6NBuWlTvZ/G
        W5YRj5Yjk2YdxnfBsMVP36L3LbXBX38ty1tY8E9s5+XuFxPLjb8hidBj7g1KXiDD
        6lXVhhYxO8fWaWBS0PUGg+2ALQKKQ+mZweDk1ut6Ni8S9WLsQ8uEYPhQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=da/HA5aDX/4wso/bGdIpUQMMjVTdDBI9MxYlR95dyfU=; b=S7uByfs5
        nhUVI3FGD62ykjkHVYDg7Xxjcw/JXsdr5kKFQqZTUSJIOxqajYEHtiQe2i3+iRNP
        mQpi8GG2RmVbq2i/2k1BgMzx2DXy/GEXwA5i9+2yeoJggzYcrLMDlt7AWrYDCn5g
        CksamdLIPOTo80tgzyXRuUtfP/+HV97iCNx9m5OgQMiB0p8t1Eh5yf7wzdgaiu05
        kAKasSWMWxy5XNHYC82hYzcR5TDM+mM1XCpmmv3LnBz1zdOZkM6TxmXqf2Aobz1j
        fVfuvWVwsXIRbLIpqLXDUnQnh+ftyQrIUthcShiV+lefO8YfCVSduUqx0BxturzU
        xDWglcr32/Yqfg==
X-ME-Sender: <xms:pGdbXZG1-mphexTWcWq3wpAP9yGWJO55qSipX8KK_nTicflmIiVtnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:pGdbXUS2e2j9rm3R6_7vg8mxSdeDA6gEb4Dc2q-fhfRSQGurFbnKRQ>
    <xmx:pGdbXYRSiwY5CHefTTspo9Hj5ikhh1Zna6w4LUUuJz24V7a4mxQ9Tg>
    <xmx:pGdbXf3EDhjO4uDCPKInKNu6bVkrlAvCVIsiT1xv59F9f8iERWXMfQ>
    <xmx:pGdbXRHtmD82LjaYZMV_N9yFl0TsRQIicDmiBXBRYDdo35YHjrV98Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 523EF80059;
        Mon, 19 Aug 2019 23:23:15 -0400 (EDT)
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
Subject: [PATCH v4 06/10] ARM: dts: sunxi: a83t: Add msgbox node
Date:   Mon, 19 Aug 2019 22:23:07 -0500
Message-Id: <20190820032311.6506-7-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A83T SoC contains a message box that can be used to send messages
and interrupts back and forth between the ARM application CPUs and the
ARISC coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 523be6611c50..8871d1aaf7f5 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -583,6 +583,16 @@
 			reg = <0x1c14000 0x400>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-a83t-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a83t-musb",
 				     "allwinner,sun8i-a33-musb";
-- 
2.21.0

