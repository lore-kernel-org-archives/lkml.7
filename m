Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E1FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC5B2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389282AbfHBG7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:59:23 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39043 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389250AbfHBG7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:59:19 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 2 Aug 2019 09:59:13 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x726x7pY004367;
        Fri, 2 Aug 2019 09:59:11 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, wankhede@nvidia.com,
        linux-kernel@vger.kernel.org
Cc:     parav@mellanox.com, alex.williamson@redhat.com, cohuck@redhat.com,
        cjia@nvidia.com
Subject: [PATCH 2/2] vfio/mdev: Removed unused and redundant API for mdev name
Date:   Fri,  2 Aug 2019 01:59:05 -0500
Message-Id: <20190802065905.45239-3-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190802065905.45239-1-parav@mellanox.com>
References: <20190802065905.45239-1-parav@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no single production driver who is interested in mdev device
name.
Additionally mdev device name is already available using core kernel
API dev_name().

Hence removed unused exported symbol.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_core.c | 6 ------
 include/linux/mdev.h          | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index b558d4cfd082..c2b809cbe59f 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -57,12 +57,6 @@ struct mdev_device *mdev_from_dev(struct device *dev)
 }
 EXPORT_SYMBOL(mdev_from_dev);
 
-const guid_t *mdev_uuid(struct mdev_device *mdev)
-{
-	return &mdev->uuid;
-}
-EXPORT_SYMBOL(mdev_uuid);
-
 /* Should be called holding parent_list_lock */
 static struct mdev_parent *__find_parent_device(struct device *dev)
 {
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 0ce30ca78db0..375a5830c3d8 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -131,7 +131,6 @@ struct mdev_driver {
 
 void *mdev_get_drvdata(struct mdev_device *mdev);
 void mdev_set_drvdata(struct mdev_device *mdev, void *data);
-const guid_t *mdev_uuid(struct mdev_device *mdev);
 
 extern struct bus_type mdev_bus_type;
 
-- 
2.21.0.777.g83232e3864

