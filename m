Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65643C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D17214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCMIeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:34:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:51480 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfCMIeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:34:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 01:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="154566596"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2019 01:34:12 -0700
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, joro@8bytes.org, jean-philippe.brucker@arm.com,
        peterx@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFC v2 0/2] vfio/pci: wrap pci device as a mediated device
Date:   Tue, 12 Mar 2019 16:18:21 +0800
Message-Id: <1552378703-11202-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add a vfio-pci-like meta driver as a demo
user of the vfio changes introduced in "vfio/mdev: IOMMU aware
mediated device" patchset from Baolu Lu.

Previous RFC v1 has given two proposals and the discussion could
be found in following link. Per the comments, this patchset adds
a separate driver named vfio-pci-mdev. It leverages some symbols
from existing vfio-pci. When device is bound to vfio-pci-mdev
driver, it would be wrapped as a mediated device. And user should
create a mdev on this device via the mdev interface exposed to
user.
https://lkml.org/lkml/2019/3/4/529

The new vfio-pci-mdev driver could be used to verify the vfio
changes in "vfio/mdev: IOMMU aware mediated device". Besides,
per Alex's comments, it could also be a good base driver for
experimenting with device specific mdev migration.

Specific interface tested in this proposal:

*) int mdev_set_iommu_device(struct device *dev,
				struct device *iommu_device)
   introduced in the patch as below:
   "[PATCH v5 6/8] vfio/mdev: Add iommu related member in mdev_device"


Links:
*) Link of "vfio/mdev: IOMMU aware mediated device"
	https://lwn.net/Articles/780522/

Please feel free give your comments.

Thanks,
Yi Liu

Change log:
  v1->v2:
  - instead of adding kernel option to existing vfio-pci
    module in v1, v2 follows Alex's suggestion to add a
    separate vfio-pci-mdev module.
  - new patchset subject: "vfio/pci: wrap pci device as a mediated device"

Liu, Yi L (2):
  vfio/pci: export common symbols in vfio-pci
  vfio/pci: add vfio-pci-mdev driver

 drivers/vfio/pci/Kconfig            |  11 ++
 drivers/vfio/pci/Makefile           |   5 +
 drivers/vfio/pci/vfio_pci.c         | 101 ++++++-----
 drivers/vfio/pci/vfio_pci_mdev.c    | 334 ++++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  17 ++
 5 files changed, 428 insertions(+), 40 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_mdev.c

-- 
2.7.4

