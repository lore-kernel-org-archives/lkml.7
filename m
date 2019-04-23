Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DDC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6F120652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfDWOOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:14:30 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:53572 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfDWOO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:14:29 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hIwBm-00005Y-OH from Jiada_Wang@mentor.com ; Tue, 23 Apr 2019 07:14:26 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 23 Apr 2019 07:14:22 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <horms+renesas@verge.net.au>,
        <niklas.soderlund+renesas@ragnatech.se>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>, <erosca@de.adit-jv.com>,
        <george_davis@mentor.com>, <joshua_frkuska@mentor.com>
Subject: [PATCH v3 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date:   Tue, 23 Apr 2019 23:14:13 +0900
Message-ID: <20190423141414.24264-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190423141414.24264-1-jiada_wang@mentor.com>
References: <20190423141414.24264-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently IRQF_SHARED type interrupt line is allocated, but it
is not appropriate, as the interrupt line isn't shared between
different devices, instead IRQF_ONESHOT is the proper type.

By changing interrupt type to IRQF_ONESHOT, now irq handler is
no longer needed, as clear of interrupt status can be done in
threaded interrupt context.

Because IRQF_ONESHOT type interrupt line is kept disabled until
the threaded handler has been run, so there is no need to protect
read/write of REG_GEN3_IRQSTR with lock.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 34 +++++------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41cf16e8..ebbaef5a3cf1 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -231,39 +231,17 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
 static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 {
 	struct rcar_gen3_thermal_priv *priv = data;
+	int i;
 	u32 status;
-	int i, ret = IRQ_HANDLED;
 
-	spin_lock(&priv->lock);
 	for (i = 0; i < priv->num_tscs; i++) {
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
 		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
 		if (status)
-			ret = IRQ_WAKE_THREAD;
+			thermal_zone_device_update(priv->tscs[i]->zone,
+						   THERMAL_EVENT_UNSPECIFIED);
 	}
 
-	if (ret == IRQ_WAKE_THREAD)
-		rcar_thermal_irq_set(priv, false);
-
-	spin_unlock(&priv->lock);
-
-	return ret;
-}
-
-static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
-{
-	struct rcar_gen3_thermal_priv *priv = data;
-	unsigned long flags;
-	int i;
-
-	for (i = 0; i < priv->num_tscs; i++)
-		thermal_zone_device_update(priv->tscs[i]->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
-
-	spin_lock_irqsave(&priv->lock, flags);
-	rcar_thermal_irq_set(priv, true);
-	spin_unlock_irqrestore(&priv->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -390,9 +368,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (!irqname)
 			return -ENOMEM;
 
-		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
-						rcar_gen3_thermal_irq_thread,
-						IRQF_SHARED, irqname, priv);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						rcar_gen3_thermal_irq,
+						IRQF_ONESHOT, irqname, priv);
 		if (ret)
 			return ret;
 	}
-- 
2.19.2

