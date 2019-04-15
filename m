Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EE3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A94218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555351532;
	bh=l4XMiaNiO78BUZsNjl18aNcG4OJuYR7E2VVhQzGVGxk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J4xCDJlO5ktkZD62tRugP8UbtBYE87VN3s4FrmqHu+lG1pfrod5295HbJkJDgRfLR
	 Br1Fh43DdDmh5Q/WYQsTnwSObuzfzG9LD+zqTK+/gBcxjRoGpbx0b91SuaD/4Ydbd/
	 woO8arGUGkiPP44c+hlpQ9mFf/2hqn6vvx/fwxS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfDOSFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfDOSF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:05:29 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74AC218A1;
        Mon, 15 Apr 2019 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555351528;
        bh=l4XMiaNiO78BUZsNjl18aNcG4OJuYR7E2VVhQzGVGxk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QAnrBwLQxbueVN5byEHd3TuOuAU5GGO/G92lOnkAksh8tp/Lx4VlG1zqH/HKaFX6y
         rlOSAP+3JxnUsHiQZrZJu1DDcdIFs/0f43QX9mOxO8AO940zQssd+HLx9ItcS/MuCd
         jqYZS3sHgz8ytilGpf0Z2O/z6zwLt1U3jvmOv+js=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 3/4] ARM: dts: exynos: Move fixed-clocks out of soc on Exynos3250
Date:   Mon, 15 Apr 2019 20:05:09 +0200
Message-Id: <20190415180510.6044-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415180510.6044-1-krzk@kernel.org>
References: <20190415180510.6044-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The three fixed-clocks (xusbxti, xxti and xtcxo) are inputs to the
Exynos3250 therefore they should not be inside the soc node.  This also
fixes DTC W=1 warning:

    arch/arm/boot/dts/exynos3250.dtsi:112.21-139.5:
        Warning (simple_bus_reg): /soc/fixed-rate-clocks: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 58 +++++++++++++++----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 6e74e6815b01..8ce3a7786b19 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -97,6 +97,35 @@
 		};
 	};
 
+	fixed-rate-clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		xusbxti: clock@0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "xusbxti";
+		};
+
+		xxti: clock@1 {
+			compatible = "fixed-clock";
+			reg = <1>;
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "xxti";
+		};
+
+		xtcxo: clock@2 {
+			compatible = "fixed-clock";
+			reg = <2>;
+			clock-frequency = <0>;
+			#clock-cells = <0>;
+			clock-output-names = "xtcxo";
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a7-pmu";
 		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -109,35 +138,6 @@
 		#size-cells = <1>;
 		ranges;
 
-		fixed-rate-clocks {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			xusbxti: clock@0 {
-				compatible = "fixed-clock";
-				reg = <0>;
-				clock-frequency = <0>;
-				#clock-cells = <0>;
-				clock-output-names = "xusbxti";
-			};
-
-			xxti: clock@1 {
-				compatible = "fixed-clock";
-				reg = <1>;
-				clock-frequency = <0>;
-				#clock-cells = <0>;
-				clock-output-names = "xxti";
-			};
-
-			xtcxo: clock@2 {
-				compatible = "fixed-clock";
-				reg = <2>;
-				clock-frequency = <0>;
-				#clock-cells = <0>;
-				clock-output-names = "xtcxo";
-			};
-		};
-
 		sysram@2020000 {
 			compatible = "mmio-sram";
 			reg = <0x02020000 0x40000>;
-- 
2.17.1

