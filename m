Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1E52082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfC0DqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:46:02 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40505 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732962AbfC0Dpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:45:55 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2019 05:45:52 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x2R3jlG6031531;
        Wed, 27 Mar 2019 05:45:51 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     cjia@nvidia.com, parav@mellanox.com
Subject: [PATCHv1 2/7] vfio/mdev: Removed unused kref
Date:   Tue, 26 Mar 2019 22:45:40 -0500
Message-Id: <1553658345-43995-3-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553658345-43995-1-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused kref from the mdev_device structure.

Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
Reviewed By: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_core.c    | 1 -
 drivers/vfio/mdev/mdev_private.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 1299d2e..00ca613 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -311,7 +311,6 @@ int mdev_device_create(struct kobject *kobj,
 	mutex_unlock(&mdev_list_lock);
 
 	mdev->parent = parent;
-	kref_init(&mdev->ref);
 
 	mdev->dev.parent  = dev;
 	mdev->dev.bus     = &mdev_bus_type;
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 379758c..ddcf9c7 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -30,7 +30,6 @@ struct mdev_device {
 	struct mdev_parent *parent;
 	guid_t uuid;
 	void *driver_data;
-	struct kref ref;
 	struct list_head next;
 	struct kobject *type_kobj;
 	bool active;
-- 
1.8.3.1

