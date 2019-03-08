Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE81C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6D2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049733;
	bh=RYCtyBhDm6qL2hKh5c1Vhxh0UYC79YgCgtBHA0rpwkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3lPMv1U99XsXOIhYjPo6O/Fjs55Mo3sLTnxT4wLA2x34FIS0X2NQ9vqGAOxvGKD2
	 6tkFy0AcB5awERt1/cs25D4i8ihrtATIvfKeRu+yIjVL1WvHo2LRKJRJCOfCD551cG
	 igjIw8sgjegpFrKd0aMn/HCbx9wbEoc4+10ejHxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCHMzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfCHMz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE242085A;
        Fri,  8 Mar 2019 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049727;
        bh=RYCtyBhDm6qL2hKh5c1Vhxh0UYC79YgCgtBHA0rpwkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A55nd3YpIa7vSn9S2L2gBFjb+/GHkG+Q2SHtu1KNy5XXuofdbY+ESx4nTzgxy5TIL
         ZR8e5Y1/kn3zp29Gf7TlFN9CnaGO71GLm5Yuz6/nIB8dcqx35yGEirN/EAZuId3MuA
         X0+lmlBSpimK8N+Yixjs3wwz/Nz5UW3KSmy6DwVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Druzhinin <igor.druzhinin@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 46/76] xen-netback: dont populate the hash cache on XenBus disconnect
Date:   Fri,  8 Mar 2019 13:49:58 +0100
Message-Id: <20190308124916.445603543@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Druzhinin <igor.druzhinin@citrix.com>

[ Upstream commit a2288d4e355992d369c50c45d017a85f6061ff71 ]

Occasionally, during the disconnection procedure on XenBus which
includes hash cache deinitialization there might be some packets
still in-flight on other processors. Handling of these packets includes
hashing and hash cache population that finally results in hash cache
data structure corruption.

In order to avoid this we prevent hashing of those packets if there
are no queues initialized. In that case RCU protection of queues guards
the hash cache as well.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netback/hash.c      |    2 ++
 drivers/net/xen-netback/interface.c |    7 +++++++
 2 files changed, 9 insertions(+)

--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -454,6 +454,8 @@ void xenvif_init_hash(struct xenvif *vif
 	if (xenvif_hash_cache_size == 0)
 		return;
 
+	BUG_ON(vif->hash.cache.count);
+
 	spin_lock_init(&vif->hash.cache.lock);
 	INIT_LIST_HEAD(&vif->hash.cache.list);
 }
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -153,6 +153,13 @@ static u16 xenvif_select_queue(struct ne
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


