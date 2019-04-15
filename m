Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF82C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B272218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555351536;
	bh=p+Gju4b5ddGOUIklS8hfpl4DdMRX+ORMuDAcQokaDNQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMTdVAtgHrlmBGk2NMA0k1red12z/B6n8xSWmTtzUlCwOfBHT9w+S4FoTRhQaDnZO
	 SFS4nSF/eSYdNO9xLkAw5pj9JRyaOWqx94WciY84d9kX2bOrjUL0u+FQudRYQcBIYR
	 qbF8AER/01TV5tvZU9GzoI0l76VTzADnDYfdOJs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfDOSFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfDOSFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:05:33 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A2D218EA;
        Mon, 15 Apr 2019 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555351533;
        bh=p+Gju4b5ddGOUIklS8hfpl4DdMRX+ORMuDAcQokaDNQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ghY9Zy5d7SwrzV4WiRejfX/MOsXSVIYHpWTMwl1e8MfYpWV0vSbX3vtSD2eVGwTsn
         Xc4D4y97gCBgxm9ThhD7F/xa5l3lU3egVYkQPfoY6dusEMs2onVxcNgkJVkjD+Mv+k
         UmmpCM/TU5WqIA9wkM9fSGjo5rAh/jVjejXbBw2g=
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
Subject: [RFT 4/4] ARM: dts: exynos: Properly override node to use MDMA0 on Universal C210
Date:   Mon, 15 Apr 2019 20:05:10 +0200
Message-Id: <20190415180510.6044-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415180510.6044-1-krzk@kernel.org>
References: <20190415180510.6044-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Universal C210 (Exynos4210) uses the secure interface of MDMA0,
instead of regular one - non-secure MDMA1.  DTS was overriding MDMA1
node address which caused DTC W=1 warning:

    arch/arm/boot/dts/exynos4.dtsi:707.25-716.6:
        Warning (simple_bus_reg): /soc/amba/mdma@12850000: simple-bus unit address format error, expected "12840000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 1c21627e3c3c..36ccf227434d 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -675,7 +675,7 @@
 			status = "disabled";
 		};
 
-		amba {
+		amba: amba {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 07d64a8f82e3..bf092e97e14f 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -177,6 +177,20 @@
 	};
 };
 
+&amba {
+	mdma0: mdma@12840000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x12840000 0x1000>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clock CLK_MDMA>;
+		clock-names = "apb_pclk";
+		#dma-cells = <1>;
+		#dma-channels = <8>;
+		#dma-requests = <1>;
+		power-domains = <&pd_lcd0>;
+	};
+};
+
 &camera {
 	status = "okay";
 
@@ -491,7 +505,8 @@
 };
 
 &mdma1 {
-	reg = <0x12840000 0x1000>;
+	/* Use the secure mdma0 */
+	status = "disabled";
 };
 
 &mixer {
-- 
2.17.1

