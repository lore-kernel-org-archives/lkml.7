Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9B8C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2050020856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfILJkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:40:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730454AbfILJkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:40:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D954308FBFC;
        Thu, 12 Sep 2019 09:40:31 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 376B860852;
        Thu, 12 Sep 2019 09:40:14 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com
Cc:     mst@redhat.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        pmorel@linux.ibm.com, freude@linux.ibm.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org,
        maxime.coquelin@redhat.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, rob.miller@broadcom.com, idos@mellanox.com,
        xiao.w.wang@intel.com, lingshan.zhu@intel.com,
        Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 0/2] Mdev: support mutiple kinds of devices
Date:   Thu, 12 Sep 2019 17:40:10 +0800
Message-Id: <20190912094012.29653-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 12 Sep 2019 09:40:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

During the development of virtio-mdev[1]. I find that mdev needs to be
extended to support devices other than vfio mdev device. So this
series tries to extend the mdev to be able to differ from different
devices by:

- device id and matching for mdev bus
- device speicfic callbacks and move vfio callbacks there

Sent for early reivew, compile test only!

Thanks

[1] https://lkml.org/lkml/2019/9/10/135

Jason Wang (2):
  mdev: device id support
  mdev: introduce device specific ops

 drivers/gpu/drm/i915/gvt/kvmgt.c  | 16 ++++---
 drivers/s390/cio/vfio_ccw_ops.c   | 16 ++++---
 drivers/s390/crypto/vfio_ap_ops.c | 13 ++++--
 drivers/vfio/mdev/mdev_core.c     | 14 +++++-
 drivers/vfio/mdev/mdev_driver.c   | 14 ++++++
 drivers/vfio/mdev/mdev_private.h  |  1 +
 drivers/vfio/mdev/vfio_mdev.c     | 36 ++++++++++-----
 include/linux/mdev.h              | 76 +++++++++++++++++++------------
 include/linux/mod_devicetable.h   |  6 +++
 samples/vfio-mdev/mbochs.c        | 18 +++++---
 samples/vfio-mdev/mdpy.c          | 18 +++++---
 samples/vfio-mdev/mtty.c          | 16 ++++---
 12 files changed, 163 insertions(+), 81 deletions(-)

-- 
2.19.1

