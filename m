Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17549222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vRhV4JBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfKLO3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:29:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37406 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfKLO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:29:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACETCEH014180;
        Tue, 12 Nov 2019 08:29:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568952;
        bh=VPcCHoz83EUA010ZU1nWEatZxpJu9dEalZ7log4olLA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vRhV4JBJShZJqKH548sWxtLoiAgrHXKCEb2d+wAYaNesweexMCZUlrTvm2xAH0ed/
         d+nx+LHvwRpiiGNNTovUGuRp6F/sAK2dExm7YD4cNi9On3IVCKeC6Ya9/SwW+HPLwR
         0/Zk0ECdx3++9qapTEkxk2T3iJRSe3mxDGXm7VHo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACETCvq038188;
        Tue, 12 Nov 2019 08:29:12 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:54 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriT044422;
        Tue, 12 Nov 2019 08:29:11 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 17/20] media: ti-vpe: cal: Properly calculate max resolution boundary
Date:   Tue, 12 Nov 2019 08:31:49 -0600
Message-ID: <20191112143152.23176-18-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112143152.23176-1-bparrot@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we were using an arbitrarily small maximum resolution mostly
based on available sensor capabilities. However the hardware DMA limits
are much higher than the statically define maximum resolution we were
using.

There we rework the boundary check code to handle the maximum width and
height based on the maximum line width in bytes and re-calculating the
pixel width based on the given pixel format.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 5b5ff32b6120..091119bee8fc 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -34,8 +34,8 @@
 
 #define CAL_MODULE_NAME "cal"
 
-#define MAX_WIDTH 1920
-#define MAX_HEIGHT 1200
+#define MAX_WIDTH_BYTES (8192 * 8)
+#define MAX_HEIGHT_LINES 16383
 
 #define CAL_VERSION "0.1.0"
 
@@ -1330,15 +1330,21 @@ static int cal_calc_format_size(struct cal_ctx *ctx,
 				const struct cal_fmt *fmt,
 				struct v4l2_format *f)
 {
-	u32 bpl;
+	u32 bpl, max_width;
 
 	if (!fmt) {
 		ctx_dbg(3, ctx, "No cal_fmt provided!\n");
 		return -EINVAL;
 	}
 
-	v4l_bound_align_image(&f->fmt.pix.width, 48, MAX_WIDTH, 2,
-			      &f->fmt.pix.height, 32, MAX_HEIGHT, 0, 0);
+	/*
+	 * Maximum width is bound by the DMA max width in bytes.
+	 * We need to recalculate the actual maxi width depending on the
+	 * number of bytes per pixels required.
+	 */
+	max_width = MAX_WIDTH_BYTES / (ALIGN(fmt->bpp, 8) >> 3);
+	v4l_bound_align_image(&f->fmt.pix.width, 48, max_width, 2,
+			      &f->fmt.pix.height, 32, MAX_HEIGHT_LINES, 0, 0);
 
 	bpl = (f->fmt.pix.width * ALIGN(fmt->bpp, 8)) >> 3;
 	f->fmt.pix.bytesperline = ALIGN(bpl, 16);
-- 
2.17.1

