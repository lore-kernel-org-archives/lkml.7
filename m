Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB75C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963972064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfDSTM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:12:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:62826 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDSTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:12:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 01:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,368,1549958400"; 
   d="scan'208";a="141935693"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2019 01:39:19 -0700
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org
Cc:     arei.gonglei@huawei.com, aik@ozlabs.ru,
        Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
        qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com,
        ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
        felipe@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com,
        jonathan.davies@nutanix.com, shaopeng.he@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        libvir-list@redhat.com, alex.williamson@redhat.com,
        eskultet@redhat.com, dgilbert@redhat.com, cohuck@redhat.com,
        kevin.tian@intel.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, cjia@nvidia.com, kwankhede@nvidia.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 0/2] introduction of version attribute for VFIO live migration
Date:   Fri, 19 Apr 2019 04:32:58 -0400
Message-Id: <20190419083258.19580-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a version attribute under sysfs of VFIO Mediated
devices.

This version attribute is used by user space software like libvirt to
determine whether two mdev devices are compatible for live migration
before starting live migration.

Patch 1 defines version attribute as mandatory for VFIO live migration. It
means if version attribute is missing or it returns errno, the
corresponding mdev device is regarded as not supporting live migration.
samples for vfio-mdev are modified to demonstrate it.

Patch 2 uses GVT as an example to show how to expose version attribute and
check device compatibility in vendor driver.


Yan Zhao (2):
  vfio/mdev: add version field as mandatory attribute for mdev device
  drm/i915/gvt: export mdev device version to sysfs for Intel vGPU

 Documentation/vfio-mediated-device.txt    | 36 +++++++++
 drivers/gpu/drm/i915/gvt/Makefile         |  2 +-
 drivers/gpu/drm/i915/gvt/device_version.c | 94 +++++++++++++++++++++++
 drivers/gpu/drm/i915/gvt/gvt.c            | 55 +++++++++++++
 drivers/gpu/drm/i915/gvt/gvt.h            |  6 ++
 samples/vfio-mdev/mbochs.c                | 17 ++++
 samples/vfio-mdev/mdpy.c                  | 16 ++++
 samples/vfio-mdev/mtty.c                  | 16 ++++
 8 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/i915/gvt/device_version.c

-- 
2.17.1

