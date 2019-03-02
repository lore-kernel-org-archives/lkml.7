Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6114CC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EADC20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Pr4v+xd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKh0Psgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfCBEaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:02 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54715 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728007AbfCBE36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F7112212A;
        Fri,  1 Mar 2019 23:29:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Gr5g246E7dz+0
        fCBoecUgP9DDbmhuNrBYG7SlR21RAU=; b=Pr4v+xd0cLSFVlI3Qqz8McAQTREtR
        JTVv2Uth3r8X87+0aeA1rFSXmEBgX0G/ykXwXhuItvGJIhVHJ7RjlCpgroU5YWW7
        ouMV5trnLzL1tzhd0gS4kFvsm5PX0fAjT7e/Y2Z8Xz027yqjxQERuFmQQvWFkgD0
        O+IHtQKgpMXrTyCc6jq7vvKRHefxQfCw2bz3YHVqVevrPfGzEHOgjHNYDpWEBx5K
        PemYQwLTf1l+ojfqW5k+io2mz8hfTLWokJzMbysEdUIwAZoTVpLtPKlu4kyfIQlb
        w8GikQk38ls/ccIpy2chDbyTKoUUDOGbkGQS4QNEH+8H8JWkJJ3J3TI0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Gr5g246E7dz+0fCBoecUgP9DDbmhuNrBYG7SlR21RAU=; b=bKh0Psgu
        JgIFptmFFBqOxI5sqBKmJ597f4fIbYCgAzEgKKMdqgIe9hrD9U3b8KCndwBEoZzE
        73r/NAtx4jrspBzeBe/J7l2nOkdRLG86c88GL1Goqq8rrN1PrhRB81orl58U4ilf
        0+QJqV/HktUYjGw+eGswDUoKcbxmZGxkJ03IJcRdN8Sx/suuukvm/Aj87BIMM6WQ
        ej68o626Pj8iuq+rUrbwzPcXd6QTPQrujTOlrbr/BvzI8rHweNlOXzek8G2PyiIP
        Rtig9rFBH1cqKu1tQITa91lzbdZVw64/RMiXWCoyi31vxHyCHxK9te3g4yMl/g7t
        y4V5Z3hHK09WrQ==
X-ME-Sender: <xms:xQZ6XP08Z0_1onEpLsWY1BRaVO7YmO5BpDO_uXBmbVg8JF1SpHHIZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:xgZ6XFuh1qLV-LkLkxk59vIfOdjj-3OL59VKkhiflJmehW5znmtUhg>
    <xmx:xgZ6XNhwp2KvtBX7kJUb5VKx4gnFKjBrZ6a9LPslNhPVJoO71FPcUA>
    <xmx:xgZ6XO_ZWVtxIbNm9512UpFTEMKEuPbfifJ3FlaQNZi1kXUamrX1kA>
    <xmx:xgZ6XIMujC4BWFBXCXfni35voD3yIYWsa09xH2Bmtf3eA8E3LR_zYQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F44610312;
        Fri,  1 Mar 2019 23:29:57 -0500 (EST)
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
Subject: [PATCH v3 09/15] arm64: dts: allwinner: h6: Add msgbox node
Date:   Fri,  1 Mar 2019 22:29:45 -0600
Message-Id: <20190302042951.53671-10-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
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

