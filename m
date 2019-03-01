Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4ACC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB912218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="WeCYBJBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yq/iHkkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfCAF35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:29:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33955 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfCAF3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3117A220A5;
        Fri,  1 Mar 2019 00:29:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ecURF+ayLWpY2
        Oe8w1vUiDRoINN11ZW1ygsWBjCaQUk=; b=WeCYBJBRXlPZXmlC9T0h/93xUddER
        0Qhy6pfcRlUAiyxTltGRz65rD9wOk8mO6ywuixEmNmY5CfT85yW4pFGHTShBk4H2
        DIfqwZW7ZThEgPXHKF5fowsoQZtkAxIYRnbuOMYwilAlT2XaLm/KkJNfB5kJgo46
        Q6ClXpU77V52GUClvvgNx1HgJBvW5lH5h05OIE3q70qqgRJH9SUH8E3gXWV5Nu0p
        PRikLj++Xj1LGVKFQFSwIHSJquoHmtOc10XlfQI5JXZnkYXqBhRp6LdTuJCZL6OC
        KsdXuxA0M+NwVniA0cvYX5iMg4CGVOCIA10kXtQWC08y4FgsAlYwSFv0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ecURF+ayLWpY2Oe8w1vUiDRoINN11ZW1ygsWBjCaQUk=; b=yq/iHkkD
        KOvzs3J43w+aptL8QS+n9ikPjaonjII4ZDcwrUS3uN40o5TpHrXi66UYPsBOypeK
        lTIu9gi6GtUalpeHeT3yOJTpEwYT8VUoSPvFTNr8UR/Tt7JspoCDa5SXty21xZug
        jeBH45ST8kg26fVMn2aYq0acAfF3XGM4QjgcsEkLaFctPg64vNVbOapcPb7p55Mx
        uTtGWU2urGxraK7WsoLaOfru0eYM+mGD6uPsno/j8E20amufMFpFOGvrAS4Cuoy7
        O0N1JSfTtIh/j8fXFUVcgyXDMLe5tv7xTg7eIeGKh1LkTa7wioUtV2shHk02n9fs
        zK4JuvhupFdDVw==
X-ME-Sender: <xms:UcN4XD4W4MqZyuXMn2wTc967TsKBFR8O8qx70VkUq-wSd-lizQdiPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:UsN4XBrItZdRHaHIxnUDF6Lz3oiyQBEZzn5TtwzJ03LFQlh7l0afrA>
    <xmx:UsN4XJKuxDizt1UUXr-avAF0_3PyhQN6Px23jPTmphA52RUGq5KAaA>
    <xmx:UsN4XGgXSM25iAI0ct9BPxVNRewHhi902ThPi7oaFcGp3pbxPWCFwQ>
    <xmx:UsN4XF1YKokIyL4cEsxsbd9Xx5KXKfD41oybjKlZB9jV3rcuVNqsuA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 471A4E427E;
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
Subject: [PATCH v2 08/10] ARM: dts: sunxi: h3/h5: Add msgbox node
Date:   Thu, 28 Feb 2019 23:29:45 -0600
Message-Id: <20190301052947.32032-9-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
References: <20190301052947.32032-1-samuel@sholland.org>
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

