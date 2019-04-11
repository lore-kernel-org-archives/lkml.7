Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC5B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WmwA2o/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDKQB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:01:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3098 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:01:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf64d30000>; Thu, 11 Apr 2019 09:01:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 09:01:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 09:01:25 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 16:01:25 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 16:01:24 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 16:01:24 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.42.162]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5caf64d10007>; Thu, 11 Apr 2019 09:01:24 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <sakari.ailus@linux.intel.com>, <paul.kocialkowski@bootlin.com>,
        <tfiga@chromium.org>, <keiichiw@chromium.org>, <sumitg@nvidia.com>,
        <bbasu@nvidia.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [Patch V2] v4l2-core: fix use-after-free error
Date:   Thu, 11 Apr 2019 21:31:18 +0530
Message-ID: <1554998478-30349-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554998483; bh=sEufludimsSbbAIyEALaQypOEDwA1U3AV6D8y6MVhVY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=WmwA2o/AN6c9kcgQungtMS4ra+riwT8ikqlOJuL89+teccY92E/O23hXB2v6Ym9UN
         dSIxZt/hA9LIQCPMM2MPqvl/ffsO2k7qpdYou4V2VrfHZb5pVdJkOfFvSOqWmTnwoY
         AUftPzaQgC+okfWrmTUN3FVbv57+FnVug8V4ubwU9nOBatH2cKd66gLSKxlUQHGAis
         LRFu65ShRthvGK3Dqd1Vm7hYyKjH9LHdX8dCvDkGRUa/LKTGqs0/6V1CI48AfHP62u
         ueOpMan9UbVJOm5qU026trP2ky1TsQcjsN5LyV5c/Q2Cx5WJ7Lpjwi8d9dG4oVORSV
         dqXNq+88XlAKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sumitg <sumitg@nvidia.com>

Fixing use-after-free within __v4l2_ctrl_handler_setup().
Memory is being freed with kfree(new_ref) for duplicate
control reference entry but cluster is still referring
to the duplicate entry. Change done to update ctrl->cluster
only when new control reference is added. Also, checking if
ctrl->ncontrols is non-zero before accessing controls from
cluster pointer to avoid illegal access when cluster has
zero controls.

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
v2:
* update ctrl->cluster only when new control reference is added.
* check ctrl->ncontrols to avoid illegal access when cluster has zero controls.

 drivers/media/v4l2-core/v4l2-ctrls.c | 53 +++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 5e3806f..3d0a952 100644
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
@@ -2725,25 +2725,28 @@ int __v4l2_ctrl_handler_setup(struct v4l2_ctrl_handler *hdl)
 		ctrl->done = false;
 
 	list_for_each_entry(ctrl, &hdl->ctrls, node) {
-		struct v4l2_ctrl *master = ctrl->cluster[0];
-		int i;
-
-		/* Skip if this control was already handled by a cluster. */
-		/* Skip button controls and read-only controls. */
-		if (ctrl->done || ctrl->type == V4L2_CTRL_TYPE_BUTTON ||
-		    (ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY))
-			continue;
+		if (ctrl->ncontrols) {
+			struct v4l2_ctrl *master = ctrl->cluster[0];
+			int i;
+
+			/* Skip if this control was already handled by a */
+			/* cluster. Skip button controls and read-only */
+			/* controls. */
+			if (ctrl->done || ctrl->type == V4L2_CTRL_TYPE_BUTTON ||
+				(ctrl->flags & V4L2_CTRL_FLAG_READ_ONLY))
+				continue;
 
-		for (i = 0; i < master->ncontrols; i++) {
-			if (master->cluster[i]) {
-				cur_to_new(master->cluster[i]);
-				master->cluster[i]->is_new = 1;
-				master->cluster[i]->done = true;
+			for (i = 0; i < master->ncontrols; i++) {
+				if (master->cluster[i]) {
+					cur_to_new(master->cluster[i]);
+					master->cluster[i]->is_new = 1;
+					master->cluster[i]->done = true;
+				}
 			}
+			ret = call_op(master, s_ctrl);
+			if (ret)
+				break;
 		}
-		ret = call_op(master, s_ctrl);
-		if (ret)
-			break;
 	}
 
 	return ret;
-- 
2.7.4

