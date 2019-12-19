Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C607EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A44924676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576757043;
	bh=RJ3mvIaVqDC3kz+hjtWcHLqxdB4ZpdxAR3Q1j/eZavs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BssmwhchePFp3szMjwANc41vgVYeQgYBK9JfLLbY0IGhFV0W4fjQQdbW5klA6q6YE
	 w88AY/shz+qF9ZO5oKrntgZzIKFe/ik2Z7P6ffa9TZ5NWF06TbZfCa9vYlsyZY6Htw
	 CAgHV2CsuUr7/5FULpbNG1zKsqTkwUvc++nIlxnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLSMEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:04:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfLSMEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:04:02 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763C1222C2;
        Thu, 19 Dec 2019 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576757040;
        bh=RJ3mvIaVqDC3kz+hjtWcHLqxdB4ZpdxAR3Q1j/eZavs=;
        h=From:To:Cc:Subject:Date:From;
        b=UPODlAURU4Z6I+ZrIbrO0SwBJGmkgWWMDyFoiiFjTqfXFRdrfca7ndq+YCw86qEvK
         dUWwMDy+/62dPQbFI2VNuPVd6OYISizRVts5FY3fimLiL+5N+7iJwev74E6KNf52Dh
         2oXUJOsfYsvuV0fRDMezfl0w/bexYbzxGEVXyWQU=
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
Subject: [PATCH v4 00/16] iommu: Permit modular builds of ARM SMMU[v3] drivers
Date:   Thu, 19 Dec 2019 12:03:36 +0000
Message-Id: <20191219120352.382-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version four of the patches I previously posted here:

  v1: https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/
  v2: https://lore.kernel.org/lkml/20191108151608.20932-1-will@kernel.org
  v3: https://lore.kernel.org/lkml/20191121114918.2293-1-will@kernel.org

Changes since v3 include:

  * Based on v5.5-rc1
  * ACPI/IORT support (thanks to Ard)
  * Export pci_{enable,disable}_ats() (thanks to Greg)
  * Added review tags

I tested this on AMD Seattle by loading arm-smmu-mod.ko from the initrd.

Cheers,

Will

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ard Biesheuvel <ardb@kernel.org>

--->8

Ard Biesheuvel (1):
  iommu/arm-smmu: Support SMMU module probing from the IORT

Greg Kroah-Hartman (1):
  PCI/ATS: Restore EXPORT_SYMBOL_GPL() for pci_{enable,disable}_ats()

Will Deacon (14):
  drivers/iommu: Export core IOMMU API symbols to permit modular drivers
  iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
  PCI: Export pci_ats_disabled() as a GPL symbol to modules
  drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
  iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
  drivers/iommu: Allow IOMMU bus ops to be unregistered
  Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
  Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
  iommu/arm-smmu: Prevent forced unbinding of Arm SMMU drivers
  iommu/arm-smmu-v3: Unregister IOMMU and bus ops on device removal
  iommu/arm-smmu-v3: Allow building as a module
  iommu/arm-smmu: Unregister IOMMU and bus ops on device removal
  iommu/arm-smmu: Allow building as a module
  iommu/arm-smmu: Update my email address in MODULE_AUTHOR()

 drivers/acpi/arm64/iort.c   |   4 +-
 drivers/iommu/Kconfig       |  16 ++++-
 drivers/iommu/Makefile      |   3 +-
 drivers/iommu/arm-smmu-v3.c |  94 +++++++++++++++++---------
 drivers/iommu/arm-smmu.c    | 128 +++++++++++++++++++++++++-----------
 drivers/iommu/iommu-sysfs.c |   5 ++
 drivers/iommu/iommu.c       |  32 ++++++++-
 drivers/iommu/of_iommu.c    |  19 ++++--
 drivers/pci/ats.c           |   2 +
 drivers/pci/pci.c           |   1 +
 include/linux/iommu.h       |   4 +-
 11 files changed, 223 insertions(+), 85 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

