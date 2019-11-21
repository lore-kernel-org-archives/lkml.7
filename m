Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A4C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21AE208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574336996;
	bh=q6tCgJoVbKmaajtoiAg/CIo4lf0H365YVrdYrstJpuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fGY8m7uQZSoy3C5Lb+lgeSHKmwIF01A65lPZ63AWlhR5SMwJgcWz+QEPpyTkfDTmu
	 KcecrsL/9m8cmfz3Sw+3PbtSn6VOE4BcroXOaG+cg999RN4SMCzwleRfZS/oedgSle
	 EmcHDSBSkhUuDiZRRQ5WPhtIadUdD0tEwgtPepaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfKULtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfKULty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:54 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD7F20898;
        Thu, 21 Nov 2019 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336994;
        bh=q6tCgJoVbKmaajtoiAg/CIo4lf0H365YVrdYrstJpuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9Y4UO/r2NR6iwRb9Azm4PC85Ih9QWiwkNxGvYWdIss6jtI70+lzdzfGpk6rL0yN2
         J3acA21ZqGP0tqrisMTUq9JlcYLYd51ZMR88dKE5irO9jScZP+fcHhaMJD5tz+Dvmb
         Q55trwhox83Pddc3vcs9fAeRmB5PTeC83TZcNpW4=
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
Subject: [PATCH v3 11/14] iommu/arm-smmu-v3: Allow building as a module
Date:   Thu, 21 Nov 2019 11:49:15 +0000
Message-Id: <20191121114918.2293-12-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
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
index 0e7a135efdfe..f79b14f75107 100644
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
2.24.0.432.g9d3f5f5b63-goog

