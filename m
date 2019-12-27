Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC0AC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3CC20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 01:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4fpulVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfL0BmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 20:42:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35768 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfL0BmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:42:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so7230541wmb.0;
        Thu, 26 Dec 2019 17:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t3dw4nJOZnYE2VNxhBHq7qx6fpZ9kBoAZtFQwOujWiQ=;
        b=s4fpulVTKlPezJe1ZKFE/yuUjx/QRdHiOuDUrrqM0Nll6bjypAqFQpQI7+ziUQiDKs
         CSrB7AbgW5/nIba5M6wfp9YKomRhsLpcAfd8Jr1htmj07UiwduDvl13oQGwujxw10CzS
         sM381SyPS9WBFAsUf9Zi1M0rWwMpdxjZhj3PVt1kjgkVGXGUF1du0OpOWqWeE13HA4M4
         yQ6CS+7jPU2JwcpxGXSIFECrXLysJpxpkGFugzrzr81HS6QSIPhHDEqhFvHd035DeR4S
         ue8t0k7D27FVhOhG+syFp0LfL1TerURCbx84EADRSZM35J2BOCQmPGu8DY9CPnvVO2u9
         Tfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t3dw4nJOZnYE2VNxhBHq7qx6fpZ9kBoAZtFQwOujWiQ=;
        b=EIpKnYlfAs62rszri1ROD6bKxr3t0Da7x+VU9vJZx+05o7kOdDm5Vfw7bmQ1fVEX68
         7mIe+b1AqasPoS6IDKGEfTjXRjbLL8XNYawihLsaXKp1HPgT0SJR3CSWegH8KKxpUbGM
         9kAaz9XBWzh9YBVFoL9etW67/TaaJ8ub7492J/ZErIanGaA2NLoZqCm6VuSgerOl/TBy
         LChxTCUMd2506l2Oi5p16QSryoYiABuWEgf+iCwYrf3Y6VrqODvCZ9Nlod/HNt1fM9QU
         B2DQUjr/uVNrxwxsMDlvsBRFQ4gEOpwwnQRljk4IlFUJ6HJYB/duOWhnm1WLTCwA6Jr1
         sw+A==
X-Gm-Message-State: APjAAAXfVShNSa7U/wcuYRAhWxwJGm7TGKOVWPglqfd79OrgOeFrostt
        tXEsVmvPTrEPIrvhGOsa2uY=
X-Google-Smtp-Source: APXvYqxf28R55vxOUXoIHUm0/dFI2QLdCrQhHAs52SMMSz5YMWsDSSZH0sY6kNi/8wdwhouXjjJtMA==
X-Received: by 2002:a1c:66d6:: with SMTP id a205mr16602351wmc.171.1577410939283;
        Thu, 26 Dec 2019 17:42:19 -0800 (PST)
Received: from localhost.localdomain ([188.25.254.226])
        by smtp.gmail.com with ESMTPSA id q11sm32622130wrp.24.2019.12.26.17.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 17:42:18 -0800 (PST)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 2/2] net: dsa: Create a kernel thread for each port's deferred xmit work
Date:   Fri, 27 Dec 2019 03:42:08 +0200
Message-Id: <20191227014208.7189-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191227014208.7189-1-olteanv@gmail.com>
References: <20191227014208.7189-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because this callback can be used on certain switches (at the moment
only sja1105) to do TX timstamping, this should have been a kernel
thread from the get-go.

PTP is a time-critical protocol and requires the ability to control the
scheduling priority with tools such as chrt, as opposed to just
executing the work in the generic workqueue.

If the user switch ports are named swp0, swp1, swp2, the kernel threads
will be named dsa_swp0_xmit, dsa_swp1_xmit, dsa_swp2_xmit.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 include/net/dsa.h |  3 ++-
 net/dsa/slave.c   | 43 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 5d510a4da5d0..8460eae69dd9 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -189,7 +189,8 @@ struct dsa_port {
 	struct phylink		*pl;
 	struct phylink_config	pl_config;
 
-	struct work_struct	xmit_work;
+	struct kthread_worker	*xmit_worker;
+	struct kthread_work	xmit_work;
 	struct sk_buff_head	xmit_queue;
 
 	struct list_head list;
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 9f7e47dcdc20..c7e8a29e1e86 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -115,9 +115,12 @@ static int dsa_slave_close(struct net_device *dev)
 {
 	struct net_device *master = dsa_slave_to_master(dev);
 	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
 
-	cancel_work_sync(&dp->xmit_work);
-	skb_queue_purge(&dp->xmit_queue);
+	if (ds->ops->port_deferred_xmit) {
+		kthread_cancel_work_sync(&dp->xmit_work);
+		skb_queue_purge(&dp->xmit_queue);
+	}
 
 	phylink_stop(dp->pl);
 
@@ -545,13 +548,13 @@ void *dsa_defer_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * won't really free the packet.
 	 */
 	skb_queue_tail(&dp->xmit_queue, skb_get(skb));
-	schedule_work(&dp->xmit_work);
+	kthread_queue_work(dp->xmit_worker, &dp->xmit_work);
 
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(dsa_defer_xmit);
 
-static void dsa_port_xmit_work(struct work_struct *work)
+static void dsa_port_xmit_work(struct kthread_work *work)
 {
 	struct dsa_port *dp = container_of(work, struct dsa_port, xmit_work);
 	struct dsa_switch *ds = dp->ds;
@@ -1363,12 +1366,15 @@ static int dsa_slave_phy_setup(struct net_device *slave_dev)
 int dsa_slave_suspend(struct net_device *slave_dev)
 {
 	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
+	struct dsa_switch *ds = dp->ds;
 
 	if (!netif_running(slave_dev))
 		return 0;
 
-	cancel_work_sync(&dp->xmit_work);
-	skb_queue_purge(&dp->xmit_queue);
+	if (ds->ops->port_deferred_xmit) {
+		kthread_cancel_work_sync(&dp->xmit_work);
+		skb_queue_purge(&dp->xmit_queue);
+	}
 
 	netif_device_detach(slave_dev);
 
@@ -1455,17 +1461,29 @@ int dsa_slave_create(struct dsa_port *port)
 	}
 	p->dp = port;
 	INIT_LIST_HEAD(&p->mall_tc_list);
-	INIT_WORK(&port->xmit_work, dsa_port_xmit_work);
-	skb_queue_head_init(&port->xmit_queue);
 	p->xmit = cpu_dp->tag_ops->xmit;
 	port->slave = slave_dev;
 
+	if (ds->ops->port_deferred_xmit) {
+		kthread_init_work(&port->xmit_work, dsa_port_xmit_work);
+		port->xmit_worker = kthread_create_worker(0, "dsa_%s_xmit",
+							  slave_dev->name);
+		if (IS_ERR(port->xmit_worker)) {
+			ret = PTR_ERR(port->xmit_worker);
+			netdev_err(master,
+				   "failed to create deferred xmit thread: %d\n",
+				   ret);
+			goto out_free;
+		}
+		skb_queue_head_init(&port->xmit_queue);
+	}
+
 	netif_carrier_off(slave_dev);
 
 	ret = dsa_slave_phy_setup(slave_dev);
 	if (ret) {
 		netdev_err(master, "error %d setting up slave phy\n", ret);
-		goto out_free;
+		goto out_destroy;
 	}
 
 	dsa_slave_notify(slave_dev, DSA_PORT_REGISTER);
@@ -1484,6 +1502,9 @@ int dsa_slave_create(struct dsa_port *port)
 	phylink_disconnect_phy(p->dp->pl);
 	rtnl_unlock();
 	phylink_destroy(p->dp->pl);
+out_destroy:
+	if (ds->ops->port_deferred_xmit)
+		kthread_destroy_worker(port->xmit_worker);
 out_free:
 	free_percpu(p->stats64);
 	free_netdev(slave_dev);
@@ -1495,6 +1516,10 @@ void dsa_slave_destroy(struct net_device *slave_dev)
 {
 	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
 	struct dsa_slave_priv *p = netdev_priv(slave_dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->port_deferred_xmit)
+		kthread_destroy_worker(dp->xmit_worker);
 
 	netif_carrier_off(slave_dev);
 	rtnl_lock();
-- 
2.17.1

