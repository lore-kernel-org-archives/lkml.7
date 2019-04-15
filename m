Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B583EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7784220880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354989;
	bh=Neicr4jzu4/wVe1gtmAsi1K8Q5U6p3on/Zrf3CdEg8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJutEqPMvtfb50u+25HlSnyRNwpy8XUyjCMcaWLY35csCi4oR1CyShu72/wHL7ELR
	 fTGar9T/r48ImAvC+kOXorvVRDPEmVkOBYM8l0L0i5mpF/EW9RaYdAXKwpUKuEE9hX
	 9QVWpSZQmiBHkIOH0dhbxHBdQLQkDxHoDYGacLfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfDOTDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfDOTDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E597D20880;
        Mon, 15 Apr 2019 19:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354982;
        bh=Neicr4jzu4/wVe1gtmAsi1K8Q5U6p3on/Zrf3CdEg8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irl2SJjmyrmEae0DI4IckLouMU4VIoeEImB70drxf80UGxWigWg47SN+e1cWDl1Lx
         w28RsQ06sOEeVySTYHZGbH4mbbZW7DnlpjLaDOACXI0MLGDxxnvGTvMIDxYBijIouK
         /Zzj5T11/yo+ZNkrbOo0yAIuL+0Bhq4fwZOrrR9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohammed Gamal <mgamal@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 38/69] hv_netvsc: Fix unwanted wakeup after tx_disable
Date:   Mon, 15 Apr 2019 20:58:56 +0200
Message-Id: <20190415183732.366513910@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h |    1 +
 drivers/net/hyperv/netvsc.c     |    6 ++++--
 drivers/net/hyperv/netvsc_drv.c |   32 ++++++++++++++++++++++++++------
 3 files changed, 31 insertions(+), 8 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -779,6 +779,7 @@ struct netvsc_device {
 
 	wait_queue_head_t wait_drain;
 	bool destroy;
+	bool tx_disable; /* if true, do not wake up queue again */
 
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -107,6 +107,7 @@ static struct netvsc_device *alloc_net_d
 
 	init_waitqueue_head(&net_device->wait_drain);
 	net_device->destroy = false;
+	net_device->tx_disable = false;
 	atomic_set(&net_device->open_cnt, 0);
 	net_device->max_pkt = RNDIS_MAX_PKT_DEFAULT;
 	net_device->pkt_align = RNDIS_PKT_ALIGN_DEFAULT;
@@ -712,7 +713,7 @@ static void netvsc_send_tx_complete(stru
 	} else {
 		struct netdev_queue *txq = netdev_get_tx_queue(ndev, q_idx);
 
-		if (netif_tx_queue_stopped(txq) &&
+		if (netif_tx_queue_stopped(txq) && !net_device->tx_disable &&
 		    (hv_ringbuf_avail_percent(&channel->outbound) > RING_AVAIL_PERCENT_HIWATER ||
 		     queue_sends < 1)) {
 			netif_tx_wake_queue(txq);
@@ -865,7 +866,8 @@ static inline int netvsc_send_pkt(
 			netif_tx_stop_queue(txq);
 	} else if (ret == -EAGAIN) {
 		netif_tx_stop_queue(txq);
-		if (atomic_read(&nvchan->queue_sends) < 1) {
+		if (atomic_read(&nvchan->queue_sends) < 1 &&
+		    !net_device->tx_disable) {
 			netif_tx_wake_queue(txq);
 			ret = -ENOSPC;
 		}
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -108,6 +108,15 @@ static void netvsc_set_rx_mode(struct ne
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
@@ -128,7 +137,7 @@ static int netvsc_open(struct net_device
 	rdev = nvdev->extension;
 	if (!rdev->link_state) {
 		netif_carrier_on(net);
-		netif_tx_wake_all_queues(net);
+		netvsc_tx_enable(nvdev, net);
 	}
 
 	if (vf_netdev) {
@@ -183,6 +192,17 @@ static int netvsc_wait_until_empty(struc
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
@@ -191,7 +211,7 @@ static int netvsc_close(struct net_devic
 	struct netvsc_device *nvdev = rtnl_dereference(net_device_ctx->nvdev);
 	int ret;
 
-	netif_tx_disable(net);
+	netvsc_tx_disable(nvdev, net);
 
 	/* No need to close rndis filter if it is removed already */
 	if (!nvdev)
@@ -893,7 +913,7 @@ static int netvsc_detach(struct net_devi
 
 	/* If device was up (receiving) then shutdown */
 	if (netif_running(ndev)) {
-		netif_tx_disable(ndev);
+		netvsc_tx_disable(nvdev, ndev);
 
 		ret = rndis_filter_close(nvdev);
 		if (ret) {
@@ -1720,7 +1740,7 @@ static void netvsc_link_change(struct wo
 		if (rdev->link_state) {
 			rdev->link_state = false;
 			netif_carrier_on(net);
-			netif_tx_wake_all_queues(net);
+			netvsc_tx_enable(net_device, net);
 		} else {
 			notify = true;
 		}
@@ -1730,7 +1750,7 @@ static void netvsc_link_change(struct wo
 		if (!rdev->link_state) {
 			rdev->link_state = true;
 			netif_carrier_off(net);
-			netif_tx_stop_all_queues(net);
+			netvsc_tx_disable(net_device, net);
 		}
 		kfree(event);
 		break;
@@ -1739,7 +1759,7 @@ static void netvsc_link_change(struct wo
 		if (!rdev->link_state) {
 			rdev->link_state = true;
 			netif_carrier_off(net);
-			netif_tx_stop_all_queues(net);
+			netvsc_tx_disable(net_device, net);
 			event->event = RNDIS_STATUS_MEDIA_CONNECT;
 			spin_lock_irqsave(&ndev_ctx->lock, flags);
 			list_add(&event->list, &ndev_ctx->reconfig_events);


