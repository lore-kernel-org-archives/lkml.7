Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81840C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CC72063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHMIyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:54:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56064 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfHMIyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:54:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E05411A0766;
        Tue, 13 Aug 2019 10:54:50 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D48591A075F;
        Tue, 13 Aug 2019 10:54:50 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 80F832060E;
        Tue, 13 Aug 2019 10:54:50 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 01/10] staging: fsl-dpaa2/ethsw: remove IGMP default address
Date:   Tue, 13 Aug 2019 11:54:30 +0300
Message-Id: <1565686479-32577-2-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not add an IGMP multicast address by default since we do not support
Rx/Tx ar the moment.

Reported-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Reported-by tag

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index aac98ece2335..8032314d5cae 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1506,7 +1506,6 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 
 static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
-	const char def_mcast[ETH_ALEN] = {0x01, 0x00, 0x5e, 0x00, 0x00, 0x01};
 	struct net_device *netdev = port_priv->netdev;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct dpsw_vlan_if_cfg vcfg;
@@ -1532,12 +1531,10 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 
 	err = dpsw_vlan_remove_if(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				  DEFAULT_VLAN_ID, &vcfg);
-	if (err) {
+	if (err)
 		netdev_err(netdev, "dpsw_vlan_remove_if err %d\n", err);
-		return err;
-	}
 
-	return ethsw_port_fdb_add_mc(port_priv, def_mcast);
+	return err;
 }
 
 static void ethsw_unregister_notifier(struct device *dev)
-- 
1.9.1

