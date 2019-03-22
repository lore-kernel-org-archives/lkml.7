Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D803DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23592070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257790;
	bh=7tZkvRCcrdfTnBGnYmkgnAnJEGxeASGr6fz4vnoQ0NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QWNcbMlmS8XGIUaANVseJ+eWzzTT0BJnqVtBOWOhhk2kBqFdTYbJM+SSBl9QkbamN
	 bakwyv62DgqpTaJ0yIco8Sb2KI84eHNTAg1DldswYQirAt+sj+i1YVDMCMgsTYO7z3
	 JVZpzfaS+5TpUKd5QwA1pdkSvEIUpX3spvFUuW3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbfCVM3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389798AbfCVMSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48DFC2082C;
        Fri, 22 Mar 2019 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257129;
        bh=7tZkvRCcrdfTnBGnYmkgnAnJEGxeASGr6fz4vnoQ0NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uy92EwWVUmd2OSUzxZ16ZY5crcUqeqt2yKYIFYeaZUXJtRR1LcmG6/URU+eiTFmeL
         SnKezgm9mSUMHiO28dXtMTrrpMT5Uq2dIRdnh+2wVeeWa/jiN555g0FnUvfF37esKO
         AvxVD0TUtAVS/BkiwzvdvqhR6AdHKL/YgMVH+yf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.0 124/238] dma: Introduce dma_max_mapping_size()
Date:   Fri, 22 Mar 2019 12:15:43 +0100
Message-Id: <20190322111305.835827654@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joerg Roedel <jroedel@suse.de>

commit 133d624b1cee16906134e92d5befb843b58bcf31 upstream.

The function returns the maximum size that can be mapped
using DMA-API functions. The patch also adds the
implementation for direct DMA and a new dma_map_ops pointer
so that other implementations can expose their limit.

Cc: stable@vger.kernel.org
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/DMA-API.txt   |    8 ++++++++
 include/linux/dma-mapping.h |    8 ++++++++
 kernel/dma/direct.c         |   11 +++++++++++
 kernel/dma/mapping.c        |   14 ++++++++++++++
 4 files changed, 41 insertions(+)

--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -195,6 +195,14 @@ Requesting the required mask does not al
 wish to take advantage of it, you should issue a dma_set_mask()
 call to set the mask to the value returned.
 
+::
+
+	size_t
+	dma_direct_max_mapping_size(struct device *dev);
+
+Returns the maximum size of a mapping for the device. The size parameter
+of the mapping functions like dma_map_single(), dma_map_page() and
+others should not be larger than the returned value.
 
 Part Id - Streaming DMA mappings
 --------------------------------
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,6 +130,7 @@ struct dma_map_ops {
 			enum dma_data_direction direction);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
+	size_t (*max_mapping_size)(struct device *dev);
 };
 
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
@@ -257,6 +258,8 @@ static inline void dma_direct_sync_sg_fo
 }
 #endif
 
+size_t dma_direct_max_mapping_size(struct device *dev);
+
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
 
@@ -460,6 +463,7 @@ int dma_supported(struct device *dev, u6
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
+size_t dma_max_mapping_size(struct device *dev);
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -561,6 +565,10 @@ static inline u64 dma_get_required_mask(
 {
 	return 0;
 }
+static inline size_t dma_max_mapping_size(struct device *dev)
+{
+	return 0;
+}
 #endif /* CONFIG_HAS_DMA */
 
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -380,3 +380,14 @@ int dma_direct_supported(struct device *
 	 */
 	return mask >= __phys_to_dma(dev, min_mask);
 }
+
+size_t dma_direct_max_mapping_size(struct device *dev)
+{
+	size_t size = SIZE_MAX;
+
+	/* If SWIOTLB is active, use its maximum mapping size */
+	if (is_swiotlb_active())
+		size = swiotlb_max_mapping_size(dev);
+
+	return size;
+}
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -357,3 +357,17 @@ void dma_cache_sync(struct device *dev,
 		ops->cache_sync(dev, vaddr, size, dir);
 }
 EXPORT_SYMBOL(dma_cache_sync);
+
+size_t dma_max_mapping_size(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	size_t size = SIZE_MAX;
+
+	if (dma_is_direct(ops))
+		size = dma_direct_max_mapping_size(dev);
+	else if (ops && ops->max_mapping_size)
+		size = ops->max_mapping_size(dev);
+
+	return size;
+}
+EXPORT_SYMBOL_GPL(dma_max_mapping_size);


