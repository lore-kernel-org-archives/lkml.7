Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6995C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1F822CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="yIWnRhOL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/dMsXb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfHTDXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:32 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35461 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbfHTDXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4CF33354B;
        Mon, 19 Aug 2019 23:23:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=WJsZIeOZd+wep
        q4QNm5ZX0jhjKc7ewjmZ/86SrygJyo=; b=yIWnRhOLfGe2U4lUOoB0rwiabnJJX
        YYOZajdX525SVoLQ0VNTUrDtwGoxxb2tCRxQzvXpg6GCmLYPcI0wVlmimsbqb6I0
        Anre2acb7aHR33FlpLKQAd4tcrmuFOQL/3D7U9DK0oekBLKXb512lZi/o775owyW
        S43MiKQCB0fZcmvofug9kxQbfs0JphvZRN4PQo5Sria2MtEhqwLlwsT1svm6Fx/x
        sOrZS8dobRBEVW7QtudLMzmreVptp1EWmhzFZevEYiA+7VN6+zJ0cGYUPU33ThQz
        dfcLpRyJ0IK7E0e1dUk+0uQE2sZNb8s35aE6m6hM8SVG2rxp05S2hBz9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=WJsZIeOZd+wepq4QNm5ZX0jhjKc7ewjmZ/86SrygJyo=; b=o/dMsXb2
        xo6003waPeyz9HcfzzBDT4gwwiwICkTJGz4ilqqW5U2pZgup+s1ace9SmAaKZiSh
        qbHa2UEw3jAEinT6OZswh59xkPGbnhXmisYKJD4H0iTHucFplWZFq/NWWMN/gk9v
        19O5AVCAvxRC+cuaAhYUSRjZmENnKD7Dk2BXqTQEPtqtzozqIRQ3mxmy4pO/jWli
        4R9LHMrUlHc4tQF07+MaT/7DIzhuzGEMkatZxE64+pGTUzk9rRnqtIJB82TWz12o
        3oan1kgZ+W2JbqiHlsLJpzQSZnhK4SDK74SrYlFhp5G83exa9sq+4dfJiiGEBkVB
        P6kdVDyQS/XPoA==
X-ME-Sender: <xms:pmdbXb2RegGIugcKSqtwe3aDEMckRmr0A_4WpWJtNobzpnEDYcTdPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepje
X-ME-Proxy: <xmx:pmdbXV8qX9xJ1ROPCwK0QTqnA3MhgLEVNrtVRmOYHhWNfPXsEcSguA>
    <xmx:pmdbXXZLPs82Td8PNAxldcyy-4VdAJycxzzA02SES3AtMlyt8mMNxw>
    <xmx:pmdbXUwPjW3UtN5VCBS5OSDhdV_6fYt92JK_N5rRKmO5Rblsm3DqmQ>
    <xmx:pmdbXWeDrRVYRKPRCa-C2v8wqAZnvElx9ze_dpSNpU3Z3Nx1aZitlA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6499E8005B;
        Mon, 19 Aug 2019 23:23:17 -0400 (EDT)
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
Subject: [PATCH v4 09/10] arm64: dts: allwinner: h6: Add msgbox node
Date:   Mon, 19 Aug 2019 22:23:10 -0500
Message-Id: <20190820032311.6506-10-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H6 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 67b732e34091..2ff6a47e3cbf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -215,6 +215,16 @@
 			#dma-cells = <1>;
 		};
 
+		msgbox: mailbox@3003000 {
+			compatible = "allwinner,sun50i-h6-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x03003000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h6-sid";
 			reg = <0x03006000 0x400>;
-- 
2.21.0

