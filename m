Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE13C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E5E206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="JgbUk9pw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4gl3uVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLCMDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:03:06 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37729 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLCMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:04 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CB16E1F79;
        Tue,  3 Dec 2019 07:03:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=q5fsQR57WMUw8
        v/diLecW7Z/022zvctgEjYQGcu9mYk=; b=JgbUk9pwtHe8CKSY99Sxnrzky6Iai
        r55Pug8hdDiTecmOd4Oo4Tw9ikoiwK/btOQBtwURRk+allOphZJeTsUXk+fGDOa3
        rusGq96wtVuOBYR0UCrw+lj911LWUi59MprF0KTGXgUpLLfKyZT3XdjVh4jKUYaG
        sPzAuns4j2WT+HfGW8zXUPWROrvppnUY+Ra5XkbbkinfKa9vqrfKRf2z2oqa8rRI
        nIADW27wTW1XzicgCjp0tP3JkjGPU8ufwIdwboum16cHLWKzk+tXXTm9W3AFSa6g
        0YdS8om8KC4oWc7QoHo0Zn6hfW7mAbdxAOpQbuXaf3Lg8a/+hwJgStEQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=q5fsQR57WMUw8v/diLecW7Z/022zvctgEjYQGcu9mYk=; b=m4gl3uVy
        rRR4tvvt2v3IkwoT0dryNqrKAlwX3BMOlnChDM5qAePMasDQWYq4YtUCi0NFCdfj
        r7LKe8DtVdK4ZFhpgJW3aom81HPJCU1vUrHLyfzx0+MzpkBO0KcnP8hzyMq6X58c
        aq2/1AMDBzQadBGJWz/Je4sAuy7uyTy631T+J2Cj+M17Fa6jl3qwP+6S65nlfOL0
        /wDwBRQeCQIV6J/t5xlj+1V6RtUtIfIBliL8MixITKK2QJ9jcwm2O0RTCCAyac3A
        Ox1gyQgEZxhg44B9ylX5iH38E9pVkxG3oEsUOGGXHfNqrRjoDGZyUXk2lAYHnbXH
        5G+RgyisZVj47g==
X-ME-Sender: <xms:907mXQ0GiOvSALqXKSkDIAG95AWdCrXXsvb-9q2z9oDeDc2PFqc_TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:907mXVfGzEw6vZcNN6maLZSn9Hdaj6VrTE3V9EbNPCjHggYj4kKUEg>
    <xmx:907mXZrYFz24HlkekUpCg-rPZmY9PLEyvM4z-afsPLiwI4ZSk41ahg>
    <xmx:907mXXWoU5TWy0iOeBXgLKUcUND9EXwJnNj_BEwVXFvcaltlR4o_Bg>
    <xmx:907mXV81iyFgpYODxjE1RdgWHqX_BNQCr4-kinJ8xeF1X4F4wJUneg>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id CD3E730600EA;
        Tue,  3 Dec 2019 07:02:58 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Adriana Kobylak <anoo@us.ibm.com>,
        Brian Yang <yang.brianc.w@inventec.com>,
        John Wang <wangzqbj@inspur.com>,
        Ken Chen <chen.kenyy@inventec.com>, Tao Ren <taoren@fb.com>,
        Xo Wang <xow@google.com>, Yuan Yao <yao.yuan@linaro.org>
Subject: [PATCH 05/14] ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
Date:   Tue,  3 Dec 2019 22:34:06 +1030
Message-Id: <141f068d10b94413a6d0ca73fe07f8e961380e7b.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
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
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts     |  4 +----
 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts |  4 +----
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts         |  9 +++++++--
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts           |  4 +----
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts             |  4 +----
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts             |  4 +----
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts               |  4 +----
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts         |  4 +----
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts               |  2 +--
 arch/arm/boot/dts/aspeed-g5.dtsi                         |  3 +--
 10 files changed, 8 insertions(+), 34 deletions(-)

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
index 2c29ac037d32..022d0744d786 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
@@ -200,10 +200,6 @@
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_c7 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index c17bb7fce7ff..d69da58476fe 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -782,8 +782,13 @@
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
+&gpio {
+	pin_gpio_b7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(B,7) GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "BMC_INIT_OK";
+	};
 };
 
 &wdt1 {
diff --git a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
index 1deb30ec912c..8a9782b7e1af 100644
--- a/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
@@ -118,10 +118,6 @@
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
index 42b37a204241..a875e873bd47 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -263,10 +263,6 @@
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
index edfa44fe1f75..270184cb0577 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -260,10 +260,6 @@
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
index b8fdd2a8a2c9..0831bc1f5a4c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -940,10 +940,6 @@
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
index 569dad93e162..39ba4d5a787e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -623,10 +623,6 @@
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
index bc60ec291681..7795248ba188 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -466,8 +466,6 @@
 };
 
 &pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-
 	pinctrl_gpioh_unbiased: gpioi_unbiased {
 		pins = "A8", "C7", "B7", "A7", "D7", "B6", "A6", "E7";
 		bias-disable;
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d8d358e23d78..5757d3f0e947 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -223,8 +223,7 @@
 
 				pinctrl: pinctrl {
 					compatible = "aspeed,ast2500-pinctrl";
-					aspeed,external-nodes = <&gfx &lhc>;
-
+					aspeed,external-nodes = <&gfx>, <&lhc>;
 				};
 
 				p2a: p2a-control {
-- 
git-series 0.9.1
