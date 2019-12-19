Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86DFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC4A222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757080;
	bh=hr0j2ciKuJVzbWUymTBVFfm1s+/LxgMJpRZN60cwSuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LLqk15OpscBXpbdCJR9OJOjlWObaVsoZkhKQckQTrK6w5YMzmmP5UfZCCmy4U1coq
	 1BeYa0HXIloCEaUSujHHOQx/09P7OClDBI1ifNDvxpvmcW1MTC0USMHgUiGuywOX/q
	 6O6MzTM9a3ze7waYeNIqIuieZdmCRwx9Kq78J9M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLSMEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfLSMEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:33 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEE224679;
        Thu, 19 Dec 2019 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757072;
        bh=hr0j2ciKuJVzbWUymTBVFfm1s+/LxgMJpRZN60cwSuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNN7UrwM6z6VgCYQJmtp1gol6K5vWJCuBjE/bc4COHcvIrw9aWiZc7T2NLOHKW1Ci
         1Qk1Q4J8mOsJKtNxjpsTfmpl3PR0o69nPh6uOr7GojdaZ7dBngKIeSzkHkohjfcR4B
         c6NsAQzjX20C/z7I0EdM7QPmEneYXkv0pnEqsQP0=
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
Subject: [PATCH v4 11/16] iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
Date:   Thu, 19 Dec 2019 12:03:47 +0000
Message-Id: <20191219120352.382-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing the SMMUv3 driver, we need to clear any state that we
registered during probe. This includes our bus ops, sysfs entries and
the IOMMU device registered for early firmware probing of masters.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 64 +++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 9d4c9de6172d..46160a2fec3e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3565,6 +3565,45 @@ static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
 		return SZ_128K;
 }
 
+static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
+{
+	int err;
+
+#ifdef CONFIG_PCI
+	if (pci_bus_type.iommu_ops != ops) {
+		if (ops)
+			pci_request_acs();
+		err = bus_set_iommu(&pci_bus_type, ops);
+		if (err)
+			return err;
+	}
+#endif
+#ifdef CONFIG_ARM_AMBA
+	if (amba_bustype.iommu_ops != ops) {
+		err = bus_set_iommu(&amba_bustype, ops);
+		if (err)
+			goto err_reset_pci_ops;
+	}
+#endif
+	if (platform_bus_type.iommu_ops != ops) {
+		err = bus_set_iommu(&platform_bus_type, ops);
+		if (err)
+			goto err_reset_amba_ops;
+	}
+
+	return 0;
+
+err_reset_amba_ops:
+#ifdef CONFIG_ARM_AMBA
+	bus_set_iommu(&amba_bustype, NULL);
+#endif
+err_reset_pci_ops: __maybe_unused;
+#ifdef CONFIG_PCI
+	bus_set_iommu(&pci_bus_type, NULL);
+#endif
+	return err;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3655,33 +3694,16 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-#ifdef CONFIG_PCI
-	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
-		pci_request_acs();
-		ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
-		if (ret)
-			return ret;
-	}
-#endif
-#ifdef CONFIG_ARM_AMBA
-	if (amba_bustype.iommu_ops != &arm_smmu_ops) {
-		ret = bus_set_iommu(&amba_bustype, &arm_smmu_ops);
-		if (ret)
-			return ret;
-	}
-#endif
-	if (platform_bus_type.iommu_ops != &arm_smmu_ops) {
-		ret = bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return arm_smmu_set_bus_ops(&arm_smmu_ops);
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	arm_smmu_set_bus_ops(NULL);
+	iommu_device_unregister(&smmu->iommu);
+	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 
 	return 0;
-- 
2.24.1.735.g03f4e72817-goog

