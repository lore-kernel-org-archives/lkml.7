Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EBEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EE9222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757083;
	bh=5RCz2TMZMRkkASXCp+AqxpJ05Mrpr53WCYjlykmdXF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYdvAD4C61m8Tw2zIlcNgcl41oOEvNcgI8KCMnxKy2It6irsH+8WXR5IIzc/DgjnZ
	 i0MGjGAg0RQ0pBp0S9Kvqd3BeMw7smVsKB+IXhFLbBkvovQlbeBn471zPunPVQGdSn
	 iYfxDt4G7fyGy8mM1IZGIlbKeYlkxGNDGIn8kcpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLSMEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSMEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:38 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A56206D3;
        Thu, 19 Dec 2019 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757078;
        bh=5RCz2TMZMRkkASXCp+AqxpJ05Mrpr53WCYjlykmdXF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1h0V17RF7vekeTkTWYpjgjz9Zszmn7oujavAur3jPEoV9CAkAOX6COvnqg+ZAQy+N
         XUK571oj+uXNTPSSYeExCGo+6ySFnnJdGNmg6cgB7eoWoMxjMp2pAxgNu0luj20VSN
         l4Tp4Yq1mxrSTM+UqFme3nSfOX3dh9nIhYMseM50=
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
Subject: [PATCH v4 13/16] iommu/arm-smmu-v3: Allow building as a module
Date:   Thu, 19 Dec 2019 12:03:49 +0000
Message-Id: <20191219120352.382-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219120352.382-1-will@kernel.org>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By removing the redundant call to 'pci_request_acs()' we can allow the
ARM SMMUv3 driver to be built as a module.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/Kconfig       | 2 +-
 drivers/iommu/arm-smmu-v3.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 0b9d78a0f3ac..31f0f376ad11 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -394,7 +394,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	  config.
 
 config ARM_SMMU_V3
-	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
+	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index da9474a02668..2a65d9b87125 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2733,6 +2733,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.owner			= THIS_MODULE,
 };
 
 /* Probing and initialisation functions */
@@ -3571,8 +3572,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != ops) {
-		if (ops)
-			pci_request_acs();
 		err = bus_set_iommu(&pci_bus_type, ops);
 		if (err)
 			return err;
-- 
2.24.1.735.g03f4e72817-goog

