Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5355AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E3120811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfDXMa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:30:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:50551 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbfDXMa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:30:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 05:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="167475632"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2019 05:30:53 -0700
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@intel.com, joro@8bytes.org, jean-philippe.brucker@arm.com,
        peterx@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, yamada.masahiro@socionext.com,
        iommu@lists.linux-foundation.org
Subject: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
Date:   Tue, 23 Apr 2019 20:14:37 +0800
Message-Id: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
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
a separate driver named vfio-mdev-pci. It is a sample driver, but
loactes in drivers/vfio/pci due to code sharing consideration.
The corresponding Kconfig definition is in samples/Kconfig.

https://lkml.org/lkml/2019/3/4/529

Besides the test purpose, per Alex's comments, it could also be a
good base driver for experimenting with device specific mdev migration.

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
  v2->v3:
  - use vfio-mdev-pci instead of vfio-pci-mdev
  - place the new driver under drivers/vfio/pci while define
    Kconfig in samples/Kconfig to clarify it is a sample driver

  v1->v2:
  - instead of adding kernel option to existing vfio-pci
    module in v1, v2 follows Alex's suggestion to add a
    separate vfio-pci-mdev module.
  - new patchset subject: "vfio/pci: wrap pci device as a mediated device"

Liu, Yi L (3):
  vfio_pci: split vfio_pci.c into two source files
  vfio/pci: protect cap/ecap_perm bits alloc/free with atomic op
  smaples: add vfio-mdev-pci driver

 drivers/vfio/pci/Makefile           |    7 +-
 drivers/vfio/pci/common.c           | 1511 +++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_mdev_pci.c    |  386 +++++++++
 drivers/vfio/pci/vfio_pci.c         | 1476 +---------------------------------
 drivers/vfio/pci/vfio_pci_config.c  |    9 +
 drivers/vfio/pci/vfio_pci_private.h |   27 +
 samples/Kconfig                     |   11 +
 7 files changed, 1962 insertions(+), 1465 deletions(-)
 create mode 100644 drivers/vfio/pci/common.c
 create mode 100644 drivers/vfio/pci/vfio_mdev_pci.c

-- 
2.7.4

