Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5FB2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbfC0DqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:46:21 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:40537 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733032AbfC0DqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:46:00 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2019 05:45:57 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x2R3jlG9031531;
        Wed, 27 Mar 2019 05:45:55 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     cjia@nvidia.com, parav@mellanox.com
Subject: [PATCHv1 5/7] vfio/mdev: Follow correct remove sequence
Date:   Tue, 26 Mar 2019 22:45:43 -0500
Message-Id: <1553658345-43995-6-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553658345-43995-1-git-send-email-parav@mellanox.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mdev_remove_sysfs_files() should follow exact mirror sequence of a
create, similar to what is followed in error unwinding path of
mdev_create_sysfs_files().

Fixes: 6a62c1dfb5c7 ("vfio/mdev: Re-order sysfs attribute creation")
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index 5193a0e..cbf94b8 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -280,7 +280,7 @@ int  mdev_create_sysfs_files(struct device *dev, struct mdev_type *type)
 
 void mdev_remove_sysfs_files(struct device *dev, struct mdev_type *type)
 {
+	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
 	sysfs_remove_link(&dev->kobj, "mdev_type");
 	sysfs_remove_link(type->devices_kobj, dev_name(dev));
-	sysfs_remove_files(&dev->kobj, mdev_device_attrs);
 }
-- 
1.8.3.1

