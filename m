Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51296C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210B32087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="ebMq51fO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z3Op50un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfCAFaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:30:16 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57663 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727596AbfCAF3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 967E92208D;
        Fri,  1 Mar 2019 00:29:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=0E3xQubbqSzCI
        eQmbqeab4IA+YPmZG/r+t8YmeooEPM=; b=ebMq51fOg5rn8EPA617OH03+udIbI
        r7moTkCiPaYugIPrVmiw2CTaMpcI8HUjJupT9CmIRhtbcxarSa0XgRQSWARuTKLo
        VhVHeoZYeNR1IMmj4ryYtN5ByovrDoVVABqO31zKNH0lbWcIdC5GLdLzbzrj+rc2
        RYIntEjtp6URuN6D1TyqWi5SDv2V3KvJDh6tTkylFrB4FxrUbdp3ymUk2wSje1AH
        l6gZGILHgSscKWf1jqFPcBAP+77Ib/+2LjAom+VYwea3b6LkOq0FamV748FPKYpM
        u0ZtsWbvz90FTwlhajO8xwEy8H4rqWlzyGQAdbF7VZwRBv/VSJAq6cd2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0E3xQubbqSzCIeQmbqeab4IA+YPmZG/r+t8YmeooEPM=; b=Z3Op50un
        +yu3kP2MBvE99tyB6We0F/Jn0k08ZU9q306b1ipcOJxrUDiCyyf1kI56H65sy3lL
        w39f8BIV0PY872737u/ZSbKJxwEYPIYFadntsWJygHhuOtWwnVvxJiLZ16T1s8Zb
        jNfmMwhlUhzHHDubP+XAWXMMREQttzqJ9z9wiWlryThaxim8WGFXaTVA2Cp2rGau
        5bDm1DIEF+zm28biF8+LYGmCgREwidrtVlr8a7tXAl/tQ+Tu/dMBnh2EfcnVq/1r
        gbmh8C7DorMJI0eAkw/dtsqXjE54Amz02C3CU2j9b1fR4+7Sgnev9gkQn8qMUpQw
        7VdOWP/+YRN3Mw==
X-ME-Sender: <xms:UcN4XMEHwnJmim1VKbQ9n6ZwzO69ymPiw9OQHlLgXh6_mjeG9FBcBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:UcN4XD3GhE0zThJZ5WyiOvFbCSUqZp2gfTIv3wYXPWKgTe6duFo1EA>
    <xmx:UcN4XM2rmDvrS0ilpflgVQzIfL29mgyLk0ia5GDeaCeLjVQyKAFtdg>
    <xmx:UcN4XNM-jD3J-udp68_8Qw_ZX8Ht_2h8jM0rhfpmgrNJ7mlH6lNWbQ>
    <xmx:UcN4XFYBuBpSlBIIUZfmB3ekp5NSMkWeQhdiCEZOSZIqog4hW82MNA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B3960E40C1;
        Fri,  1 Mar 2019 00:29:52 -0500 (EST)
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
Subject: [PATCH v2 07/10] ARM: dts: sunxi: a83t: Add msgbox node
Date:   Thu, 28 Feb 2019 23:29:44 -0600
Message-Id: <20190301052947.32032-8-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
References: <20190301052947.32032-1-samuel@sholland.org>
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

