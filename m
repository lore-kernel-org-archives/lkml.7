Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57872C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CEF22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Ijydvjo2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RwaHGHzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfGZFkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:17 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48705 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbfGZFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BE95C4169;
        Fri, 26 Jul 2019 01:40:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=H2SkfNadBvvR5
        /1SfNvzYkRRCEpCfJ5JlYnAHdwy93E=; b=Ijydvjo2F26+SBwMObBQVp8EGlwzl
        aFMmdR7M5oKALAJPM5w+gxxRIlKLsdWS39LtOXz5Jnid0ebKSiVXpZvOEu8bYa99
        1heEOJjP2s9mskTaHj7JXFQ6lPUXOuKcfrslr7WkT1P418oSRlr/n51fCbwVgZvR
        RLu8CEd79roFM3Dq/uC9w4+ow9NhNePaKra/C8zs+2SWWO+7wlzz82l4UIjH2k+j
        xClGiUe1hj7o3pr8QpD7MxOovrF9ZPSvVFXq8AVtSXQ7cK8PrgK60+5gyH096OUC
        x7GNvSAxNxlu/f1nilMLjlRvPDMNZCxG2zzoXxNLbCJiPR532pshSOsJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=H2SkfNadBvvR5/1SfNvzYkRRCEpCfJ5JlYnAHdwy93E=; b=RwaHGHzC
        evPKfxCaC8gAw6S3DpavFs+ZkZuD0CRVTkAvbeujB3XmaoWZkGmCJPFdUk7/JwGp
        WL1lwpsTpkr48TqN3Boet/mGQRQEZ7+zWvFr7xYLQg5SmAr4EU1yLExgRIBF7Go8
        ATEQzhbipPzAdrfh+kQip09o0I3oKnQqtOsB5WXKw2w6qUfZ35j4eF+2QXoKGyZb
        HTybFeMLkkr3xHjHoDcyvWUlqggbesOHiPchS3AwUQQOvl49ewZxdleUPDmqJ6NR
        m9rTTh2Sw62jKBfgnAyfX4/X82i/xi4iSAapkLeWYTaKnC0eJq/LdlXRJKeFxocy
        c90CUAmaSMmFKQ==
X-ME-Sender: <xms:PZI6XaUTWCAYFo4HWoUr89dRDT1byp4kFzqE9fpKljIeXbscDWVHxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughrvgif
    ucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtddvrd
    ekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdr
    ihgurdgruhenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:PZI6XfUxwPc-SG32VF8tms9gnwjAKGJloUPs1GqkXvaAhJMPJD91OQ>
    <xmx:PZI6XT1k3hxvBLfhC_cEnS37KMgRsa4eZ6poXm-myg88b6Y5YlW9Uw>
    <xmx:PZI6XVAE5ILSe22IjZlY1cXn1LrTVmEQUlYlkTqGOBnXRxOmeh8emg>
    <xmx:PZI6XThj-ZW0aIvYBsOviXGojSZnNbjypMy2jsnXAElKdYD_bUXc3w>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01476380079;
        Fri, 26 Jul 2019 01:40:08 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adriana Kobylak <anoo@us.ibm.com>,
        Brian Yang <yang.brianc.w@inventec.com>,
        John Wang <wangzqbj@inspur.com>,
        Ken Chen <chen.kenyy@inventec.com>, Tao Ren <taoren@fb.com>,
        Xo Wang <xow@google.com>, Yuan Yao <yao.yuan@linaro.org>
Subject: [PATCH 03/17] ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
Date:   Fri, 26 Jul 2019 15:09:45 +0930
Message-Id: <20190726053959.2003-4-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing approach lead to an error from the dtbs_check:

    pinctrl: aspeed,external-nodes: [[8, 9]] is too short

Cc: Adriana Kobylak <anoo@us.ibm.com>
Cc: Brian Yang <yang.brianc.w@inventec.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: John Wang <wangzqbj@inspur.com>
Cc: Ken Chen <chen.kenyy@inventec.com>
Cc: Tao Ren <taoren@fb.com>
Cc: Xo Wang <xow@google.com>
Cc: Yuan Yao <yao.yuan@linaro.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts     | 4 ----
 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts | 4 ----
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts            | 4 ----
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts           | 4 ----
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts         | 4 ----
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts           | 4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts             | 4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts             | 4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts               | 4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts         | 4 ----
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts               | 2 --
 arch/arm/boot/dts/aspeed-g5.dtsi                         | 3 +--
 12 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
index c2ece0b91885..de9612e49c69 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
@@ -211,10 +211,6 @@
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_c7 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
index 521afbea2c5b..d122a8efcc66 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
@@ -197,10 +197,6 @@
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_c7 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
index d519d307aa2a..dd2be50112a4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
@@ -64,10 +64,6 @@
 	};
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 /*
  * Update reset type to "system" (full chip) to fix warm reboot hang issue
  * when reset type is set to default ("soc", gated by reset mask registers).
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
index 4e09a9cf32b7..d4d2d0b48f83 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
@@ -29,10 +29,6 @@
 	};
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 /*
  * Update reset type to "system" (full chip) to fix warm reboot hang issue
  * when reset type is set to default ("soc", gated by reset mask registers).
diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 628195b66d46..2dd664bff928 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -745,10 +745,6 @@
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_b7 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
index 22dade6393d0..4e9c03d5e5a3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
@@ -115,10 +115,6 @@
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
index de95112e2a04..fe7965366f4a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -260,10 +260,6 @@
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_b0 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 9628ecb879cf..2fa4f361ac6a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -255,10 +255,6 @@
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index caac895c60b4..2077e8d0e096 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -937,10 +937,6 @@
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index 31ea34e14c79..08facb2120b2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -618,10 +618,6 @@
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 30624378316d..c99113e69e43 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -461,8 +461,6 @@
 };
 
 &pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-
 	pinctrl_gpioh_unbiased: gpioi_unbiased {
 		pins = "A8", "C7", "B7", "A7", "D7", "B6", "A6", "E7";
 		bias-disable;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 6e5b0c493f16..3b4af88f9b80 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -216,8 +216,7 @@
 
 				pinctrl: pinctrl {
 					compatible = "aspeed,g5-pinctrl";
-					aspeed,external-nodes = <&gfx &lhc>;
-
+					aspeed,external-nodes = <&gfx>, <&lhc>;
 				};
 
 				p2a: p2a-control {
-- 
2.20.1

