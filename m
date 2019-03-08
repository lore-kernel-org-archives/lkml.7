Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1774DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E177D2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCHWIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:08:13 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42805 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726319AbfCHWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:08:13 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Mar 2019 00:08:09 +0200
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x28M83SV002296;
        Sat, 9 Mar 2019 00:08:07 +0200
From:   Parav Pandit <parav@mellanox.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com, kwankhede@nvidia.com
Cc:     parav@mellanox.com, alex.williamson@redhat.com,
        vuhuong@mellanox.com, yuvalav@mellanox.com,
        jakub.kicinski@netronome.com, kvm@vger.kernel.org
Subject: [RFC net-next v1 1/3] vfio/mdev: Inherit dma masks of parent device
Date:   Fri,  8 Mar 2019 16:07:54 -0600
Message-Id: <1552082876-60228-2-git-send-email-parav@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1552082876-60228-1-git-send-email-parav@mellanox.com>
References: <1552082876-60228-1-git-send-email-parav@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inherit dma mask of parent device in child mdev devices, so that
protocol stack can use right dma mask while doing dma mappings.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 drivers/vfio/mdev/mdev_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0e..9b8bdc9 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -315,6 +315,10 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
 	mdev->dev.parent  = dev;
 	mdev->dev.bus     = &mdev_bus_type;
 	mdev->dev.release = mdev_device_release;
+	mdev->dev.dma_mask = dev->dma_mask;
+	mdev->dev.dma_parms = dev->dma_parms;
+	mdev->dev.coherent_dma_mask = dev->coherent_dma_mask;
+
 	dev_set_name(&mdev->dev, "%pUl", uuid.b);
 
 	ret = device_register(&mdev->dev);
-- 
1.8.3.1

