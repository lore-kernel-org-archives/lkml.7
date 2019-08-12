Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93218C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFD620842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfHLJjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:39:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:57594 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfHLJjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:39:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8DECE2002F1;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EEB4200112;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 35536205ED;
        Mon, 12 Aug 2019 11:39:34 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 05/10] staging: fsl-dpaa2/ethsw: use bool when encoding learning/flooding state
Date:   Mon, 12 Aug 2019 12:39:13 +0300
Message-Id: <1565602758-14434-6-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a bool instead of an u8 in ethsw_set_learning() and
ethsw_port_set_flood() to encode an binary type property.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 9ade73928e60..20519af4d804 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -149,12 +149,12 @@ static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
 	return 0;
 }
 
-static int ethsw_set_learning(struct ethsw_core *ethsw, u8 flag)
+static int ethsw_set_learning(struct ethsw_core *ethsw, bool enable)
 {
 	enum dpsw_fdb_learning_mode learn_mode;
 	int err;
 
-	if (flag)
+	if (enable)
 		learn_mode = DPSW_FDB_LEARNING_MODE_HW;
 	else
 		learn_mode = DPSW_FDB_LEARNING_MODE_DIS;
@@ -165,24 +165,24 @@ static int ethsw_set_learning(struct ethsw_core *ethsw, u8 flag)
 		dev_err(ethsw->dev, "dpsw_fdb_set_learning_mode err %d\n", err);
 		return err;
 	}
-	ethsw->learning = !!flag;
+	ethsw->learning = enable;
 
 	return 0;
 }
 
-static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, u8 flag)
+static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, bool enable)
 {
 	int err;
 
 	err = dpsw_if_set_flooding(port_priv->ethsw_data->mc_io, 0,
 				   port_priv->ethsw_data->dpsw_handle,
-				   port_priv->idx, flag);
+				   port_priv->idx, enable);
 	if (err) {
 		netdev_err(port_priv->netdev,
 			   "dpsw_if_set_flooding err %d\n", err);
 		return err;
 	}
-	port_priv->flood = !!flag;
+	port_priv->flood = enable;
 
 	return 0;
 }
-- 
1.9.1

