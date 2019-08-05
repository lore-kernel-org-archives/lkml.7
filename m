Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582C6C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250C72067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sd4QHDwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfHEJNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:13:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfHEJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=r7VigzYU3BuHUi2BBP1jIMsKqnBbu0+Xmxj4lDWNmG0=; b=Sd4QHDwuC8t+6vutznxfjeQukI
        02e7uLEYeS7f/4D+3POuYv4ZxgWMNVY7eDp6J7tleaoYU7pppL8xXSM6f81jDZVjJTLDl22ru67IU
        f4gkXp/yZcv9v0g6Fe0e6IpRC8jSvYiygY/FH5YpQ7cEhg+2bqRMibPUsHrhM1CkxwgHILjqwKIjr
        w9S/Ulsek9D8832JzD+E1gwns8BTtn/sJUlKJf0FgkxU8wSe/i/Pt3Ogoo/zqFupnMC400hE/3RW6
        02BmOfALUs2NKEFGJNMHjow/YYbsDC0A9FZEEd6mweswxwTRO0uOaFyhTGmmbxcsxHZurxCwtQotm
        Oy4PGlhw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huZ2L-0004ys-Hw; Mon, 05 Aug 2019 09:12:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Date:   Mon,  5 Aug 2019 12:11:56 +0300
Message-Id: <20190805091159.7826-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805091159.7826-1-hch@lst.de>
References: <20190805091159.7826-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the local hack with the dma_can_mmap helper to check if
a given device supports mapping DMA allocations to userspace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/core/pcm_native.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 703857aab00f..81c82c3ee8a2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -220,12 +220,11 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 {
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
 		return false;
-	/* architecture supports dma_mmap_coherent()? */
-#if defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP) || !defined(CONFIG_HAS_DMA)
+	if (!dma_can_mmap(substream->dma_buffer.dev.dev))
+		return false;
 	if (!substream->ops->mmap &&
 	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
 		return false;
-#endif
 	return true;
 }
 
-- 
2.20.1

