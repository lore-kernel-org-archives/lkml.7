Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E3CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7000A217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="QA44wzNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfC1LcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:32:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:46170 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfC1LcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553772727; bh=yk/C7qYRfuut/PI19IMTJPnIANY8O0yaD/q2l2j/hDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QA44wzNkINEWqeQokMNzIqdeQHlnpFGRDinp/5Ze9yNAE+xjDCcQ7DwCjITWkP/Zz
         elyoM5J2wmtLsuVQXkNSqj9i4avcXMusEJvCJqn/Iqi/MGYWSMEEzYJjzWqmWotlys
         XQ7y4H/tzJbkFkwZmcBuwWOejElJQsR3p7QsbGTI=
From:   megous@megous.com
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: sun8i: a83t: Add missing cooling device properties for CPUs
Date:   Thu, 28 Mar 2019 12:31:58 +0100
Message-Id: <20190328113159.9668-2-megous@megous.com>
In-Reply-To: <20190328113159.9668-1-megous@megous.com>
References: <20190328113159.9668-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Enable to use CPUs as cooling device in the future, by adding
"#cooling-cells" to each CPU node. This property should be present for
all the CPUs of a cluster. If these are present only for a subset of
CPUs of a cluster then things will start falling apart as soon as the
CPUs are brought online in a different order. For example, this will
happen because the operating system looks for such properties in the CPU
node it is trying to bring up, so that it can register a cooling device.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index fcb7ef5ce2df..7a40b7d77ec0 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -69,6 +69,7 @@
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@1 {
@@ -78,6 +79,7 @@
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <1>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@2 {
@@ -87,6 +89,7 @@
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@3 {
@@ -96,6 +99,7 @@
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <3>;
+			#cooling-cells = <2>;
 		};
 
 		cpu100: cpu@100 {
@@ -107,6 +111,7 @@
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x100>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@101 {
@@ -116,6 +121,7 @@
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x101>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@102 {
@@ -125,6 +131,7 @@
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x102>;
+			#cooling-cells = <2>;
 		};
 
 		cpu@103 {
@@ -134,6 +141,7 @@
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x103>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.21.0

