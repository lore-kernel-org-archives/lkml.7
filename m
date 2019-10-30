Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5CFCA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132F220856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572447098;
	bh=F9GxmV9JRoWx/7+njViQgD19WYLLBQ0StpL47b4u+Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKHdOx94JS679LSN0k2nz2zFj7XUzfL4Wib4/qyt0xT9ekguYkBY1bFoPfYEF1gTo
	 lGC6i9uiLixnpaPvKwPiu1J0r9412lluG2hyzdLleIRWE9EdD8fse5l0DOC5fbEHtn
	 7q05zRtDYGWPLR0Fi4Ynoe9WbnMwtnvVAEvOuqt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfJ3Ovd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfJ3Ov2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:51:28 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F0F8208E3;
        Wed, 30 Oct 2019 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572447087;
        bh=F9GxmV9JRoWx/7+njViQgD19WYLLBQ0StpL47b4u+Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACVvc7LJWEa4HLbetuu4zNT2qScjlWX+/gOTfPg/ez2pNJkXXwcpsfO1DWeDggaM4
         ZJF5Egydh7i/VJLGUC8WYT5fJI75n7JeF9sg2mTPzwU9LjoJzNbHi2m1nnwmK4KPk7
         PBLjuxa818PNBErf5IGOdwjnAcekH4CvtODFu6RI=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 5/7] iommu/arm-smmu-v3: Allow building as a module
Date:   Wed, 30 Oct 2019 14:51:10 +0000
Message-Id: <20191030145112.19738-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030145112.19738-1-will@kernel.org>
References: <20191030145112.19738-1-will@kernel.org>
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
 drivers/iommu/arm-smmu-v3.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3842eabcfdd..7583d47fc4d5 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -388,7 +388,7 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
 	  config.
 
 config ARM_SMMU_V3
-	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
+	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2ad8e2ca0583..56ce4ba2fcbe 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3657,7 +3657,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
-		pci_request_acs();
 		ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 		if (ret)
 			return ret;
-- 
2.24.0.rc0.303.g954a862665-goog

