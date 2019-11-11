Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35366C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103A0206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfKKQvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:51:17 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44298 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKKQvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:12 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3AF2620063D;
        Mon, 11 Nov 2019 17:51:10 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D9E020062E;
        Mon, 11 Nov 2019 17:51:10 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EAEA0205FE;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/4] staging: dpaa2-ethsw: ordered workqueue should be per ethsw
Date:   Mon, 11 Nov 2019 18:50:58 +0200
Message-Id: <1573491058-24766-5-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
References: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a different ordered workqueue per dpaa2-ethsw instance.  Without
this change, we overwrite the global queue and leak memory when probing
multiple instances of the driver.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 17 +++++++++--------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  1 +
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 37ee9b0aa326..39c0fe347188 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -18,8 +18,6 @@
 
 #include "ethsw.h"
 
-static struct workqueue_struct *ethsw_owq;
-
 /* Minimal supported DPSW version */
 #define DPSW_MIN_VER_MAJOR		8
 #define DPSW_MIN_VER_MINOR		1
@@ -1229,8 +1227,10 @@ static int port_switchdev_event(struct notifier_block *unused,
 				unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
 	struct ethsw_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 
 	if (!ethsw_port_dev_check(dev))
 		return NOTIFY_DONE;
@@ -1266,7 +1266,7 @@ static int port_switchdev_event(struct notifier_block *unused,
 		return NOTIFY_DONE;
 	}
 
-	queue_work(ethsw_owq, &switchdev_work->work);
+	queue_work(ethsw->workqueue, &switchdev_work->work);
 
 	return NOTIFY_DONE;
 
@@ -1427,9 +1427,10 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 		}
 	}
 
-	ethsw_owq = alloc_ordered_workqueue("%s_ordered", WQ_MEM_RECLAIM,
-					    "ethsw");
-	if (!ethsw_owq) {
+	ethsw->workqueue = alloc_ordered_workqueue("%s_%d_ordered",
+						   WQ_MEM_RECLAIM, "ethsw",
+						   ethsw->sw_attr.id);
+	if (!ethsw->workqueue) {
 		err = -ENOMEM;
 		goto err_close;
 	}
@@ -1441,7 +1442,7 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 	return 0;
 
 err_destroy_ordered_workqueue:
-	destroy_workqueue(ethsw_owq);
+	destroy_workqueue(ethsw->workqueue);
 
 err_close:
 	dpsw_close(ethsw->mc_io, 0, ethsw->dpsw_handle);
@@ -1529,7 +1530,7 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 
 	ethsw_teardown_irqs(sw_dev);
 
-	destroy_workqueue(ethsw_owq);
+	destroy_workqueue(ethsw->workqueue);
 
 	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index db7eef134230..a0244f7d5003 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -70,6 +70,7 @@ struct ethsw_core {
 	struct notifier_block		port_nb;
 	struct notifier_block		port_switchdev_nb;
 	struct notifier_block		port_switchdevb_nb;
+	struct workqueue_struct		*workqueue;
 };
 
 #endif	/* __ETHSW_H */
-- 
1.9.1

