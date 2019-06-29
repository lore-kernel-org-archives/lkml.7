Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F99C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1218321670
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561808869;
	bh=jzISek9/BxlkfR4QsZijiOWmURElEaC0O0/FFoqJpTQ=;
	h=From:To:Subject:Date:List-ID:From;
	b=mdIMmcvr0pAAwclyFjYlzd/4DKc5fMPsllOncQyO88bFchT6RaDsRocXUOu4rl8Wh
	 aK2BWWesC7dhNbVmqexw7CK62Kqubxqxj/QfJxoSHex/9lbiLziaLw1UfNM7X5u24c
	 m6Pg9QhKNXpWcyX2KLRsv+vmvl3uqV4SOiTzw0F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfF2Lrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 07:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfF2Lrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 07:47:47 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA47E214AF;
        Sat, 29 Jun 2019 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561808866;
        bh=jzISek9/BxlkfR4QsZijiOWmURElEaC0O0/FFoqJpTQ=;
        h=From:To:Subject:Date:From;
        b=UvAdY2AjJpr49kfKWnEt8gAtDmfvd6Fj+NLpXCAujRNCkhmVcgeWcI1vNR71At5/C
         OaoO6jGbA+Xm+29mz2BBgkvtTGCd8nMtrJYVcS5fwWv0505hWWB/U0039EpnpJnXYR
         0+9lEyTxm+fc4MJBIHzL2OHIyRN33wfP8klK2Euw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: exynos: Adjust buck[78] regulators to supported values on Odroid XU3 family
Date:   Sat, 29 Jun 2019 13:47:38 +0200
Message-Id: <20190629114739.11702-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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
safe side.  Also change the name of regulators to match reality.  Anyway
these regulators stay at default value so this should not have effect.

Reported-by: Anand Moon <linux.amoon@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 9843d21d6924..829147e320e0 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -551,17 +551,17 @@
 			};
 
 			buck7_reg: BUCK7 {
-				regulator-name = "vdd_1.0v_ldo";
-				regulator-min-microvolt = <800000>;
+				regulator-name = "vdd_1.35v_ldo";
+				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
 
 			buck8_reg: BUCK8 {
-				regulator-name = "vdd_1.8v_ldo";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <2000000>;
+				regulator-name = "vdd_2.0v_ldo";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2100000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
-- 
2.17.1

