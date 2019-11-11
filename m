Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BAE206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKKQvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:51:13 -0500
Received: from inva021.nxp.com ([92.121.34.21]:44286 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfKKQvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:11 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AEF1E200638;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A1D05200629;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D070205FE;
        Mon, 11 Nov 2019 17:51:09 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/4] staging: dpaa2-ethsw: move port switchdev notifier per ethsw
Date:   Mon, 11 Nov 2019 18:50:56 +0200
Message-Id: <1573491058-24766-3-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
References: <1573491058-24766-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a different switchdev notifier block per ethsw instance.
When probing multiple dpaa2-ethsw instances, without this the register
will fail.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 11 ++++-------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b25520173fec..abbfcbf81241 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1314,10 +1314,6 @@ static int port_switchdev_blocking_event(struct notifier_block *unused,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block port_switchdev_nb = {
-	.notifier_call = port_switchdev_event,
-};
-
 static struct notifier_block port_switchdev_blocking_nb = {
 	.notifier_call = port_switchdev_blocking_event,
 };
@@ -1334,7 +1330,8 @@ static int ethsw_register_notifier(struct device *dev)
 		return err;
 	}
 
-	err = register_switchdev_notifier(&port_switchdev_nb);
+	ethsw->port_switchdev_nb.notifier_call = port_switchdev_event;
+	err = register_switchdev_notifier(&ethsw->port_switchdev_nb);
 	if (err) {
 		dev_err(dev, "Failed to register switchdev notifier\n");
 		goto err_switchdev_nb;
@@ -1349,7 +1346,7 @@ static int ethsw_register_notifier(struct device *dev)
 	return 0;
 
 err_switchdev_blocking_nb:
-	unregister_switchdev_notifier(&port_switchdev_nb);
+	unregister_switchdev_notifier(&ethsw->port_switchdev_nb);
 err_switchdev_nb:
 	unregister_netdevice_notifier(&ethsw->port_nb);
 	return err;
@@ -1499,7 +1496,7 @@ static void ethsw_unregister_notifier(struct device *dev)
 		dev_err(dev,
 			"Failed to unregister switchdev blocking notifier (%d)\n", err);
 
-	err = unregister_switchdev_notifier(&port_switchdev_nb);
+	err = unregister_switchdev_notifier(&ethsw->port_switchdev_nb);
 	if (err)
 		dev_err(dev,
 			"Failed to unregister switchdev notifier (%d)\n", err);
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index 39a3f542c8ee..e050589758b1 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -68,6 +68,7 @@ struct ethsw_core {
 	bool				learning;
 
 	struct notifier_block		port_nb;
+	struct notifier_block		port_switchdev_nb;
 };
 
 #endif	/* __ETHSW_H */
-- 
1.9.1

