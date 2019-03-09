Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F02C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CB22086A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552143656;
	bh=LRTTlB8gN0bCiT/Z5/Z5zKrrv4H9gWR0WlKFUoTncQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0R/GfvEKM7iHr3iip5OQO0H6/z4SlrQAyUmDn/S75x0s4t/OSUBYtq/2SfCHokWI
	 F/GA206YObUI2XC9mu4V+OcFvMEe5FVS5nxgn3zIAjwfkfRs7SvRkdp/GNDmIoTNMQ
	 gWjca8Tu9JDS8VCDsSypyVHnjnmXNqc/loGDBXLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCIPAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfCIPAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:00:54 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28B02086A;
        Sat,  9 Mar 2019 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552143653;
        bh=LRTTlB8gN0bCiT/Z5/Z5zKrrv4H9gWR0WlKFUoTncQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSqfghuQv7csGCG4TGspObExhyO+mgta9dOMukV1wTmeNdSFhZ5mgIszzpaXh810n
         FYfSvlriYqZhE3KgChWsMJRqmVM+MDoakk7OKiN2PFvyrgc7oBq2625Xza0rCU3yXg
         Ao5P/6ZEjVJv3v+lZl5dGnh86pbvmD1TxzeVhyOM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/3] ARM: dts: exynos: Add support for UHS-I SD cards on Arndale Octa
Date:   Sat,  9 Mar 2019 16:00:38 +0100
Message-Id: <20190309150039.8705-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309150039.8705-1-krzk@kernel.org>
References: <20190309150039.8705-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos5420's Mobile Storage Host supports SD cards in UHS-I standard
(SD specification v3.0), with 1.8 V signaling in SD UHS DDR50.  Adjust
the regulator and add necessary capability properties.  Change the SDR
and DDR timings to match values in Insignal v3.4 Android kernel.

Tested with SD UHS-I card in SD UHS DDR50 mode.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 751e772b5710..96a0eb73a99b 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -441,7 +441,7 @@
 
 			ldo13_reg: LDO13 {
 				regulator-name = "PVDD_APIO_MMCOFF_2V8";
-				regulator-min-microvolt = <2800000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <2800000>;
 			};
 
@@ -701,14 +701,17 @@
 	status = "okay";
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
-	samsung,dw-mshc-sdr-timing = <2 3>;
-	samsung,dw-mshc-ddr-timing = <1 2>;
+	samsung,dw-mshc-sdr-timing = <0 4>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 };
 
 &pinctrl_0 {
-- 
2.17.1

