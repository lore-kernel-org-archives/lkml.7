Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D7C4649C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE38216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 14:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfGEO1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 10:27:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36114 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfGEO1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:27:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 41E4C1A07CD;
        Fri,  5 Jul 2019 16:27:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3629C1A07C8;
        Fri,  5 Jul 2019 16:27:18 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E9D44204D6;
        Fri,  5 Jul 2019 16:27:17 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ruxandra.radulescu@nxp.com,
        Razvan Stefanescu <razvan.stefanescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 2/6] staging: fsl-dpaa2/ethsw: Add network interface statistics
Date:   Fri,  5 Jul 2019 17:27:12 +0300
Message-Id: <1562336836-17119-3-git-send-email-ioana.ciornei@nxp.com>
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

Allocate MC portal with atomic context for I/O and enable network interface
statistics for hardware counters.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - none

 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 87470070c3a5..b2273f840813 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -521,6 +521,7 @@ static int swdev_get_port_parent_id(struct net_device *dev,
 	.ndo_stop		= port_stop,
 
 	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_get_stats64	= port_get_stats,
 	.ndo_change_mtu		= port_change_mtu,
 	.ndo_has_offload_stats	= port_has_offload_stats,
 	.ndo_get_offload_stats	= port_get_offload_stats,
@@ -1483,7 +1484,8 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 	ethsw->dev = dev;
 	dev_set_drvdata(dev, ethsw);
 
-	err = fsl_mc_portal_allocate(sw_dev, 0, &ethsw->mc_io);
+	err = fsl_mc_portal_allocate(sw_dev, FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
+				     &ethsw->mc_io);
 	if (err) {
 		if (err == -ENXIO)
 			err = -EPROBE_DEFER;
-- 
1.9.1

