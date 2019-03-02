Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57DAC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEA920857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="I7xfKX7l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UO5PLq8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfCBEa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35099 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727923AbfCBE35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E3322211F;
        Fri,  1 Mar 2019 23:29:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=0E3xQubbqSzCI
        eQmbqeab4IA+YPmZG/r+t8YmeooEPM=; b=I7xfKX7laLt2tE8RcMfKdntRfXN4h
        yDK6RVNt1A3EJzZewNDcyfQm0fw376VJwaLWWnTJCzJBaEwo/hjOv76NVq1q45Kq
        pIwZl9fM2K/6jU8EbD2QppWpX6J0PFBpe62prww1K0lBWzdzSPy1NHa8I+yzFgHA
        GkFYOhE1hoVuXNCDEJ0MMUWDfEu2M3Sg5CjoZ80FTJ5QrjwLqONtiiwTAj6cRFD/
        pEjdnH2zT+88JuBSOuDVEX9DqShfoPaq8HPmu3yRY01heAEmq/Ws5VlodXrLcW0U
        Osza51Md71+PUbOn8PtTmHg77RccdDgcPCOgXnt5gACUCkqzoEjVB2amw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0E3xQubbqSzCIeQmbqeab4IA+YPmZG/r+t8YmeooEPM=; b=UO5PLq8f
        fzRWNZnJRIFZ7qN6poKe8mVPJoUCgZXX7Du+ZkmOFQjBrAkbCymeOeELLJxERzap
        m2XQUDctzR+qZi0bvNgXCCBNUe1yx3z/WsGhyM/XVDpo1vSuE51Mh+9N79P/D7mh
        Dal2MZOo/DJARQZY/HhI/Hju27oxBEGP1LLek+SytGhI+E2/oLWblD3uCLdFpT67
        SOfCQVUA+h3qVy1TY6aZrBOeK6ripfgue/AthBREaqAZkJfWw8AOB2PaxXSOBaIx
        lxXJkQO72gZvXcDsakXxVSeXPSlBClO4nrCYyQxXUf+hJN/HasD+6GzsMDaWnp67
        k3M6KdUpcXQQiA==
X-ME-Sender: <xms:xAZ6XAUKJncthiRUgNB-C4ZfT1bmIAo-Hf971TA2qWO_ePdEs1VjoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xAZ6XI238xuttJjjHauOS2rh4zQIMZCADFXjT4jjEe6vt_4SDn5udw>
    <xmx:xAZ6XPbBVBvlzQwagFAZH6lBaA5NEr5lvq5qPYlhy0GBfyh-JoGENQ>
    <xmx:xAZ6XDqjIPsmmmgPUVenM78L-mnjtz0oW64zT1L6dpXfZ7uSYFI2fg>
    <xmx:xAZ6XPxRbfkjvB6tdoy6xq8A7AAIU0j1IE85BdVoEj4yOK-LYjhaoA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 951CC10310;
        Fri,  1 Mar 2019 23:29:55 -0500 (EST)
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
Subject: [PATCH v3 06/15] ARM: dts: sunxi: a83t: Add msgbox node
Date:   Fri,  1 Mar 2019 22:29:42 -0600
Message-Id: <20190302042951.53671-7-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
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
index b099d2fbb5cd..c80c4f942439 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -546,6 +546,16 @@
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
2.19.2

