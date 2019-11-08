Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C23FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F0A222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573226177;
	bh=nD47Fyavvt+u4/f0W65Gr+cRRT2ED6dF9mWsjBW13dc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ej18O1HFCh2skpc0kPxoasMAA3ZhWG1goQPrwvvNqHCn88b2Z4BCuHKk2k7QJIcPl
	 f7D5ylpa3KXToCvsaBl8Buw/byAj/AqO4HYkdPqFyAcOEpz/2yEnOp369zQYtgwJ7M
	 a6qiXevfbo+kkUQl1IQL3FUNZMFeLh2s1wkR8fX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKHPQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:16:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHPQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:16:16 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBE2214DB;
        Fri,  8 Nov 2019 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573226175;
        bh=nD47Fyavvt+u4/f0W65Gr+cRRT2ED6dF9mWsjBW13dc=;
        h=From:To:Cc:Subject:Date:From;
        b=p2x2OLB9c0MkLxp4toBA4qT2FhiYuS31bX+d7J29WYWWLOgeJ+Y7yso8TiOKCaPJ9
         +N/wg4fwi0M12IGed/UzywZb4K/G9EiVycGbhAdw4ACh1Tuo9xw11EnSZ/BDXEXz7c
         UhLbZj/ZNuo/+4fCyWbeiNITXN2d+NxNy9daP8eA=
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
Subject: [PATCH v2 0/9] iommu: Permit modular builds of ARM SMMU[v3] drivers
Date:   Fri,  8 Nov 2019 15:15:59 +0000
Message-Id: <20191108151608.20932-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the patches I previously posted here:

  https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/

Changes since v1 include:

  * Build single "arm-smmu-mod.ko" module for the Arm SMMU driver
  * Hold a reference to the IOMMU driver module across {add,remove}_device()
  * Take a reference to the IOMMU driver module during of_xlate()
  * Added Bjorn's ack on the PCI export patch

Please note that I haven't been able to test this properly, since I don't
currently have access to any Arm SMMU hardware.

Cheers,

Will

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>

--->8

Will Deacon (9):
  drivers/iommu: Export core IOMMU API symbols to permit modular drivers
  iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
  PCI: Export pci_ats_disabled() as a GPL symbol to modules
  drivers/iommu: Take a ref to the IOMMU driver prior to ->add_device()
  iommu/of: Take a ref to the IOMMU driver during ->of_xlate()
  Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
  iommu/arm-smmu-v3: Allow building as a module
  Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
  iommu/arm-smmu: Allow building as a module

 drivers/iommu/Kconfig       | 16 ++++++-
 drivers/iommu/Makefile      |  3 +-
 drivers/iommu/arm-smmu-v3.c | 27 +++++++-----
 drivers/iommu/arm-smmu.c    | 87 ++++++++++++++++++++++---------------
 drivers/iommu/iommu-sysfs.c |  5 +++
 drivers/iommu/iommu.c       | 27 +++++++++++-
 drivers/iommu/of_iommu.c    | 17 +++++---
 drivers/pci/pci.c           |  1 +
 include/linux/iommu.h       |  2 +
 9 files changed, 130 insertions(+), 55 deletions(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

