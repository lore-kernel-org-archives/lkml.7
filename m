Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD1CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780EB20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfLDOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:30:07 -0500
Received: from inva021.nxp.com ([92.121.34.21]:47476 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:30:07 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D54120120C;
        Wed,  4 Dec 2019 15:30:05 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 899AC20121A;
        Wed,  4 Dec 2019 15:30:05 +0100 (CET)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C699205C5;
        Wed,  4 Dec 2019 15:30:05 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH] bus: fsl-mc: properly empty-initialize structure
Date:   Wed,  4 Dec 2019 16:29:50 +0200
Message-Id: <20191204142950.30206-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper form of the empty initializer when working with
structures that contain an array. Otherwise, older gcc versions (eg gcc
4.9) will complain about this.

Fixes: 1ac210d128ef ("bus: fsl-mc: add the fsl_mc_get_endpoint function")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index a07cc19becdb..c78d10ea641f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -715,9 +715,9 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_remove);
 struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev)
 {
 	struct fsl_mc_device *mc_bus_dev, *endpoint;
-	struct fsl_mc_obj_desc endpoint_desc = { 0 };
-	struct dprc_endpoint endpoint1 = { 0 };
-	struct dprc_endpoint endpoint2 = { 0 };
+	struct fsl_mc_obj_desc endpoint_desc = {{ 0 }};
+	struct dprc_endpoint endpoint1 = {{ 0 }};
+	struct dprc_endpoint endpoint2 = {{ 0 }};
 	int state, err;
 
 	mc_bus_dev = to_fsl_mc_device(mc_dev->dev.parent);
-- 
2.17.1

