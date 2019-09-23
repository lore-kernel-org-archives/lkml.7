Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D6C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A5621971
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569255295;
	bh=055AApEoZHnhqgk+jRGaMDM2ewIZ2IZaWqUX6PpZBOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CND6EiodI9ROsHXUznKXEt7CArRFjTYv6IMBmAzoJufJUOab7umLZUScJVTS9w011
	 uhi/6rVAjkx9UI91wkRSe1Utm7Uo6rGN4lEucCkdUunQWi21JbP6dcLqImx5qAKMdA
	 b5kK/VaIBqpDYAHIpI71CQBHLgs8IZUnNSw3W7o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437522AbfIWQOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395236AbfIWQOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:14:52 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B95021BE5;
        Mon, 23 Sep 2019 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569255291;
        bh=055AApEoZHnhqgk+jRGaMDM2ewIZ2IZaWqUX6PpZBOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=080ytc1/zsczrnAZzkk/jf+vyHuy1mflRjgCtER/h6Ys3Ydv1bhSixWAn+HLLDF5f
         fXj2G5bKxZYkwqKEmrIhd8NE2wUw106stvVZm3hSJu/CDv+5kT0WAyysLz/KgI2KUR
         XEyVj5JdthFCujY/OeJbz5nMHC9pM1t57MKCanVo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v4 7/8] ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos54xx
Date:   Mon, 23 Sep 2019 18:14:10 +0200
Message-Id: <20190923161411.9236-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923161411.9236-1-krzk@kernel.org>
References: <20190923161411.9236-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi Core Timer node has interrupts routed to two different parents -
GIC and combiner.  This was modeled with a interrupt-map within a
subnode but can be expressed in an easier and more common way, directly
in the node itself.

Tested on Odroid XU (Exynos5410), Odroid HC1 (Exynos5422) and Arndale
Octa (Exynos5420).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Use interrupts-extended instead of interrupts-map.
---
 arch/arm/boot/dts/exynos54xx.dtsi | 33 +++++++++++--------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 247d23872384..aca1b4831e38 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -67,27 +67,18 @@
 		mct: timer@101c0000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x101c0000 0xb00>;
-			interrupt-parent = <&mct_map>;
-			interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
-					<8>, <9>, <10>, <11>;
-
-			mct_map: mct-map {
-				#interrupt-cells = <1>;
-				#address-cells = <0>;
-				#size-cells = <0>;
-				interrupt-map = <0 &combiner 23 3>,
-						<1 &combiner 23 4>,
-						<2 &combiner 25 2>,
-						<3 &combiner 25 3>,
-						<4 &gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
-						<5 &gic 0 121 IRQ_TYPE_LEVEL_HIGH>,
-						<6 &gic 0 122 IRQ_TYPE_LEVEL_HIGH>,
-						<7 &gic 0 123 IRQ_TYPE_LEVEL_HIGH>,
-						<8 &gic 0 128 IRQ_TYPE_LEVEL_HIGH>,
-						<9 &gic 0 129 IRQ_TYPE_LEVEL_HIGH>,
-						<10 &gic 0 130 IRQ_TYPE_LEVEL_HIGH>,
-						<11 &gic 0 131 IRQ_TYPE_LEVEL_HIGH>;
-			};
+			interrupts-extended = <&combiner 23 3>,
+					      <&combiner 23 4>,
+					      <&combiner 25 2>,
+					      <&combiner 25 3>,
+					      <&gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 121 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 122 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 123 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 128 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 129 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 131 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		watchdog: watchdog@101d0000 {
-- 
2.17.1

