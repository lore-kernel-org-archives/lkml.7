Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B953C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D021A217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569255285;
	bh=XzOwzt4EaDZ9rGaWKVtEVQXODQx4kDEr42DdUyLF9nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fal4x+KRiwo/h/g/Twsy7Y9IoN49oogVDQT8guIdcXz0C2bprYriSJe1zUXgpZdt1
	 O3iX8NU8xflB+hTHs1yaKCFVjEDH28WO8Px6xCtf0neB2S9ZVAAs7kA65vEUViukUm
	 3jnjTCco9BbC8qlMtkzgyuSwofmhP31IoUvoGq6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395071AbfIWQOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394695AbfIWQOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:14:41 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343352168B;
        Mon, 23 Sep 2019 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569255280;
        bh=XzOwzt4EaDZ9rGaWKVtEVQXODQx4kDEr42DdUyLF9nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfG2fVlepDQbEBbjD4wbtwex8SGgtPbxKDn/6J7/FG+egAXLJumQN9lB4o5yNHixn
         ibB991ZBSGbVoSF/60Yx44nnWdBbaWiq8jSi6LL3mCfCzG/IdeF0kOCRDjEaF4ycez
         K0bIfhq51GoWmKBGdO6Mf2T3qSdIt50G7g9josg8=
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
Subject: [RFT v4 4/8] ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos4210
Date:   Mon, 23 Sep 2019 18:14:07 +0200
Message-Id: <20190923161411.9236-4-krzk@kernel.org>
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

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested.

Changes since v3:
1. Use interrupts-extended instead of interrupts-map.
---
 arch/arm/boot/dts/exynos4210.dtsi | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 6d3f19562aab..5fa33d43821e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -109,23 +109,14 @@
 		mct: timer@10050000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x10050000 0x800>;
-			interrupt-parent = <&mct_map>;
-			interrupts = <0>, <1>, <2>, <3>, <4>, <5>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
-
-			mct_map: mct-map {
-				#interrupt-cells = <1>;
-				#address-cells = <0>;
-				#size-cells = <0>;
-				interrupt-map =
-					<0 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
-					<1 &gic 0 69 IRQ_TYPE_LEVEL_HIGH>,
-					<2 &combiner 12 6>,
-					<3 &combiner 12 7>,
-					<4 &gic 0 42 IRQ_TYPE_LEVEL_HIGH>,
-					<5 &gic 0 48 IRQ_TYPE_LEVEL_HIGH>;
-			};
+			interrupts-extended = <&gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 69 IRQ_TYPE_LEVEL_HIGH>,
+					      <&combiner 12 6>,
+					      <&combiner 12 7>,
+					      <&gic 0 42 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic 0 48 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		watchdog: watchdog@10060000 {
-- 
2.17.1

