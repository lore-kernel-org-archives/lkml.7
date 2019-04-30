Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15AEC04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDE421743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfD3Wtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:49:49 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45872 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727469AbfD3Wts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:49:48 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 May 2019 01:49:45 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3UMncnX009688;
        Wed, 1 May 2019 01:49:44 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     cjia@nvidia.com, parav@mellanox.com
Subject: [PATCHv2 03/10] vfio/mdev: Drop redundant extern for exported symbols
Date:   Tue, 30 Apr 2019 17:49:30 -0500
Message-Id: <20190430224937.57156-4-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190430224937.57156-1-parav@mellanox.com>
References: <20190430224937.57156-1-parav@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need use 'extern' for exported functions.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 include/linux/mdev.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index d7aee90e5da5..4924d8038814 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -118,21 +118,20 @@ struct mdev_driver {
 
 #define to_mdev_driver(drv)	container_of(drv, struct mdev_driver, driver)
 
-extern void *mdev_get_drvdata(struct mdev_device *mdev);
-extern void mdev_set_drvdata(struct mdev_device *mdev, void *data);
-extern const guid_t *mdev_uuid(struct mdev_device *mdev);
+void *mdev_get_drvdata(struct mdev_device *mdev);
+void mdev_set_drvdata(struct mdev_device *mdev, void *data);
+const guid_t *mdev_uuid(struct mdev_device *mdev);
 
 extern struct bus_type mdev_bus_type;
 
-extern int  mdev_register_device(struct device *dev,
-				 const struct mdev_parent_ops *ops);
-extern void mdev_unregister_device(struct device *dev);
+int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops);
+void mdev_unregister_device(struct device *dev);
 
-extern int  mdev_register_driver(struct mdev_driver *drv, struct module *owner);
-extern void mdev_unregister_driver(struct mdev_driver *drv);
+int mdev_register_driver(struct mdev_driver *drv, struct module *owner);
+void mdev_unregister_driver(struct mdev_driver *drv);
 
-extern struct device *mdev_parent_dev(struct mdev_device *mdev);
-extern struct device *mdev_dev(struct mdev_device *mdev);
-extern struct mdev_device *mdev_from_dev(struct device *dev);
+struct device *mdev_parent_dev(struct mdev_device *mdev);
+struct device *mdev_dev(struct mdev_device *mdev);
+struct mdev_device *mdev_from_dev(struct device *dev);
 
 #endif /* MDEV_H */
-- 
2.19.2

