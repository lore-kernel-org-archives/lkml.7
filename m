Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60DBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936332085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="peiMb3+2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3EyrfDdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfCBEbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:31:07 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54715 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727870AbfCBE35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E00FA2211B;
        Fri,  1 Mar 2019 23:29:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4sJ0QvbHFrHgY
        YKLnD6Nl7ke1xODL6daE8lQX6XAObc=; b=peiMb3+2WoD0g/wc1eQNoF3kLk5Ww
        C06hYAoJ9SbkyjoO2ckNX4e57M02JuczXxR/kpSZbpgLYI0WhP1PXH6leIdfIubq
        6bVQYRCdwAW8M/rXgvigdggZ/qmLVZ75XnlAG4g+fGEqaAVoJdw7/kzOrxWHTJAf
        wt+VTRjefe0Vmb8BO5GGwO4IISxvrVGqihQqtyG1w881PNs2Fl/PM3vaJKbFCLjM
        rFIwqgOxfQX9xAoAihmeSu6Fh2+FTZ4U6AJ/RXz/Hg9h4tyYJ0LudUeVjYhG/oSV
        xUpGnr4OKicZQu6XamKjnKUYPl6Ka8FdOAqf7KDjISUvL4ZID3JOKII7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4sJ0QvbHFrHgYYKLnD6Nl7ke1xODL6daE8lQX6XAObc=; b=3EyrfDdw
        C5u2auqqoGrjTPgs+6Bc5d1kAW0mdL9eZhK6AhVdfHVZcI2KbDSAhorbNvYfJlzo
        BqLxrSNdHMf7T+xXmNdY/XrAE9O9kgfd0F2jrFS/MQ/N1fdFUctXXIJr68OvxaOG
        dCzQ64eJMuREsqk1Oxtfka6MO5Z/cE1N8jXgbFK3Oqw7LgpkK3L1mrMfOY04IHpi
        tKbEI4GV8j0yrdyx2FF6ve6xoUOCB6dJQTbX6HAHQId6WJluMK6N/up+x6MWsWcL
        TFCacI+FIT+A4grhB9eC30iVP/pKGi6lOK2ykJjwkCMvuIh0Grgj+BVlIGfkmFmr
        FsCRHaUo05b7DQ==
X-ME-Sender: <xms:wwZ6XM3Y-hDZ938ShbzM4O7yXNHLnKwjeWrDwgW_MQoCKI9I75umdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wwZ6XBqLfKoqLZSSvqHsM6wKF-qOxE7aQJVKHcKBUKTlwB027IqhOQ>
    <xmx:wwZ6XBekGB37_E9oKyopdXBAM1UUnVrocR1Z24hDqEU4Td5nYOVZEw>
    <xmx:wwZ6XIq9X2v5PzFs_EHDVFO3I_CLj6-9W1qfo9TS-Uwcpy0k8Tq3aw>
    <xmx:wwZ6XH5B9m7YJ3TOP4xdsGo7gCwx45LsExeqL6tmsN1dEmzJKV8gGQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 05F3F10312;
        Fri,  1 Mar 2019 23:29:54 -0500 (EST)
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
Subject: [PATCH v3 05/15] ARM: dts: sunxi: a80: Add msgbox node
Date:   Fri,  1 Mar 2019 22:29:41 -0600
Message-Id: <20190302042951.53671-6-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
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
index d9532fb1ef65..10e878f94fc0 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -283,6 +283,16 @@
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
 		ehci0: usb@a00000 {
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a00000 0x100>;
-- 
2.19.2

