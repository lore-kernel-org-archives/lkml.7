Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EA5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C08218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfGCO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:56:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54540 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfGCO4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:56:49 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31B401A0DC7;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 25A781A03A1;
        Wed,  3 Jul 2019 16:56:48 +0200 (CEST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D8FEF205F0;
        Wed,  3 Jul 2019 16:56:47 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     laurentiu.tudor@nxp.com, Roy.Pledge@nxp.com,
        linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/3] bus: fsl-mc: remove explicit device_link_del
Date:   Wed,  3 Jul 2019 17:56:38 +0300
Message-Id: <1562165800-30721-2-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with commit 72175d4ea4c4 ("driver core: Make driver core own
stateful device links") stateful device links are owned by the driver
core and should not be explicitly removed on device unbind. Delete all
device_link_del appearances from the fsl-mc bus.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 1 -
 drivers/bus/fsl-mc/mc-io.c            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 8ad77246f322..cc7bb900f524 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -330,7 +330,6 @@ void fsl_mc_object_free(struct fsl_mc_device *mc_adev)
 
 	fsl_mc_resource_free(resource);
 
-	device_link_del(mc_adev->consumer_link);
 	mc_adev->consumer_link = NULL;
 }
 EXPORT_SYMBOL_GPL(fsl_mc_object_free);
diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 3ae574a58cce..d9629fc13a15 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -255,7 +255,6 @@ void fsl_mc_portal_free(struct fsl_mc_io *mc_io)
 	fsl_destroy_mc_io(mc_io);
 	fsl_mc_resource_free(resource);
 
-	device_link_del(dpmcp_dev->consumer_link);
 	dpmcp_dev->consumer_link = NULL;
 }
 EXPORT_SYMBOL_GPL(fsl_mc_portal_free);
-- 
1.9.1

