Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAC021734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412557;
	bh=UY2kBkV2e9l/KGrFwczm1NkHnmte9s0hWgV8g+o2cBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2jFKO6Mxp/vTZXbLcdWYNgR+JPLByrVBJQGaiAvA8Zo7059NDCrwgvElPhchPShzf
	 MG9fEwe3+YWcSp5lWJzHPCugDT47IyDZKu+6IuqV4qB4fy7AkJKv/TRRxCtdXcvfWk
	 lhDl1kdHW8UAH4I3ZyLr1QzJWS+CnwqsvdnRdrpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfCLRmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbfCLRP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:56 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BCE821850;
        Tue, 12 Mar 2019 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410955;
        bh=UY2kBkV2e9l/KGrFwczm1NkHnmte9s0hWgV8g+o2cBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QE+fnJuMMqqzZ9XiZOy9vtcc8TZlhRyzgGS6/mqKDzEy1G7IuDCQdf4hfKNUduIVG
         vmxOrAA0jtDLYtgJtyEtA8wKS7rHhEQn+jFY9haDs+9gzgBBwhJqLuHGLZQTRwscvv
         Gb5yEaGg8p5SkisK9c7PkgqF6uYaEQwUPJKpQ7Ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Druzhinin <igor.druzhinin@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 024/135] xen-netback: dont populate the hash cache on XenBus disconnect
Date:   Tue, 12 Mar 2019 10:07:51 -0700
Message-Id: <20190312170343.347675274@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -435,6 +435,8 @@ void xenvif_init_hash(struct xenvif *vif
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
 		return fallback(dev, skb) % dev->real_num_tx_queues;


