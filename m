Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62FF20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfHLJkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:40:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49666 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfHLJjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:39:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31C4B1A0658;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25EBD1A011B;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D9803205ED;
        Mon, 12 Aug 2019 11:39:33 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 04/10] staging: fsl-dpaa2/ethsw: remove debug message
Date:   Mon, 12 Aug 2019 12:39:12 +0300
Message-Id: <1565602758-14434-5-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ethtool will be loud enough if the .set_link_ksettings() callback
fails, remove the debug messages which do not add additional
information.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index 95e9f1096999..12e33a3a1bf1 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -91,8 +91,6 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 	struct dpsw_link_cfg cfg = {0};
 	int err = 0;
 
-	netdev_dbg(netdev, "Setting link parameters...");
-
 	/* Due to a temporary MC limitation, the DPSW port must be down
 	 * in order to be able to change link settings. Taking steps to let
 	 * the user know that.
@@ -116,11 +114,6 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 				   port_priv->ethsw_data->dpsw_handle,
 				   port_priv->idx,
 				   &cfg);
-	if (err)
-		/* ethtool will be loud enough if we return an error; no point
-		 * in putting our own error message on the console by default
-		 */
-		netdev_dbg(netdev, "ERROR %d setting link cfg", err);
 
 	return err;
 }
-- 
1.9.1

