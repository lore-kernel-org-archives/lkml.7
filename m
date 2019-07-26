Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC8FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CFA22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="i9Z8F/wF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ip9qYLAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGZFkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49059 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfGZFkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 41E402224B;
        Fri, 26 Jul 2019 01:40:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=HESpvVbaHQiOa
        yBRK5sEX6EQs5s2hLfvGzXijz0YC9o=; b=i9Z8F/wF+RB+/ayVWbUiCCfiPRwN7
        eMWKkqOojYqcrEntkvDlBCl3PFbzk7LiOE1lTzBmL8FW5Rhbhpl5DwnRKdfZAScN
        mm5/FDIW5gO7r+qzrmPDfFs0fwHHi9K//y59R0qdxRUrpu57ZJATjDX/cY+wTPbP
        8oB7dlndnuNIIMHfdUqiKi9VEN/jFvH3+dTPosSxAu91p3euW+GoobfPkZz2Ts3B
        Om3Bz9oSxlklVcF40688lBoOq4gyErUO7jB5IJaFquONsTq5PaqLacDyhob+19HQ
        w516ftnT6uuY116f/cPqsgic+UZWLTkZ/ohuCwdB2yhfTILF8loIJMN5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=HESpvVbaHQiOayBRK5sEX6EQs5s2hLfvGzXijz0YC9o=; b=ip9qYLAC
        6Hz53HL//BE8MS5cpLyg0thf7LF3XRnazzZ8RBHBitf2UNM+Dsdz0bM0y3gM2LHF
        a4rC5yO/4zXDqG6U6oHC6UbdUSQPdFg4iyfj9Q2YY/bejXaEC9eL2I1h9Y+ZEvnm
        vIs83tPJ3e+3Oih8ac5Zi00oj6NGtI6Bps56IOGEFVeNpx2vVm51nwK+oL+Kdi8I
        1j2NpVKUdawZl3M4w70xDU0OTMHChpK1y6TxvntXEyfDIvCKjqBO9svobwVYQfzB
        cE4bASSqabalywJg9p1w/Z6+PBXDTlQXIPXGn3E88zQMpJr0V2K94QtEIhYf34MM
        7JO2Qu5Jqp2hWg==
X-ME-Sender: <xms:XpI6XRhCKREbudYRDFh75p0jFaGConmnjr5rDOYXB-6mlsp24vaB1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:XpI6XabtY-ZjGrsKG4UWJwewIClHgj6C7hs_vjIjxSfksF_3pYIDXA>
    <xmx:XpI6Xe-QxRs6tmUyrupxBjaE-MefARqwjtevRvnZFsOvUhELd2iH1A>
    <xmx:XpI6XUMGNHgA4LUOwK87WnzZsSYnnkVcB-SPhdLf3cMWsu32paCuxw>
    <xmx:XpI6XUtK0bFypTXRdhTR613U3iRZkHol8lso0XtGV1XLSk0npEpYAA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2694380074;
        Fri, 26 Jul 2019 01:40:42 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Patrick Venture <venture@google.com>
Subject: [RFC PATCH 12/17] ARM: dts: aspeed: Add reg hints to syscon children
Date:   Fri, 26 Jul 2019 15:09:54 +0930
Message-Id: <20190726053959.2003-13-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warnings:

    arch/arm/boot/dts/aspeed-g5.dtsi:209.28-226.6: Warning (avoid_unnecessary_addr_size): /ahb/apb/syscon@1e6e2000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm/boot/dts/aspeed-g4.dtsi:156.28-172.6: Warning (avoid_unnecessary_addr_size): /ahb/apb/syscon@1e6e2000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Cc: Patrick Venture <venture@google.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 15 +++++++++------
 arch/arm/boot/dts/aspeed-g5.dtsi | 17 ++++++++++-------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index ed78020f6269..1515b56a1487 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -157,18 +157,21 @@
 				compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x1e6e2000 0x1000>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 
-				pinctrl: pinctrl {
-					compatible = "aspeed,g4-pinctrl";
-				};
-
-				p2a: p2a-control {
+				p2a: p2a-control@2c {
+					reg = <0x2c 0x4>;
 					compatible = "aspeed,ast2400-p2a-ctrl";
 					status = "disabled";
 				};
+
+				pinctrl: pinctrl@80 {
+					reg = <0x80 0x18>, <0xa0 0x10>;
+					compatible = "aspeed,g4-pinctrl";
+				};
 			};
 
 			rng: hwrng@1e6e2078 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index a8a593dd2240..92c659c50b4c 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -210,19 +210,22 @@
 				compatible = "aspeed,ast2500-scu", "syscon", "simple-mfd";
 				reg = <0x1e6e2000 0x1a8>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x1e6e2000 0x1000>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 
-				pinctrl: pinctrl {
-					compatible = "aspeed,g5-pinctrl";
-					aspeed,external-nodes = <&gfx>, <&lhc>;
-				};
-
-				p2a: p2a-control {
+				p2a: p2a-control@2c {
 					compatible = "aspeed,ast2500-p2a-ctrl";
+					reg = <0x2c 0x4>;
 					status = "disabled";
 				};
+
+				pinctrl: pinctrl@80 {
+					compatible = "aspeed,g5-pinctrl";
+					reg = <0x80 0x18>, <0xa0 0x10>;
+					aspeed,external-nodes = <&gfx>, <&lhc>;
+				};
 			};
 
 			rng: hwrng@1e6e2078 {
-- 
2.20.1

