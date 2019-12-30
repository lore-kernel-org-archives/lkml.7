Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB740C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5120206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726796;
	bh=WI3AUEHv2mSX/rTgYvCDyLE6KFEp215twOVaWTDYKaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUfg6n28g/svCnO70IGH7ll4ILvv1sRD5VmZb9qkzHGFdxngbPClyod9JXa2J/8gk
	 Jpe3MC/X/0CfsrFD76+S0rXfJ+sN0SFFlYST2WTrraoeacLZM+weEsD6aQmQgBwbUh
	 1p7M/bD+BKAwDDIznszwg08kshA8EsQ1LzSPtK/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfL3R0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfL3R0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:26:34 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD5E20730;
        Mon, 30 Dec 2019 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726793;
        bh=WI3AUEHv2mSX/rTgYvCDyLE6KFEp215twOVaWTDYKaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ztprat6+2eMdb9X7G5j1siqsB9e3xMO55Md9+qDr8sGe7WzbaMmbqDQLhJXQmFm1j
         S9dq9mJqNu0mQ6fDQaBpjtww0njsAut5iW1wSFnt11UcrZZfYA11/Fcv+D10iQ8EIa
         Uzu15c6R1mhrOCXeLD595LB06GqLdoyu73tj33RY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] iommu: Enable compile testing for some of drivers
Date:   Mon, 30 Dec 2019 18:26:19 +0100
Message-Id: <20191230172619.17814-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230172619.17814-1-krzk@kernel.org>
References: <20191230172619.17814-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the IOMMU drivers can be compile tested to increase build
coverage.  The OMAP, Rockchip and Exynos drivers use
device.dev_archdata.iommu field which does not exist on all platforms.
The sPAPR TCE and ARM SMMU have also restrictions where they can be
built.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0b9d78a0f3ac..fa27192ad166 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -260,7 +260,7 @@ config IRQ_REMAP
 # OMAP IOMMU support
 config OMAP_IOMMU
 	bool "OMAP IOMMU Support"
-	depends on ARM && MMU
+	depends on ARM && MMU || (COMPILE_TEST && (ARM || ARM64 || IA64 || SPARC))
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select IOMMU_API
 	---help---
@@ -278,7 +278,7 @@ config OMAP_IOMMU_DEBUG
 
 config ROCKCHIP_IOMMU
 	bool "Rockchip IOMMU Support"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || (COMPILE_TEST && (ARM64 || IA64 || SPARC))
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
@@ -312,7 +312,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && MMU
+	depends on ARCH_EXYNOS && MMU || (COMPILE_TEST && (ARM || ARM64 || IA64 || SPARC))
 	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
@@ -348,7 +348,7 @@ config IPMMU_VMSA
 
 config SPAPR_TCE_IOMMU
 	bool "sPAPR TCE IOMMU Support"
-	depends on PPC_POWERNV || PPC_PSERIES
+	depends on PPC_POWERNV || PPC_PSERIES || (PPC && COMPILE_TEST)
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -357,7 +357,7 @@ config SPAPR_TCE_IOMMU
 # ARM IOMMU support
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
-	depends on (ARM64 || ARM) && MMU
+	depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) && MMU
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
@@ -415,7 +415,7 @@ config S390_IOMMU
 
 config S390_CCW_IOMMU
 	bool "S390 CCW IOMMU Support"
-	depends on S390 && CCW
+	depends on S390 && CCW || COMPILE_TEST
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -423,7 +423,7 @@ config S390_CCW_IOMMU
 
 config S390_AP_IOMMU
 	bool "S390 AP IOMMU Support"
-	depends on S390 && ZCRYPT
+	depends on S390 && ZCRYPT || COMPILE_TEST
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
@@ -431,7 +431,7 @@ config S390_AP_IOMMU
 
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
-	depends on ARM || ARM64
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
-- 
2.17.1

