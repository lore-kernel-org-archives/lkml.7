Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54670C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C708208CE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574337000;
	bh=7WtNBj2cxDsm8FZRgal0cZFFQ2WqduNL4hBNbu0huqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oMTqgdZnVObSqL9OAt/Sqvy3xKKeIFar1kvsTIb/BPqf0BSvnwcAuR5lB5LFAalwR
	 DdzlfqoM/2z+rGL3r14FXB4B8GfboBi08ZJoChAo7BINA4w1/MNMsL3jg4VMm3hrhO
	 9hUKDnu7CBLVV325HWGrHQEmg0K6fYvgICB0AkB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfKULt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfKULt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:57 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3430208A1;
        Thu, 21 Nov 2019 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336996;
        bh=7WtNBj2cxDsm8FZRgal0cZFFQ2WqduNL4hBNbu0huqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFzvYh9y6u9wOC8R27hMSN8xc916+GErcpKnpDzte/yO2XVHRQAeSYHZ1xD1vcbox
         MN6YpK54l7btq0nQCcYwskTTAUzFAzi7Jx8KhNGhw0Yc8ZA4uj+eL+RUUBhWKlTgdR
         B9ArjQ1OMk0VH9+MqQzNWp5lDjeSdIpYN9h+2VRo=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 12/14] iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
Date:   Thu, 21 Nov 2019 11:49:16 +0000
Message-Id: <20191121114918.2293-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
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
index d6c83bd69555..307026fb58b3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1976,25 +1976,51 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
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
@@ -2142,7 +2168,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	 * ready to handle default domain setup as soon as any SMMU exists.
 	 */
 	if (!using_legacy_binding)
-		arm_smmu_bus_init();
+		return arm_smmu_bus_init(&arm_smmu_ops);
 
 	return 0;
 }
@@ -2156,7 +2182,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 static int arm_smmu_legacy_bus_init(void)
 {
 	if (using_legacy_binding)
-		arm_smmu_bus_init();
+		return arm_smmu_bus_init(&arm_smmu_ops);
 	return 0;
 }
 device_initcall_sync(arm_smmu_legacy_bus_init);
@@ -2171,6 +2197,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
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
2.24.0.432.g9d3f5f5b63-goog

