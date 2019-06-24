Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD30C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394F9204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561395268;
	bh=rfv1zxL8ny7uQ3JLqVgyxlfROKSzUzd/rwTWdUAIdv0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Tq8AzXIvxek1lJJ5P47SKFxPQ/uRSmqdr4Ts4ebSUY6Pv+oM55sWLo0Q/ND8WtBqQ
	 OmiiHjZrBwgfWktkkQ6czaOcX21HUVBUx3T1ZoZRSwzT1+igPw39irTD0JF41DaqaV
	 0wRaboVcgvdWfA9lqBlGlh2MxfTzO1b0MoCnUDIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbfFXQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfFXQy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:54:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C2F204FD;
        Mon, 24 Jun 2019 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561395264;
        bh=rfv1zxL8ny7uQ3JLqVgyxlfROKSzUzd/rwTWdUAIdv0=;
        h=From:To:Cc:Subject:Date:From;
        b=S3XFfWC/H1r1euWO6gFy5+0D1+J0La/SP+oSs2NyVAyuNoi//PI2rG6Wm4Tg6ZfxT
         q5a2r5Gnq07cacPhuY2UIBmn2uAL+ih0D0z09zz4v/xgghyznZBQsI8N7di1uuptaB
         H7pyAuaAgTRLHk/3JFa1123iWru6VSnaQNv7/Id4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3] ARM: dts: exynos: Add regulator suspend configuration to Odroid XU3/XU4/HC1 family
Date:   Mon, 24 Jun 2019 18:54:19 +0200
Message-Id: <20190624165419.4704-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PMIC regulator suspend configuration to entire Odroid
XU3/XU4/HC1 family of boards to reduce power usage during suspend.  The
configuration is based on vendor (Hardkernel) reference kernel with
additional buck9 suspend configuration (for USB hub suspend and proper
reset).

Energy consumption measurements from Marek Szyprowski during suspend to
RAM:
 - all at 5 V power supply,
 - before: next-20190620,
 - after: next-20190620 + this patch + suspend configuration for s2mps11
          regulator driver,

Board              | before [mA] | after [mA] |
Odroid HC1         |         120 |       7-10 |
Odroid XU4, sdcard |          88 |        6-9 |
Odroid XU4, eMMC   |         100 |        6-9 |

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>

---

Tested on XU3 and HC1 with SD card.

---

Changes since v2:
1. Suspend also buck9, as suggested by Anand.
2. Add Anand's tag.

Changes since v1:
1. Add Marek's tag.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 0f967259ad29..9843d21d6924 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -177,6 +177,10 @@
 				regulator-name = "vdd_adc";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo5_reg: LDO5 {
@@ -184,6 +188,10 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo6_reg: LDO6 {
@@ -191,6 +199,10 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo7_reg: LDO7 {
@@ -198,6 +210,10 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
@@ -205,6 +221,10 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo9_reg: LDO9 {
@@ -212,6 +232,10 @@
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo10_reg: LDO10 {
@@ -219,6 +243,10 @@
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo11_reg: LDO11 {
@@ -226,6 +254,10 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo12_reg: LDO12 {
@@ -239,6 +271,10 @@
 				regulator-name = "vddq_mmc2";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo14_reg: LDO14 {
@@ -253,6 +289,10 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
@@ -267,18 +307,30 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo18_reg: LDO18 {
 				regulator-name = "vdd_emmc_1V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo19_reg: LDO19 {
 				regulator-name = "vdd_sd";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
@@ -307,6 +359,10 @@
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo24_reg: LDO24 {
@@ -328,6 +384,10 @@
 				regulator-name = "vdd_ldo26";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3950000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo27_reg: LDO27 {
@@ -335,6 +395,10 @@
 				regulator-min-microvolt = <1000000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo28_reg: LDO28 {
@@ -342,6 +406,10 @@
 				regulator-name = "vdd_ldo28";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3950000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo29_reg: LDO29 {
@@ -420,6 +488,10 @@
 				regulator-max-microvolt = <1300000>;
 				regulator-always-on;
 				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -428,6 +500,10 @@
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck3_reg: BUCK3 {
@@ -436,6 +512,10 @@
 				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
@@ -444,6 +524,10 @@
 				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
@@ -460,6 +544,10 @@
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck7_reg: BUCK7 {
@@ -484,12 +572,20 @@
 				regulator-max-microvolt = <3750000>;
 				regulator-always-on;
 				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck10_reg: BUCK10 {
 				regulator-name = "vdd_vmem";
 				regulator-min-microvolt = <2850000>;
 				regulator-max-microvolt = <2850000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 		};
 	};
-- 
2.17.1

