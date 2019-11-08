Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C09FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54497214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573226197;
	bh=2ZvDEGh6IOOltQvHt9zTc+gSBf5wV4xvytOB8pwRoro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sTHjSEJh+mhzQpzDROTicTN1Hm6Ue3mh/jmBcYyRd4ulGmtpxVof7i074zNDlLQs1
	 oKUK+1d2itGfVWjzP5c97LMZVhoWEgVjgKDJeVcwcXWbAyytjqEoEUnF4HQe8p6ASL
	 MgpLk74M1NBxQVFAdbGuAK8RsR9erMC0UsjOohPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKHPQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:16:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727419AbfKHPQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:33 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42583222C6;
        Fri,  8 Nov 2019 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226193;
        bh=2ZvDEGh6IOOltQvHt9zTc+gSBf5wV4xvytOB8pwRoro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2TPJopCA7RalWF7kJhlmfM/4Y7tZLTy6fCl2aNIVQVXkgiBZPGJY83IXtnVgwFrK
         RpGsnLdQzz+HJdIxxqGSehHTmQviTYhO5lIeKwKJiLHDUM+fndzaUm98fl6p7QKAet
         bQqbcbQgiQ02IJgLgyu/Z3Asy8pfpKV/eUGPYlsA=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 7/9] iommu/arm-smmu-v3: Allow building as a module
Date:   Fri,  8 Nov 2019 15:16:06 +0000
Message-Id: <20191108151608.20932-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108151608.20932-1-will@kernel.org>
References: <20191108151608.20932-1-will@kernel.org>
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
 drivers/iommu/arm-smmu-v3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index 2ad8e2ca0583..d54ceb80c28d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2733,6 +2733,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= arm_smmu_put_resv_regions,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.owner			= THIS_MODULE,
 };
 
 /* Probing and initialisation functions */
@@ -3657,7 +3658,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
-		pci_request_acs();
 		ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 		if (ret)
 			return ret;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

