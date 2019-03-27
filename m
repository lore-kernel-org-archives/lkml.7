Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B157C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8689217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710183;
	bh=L717aaQdtJZI7cgIFRaU5bffceUa60LxxGPnBFnbDFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9j15mgIjQpn4v1+1Q4tg8xkDqe6rNI37/lzRTyn6QBpfdsKLlxujjQbEtXjuKy/M
	 uzzCSrfP1coyh3KaobxcsyHcGg/WDAbmzxRHi5Uyku5H3O62KSJGu651dNp8gYbyjv
	 lvyQDVGcjtvl7/8/2a45BLR/1Kq69YCQwH3NhJvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfC0SJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388229AbfC0SJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B559C2054F;
        Wed, 27 Mar 2019 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710175;
        bh=L717aaQdtJZI7cgIFRaU5bffceUa60LxxGPnBFnbDFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWbueuDRvZsUJuPLcVYK8XNWCzJPfUyj9isJElUUxufAfW8ZZMw/0AZ0ToO70b2hj
         Ut9pV4yCcnhUgfC5KuRZ2OqHAJpsvemdBKDTqEXfPvVPOQO+HSgAt1NGyti+9wS2vP
         LiU/k51Xg92bes9SjxFgzHelf5wClLY4Qu+soSCY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Hurley <john.hurley@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 234/262] nfp: flower: tidy tunnel related private data
Date:   Wed, 27 Mar 2019 14:01:29 -0400
Message-Id: <20190327180158.10245-234-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit f3b975778c176b01eba10f869a5a64c6b8550c23 ]

Recent additions to the flower app private data have grouped the variables
of a given feature into a struct and added that struct to the main private
data struct.

In keeping with this, move all tunnel related private data to their own
struct. This has no affect on functionality but improves readability and
maintenance of the code.

Signed-off-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/netronome/nfp/flower/main.h  |  52 ++++---
 .../netronome/nfp/flower/tunnel_conf.c        | 144 +++++++++---------
 2 files changed, 102 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.h b/drivers/net/ethernet/netronome/nfp/flower/main.h
index b858bac47621..4a7896042ab8 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -53,6 +53,34 @@ struct nfp_fl_stats_id {
 	u8 repeated_em_count;
 };
 
+/**
+ * struct nfp_fl_tunnel_offloads - priv data for tunnel offloads
+ * @mac_off_list:	List of MAC addresses to offload
+ * @mac_index_list:	List of unique 8-bit indexes for non NFP netdevs
+ * @ipv4_off_list:	List of IPv4 addresses to offload
+ * @neigh_off_list:	List of neighbour offloads
+ * @mac_off_lock:	Lock for the MAC address list
+ * @mac_index_lock:	Lock for the MAC index list
+ * @ipv4_off_lock:	Lock for the IPv4 address list
+ * @neigh_off_lock:	Lock for the neighbour address list
+ * @mac_off_ids:	IDA to manage id assignment for offloaded MACs
+ * @mac_off_count:	Number of MACs in address list
+ * @neigh_nb:		Notifier to monitor neighbour state
+ */
+struct nfp_fl_tunnel_offloads {
+	struct list_head mac_off_list;
+	struct list_head mac_index_list;
+	struct list_head ipv4_off_list;
+	struct list_head neigh_off_list;
+	struct mutex mac_off_lock;
+	struct mutex mac_index_lock;
+	struct mutex ipv4_off_lock;
+	spinlock_t neigh_off_lock;
+	struct ida mac_off_ids;
+	int mac_off_count;
+	struct notifier_block neigh_nb;
+};
+
 /**
  * struct nfp_mtu_conf - manage MTU setting
  * @portnum:		NFP port number of repr with requested MTU change
@@ -113,17 +141,7 @@ struct nfp_fl_lag {
  *			processing
  * @cmsg_skbs_low:	List of lower priority skbs for control message
  *			processing
- * @nfp_mac_off_list:	List of MAC addresses to offload
- * @nfp_mac_index_list:	List of unique 8-bit indexes for non NFP netdevs
- * @nfp_ipv4_off_list:	List of IPv4 addresses to offload
- * @nfp_neigh_off_list:	List of neighbour offloads
- * @nfp_mac_off_lock:	Lock for the MAC address list
- * @nfp_mac_index_lock:	Lock for the MAC index list
- * @nfp_ipv4_off_lock:	Lock for the IPv4 address list
- * @nfp_neigh_off_lock:	Lock for the neighbour address list
- * @nfp_mac_off_ids:	IDA to manage id assignment for offloaded macs
- * @nfp_mac_off_count:	Number of MACs in address list
- * @nfp_tun_neigh_nb:	Notifier to monitor neighbour state
+ * @tun:		Tunnel offload data
  * @reify_replies:	atomically stores the number of replies received
  *			from firmware for repr reify
  * @reify_wait_queue:	wait queue for repr reify response counting
@@ -147,17 +165,7 @@ struct nfp_flower_priv {
 	struct work_struct cmsg_work;
 	struct sk_buff_head cmsg_skbs_high;
 	struct sk_buff_head cmsg_skbs_low;
-	struct list_head nfp_mac_off_list;
-	struct list_head nfp_mac_index_list;
-	struct list_head nfp_ipv4_off_list;
-	struct list_head nfp_neigh_off_list;
-	struct mutex nfp_mac_off_lock;
-	struct mutex nfp_mac_index_lock;
-	struct mutex nfp_ipv4_off_lock;
-	spinlock_t nfp_neigh_off_lock;
-	struct ida nfp_mac_off_ids;
-	int nfp_mac_off_count;
-	struct notifier_block nfp_tun_neigh_nb;
+	struct nfp_fl_tunnel_offloads tun;
 	atomic_t reify_replies;
 	wait_queue_head_t reify_wait_queue;
 	struct nfp_mtu_conf mtu_conf;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 2d9f26a725c2..3026ab178fd2 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -205,15 +205,15 @@ static bool nfp_tun_has_route(struct nfp_app *app, __be32 ipv4_addr)
 	struct nfp_ipv4_route_entry *entry;
 	struct list_head *ptr, *storage;
 
-	spin_lock_bh(&priv->nfp_neigh_off_lock);
-	list_for_each_safe(ptr, storage, &priv->nfp_neigh_off_list) {
+	spin_lock_bh(&priv->tun.neigh_off_lock);
+	list_for_each_safe(ptr, storage, &priv->tun.neigh_off_list) {
 		entry = list_entry(ptr, struct nfp_ipv4_route_entry, list);
 		if (entry->ipv4_addr == ipv4_addr) {
-			spin_unlock_bh(&priv->nfp_neigh_off_lock);
+			spin_unlock_bh(&priv->tun.neigh_off_lock);
 			return true;
 		}
 	}
-	spin_unlock_bh(&priv->nfp_neigh_off_lock);
+	spin_unlock_bh(&priv->tun.neigh_off_lock);
 	return false;
 }
 
@@ -223,24 +223,24 @@ static void nfp_tun_add_route_to_cache(struct nfp_app *app, __be32 ipv4_addr)
 	struct nfp_ipv4_route_entry *entry;
 	struct list_head *ptr, *storage;
 
-	spin_lock_bh(&priv->nfp_neigh_off_lock);
-	list_for_each_safe(ptr, storage, &priv->nfp_neigh_off_list) {
+	spin_lock_bh(&priv->tun.neigh_off_lock);
+	list_for_each_safe(ptr, storage, &priv->tun.neigh_off_list) {
 		entry = list_entry(ptr, struct nfp_ipv4_route_entry, list);
 		if (entry->ipv4_addr == ipv4_addr) {
-			spin_unlock_bh(&priv->nfp_neigh_off_lock);
+			spin_unlock_bh(&priv->tun.neigh_off_lock);
 			return;
 		}
 	}
 	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry) {
-		spin_unlock_bh(&priv->nfp_neigh_off_lock);
+		spin_unlock_bh(&priv->tun.neigh_off_lock);
 		nfp_flower_cmsg_warn(app, "Mem error when storing new route.\n");
 		return;
 	}
 
 	entry->ipv4_addr = ipv4_addr;
-	list_add_tail(&entry->list, &priv->nfp_neigh_off_list);
-	spin_unlock_bh(&priv->nfp_neigh_off_lock);
+	list_add_tail(&entry->list, &priv->tun.neigh_off_list);
+	spin_unlock_bh(&priv->tun.neigh_off_lock);
 }
 
 static void nfp_tun_del_route_from_cache(struct nfp_app *app, __be32 ipv4_addr)
@@ -249,8 +249,8 @@ static void nfp_tun_del_route_from_cache(struct nfp_app *app, __be32 ipv4_addr)
 	struct nfp_ipv4_route_entry *entry;
 	struct list_head *ptr, *storage;
 
-	spin_lock_bh(&priv->nfp_neigh_off_lock);
-	list_for_each_safe(ptr, storage, &priv->nfp_neigh_off_list) {
+	spin_lock_bh(&priv->tun.neigh_off_lock);
+	list_for_each_safe(ptr, storage, &priv->tun.neigh_off_list) {
 		entry = list_entry(ptr, struct nfp_ipv4_route_entry, list);
 		if (entry->ipv4_addr == ipv4_addr) {
 			list_del(&entry->list);
@@ -258,7 +258,7 @@ static void nfp_tun_del_route_from_cache(struct nfp_app *app, __be32 ipv4_addr)
 			break;
 		}
 	}
-	spin_unlock_bh(&priv->nfp_neigh_off_lock);
+	spin_unlock_bh(&priv->tun.neigh_off_lock);
 }
 
 static void
@@ -326,7 +326,7 @@ nfp_tun_neigh_event_handler(struct notifier_block *nb, unsigned long event,
 	if (!nfp_netdev_is_nfp_repr(n->dev))
 		return NOTIFY_DONE;
 
-	app_priv = container_of(nb, struct nfp_flower_priv, nfp_tun_neigh_nb);
+	app_priv = container_of(nb, struct nfp_flower_priv, tun.neigh_nb);
 	app = app_priv->app;
 
 	/* Only concerned with changes to routes already added to NFP. */
@@ -401,11 +401,11 @@ static void nfp_tun_write_ipv4_list(struct nfp_app *app)
 	int count;
 
 	memset(&payload, 0, sizeof(struct nfp_tun_ipv4_addr));
-	mutex_lock(&priv->nfp_ipv4_off_lock);
+	mutex_lock(&priv->tun.ipv4_off_lock);
 	count = 0;
-	list_for_each_safe(ptr, storage, &priv->nfp_ipv4_off_list) {
+	list_for_each_safe(ptr, storage, &priv->tun.ipv4_off_list) {
 		if (count >= NFP_FL_IPV4_ADDRS_MAX) {
-			mutex_unlock(&priv->nfp_ipv4_off_lock);
+			mutex_unlock(&priv->tun.ipv4_off_lock);
 			nfp_flower_cmsg_warn(app, "IPv4 offload exceeds limit.\n");
 			return;
 		}
@@ -413,7 +413,7 @@ static void nfp_tun_write_ipv4_list(struct nfp_app *app)
 		payload.ipv4_addr[count++] = entry->ipv4_addr;
 	}
 	payload.count = cpu_to_be32(count);
-	mutex_unlock(&priv->nfp_ipv4_off_lock);
+	mutex_unlock(&priv->tun.ipv4_off_lock);
 
 	nfp_flower_xmit_tun_conf(app, NFP_FLOWER_CMSG_TYPE_TUN_IPS,
 				 sizeof(struct nfp_tun_ipv4_addr),
@@ -426,26 +426,26 @@ void nfp_tunnel_add_ipv4_off(struct nfp_app *app, __be32 ipv4)
 	struct nfp_ipv4_addr_entry *entry;
 	struct list_head *ptr, *storage;
 
-	mutex_lock(&priv->nfp_ipv4_off_lock);
-	list_for_each_safe(ptr, storage, &priv->nfp_ipv4_off_list) {
+	mutex_lock(&priv->tun.ipv4_off_lock);
+	list_for_each_safe(ptr, storage, &priv->tun.ipv4_off_list) {
 		entry = list_entry(ptr, struct nfp_ipv4_addr_entry, list);
 		if (entry->ipv4_addr == ipv4) {
 			entry->ref_count++;
-			mutex_unlock(&priv->nfp_ipv4_off_lock);
+			mutex_unlock(&priv->tun.ipv4_off_lock);
 			return;
 		}
 	}
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
-		mutex_unlock(&priv->nfp_ipv4_off_lock);
+		mutex_unlock(&priv->tun.ipv4_off_lock);
 		nfp_flower_cmsg_warn(app, "Mem error when offloading IP address.\n");
 		return;
 	}
 	entry->ipv4_addr = ipv4;
 	entry->ref_count = 1;
-	list_add_tail(&entry->list, &priv->nfp_ipv4_off_list);
-	mutex_unlock(&priv->nfp_ipv4_off_lock);
+	list_add_tail(&entry->list, &priv->tun.ipv4_off_list);
+	mutex_unlock(&priv->tun.ipv4_off_lock);
 
 	nfp_tun_write_ipv4_list(app);
 }
@@ -456,8 +456,8 @@ void nfp_tunnel_del_ipv4_off(struct nfp_app *app, __be32 ipv4)
 	struct nfp_ipv4_addr_entry *entry;
 	struct list_head *ptr, *storage;
 
-	mutex_lock(&priv->nfp_ipv4_off_lock);
-	list_for_each_safe(ptr, storage, &priv->nfp_ipv4_off_list) {
+	mutex_lock(&priv->tun.ipv4_off_lock);
+	list_for_each_safe(ptr, storage, &priv->tun.ipv4_off_list) {
 		entry = list_entry(ptr, struct nfp_ipv4_addr_entry, list);
 		if (entry->ipv4_addr == ipv4) {
 			entry->ref_count--;
@@ -468,7 +468,7 @@ void nfp_tunnel_del_ipv4_off(struct nfp_app *app, __be32 ipv4)
 			break;
 		}
 	}
-	mutex_unlock(&priv->nfp_ipv4_off_lock);
+	mutex_unlock(&priv->tun.ipv4_off_lock);
 
 	nfp_tun_write_ipv4_list(app);
 }
@@ -481,25 +481,25 @@ void nfp_tunnel_write_macs(struct nfp_app *app)
 	struct list_head *ptr, *storage;
 	int mac_count, err, pay_size;
 
-	mutex_lock(&priv->nfp_mac_off_lock);
-	if (!priv->nfp_mac_off_count) {
-		mutex_unlock(&priv->nfp_mac_off_lock);
+	mutex_lock(&priv->tun.mac_off_lock);
+	if (!priv->tun.mac_off_count) {
+		mutex_unlock(&priv->tun.mac_off_lock);
 		return;
 	}
 
 	pay_size = sizeof(struct nfp_tun_mac_addr) +
-		   sizeof(struct index_mac_addr) * priv->nfp_mac_off_count;
+		   sizeof(struct index_mac_addr) * priv->tun.mac_off_count;
 
 	payload = kzalloc(pay_size, GFP_KERNEL);
 	if (!payload) {
-		mutex_unlock(&priv->nfp_mac_off_lock);
+		mutex_unlock(&priv->tun.mac_off_lock);
 		return;
 	}
 
-	payload->count = cpu_to_be16(priv->nfp_mac_off_count);
+	payload->count = cpu_to_be16(priv->tun.mac_off_count);
 
 	mac_count = 0;
-	list_for_each_safe(ptr, storage, &priv->nfp_mac_off_list) {
+	list_for_each_safe(ptr, storage, &priv->tun.mac_off_list) {
 		entry = list_entry(ptr, struct nfp_tun_mac_offload_entry,
 				   list);
 		payload->addresses[mac_count].index = entry->index;
@@ -514,21 +514,21 @@ void nfp_tunnel_write_macs(struct nfp_app *app)
 	kfree(payload);
 
 	if (err) {
-		mutex_unlock(&priv->nfp_mac_off_lock);
+		mutex_unlock(&priv->tun.mac_off_lock);
 		/* Write failed so retain list for future retry. */
 		return;
 	}
 
 	/* If list was successfully offloaded, flush it. */
-	list_for_each_safe(ptr, storage, &priv->nfp_mac_off_list) {
+	list_for_each_safe(ptr, storage, &priv->tun.mac_off_list) {
 		entry = list_entry(ptr, struct nfp_tun_mac_offload_entry,
 				   list);
 		list_del(&entry->list);
 		kfree(entry);
 	}
 
-	priv->nfp_mac_off_count = 0;
-	mutex_unlock(&priv->nfp_mac_off_lock);
+	priv->tun.mac_off_count = 0;
+	mutex_unlock(&priv->tun.mac_off_lock);
 }
 
 static int nfp_tun_get_mac_idx(struct nfp_app *app, int ifindex)
@@ -538,32 +538,32 @@ static int nfp_tun_get_mac_idx(struct nfp_app *app, int ifindex)
 	struct list_head *ptr, *storage;
 	int idx;
 
-	mutex_lock(&priv->nfp_mac_index_lock);
-	list_for_each_safe(ptr, storage, &priv->nfp_mac_index_list) {
+	mutex_lock(&priv->tun.mac_index_lock);
+	list_for_each_safe(ptr, storage, &priv->tun.mac_index_list) {
 		entry = list_entry(ptr, struct nfp_tun_mac_non_nfp_idx, list);
 		if (entry->ifindex == ifindex) {
 			idx = entry->index;
-			mutex_unlock(&priv->nfp_mac_index_lock);
+			mutex_unlock(&priv->tun.mac_index_lock);
 			return idx;
 		}
 	}
 
-	idx = ida_simple_get(&priv->nfp_mac_off_ids, 0,
+	idx = ida_simple_get(&priv->tun.mac_off_ids, 0,
 			     NFP_MAX_MAC_INDEX, GFP_KERNEL);
 	if (idx < 0) {
-		mutex_unlock(&priv->nfp_mac_index_lock);
+		mutex_unlock(&priv->tun.mac_index_lock);
 		return idx;
 	}
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry) {
-		mutex_unlock(&priv->nfp_mac_index_lock);
+		mutex_unlock(&priv->tun.mac_index_lock);
 		return -ENOMEM;
 	}
 	entry->ifindex = ifindex;
 	entry->index = idx;
-	list_add_tail(&entry->list, &priv->nfp_mac_index_list);
-	mutex_unlock(&priv->nfp_mac_index_lock);
+	list_add_tail(&entry->list, &priv->tun.mac_index_list);
+	mutex_unlock(&priv->tun.mac_index_lock);
 
 	return idx;
 }
@@ -574,18 +574,18 @@ static void nfp_tun_del_mac_idx(struct nfp_app *app, int ifindex)
 	struct nfp_tun_mac_non_nfp_idx *entry;
 	struct list_head *ptr, *storage;
 
-	mutex_lock(&priv->nfp_mac_index_lock);
-	list_for_each_safe(ptr, storage, &priv->nfp_mac_index_list) {
+	mutex_lock(&priv->tun.mac_index_lock);
+	list_for_each_safe(ptr, storage, &priv->tun.mac_index_list) {
 		entry = list_entry(ptr, struct nfp_tun_mac_non_nfp_idx, list);
 		if (entry->ifindex == ifindex) {
-			ida_simple_remove(&priv->nfp_mac_off_ids,
+			ida_simple_remove(&priv->tun.mac_off_ids,
 					  entry->index);
 			list_del(&entry->list);
 			kfree(entry);
 			break;
 		}
 	}
-	mutex_unlock(&priv->nfp_mac_index_lock);
+	mutex_unlock(&priv->tun.mac_index_lock);
 }
 
 static void nfp_tun_add_to_mac_offload_list(struct net_device *netdev,
@@ -633,10 +633,10 @@ static void nfp_tun_add_to_mac_offload_list(struct net_device *netdev,
 	entry->index = cpu_to_be16(nfp_mac_idx);
 	ether_addr_copy(entry->addr, netdev->dev_addr);
 
-	mutex_lock(&priv->nfp_mac_off_lock);
-	priv->nfp_mac_off_count++;
-	list_add_tail(&entry->list, &priv->nfp_mac_off_list);
-	mutex_unlock(&priv->nfp_mac_off_lock);
+	mutex_lock(&priv->tun.mac_off_lock);
+	priv->tun.mac_off_count++;
+	list_add_tail(&entry->list, &priv->tun.mac_off_list);
+	mutex_unlock(&priv->tun.mac_off_lock);
 }
 
 int nfp_tunnel_mac_event_handler(struct nfp_app *app,
@@ -662,23 +662,23 @@ int nfp_tunnel_config_start(struct nfp_app *app)
 	struct nfp_flower_priv *priv = app->priv;
 
 	/* Initialise priv data for MAC offloading. */
-	priv->nfp_mac_off_count = 0;
-	mutex_init(&priv->nfp_mac_off_lock);
-	INIT_LIST_HEAD(&priv->nfp_mac_off_list);
-	mutex_init(&priv->nfp_mac_index_lock);
-	INIT_LIST_HEAD(&priv->nfp_mac_index_list);
-	ida_init(&priv->nfp_mac_off_ids);
+	priv->tun.mac_off_count = 0;
+	mutex_init(&priv->tun.mac_off_lock);
+	INIT_LIST_HEAD(&priv->tun.mac_off_list);
+	mutex_init(&priv->tun.mac_index_lock);
+	INIT_LIST_HEAD(&priv->tun.mac_index_list);
+	ida_init(&priv->tun.mac_off_ids);
 
 	/* Initialise priv data for IPv4 offloading. */
-	mutex_init(&priv->nfp_ipv4_off_lock);
-	INIT_LIST_HEAD(&priv->nfp_ipv4_off_list);
+	mutex_init(&priv->tun.ipv4_off_lock);
+	INIT_LIST_HEAD(&priv->tun.ipv4_off_list);
 
 	/* Initialise priv data for neighbour offloading. */
-	spin_lock_init(&priv->nfp_neigh_off_lock);
-	INIT_LIST_HEAD(&priv->nfp_neigh_off_list);
-	priv->nfp_tun_neigh_nb.notifier_call = nfp_tun_neigh_event_handler;
+	spin_lock_init(&priv->tun.neigh_off_lock);
+	INIT_LIST_HEAD(&priv->tun.neigh_off_list);
+	priv->tun.neigh_nb.notifier_call = nfp_tun_neigh_event_handler;
 
-	return register_netevent_notifier(&priv->nfp_tun_neigh_nb);
+	return register_netevent_notifier(&priv->tun.neigh_nb);
 }
 
 void nfp_tunnel_config_stop(struct nfp_app *app)
@@ -690,10 +690,10 @@ void nfp_tunnel_config_stop(struct nfp_app *app)
 	struct nfp_ipv4_addr_entry *ip_entry;
 	struct list_head *ptr, *storage;
 
-	unregister_netevent_notifier(&priv->nfp_tun_neigh_nb);
+	unregister_netevent_notifier(&priv->tun.neigh_nb);
 
 	/* Free any memory that may be occupied by MAC list. */
-	list_for_each_safe(ptr, storage, &priv->nfp_mac_off_list) {
+	list_for_each_safe(ptr, storage, &priv->tun.mac_off_list) {
 		mac_entry = list_entry(ptr, struct nfp_tun_mac_offload_entry,
 				       list);
 		list_del(&mac_entry->list);
@@ -701,24 +701,24 @@ void nfp_tunnel_config_stop(struct nfp_app *app)
 	}
 
 	/* Free any memory that may be occupied by MAC index list. */
-	list_for_each_safe(ptr, storage, &priv->nfp_mac_index_list) {
+	list_for_each_safe(ptr, storage, &priv->tun.mac_index_list) {
 		mac_idx = list_entry(ptr, struct nfp_tun_mac_non_nfp_idx,
 				     list);
 		list_del(&mac_idx->list);
 		kfree(mac_idx);
 	}
 
-	ida_destroy(&priv->nfp_mac_off_ids);
+	ida_destroy(&priv->tun.mac_off_ids);
 
 	/* Free any memory that may be occupied by ipv4 list. */
-	list_for_each_safe(ptr, storage, &priv->nfp_ipv4_off_list) {
+	list_for_each_safe(ptr, storage, &priv->tun.ipv4_off_list) {
 		ip_entry = list_entry(ptr, struct nfp_ipv4_addr_entry, list);
 		list_del(&ip_entry->list);
 		kfree(ip_entry);
 	}
 
 	/* Free any memory that may be occupied by the route list. */
-	list_for_each_safe(ptr, storage, &priv->nfp_neigh_off_list) {
+	list_for_each_safe(ptr, storage, &priv->tun.neigh_off_list) {
 		route_entry = list_entry(ptr, struct nfp_ipv4_route_entry,
 					 list);
 		list_del(&route_entry->list);
-- 
2.19.1

