Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D1FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3700D206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="lPCj6RHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbfC0AtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:49:19 -0400
Received: from vps.xff.cz ([195.181.215.36]:53990 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfC0AtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553647756; bh=ouivOhArKwMC5dYfyXxes1cTnKWBXl47Y15kvFkY6uE=;
        h=From:To:Cc:Subject:Date:From;
        b=lPCj6RHHTfWpdANZhf3cEuq/HPAbUMzT8C5trqcGcCB4KS4oAaJ4NiI1S25u4Hav8
         LzoiXhCXvKoI0ss0iOPr+LcmO7uL2NLWXe8w1w7y8yqqe5+JlMYPFqqfYgTHuc67C2
         4KOTrPYffX0ZOQ1I60AJ4BBtgy4rsWBJ0c+r6pKA=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: sun8i: a83t: Add missing cooling device properties for CPUs
Date:   Wed, 27 Mar 2019 01:48:37 +0100
Message-Id: <20190327004837.10384-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This is inspired by the similar patch for H3. Original description
applies, and is copied below:

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Fix other missing properties (clocks, clock-names) as well to make it all
work.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index fcb7ef5ce2df..1b0b025b9250 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -69,33 +69,43 @@
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
+			clocks = <&ccu CLK_C0CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <1>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
+			clocks = <&ccu CLK_C0CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@3 {
+			clocks = <&ccu CLK_C0CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <3>;
+			#cooling-cells = <2>;
 		};
 
 		cpu100: cpu@100 {
@@ -107,33 +117,43 @@
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x100>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@101 {
+			clocks = <&ccu CLK_C1CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x101>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@102 {
+			clocks = <&ccu CLK_C1CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x102>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@103 {
+			clocks = <&ccu CLK_C1CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x103>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.21.0

