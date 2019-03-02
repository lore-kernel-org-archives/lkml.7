Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C19C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E42086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="h0eExKGh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoPqF77W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfCBEaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:19 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39837 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728100AbfCBEaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:30:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 19FEC22158;
        Fri,  1 Mar 2019 23:30:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=9acILfTnwSiDO
        KxTjEmIxA9/egLaSc8vNg9Rsf4kxgs=; b=h0eExKGhaVNgqPbGKe99EXE/Cyn/5
        vl71PtOET1cxTBeXzcjR9gHzotlJWO0UDJKi6c5Jit0UlyuiSbBV5nGTjtzeBd2S
        IZlvnUnBOS3rFMqsewpIZE1dfHfStkjdzy3laKVSrkyem3coS9PMuiNdxeFfbjYL
        tWs8zJiie6xah55NM51QNCH04f0ESWdPaTCsOAhpgtQNOJS532LcRMrzYpE3HNIg
        Is6A0G/9deFUGy3fRPamwsW0V0plZZ0sDpz3iQQEjYFDrBN4gFezpSVA/hz5eq52
        hWBTFi33ljMs5jBEFqaIKK/TAWJxMY8E/CuxhiyYkPhaqAmebmiMUrPNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=9acILfTnwSiDOKxTjEmIxA9/egLaSc8vNg9Rsf4kxgs=; b=DoPqF77W
        taxQDN4m2km5TOipMt3x7IiWlOPXv8dsJ2jWletnxK1xHN73IsYcNnSjFAFEmE2P
        T1+0nAy5bkRM4Fm71BjgKBt6CqNwZ+hDXjTehp8ZCKKzQ3XC3FtalLQuwutsuuXv
        af4qSUEvmjsB0p2pNJbS6eQ4JIhn9slIjEQSiKFl10E+43zkY3BUBu8E3AhvMaxd
        XTR9gL3RlFOM+GSUMhc6brr8lXmMzD1Qyo3T9kmj4ui6Ym176E3QLQTpXCr5fNvx
        wRW+1ZoBg4ubstqpqut6hVAUhdzj6EmSMOGV6xuP125sR5TtN+gfAbuU1RwWNSa5
        DriYmTe4o62SpQ==
X-ME-Sender: <xms:yAZ6XED7St2KJDz4gSqUIm354OOeJaWvSF9UwIJ17_lqUs5Cmb0jIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:yAZ6XMTC9OgMTbE-9KbsRQXuyn9V65ZmiCaGfqyaAlMIVang5proOg>
    <xmx:yAZ6XFpU5ncKqGerj6MXfxaJb4Ot9bX5VGR5b78zSg2aUTyv3hR9Wg>
    <xmx:yAZ6XFWt5tSCAmlI_flaafBKOFPC0r8VGZizA4oU0OaO4B_4WM_gXw>
    <xmx:yQZ6XBuaDPUgH_wH4IbfSnsvNEtIj8pXXC--pZahzy9UB7z_k2XMaA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2D2D110310;
        Fri,  1 Mar 2019 23:30:00 -0500 (EST)
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
Subject: [PATCH v3 14/15] [NOT FOR MERGE] arm64: dts: allwinner: a64: Convert DTS to use msgbox_intc
Date:   Fri,  1 Mar 2019 22:29:50 -0600
Message-Id: <20190302042951.53671-15-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is an alternate way for Linux to receive NMIs from the
PMIC, replace references to r_intc with references to the new interrupt
controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts    | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts     | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts  | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts        | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts      | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi       | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts       | 4 ++--
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 6cb2b7f0c817..57690fc3f65e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -78,8 +78,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 9d0afd7d50ec..0d5693710cb2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -214,8 +214,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 31884dbc8838..33d89c2d7b60 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -179,8 +179,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index f7a4bccaa5d4..6f9da1cc6c79 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -169,8 +169,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 		x-powers,drive-vbus-en;	/* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 8974b5a1d3b1..94bc6fadc58f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -186,8 +186,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 216f2f5db5ef..ceb6d7353cc7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -162,8 +162,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index d22736a62481..02b5dfabc181 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -169,8 +169,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index d2651f284aa0..9555dce6703b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -68,8 +68,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index c455b24dd079..63aba1519ce3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -137,8 +137,8 @@
 	axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
-		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&msgbox_intc>;
+		interrupts = <0>;
 		wakeup-source;
 	};
 };
-- 
2.19.2

