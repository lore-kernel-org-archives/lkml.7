Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8ADC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DA52063F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfHMIyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:54:54 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41500 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbfHMIyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:54:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 959ED200779;
        Tue, 13 Aug 2019 10:54:51 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 89615200769;
        Tue, 13 Aug 2019 10:54:51 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 477B62060E;
        Tue, 13 Aug 2019 10:54:51 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     joe@perches.com, andrew@lunn.ch, ruxandra.radulescu@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 03/10] staging: fsl-dpaa2/ethsw: add line terminator to all formats
Date:   Tue, 13 Aug 2019 11:54:32 +0300
Message-Id: <1565686479-32577-4-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
References: <1565686479-32577-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the '\n' line terminator to the string formats missing it.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
 - added Reported-by tag

 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
index 926a0c053e18..95e9f1096999 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -65,7 +65,7 @@ static void ethsw_get_drvinfo(struct net_device *netdev,
 				     port_priv->idx,
 				     &state);
 	if (err) {
-		netdev_err(netdev, "ERROR %d getting link state", err);
+		netdev_err(netdev, "ERROR %d getting link state\n", err);
 		goto out;
 	}
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 302842c3bdfe..9ade73928e60 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -722,12 +722,12 @@ static irqreturn_t ethsw_irq0_handler_thread(int irq_num, void *arg)
 	err = dpsw_get_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				  DPSW_IRQ_INDEX_IF, &status);
 	if (err) {
-		dev_err(dev, "Can't get irq status (err %d)", err);
+		dev_err(dev, "Can't get irq status (err %d)\n", err);
 
 		err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 					    DPSW_IRQ_INDEX_IF, 0xFFFFFFFF);
 		if (err)
-			dev_err(dev, "Can't clear irq status (err %d)", err);
+			dev_err(dev, "Can't clear irq status (err %d)\n", err);
 		goto out;
 	}
 
@@ -772,21 +772,21 @@ static int ethsw_setup_irqs(struct fsl_mc_device *sw_dev)
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					dev_name(dev), dev);
 	if (err) {
-		dev_err(dev, "devm_request_threaded_irq(): %d", err);
+		dev_err(dev, "devm_request_threaded_irq(): %d\n", err);
 		goto free_irq;
 	}
 
 	err = dpsw_set_irq_mask(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				DPSW_IRQ_INDEX_IF, mask);
 	if (err) {
-		dev_err(dev, "dpsw_set_irq_mask(): %d", err);
+		dev_err(dev, "dpsw_set_irq_mask(): %d\n", err);
 		goto free_devm_irq;
 	}
 
 	err = dpsw_set_irq_enable(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				  DPSW_IRQ_INDEX_IF, 1);
 	if (err) {
-		dev_err(dev, "dpsw_set_irq_enable(): %d", err);
+		dev_err(dev, "dpsw_set_irq_enable(): %d\n", err);
 		goto free_devm_irq;
 	}
 
-- 
1.9.1

