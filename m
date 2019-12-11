Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F42FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051CD20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080485;
	bh=TXhQgINiiHOmO+dIBob4x0n3LWwuAWVeGsy7mnGnAgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KC9B8aib1nbAg21grcdS9Ag3o6Mroyhgwp9W5WJvoJY/uFBIvkuoZepU8wzfo9a6K
	 HF/cgWDwt3bEiffss1WbCBgpuP1aEfUKT+V61FxDS0DvGDQ2fKdFSIuATBLCGwX/lj
	 d/UepJYBIWihVuun/YsXeA3mAzO8SGI/ucyLJn1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbfLKQID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbfLKPMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:12:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B7A2467A;
        Wed, 11 Dec 2019 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077142;
        bh=TXhQgINiiHOmO+dIBob4x0n3LWwuAWVeGsy7mnGnAgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZpNZU3o+oK+g5YzeB7QNOY2RQRJhHkwZ8Jfyx4UqMezedDANTrO34VNeq0V7M4MZn
         4Qkaqbu9lQHSTQNniwjmF8VN7SEK2wZltuyfeY06MWmaaRHokkoTKDAAGQ2kPTbAA+
         3mYRfZTQG911aKmXAIZMck46OH//wKV1yczP8gkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 029/134] dma-mapping: Add vmap checks to dma_map_single()
Date:   Wed, 11 Dec 2019 10:10:05 -0500
Message-Id: <20191211151150.19073-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 4544b9f25e70eae9f70a243de0cc802aa5c8cb69 ]

As we've seen from USB and other areas[1], we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
adds vmap checks (similar to those already in USB but missing in other
places) into dma_map_single() so all callers benefit from the checking.

[1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
[hch: fixed the printk message]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dma-mapping.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475ad..0aad641d662c3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,6 +583,10 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	/* DMA must never operate on areas that might be remapped. */
+	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
+			  "rejecting DMA map of vmalloc memory\n"))
+		return DMA_MAPPING_ERROR;
 	debug_dma_map_single(dev, ptr, size);
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
-- 
2.20.1

