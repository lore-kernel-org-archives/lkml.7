Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E25C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A724208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lD7C87Vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbfIFLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:55:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36237 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391470AbfIFLzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:55:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so3038099plr.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmvBNkTdsDRsEM61NjMf/X0IeoL67srtswcL/KipeCU=;
        b=lD7C87VcCfCC73o5yfmt2mC/BIZKrEeMM/aT6dR4o+mCr1k4uiXbUBCGjdmwVCK7f+
         xuR8XlsTWg3PNQMzw6MlyoZnkB09W7iSSH2oWnJ8xLBnFXifM9yzmQCi0zibzW0c1/Ge
         RlScRApeYLC5DHYB1nXWL5UsmHcTspdONkYsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmvBNkTdsDRsEM61NjMf/X0IeoL67srtswcL/KipeCU=;
        b=uLbdZQnqQh1R21b3bYRFJYvV4VJ2T+pOXvMgxH6o7aV06ujO+xPquoEgV4FdGBRcqq
         RZUZEwOkponQvW3LYhhFetGh/zvQy5bvS5/JXCPlL7f3d5VzaqmzBKno20LPKOOYcXLk
         YebtPitPA2YyxnrI4+AT4yj1ldLF+gf0YswxLQ04I4IsEJJ5UgQUGtk94kFyccUp+nf6
         l8CEENGs39exz4wf+iILpq29F2sgLg9EMEpDFpT755AKHZSEvRycMm64Wn5OLBRZu6q2
         gdl/VsllyjWQH1+16BO8srh5nxaknstYYR2TIAZ09k3cXJxaKd1eTRZvEXJd8WvF6oX+
         zyNA==
X-Gm-Message-State: APjAAAUwOW036EhKwJSiCkfjbFZmvi6mW5vWwrGIZemT2oQiDxFsHMys
        FetaXfaxTCkDAIZjelIAnoqB1A==
X-Google-Smtp-Source: APXvYqyUCSBsPgZieu0kGLJ172xmNCEYZ4dQ2c7hwk8o5f0gKm/e7v15Sxpv0rgcqXV8P/Q5bi7y3A==
X-Received: by 2002:a17:902:8690:: with SMTP id g16mr9003555plo.282.1567770937975;
        Fri, 06 Sep 2019 04:55:37 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id o22sm3667394pjq.21.2019.09.06.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 04:55:37 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFC PATCH v2 03/13] media: mtk-vcodec: vdec: clean up vidioc_vdec_s_fmt a bit
Date:   Fri,  6 Sep 2019 20:55:03 +0900
Message-Id: <20190906115513.159705-4-acourbot@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906115513.159705-1-acourbot@chromium.org>
References: <20190906115513.159705-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for a potentially NULL pointer that was overlooked and use shorter
accessors to the same data. While we are at it, sprinkle a few comments.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_dec.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 653f111532ab..858727824889 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -841,12 +841,20 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 		return -EINVAL;
 
 	pix_mp = &f->fmt.pix_mp;
+	/*
+	 * Setting OUTPUT format after OUTPUT buffers are allocated is invalid
+	 * if using the stateful API.
+	 */
 	if ((f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) &&
 	    vb2_is_busy(&ctx->m2m_ctx->out_q_ctx.q)) {
 		mtk_v4l2_err("out_q_ctx buffers already requested");
 		ret = -EBUSY;
 	}
 
+	/*
+	 * Setting CAPTURE format after CAPTURE buffers are allocated is
+	 * invalid.
+	 */
 	if ((f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) &&
 	    vb2_is_busy(&ctx->m2m_ctx->cap_q_ctx.q)) {
 		mtk_v4l2_err("cap_q_ctx buffers already requested");
@@ -865,6 +873,8 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 			fmt = mtk_vdec_find_format(f);
 		}
 	}
+	if (fmt == NULL)
+		return -EINVAL;
 
 	q_data->fmt = fmt;
 	vidioc_try_fmt(f, q_data->fmt);
@@ -873,10 +883,10 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 		q_data->coded_width = pix_mp->width;
 		q_data->coded_height = pix_mp->height;
 
-		ctx->colorspace = f->fmt.pix_mp.colorspace;
-		ctx->ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
-		ctx->quantization = f->fmt.pix_mp.quantization;
-		ctx->xfer_func = f->fmt.pix_mp.xfer_func;
+		ctx->colorspace = pix_mp->colorspace;
+		ctx->ycbcr_enc = pix_mp->ycbcr_enc;
+		ctx->quantization = pix_mp->quantization;
+		ctx->xfer_func = pix_mp->xfer_func;
 
 		if (ctx->state == MTK_STATE_FREE) {
 			ret = vdec_if_init(ctx, q_data->fmt->fourcc);
-- 
2.23.0.187.g17f5b7556c-goog

