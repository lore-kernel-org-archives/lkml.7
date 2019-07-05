Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA8DC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B72133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGEO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:27:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50634 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfGEO1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:27:20 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26EE1200761;
        Fri,  5 Jul 2019 16:27:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A631200E8B;
        Fri,  5 Jul 2019 16:27:19 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CDEE9204D6;
        Fri,  5 Jul 2019 16:27:18 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ruxandra.radulescu@nxp.com,
        Razvan Stefanescu <razvan.stefanescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 4/6] staging: fsl-dpaa2/ethsw: Add ndo_get_phys_port_name
Date:   Fri,  5 Jul 2019 17:27:14 +0300
Message-Id: <1562336836-17119-5-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
References: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@nxp.com>

Add the ndo_get_phys_port_name callback to the ethsw driver.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 9f1617164865..341c36b3a76d 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -516,6 +516,19 @@ static int swdev_get_port_parent_id(struct net_device *dev,
 	return 0;
 }
 
+static int port_get_phys_name(struct net_device *netdev, char *name,
+			      size_t len)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err;
+
+	err = snprintf(name, len, "p%d", port_priv->idx);
+	if (err >= len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct net_device_ops ethsw_port_ops = {
 	.ndo_open		= port_open,
 	.ndo_stop		= port_stop,
@@ -528,6 +541,7 @@ static int swdev_get_port_parent_id(struct net_device *dev,
 
 	.ndo_start_xmit		= port_dropframe,
 	.ndo_get_port_parent_id	= swdev_get_port_parent_id,
+	.ndo_get_phys_port_name = port_get_phys_name,
 };
 
 static void ethsw_links_state_update(struct ethsw_core *ethsw)
-- 
1.9.1

