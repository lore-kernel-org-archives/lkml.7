Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A6CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CA520830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfCDNNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:13:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:33932 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCDNNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:13:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 05:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="151870439"
Received: from yiliu-dev.bj.intel.com ([10.238.156.125])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2019 05:13:46 -0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        jean-philippe.brucker@arm.com, peterx@redhat.com,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
        yi.y.sun@intel.com
Subject: [RFC v1 0/2] vfio/pci: wrap pci device as mdev with vfio-pci driver
Date:   Sun,  3 Mar 2019 20:57:59 +0800
Message-Id: <1551617881-8520-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add a vfio-pci-like meta driver on existing
PCI devices, as a demo user of the vfio changes introduced in
"vfio/mdev: IOMMU aware mediated device" patchset from Baolu Lu.

To build such a meta driver. We have two choices.
a) add a vfio-pci alike sample driver under samples directory
b) add some extensions in vfio-pci driver to make it wrap pci
   device as mdev

For choice a), the new sample driver will have quite a few
duplicated code with vfio-pci driver since the new sample
driver also wants to virtualize the PCI config space. So
this choice may bring in extra maintain effort in kernel
and also looks strange since there will be a bunch of
duplicated code with vfio-pci driver.

For choice b), it may reuse the existing vfio-pci driver
by adding a new working mode. With this mode, user can wrap
a pci device as a mediated device by binding it with the
vfio-pci driver which works in the new mode. Thus can be used
to verify the ""vfio/mdev: IOMMU aware mediated device"
patchset.

This patchset is following choice b). However, we are open on
the direction of the implementation of this vfio-pci-like meta
driver. Pls feel free give your suggestions.

Specific interface tested in this proposal:

*) int mdev_set_iommu_device(struct device *dev,
				struct device *iommu_device)
   introduced in the patch as below:
   "[PATCH v5 6/8] vfio/mdev: Add iommu related member in mdev_device"


Links:
*) Link of "vfio/mdev: IOMMU aware mediated device"
	https://lwn.net/Articles/780522/

Liu, Yi L (2):
  vfio/pci: register vfio-pci driver to mdev framework
  vfio/pci: expose only mdev interface if in pci-mdev mode

 drivers/vfio/pci/vfio_pci.c | 199 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 193 insertions(+), 6 deletions(-)

-- 
2.7.4

