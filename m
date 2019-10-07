Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA0ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143892070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aES9uJ0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfJGPIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:08:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35882 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbfJGPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:07:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97F7qOK047041;
        Mon, 7 Oct 2019 10:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570460872;
        bh=1Msqbd1UaOlI29ml1szWg9wzSAK2snjYLbjjAcowX14=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aES9uJ0R2BlwuJ/dJXlT4bjtm5UuisgcOdKO2vx7eJZo+/20Tkvy8FMk06Afqcsg6
         7JDHnfq06ZmDpKNmzcz6cI0XGRAqU/52dzUCYJFDXwOplDdbBpTdh4k1JW9LdIBDfX
         TQ98mvMOc7lW274OvbWy+PlHfOf9AwBHxp+dML+8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97F7qq9043113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 10:07:52 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 10:07:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 10:07:49 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97F7aFN055156;
        Mon, 7 Oct 2019 10:07:52 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 17/21] media: ti-vpe: vpe: fix v4l2_compliance issue related to xfer_func
Date:   Mon, 7 Oct 2019 10:10:05 -0500
Message-ID: <20191007151009.22095-18-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007151009.22095-1-bparrot@ti.com>
References: <20191007151009.22095-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All 4 of the "colorspace" components were not originally handled.
Causing issue related to xfer_func not being initialized properly.

This was found with v4l2-compliance test.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/media/platform/ti-vpe/vpe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index 295cbcef3a0e..7c74b21e0164 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -1582,11 +1582,14 @@ static int vpe_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		struct vpe_q_data *s_q_data;
 		struct v4l2_pix_format_mplane *spix;
 
-		/* get colorspace from the source queue */
+		/* get colorimetry from the source queue */
 		s_q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 		spix = &s_q_data->format.fmt.pix_mp;
 
 		pix->colorspace = spix->colorspace;
+		pix->xfer_func = spix->xfer_func;
+		pix->ycbcr_enc = spix->ycbcr_enc;
+		pix->quantization = spix->quantization;
 	}
 
 	return 0;
-- 
2.17.1

