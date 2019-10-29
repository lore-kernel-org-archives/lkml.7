Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD40CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9446C20659
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oKJHpxq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfJ2Vem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:34:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44459 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfJ2Vek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:34:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id q16so8078977pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TR55chCCmBWkHTwfAhFnogv72SctklZSP/GTej4Kjb0=;
        b=oKJHpxq4xoQy3oSIQqwPlLB8hASIba7+d5xOsy4muSmGigScqgMUdELZWvZ5HHFkwT
         XoWdGcyAzYEeEJ1d6zU+UeWdh39zgY6BfyZIqHMDZeQrd6nrJxA1e1tjTmbiSpxwjyiY
         fy9W7C3xQpwb0B+nS/kzhr5h6dfcgynTLzuIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TR55chCCmBWkHTwfAhFnogv72SctklZSP/GTej4Kjb0=;
        b=Nro2z4H2o1yL1z854+vVJeE8y3lqFTfY2nsmYVLg3B679L5Zb1dScPCTvL+M6lQ31y
         yygQ0baiCNV/eMFzeIV97plENPQtFtjtLiaxPfook1LyibhW7O1kueUUkFVJ+5kUUA9W
         MxOZEeCfLxl6jA+8vY7PyrGzhctt/H4q9KTHElevvuGV6Hdf/cqCcdMk6QLwlyGiRsNX
         glO50rvIbZOs9vy8Nygqhur4ALTeb7n81GeI5cpaVer5O71LYTVdBk9QttSnpriuER3H
         TNhA/Kfie1d4w7kLOSQ2YjaZwK8MVvkv1ec0gGLcODtxGhfsqTO3OeXJ7NDgf8gxRxyk
         Z8Kw==
X-Gm-Message-State: APjAAAWkWaMDnff8qZCS+5rz2zeVXiCYbG7hEHa75kW0+V4AtnujbkGA
        gEvau8GfPbRNupz31inHTC5saQ==
X-Google-Smtp-Source: APXvYqxHCJjrLr8A7ARPgZhUUVZAlUD10TxDsm4B7NQrxpTzCx1dyayjY2Dpt/KCocO3c9JTZVAg7g==
X-Received: by 2002:a17:902:b703:: with SMTP id d3mr904645pls.194.1572384879122;
        Tue, 29 Oct 2019 14:34:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm72319pjq.0.2019.10.29.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:34:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dma-mapping: Add vmap checks to dma_map_single()
Date:   Tue, 29 Oct 2019 14:34:22 -0700
Message-Id: <20191029213423.28949-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029213423.28949-1-keescook@chromium.org>
References: <20191029213423.28949-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we've seen from USB and other areas[1], we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
adds vmap checks (similar to those already in USB but missing in other
places) into dma_map_single() so all callers benefit from the checking.

[1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/dma-mapping.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..54de3c496407 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	/* DMA must never operate on areas that might be remapped. */
+	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
+			  "wanted %zu bytes mapped in vmalloc\n", size)) {
+		return DMA_MAPPING_ERROR;
+	}
+
 	debug_dma_map_single(dev, ptr, size);
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
-- 
2.17.1

