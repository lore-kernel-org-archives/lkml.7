Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E53C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF7214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9i4/VXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfJJW2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:28:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45604 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfJJW2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:28:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so3367879pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OcjzQsF45hEBxamHjzpQj8tPOdjVhqexrCUuTV+HOUI=;
        b=T9i4/VXlqHD33x2rdbjhCXLVnQ+qG4Uv18788Nx+nq3IggKPThAsPRLeMaplN5ymQr
         tzgwE5GOtA7J3878fNnL1gGphXBatCnK/iXdn7Td14FdsZdDFE++iYuGFaldSRcvcJ+V
         Lk1LJRRoXS9JwC/Vu3Z12UPnLUhvIT3Svk7rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OcjzQsF45hEBxamHjzpQj8tPOdjVhqexrCUuTV+HOUI=;
        b=CPgc0QrZeqe4WLEK98daIGalvURTHXvqRs82PzIAHYmzsyrTPItsNE/4zRfYlmZq54
         jX3mdRi+pxdMC23dZGV2PM/LpBSkA9ueJ3vHCE9DUnhio7SwVx8ZHrcJvjtB+wnLxKn4
         E1Do6O9EWVCc3DUQ92MG7sjRYpWKY4Xd4EM5hfObinhrAIHJOy2hySb9y591jrXZ2GAW
         EcQcKS53VuxZqbDQc2uzQ9AoYQbNdHzUjL9jjR5nqQvJNhUXQKWnHIsAD/3KqXy+gy9d
         uf4Ibby53xnj/RCK1ZnDeX+dnet4bVsDNk4F/eEvHO+VRerHEmeAMXL/j8R8e+PPGGIt
         ZeQw==
X-Gm-Message-State: APjAAAWjZjH71UjhJeBky20y4IvniAnWrmpiBersnqkXpDJaPRGqMXZe
        9cUVUAxro2CmCeV+0Q4d7pM7ag==
X-Google-Smtp-Source: APXvYqy0miqiQgwRV6iDS1mfqG6ZXytFWuqANBgQeUkcZkLlYk8skOUQdwGEmFZ5Nxpllc2qQsqrjg==
X-Received: by 2002:a62:2501:: with SMTP id l1mr13115257pfl.148.1570746518172;
        Thu, 10 Oct 2019 15:28:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m5sm6948794pgt.15.2019.10.10.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 15:28:36 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dma-mapping: Add vmap checks to dma_map_single()
Date:   Thu, 10 Oct 2019 15:28:28 -0700
Message-Id: <20191010222829.21940-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010222829.21940-1-keescook@chromium.org>
References: <20191010222829.21940-1-keescook@chromium.org>
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
index 4a1c4fca475a..ff4e91c66f44 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	/* DMA must never operate on areas that might be remapped. */
+	if (unlikely(is_vmalloc_addr(ptr))) {
+		dev_warn_once(dev, "bad map: %zu bytes in vmalloc\n", size);
+		return DMA_MAPPING_ERROR;
+	}
+
 	debug_dma_map_single(dev, ptr, size);
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
-- 
2.17.1

