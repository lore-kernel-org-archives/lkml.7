Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1886EC2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E325E206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 05:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAAF2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 00:28:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:55757 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgAAF2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 00:28:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 21:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,382,1571727600"; 
   d="scan'208";a="244319507"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2019 21:28:19 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 0/4] iommu: Per-group default domain type
Date:   Wed,  1 Jan 2020 13:26:44 +0800
Message-Id: <20200101052648.14295-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An IOMMU group represents the smallest set of devices that are considered
to be isolated. All devices belonging to an IOMMU group share a default
domain for DMA APIs. There are two types of default domain: IOMMU_DOMAIN_DMA
and IOMMU_DOMAIN_IDENTITY. The former means IOMMU translation, while the
latter means IOMMU by-pass.

Currently, the default domain type for the IOMMU groups is determined
globally. All IOMMU groups use a single default domain type. The global
default domain type can be adjusted by kernel build configuration or
kernel parameters.

More and more users are looking forward to a fine grained default domain
type. For example, with the global default domain type set to translation,
the OEM verndors or end users might want some trusted and fast-speed devices
to bypass IOMMU for performance gains. On the other hand, with global
default domain type set to by-pass, some devices with limited system
memory addressing capability might want IOMMU translation to remove the
bounce buffer overhead.

This series proposes per-group default domain type to meet these demands.
It adds a per-device iommu_passthrough attribute. By setting this
attribute, end users or device vendors are able to tell the IOMMU subsystem
that this device is willing to use a default domain of IOMMU_DOMAIN_IDENTITY.
The IOMMU device probe procedure is reformed to pre-allocate groups for
all devices on a specific bus before adding the devices into the groups.
This enables the IOMMU device probe precedure to determine a per-group
default domain type before allocating IOMMU domains and attaching them
to devices.

Please help to review it. Your comments and suggestions are appricated.

Best regards,
baolu 

Lu Baolu (4):
  driver core: Add iommu_passthrough to struct device
  PCI: Add "pci=iommu_passthrough=" parameter for iommu passthrough
  iommu: Preallocate iommu group when probing devices
  iommu: Determine default domain type before allocating domain

 .../admin-guide/kernel-parameters.txt         |   5 +
 drivers/iommu/iommu.c                         | 127 ++++++++++++++----
 drivers/pci/pci.c                             |  34 +++++
 drivers/pci/pci.h                             |   1 +
 drivers/pci/probe.c                           |   2 +
 include/linux/device.h                        |   3 +
 6 files changed, 143 insertions(+), 29 deletions(-)

-- 
2.17.1

