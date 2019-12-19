Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113E0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DFC222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757097;
	bh=ZWu/BRMh45ey2/+NOodYySlbK+BJsxdZgItFNtS2Vzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mcct3nCfUlsGPV8kSMNd247blD8+iPzjQ/OwRW+YLT31PyP1w2rivCym74oI6iAyW
	 4AZq8UjTn37JJiuJ5DK4sCqtZkkKu0YQP3CDyvlPfe2DiB3z5izEPtxacZN1TpV233
	 YHsFsTHMMlE39VRR76iH8YBjjVBOilaKy1OAxRgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLSME5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfLSMEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:36 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0272524684;
        Thu, 19 Dec 2019 12:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757075;
        bh=ZWu/BRMh45ey2/+NOodYySlbK+BJsxdZgItFNtS2Vzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4buwxKD9N1mp2Bklv1roxu3ObpRgjzsbf0LGyVbNONyxjW7apNDAHSTSbQb4Ht3Z
         HMkrmKiXWR56IInnoR70ShrQZkwW7+unCDsJCqcmBPIbaYB1tOEluqq9Ead3czW6k8
         0s5Mg90QZqAtzJh8+m4nAJ42Egl4Uk8mrGPrzmwM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v4 12/16] iommu/arm-smmu: Support SMMU module probing from the IORT
Date:   Thu, 19 Dec 2019 12:03:48 +0000
Message-Id: <20191219120352.382-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Add support for SMMU drivers built as modules to the ACPI/IORT device
probing path, by deferring the probe of the master if the SMMU driver is
known to exist but has not been loaded yet. Given that the IORT code
registers a platform device for each SMMU that it discovers, we can
easily trigger the udev based autoloading of the SMMU drivers by making
the platform device identifier part of the module alias.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: John Garry <john.garry@huawei.com> # only manual smmu ko loading
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/acpi/arm64/iort.c   | 4 ++--
 drivers/iommu/arm-smmu-v3.c | 1 +
 drivers/iommu/arm-smmu.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 33f71983e001..4a560fdf7386 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -850,9 +850,9 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 {
 	switch (type) {
 	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
+		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
 	case ACPI_IORT_NODE_SMMU:
-		return IS_BUILTIN(CONFIG_ARM_SMMU);
+		return IS_ENABLED(CONFIG_ARM_SMMU);
 	default:
 		pr_warn("IORT node type %u does not describe an SMMU\n", type);
 		return false;
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 46160a2fec3e..da9474a02668 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3734,4 +3734,5 @@ module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_ALIAS("platform:arm-smmu-v3");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5cbee88a3b83..5d2f60bb9e50 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2281,4 +2281,5 @@ module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_ALIAS("platform:arm-smmu");
 MODULE_LICENSE("GPL v2");
-- 
2.24.1.735.g03f4e72817-goog

