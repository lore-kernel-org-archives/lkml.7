Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45940C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4FC208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574337010;
	bh=qgVq3iULPLf+++Sd5yvjfZUHIX2r2j9MWG12MbuZ/Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tolvCvfQZVV4QAGeSPWl8j7GtHwNSiAnf0hrIKzGACN4RE4OHdCVLvMd7pzTuG4g8
	 a37FKnMT4BPitNMBwASfVnOICxOzd2bSOhBX8HoeqUBpSLpTKvg/DFthU5yVsFQ7K6
	 iLM/PmE0xizO06gnoZOv9Q7ClSR9F1+tKLmTTBJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfKULtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfKULtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:52 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46BCC208D4;
        Thu, 21 Nov 2019 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336991;
        bh=qgVq3iULPLf+++Sd5yvjfZUHIX2r2j9MWG12MbuZ/Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6OSNWnyx8YGNhh9beVm1ztO44vtT3s0rmkIx87QFcYLcFnKlIqdRUorXUSANn/lI
         36coRd4w38f4NCfKljGzCGLReTiOnIvO8N1dgoDiHH71BhZyhJehU0gaom3MIsWYMu
         /3phKep+h4ioKLI1GlAN93SRfcqHnS5YzeX2g2Oc=
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
Subject: [PATCH v3 10/14] iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
Date:   Thu, 21 Nov 2019 11:49:14 +0000
Message-Id: <20191121114918.2293-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
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
index 3fd75abce3bb..0e7a135efdfe 100644
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
2.24.0.432.g9d3f5f5b63-goog

