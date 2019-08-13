Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C0C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D2D20842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfHMIy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:54:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56152 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfHMIyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:54:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 60FC41A0766;
        Tue, 13 Aug 2019 10:54:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 550041A075F;
        Tue, 13 Aug 2019 10:54:54 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id F30792060E;
        Tue, 13 Aug 2019 10:54:53 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 10/10] staging: fsl-dpaa2/ethsw: do not force user to bring interface down
Date:   Tue, 13 Aug 2019 11:54:39 +0300
Message-Id: <1565686479-32577-11-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link settings can be changed only when the interface is down. Disable
and re-enable the interface, if necessary, behind the scenes so that we do
not force users to an if down/up sequence.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Reported-by tag

 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 32 ++++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index 0f9f8345e534..99d658fefa14 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -88,16 +88,21 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 			 const struct ethtool_link_ksettings *link_ksettings)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct dpsw_link_cfg cfg = {0};
-	int err = 0;
-
-	/* Due to a temporary MC limitation, the DPSW port must be down
-	 * in order to be able to change link settings. Taking steps to let
-	 * the user know that.
-	 */
-	if (netif_running(netdev)) {
-		netdev_info(netdev, "Sorry, interface must be brought down first.\n");
-		return -EACCES;
+	bool if_running;
+	int err = 0, ret;
+
+	/* Interface needs to be down to change link settings */
+	if_running = netif_running(netdev);
+	if (if_running) {
+		err = dpsw_if_disable(ethsw->mc_io, 0,
+				      ethsw->dpsw_handle,
+				      port_priv->idx);
+		if (err) {
+			netdev_err(netdev, "dpsw_if_disable err %d\n", err);
+			return err;
+		}
 	}
 
 	cfg.rate = link_ksettings->base.speed;
@@ -115,6 +120,15 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 				   port_priv->idx,
 				   &cfg);
 
+	if (if_running) {
+		ret = dpsw_if_enable(ethsw->mc_io, 0,
+				     ethsw->dpsw_handle,
+				     port_priv->idx);
+		if (ret) {
+			return ret;
+			netdev_err(netdev, "dpsw_if_enable err %d\n", ret);
+		}
+	}
 	return err;
 }
 
-- 
1.9.1

