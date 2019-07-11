Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008F2C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314C2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 03:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEJ2OiHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfGKDKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 23:10:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38701 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:10:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so2185458pgz.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 20:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rIHV6cPDPKhX9jkZyhvnHZiEyAQlrV5sCTvAq/yF72U=;
        b=gEJ2OiHD3xfsyfhhrIHY7acOsv6Qmhq6okCyaEE6s5QGewpmPiMaVqagAoR5/gZE6R
         gGoOxfOGyeeT0QzUltFU3Z4VTps64FBwoPj7DswM5ZiwD9XcG5qcPLhM1URwPJLSibWp
         Xx5mt9DSFkUnFcfXbXS//GfIi46AfHy/Bg5kHjHL2Wr+CDUpgpeFbGYKGLiP4Kt8xvLg
         06zNoJiw+kAAm50bmLvuALPrWB0YCutV3YMeywHvZyQqaaXLlpdMVL897OxRjBoNJqEx
         Rb9UriVejde7CpAhZ/6hPnRFchFtkO2c3j56UTY0GP6NAPi1I+dMR6JkIMLXMiQN7s4C
         +z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rIHV6cPDPKhX9jkZyhvnHZiEyAQlrV5sCTvAq/yF72U=;
        b=kf+v7qoWB8qbnvj8eHxoVo6GJpbzzMslQecAN7zfbh3Bj/75jX5KdGMm4vBTeIgms2
         Q31NIhVIuDWUNS2Cj19JUbq00OLuUcxqTSO8dttjrcQJ1awCCN1B/7xAbHm7wPFJcJEN
         zcSRKtceROeoKl7sLPwzBBj1e9mBvclEe4zlpo0a0iovvMjchh9T0NBAmiKjtVLIlEHH
         y4+D+IP+DqxgJ4qixcznGhFBTCnwcLvhffIFwFehJ9fdxqeH0m6cHUB0kdcZW0uofXSu
         t+TacnmwgNoltA6TAWZOjeyXU7rZjpLEsSEULYaJAtmRgeFbfKz1w6lOFOJPGrozn0Sv
         FZUA==
X-Gm-Message-State: APjAAAXH+lGQzzVVRWi0V+Wb9uJNVwdCDESbSHDwAkPr5igaz9J1Fyt+
        1J8vfXVFSMKPMMP2813OzyRhFeQr84s=
X-Google-Smtp-Source: APXvYqxvo8BxIF61S1ZT84fFK4re4Ii9aN+zdDpPdZpPAiFOokGPgqqw0oTyzCS7WT7S/oCgl7+G2A==
X-Received: by 2002:a17:90a:23a4:: with SMTP id g33mr2077739pje.115.1562814630577;
        Wed, 10 Jul 2019 20:10:30 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 65sm4043082pff.148.2019.07.10.20.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 20:10:29 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 1/2] drm/ttm: use the same attributes when freeing d_page->vaddr
Date:   Thu, 11 Jul 2019 11:10:21 +0800
Message-Id: <20190711031021.23512-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __ttm_dma_alloc_page(), d_page->addr is allocated
by dma_alloc_attrs() but freed with use dma_free_coherent() in
__ttm_dma_free_page().
Use the correct dma_free_attrs() to free d_page->vaddr.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index d594f7520b7b..7d78e6deac89 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -285,9 +285,13 @@ static int ttm_set_pages_caching(struct dma_pool *pool,
 
 static void __ttm_dma_free_page(struct dma_pool *pool, struct dma_page *d_page)
 {
+	unsigned long attrs = 0;
 	dma_addr_t dma = d_page->dma;
 	d_page->vaddr &= ~VADDR_FLAG_HUGE_POOL;
-	dma_free_coherent(pool->dev, pool->size, (void *)d_page->vaddr, dma);
+	if (pool->type & IS_HUGE)
+		attrs = DMA_ATTR_NO_WARN;
+
+	dma_free_attrs(pool->dev, pool->size, (void *)d_page->vaddr, dma, attrs);
 
 	kfree(d_page);
 	d_page = NULL;
-- 
2.11.0

