Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FFCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01F4206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g8x5ga3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHNOMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:12:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wNAotc+YfObYMHP+Et0cYpre0RXPoOPUScnc71ZCCN0=; b=g8x5ga3zG8Qv34oZE7poH84sBC
        weQ4xKIdYW1uBiZvAi38+jHi7uhUVbCd7caX/PXGsYG499S5EPoqXtafuRTvX2gaYI8KdwtYWLrLV
        waRjmLUNjrpsPohrrzwMnLElKv6YbVQ0W61u8ItYI/Omt0nLuUSb+sgTNLxJkA2YLl9dC3XvUOjPy
        vzfa4HonzfPevyJ9+tBbnZuYyh4pXjURzJTSASFQliQ4Vce31WsWxc2APNcDX63BqUgTY6nyWwAO4
        QgIah0qTHyVyyNssaKO/MYA90fgTkMS9q67Fl7oEWs/8JEDUXXJwOoORd/gh7AimMiEavdBXyTZw3
        gq1tehMQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxu0h-0004We-6a; Wed, 14 Aug 2019 14:12:19 +0000
Date:   Wed, 14 Aug 2019 16:12:17 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma mapping fixes for 5.3-rc
Message-ID: <20190814141217.GA3792@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 451577f3e3a9bf1861218641dbbf98e214e77851:

  Merge tag 'kbuild-fixes-v5.3-3' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2019-08-09 20:31:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-4

for you to fetch changes up to 33dcb37cef741294b481f4d889a465b8091f11bf:

  dma-mapping: fix page attributes for dma_mmap_* (2019-08-10 19:52:45 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.3-rc

 - fix the handling of the bus_dma_mask in dma_get_required_mask, which
   caused a regression in this merge window (Lucas Stach)
 - fix a regression in the handling of DMA_ATTR_NO_KERNEL_MAPPING (me)
 - fix dma_mmap_coherent to not cause page attribute mismatches on
   coherent architectures like x86 (me)

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
      dma-mapping: fix page attributes for dma_mmap_*

Lucas Stach (1):
      dma-direct: don't truncate dma_required_mask to bus addressing capabilities

 arch/arm/mm/dma-mapping.c        |  4 +---
 arch/arm64/mm/dma-mapping.c      |  4 +---
 arch/powerpc/Kconfig             |  1 -
 arch/powerpc/kernel/Makefile     |  3 +--
 arch/powerpc/kernel/dma-common.c | 17 -----------------
 drivers/iommu/dma-iommu.c        |  6 +++---
 include/linux/dma-noncoherent.h  | 13 +++++++++----
 kernel/dma/direct.c              | 10 +++++-----
 kernel/dma/mapping.c             | 19 ++++++++++++++++++-
 kernel/dma/remap.c               |  2 +-
 10 files changed, 39 insertions(+), 40 deletions(-)
 delete mode 100644 arch/powerpc/kernel/dma-common.c
