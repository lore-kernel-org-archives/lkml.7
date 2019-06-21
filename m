Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B256C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029572089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561132738;
	bh=7XFF/9p+dYOYssFeDHiKPhmpzkHKkQfC0rOFxlDqZKo=;
	h=From:To:Subject:Date:List-ID:From;
	b=LsnoSbcQWx8zIoCwIG5bYHSFyl3JUTQwzYWUfBZeJ5ArqJQEBcfGna0ZekL02NAlH
	 cbHSTMxVQhvdj6hOEky2aEN3CPNQun5GU6nXTlky+2pizjPMazvSjlxwoOen5+1ZLB
	 eWHf6WGep0xPD6NpMBz7dAMmz2gKoHZqW2X7k+J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfFUP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUP64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:58:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7C8206B7;
        Fri, 21 Jun 2019 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561132735;
        bh=7XFF/9p+dYOYssFeDHiKPhmpzkHKkQfC0rOFxlDqZKo=;
        h=From:To:Subject:Date:From;
        b=nCCbG66mlF9/FT/MMmVUwArOmDcJsgQD3NUalhRzU6LxSnJ7YwPx68wR2F9R9MIOZ
         r4jxw8/eJorPcIPjui3P8gwvKh5KnB+1v9g/BU5EgwmlFy0d82jayxaA76RvEtSmo4
         xygb5w2udm6p89vzImMBvuVqJgBas2sli9wHNXmY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ARM: dts: exynos: Disable unused buck10 regulator on Odroid HC1 board
Date:   Fri, 21 Jun 2019 17:58:42 +0200
Message-Id: <20190621155845.7079-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eMMC memory on Odroid XU3/XU4 boards is supplied by two regulators
LDO18 and buck10 (and LDO13 for the host interface).

However the Odroid HC1 board does not have eMMC connector so this
regulator does not have to be always on.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 2 --
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 25d95de15c9b..0f967259ad29 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -490,8 +490,6 @@
 				regulator-name = "vdd_vmem";
 				regulator-min-microvolt = <2850000>;
 				regulator-max-microvolt = <2850000>;
-				regulator-always-on;
-				regulator-boot-on;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 93a48f2dda49..838872037493 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -360,6 +360,12 @@
 	};
 };
 
+&buck10_reg {
+	/* Supplies vmmc-supply of mmc_0 */
+	regulator-always-on;
+	regulator-boot-on;
+};
+
 &hdmi {
 	status = "okay";
 	ddc = <&i2c_2>;
-- 
2.17.1

