Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E510C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3467720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Ahw9/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfCFW5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:57:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37566 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFW5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:57:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id u2so3240043lfd.4;
        Wed, 06 Mar 2019 14:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbUatogV1OYtO8p60xMbel10SeB8vF3N6/iddbJzbnY=;
        b=G3Ahw9/D+GKmLvjDPbIMcmjTuUjQXN5v2QPj4bDHJ/TPC1ajrtO8r7JOCpVnr3MhGa
         AHbojOME5P6fqFoyhaKFJ8xdNPv3CtR/p4wflquseE0yumSJskf3vORXiLQkIoy9j3vD
         NnSN1eNxWzcCM7sX3fsWXGV+2zctYToRPM+lpuqVhYDEmwvh4TDoMWjmbOGLjMEo6XzO
         rUm9X4HH9QadRhoamY6fPT1f8B4z8U3SyRS7G8qOSvMciTK4MFGUoUZJ9OX9KQVwGffX
         q+EThJLnBiZA7s1c5NZLqgguz05iRaWpR8EhGUiTHf3uJJDS/74JlNUpwKdm3suWGBS7
         tKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbUatogV1OYtO8p60xMbel10SeB8vF3N6/iddbJzbnY=;
        b=p+Qd/MG6pHleQWw4HEEakl5HTmgrwWhZ0ueyHn5HKV59crtcRVVHQkg3q0H9Kgvvtc
         bA0OQSnnRBpjAms4w/Ju6s4C0CVIzrASa1RC77xm7swsMrNwn7FMJOGjZPRYCvn/RVPs
         nswN8D8KEzbYLm/sT5LarxBJIFNzo6j2wC54WFLBfpUc8s6uedg9EBAxJ6Bh32WJDS9l
         Zr9tdX92f016GvjwcWG5THpeseKu3ck4U99/dvyUqPqah+b1jcIPGNsattonjmAcwG5/
         wIBOyI5Hs02UIY4XrHrumpZSRAEz8rEhu7Mhcjdpi62x8GEgABP9rQTJO8H5abuPgmyH
         cPBQ==
X-Gm-Message-State: APjAAAU+sV5CIfcH8oNEtiT4Owb9Yv26FwrDGeJ6tNkO+7o94IUToaxC
        Rnnc/HBjJD+pW5W+I/d9rSI=
X-Google-Smtp-Source: APXvYqwRyPoKx9Y4I4Ed2288fN9kjVyt+GmHuVRlsst029M8DomUo2/0aZnxaiacCjGbvHn9xBPOUg==
X-Received: by 2002:ac2:51c7:: with SMTP id u7mr5192220lfm.30.1551913023035;
        Wed, 06 Mar 2019 14:57:03 -0800 (PST)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id a196sm4833lfa.89.2019.03.06.14.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:57:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/tegra: gem: Fix CPU-cache maintenance for BO's allocated using get_pages()
Date:   Thu,  7 Mar 2019 01:55:19 +0300
Message-Id: <20190306225519.4538-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocated pages need to be invalidated in CPU caches. On ARM32 the
DMA_BIDIRECTIONAL flag only ensures that data is written-back to DRAM and
the data stays in CPU cache lines. While the DMA_FROM_DEVICE flag ensures
that the corresponding CPU cache lines are getting invalidated and nothing
more, that's exactly what is needed for a newly allocated pages.

This fixes randomly failing rendercheck tests on Tegra30 using the
Opentegra driver for tests that use small-sized pixmaps (10x10 and less,
i.e. 1-2 memory pages) because apparently CPU reads out stale data from
caches and/or that data is getting evicted to DRAM at the time of HW job
execution.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 4f80100ff5f3..4cce11fd8836 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -204,7 +204,7 @@ static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 {
 	if (bo->pages) {
 		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			     DMA_BIDIRECTIONAL);
+			     DMA_FROM_DEVICE);
 		drm_gem_put_pages(&bo->gem, bo->pages, true, true);
 		sg_free_table(bo->sgt);
 		kfree(bo->sgt);
@@ -230,7 +230,7 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 	}
 
 	err = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			 DMA_BIDIRECTIONAL);
+			 DMA_FROM_DEVICE);
 	if (err == 0) {
 		err = -EFAULT;
 		goto free_sgt;
-- 
2.20.1

