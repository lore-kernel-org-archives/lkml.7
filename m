Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3962CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED321734
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572447080;
	bh=fGY4lwQed6kXKr5Reh7oVYWsIVXScMRNH9ALNwy+qSg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=f1o0bo2fTCYIesoPKAd+Skc+qXUzKb82YNDNdpIO3F5dypt3VRO1A+dV/XgsrG/ID
	 f8vqtFlyAMWrBeHuBJa0c7eKl3cUwyOqfgPWrVJ4eUb6ZDOCsLBV07SK0su9s5hS2d
	 6ScbPwZFcMUcVoYWvzAxSvcsWUFN/EnkzaSqfrCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJ3OvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJ3OvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:51:19 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64ED320856;
        Wed, 30 Oct 2019 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572447078;
        bh=fGY4lwQed6kXKr5Reh7oVYWsIVXScMRNH9ALNwy+qSg=;
        h=From:To:Cc:Subject:Date:From;
        b=SiVarWNl5Lv4nOXK6mU4X2uIu2qZbZcZKslAwfQCTX3dVRpk4EtEegjAXd2Z3/Jlt
         hVNdpEIViMEGTdmZMVV5eIbAZvOiXQ6A+g1iG0vrZ3ndOFzo/6BUTyYQLiZKJRQXIP
         h6nlrJJHJUJTbObV1dQdPhXT0aYnBO1cRVTrhf/c=
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
Date:   Wed, 30 Oct 2019 14:51:05 +0000
Message-Id: <20191030145112.19738-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As part of the work to enable a "Generic Kernel Image" across multiple
Android devices, there is a need to seperate shared, core kernel code
from modular driver code that may not be needed by all SoCs. This means
building IOMMU drivers as modules.

It turns out that most of the groundwork has already been done to enable
the ARM SMMU drivers to be 'tristate' options in drivers/iommu/Kconfig;
with a few symbols exported from the IOMMU/PCI core, everything builds
nicely out of the box. The one exception is support for the legacy SMMU
DT binding, which is not in widespread use and has never worked with
modules, so we can simply remove that when building as a module rather
than try to paper over it with even more hacks.

Obviously you need to be careful about using IOMMU drivers as modules,
since late loading of the driver for an IOMMU serving active DMA masters
is going to end badly in many cases. On Android, we're using device links
to ensure that the IOMMU probes first.

Comments welcome,

Will

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

--->8

Will Deacon (7):
  drivers/iommu: Export core IOMMU API symbols to permit modular drivers
  iommu/of: Request ACS from the PCI core when configuring IOMMU linkage
  PCI: Export pci_ats_disabled() as a GPL symbol to modules
  Revert "iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular"
  iommu/arm-smmu-v3: Allow building as a module
  Revert "iommu/arm-smmu: Make arm-smmu explicitly non-modular"
  iommu/arm-smmu: Allow building as a module

 drivers/iommu/Kconfig         | 16 ++++++-
 drivers/iommu/arm-smmu-impl.c |  6 +++
 drivers/iommu/arm-smmu-v3.c   | 26 +++++++----
 drivers/iommu/arm-smmu.c      | 86 +++++++++++++++++++++--------------
 drivers/iommu/iommu-sysfs.c   |  5 ++
 drivers/iommu/iommu.c         |  8 ++++
 drivers/iommu/of_iommu.c      |  1 +
 drivers/pci/pci.c             |  1 +
 8 files changed, 102 insertions(+), 47 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

