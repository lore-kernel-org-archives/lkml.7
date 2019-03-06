Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F41D2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrCrQLvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfCFGPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:15:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfCFGPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:15:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so7683643pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 22:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yKqYoiAT0Tmmo3srRdNf++4aPyW5uQd7VuC7jZ4Ae0=;
        b=SrCrQLvMzMrdQBfMF2hf4vL7DVph7K8/C4/HascSXSHP6hPJb9pqkxZdirMYWrBTvD
         3beFbrpMwjOAN3puKSi5yLF46/XQ0+DbO3s19GIWDgdw7c6ZNRwX3SIyPL6GCgo5RNFq
         crJ/I3ky1uzcOoLBHNZnC77/4xuKyt7mbdUQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yKqYoiAT0Tmmo3srRdNf++4aPyW5uQd7VuC7jZ4Ae0=;
        b=EilrGwBRFDgCGjTBgihqUzaWpuRWQ+Z1X+NLZoE7qqJJhUWntnJy2l26Iw/n9LRobE
         +vYYd3/rkUm4wBDydxXI4lpn5LhVAlm0lIqH3iFe78SYYgrV92h0gHLj1RgkW4zFUQAx
         jFyI4Y5oMy5p8FusYm+EfuINZ5rs7AvQE7WFe7Ta3LnJjqGDfL4q0UtPcjZFa2h+hxVJ
         f1aMwNdhxjJQ8e5BHfMgjz29Ixw2KfOPx/jd0Z3t76C0MiOgesny9FWp9Be8wAJgPcuK
         zDQSBE1h2uAnkysPcpFwKNnY4wMxRTuV066/H6mRA3RNTDTs+EYJxAgUrRAnwhzILQpm
         P88w==
X-Gm-Message-State: APjAAAV+LREi9BLFh2uihw27xaTXuJkIev3Ov2gxTD9SIxSnBV6BP7OK
        NFjjwL7ldRjMFXzfxOaEwC+Alg==
X-Google-Smtp-Source: APXvYqyFrfyPokVCZ0UNRCvO3ZJgdZKDC9H1a48lxdMOuEltaAY3I7LKkXeuE3ikzh2FOmbi+zOKnQ==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr5219821plk.105.1551852913262;
        Tue, 05 Mar 2019 22:15:13 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id k9sm1511981pfc.57.2019.03.05.22.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 22:15:12 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] media: mtk-vcodec: fix access to vb2_v4l2_buffer struct
Date:   Wed,  6 Mar 2019 15:15:02 +0900
Message-Id: <20190306061502.126904-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0650a91499e0 ("media: mtk-vcodec: Correct return type for mem2mem
buffer helpers") fixed the return types for mem2mem buffer helper
functions, but omitted two occurrences that are accessed in the
mtk_v4l2_debug() macro. These only trigger compiler errors when DEBUG is
defined.

Fixes: 0650a91499e0 ("media: mtk-vcodec: Correct return type for mem2mem buffer helpers")
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index d022c65bb34c..a85c7cc8328e 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -1158,7 +1158,7 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
 	src_mem.size = (size_t)src_buf->planes[0].bytesused;
 	mtk_v4l2_debug(2,
 			"[%d] buf id=%d va=%p dma=%pad size=%zx",
-			ctx->id, src_buf->index,
+			ctx->id, src_buf->vb2_buf.index,
 			src_mem.va, &src_mem.dma_addr,
 			src_mem.size);
 
@@ -1182,7 +1182,7 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
 		}
 		mtk_v4l2_debug(ret ? 0 : 1,
 			       "[%d] vdec_if_decode() src_buf=%d, size=%zu, fail=%d, res_chg=%d",
-			       ctx->id, src_buf->index,
+			       ctx->id, src_buf->vb2_buf.index,
 			       src_mem.size, ret, res_chg);
 		return;
 	}
-- 
2.21.0.352.gf09ad66450-goog

