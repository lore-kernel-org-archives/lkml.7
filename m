Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62345C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA9420857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hjk4OJ6P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvS7S7Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfCBEaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:39 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39837 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbfCBE37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A34C121C82;
        Fri,  1 Mar 2019 23:29:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iyNHX5bab3Lfe
        AAxywZMP6Pf+JBDMgU9maMkQ45NjMk=; b=hjk4OJ6POVLyUPslwe7Vvj4kHDAES
        xZ5TQbvhPQTOhtYJImhQynTYGUUgA8dzlSFEdeXbe1nCaK0YQs9EwNh3dY0RB8Tc
        caItwbz2uUsJPpLKygO1qfFGCaAqL0kQE6WiIc+sKttiYBzqO8v2/7wBC0Dh6cbF
        Y96yjSYeCQ0yzERYdY3gp48qGbqXEctYypte7m5oS6xdwm3ft+Oc1QxW5MnF0EtQ
        TDdvzG2Zv3ptTITeB5Aw7t5NE1Aw8C98x7r5iB3qtFsaGYQmIucbp7Js/QEtR6jy
        kzUbUxTJ26p5QjokKEX6t6Lp6McDl7bxgjI4gpeqJJve6zxHWaUjaQHFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=iyNHX5bab3LfeAAxywZMP6Pf+JBDMgU9maMkQ45NjMk=; b=PvS7S7Yc
        XPHkAo4pdMq24igXGdPaz73XaawXCVwwvg39r7FB+xOcL6cK8vwKCXV1TfEwCV+7
        6ZaF6UEyv6XMTGJukxiiTdMeCDzZyaRy08YAB8OPkURUQK2NEK2urjcb43fmFFQo
        N7Csha+6dL9t/oN+7MqVTQrlYTvt8MbH1ZGW95V6Dzh4iLyYPryAbfJI5kzqEKd3
        /x1tyY2Q9qzcWsk6X/2rDBkYxCr+J0vAdn0943VxTJWNJJh6wA8Eyqs+F6OetvDC
        dcTchkSw2089+rwVaJWQiQb6gLTceUuKRnOG+1Q00TbCjGJfEp2Vft09p1XNU3Eq
        lX2SmY+ish5K9A==
X-ME-Sender: <xms:xQZ6XON16BTLr7mt5tlbh0306PCGg6Th2ABpXy_PmTMlDfPcsT3z8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xQZ6XBMZTekxXT86t8sf8S8H5xkUfvYlxm2eixAuQrpAp5127cedAA>
    <xmx:xQZ6XASsifMx0-IXCrJr7VJLybCz-CuDwOnogL_JM5VUVUOT6-5H9A>
    <xmx:xQZ6XDDf2HxuWPCuhSj1PyWGfPVpINae7Qm0N-gki_13s8It9_tDTA>
    <xmx:xQZ6XHJ3JMVo1WNnsO241R8_RmsAKwO6QoRccdtytuyrqhHd9PAVYg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9C1E10310;
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
Subject: [PATCH v3 08/15] arm64: dts: allwinner: a64: Add msgbox node
Date:   Fri,  1 Mar 2019 22:29:44 -0600
Message-Id: <20190302042951.53671-9-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
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
index 2abb335145a6..29ee8f0f833a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -447,6 +447,16 @@
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
2.19.2

