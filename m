Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD7BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12467218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfCVXUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:20:44 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:56782 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726276AbfCVXUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:20:44 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 23 Mar 2019 01:20:42 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x2MNKavx007896;
        Sat, 23 Mar 2019 01:20:40 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kwankhede@nvidia.com, alex.williamson@redhat.com
Cc:     parav@mellanox.com
Subject: [PATCH 1/8] vfio/mdev: Fix to not do put_device on device_register failure
Date:   Fri, 22 Mar 2019 18:20:28 -0500
Message-Id: <1553296835-37522-2-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553296835-37522-1-git-send-email-parav@mellanox.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() performs put_device() if device_add() fails.
This balances with device_initialize().

mdev core performing put_device() when device_register() fails,
is an error that puts already released device again.
Therefore, don't put the device on error.

Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0e..3e5880a 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -318,10 +318,8 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 	dev_set_name(&mdev->dev, "%pUl", uuid.b);
 
 	ret = device_register(&mdev->dev);
-	if (ret) {
-		put_device(&mdev->dev);
+	if (ret)
 		goto mdev_fail;
-	}
 
 	ret = mdev_device_create_ops(kobj, mdev);
 	if (ret)
-- 
1.8.3.1

