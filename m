Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F1C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18118215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561808873;
	bh=QqIK/wq6CAql+1yE4dVAaHOMSzbguVlkuNzXU6IwT04=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0U2HhoTFi4KyuTH+NwjI/l8aKYw2fPVDnwYBvzs3ZGzF3y2LdC5fkjoAt7JHLgbtc
	 jQe9CUjWuzlh39+DDrXAmeRd2vAmPkgBCEn3DOvbRlOVkjU9FmA17o607V8yLKTTVs
	 8LpFBSVR0wk9CJ2bQPq3RmpynwG9KRUhnRqgUVpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfF2Lrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 07:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfF2Lrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:47:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DED40216FD;
        Sat, 29 Jun 2019 11:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561808868;
        bh=QqIK/wq6CAql+1yE4dVAaHOMSzbguVlkuNzXU6IwT04=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ibEz1k48uMtAiph2Ifwow6bIPoOdD3jtTVIAv4F1J3UbzO2reCAVFZWWSnVXXkT16
         KvXjFDAXtVeItjYQde/3pLUG60sGiLigN9MC0qEestV6iwBu9s9n/9e7lX/4YKHt+f
         t657is9fPiPtorrqfT3mfvRlgv/RyHFEbMWc+a+w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: exynos: Adjust buck[78] regulators to supported values on Arndale Octa
Date:   Sat, 29 Jun 2019 13:47:39 +0200
Message-Id: <20190629114739.11702-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629114739.11702-1-krzk@kernel.org>
References: <20190629114739.11702-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet of S2MPS11 PMIC is slightly non-consistent in buck[78]
voltage regulators values.

1. The voltage tables for configuring their registers mention range of
   voltages: 0.750 V to 3.55 V,
2. The constrains in electrical specifications say output voltage range
   to be different (buck7: 1.2 V to 1.5 V, buck8: 1.8 V to 2.1 V).

Adjust the ranges to match the electrical specifications to stay on the
safe side.  Anyway these regulators stay at default value so this should
not have effect.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index ac7f2fa0ba22..592d7b45ecc8 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -723,15 +723,15 @@
 
 			buck7_reg: BUCK7 {
 				regulator-name = "VIN_LLDO_1V4";
-				regulator-min-microvolt = <800000>;
+				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
 			buck8_reg: BUCK8 {
 				regulator-name = "VIN_MLDO_2V0";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <2000000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2100000>;
 				regulator-always-on;
 			};
 
-- 
2.17.1

