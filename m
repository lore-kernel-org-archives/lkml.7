Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4675DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2623921882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfGCO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:56:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54550 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCO4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:56:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A4DF1A03A1;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7E9021A016C;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3485E205F0;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, Roy.Pledge@nxp.com,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] soc: fsl: dpio: remove explicit device_link_remove
Date:   Wed,  3 Jul 2019 17:56:39 +0300
Message-Id: <1562165800-30721-3-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with commit 72175d4ea4c4 ("driver core: Make driver core
own stateful device links") stateful device links are owned by the
driver core and should not be explicitly removed on device unbind.
Delete all device_link_remove appearances from the dpio driver.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index b9539ef2c3cd..518a8e081b49 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -305,8 +305,6 @@ void dpaa2_io_service_deregister(struct dpaa2_io *service,
 	list_del(&ctx->node);
 	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
 
-	if (dev)
-		device_link_remove(dev, d->dev);
 }
 EXPORT_SYMBOL_GPL(dpaa2_io_service_deregister);
 
-- 
1.9.1

