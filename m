Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9196CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A21C214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKKQvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:51:11 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44276 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfKKQvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:11 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C35A200637;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EF33200629;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A08E205FE;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/4] staging: dpaa2-ethsw: move port notifier per ethsw
Date:   Mon, 11 Nov 2019 18:50:55 +0200
Message-Id: <1573491058-24766-2-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
References: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a different net_device notifier block per ethsw instance.
When probing multiple dpaa2-ethsw instances, without this the register
will fail.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 13 ++++++-------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  2 ++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 14a9eebf687e..b25520173fec 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1174,10 +1174,6 @@ static int port_netdevice_event(struct notifier_block *unused,
 	return notifier_from_errno(err);
 }
 
-static struct notifier_block port_nb __read_mostly = {
-	.notifier_call = port_netdevice_event,
-};
-
 struct ethsw_switchdev_event_work {
 	struct work_struct work;
 	struct switchdev_notifier_fdb_info fdb_info;
@@ -1328,9 +1324,11 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 
 static int ethsw_register_notifier(struct device *dev)
 {
+	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	int err;
 
-	err = register_netdevice_notifier(&port_nb);
+	ethsw->port_nb.notifier_call = port_netdevice_event;
+	err = register_netdevice_notifier(&ethsw->port_nb);
 	if (err) {
 		dev_err(dev, "Failed to register netdev notifier\n");
 		return err;
@@ -1353,7 +1351,7 @@ static int ethsw_register_notifier(struct device *dev)
 err_switchdev_blocking_nb:
 	unregister_switchdev_notifier(&port_switchdev_nb);
 err_switchdev_nb:
-	unregister_netdevice_notifier(&port_nb);
+	unregister_netdevice_notifier(&ethsw->port_nb);
 	return err;
 }
 
@@ -1491,6 +1489,7 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 
 static void ethsw_unregister_notifier(struct device *dev)
 {
+	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	struct notifier_block *nb;
 	int err;
 
@@ -1505,7 +1504,7 @@ static void ethsw_unregister_notifier(struct device *dev)
 		dev_err(dev,
 			"Failed to unregister switchdev notifier (%d)\n", err);
 
-	err = unregister_netdevice_notifier(&port_nb);
+	err = unregister_netdevice_notifier(&ethsw->port_nb);
 	if (err)
 		dev_err(dev,
 			"Failed to unregister netdev notifier (%d)\n", err);
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index 3ea8a0ad8c10..39a3f542c8ee 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -66,6 +66,8 @@ struct ethsw_core {
 
 	u8				vlans[VLAN_VID_MASK + 1];
 	bool				learning;
+
+	struct notifier_block		port_nb;
 };
 
 #endif	/* __ETHSW_H */
-- 
1.9.1

