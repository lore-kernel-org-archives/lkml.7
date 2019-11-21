Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF99C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8465E208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574336966;
	bh=PdT7/vjeG9qVa+Z4rGos3rHHIh/e4XCZdgXcB6xN00c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s8he3qN5pCsaWMk/CIaaqtc+v3qQ+T2T6a3b/O3tRLD+locazUcReNN3rM3pUd1BE
	 edksci9tA+yTIFsQZ/PjDUduQmnl8Vzl6zvu03+L/tYK2HKNiNKtoNv0m4pC8F7DX2
	 BhdREIHNNzDzGP9Axr/XAZMFg/kWJBVNHueJAkbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKULtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKULtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:49:25 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05F0220898;
        Thu, 21 Nov 2019 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574336964;
        bh=PdT7/vjeG9qVa+Z4rGos3rHHIh/e4XCZdgXcB6xN00c=;
        h=From:To:Cc:Subject:Date:From;
        b=CnJgpSRU+BCftuywRCvfcH6mcTonCZhx3FKxuOCpNHwKqe5qVufZMKjeg5NgxQZg2
         Th+EITTwNMA9zDnNLX0+xnu2cx2GduL4GFSd1YwczFvZHWz4a7IyP6TrqAb2MLpWDy
         FT08tPUMC2o74E7WGXXgty7g0TlkZlJhq2v9l+64=
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
Subject: [PATCH v3 00/14] iommu: Permit modular builds of ARM SMMU[v3] drivers
Date:   Thu, 21 Nov 2019 11:49:04 +0000
Message-Id: <20191121114918.2293-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is version three of the patches I previously posted here:

  v1: https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/
  v2: https://lore.kernel.org/lkml/20191108151608.20932-1-will@kernel.org

Changes since v2 include:

  * Tested successfully on real hardware (!)
  * Handle re-registering of IOMMU bus ops
  * Unregister IOMMU on unload
  * Prevent forced unbinding of SMMU drivers via sysfs
  * Update my email address in MODULE_AUTHOR

Note that if you want to rely on the 'of_devlink' support in linux-next
for dependent probe ordering, then you'll need an extra patch [1] to
support PCI devices upstream of an SMMU. I'm routing that one via Greg.

Will

[1] https://lore.kernel.org/lkml/20191120190028.4722-1-will@kernel.org

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

--->8

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

 drivers/iommu/Kconfig       |  16 ++++-
 drivers/iommu/Makefile      |   3 +-
 drivers/iommu/arm-smmu-v3.c |  93 +++++++++++++++++---------
 drivers/iommu/arm-smmu.c    | 127 +++++++++++++++++++++++++-----------
 drivers/iommu/iommu-sysfs.c |   5 ++
 drivers/iommu/iommu.c       |  32 ++++++++-
 drivers/iommu/of_iommu.c    |  17 +++--
 drivers/pci/pci.c           |   1 +
 include/linux/iommu.h       |   2 +
 9 files changed, 215 insertions(+), 81 deletions(-)

-- 
2.24.0.432.g9d3f5f5b63-goog

