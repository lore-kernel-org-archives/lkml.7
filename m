Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882FFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4FD20851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552143653;
	bh=XaQBhbVoJPfbkfttqCPBRg15wXTePmHlhnlW6AdV4bg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Mh/FVWxmT9UOpHeBGs6vdrRSF9LvaR7JQbw4ca+jY0EDuMgiU328+5wQO/ITh3VWk
	 JKjWbl6CCZjKPV9d4cjWEfMxIWOwIEjBbo/2gsBNg9g44M3FYMX98/0yvdZz7bxbjv
	 9sqAmnBKggZWDv7Qm9FtvbA8eGLhJdbuTPo5SZos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCIPAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:00:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfCIPAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:00:51 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D21B20836;
        Sat,  9 Mar 2019 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552143651;
        bh=XaQBhbVoJPfbkfttqCPBRg15wXTePmHlhnlW6AdV4bg=;
        h=From:To:Cc:Subject:Date:From;
        b=mPrpb05UQQwk3QhOKAVv8PttEmDhoAwRMV9ZHkdAdcPQvP7q87qz3jeE86cuNve49
         MW3xT1lPmMec5vzDUYp37rExv/FGH+hIJUtpych7DstnXuS7Gkaj/zvOtqCQbwck8Q
         eOSVRc+ZkKxtTuITXP1DcfTWSoTdgLIeUn2Rqu2Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/3] ARM: dts: exynos: Adjust ldo23 and ldo27 to lower levels on Arndale Octa
Date:   Sat,  9 Mar 2019 16:00:37 +0100
Message-Id: <20190309150039.8705-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although on the schematics of Insignal Arndale Octa board the
PVDD_MIFS_1V1 (ldo23) and PVDD_G3DS_1V0 (ldo27) are marked as 1.2 V, the
vendor v3.4 Android kernel sets them lower.  Also name suggests that
they should work on 1.1 V and 1.0 V respectively, not 1.2 V.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 6f5e6e2fde22..751e772b5710 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -504,8 +504,8 @@
 
 			ldo23_reg: LDO23 {
 				regulator-name = "PVDD_MIFS_1V1";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 			};
 
@@ -530,8 +530,8 @@
 
 			ldo27_reg: LDO27 {
 				regulator-name = "PVDD_G3DS_1V0";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
 			};
 
 			ldo28_reg: LDO28 {
-- 
2.17.1

