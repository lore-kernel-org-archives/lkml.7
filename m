Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29099C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B2321530
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556559335;
	bh=W/GoX7yGvh8bG51wr9bb4gUdm7k34g84QPI9aUcc8+Q=;
	h=From:To:Subject:Date:List-ID:From;
	b=dcWS5pZA57/pYrqcOpD9Dfx/30lwp1GtFw/ZX6FpSy+1K2fD3ONMJ7AqncegRwDOl
	 JkopcISzrExXI4tnYn/Opovujm2xJOEijQluC9+sgKtpeQQfmCeQAusFUmsmKUV9Qk
	 FcveiRbCnY4pubs+6PWKQZYDAYk0KblAZJF8RYsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfD2Rfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfD2Rfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:35:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E182087B;
        Mon, 29 Apr 2019 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556559332;
        bh=W/GoX7yGvh8bG51wr9bb4gUdm7k34g84QPI9aUcc8+Q=;
        h=From:To:Subject:Date:From;
        b=azmhrkYJy7BbsRwpc1miEtNVhrmHJzqfJtmD2TrJwXpla9dQTAtMBYppjuaRHMUaG
         02T75tJ6yk1HU6h+7TsXKcLMykYIqBxLCeKq57A+H4t6yAWdID/JPJlHboJ+zu54Oj
         Gl+E34Y5hQRQdC+5f7Qa/H8Li6UBs3UAzvuo/owA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Move CPU OPP tables out of SoC node on Exynos5420
Date:   Mon, 29 Apr 2019 19:35:24 +0200
Message-Id: <20190429173524.4870-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpus node is a top-level node, not inside the soc.  Therefore its
OPP tables should be there as well.

This also fixes the DTC warnings like:

    arch/arm/boot/dts/exynos5420.dtsi:46.37-109.5:
        Warning simple_bus_reg): /soc/opp_table0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 216 +++++++++++++++---------------
 1 file changed, 109 insertions(+), 107 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 5fb2326875dc..16088186a33a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -42,117 +42,119 @@
 	 * by exynos5420-cpus.dtsi or exynos5422-cpus.dtsi.
 	 */
 
-	soc: soc {
-		cluster_a15_opp_table: opp_table0 {
-			compatible = "operating-points-v2";
-			opp-shared;
-			opp-1800000000 {
-				opp-hz = /bits/ 64 <1800000000>;
-				opp-microvolt = <1250000>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1700000000 {
-				opp-hz = /bits/ 64 <1700000000>;
-				opp-microvolt = <1212500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1600000000 {
-				opp-hz = /bits/ 64 <1600000000>;
-				opp-microvolt = <1175000>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1500000000 {
-				opp-hz = /bits/ 64 <1500000000>;
-				opp-microvolt = <1137500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1400000000 {
-				opp-hz = /bits/ 64 <1400000000>;
-				opp-microvolt = <1112500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1300000000 {
-				opp-hz = /bits/ 64 <1300000000>;
-				opp-microvolt = <1062500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1200000000 {
-				opp-hz = /bits/ 64 <1200000000>;
-				opp-microvolt = <1037500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1100000000 {
-				opp-hz = /bits/ 64 <1100000000>;
-				opp-microvolt = <1012500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1000000000 {
-				opp-hz = /bits/ 64 <1000000000>;
-				opp-microvolt = < 987500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-900000000 {
-				opp-hz = /bits/ 64 <900000000>;
-				opp-microvolt = < 962500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-800000000 {
-				opp-hz = /bits/ 64 <800000000>;
-				opp-microvolt = < 937500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-700000000 {
-				opp-hz = /bits/ 64 <700000000>;
-				opp-microvolt = < 912500>;
-				clock-latency-ns = <140000>;
-			};
+	cluster_a15_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1175000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1012500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = < 987500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = < 962500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = < 937500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = < 912500>;
+			clock-latency-ns = <140000>;
 		};
+	};
 
-		cluster_a7_opp_table: opp_table1 {
-			compatible = "operating-points-v2";
-			opp-shared;
-			opp-1300000000 {
-				opp-hz = /bits/ 64 <1300000000>;
-				opp-microvolt = <1275000>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1200000000 {
-				opp-hz = /bits/ 64 <1200000000>;
-				opp-microvolt = <1212500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1100000000 {
-				opp-hz = /bits/ 64 <1100000000>;
-				opp-microvolt = <1162500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-1000000000 {
-				opp-hz = /bits/ 64 <1000000000>;
-				opp-microvolt = <1112500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-900000000 {
-				opp-hz = /bits/ 64 <900000000>;
-				opp-microvolt = <1062500>;
-				clock-latency-ns = <140000>;
-			};
-			opp-800000000 {
-				opp-hz = /bits/ 64 <800000000>;
-				opp-microvolt = <1025000>;
-				clock-latency-ns = <140000>;
-			};
-			opp-700000000 {
-				opp-hz = /bits/ 64 <700000000>;
-				opp-microvolt = <975000>;
-				clock-latency-ns = <140000>;
-			};
-			opp-600000000 {
-				opp-hz = /bits/ 64 <600000000>;
-				opp-microvolt = <937500>;
-				clock-latency-ns = <140000>;
-			};
+	cluster_a7_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1275000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1212500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1162500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1112500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1062500>;
+			clock-latency-ns = <140000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1025000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <140000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <937500>;
+			clock-latency-ns = <140000>;
 		};
+	};
 
+	soc: soc {
 		cci: cci@10d20000 {
 			compatible = "arm,cci-400";
 			#address-cells = <1>;
-- 
2.17.1

