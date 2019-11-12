Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B53C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9760222C6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EmHh3xqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfKLO3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:29:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37388 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfKLO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:29:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACET6Jt014155;
        Tue, 12 Nov 2019 08:29:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573568946;
        bh=fxkl6EobTAT1J+Cb0bAfjajLxzJGK5I9H/BGiUdtKHg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EmHh3xqeIO/Msg/cHeCvGX//8hnYPv4f1Nbjy0tNUx/pzz2sOrYknrk9F4CsZ3qPZ
         NsFwJNwGMzvgyMOORafPhqFxgrZUWRG2r6vvoJ0HtWfwuOTvRzYrSR4sLmyAcDmpTg
         VKyxe5UAJl/4IGLWK5Yen+WaJlpFJdh96xk8ZjOo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACET6qv027172
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:29:06 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:28:49 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:28:49 -0600
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACESriM044422;
        Tue, 12 Nov 2019 08:29:06 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 10/20] media: ti-vpe: cal: Fix pixel processing parameters
Date:   Tue, 12 Nov 2019 08:31:42 -0600
Message-ID: <20191112143152.23176-11-bparrot@ti.com>
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

The pixel processing unit was hard coded to only handle 8 bits per pixel
from input to output.

We now add handling for 10, 12 and 16 bits per pixel at the source and
setting the in-memory size (i.e. container size) to 16 bits for these 3
cases.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/cal.c | 41 ++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 51edc7bc3135..1b4a74f0d751 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -800,13 +800,48 @@ static void csi2_ctx_config(struct cal_ctx *ctx)
 
 static void pix_proc_config(struct cal_ctx *ctx)
 {
-	u32 val;
+	u32 val, extract, pack;
+
+	switch (ctx->fmt->bpp) {
+	case 8:
+		extract = CAL_PIX_PROC_EXTRACT_B8;
+		pack = CAL_PIX_PROC_PACK_B8;
+		break;
+	case 10:
+		extract = CAL_PIX_PROC_EXTRACT_B10_MIPI;
+		pack = CAL_PIX_PROC_PACK_B16;
+		break;
+	case 12:
+		extract = CAL_PIX_PROC_EXTRACT_B12_MIPI;
+		pack = CAL_PIX_PROC_PACK_B16;
+		break;
+	case 16:
+		extract = CAL_PIX_PROC_EXTRACT_B16_LE;
+		pack = CAL_PIX_PROC_PACK_B16;
+		break;
+	default:
+		/*
+		 * If you see this warning then it means that you added
+		 * some new entry in the cal_formats[] array with a different
+		 * bit per pixel values then the one supported below.
+		 * Either add support for the new bpp value below or adjust
+		 * the new entry to use one of the value below.
+		 *
+		 * Instead of failing here just use 8 bpp as a default.
+		 */
+		dev_warn_once(&ctx->dev->pdev->dev,
+			      "%s:%d:%s: bpp:%d unsupported! Overwritten with 8.\n",
+			      __FILE__, __LINE__, __func__, ctx->fmt->bpp);
+		extract = CAL_PIX_PROC_EXTRACT_B8;
+		pack = CAL_PIX_PROC_PACK_B8;
+		break;
+	}
 
 	val = reg_read(ctx->dev, CAL_PIX_PROC(ctx->csi2_port));
-	set_field(&val, CAL_PIX_PROC_EXTRACT_B8, CAL_PIX_PROC_EXTRACT_MASK);
+	set_field(&val, extract, CAL_PIX_PROC_EXTRACT_MASK);
 	set_field(&val, CAL_PIX_PROC_DPCMD_BYPASS, CAL_PIX_PROC_DPCMD_MASK);
 	set_field(&val, CAL_PIX_PROC_DPCME_BYPASS, CAL_PIX_PROC_DPCME_MASK);
-	set_field(&val, CAL_PIX_PROC_PACK_B8, CAL_PIX_PROC_PACK_MASK);
+	set_field(&val, pack, CAL_PIX_PROC_PACK_MASK);
 	set_field(&val, ctx->csi2_port, CAL_PIX_PROC_CPORT_MASK);
 	set_field(&val, CAL_GEN_ENABLE, CAL_PIX_PROC_EN_MASK);
 	reg_write(ctx->dev, CAL_PIX_PROC(ctx->csi2_port), val);
-- 
2.17.1

