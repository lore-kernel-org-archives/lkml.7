Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC7AC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF7B23431
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfHaACJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 20:02:09 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34626 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfHaACJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:02:09 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i3qqE-0003Cm-6L; Fri, 30 Aug 2019 18:02:07 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i3qqC-00020M-63; Fri, 30 Aug 2019 18:02:04 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 30 Aug 2019 18:01:39 -0600
Message-Id: <20190831000139.7662-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, hare@suse.com, martin.petersen@oracle.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multipath enabled (which is now default in many distros), nvme
controllers and their respective namespaces can be numbered
differently. For example: nvme0n1 might actually belong to controller
nvme1, which is super confusing (and may have broken any scripts that
rely on the numbering relation). To make matters worse, the mismatches
can sometimes change from boot to boot so anyone dealing with the
nvme control device has to inspect sysfs every boot to ensure they
get the right one.

The reason for this is that the X in nvmeXn1 is the subsystem's instance
number (when multipath is enabled) which is distinct from the
controller's instance and the subsystem instance is assigned from a
separate IDA after the controller gets identified and this can race
a bit when multiple controllers are being setup.

To fix this, assign the subsystem's instance based on the instance
number of the controller's instance that first created it. There should
always be fewer subsystems than controllers so the should not be a need
to create extra subsystems that overlap existing controllers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd6903..ca201b71ab49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -2332,7 +2331,6 @@ static void nvme_release_subsystem(struct device *dev)
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -2461,12 +2459,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
-	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(subsys);
-		return ret;
-	}
-	subsys->instance = ret;
+	subsys->instance = ctrl->instance;
 	mutex_init(&subsys->lock);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
@@ -4074,7 +4067,6 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
-- 
2.20.1

