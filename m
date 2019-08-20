Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4EBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B89222D37
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Ahk34iBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljXfDEV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfHTDXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:42 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59901 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729032AbfHTDXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8D1CE3543;
        Mon, 19 Aug 2019 23:23:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=iCw2E9iDZfqG+
        Z2bVssCxeMbPHJOSeD2lC6j+oVPq7Q=; b=Ahk34iBTRFhvUNc+u/aId0W4Pn5iy
        jQAadr5amH8prlgKl45cq2h480YE1ty9GuExZDKv/gVET6pY4oF5AKsyZLR1GFHN
        U1sV16d7TTk1W5wf6NPmoLVqgggKElXRMuRrMkFliCWJd96zUHFEW4p+8JKZHjyy
        myg165rGJAgyerNvVfjK45Nh/j0bD6bSeXpJjmKW1POTlG/2obvCyRSL6Lvu06OR
        SO7PRVKIeytWnEDAWiKh1cxNIhkzJ/iyZj7N5ElFTXkL0lhV0Sq+UziA0dXVTx4P
        tUT3t/37NRl+AmeiwWFYKpQc8EI12VvZOabuqlvBwzQCcHZhx8m+j+++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=iCw2E9iDZfqG+Z2bVssCxeMbPHJOSeD2lC6j+oVPq7Q=; b=ljXfDEV0
        NGHC/hwrcenaEp9QvLzUyFu9PBoiRZ6HozmatnCCmUJ2hio6xrRtCIFxcWoN1Qn1
        bndt0UgeyhfANSJ5yFI8P+JVpubo/o6Xh8dL5g90HPcTonxSCCeDA3VxvMxnXuf9
        WlqqDGnX46EkXcVKu5tNbo52GTjQyl/dnGCu+wACH/qUk++8/yYt+EpLOmglc5yM
        fNCmX8bXfmGbyhvmHWdozJUg6ffE4zvda4spY8sZC4wf56Duw7aQv4z5sLeCHOg+
        +mWR8E68Xq3V8FaeVFgPE/QyDCF5G6zrY3EGPXbyV0QxQ3FkjRv/6kbuSNmJSTPH
        vKm3LH9Y42Eh2g==
X-ME-Sender: <xms:o2dbXak-3cSu5-vreBbf84dwAPYvnJsDvOvfnGiNwg8dXDDQUQFYcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:o2dbXZl30ZkMcZipw20NzrHnxf5FTWxScCwzeMQeaDgIMpT9tQSsqg>
    <xmx:o2dbXXOIIYKknhQW7qrAmr5cGG4ep5r3k_bkPV0-8MQ62Ash-djQgQ>
    <xmx:o2dbXY5sdQaEWCoIhXEgszGkFYrMlsv-wz2Vruh3q5JEPM7Aen3TUA>
    <xmx:o2dbXV_AmF4RBV00_b-qm7P1CurEBQqINyiZFPkFMP1ItMWkDrknqA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6725680060;
        Mon, 19 Aug 2019 23:23:14 -0400 (EDT)
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
Subject: [PATCH v4 05/10] ARM: dts: sunxi: a80: Add msgbox node
Date:   Mon, 19 Aug 2019 22:23:06 -0500
Message-Id: <20190820032311.6506-6-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A80 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index c34d505c7efe..844a265dbd0e 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -318,6 +318,16 @@
 			};
 		};
 
+		msgbox: mailbox@803000 {
+			compatible = "allwinner,sun9i-a80-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x00803000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		gmac: ethernet@830000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x00830000 0x1054>;
-- 
2.21.0

