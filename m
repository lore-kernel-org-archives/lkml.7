Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F15C2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbfB1OMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:12:02 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:31780 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbfB1OMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:12:02 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544486400"; 
   d="scan'208";a="79327735"
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
To:     <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <davem@davemloft.net>, Igor Druzhinin <igor.druzhinin@citrix.com>
Subject: [PATCH] xen-netback: don't populate the hash cache on XenBus disconnect
Date:   Thu, 28 Feb 2019 14:11:26 +0000
Message-ID: <1551363086-29652-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally, during the disconnection procedure on XenBus which
includes hash cache deinitialization there might be some packets
still in-flight on other processors. Handling of these packets includes
hashing and hash cache population that finally results in hash cache
data structure corruption.

In order to avoid this we prevent hashing of those packets if there
are no queues initialized. In that case RCU protection of queues guards
the hash cache as well.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---

Found this while applying the previous patch to our patchqueue. Seems it
never went to the mailing list and, to my knowledge, the problem is still
present. From my recollection, it only happened on stress frontend on/off
test with Windows guests (since only those detach the frontend completely).
So better late than never.

---
 drivers/net/xen-netback/hash.c      | 2 ++
 drivers/net/xen-netback/interface.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index 0ccb021..10d580c 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -454,6 +454,8 @@ void xenvif_init_hash(struct xenvif *vif)
 	if (xenvif_hash_cache_size == 0)
 		return;
 
+	BUG_ON(vif->hash.cache.count);
+
 	spin_lock_init(&vif->hash.cache.lock);
 	INIT_LIST_HEAD(&vif->hash.cache.list);
 }
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 182d677..6da1251 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -153,6 +153,13 @@ static u16 xenvif_select_queue(struct net_device *dev, struct sk_buff *skb,
 {
 	struct xenvif *vif = netdev_priv(dev);
 	unsigned int size = vif->hash.size;
+	unsigned int num_queues;
+
+	/* If queues are not set up internally - always return 0
+	 * as the packet going to be dropped anyway */
+	num_queues = READ_ONCE(vif->num_queues);
+	if (num_queues < 1)
+		return 0;
 
 	if (vif->hash.alg == XEN_NETIF_CTRL_HASH_ALGORITHM_NONE)
 		return fallback(dev, skb, NULL) % dev->real_num_tx_queues;
-- 
2.7.4

