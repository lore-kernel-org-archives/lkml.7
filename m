Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB0DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C36E21655
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zWtjVzed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfI0SfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:35:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57798 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfI0Se6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:34:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8RIYvGL091605;
        Fri, 27 Sep 2019 13:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569609297;
        bh=qR2u/2vBhjFJBnrGn7xWPTWwDi9+4SxHSJh+/UG2w0o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zWtjVzedURuY6DqlllNhPXuXt1K8lb/nPzwkms8S62J46KgLV4dR0U07l83qQENuy
         1XlpE9jYsktPWAd8b5kMBSokCBUf3HRh6pNK4AJk5TuRi2tbm6VtyaQsqzjTFXcCGm
         HA49IU3TGQGl6XOg3Z5dPJC1Lcvmn3TAONBseJD4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8RIYvbm061285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Sep 2019 13:34:57 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 27
 Sep 2019 13:34:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 27 Sep 2019 13:34:49 -0500
Received: from uda0869644b.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8RIYgc4073031;
        Fri, 27 Sep 2019 13:34:57 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch 15/16] media: ti-vpe: vpe: fix v4l2_compliance issue related to xfer_func
Date:   Fri, 27 Sep 2019 13:36:49 -0500
Message-ID: <20190927183650.31345-16-bparrot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927183650.31345-1-bparrot@ti.com>
References: <20190927183650.31345-1-bparrot@ti.com>
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
 drivers/media/platform/ti-vpe/vpe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
index d7f8eb901475..e30981cd3e8f 100644
--- a/drivers/media/platform/ti-vpe/vpe.c
+++ b/drivers/media/platform/ti-vpe/vpe.c
@@ -324,6 +324,9 @@ struct vpe_q_data {
 	unsigned int		nplanes;			/* Current number of planes */
 	unsigned int		bytesperline[VPE_MAX_PLANES];	/* bytes per line in memory */
 	enum v4l2_colorspace	colorspace;
+	enum v4l2_ycbcr_encoding ycbcr_enc;
+	enum v4l2_xfer_func	xfer_func;
+	enum v4l2_quantization	quant;
 	enum v4l2_field		field;				/* supported field value */
 	unsigned int		flags;
 	unsigned int		sizeimage[VPE_MAX_PLANES];	/* image size in memory */
@@ -1576,6 +1579,9 @@ static int vpe_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 
 	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
 		pix->colorspace = q_data->colorspace;
+		pix->xfer_func = q_data->xfer_func;
+		pix->ycbcr_enc = q_data->ycbcr_enc;
+		pix->quantization = q_data->quant;
 	} else {
 		struct vpe_q_data *s_q_data;
 
@@ -1583,6 +1589,9 @@ static int vpe_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		s_q_data = get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 
 		pix->colorspace = s_q_data->colorspace;
+		pix->xfer_func = s_q_data->xfer_func;
+		pix->ycbcr_enc = s_q_data->ycbcr_enc;
+		pix->quantization = s_q_data->quant;
 	}
 
 	pix->num_planes = q_data->nplanes;
@@ -1758,6 +1767,9 @@ static int __vpe_s_fmt(struct vpe_ctx *ctx, struct v4l2_format *f)
 	q_data->width		= pix->width;
 	q_data->height		= pix->height;
 	q_data->colorspace	= pix->colorspace;
+	q_data->xfer_func	= pix->xfer_func;
+	q_data->ycbcr_enc	= pix->ycbcr_enc;
+	q_data->quant		= pix->quantization;
 	q_data->field		= pix->field;
 	q_data->nplanes		= pix->num_planes;
 
-- 
2.17.1

