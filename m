Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B324C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226BC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfDWGMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:12:43 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:41114 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDWGMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:12:39 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hIofO-0001t8-VF from Jiada_Wang@mentor.com ; Mon, 22 Apr 2019 23:12:30 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 22 Apr 2019 23:12:26 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <joshua_frkuska@mentor.com>,
        <jiada_wang@mentor.com>, <horms+renesas@verge.net.au>,
        <niklas.soderlund+renesas@ragnatech.se>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>
Subject: [PATCH v2 1/2] thermal: rcar_gen3_thermal: fix interrupt type
Date:   Tue, 23 Apr 2019 15:12:17 +0900
Message-ID: <20190423061218.29705-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190423061218.29705-1-jiada_wang@mentor.com>
References: <20190423061218.29705-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
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
 drivers/thermal/rcar_gen3_thermal.c | 40 ++++++++---------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 64035bcec42c..a11032e42f36 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -236,41 +236,21 @@ static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
 static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 {
 	struct rcar_gen3_thermal_priv *priv = data;
+	unsigned long flags;
+	int i;
 	u32 status;
-	int i, ret = IRQ_HANDLED;
 
-	spin_lock(&priv->lock);
 	for (i = 0; i < priv->num_tscs; i++) {
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
 		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
-		if (status)
-			ret = IRQ_WAKE_THREAD;
-	}
-
-	if (ret == IRQ_WAKE_THREAD)
-		rcar_thermal_irq_set(priv, false);
-
-	spin_unlock(&priv->lock);
 
-	return ret;
-}
-
-static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
-{
-	struct rcar_gen3_thermal_priv *priv = data;
-	unsigned long flags;
-	int i;
-
-	for (i = 0; i < priv->num_tscs; i++) {
-		rcar_gen3_thermal_set_irq_temp(priv->tscs[i]);
-		thermal_zone_device_update(priv->tscs[i]->zone,
-					   THERMAL_EVENT_UNSPECIFIED);
+		if (status) {
+			rcar_gen3_thermal_set_irq_temp(priv->tscs[i]);
+			thermal_zone_device_update(priv->tscs[i]->zone,
+						   THERMAL_EVENT_UNSPECIFIED);
+		}
 	}
 
-	spin_lock_irqsave(&priv->lock, flags);
-	rcar_thermal_irq_set(priv, true);
-	spin_unlock_irqrestore(&priv->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -397,9 +377,9 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
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

