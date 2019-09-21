Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55437C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A105218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569085343;
	bh=ZhlatAQJ3gbAFsTaWLwFfMHgUb56DQV27LgklGme05w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RAiJd4eICqMXP6hPhhubNh7VuyQc9qA18w2ALG+RDQP6bqVZHMMrqHeNtjntHcn6t
	 Cw6SIwXe67DB/DkyRiRQ85BR8rEQ+Tog+v48B2i3r6AcA0bQA2o3c8V7k/8HzwQPUf
	 n4oonNC2eXY+ouVlC0sRUunw2Ks811p0wEasouG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438394AbfIURCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438377AbfIURCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:02:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E4212190F;
        Sat, 21 Sep 2019 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085338;
        bh=ZhlatAQJ3gbAFsTaWLwFfMHgUb56DQV27LgklGme05w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBysDp4gwW+VrTrbK206X0kuUyh0if1grnyL8UMjAAS14VgeSsqtTDx3uZ5e9SP34
         C9zjLhxaj8MzDzvI5GSN3UxPu2facYXgjFJ3nniZ9CwpfkoqjDdW0nLXcgm+eXGSN5
         /fQq2btfTyZc95vwHuJHsh3vbZ5yjgQRNbeUWdBc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [RFT v3 5/8] ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos4412
Date:   Sat, 21 Sep 2019 19:01:49 +0200
Message-Id: <20190921170152.5033-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921170152.5033-1-krzk@kernel.org>
References: <20190921170152.5033-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi Core Timer node has interrupts routed to two different parents -
GIC and combiner.  This was modeled with a interrupt-map within a
subnode but can be expressed in an easier and more common way, directly
in the node itself.

Tested on Odroid U3 (Exynos4412).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412.dtsi | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 8b6d5875c75d..7e2dabefd53f 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -243,25 +243,21 @@
 			clock-names = "aclk200", "aclk400_mcuisp";
 		};
 
-		timer@10050000 {
+		mct: timer@10050000 {
 			compatible = "samsung,exynos4412-mct";
 			reg = <0x10050000 0x800>;
-			interrupt-parent = <&mct_map>;
-			interrupts = <0>, <1>, <2>, <3>, <4>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
-
-			mct_map: mct-map {
-				#interrupt-cells = <1>;
-				#address-cells = <0>;
-				#size-cells = <0>;
-				interrupt-map =
-					<0 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
+			#address-cells = <0>;
+			#size-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&mct>;
+			interrupts = <0>, <1>, <2>, <3>, <4>;
+			interrupt-map = <0 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
 					<1 &combiner 12 5>,
 					<2 &combiner 12 6>,
 					<3 &combiner 12 7>,
 					<4 &gic 1 12 IRQ_TYPE_LEVEL_HIGH>;
-			};
 		};
 
 		watchdog: watchdog@10060000 {
-- 
2.17.1

