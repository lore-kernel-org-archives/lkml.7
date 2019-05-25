Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1919C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957E52133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEYFss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:48:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfEYFss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:47 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 00/15] iommu/vt-d: Delegate DMA domain to generic iommu
Date:   Sat, 25 May 2019 13:41:21 +0800
Message-Id: <20190525054136.27810-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset delegates the iommu DMA domain management to the
generic iommu layer. It avoids the use of find_or_alloc_domain
whose domain assignment is inconsistent with the iommu grouping
as determined by pci_device_group.

The major change is to permit domains of type IOMMU_DOMAIN_DMA
and IOMMU_DOMAIN_IDENTITY to be allocated via the iommu_ops api.
This allows the default_domain of an iommu group to be set in
iommu.c. This domain will be attached to every device that is
brought up with an iommu group, and the devices reserved regions
will be mapped using regions returned by get_resv_regions.

The default domain implementation defines a default domain type
and a domain of the default domain type will be allocated and
attached to devices which belong to a same group. Unfortunately,
this doesn't work for some quirky devices which is known to only
work with a specific domain type. PATCH 1/15 adds an iommu ops
which allows the IOMMU driver to request a dma domain if the
default identity domain doesn't match the device. Together with
iommu_request_dm_for_dev(), we can handle the mismatching cases
in a nice way.

Other changes are limited within the Intel IOMMU driver. They
mainly allow the driver to adapt to allocating domains, attaching
domains, applying and direct mapping reserved memory regions,
deferred domain attachment, and so on, via the iommu_ops api's.

This patchset was initiated by James Sewart. The v1 and v2 were
posted here [1] [2] for discussion. Lu Baolu took over the work
for testing and bug fixing with permission from James Sewart.

This version of implementation depends on the patchset of "RMRR
related fixes and enhancements". The latest version is under
discussion at [3]. It allows the iommu_alloc_resv_region() to
be called in a non preemptible section.

Reference:
[1] https://lkml.org/lkml/2019/3/4/644
[2] https://lkml.org/lkml/2019/3/14/299
[3] https://lkml.org/lkml/2019/5/16/237

Best regards,
Lu Baolu

Change log:
 v3->v4:
  - Add code to probe the DMA-capable devices through ACPI
    name space.
  - Remove the callbacks for pci hot-plug devices in Intel
    IOMMU driver.
  - Remove the code to prepare static identity map during
    boot.
  - Add iommu_request_dma_domain_for_dev() to request dma
    domain in case the default identity domain doesn't match
    the device.

 v2->v3:
  - https://lkml.org/lkml/2019/4/28/284
  - Add supported default domain type callback.
  - Make the iommu map() callback work even the domain is not
    attached.
  - Add domain deferred attach when iommu is pre-enabled in
    kdump kernel.

 v1->v2:
  - https://lkml.org/lkml/2019/3/14/299
  - Refactored ISA direct mappings to be returned by
    iommu_get_resv_regions.
  - Integrated patch by Lu to defer turning on DMAR until iommu.c
    has mapped reserved regions.
  - Integrated patches by Lu to remove more unused code in cleanup.

 v1:
  -Original post https://lkml.org/lkml/2019/3/4/644

James Sewart (1):
  iommu/vt-d: Implement apply_resv_region iommu ops entry

Lu Baolu (14):
  iommu: Add API to request DMA domain for device
  iommu/vt-d: Expose ISA direct mapping region via
    iommu_get_resv_regions
  iommu/vt-d: Enable DMA remapping after rmrr mapped
  iommu/vt-d: Add device_def_domain_type() helper
  iommu/vt-d: Delegate the identity domain to upper layer
  iommu/vt-d: Delegate the dma domain to upper layer
  iommu/vt-d: Identify default domains replaced with private
  iommu/vt-d: Handle 32bit device with identity default domain
  iommu/vt-d: Probe DMA-capable ACPI name space devices
  iommu/vt-d: Implement is_attach_deferred iommu ops entry
  iommu/vt-d: Cleanup get_valid_domain_for_dev()
  iommu/vt-d: Remove startup parameter from device_def_domain_type()
  iommu/vt-d: Remove duplicated code for device hotplug
  iommu/vt-d: Remove static identity map code

 drivers/iommu/intel-iommu.c | 608 +++++++++++++++++-------------------
 drivers/iommu/iommu.c       |  36 ++-
 include/linux/intel-iommu.h |   1 -
 include/linux/iommu.h       |   6 +
 4 files changed, 324 insertions(+), 327 deletions(-)

-- 
2.17.1

