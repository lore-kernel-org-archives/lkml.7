Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C53F20863
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uk740Zif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEIHRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:17:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfEIHRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n2162wdlBrQIOUPLB7f2xIUVw2pG4qMesu/oB9VnM1U=; b=Uk740ZifxhcQUjkMGUtNCCuZu
        Y87Refm+GmE6UR5JsholTT/PhP3N4OqDuXsL28GAVz4252oycY62vzOLiD9sW3HLqI6+8o5sPvY/i
        LWFmBP3j8VmB/5maPXTai1AKt6bk1FyGlsPjEKgvkZ4jnoO/ui5WdYVqlT0IjuqD8YWcAxRqsdnIC
        fVUiDGacrBOvdh6uFVqv2De6yZ2eoHzrMnheUM4A5AkBEw2ydbPxhvvp1inL5+sU3vtZdjW4Bemzs
        hnsSJnCCyLZURVichgD2WjUEo9S/YWJ9j/WRVAtjBZJnvBRaSkWzSAHuFjXpaDZoUE3Wdh+k/s/eG
        wcgMaFRfA==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOdIq-0004T1-1W; Thu, 09 May 2019 07:17:16 +0000
Date:   Thu, 9 May 2019 09:16:34 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] DMA mapping updates for 5.2
Message-ID: <20190509071634.GA604@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a pretty small DMA mapping updates for this merge window below:


The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.2

for you to fetch changes up to 13bf5ced93775ffccb53527a9d862e023a9daa03:

  dma-mapping: add a Kconfig symbol to indicate arch_dma_prep_coherent presence (2019-05-06 15:04:40 +0200)

----------------------------------------------------------------
DMA mapping updates for 5.2

 - remove the already broken support for NULL dev arguments to the
   DMA API calls
 - Kconfig tidyups

----------------------------------------------------------------
Christoph Hellwig (8):
      parport_ip32: pass struct device to DMA API functions
      da8xx-fb: pass struct device to DMA API functions
      gbefb: switch to managed version of the DMA allocator
      pxa3xx-gcu: pass struct device to dma_mmap_coherent
      arm: use a dummy struct device for ISA DMA use of the DMA API
      dma-mapping: remove leftover NULL device support
      x86/dma: Remove the x86_dma_fallback_dev hack
      dma-mapping: add a Kconfig symbol to indicate arch_dma_prep_coherent presence

Clément Leger (1):
      dma: select GENERIC_ALLOCATOR for DMA_REMAP

Dan Carpenter (1):
      dma-mapping: remove an unnecessary NULL check

 Documentation/DMA-API-HOWTO.txt    | 13 ++++++-------
 arch/arm/kernel/dma-isa.c          |  8 +++++++-
 arch/arm/mach-rpc/dma.c            |  8 +++++++-
 arch/arm64/Kconfig                 |  1 +
 arch/csky/Kconfig                  |  1 +
 arch/x86/include/asm/dma-mapping.h | 10 ----------
 arch/x86/kernel/amd_gart_64.c      |  6 ------
 arch/x86/kernel/pci-dma.c          | 20 --------------------
 drivers/parport/parport_ip32.c     | 18 ++++++++++--------
 drivers/video/fbdev/da8xx-fb.c     | 13 +++++++------
 drivers/video/fbdev/gbefb.c        | 24 ++++++++----------------
 drivers/video/fbdev/pxa3xx-gcu.c   |  4 +++-
 include/linux/dma-mapping.h        |  6 +++---
 include/linux/dma-noncoherent.h    |  6 ++++++
 kernel/dma/Kconfig                 |  4 ++++
 kernel/dma/direct.c                |  2 +-
 kernel/dma/mapping.c               |  9 +--------
 17 files changed, 65 insertions(+), 88 deletions(-)
