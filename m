Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A813C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237462085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 01:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgACBMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:12:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:48945 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgACBMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:12:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 17:12:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; 
   d="scan'208";a="221511534"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by orsmga006.jf.intel.com with ESMTP; 02 Jan 2020 17:12:16 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     zhenyuw@linux.intel.com
Cc:     alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gvt@eclists.intel.com,
        pbonzini@redhat.com, kevin.tian@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 2/2] drm/i915/gvt: subsitute kvm_read/write_guest with vfio_iova_rw
Date:   Thu,  2 Jan 2020 20:03:49 -0500
Message-Id: <20200103010349.4262-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103010055.4140-1-yan.y.zhao@intel.com>
References: <20200103010055.4140-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a device model, it is better to read/write guest memory using vfio
interface, so that vfio is able to maintain dirty info of device IOVAs.

Compared to CPU side interfaces kvm_read/write_guest(), vfio_iova_rw()
has ~600 cycles more overhead on average.
-------------------------------------
|    interface     | avg cpu cycles |
|-----------------------------------|
| kvm_write_guest  |     1546       |
| ----------------------------------|
| kvm_read_guest   |     686        |
|-----------------------------------|
| vfio_iova_rw(w)  |     2233       |
|-----------------------------------|
| vfio_iova_rw(r)  |     1262       |
-------------------------------------

Comparison of benchmarks scores are as blow:
---------------------------------------------------------
|  avg score  | kvm_read/write_guest   | vfio_iova_rw   |
---------------------------------------------------------
|   Glmark2   |         1132           |      1138.2    |
---------------------------------------------------------
|  Lightsmark |        61.558          |      61.538    |
|--------------------------------------------------------
|  OpenArena  |        142.77          |      136.6     |
---------------------------------------------------------
|   Heaven    |         698            |      686.8     |
--------------------------------------------------------
No obvious performance downgrade found.

Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index bd79a9718cc7..576b05db3998 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1966,31 +1966,19 @@ static int kvmgt_rw_gpa(unsigned long handle, unsigned long gpa,
 			void *buf, unsigned long len, bool write)
 {
 	struct kvmgt_guest_info *info;
-	struct kvm *kvm;
-	int idx, ret;
-	bool kthread = current->mm == NULL;
+	int ret;
+	struct intel_vgpu *vgpu;
+	struct device *dev;
 
 	if (!handle_valid(handle))
 		return -ESRCH;
 
 	info = (struct kvmgt_guest_info *)handle;
-	kvm = info->kvm;
-
-	if (kthread) {
-		if (!mmget_not_zero(kvm->mm))
-			return -EFAULT;
-		use_mm(kvm->mm);
-	}
-
-	idx = srcu_read_lock(&kvm->srcu);
-	ret = write ? kvm_write_guest(kvm, gpa, buf, len) :
-		      kvm_read_guest(kvm, gpa, buf, len);
-	srcu_read_unlock(&kvm->srcu, idx);
+	vgpu = info->vgpu;
+	dev = mdev_dev(vgpu->vdev.mdev);
 
-	if (kthread) {
-		unuse_mm(kvm->mm);
-		mmput(kvm->mm);
-	}
+	ret = write ? vfio_iova_rw(dev, gpa, buf, len, true) :
+			vfio_iova_rw(dev, gpa, buf, len, false);
 
 	return ret;
 }
-- 
2.17.1

