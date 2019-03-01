Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EBFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072E32186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="KY5L/Yk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0JxeBd0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfCAF36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:29:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42897 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbfCAF3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BC1932208B;
        Fri,  1 Mar 2019 00:29:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=iyNHX5bab3Lfe
        AAxywZMP6Pf+JBDMgU9maMkQ45NjMk=; b=KY5L/Yk/YJ/z19zhJJAKx8aGAbpCd
        /wggZt+7Cyd75PPZA8iAGo/sZUIQxu2nh07XAU4Bk/spoAfwX23tbcB6e3oJaN5/
        sUc9jwnno9bWB/+u9GMLJxuEpn330f+CouHSBJEWZvBPasP/MZ5c40/nb5YbOkBU
        jnHz5d8Inoeq485kIt3/u7W3Iy3BqiOCuan9v0hYvVDN47qsxLvVkkVpCdzI8ZMc
        ahH6epiewODZ96qyR/2593yrb+jtsvoOhipsmJohjFDLnsn9VNHI+H0y46LwzZI2
        l4nHV3THpNK8MQU7uh0Nt8+6P/4U3m/jGXhawd+4XJkOITyoDe5QZ55tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=iyNHX5bab3LfeAAxywZMP6Pf+JBDMgU9maMkQ45NjMk=; b=0JxeBd0t
        g6oripoXyxvKrATCgh5COlshkPhFfxPqb+lE4YsqO1225K3I/NILhzZ87e+4JJXk
        br/pYKGiGoXvpNhGIkU+coy/EkQkWzn8NTteOVhfGVkUMxLH5HPyqOXELsWJDiX+
        fhs3M8XZLiTxGVcc1qxeXhBedBxB4wQr6UEikCnsHKKp6lg6DfJ5DLBcCIs15p3w
        AvkggsK40Q8jI92ioSHdjGj3DK8WrWMVCSrrxIrJ/IzwvUD2mvll5bpyXZpgWeU/
        adHvcSR8dTx7kvmCoDU18LzbYgoxYuretb3zrr32rnDprvbcKqmvlwv+deChoji3
        R4kZiBhM2xUp+g==
X-ME-Sender: <xms:UsN4XG9fYPzzdJ_8tIrk8AU723DZvxoS2wsVcvHKIJDkGUk_lJf1YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:UsN4XG2rPKry7Um8fcsY4bivjmgauXhjyT2xfJzLyZybBHqOS0oPvg>
    <xmx:UsN4XAK45g3UzP2be100Spn5nnu1KQPbzmZE1EW78cmZz7dj9d0nYw>
    <xmx:UsN4XG5tm-GgL73KQy1aGOUpo11qzEgrSBeBjvjUjwn66427CPF2IA>
    <xmx:UsN4XJPHUdOCMFsjiCus16WnHUi9WqE9YAeiV7YATvsnU0bMEL_miA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D288DE40C1;
        Fri,  1 Mar 2019 00:29:53 -0500 (EST)
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
Subject: [PATCH v2 09/10] arm64: dts: allwinner: a64: Add msgbox node
Date:   Thu, 28 Feb 2019 23:29:46 -0600
Message-Id: <20190301052947.32032-10-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
References: <20190301052947.32032-1-samuel@sholland.org>
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

