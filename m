Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80640C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5829C2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567618431;
	bh=rK9BphDiz1ChLpGzusVKfpkUVPpbuyxLNh/oHiPq6H8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QJjXnX+5gbJCdeJ4+5ZnV3tYdDLz2lRYdNZi/30WExJTgQ+cMSf8BSWE21+LbX/JX
	 ghW0KwtLLIVcOAWLea6fYdUHwUOzNTpQogxOHOAgXQP4TGQ9gsAsQGX/0bWMWMB8Hv
	 OYt9jn95MVPWsJehYtphcGR8kVjgwA4FcbxMrY/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfIDRdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:33:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:31688 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbfIDRdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:33:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="199078464"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2019 10:33:49 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: Restore device naming sanity
Date:   Wed,  4 Sep 2019 11:31:59 -0600
Message-Id: <20190904173159.22921-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The namespace names must be unique for the lifetime of the subsystem.
This was accomplished by using their parent subsystems' instances which
was independent of the controllers connected to that subsystem.

The consequence of that naming scheme meant that name prefixes given to
namespaces may match a controller from an unrelated subsystem. This has
understandbly invited confusion when examining device nodes.

Ensure the namespace's subsystem instance never clashes with a
controller instance of another subsystem by transferring the instance
ownership to parent subsystem from the first controller discovered in
that subsystem.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 14c0bfb55615..8a8279ece5ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -2344,7 +2343,8 @@ static void nvme_release_subsystem(struct device *dev)
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
+	if (subsys->instance >= 0)
+		ida_simple_remove(&nvme_instance_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -2473,12 +2473,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
-	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(subsys);
-		return ret;
-	}
-	subsys->instance = ret;
+
+	subsys->instance = -1;
 	mutex_init(&subsys->lock);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
@@ -2497,7 +2493,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
 	subsys->dev.groups = nvme_subsys_attrs_groups;
-	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
+	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);
 	device_initialize(&subsys->dev);
 
 	mutex_lock(&nvme_subsystems_lock);
@@ -2528,6 +2524,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		goto out_put_subsystem;
 	}
 
+	if (!found)
+		subsys->instance = ctrl->instance;
 	ctrl->subsys = subsys;
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	mutex_unlock(&nvme_subsystems_lock);
@@ -3803,7 +3801,9 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
-	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+	if (subsys && ctrl->instance != subsys->instance)
+		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+
 	kfree(ctrl->effects);
 	nvme_mpath_uninit(ctrl);
 	__free_page(ctrl->discard_page);
@@ -4085,7 +4085,6 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
-- 
2.14.5

