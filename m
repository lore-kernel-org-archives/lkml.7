Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A203C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D1924671
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="HCuIys0K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzLWb1oV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLOEZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:25:18 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60083 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbfLOEZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:25:04 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4E96B5AE9;
        Sat, 14 Dec 2019 23:25:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=b6HojHijxWb+y
        5XleJvk+mLWd4R6gqj7yGjWhlzWNIc=; b=HCuIys0KuTmOuDOGPeH1i5uklfFtJ
        0cPQbfJmG53IwKJpiDhN6Rkrw5BdEWXgt/bfqMxVteVzW/err946kNpLsprx8sZN
        KNzI0l8v4w0EgeiALxeL4vvEMbmz7Gxt4td7IT0pypjb6tcp79N7RKupFpNK7EaF
        P/CmXLNWjfziSeADmr1fDhIbfpMO6VXZuuUWjSIDtRkf7/I0Z8ejbxHVFqItELqJ
        U4mWJBJpGmMX1sTeYlCkoYvh2rLuEkMF6ReokLQzgfv+zRdBBIqVq+gQ84FMJFkB
        t7kpkuqfu57aynS2wTIgXf7LMLXGZlbOVBxURIrxzcxAna2wL5Qs4mkTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=b6HojHijxWb+y5XleJvk+mLWd4R6gqj7yGjWhlzWNIc=; b=EzLWb1oV
        R/IT+zv7mmdIiWf4Ne9Jw6b6kG/JK5wV34ldDiR0I1hhilVQqbZwznORkyb8J3kl
        cNeiU4WKKAXJM6Ac2IkJIe+bYoJ3D5/qsloyXSF8VVHf82rBIiPYGK7qSmmFY+BG
        ee0B3zWXpi7nBhjCHeMbykgowa6Bvf7MnPtc5Z1fLXRIOqparUnJYbZ0XeixPUkk
        e3Td9JSkJ5mNbZHQELxsio9KZr6MmhDylHauLNpklGLhNQmPfck2rl9Y9Pr/g/Ou
        S0hyhK9DWp0kJ+m28c0xlr/RIyaAIg60EYAedv+alYCx1nHhbd3c4jdGeBhXzK5m
        /9XPJIYCDR/WJQ==
X-ME-Sender: <xms:n7X1XZnGGCNl5aNUin-fHyezI3e1aOn6fmXgi92TMYXXZoxrl9-VdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:n7X1XalNUiokq8tv2nhCBpg8T7Vi-4dCg2aGeEUj_0UdxQ4zU5nZCg>
    <xmx:n7X1Xds1oPgAB8wKLD0CBnXYuuN6pMjqk3dYuabyL550qoNU_t5Kyg>
    <xmx:n7X1XUKXkWUzg3-86Lp4B44SPWUkmSlhXgv4r1nWBCDjtHR1kp-1Mw>
    <xmx:n7X1XTuF4PovPZZzfHh5emB3_6CdFT7xUu15P285jMtoNTx-E_MUPA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 614B78005B;
        Sat, 14 Dec 2019 23:25:02 -0500 (EST)
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
Subject: [PATCH v5 7/8] arm64: dts: allwinner: h6: Add msgbox node
Date:   Sat, 14 Dec 2019 22:24:54 -0600
Message-Id: <20191215042455.51001-8-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191215042455.51001-1-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
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
index 8e5999cd08bb..70ee56ba2091 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -240,6 +240,16 @@
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
2.23.0

