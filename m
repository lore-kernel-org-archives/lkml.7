Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C80C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE7420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688992;
	bh=YelxrsqWMdfzuDRF+0doyhONL1x2aYxDmMOBnwUQUNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uyrUy0ICNlXrYPG+1kue3c8S/ctWr9ENyT24MqDwxoH4G4UEqV0dEg04GDE/lkl8Q
	 VFfQ67xxZ95YCljpYm3jr5gs7SKiRoeJ+o0h1DFREDIeaaWY2npilRVAiPQ5OLEx6+
	 M9zl7cXnoS2vymaF7Wh7FFjMAB56i5ciqT+KqmEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCDInK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:43:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfCDIaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8958920836;
        Mon,  4 Mar 2019 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688212;
        bh=YelxrsqWMdfzuDRF+0doyhONL1x2aYxDmMOBnwUQUNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhYr1r1FyvRJjlWTw4ib2P7Thmx2Mul0aIUODm5vIs8veQN2p8AO1wP69po9ZVDWJ
         06IxBS8m6LX+R9t8VqKgcfEBdr2NZiN3b7QcY3SckWwihNk3dQD65bpbWmUl4He0wQ
         D02oHbWEPXdpO/UXJN9NzrEA02Z16dH4Mdz+QrjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 51/78] hv_netvsc: Refactor assignments of struct netvsc_device_info
Date:   Mon,  4 Mar 2019 09:22:34 +0100
Message-Id: <20190304081627.771991013@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7c9f335a3ff20557a92584199f3d35c7e992bbe5 ]

These assignments occur in multiple places. The patch refactor them
to a function for simplicity. It also puts the struct to heap area
for future expension.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
[sl: fix up subject line]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 134 ++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 49 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 1c37a821895b7..bece935567c14 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -856,6 +856,36 @@ static void netvsc_get_channels(struct net_device *net,
 	}
 }
 
+/* Alloc struct netvsc_device_info, and initialize it from either existing
+ * struct netvsc_device, or from default values.
+ */
+static struct netvsc_device_info *netvsc_devinfo_get
+			(struct netvsc_device *nvdev)
+{
+	struct netvsc_device_info *dev_info;
+
+	dev_info = kzalloc(sizeof(*dev_info), GFP_ATOMIC);
+
+	if (!dev_info)
+		return NULL;
+
+	if (nvdev) {
+		dev_info->num_chn = nvdev->num_chn;
+		dev_info->send_sections = nvdev->send_section_cnt;
+		dev_info->send_section_size = nvdev->send_section_size;
+		dev_info->recv_sections = nvdev->recv_section_cnt;
+		dev_info->recv_section_size = nvdev->recv_section_size;
+	} else {
+		dev_info->num_chn = VRSS_CHANNEL_DEFAULT;
+		dev_info->send_sections = NETVSC_DEFAULT_TX;
+		dev_info->send_section_size = NETVSC_SEND_SECTION_SIZE;
+		dev_info->recv_sections = NETVSC_DEFAULT_RX;
+		dev_info->recv_section_size = NETVSC_RECV_SECTION_SIZE;
+	}
+
+	return dev_info;
+}
+
 static int netvsc_detach(struct net_device *ndev,
 			 struct netvsc_device *nvdev)
 {
@@ -941,7 +971,7 @@ static int netvsc_set_channels(struct net_device *net,
 	struct net_device_context *net_device_ctx = netdev_priv(net);
 	struct netvsc_device *nvdev = rtnl_dereference(net_device_ctx->nvdev);
 	unsigned int orig, count = channels->combined_count;
-	struct netvsc_device_info device_info;
+	struct netvsc_device_info *device_info;
 	int ret;
 
 	/* We do not support separate count for rx, tx, or other */
@@ -960,24 +990,26 @@ static int netvsc_set_channels(struct net_device *net,
 
 	orig = nvdev->num_chn;
 
-	memset(&device_info, 0, sizeof(device_info));
-	device_info.num_chn = count;
-	device_info.send_sections = nvdev->send_section_cnt;
-	device_info.send_section_size = nvdev->send_section_size;
-	device_info.recv_sections = nvdev->recv_section_cnt;
-	device_info.recv_section_size = nvdev->recv_section_size;
+	device_info = netvsc_devinfo_get(nvdev);
+
+	if (!device_info)
+		return -ENOMEM;
+
+	device_info->num_chn = count;
 
 	ret = netvsc_detach(net, nvdev);
 	if (ret)
-		return ret;
+		goto out;
 
-	ret = netvsc_attach(net, &device_info);
+	ret = netvsc_attach(net, device_info);
 	if (ret) {
-		device_info.num_chn = orig;
-		if (netvsc_attach(net, &device_info))
+		device_info->num_chn = orig;
+		if (netvsc_attach(net, device_info))
 			netdev_err(net, "restoring channel setting failed\n");
 	}
 
+out:
+	kfree(device_info);
 	return ret;
 }
 
@@ -1044,48 +1076,45 @@ static int netvsc_change_mtu(struct net_device *ndev, int mtu)
 	struct net_device *vf_netdev = rtnl_dereference(ndevctx->vf_netdev);
 	struct netvsc_device *nvdev = rtnl_dereference(ndevctx->nvdev);
 	int orig_mtu = ndev->mtu;
-	struct netvsc_device_info device_info;
+	struct netvsc_device_info *device_info;
 	int ret = 0;
 
 	if (!nvdev || nvdev->destroy)
 		return -ENODEV;
 
+	device_info = netvsc_devinfo_get(nvdev);
+
+	if (!device_info)
+		return -ENOMEM;
+
 	/* Change MTU of underlying VF netdev first. */
 	if (vf_netdev) {
 		ret = dev_set_mtu(vf_netdev, mtu);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	memset(&device_info, 0, sizeof(device_info));
-	device_info.num_chn = nvdev->num_chn;
-	device_info.send_sections = nvdev->send_section_cnt;
-	device_info.send_section_size = nvdev->send_section_size;
-	device_info.recv_sections = nvdev->recv_section_cnt;
-	device_info.recv_section_size = nvdev->recv_section_size;
-
 	ret = netvsc_detach(ndev, nvdev);
 	if (ret)
 		goto rollback_vf;
 
 	ndev->mtu = mtu;
 
-	ret = netvsc_attach(ndev, &device_info);
-	if (ret)
-		goto rollback;
-
-	return 0;
+	ret = netvsc_attach(ndev, device_info);
+	if (!ret)
+		goto out;
 
-rollback:
 	/* Attempt rollback to original MTU */
 	ndev->mtu = orig_mtu;
 
-	if (netvsc_attach(ndev, &device_info))
+	if (netvsc_attach(ndev, device_info))
 		netdev_err(ndev, "restoring mtu failed\n");
 rollback_vf:
 	if (vf_netdev)
 		dev_set_mtu(vf_netdev, orig_mtu);
 
+out:
+	kfree(device_info);
 	return ret;
 }
 
@@ -1690,7 +1719,7 @@ static int netvsc_set_ringparam(struct net_device *ndev,
 {
 	struct net_device_context *ndevctx = netdev_priv(ndev);
 	struct netvsc_device *nvdev = rtnl_dereference(ndevctx->nvdev);
-	struct netvsc_device_info device_info;
+	struct netvsc_device_info *device_info;
 	struct ethtool_ringparam orig;
 	u32 new_tx, new_rx;
 	int ret = 0;
@@ -1710,26 +1739,29 @@ static int netvsc_set_ringparam(struct net_device *ndev,
 	    new_rx == orig.rx_pending)
 		return 0;	 /* no change */
 
-	memset(&device_info, 0, sizeof(device_info));
-	device_info.num_chn = nvdev->num_chn;
-	device_info.send_sections = new_tx;
-	device_info.send_section_size = nvdev->send_section_size;
-	device_info.recv_sections = new_rx;
-	device_info.recv_section_size = nvdev->recv_section_size;
+	device_info = netvsc_devinfo_get(nvdev);
+
+	if (!device_info)
+		return -ENOMEM;
+
+	device_info->send_sections = new_tx;
+	device_info->recv_sections = new_rx;
 
 	ret = netvsc_detach(ndev, nvdev);
 	if (ret)
-		return ret;
+		goto out;
 
-	ret = netvsc_attach(ndev, &device_info);
+	ret = netvsc_attach(ndev, device_info);
 	if (ret) {
-		device_info.send_sections = orig.tx_pending;
-		device_info.recv_sections = orig.rx_pending;
+		device_info->send_sections = orig.tx_pending;
+		device_info->recv_sections = orig.rx_pending;
 
-		if (netvsc_attach(ndev, &device_info))
+		if (netvsc_attach(ndev, device_info))
 			netdev_err(ndev, "restoring ringparam failed");
 	}
 
+out:
+	kfree(device_info);
 	return ret;
 }
 
@@ -2158,7 +2190,7 @@ static int netvsc_probe(struct hv_device *dev,
 {
 	struct net_device *net = NULL;
 	struct net_device_context *net_device_ctx;
-	struct netvsc_device_info device_info;
+	struct netvsc_device_info *device_info = NULL;
 	struct netvsc_device *nvdev;
 	int ret = -ENOMEM;
 
@@ -2205,21 +2237,21 @@ static int netvsc_probe(struct hv_device *dev,
 	netif_set_real_num_rx_queues(net, 1);
 
 	/* Notify the netvsc driver of the new device */
-	memset(&device_info, 0, sizeof(device_info));
-	device_info.num_chn = VRSS_CHANNEL_DEFAULT;
-	device_info.send_sections = NETVSC_DEFAULT_TX;
-	device_info.send_section_size = NETVSC_SEND_SECTION_SIZE;
-	device_info.recv_sections = NETVSC_DEFAULT_RX;
-	device_info.recv_section_size = NETVSC_RECV_SECTION_SIZE;
-
-	nvdev = rndis_filter_device_add(dev, &device_info);
+	device_info = netvsc_devinfo_get(NULL);
+
+	if (!device_info) {
+		ret = -ENOMEM;
+		goto devinfo_failed;
+	}
+
+	nvdev = rndis_filter_device_add(dev, device_info);
 	if (IS_ERR(nvdev)) {
 		ret = PTR_ERR(nvdev);
 		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
 		goto rndis_failed;
 	}
 
-	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
+	memcpy(net->dev_addr, device_info->mac_adr, ETH_ALEN);
 
 	/* We must get rtnl lock before scheduling nvdev->subchan_work,
 	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
@@ -2257,12 +2289,16 @@ static int netvsc_probe(struct hv_device *dev,
 
 	list_add(&net_device_ctx->list, &netvsc_dev_list);
 	rtnl_unlock();
+
+	kfree(device_info);
 	return 0;
 
 register_failed:
 	rtnl_unlock();
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
+	kfree(device_info);
+devinfo_failed:
 	free_percpu(net_device_ctx->vf_stats);
 no_stats:
 	hv_set_drvdata(dev, NULL);
-- 
2.19.1



