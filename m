Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC06C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D0820857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="RdauTGcL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qsIETBD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfCBEa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:30:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50547 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728094AbfCBEaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:30:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8728622141;
        Fri,  1 Mar 2019 23:30:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ooUrU7uGG5qG1
        YLHj5lkEeYiw80CHNq9zOV4g5e9hA4=; b=RdauTGcLp3wpSfwXKHeGhO+QUrFXV
        tKRCSxiEN93Xfz9OQEfsEo2HwoVXBU6PlWndHbC9Ye3QQuyIC/PChIvkc4hZPWDq
        7m3Mh57P4WKfaiS3YzvZljH/xF0Nnc5yOmrx0+aPqWlumqu8TqK6y8Mf7HyvyX0Q
        25xyXLx4dP6egrBwS/PB5PYBR7YK/YzvS7ttKfuqWoOhaWuGS96p2eTDNYMeusjj
        C2z8nsx5xlrgQ7bRNxONihkxddceCwi6XsSDYmy1HvVEbFSk0fu63VR2wQCNqWJF
        c9DnNVO+dHRTT0V7WRoIbpoQP2oM+LH8k0q5DgadnngxFwfNvOoZ0Z8zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ooUrU7uGG5qG1YLHj5lkEeYiw80CHNq9zOV4g5e9hA4=; b=qsIETBD3
        JNnxNOHwn51oDwyRMIEtg/Fmh6/+TsHXC9WuqsPl8L3RucSc0PFukehUc/tDAJHM
        A/2z/TXCyQMZXIynDAE46IXw2xeFbp1nD+scMZgZPWtDomif6IdUReE/9zftGm5o
        AK4EalJKGtnvwHkjhexvSQpKk49r1EJv2ES3089d67GjqzzBPEJwQKj017p9D5Q3
        0vryF/BLrM62UdniEQ2+KKG7m8CR3ZlNBsZW95Gz5bN2cOTRdBn/LwrvK34aamGA
        XfAtkfCM4P6kc50gcRBrmVAXaOoA/ZeRto+/97T0UXfdZJNvKurUElL+bL4ZgQeI
        hRWllzfi0ILNXw==
X-ME-Sender: <xms:yAZ6XA1R_nuyCVsq8n3iLfLId6l6oFy6qiS5v13xJj1jf0cA8TGLWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:yAZ6XG64Z1qX7CJBSEZli7OupFvjwb60BJDHxEdBigzSs8HnOtRomA>
    <xmx:yAZ6XOaYyvYyL487buQjXjCdy2mLHOKVASVW8eL5HfxdtO5wyIgyiA>
    <xmx:yAZ6XMTZpfe_nPvLRieKQ7MgLIfHUQb4ga9d2c-JChGKW85HPf45MQ>
    <xmx:yAZ6XJFuqUpoL09LmwzBtxn2u9UNr4hplX3xMlVZWdmWsE_TzBlZyw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9879910312;
        Fri,  1 Mar 2019 23:29:59 -0500 (EST)
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
Subject: [PATCH v3 13/15] [NOT FOR MERGE] arm64: dts: allwinner: a64: Add interrupt controller node
Date:   Fri,  1 Mar 2019 22:29:49 -0600
Message-Id: <20190302042951.53671-14-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190302042951.53671-1-samuel@sholland.org>
References: <20190302042951.53671-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to give firmware full access to r_intc, Linux needs to avoid
using it in the device tree. Most IRQ lines attached to r_intc are also
attached to the GIC. Unfortunately, the NMI is not. For it to be used in
Linux, we have to forward it in firmware over the mailbox.

Add a node representing this virtual interrupt controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 29ee8f0f833a..63e33215dea0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -128,6 +128,14 @@
 		status = "disabled";
 	};
 
+	msgbox_intc: interrupt-controller {
+		compatible = "allwinner,sunxi-msgbox-intc";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		mboxes = <&msgbox 6>, <&msgbox 7>;
+		mbox-names = "tx", "rx";
+	};
+
 	osc24M: osc24M_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-- 
2.19.2

