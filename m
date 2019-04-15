Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2350FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2CE2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XsJuTkH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfDOPgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:36:23 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15092 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfDOPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:36:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4a4f90000>; Mon, 15 Apr 2019 08:36:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:36:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:36:20 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:36:20 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 15:36:20 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.42.162]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4a4f10001>; Mon, 15 Apr 2019 08:36:19 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <sakari.ailus@linux.intel.com>, <paul.kocialkowski@bootlin.com>,
        <tfiga@chromium.org>, <keiichiw@chromium.org>, <sumitg@nvidia.com>,
        <bbasu@nvidia.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [Patch V3] v4l2-core: fix use-after-free error
Date:   Mon, 15 Apr 2019 21:06:14 +0530
Message-ID: <1555342574-15940-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555342585; bh=CoJlo7u72gt6x5TjSc1ianvMzwS3wHRHZ4CWcBMBguo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=XsJuTkH5JAbi/NBtPRaJqgRBdLBo2g5jp+JrxPi8xRkW3i+bxMkpOcA//yhHO6TkC
         uIkyodEbLTcbyo/BhfF1EpiGMIjy847UShb7Mrz28L3wmxFmNOJBAVPm1erTfRDPz2
         /wbrzu0xaYLNc7ziWA/Q67ezVSuU8JzeQexEbQVF0Mq0rEpbBjFdVuK/btQ7IXIvE6
         OxtlPMMFe3WACbdtEz00EQv/I+Io8vLK3TPRQLymZ2yO9apJYEnYNI2tNF4vkDilaX
         V+0upmLvsgpV7qV4iu0DFX69LRVIOZSb38Py80Fo8GLzxHOYutwZoqUZTTSGqT8vQq
         oqVgOOmMC4VZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sumitg <sumitg@nvidia.com>

Fixing use-after-free within __v4l2_ctrl_handler_setup().
Memory is being freed with kfree(new_ref) for duplicate
control reference entry but ctrl->cluster pointer is still
referring to freed duplicate entry resulting in error on
access. Change done to update cluster pointer only when new
control reference is added. Also, added check to add new
ctrl to handler only if the cluster points to an entry.

 ==================================================================
 BUG: KASAN: use-after-free in __v4l2_ctrl_handler_setup+0x388/0x428
 Read of size 8 at addr ffffffc324e78618 by task systemd-udevd/312

 Allocated by task 312:

 Freed by task 312:

 The buggy address belongs to the object at ffffffc324e78600
  which belongs to the cache kmalloc-64 of size 64
 The buggy address is located 24 bytes inside of
  64-byte region [ffffffc324e78600, ffffffc324e78640)
 The buggy address belongs to the page:
 page:ffffffbf0c939e00 count:1 mapcount:0 mapping:
					(null) index:0xffffffc324e78f80
 flags: 0x4000000000000100(slab)
 raw: 4000000000000100 0000000000000000 ffffffc324e78f80 000000018020001a
 raw: 0000000000000000 0000000100000001 ffffffc37040fb80 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffffffc324e78500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffffffc324e78580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 >ffffffc324e78600: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                             ^
  ffffffc324e78680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
  ffffffc324e78700: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---

v3:
* update ctrl->cluster only when new control reference is added.
* add new ctrl to handler only if the cluster points to an entry.

v2:
* update ctrl->cluster only when new control reference is added.
* check ctrl->ncontrols to avoid illegal access when cluster has zero controls.

 drivers/media/v4l2-core/v4l2-ctrls.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 5e3806f..877c2ab 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2154,15 +2154,6 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
 	if (size_extra_req)
 		new_ref->p_req.p = &new_ref[1];
 
-	if (ctrl->handler == hdl) {
-		/* By default each control starts in a cluster of its own.
-		   new_ref->ctrl is basically a cluster array with one
-		   element, so that's perfect to use as the cluster pointer.
-		   But only do this for the handler that owns the control. */
-		ctrl->cluster = &new_ref->ctrl;
-		ctrl->ncontrols = 1;
-	}
-
 	INIT_LIST_HEAD(&new_ref->node);
 
 	mutex_lock(hdl->lock);
@@ -2195,6 +2186,15 @@ static int handler_new_ref(struct v4l2_ctrl_handler *hdl,
 	hdl->buckets[bucket] = new_ref;
 	if (ctrl_ref)
 		*ctrl_ref = new_ref;
+	if (ctrl->handler == hdl) {
+		/* By default each control starts in a cluster of its own.
+		 * new_ref->ctrl is basically a cluster array with one
+		 * element, so that's perfect to use as the cluster pointer.
+		 * But only do this for the handler that owns the control.
+		 */
+		ctrl->cluster = &new_ref->ctrl;
+		ctrl->ncontrols = 1;
+	}
 
 unlock:
 	mutex_unlock(hdl->lock);
@@ -2346,9 +2346,11 @@ static struct v4l2_ctrl *v4l2_ctrl_new(struct v4l2_ctrl_handler *hdl,
 		kvfree(ctrl);
 		return NULL;
 	}
-	mutex_lock(hdl->lock);
-	list_add_tail(&ctrl->node, &hdl->ctrls);
-	mutex_unlock(hdl->lock);
+	if (ctrl->cluster) {
+		mutex_lock(hdl->lock);
+		list_add_tail(&ctrl->node, &hdl->ctrls);
+		mutex_unlock(hdl->lock);
+	}
 	return ctrl;
 }
 
-- 
2.7.4

