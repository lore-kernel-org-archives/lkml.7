Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000E5C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA562064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="dgIDfwW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5PJ3Y8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfGJOPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:15:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32773 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726458AbfGJOPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:15:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FA172210C;
        Wed, 10 Jul 2019 10:15:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=g9VnI55k2gfqk
        yFiDo2jUP6h8kVt5+l1eXuk/JqwcPI=; b=dgIDfwW2wukWqdwH2hVBui5z39N+m
        fE93iY7NdpOqULDW4QZRTh/e0fCwt0EQVq1PRwiTvoXPlDR1nSDyjxIGtB4ze4GV
        qQp1NH/Tch5Hr121Ekdi+Bwonr1vaP6OcE11E/2RL5UmwF7rugcDhb2z4hzKFUS2
        PtFNxxddteachq6uBwgHmAMWIqNOgcRH7EaWn0dmpSyYHeM2Ix/qK8EFE6YOo9w/
        NC0SDS/J9sdXtCiChymQyADk40yaYnkDXg3n6KWBPLuVTfbrsGT8PjQ4g3eplHGC
        aclYFIQMY8CONiInfLywelONW4mYgLHgyvjYl5EMP56awT5O7+cSh2YAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=g9VnI55k2gfqkyFiDo2jUP6h8kVt5+l1eXuk/JqwcPI=; b=i5PJ3Y8Q
        d0mWnD4ec//WuAghvNmxKKmPv5mFXLYsUVrFmNOSpKsTgfNMbwm4qgBjwNdJn7tU
        EnIYYDnJqJq6Npz2ShMQr3R/funrDJsuJFd6WAFydp+0MdA2QFHmHQfCw08CNmWJ
        qkWG+0zpJzh15vpnPrOdx7vCyG3282e4CzuHeSY55De1QiTuNFJRzUqdOosOUXj1
        m8szQfCCyUyy2lbHJpiIOfcKyTfT07ROuoJsiH/v+GAgPzF5JJQRN8YqsMAlkUpt
        XcMyd0XClQaN6f3tyEsGIqo89QUQg7f0ooTrs4NG552ocUpUfRqygaiHWjcR0fL2
        ggIQplyvOnOoqg==
X-ME-Sender: <xms:8_IlXRsCh7EqHYRNHhHqp8wxMUf3PPfP_ng-Fc2w9sTNI0AzoFYOZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepudegrddvrdekhedrvddvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:8_IlXRBLoY7fA4hcfaRHnSrMTKLas6ZOnMJL_hmdXqi-B5Vo4k-OLA>
    <xmx:8_IlXR0STOyijvaAAKBVIjBwJqiM9160bLzZ7A7_J9EQVCK5DQuegw>
    <xmx:8_IlXcIHGiYFmxa749GOgq0Ynn27ktUzf-rsO8lMx4Q2vOuDh-bm9g>
    <xmx:8_IlXdkL0CBRjqRayOaErCFAXeEAtDeL-3AOr3FCuZfcmgAY-rJlDA>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id F3BBF80065;
        Wed, 10 Jul 2019 10:15:11 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        robh+dt@kernel.org, mark.rutland@arm.com,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: aspeed: Describe SD controller in DTSIs
Date:   Wed, 10 Jul 2019 23:45:01 +0930
Message-Id: <20190710141503.21026-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710141503.21026-1-andrew@aj.id.au>
References: <20190710141503.21026-1-andrew@aj.id.au>
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
 arch/arm/boot/dts/aspeed-g4.dtsi | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 30 ++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 5d7050d00874..4bfda5d91dbe 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -188,6 +188,36 @@
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
 
+			sdc: sdc@1e740000 {
+				compatible = "aspeed,ast2400-sdc";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci@1e740100 {
+					compatible = "aspeed,ast2400-sdhci", "sdhci";
+					reg = <0x1e740100 0x100>;
+					aspeed,sdhci-slot = <0>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci@1e740200 {
+					compatible = "aspeed,ast2400-sdhci", "sdhci";
+					reg = <0x1e740200 0x100>;
+					aspeed,sdhci-slot = <1>;
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
index 4345c3153ca7..8d6404311652 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -262,6 +262,36 @@
 				reg = <0x1e720000 0x9000>;	// 36K
 			};
 
+			sdc: sdc@1e740000 {
+				compatible = "aspeed,ast2500-sdc";
+				reg = <0x1e740000 0x100>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+				clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+				status = "disabled";
+
+				sdhci0: sdhci@1e740100 {
+					compatible = "aspeed,ast2500-sdhci", "sdhci";
+					reg = <0x1e740100 0x100>;
+					slot = <0>;
+					interrupts = <26>;
+					sdhci,auto-cmd12;
+					clocks = <&syscon ASPEED_CLK_SDIO>;
+					status = "disabled";
+				};
+
+				sdhci1: sdhci@1e740200 {
+					compatible = "aspeed,ast2500-sdhci", "sdhci";
+					reg = <0x1e740200 0x100>;
+					slot = <1>;
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

