Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948D6206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757085;
	bh=Ou1QSenIX/ZPR01QhZ3Eov9oYA+rmJXBLNuMfDc7+GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZ0ZEh0HP6HwMzODA3EThRCPLyJBk5o87O08MCrLlpdU1PBVM/os1jzCmFMO3eD7o
	 RsBaAvLVY1G2+Yd4saOnYSrzcwhfrRQ0Huk1hIkbta1BB/6UvoGInUu5aO46LbWFB6
	 Cg1vFTvLUuOs08BAHh95xoR/G9XMgPri+oxbVefI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfLSMEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfLSMEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:41 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53A924688;
        Thu, 19 Dec 2019 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757081;
        bh=Ou1QSenIX/ZPR01QhZ3Eov9oYA+rmJXBLNuMfDc7+GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGIC12OyAsd4qU9XFvo2hKhdFDR9Iq/fk+P3S0i7ojRAectu6hh+ois+Lzktyw5f/
         Ta74IyXCFRoLCd+dXC6b7ZYEVdYREYyDXK/htuqb69Ij06HpRZgVrePBtP9qT1l1ky
         9DyZQAGzSu+zJBQDSgrsS61n16Wrg8p2OIKFHAkU=
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
Subject: [PATCH v4 14/16] iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
Date:   Thu, 19 Dec 2019 12:03:50 +0000
Message-Id: <20191219120352.382-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing the SMMU driver, we need to clear any state that we
registered during probe. This includes our bus ops, sysfs entries and
the IOMMU device registered for early firmware probing of masters.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu.c | 50 ++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5d2f60bb9e50..1f0c09bf112a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2009,25 +2009,51 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static void arm_smmu_bus_init(void)
+static int arm_smmu_bus_init(struct iommu_ops *ops)
 {
+	int err;
+
 	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+	if (!iommu_present(&platform_bus_type)) {
+		err = bus_set_iommu(&platform_bus_type, ops);
+		if (err)
+			return err;
+	}
 #ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype))
-		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+	if (!iommu_present(&amba_bustype)) {
+		err = bus_set_iommu(&amba_bustype, ops);
+		if (err)
+			goto err_reset_platform_ops;
+	}
 #endif
 #ifdef CONFIG_PCI
 	if (!iommu_present(&pci_bus_type)) {
 		pci_request_acs();
-		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+		err = bus_set_iommu(&pci_bus_type, ops);
+		if (err)
+			goto err_reset_amba_ops;
 	}
 #endif
 #ifdef CONFIG_FSL_MC_BUS
-	if (!iommu_present(&fsl_mc_bus_type))
-		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
+	if (!iommu_present(&fsl_mc_bus_type)) {
+		err = bus_set_iommu(&fsl_mc_bus_type, ops);
+		if (err)
+			goto err_reset_pci_ops;
+	}
+#endif
+	return 0;
+
+err_reset_pci_ops: __maybe_unused;
+#ifdef CONFIG_PCI
+	bus_set_iommu(&pci_bus_type, NULL);
 #endif
+err_reset_amba_ops: __maybe_unused;
+#ifdef CONFIG_ARM_AMBA
+	bus_set_iommu(&amba_bustype, NULL);
+#endif
+err_reset_platform_ops: __maybe_unused;
+	bus_set_iommu(&platform_bus_type, NULL);
+	return err;
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
@@ -2173,7 +2199,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	 * ready to handle default domain setup as soon as any SMMU exists.
 	 */
 	if (!using_legacy_binding)
-		arm_smmu_bus_init();
+		return arm_smmu_bus_init(&arm_smmu_ops);
 
 	return 0;
 }
@@ -2187,7 +2213,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 static int arm_smmu_legacy_bus_init(void)
 {
 	if (using_legacy_binding)
-		arm_smmu_bus_init();
+		return arm_smmu_bus_init(&arm_smmu_ops);
 	return 0;
 }
 device_initcall_sync(arm_smmu_legacy_bus_init);
@@ -2202,6 +2228,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
+	arm_smmu_bus_init(NULL);
+	iommu_device_unregister(&smmu->iommu);
+	iommu_device_sysfs_remove(&smmu->iommu);
+
 	arm_smmu_rpm_get(smmu);
 	/* Turn the thing off */
 	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, sCR0_CLIENTPD);
-- 
2.24.1.735.g03f4e72817-goog

