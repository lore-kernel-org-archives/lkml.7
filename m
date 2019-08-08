Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2D1C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929FC217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YnaMOI0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbfHHQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:00:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404110AbfHHQAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=emic1N5pBwSKEozMjClg8gLUqV9b7hGEYPngZUmCqiM=; b=YnaMOI0PsAMQfwt7chdmGOBbQG
        0ZHnt7n+tMRMd/8o79LcsuHafIxSlRM1SSMQfOtSkYDGEzOawBIDA+pK72yZ1K1FaMR2XNxaebXnH
        PnQ1AixagKdvzYUUvlKZYwKiFXy5r59kx7JXZVKWW1KrV1qasvazlcbTmH/vPGHaKJfMjh2E4OnTD
        hfVGXb4c6ku3o/2RJo0j8ojtZ59PPlBGClwpRiAFzgLRRaW96Mwf7rLftwORFqtnTpi9i4fdl/tMz
        +9ScBv/CMBBcU52fS7BRVFGgnutNXu0CPQfJXGl1OyOFtyHWngOI68b8niJkpJ1oO1oNX1KFNPEmM
        xj2HKXDw==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvkqK-0006lS-SV; Thu, 08 Aug 2019 16:00:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Takashi Iwai <tiwai@suse.de>, Helge Deller <deller@gmx.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Date:   Thu,  8 Aug 2019 19:00:02 +0300
Message-Id: <20190808160005.10325-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
References: <20190808160005.10325-1-hch@lst.de>
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
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 703857aab00f..9763c18e176a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -220,13 +220,12 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 {
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
 		return false;
-	/* architecture supports dma_mmap_coherent()? */
-#if defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP) || !defined(CONFIG_HAS_DMA)
-	if (!substream->ops->mmap &&
-	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
-		return false;
-#endif
-	return true;
+
+	if (substream->ops->mmap ||
+	    substream->dma_buffer.dev.type != SNDRV_DMA_TYPE_DEV)
+		return true;
+
+	return dma_can_mmap(substream->dma_buffer.dev.dev);
 }
 
 static int constrain_mask_params(struct snd_pcm_substream *substream,
-- 
2.20.1

