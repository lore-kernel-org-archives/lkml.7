Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128CC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 22:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C3E2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 22:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O6/5T8TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfHXWuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 18:50:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfHXWuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 18:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wv1CsQX3LIg+M7myrfeQ/31wD/BQEbIvRY+D24DlEsI=; b=O6/5T8TQe1mJEH4PK7j1g3/Nuz
        7oQUV8IP4h0gEY/xcTThHfZUPMwwMc9h2YtAQiTBXbq8wKfOGBa17lOISDEqLfAgBAZ5TiId11nwQ
        EkQP6GkRhilKc6hGIeRe9dvvab8VIBvaLFVY0sKescqrz2CxeSuGkDXizLQ0Keho2u52ezH7NZ4E4
        MpvN1R2GfuqeBBMfpwu5ZzLT6v1ybMxsWr285ZuQxKqCstzJnPv13lmrEdhBDfiAj9hiiSiwyO7N5
        AvjksDLEoopLePNv72KhXr1Ra8ayakJV3FSfxXROhJ4hOPDLySc2SDyN6LaSUySW3sjGFEMyvAZWO
        1a+NkzWg==;
Received: from softbank060117181124.bbtec.net ([60.117.181.124] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i1erM-0006oX-4O; Sat, 24 Aug 2019 22:50:12 +0000
Date:   Sun, 25 Aug 2019 07:50:10 +0900
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixes for 5.3-rc
Message-ID: <20190824225010.GA18590@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-5

for you to fetch changes up to 90ae409f9eb3bcaf38688f9ec22375816053a08e:

  dma-direct: fix zone selection after an unaddressable CMA allocation (2019-08-21 07:14:10 +0900)

----------------------------------------------------------------
dma-mapping fixes for 5.3-rc

Two fixes for regressions in this merge window:

 - select the Kconfig symbols for the noncoherent dma arch helpers
   on arm if swiotlb is selected, not just for LPAE to not break then
   Xen build, that uses swiotlb indirectly through swiotlb-xen
 - fix the page allocator fallback in dma_alloc_contiguous if the CMA
   allocation fails

----------------------------------------------------------------
Christoph Hellwig (2):
      arm: select the dma-noncoherent symbols for all swiotlb builds
      dma-direct: fix zone selection after an unaddressable CMA allocation

 arch/arm/Kconfig               |  4 ++++
 arch/arm/mm/Kconfig            |  4 ----
 drivers/iommu/dma-iommu.c      |  3 +++
 include/linux/dma-contiguous.h |  5 +----
 kernel/dma/contiguous.c        |  8 ++------
 kernel/dma/direct.c            | 10 +++++++++-
 6 files changed, 19 insertions(+), 15 deletions(-)
