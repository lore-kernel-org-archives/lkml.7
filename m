Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384B420854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCohNRtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfCYUWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:22:55 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48518 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfCYUWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:22:55 -0400
Received: by mail-yw1-f74.google.com with SMTP id j63so15424317ywb.15
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vUEZqTGp1lI8WHJl0ieF6DFnb827QF4G7wGfBtXI8NQ=;
        b=TCohNRtIUWFA1KEUlKXOWBC9wNOXwyMRxlXhuiKeG+AFa05ZTLoquKyk0vw1wHW0No
         /uUPM1SAUlDQsCaRku4wB2AqH6+KMa4L03GcdMyc/LJucRmRoroU2bvzaXoHLh+fqe11
         Ac8O6SlPTIX+NzDKFe8E1+8phpFsGozGAGFBbzAR6kg7SK8unsOTR6fBDbO9eajLs87B
         HeTlzb1e/m+E6LImeu9otdDPCWx+pRwRLZgHXPEQd5/3j8/ifebZh8m0rcI+wXrES2u6
         9h/fL4KouNKzGcW+qPCakUz8I9wGiehkRxZIUKnJK7rtqoB2jY1w0zkr732lo4vt3YWz
         dGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vUEZqTGp1lI8WHJl0ieF6DFnb827QF4G7wGfBtXI8NQ=;
        b=q13yz1YNcCBo530I/1ajXb+MkMTLVTZBb12pCeqzpnd7VzPrfJ/UtZ8W6yD2wStT0x
         mqZF2pe5JTw16YqFgOsWQQc6U6R0oYy2Pb/8IuPfA0wzBPvQFX6BLHrere0BoLYfRJhV
         aU1WgGgrVKbWsYc6VoglAA4cT+cwln3LPewtlQjeP6mGZMjqoz7fRgez0LiFF7J8S3Lw
         jI/uiAby9Ltkl767B2mAZzcUjHI8bd500T1uViruqGlnF7s3RQEyKSRSGmGZ1UhabTOT
         zK9cCfGgJOqvsq8FClRCt7aK1LCnR0GRKG8m348RTBG4S++4xIeY9eTDpCg8MYB3u2X6
         3+lQ==
X-Gm-Message-State: APjAAAX3YCGLZoNOpvK/pd97yMpWmOcLJKvMQDGeHixxhC4Js2laIqMk
        JT2SuS0mStdVEoCPQpgC1Lc5+LAYXFs=
X-Google-Smtp-Source: APXvYqwNwRta4kYwCH2tSkIIj8dNXSXtyIsbweyyUYqPTuDbA5FKjljRerzazPBKaWo+feVimZZEM3V5x/Y=
X-Received: by 2002:a81:1150:: with SMTP id 77mr9845080ywr.241.1553545374700;
 Mon, 25 Mar 2019 13:22:54 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:22:50 -0600
Message-Id: <20190325202250.212801-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] drm/ttm: properly unmap dma page upon failure
From:   Yu Zhao <yuzhao@google.com>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_unmap_page() must be called with exactly the same dma address
and size returned by dma_map_page(). Otherwise, the function may
fail.

This is at least the case for debug_dma_unmap_page() and AMD iommu
unmap_page callback.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/gpu/drm/ttm/ttm_page_alloc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index f841accc2c00..c1636595f63c 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -1118,10 +1118,19 @@ int ttm_populate_and_map_pages(struct device *dev, struct ttm_dma_tt *tt,
 						  0, num_pages * PAGE_SIZE,
 						  DMA_BIDIRECTIONAL);
 		if (dma_mapping_error(dev, tt->dma_address[i])) {
+			num_pages = 1;
 			while (i--) {
+				if (i && tt->ttm.pages[i] -
+					 tt->ttm.pages[i - 1] == 1) {
+					tt->dma_address[i] = 0;
+					num_pages++;
+					continue;
+				}
 				dma_unmap_page(dev, tt->dma_address[i],
-					       PAGE_SIZE, DMA_BIDIRECTIONAL);
+					       num_pages * PAGE_SIZE,
+					       DMA_BIDIRECTIONAL);
 				tt->dma_address[i] = 0;
+				num_pages = 1;
 			}
 			ttm_pool_unpopulate(&tt->ttm);
 			return -EFAULT;
-- 
2.21.0.392.gf8f6787159e-goog

