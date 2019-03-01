Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783F2C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB1C21901
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="bcf7qBZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3IB6M+Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfCAF37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:29:59 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45345 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfCAF34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4AB9522096;
        Fri,  1 Mar 2019 00:29:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Gr5g246E7dz+0
        fCBoecUgP9DDbmhuNrBYG7SlR21RAU=; b=bcf7qBZazL4p9/d09qTgDVyfx63Ct
        zOYeDpWE7Xrjjq1ydCV2KeorqN1I+8YGWrzlzy6uqsCCMFEpu+lqiEtw24Kjsmxf
        KdTJ6HgM2WfjqOXbhleZWxIyIn4LMm9hrW2xnpkwf/y5pgGNPl66Wsmjkj40yNMe
        eVzmMFhOvsax7tEXHQUDO2a9vHNPDI99uxbD1g/UXmgJ2sijQFqFF3+cxsVXvm2+
        w4RbNT+5TbCH7fwmdM63eHSE9Wjc1wcVCJV/FyQ9WjekZgFnwWodr8UsuYxh63AU
        1aCXbZFbPWZ+qpGSAFEuiMeD4x6Xpla5cqdI9w4iWNrlUD4oaVzrsekxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Gr5g246E7dz+0fCBoecUgP9DDbmhuNrBYG7SlR21RAU=; b=3IB6M+Qc
        OBK4XV059Vl8F3uIBGKayIIkfON7IU1LysExpNVtzsmqOl1QeLHcDcZsn1hThb3x
        iGyNXo5K6rkr7M4xw31Rhpt8lXvcQQtUReQEtp8cg3f1MHXo4V5ENXlhoYPniX73
        WDynuH1NcMV8bxhBnYPyR2jeHIXFt2f+FJxhvGs76ZbLZVC5EtLFdx6YmbIOrqRH
        JsJPwaWRKH4sqD2EFsCKt0gvmz3ReQtgUgC/qRnFVwFEjlxYjn5dP7bcqAWIrSIK
        Wna325267B84Bss3w8CkLxZGcwOCfTnxGxjILJ5igVE0K9ouOJC878K37BNYxyyD
        dkjQVkDal1HT8A==
X-ME-Sender: <xms:U8N4XKCIoy2S6htyXckN9ijgycUe0X9r-krXioNZ5xHINscBmDLL7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:U8N4XBQWRq3m-cJuKyEDApIJlU1lj0K-apX4boIBovua3Ct6gKC45Q>
    <xmx:U8N4XNIoPznKoQNSt3A3xkEi7xk0idptjdGyYOe4trufZi7xu_4AAA>
    <xmx:U8N4XBZoja_-NaHxNRGXbPASHIcD64hoqovXTmnub4jMOhl8sPS94Q>
    <xmx:U8N4XFpn8TX43tpH73BTwTbr4gAhgPpKdE30FdQI9swsb9f1Lih3mw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6662CE427E;
        Fri,  1 Mar 2019 00:29:54 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 10/10] arm64: dts: allwinner: h6: Add msgbox node
Date:   Thu, 28 Feb 2019 23:29:47 -0600
Message-Id: <20190301052947.32032-11-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
References: <20190301052947.32032-1-samuel@sholland.org>
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
index d93a7add67e7..950681b2f7d9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -189,6 +189,16 @@
 			#interrupt-cells = <3>;
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
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
-- 
2.19.2

