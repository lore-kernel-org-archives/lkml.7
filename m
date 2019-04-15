Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44583C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D9D20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355388;
	bh=c7Qy36+HoEXOqmBWOheC0HGX1mBvpmKCCeGXqE3wN6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/keGNSrZc20F4birD51HpEYjwgVGl0WC/DrAKpzA1hutSPNd/qrfvQtpu6V0lLr7
	 YZ+vDSbsJxMCGdgO8jvKph+DrrYhPJDrjTw/AUnTOFwwAAZZJV0/UiCxiajpPZe+HL
	 R1XbIhdPW8CXfaFz/MZcrR6g7+gL2bqYhj6RK8Nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfDOTJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730776AbfDOTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A2B20651;
        Mon, 15 Apr 2019 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355382;
        bh=c7Qy36+HoEXOqmBWOheC0HGX1mBvpmKCCeGXqE3wN6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYXw1DYQrjI7oIJQdWI0RPGpEAki0sSaMx6s7GMh0bD8vAPV6tPiEOEc60xUWnx5s
         j2PSo37KCeO/yquYu22et7qU/37z4l8jG6xSsnA2/ObsSMiKuaUi50TVy8rk/pYKAf
         NPQA7f2U7uanaIKVNpJCSB3WPWa6HDiRumKaT4DM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 006/117] hv_netvsc: Fix unwanted wakeup after tx_disable
Date:   Mon, 15 Apr 2019 20:59:36 +0200
Message-Id: <20190415183745.213851693@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1b704c4a1ba95574832e730f23817b651db2aa59 ]

After queue stopped, the wakeup mechanism may wake it up again
when ring buffer usage is lower than a threshold. This may cause
send path panic on NULL pointer when we stopped all tx queues in
netvsc_detach and start removing the netvsc device.

This patch fix it by adding a tx_disable flag to prevent unwanted
queue wakeup.

Fixes: 7b2ee50c0cd5 ("hv_netvsc: common detach logic")
Reported-by: Mohammed Gamal <mgamal@redhat.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/hyperv_net.h |  1 +
 drivers/net/hyperv/netvsc.c     |  6 ++++--
 drivers/net/hyperv/netvsc_drv.c | 32 ++++++++++++++++++++++++++------
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index e859ae2e42d5..49f41b64077b 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -987,6 +987,7 @@ struct netvsc_device {
 
 	wait_queue_head_t wait_drain;
 	bool destroy;
+	bool tx_disable; /* if true, do not wake up queue again */
 
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 813d195bbd57..e0dce373cdd9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -110,6 +110,7 @@ static struct netvsc_device *alloc_net_device(void)
 
 	init_waitqueue_head(&net_device->wait_drain);
 	net_device->destroy = false;
+	net_device->tx_disable = false;
 
 	net_device->max_pkt = RNDIS_MAX_PKT_DEFAULT;
 	net_device->pkt_align = RNDIS_PKT_ALIGN_DEFAULT;
@@ -719,7 +720,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
 	} else {
 		struct netdev_queue *txq = netdev_get_tx_queue(ndev, q_idx);
 
-		if (netif_tx_queue_stopped(txq) &&
+		if (netif_tx_queue_stopped(txq) && !net_device->tx_disable &&
 		    (hv_get_avail_to_write_percent(&channel->outbound) >
 		     RING_AVAIL_PERCENT_HIWATER || queue_sends < 1)) {
 			netif_tx_wake_queue(txq);
@@ -874,7 +875,8 @@ static inline int netvsc_send_pkt(
 	} else if (ret == -EAGAIN) {
 		netif_tx_stop_queue(txq);
 		ndev_ctx->eth_stats.stop_queue++;
-		if (atomic_read(&nvchan->queue_sends) < 1) {
+		if (atomic_read(&nvchan->queue_sends) < 1 &&
+		    !net_device->tx_disable) {
 			netif_tx_wake_queue(txq);
 			ndev_ctx->eth_stats.wake_queue++;
 			ret = -ENOSPC;
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index cf4897043e83..b20fb0fb595b 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -109,6 +109,15 @@ static void netvsc_set_rx_mode(struct net_device *net)
 	rcu_read_unlock();
 }
 
+static void netvsc_tx_enable(struct netvsc_device *nvscdev,
+			     struct net_device *ndev)
+{
+	nvscdev->tx_disable = false;
+	virt_wmb(); /* ensure queue wake up mechanism is on */
+
+	netif_tx_wake_all_queues(ndev);
+}
+
 static int netvsc_open(struct net_device *net)
 {
 	struct net_device_context *ndev_ctx = netdev_priv(net);
@@ -129,7 +138,7 @@ static int netvsc_open(struct net_device *net)
 	rdev = nvdev->extension;
 	if (!rdev->link_state) {
 		netif_carrier_on(net);
-		netif_tx_wake_all_queues(net);
+		netvsc_tx_enable(nvdev, net);
 	}
 
 	if (vf_netdev) {
@@ -184,6 +193,17 @@ static int netvsc_wait_until_empty(struct netvsc_device *nvdev)
 	}
 }
 
+static void netvsc_tx_disable(struct netvsc_device *nvscdev,
+			      struct net_device *ndev)
+{
+	if (nvscdev) {
+		nvscdev->tx_disable = true;
+		virt_wmb(); /* ensure txq will not wake up after stop */
+	}
+
+	netif_tx_disable(ndev);
+}
+
 static int netvsc_close(struct net_device *net)
 {
 	struct net_device_context *net_device_ctx = netdev_priv(net);
@@ -192,7 +212,7 @@ static int netvsc_close(struct net_device *net)
 	struct netvsc_device *nvdev = rtnl_dereference(net_device_ctx->nvdev);
 	int ret;
 
-	netif_tx_disable(net);
+	netvsc_tx_disable(nvdev, net);
 
 	/* No need to close rndis filter if it is removed already */
 	if (!nvdev)
@@ -920,7 +940,7 @@ static int netvsc_detach(struct net_device *ndev,
 
 	/* If device was up (receiving) then shutdown */
 	if (netif_running(ndev)) {
-		netif_tx_disable(ndev);
+		netvsc_tx_disable(nvdev, ndev);
 
 		ret = rndis_filter_close(nvdev);
 		if (ret) {
@@ -1908,7 +1928,7 @@ static void netvsc_link_change(struct work_struct *w)
 		if (rdev->link_state) {
 			rdev->link_state = false;
 			netif_carrier_on(net);
-			netif_tx_wake_all_queues(net);
+			netvsc_tx_enable(net_device, net);
 		} else {
 			notify = true;
 		}
@@ -1918,7 +1938,7 @@ static void netvsc_link_change(struct work_struct *w)
 		if (!rdev->link_state) {
 			rdev->link_state = true;
 			netif_carrier_off(net);
-			netif_tx_stop_all_queues(net);
+			netvsc_tx_disable(net_device, net);
 		}
 		kfree(event);
 		break;
@@ -1927,7 +1947,7 @@ static void netvsc_link_change(struct work_struct *w)
 		if (!rdev->link_state) {
 			rdev->link_state = true;
 			netif_carrier_off(net);
-			netif_tx_stop_all_queues(net);
+			netvsc_tx_disable(net_device, net);
 			event->event = RNDIS_STATUS_MEDIA_CONNECT;
 			spin_lock_irqsave(&ndev_ctx->lock, flags);
 			list_add(&event->list, &ndev_ctx->reconfig_events);
-- 
2.19.1



