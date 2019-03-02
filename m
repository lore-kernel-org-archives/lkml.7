Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210EFC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90F52085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="oVH2LJ/i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNw6ne3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfCBEaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:00 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57233 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727938AbfCBE36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F363E22120;
        Fri,  1 Mar 2019 23:29:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ecURF+ayLWpY2
        Oe8w1vUiDRoINN11ZW1ygsWBjCaQUk=; b=oVH2LJ/ipR1gMiBgO00vqnOzkP+nK
        72eo4L8SKc0JJ5STMoJAfvnwoUO4nFKXc+kjsxw3GFTbr9xKQ1nHHqny+oIl201o
        lwUyhNU71i9H0vFJ1liAgbEcSzPncjMTD6DVxTNQiZTjpIy4LjKzcypcUzfEWakH
        qTuQvr3dQzISyQ6a0uRUZWRdb2YQAAgKIkIOmBhi1ZfrUrxBd09IlyET6OVsgq7u
        /HdDWBNZl/UfoK73fgD9RpM4HS2ZxcU9JbjDrwBrCuzWqT8zvdA/9EzPbahfFV3o
        uG+d6p95WDS7/cYMtaeKyKy2DczUh0yoH5Ud+KqF7YzdVa69ScvaByqZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ecURF+ayLWpY2Oe8w1vUiDRoINN11ZW1ygsWBjCaQUk=; b=tNw6ne3n
        lCco5DuCmmp4woeo+/EN+sucysrvnYp+HPC+exsQejqAnb5Ui/wzaQIcwmdomzKU
        q/Q8BGSj90Q3Se3GrfR9Ack53V+VH4e/e6m07kd232P7rCGmbe/exrL0HIrH2QYh
        Y1xKr5HrhlsCV1f01lHiPnxi14X47VuqDhNyVt9ijJ0F7rqnnrX1SWyN9CS+qXeD
        HtF4LWIuz6yXO6YBCP1Kdr+Zw/SUonYkRBVa2zayVSck78h45tuCJgwOGnaKeVen
        sB6ewc2zoZUaVHiDx/QsNKqjXyjIUIuiCmkJLkgoqLCofGHTq6HXcs3Oy03gJRcp
        yWNf5ra1hRQgCw==
X-ME-Sender: <xms:xAZ6XN_0J9GSLbAn36NTsOKqTzpgehz2txkvtUVJYb44SMQWZ472RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xAZ6XNMvqrYWASUqNiSdkHU7kUnYoe65MA2AreMyOgllizBKIozajQ>
    <xmx:xAZ6XBcZk0NFOgesxagFRCHlVsmTicS4QGYsX4QPSC_a0t4iQH92ng>
    <xmx:xAZ6XMUVdjYtK3ng_5rvArH1oJpJZn3X1sonw93JbRu6MHGwpoFyAA>
    <xmx:xAZ6XPde_6r-ax1FgTBohqmHhfq4RgvAKJSjJ65ROtvl1FrIONycgA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2CD9010312;
        Fri,  1 Mar 2019 23:29:56 -0500 (EST)
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
Subject: [PATCH v3 07/15] ARM: dts: sunxi: h3/h5: Add msgbox node
Date:   Fri,  1 Mar 2019 22:29:43 -0600
Message-Id: <20190302042951.53671-8-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
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
index a4c757c0b741..a42fd3f9739e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -227,6 +227,16 @@
 			#size-cells = <0>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-h3-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
-- 
2.19.2

