Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2287BC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE4F21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfIBEYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:24:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35675 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729499AbfIBEYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:24:51 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 2 Sep 2019 07:24:47 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x824OeRM001225;
        Mon, 2 Sep 2019 07:24:45 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     alex.williamson@redhat.com, jiri@mellanox.com,
        kwankhede@nvidia.com, cohuck@redhat.com, davem@davemloft.net
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Subject: [PATCH v3 2/5] mdev: Make mdev alias unique among all mdevs
Date:   Sun,  1 Sep 2019 23:24:33 -0500
Message-Id: <20190902042436.23294-3-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190902042436.23294-1-parav@mellanox.com>
References: <20190826204119.54386-1-parav@mellanox.com>
 <20190902042436.23294-1-parav@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mdev alias should be unique among all the mdevs, so that when such alias
is used by the mdev users to derive other objects, there is no
collision in a given system.

Signed-off-by: Parav Pandit <parav@mellanox.com>

---
Changelog:
v2->v3:
 - Changed strcmp() ==0 to !strcmp()
v1->v2:
 - Moved alias NULL check at beginning
v0->v1:
 - Fixed inclusiong of alias for NULL check
 - Added ratelimited debug print for sha1 hash collision error
---
 drivers/vfio/mdev/mdev_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 3bdff0469607..c8cd40366783 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -388,6 +388,13 @@ int mdev_device_create(struct kobject *kobj, struct device *dev,
 			ret = -EEXIST;
 			goto mdev_fail;
 		}
+		if (alias && tmp->alias && !strcmp(alias, tmp->alias)) {
+			mutex_unlock(&mdev_list_lock);
+			ret = -EEXIST;
+			dev_dbg_ratelimited(dev, "Hash collision in alias creation for UUID %pUl\n",
+					    uuid);
+			goto mdev_fail;
+		}
 	}
 
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
-- 
2.19.2

