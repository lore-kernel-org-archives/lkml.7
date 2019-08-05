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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C6C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E212147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a62gzBHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfHEVRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:17:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42226 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:17:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so40360604pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btriHWYQu73nHxyRj0uULDI0WFupXKYE8nFpqRhUi5E=;
        b=a62gzBHN8zDS50OBhnDV1V4x7nXoRywHSroTQoVByDczAGXV3BipxjPTq01SrkbTub
         agEwfMmn44cmWjaxwPjM6J6JZpjx8WmyJxEXRnDXjNclOKeWLXUkdJVEX/MQCLvJBqtC
         K1ZxpmOSHoJ9dVfT1c362g+35YgZNJ24X+8fEyjxPJRcu8l+xY8PVNESw9BGEXx1nU94
         wqiQun9OUEuGzEM7cth+AU5ej7W/2Q3sElHfUdFCQU068818rs5agvFXmicnwPaMJR6t
         5IAlapgFz9ED0//3XPA1KmOrrKMINrpJTfgOu4sGbvQe4C1K91C5/vchqTWaSGlR7ZtT
         i/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=btriHWYQu73nHxyRj0uULDI0WFupXKYE8nFpqRhUi5E=;
        b=dH+6Z1bLNiLH43tJMwkWMut2M5EyvuW3lkmWXlddqZfREQXu5XUsDTtMzrgbmomohG
         49zqY4FmDvl4+yd6qITY3kPaYpG3m+H5KWNqqNiREBX/k9HbF36VaxdCjxlWrQV6Ue+k
         UEKM7CBr/YFpargRfwYGh0XJYk7OluEPNRPCUq58pAeoLjNXUCya/alvhVyT6OVL2Ny+
         HOETKP3Sm6Ro0JArHFLyE6vGs3rYxfr7NJHmejcAgd9n3aS8NlFy8P10vxwxQ7f2FoT6
         P6aeySCrypT/PL3GUebWU0dBUiR+B2wuHJ8DNoeqiM5zTVZ7bYHnm2dwU1jBLu6cl4zp
         JSXg==
X-Gm-Message-State: APjAAAVvsISK2UbKOnXdwq04wQIuHLE+fIbnb0mtEOU4kQrF4quGjCav
        2fQOwGVsUtwS9/Qwa32p8cY=
X-Google-Smtp-Source: APXvYqyoYl+h7ZIawCU+3W64OfYJakM+Xfc++m5kBgD7zKEdWhgVKG1NxI4zroBuK4W+iWzBAmRtUg==
X-Received: by 2002:a17:90b:8c8:: with SMTP id ds8mr20553606pjb.89.1565039825384;
        Mon, 05 Aug 2019 14:17:05 -0700 (PDT)
Received: from localhost ([100.118.89.196])
        by smtp.gmail.com with ESMTPSA id j15sm97068547pfe.3.2019.08.05.14.17.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 14:17:04 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm: add cache support for arm64
Date:   Mon,  5 Aug 2019 14:14:33 -0700
Message-Id: <20190805211451.20176-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This will let drm/msm stop abusing DMA API for cache ops, at least for
arm64.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 arch/arm64/mm/flush.c       |  2 ++
 drivers/gpu/drm/drm_cache.c | 20 +++++++++++++++++---
 include/drm/drm_cache.h     |  4 ++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index dc19300309d2..f0eb6320c979 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -93,3 +93,5 @@ void arch_invalidate_pmem(void *addr, size_t size)
 }
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 #endif
+
+EXPORT_SYMBOL_GPL(__flush_dcache_area);
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
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index 987ff16b9420..f94e7bd3eca4 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -40,6 +40,10 @@ void drm_clflush_sg(struct sg_table *st);
 void drm_clflush_virt_range(void *addr, unsigned long length);
 bool drm_need_swiotlb(int dma_bits);
 
+#if defined(CONFIG_X86) || defined(__powerpc__) || defined(CONFIG_ARM64)
+#define HAS_DRM_CACHE 1
+#endif
+
 
 static inline bool drm_arch_can_wc_memory(void)
 {
-- 
2.21.0

