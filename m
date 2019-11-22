Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52640C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B2E2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574444514;
	bh=HbtGDWVqT6RINptsr4QdRRG5JyZvL6Y5ZfA3QFTTrxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tQHJp4Blbx2LRF0B99S4sMrFK3uvx8CNGOczkRwtOQLRfrKcDopx5VmHXhAMDGqck
	 gRcZ06eX3YFUU6Lz2XabUlSx5HUvFTJiIlGUqVlr7k+ZB+FH7ReAjaTyX+JBKSov1z
	 U7nk6Y47XJKio1Qph7euEs4WeM+mJY6rTyGomoKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfKVRlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfKVRlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:41:53 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFFD205C9;
        Fri, 22 Nov 2019 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574444512;
        bh=HbtGDWVqT6RINptsr4QdRRG5JyZvL6Y5ZfA3QFTTrxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4I7dBaZKmPNfgNkHj3p5SYZ580WTfFb41b4Ml6YiqL30G1arS1GgdKFq8YoW11WK
         XkbJBolt+sIkz/1aPda8+Rwf10Pnkghqqaj9hQy7S9JFj8oe1yf5zR0G6wocutN0eg
         EqMcwa0JUpbTsj7wqO+Bg3q9UWxKHvQtrkFCQ2EI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     will@kernel.org
Cc:     bhelgaas@google.com, gregkh@linuxfoundation.org,
        iommu@lists.linuxfoundation.org, isaacm@codeaurora.org,
        jcrouse@codeaurora.org, jean-philippe@linaro.org,
        john.garry@huawei.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, saravanak@google.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] iommu/arm-smmu: support SMMU module probing from the IORT
Date:   Fri, 22 Nov 2019 18:41:25 +0100
Message-Id: <20191122174125.21030-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SMMU drivers built as modules to the ACPI/IORT device
probing path, by deferring the probe of the master if the SMMU driver is
known to exist but has not been loaded yet. Given that the IORT code
registers a platform device for each SMMU that it discovers, we can
easily trigger the udev based autoloading of the SMMU drivers by making
the platform device identifier part of the module alias.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/acpi/arm64/iort.c   | 4 ++--
 drivers/iommu/arm-smmu-v3.c | 1 +
 drivers/iommu/arm-smmu.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 5a7551d060f2..a696457a9b11 100644
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
index 7669beafc493..bf6a1e8eb9b0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3733,4 +3733,5 @@ module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will@kernel.org>");
+MODULE_ALIAS("platform:arm-smmu-v3");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d55acc48aee3..db5106b0955b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2292,4 +2292,5 @@ module_platform_driver(arm_smmu_driver);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will@kernel.org>");
+MODULE_ALIAS("platform:arm-smmu");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

