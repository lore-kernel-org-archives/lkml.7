Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880ADC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CBA20836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552143661;
	bh=vRDXv7E8Trcrbs2HQNoLshZvsVr14Hp+aVdiDAUomXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+y5J9Ay7PTo8gZAM+zIuhUZv4ZyffI4oBJK+8u8fAWLv2U5wx07MMWU7PvBFEY/O
	 B6B6TL0yM/K0iUXRF4uKMgT8BBelmsTI/7KKvX1DL55Xg7XqO70srRvwtUKwC2eXvR
	 Nax9omwpVd53OrCaP6RqKcvtwgHrnFGCgxb5VfxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCIPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfCIPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:00:56 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3900220836;
        Sat,  9 Mar 2019 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552143656;
        bh=vRDXv7E8Trcrbs2HQNoLshZvsVr14Hp+aVdiDAUomXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KI96qB+Rqtg9DTHp4QFErGgXFtDRKIUUOm+QCqW+SBlzN17gt1/Wqvd++DqII44lB
         1/aVZlJdgduKgo9ZuUarCMeRAsZVulaWsaXhvYR9EO/eAdoO48PbQ4wAzilSnHZvZI
         UYjr0aqLiHg2XneijOVvbLHhq8zVH2EEpHJHO3z0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/3] ARM: dts: exynos: Extend the eMMC node on Arndale Octa
Date:   Sat,  9 Mar 2019 16:00:39 +0100
Message-Id: <20190309150039.8705-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309150039.8705-1-krzk@kernel.org>
References: <20190309150039.8705-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe properly the MMC0 node (with attached embedded MMC memory) on
Arndale Node by:
1. Adding the regulator for host interface (although it still has to be
   "always-on" so the board with Linaro U-Boot will boot;
2. Using "non-removable" instead of "broken-cd" property, because eMMC
   is embedded into the board;
3. Adding support for HS200 v1.8 to indicate support in host controller
   although this has no practical effect (embedded memory does not
   support it).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 96a0eb73a99b..56a42c68bc39 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -378,6 +378,12 @@
 				regulator-name = "PVDD_APIO_MMCON_1V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				/*
+				 * Must be always on, even though there is
+				 * a consumer (mmc_0).  Otherwise the board
+				 * does not reboot with vendor U-Boot
+				 * (Linaro for Arndale Octa, v2012.07).
+				 */
 				regulator-always-on;
 			};
 
@@ -685,7 +691,7 @@
 
 &mmc_0 {
 	status = "okay";
-	broken-cd;
+	non-removable;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
@@ -693,8 +699,10 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
 	vmmc-supply = <&ldo10_reg>;
+	vqmmc-supply = <&ldo3_reg>;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
 };
 
 &mmc_2 {
-- 
2.17.1

