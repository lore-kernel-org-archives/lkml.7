Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8D0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F97D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udJV5gKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfHEVVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:21:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32928 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfHEVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:21:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so5242731pgn.0;
        Mon, 05 Aug 2019 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OeBQSmDe1xB3j4rFO2BJAt14X15aBZMOVJCfaHc6LY=;
        b=udJV5gKYkc67MZOEO3IGRVgW8n6V52TOvRmHEDWyme7dORPIgCmmqhH0J80IivOTKd
         yYMTe21ojN4bSKOnAtli2KxUhxAlsSGM2zTXSr//TjRHeOnx6vaheXxV4T/F0cOg3GOu
         Ni3sX0FkoAE3Sb0p4TenKRIaI3ByAyb4kpXO3cwwDvpA8nt5UnBWoyaLWu3g1BZOw4kJ
         XGKcBL2PS0gPWQ3hLP0V4pDoOltHcAd0IPqoJtk0cJdFVLZNzaR+Knw8MsIILKpn/hCq
         bXimrChiXBHpwucZLtnbis6QC9JuSjGhVZUPyI5IXQPfT2Cnaf730fDwr6BIjxT0ZF+/
         phjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OeBQSmDe1xB3j4rFO2BJAt14X15aBZMOVJCfaHc6LY=;
        b=MsnC4aSJDDFWo/0fvmfYOqgVAT4U3JGkOsc5FfTRGUZ4hq3Cd7e+Y277fFXXkyvjyd
         BzdHxGnmr+yNWHxYgg1W14I5vKy7WiOxanAGNty+MkMPG0QjcF1QelZgLDm62e16ri1Z
         avpdbao3jYsDEizTbSNNqm9w/oSYABiEx6Y1U/qIkUh/4MvcZr24SOhftnfV2K1mnnXY
         gKF2l0IOhudhES4vW+6eHp8ig0KVHU78OuFpje+kDLsjWyv6Gmzo3JzckcbJkwMj0lsL
         LWpekoOHZ+uzndfcpdBkiNd3rwELV3G2TC/6WbwrRkjh0qKZyvnPPwrlWOcIZwuDNapA
         x0YA==
X-Gm-Message-State: APjAAAVuPT8/vtlc5lDdVjFoq9MPrjFcuo1zoXJgEC+zPdjBkx4LEYe/
        xPy7xsT9QsJfgfvHyJUC2Vk=
X-Google-Smtp-Source: APXvYqzYkbGeZQnOUdtCfiR5eVyf9faEZUVFiJdOsNaNr95dPgUihphNyzw+oDlds8tspfo+6KC2Pg==
X-Received: by 2002:a63:f941:: with SMTP id q1mr139140666pgk.350.1565040099484;
        Mon, 05 Aug 2019 14:21:39 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id r12sm66910903pgb.73.2019.08.05.14.21.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 14:21:38 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/msm: use drm_cache when available
Date:   Mon,  5 Aug 2019 14:14:34 -0700
Message-Id: <20190805211451.20176-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190805211451.20176-1-robdclark@gmail.com>
References: <20190805211451.20176-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

For a long time drm/msm had been abusing dma_map_* or dma_sync_* to
clean pages for buffers with uncached/writecombine CPU mmap'ings.

But drm/msm is managing it's own iommu domains, and really doesn't want
the additional functionality provided by various DMA API ops.

Let's just cut the abstraction and use drm_cache where possible.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 8cf6362e64bf..af19ef20d0d5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -9,6 +9,8 @@
 #include <linux/dma-buf.h>
 #include <linux/pfn_t.h>
 
+#include <drm/drm_cache.h>
+
 #include "msm_drv.h"
 #include "msm_fence.h"
 #include "msm_gem.h"
@@ -48,6 +50,7 @@ static bool use_pages(struct drm_gem_object *obj)
 
 static void sync_for_device(struct msm_gem_object *msm_obj)
 {
+#if !defined(HAS_DRM_CACHE)
 	struct device *dev = msm_obj->base.dev->dev;
 
 	if (get_dma_ops(dev)) {
@@ -57,10 +60,14 @@ static void sync_for_device(struct msm_gem_object *msm_obj)
 		dma_map_sg(dev, msm_obj->sgt->sgl,
 			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
 	}
+#else
+	drm_clflush_sg(msm_obj->sgt);
+#endif
 }
 
 static void sync_for_cpu(struct msm_gem_object *msm_obj)
 {
+#if !defined(HAS_DRM_CACHE)
 	struct device *dev = msm_obj->base.dev->dev;
 
 	if (get_dma_ops(dev)) {
@@ -70,6 +77,7 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
 		dma_unmap_sg(dev, msm_obj->sgt->sgl,
 			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
 	}
+#endif
 }
 
 /* allocate pages from VRAM carveout, used when no IOMMU: */
-- 
2.21.0

