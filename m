Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9646C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDF72070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfJHMLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:11:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40896 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbfJHMLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:11:33 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EDAC200301;
        Tue,  8 Oct 2019 14:11:31 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 129E22002DE;
        Tue,  8 Oct 2019 14:11:31 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BB8C8205DB;
        Tue,  8 Oct 2019 14:11:30 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     roy.pledge@nxp.com, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 17/20] dpaa_eth: remove netdev_err() for user errors
Date:   Tue,  8 Oct 2019 15:10:38 +0300
Message-Id: <1570536641-25104-18-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1570536641-25104-1-git-send-email-madalin.bucur@nxp.com>
References: <1570536641-25104-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User reports that an application making an (incorrect) call to
restart AN on a fixed link DPAA interface triggers an error in
the kernel log while the returned EINVAL should be enough.

Reported-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 1c689e11c61f..126c0f1d8442 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -81,7 +81,6 @@ static int dpaa_get_link_ksettings(struct net_device *net_dev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	if (!net_dev->phydev) {
-		netdev_dbg(net_dev, "phy device not initialized\n");
 		return 0;
 	}
 
@@ -96,7 +95,6 @@ static int dpaa_set_link_ksettings(struct net_device *net_dev,
 	int err;
 
 	if (!net_dev->phydev) {
-		netdev_err(net_dev, "phy device not initialized\n");
 		return -ENODEV;
 	}
 
@@ -143,7 +141,6 @@ static int dpaa_nway_reset(struct net_device *net_dev)
 	int err;
 
 	if (!net_dev->phydev) {
-		netdev_err(net_dev, "phy device not initialized\n");
 		return -ENODEV;
 	}
 
@@ -168,7 +165,6 @@ static void dpaa_get_pauseparam(struct net_device *net_dev,
 	mac_dev = priv->mac_dev;
 
 	if (!net_dev->phydev) {
-		netdev_err(net_dev, "phy device not initialized\n");
 		return;
 	}
 
-- 
2.1.0

