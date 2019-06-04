Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2919C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743DE24976
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqKAjRwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfFDJiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:38:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43338 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfFDJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:38:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so10017997pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfKR4zIJY5Q7mLLSSnEqtRMlxyZNbSUA1f1fGIbLQtA=;
        b=SqKAjRwGPeznbRHq14yh+MdKPzB2UlkQq+rY79BVw0o99j5riYGogmLQWyRGa4CV9D
         yXU+nzbphMJin777kMGmpYxmiOt3guezpTWJ80gMOevfTZm/ve7AXEsdxR1ynh36o1q3
         TBq7U2o8GgviftlEn+OeJATftUgCrWBanShTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfKR4zIJY5Q7mLLSSnEqtRMlxyZNbSUA1f1fGIbLQtA=;
        b=uNxG2ZXgTvBBvRlW98dA+7uwTDRLwlycArZiJiYBC25v7WEWN8r6bxilOHtN5KzE/2
         btGqV3cch7dkYFA9TeccMo2myQvm9N8Fu6FP6CtSbkeh3EfLjpFdnl6ZtVPdX2E3dAKD
         QitTGC5D+OqdJFtoq1M8ds8Ai2bs5NvOx+KP/c6wYSHJI2togoNO/471gJF0rqqD5CJS
         +t63T3W0O4v7QE3IQ0x25RjbDBfP5XNKWrJEjJEwUqPf/CNa/1Gtrj64UHVrEMShi+AJ
         HdgJe2bv2rJiK7aCVZavw6X4h+YPJt5dvqKHmwaSFKFqskncuF8aj7hWb/r/6Hae8y/5
         yEvw==
X-Gm-Message-State: APjAAAWR+a+mAkLBnnKFFPYnbpK+sDJTPO9fP4h56marMpwZ3G6hjC6W
        GSsgyRVBLFd98E4FETDhCVhxdw==
X-Google-Smtp-Source: APXvYqyWS5dM/l4M3+5y02FrXWl3FHdeFzRApJLhFiUHB9nkoj0cukopH+788acAn59bdd3teuxmBg==
X-Received: by 2002:a17:90a:cf0b:: with SMTP id h11mr29074586pju.90.1559641087044;
        Tue, 04 Jun 2019 02:38:07 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id j7sm17431588pfa.184.2019.06.04.02.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 02:38:06 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH 5/5] media: mtk-vcodec: support single-buffer frames
Date:   Tue,  4 Jun 2019 18:37:37 +0900
Message-Id: <20190604093737.172599-6-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190604093737.172599-1-acourbot@chromium.org>
References: <20190604093737.172599-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

MT8183 will use a multi-planar format backed by a single buffer. Adapt
the existing code to be able to handle such frames instead of assuming
each frame is backed by two buffers.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
[acourbot: refactor, cleanup and split]
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 131a8117ece2..6b99b877a3b4 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -117,8 +117,9 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
 	if (dstbuf->used) {
 		vb2_set_plane_payload(&dstbuf->vb.vb2_buf, 0,
 					ctx->picinfo.fb_sz[0]);
-		vb2_set_plane_payload(&dstbuf->vb.vb2_buf, 1,
-					ctx->picinfo.fb_sz[1]);
+		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
+			vb2_set_plane_payload(&dstbuf->vb.vb2_buf, 1,
+						ctx->picinfo.fb_sz[1]);
 
 		mtk_v4l2_debug(2,
 				"[%d]status=%x queue id=%d to done_list %d",
@@ -389,7 +390,8 @@ static void mtk_vdec_worker(struct work_struct *work)
 		vdec_if_decode(ctx, NULL, NULL, &res_chg);
 		clean_display_buffer(ctx);
 		vb2_set_plane_payload(&dst_buf_info->vb.vb2_buf, 0, 0);
-		vb2_set_plane_payload(&dst_buf_info->vb.vb2_buf, 1, 0);
+		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
+			vb2_set_plane_payload(&dst_buf_info->vb.vb2_buf, 1, 0);
 		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
 		v4l2_m2m_buf_done(&dst_buf_info->vb, VB2_BUF_STATE_DONE);
 		clean_free_buffer(ctx);
@@ -1320,7 +1322,8 @@ static void vb2ops_vdec_stop_streaming(struct vb2_queue *q)
 
 	while ((dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx))) {
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
-		vb2_set_plane_payload(&dst_buf->vb2_buf, 1, 0);
+		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
+			vb2_set_plane_payload(&dst_buf->vb2_buf, 1, 0);
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
 	}
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

