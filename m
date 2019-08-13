Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F336C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090FB20844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfHMMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:43:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51566 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbfHMMnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:43:15 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93384200796;
        Tue, 13 Aug 2019 14:43:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8656A20078C;
        Tue, 13 Aug 2019 14:43:12 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CC172060E;
        Tue, 13 Aug 2019 14:43:12 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 02/10] staging: fsl-dpaa2/ethsw: enable switch ports only on dev_open
Date:   Tue, 13 Aug 2019 15:42:59 +0300
Message-Id: <1565700187-16048-3-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565700187-16048-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565700187-16048-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At probe time, only the DPSW object should be enabled without the
associated ports, which will get enabled on dev_open. Remove the
ethsw_open() and ethsw_stop() functions and replace them only with
dpsw_enable()/_disable().

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Reported-by tag
Changes in v3:
 - none

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 59 ++++-----------------------------
 1 file changed, 6 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 8032314d5cae..302842c3bdfe 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1363,48 +1363,6 @@ static int ethsw_register_notifier(struct device *dev)
 	return err;
 }
 
-static int ethsw_open(struct ethsw_core *ethsw)
-{
-	struct ethsw_port_priv *port_priv = NULL;
-	int i, err;
-
-	err = dpsw_enable(ethsw->mc_io, 0, ethsw->dpsw_handle);
-	if (err) {
-		dev_err(ethsw->dev, "dpsw_enable err %d\n", err);
-		return err;
-	}
-
-	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
-		port_priv = ethsw->ports[i];
-		err = dev_open(port_priv->netdev, NULL);
-		if (err) {
-			netdev_err(port_priv->netdev, "dev_open err %d\n", err);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static int ethsw_stop(struct ethsw_core *ethsw)
-{
-	struct ethsw_port_priv *port_priv = NULL;
-	int i, err;
-
-	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
-		port_priv = ethsw->ports[i];
-		dev_close(port_priv->netdev);
-	}
-
-	err = dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
-	if (err) {
-		dev_err(ethsw->dev, "dpsw_disable err %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
 static int ethsw_init(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
@@ -1586,9 +1544,7 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 
 	destroy_workqueue(ethsw_owq);
 
-	rtnl_lock();
-	ethsw_stop(ethsw);
-	rtnl_unlock();
+	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		port_priv = ethsw->ports[i];
@@ -1708,12 +1664,11 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 			goto err_free_ports;
 	}
 
-	/* Switch starts up enabled */
-	rtnl_lock();
-	err = ethsw_open(ethsw);
-	rtnl_unlock();
-	if (err)
+	err = dpsw_enable(ethsw->mc_io, 0, ethsw->dpsw_handle);
+	if (err) {
+		dev_err(ethsw->dev, "dpsw_enable err %d\n", err);
 		goto err_free_ports;
+	}
 
 	/* Setup IRQs */
 	err = ethsw_setup_irqs(sw_dev);
@@ -1724,9 +1679,7 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 	return 0;
 
 err_stop:
-	rtnl_lock();
-	ethsw_stop(ethsw);
-	rtnl_unlock();
+	dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 
 err_free_ports:
 	/* Cleanup registered ports only */
-- 
1.9.1

