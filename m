Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB12C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A06D20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZbeCYiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfG3XBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:01:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35551 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfG3XBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:01:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so24511544pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkytYeH7M66nBAoxCQa0bNBGsymk7oY3s7W/ud/aulQ=;
        b=lZbeCYiFHn/t0t6F+ChT5unZY+5uTZKrCGEloLfqvJgD+wwHI7PM6JvcurR3hXG0Yg
         FMyzS5zW3wvGb777PQdA0k1hEHTHyqRgLpfFbmW4JVAnjrPaoPAEeXmDM58BkL8XK+hW
         iCIuaoLH7nMJLLtfhpc0edA6bMMyhCI3DycK/lsZZMyh4E1cxu9gTvcEorjrYA4GRRrq
         4DN1fYDeJ4v6M16KMwtAs4FJa9BE5ha1Qbku48nNtZiy7QxrvrFzs8ASeloSiz8j6jxq
         9JU8uwsvKDTAXzHxc8WM3Y2jpnwxZoLmw5yzswesSEUt4z03NbPtksue8thNq0HpmxCN
         4omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkytYeH7M66nBAoxCQa0bNBGsymk7oY3s7W/ud/aulQ=;
        b=ACTdwmVAXauDnjyGshZXvrPZ5v8SgMm8J1a5hZWC9TGVShGfxkeA67ZbOkAgUTSuCY
         cskeP+pN/YHuS3hfJWLGdOuuh8fFZvsniYFAc+dlmw4iZR3EBOFySUn1cnlMz/LrLLG8
         SxN4e5j3Fi5Bz995Kg5m3nID0ZwEJvYyxTQtLOILgSuubnspdgwvVM4K/SRZXWi8kO8I
         DoGA+phUv6TBCKFRqNExuytTvyPF/5xtdB79pXhuE4gXeFqm4ksHxnFf3ZbWqok/gGWp
         PsgWFguJoI5DWIzoAnub6a7pGaCatfV/28oZWoKP+MjbZmTN7zXqiP1r4v41uERYrWTo
         13/g==
X-Gm-Message-State: APjAAAXNEJUCNdZ8gATIdbh8r0LSYjQxhiPYJtoP/9g+O1ZxC55qsGuw
        vrtfsHZ2B+F7IhUK4NJhRHc=
X-Google-Smtp-Source: APXvYqxZB4H2ozpiUg+eNXM9lA/nk8Bx4kCAQNMkihvOXk6znIkuChUDwYlzk05yBdkdNw5K835/HQ==
X-Received: by 2002:a62:87c8:: with SMTP id i191mr44314801pfe.133.1564527668085;
        Tue, 30 Jul 2019 16:01:08 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id q22sm60432615pgh.49.2019.07.30.16.01.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 16:01:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: add cache support for arm64
Date:   Tue, 30 Jul 2019 15:58:46 -0700
Message-Id: <20190730225852.30319-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Not sure about 32b arm, but at least for aarch64 this is relatively
easy.  So lets at least enable for arm64.

 drivers/gpu/drm/drm_cache.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 3bd76e918b5d..90105c637797 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -69,6 +69,14 @@ static void drm_cache_flush_clflush(struct page *pages[],
 }
 #endif
 
+#if defined(__powerpc__)
+static void __flush_dcache_area(void *addr, size_t len)
+{
+	flush_dcache_range((unsigned long)addr,
+			   (unsigned long)addr + PAGE_SIZE);
+}
+#endif
+
 /**
  * drm_clflush_pages - Flush dcache lines of a set of pages.
  * @pages: List of pages to be flushed.
@@ -90,7 +98,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 	if (wbinvd_on_all_cpus())
 		pr_err("Timed out waiting for cache flush\n");
 
-#elif defined(__powerpc__)
+#elif defined(__powerpc__) || defined(CONFIG_ARM64)
 	unsigned long i;
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = pages[i];
@@ -100,8 +108,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 			continue;
 
 		page_virtual = kmap_atomic(page);
-		flush_dcache_range((unsigned long)page_virtual,
-				   (unsigned long)page_virtual + PAGE_SIZE);
+		__flush_dcache_area(page_virtual, PAGE_SIZE);
 		kunmap_atomic(page_virtual);
 	}
 #else
@@ -135,6 +142,13 @@ drm_clflush_sg(struct sg_table *st)
 
 	if (wbinvd_on_all_cpus())
 		pr_err("Timed out waiting for cache flush\n");
+#elif defined(CONFIG_ARM64)
+	struct sg_page_iter sg_iter;
+
+	for_each_sg_page(st->sgl, &sg_iter, st->nents, 0) {
+		struct page *p = sg_page_iter_page(&sg_iter);
+		drm_clflush_pages(&p, 1);
+	}
 #else
 	pr_err("Architecture has no drm_cache.c support\n");
 	WARN_ON_ONCE(1);
-- 
2.21.0

