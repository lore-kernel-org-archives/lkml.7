Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681DEC742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0EA21537
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ZWJZ36c+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J1ytC6y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfGLDhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:37:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58115 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729404AbfGLDhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:37:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CA9A22223;
        Thu, 11 Jul 2019 23:37:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jul 2019 23:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=wkoAIErEzcHdT
        OhYOKxqtuFlPzo+edLdLqHK1zIdcu0=; b=ZWJZ36c+VcnsL4AIvV8Y31GLbiiiy
        nZo9Z6QG/Zf6NbSIlks9CmVZgXv1IX8GsYGeWtIDDM759fVKilPXwjjygAT+/EhM
        mJ9WRXV51yPZOMJQ5Ifl5tRIMQr4SxA97vGprxWFRbgb4dNKxy8uT/oe0YfVdMd5
        0smfv9uN/4/ufPquqXUnnOgEhNrlr12iuS6hs7ZLfUCXdBYNStCAkOXMSEOMSyJq
        SDspF0cjOp7chP0Ra7dDHI7Z0yV/XmXQAO+hHPgWun6yXcVTB0xDHFGhs9VWm93F
        dzlSbacoU/ihLcw9Tk7UriVgOt6Xzn6uCEupD5SG/AnbB/ZqBVsl/v4Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wkoAIErEzcHdTOhYOKxqtuFlPzo+edLdLqHK1zIdcu0=; b=J1ytC6y8
        Tr3qehwTCKCxh0nm4i5A6ORWoJSmimyt9WGVnORooi2bOO2SeK+Kjmt68+yg5Wpb
        WCb/bmNRXsbaO1dj4JDEMF8iuSkkDYxvJ+OQbSVThirA43fVIjgxnJr2H+ThZOoO
        YMhlmIrA53fRBH0LCOIynmLvde3EpNV1u62B/759Rc6N0FbuPlvGZsOiRLb7lNcZ
        Gjp0Ylm4LDF9jtY+C0arSQdAxtmPpgyf7Ec/b04yOtM03fnIVNoV+AwA8kV/NWTI
        bhT6qA5B/XkeUfCyK83hHc42ELOmaWAtsiYHhg2QMxktWcWluBOnM6P5qggRmnVO
        CTR7QkjHWjraug==
X-ME-Sender: <xms:fwAoXY8rHKslaU4FfgFauoJikKTPdyNlSo-JihW7Hj_KAHzPFDm2QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    td
X-ME-Proxy: <xmx:fwAoXW0KJO_zVEhE4_KUMGm1_16jeAEKykbuMcIrAnmR68g_0cKJcw>
    <xmx:fwAoXTkG7gBUKu7RbFT-H3SvzIp7kBO7foYj71lgnMMffGXlsXFp7g>
    <xmx:fwAoXb15oa9maB6T5NmiN6sL0vmtrV9OIOBVI0_ccCdTq4ZLAD2HFA>
    <xmx:fwAoXYLEvvwVpjmU5tV2hAadyys0ZGCG8YuwgTwbd0KyuAZ0g-PTig>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7CBE1380084;
        Thu, 11 Jul 2019 23:37:32 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: aspeed: Describe SD controllers
Date:   Fri, 12 Jul 2019 13:07:25 +0930
Message-Id: <20190712033726.25237-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712033726.25237-1-andrew@aj.id.au>
References: <20190712033726.25237-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AST2400 and AST2500 both share the same SD controller, at the same
location in the physical address space and the same hardware interrupt,
with the same clock configurations.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Rename sd-controller compatible
* Drop "sdhci" compatible
* Explicit ranges
* Remove slot property

 arch/arm/boot/dts/aspeed-g4.dtsi | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 5d7050d00874..6ef2563ce372 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -188,6 +188,34 @@
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
 
+			sdc: sdc@1e740000 {
+				compatible = "aspeed,ast2400-sd-controller";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e740000 0x10000>;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci@100 {
+					compatible = "aspeed,ast2400-sdhci";
+					reg = <0x100 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci@200 {
+					compatible = "aspeed,ast2400-sdhci";
+					reg = <0x200 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+			};
+
 			gpio: gpio@1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 4345c3153ca7..c0e71f814fec 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -262,6 +262,34 @@
 				reg = <0x1e720000 0x9000>;	// 36K
 			};
 
+			sdc: sdc@1e740000 {
+				compatible = "aspeed,ast2500-sd-controller";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x1e740000 0x10000>;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci@100 {
+					compatible = "aspeed,ast2500-sdhci";
+					reg = <0x100 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci@200 {
+					compatible = "aspeed,ast2500-sdhci";
+					reg = <0x200 0x100>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+			};
+
 			gpio: gpio@1e780000 {
 				#gpio-cells = <2>;
 				gpio-controller;
-- 
2.20.1

