Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20342C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E743A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411235;
	bh=frYxrMSd+AzJSnJ8BB5h3ppsB5r7/iaIa9zuRBA8Gag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6kLs3BHCFk0leiratp0Qa7KbGM6nl24jFF0PzZORaFisfLjYp5rxJRs2XpxLLWOs
	 CGeVAY9Zq15hRWjOjZ+gShGEFT5wH6XrC7MVfKenwivEfdb1z41nq+kUWLVb6QwSQ4
	 rK1C/uB+4185Fm2sXDDyb+8eVkFEDBvC36VynPso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfCLRSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729655AbfCLRRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:34 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1AE02186A;
        Tue, 12 Mar 2019 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411054;
        bh=frYxrMSd+AzJSnJ8BB5h3ppsB5r7/iaIa9zuRBA8Gag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjzUhp6pIrLm9sKI0pr9c9HbXyZ7dIvXFGHR1N2jH7wAgB5mTWKqvJDNqUIp/KANe
         aX0Mt50TVdq4EUCR6Wz6K+PmBaa1SMO//tBl9YOvJLk/8Exi4hBqGUvnwT0M1fv3F1
         4pT4WiBuJVloleAFHKJqIwS1M34Rx1FI03Hczlgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Druzhinin <igor.druzhinin@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 21/96] xen-netback: dont populate the hash cache on XenBus disconnect
Date:   Tue, 12 Mar 2019 10:09:39 -0700
Message-Id: <20190312171036.123110394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -152,6 +152,13 @@ static u16 xenvif_select_queue(struct ne
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


