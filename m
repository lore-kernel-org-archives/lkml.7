Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C01208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561132741;
	bh=LrMmbFUNhbcgdUmpHgJVmzOPNpufte8XRveYDsh3I48=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iwr+RktNWmgC2b2ZtUwFNC6p3qNITHQunqRv31ugsSJ08r1Ey0v1oFwh/j97X7o57
	 oazBG7vtsREl3v/Qvg2zqpfSzGgpwENYnDhIAn6udwlbK/EpDLIZxS6ClndlI4x3Ns
	 1bTOmE2hVxjHA3UNleiMrx44SiHDHKHfJCEmg1jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUP7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUP67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:58:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5308821530;
        Fri, 21 Jun 2019 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561132738;
        bh=LrMmbFUNhbcgdUmpHgJVmzOPNpufte8XRveYDsh3I48=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=171YLbmdcQQXB2+6BfLx/bV95awcO65JBsWUJfkCg3rT/b3LWc5miSb5IElimE695
         vH6uchSq5iycLp3u034XRF3zupsNXy4wuFyy4tSWcNuOnKTvRxEsABocFS/bad62zj
         niZboHvZVt/eCy2lSL4nGArv/J6dpnjlKgCXa8jw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM: dts: exynos: Add regulator suspend configuration to Arndale Octa board
Date:   Fri, 21 Jun 2019 17:58:43 +0200
Message-Id: <20190621155845.7079-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621155845.7079-1-krzk@kernel.org>
References: <20190621155845.7079-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PMIC regulator suspend configuration to Arndale Octa board to
reduce power usage during suspend and keep necessary regulators on.  The
configuration is based on vendor (Insignal) reference kernel and the
board datasheet.  Comparing to vendor kernel, additionally turn off in
suspend all regulators controlled by external pin (LDO3, LDO7, LDO18 and
buck10).

This is purely for hardware description because board does not support
Suspend to RAM and the S2MPS11 driver does not support
"regulator-on-in-suspend" property.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---
Changes since v1:
1. Turn off LDO3, LDO7, LDO18 and buck10. Add comment about LDO3 and
buck10.
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index dc9162a17475..3126a6c3f842 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -386,6 +386,10 @@
 				 * (Linaro for Arndale Octa, v2012.07).
 				 */
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo4_reg: LDO4 {
@@ -411,6 +415,10 @@
 				regulator-name = "PVDD_ANAIP_1V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo8_reg: LDO8 {
@@ -451,6 +459,10 @@
 				regulator-name = "PVDD_APIO_MMCOFF_2V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo14_reg: LDO14 {
@@ -464,12 +476,20 @@
 				regulator-name = "PVDD_PERI_2V8";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo16_reg: LDO16 {
 				regulator-name = "PVDD_PERI_3V3";
 				regulator-min-microvolt = <2200000>;
 				regulator-max-microvolt = <2200000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo17_reg: LDO17 {
@@ -483,12 +503,28 @@
 				regulator-name = "PVDD_EMMC_1V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				/*
+				 * Must stay in "off" mode during shutdown for
+				 * proper eMMC reset.  The "off" mode is in
+				 * fact controlled by LDO18EN.  The eMMC does
+				 * not have reset pin connected so the reset
+				 * will be triggered by falling edge of
+				 * LDO18EN.
+				 */
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo19_reg: LDO19 {
 				regulator-name = "PVDD_TFLASH_2V8";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			ldo20_reg: LDO20 {
@@ -515,12 +551,20 @@
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo24_reg: LDO24 {
 				regulator-name = "PVDD_CAM1_AVDD_2V8";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo25_reg: LDO25 {
@@ -540,6 +584,10 @@
 				regulator-name = "PVDD_G3DS_1V0";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1100000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
 			};
 
 			ldo28_reg: LDO28 {
@@ -617,6 +665,10 @@
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck2_reg: BUCK2 {
@@ -624,6 +676,10 @@
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck3_reg: BUCK3 {
@@ -631,12 +687,20 @@
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck4_reg: BUCK4 {
 				regulator-name = "PVDD_G3D_1V0";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1400000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck5_reg: BUCK5 {
@@ -651,6 +715,10 @@
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 
 			buck7_reg: BUCK7 {
@@ -678,6 +746,18 @@
 				regulator-name = "PVDD_EMMCF_2V8";
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
+				/*
+				 * Must stay in "off" mode during shutdown for
+				 * proper eMMC reset.  The "off" mode is in
+				 * fact controlled by BUCK10EN.  The eMMC does
+				 * not have reset pin connected so the reset
+				 * will be triggered by falling edge of
+				 * BUCK10EN.
+				 */
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
 			};
 		};
 	};
-- 
2.17.1

