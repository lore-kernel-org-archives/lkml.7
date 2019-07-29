Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE22C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70257206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbfG2QMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:12:37 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40790 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfG2QMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:12:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C88CE200356;
        Mon, 29 Jul 2019 18:12:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BC1BF200344;
        Mon, 29 Jul 2019 18:12:20 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 55E28205F3;
        Mon, 29 Jul 2019 18:12:20 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com, jiri@mellanox.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 4/5] staging: fsl-dpaa2/ethsw: check added_by_user flag
Date:   Mon, 29 Jul 2019 19:11:51 +0300
Message-Id: <1564416712-16946-5-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564416712-16946-1-git-send-email-ioana.ciornei@nxp.com>
References: <1564416712-16946-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not want to offload FDB entries if not added by user as static
entries. Check the added_by_user flag and break if not set.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index e6423f1e190d..2d3179c6bad8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1179,6 +1179,8 @@ static void ethsw_switchdev_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		if (!fdb_info->added_by_user)
+			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			err = ethsw_port_fdb_add_uc(netdev_priv(dev),
 						    fdb_info->addr);
@@ -1192,6 +1194,8 @@ static void ethsw_switchdev_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (!fdb_info->added_by_user)
+			break;
 		if (is_unicast_ether_addr(fdb_info->addr))
 			ethsw_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
 		else
-- 
1.9.1

