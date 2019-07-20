Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CFC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F22084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TYB3ehpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfGTR3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 13:29:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfGTR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 13:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4u1UOOluIxzpChbBbBSB5WjUOAsP++Ttncv2ljBjqr4=; b=TYB3ehpK45DbHzMLjElDZFdEgT
        BWsGY7vVVkBDsGd5ZwN28+yzOtO3hPDvoWtQfoG3dCbG0IcuYyw8DlIfFMN0ySS1i6HepXsVr1T9f
        KWrM3efShVAhHknbh4NIlzbH8t46Wj+wz/jl7uxEOPgdbl4FsSbdliD6VAnfdf+V8fQbyHnqjXjk+
        JVcCumn9IhxkbYuqXsJkPnucLp4tvwS0My2jZGSycB8/qtK6VTkPX3i4JHeHa3vi64HhbusL5Ruat
        oP63hhsz2KQsg1q/XJEqKEBArPQZFy7l7/9hYw0IqglTvwtqEWnNEw9gjCKT6XYdYWmkKuQLr0OLl
        32QaUt0A==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hotAX-0004Zo-Pi; Sat, 20 Jul 2019 17:29:14 +0000
Date:   Sat, 20 Jul 2019 19:29:11 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixes for 5.3
Message-ID: <20190720172911.GA11099@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9637d517347e80ee2fe1c5d8ce45ba1b88d8b5cd:

  Merge tag 'for-linus-20190715' of git://git.kernel.dk/linux-block (2019-07-15 21:20:52 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-1

for you to fetch changes up to 449fa54d6815be8c2c1f68fa9dbbae9384a7c03e:

  dma-direct: correct the physical addr in dma_direct_sync_sg_for_cpu/device (2019-07-19 14:09:40 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.3-rc1

Fix various regressions:

 - force unencrypted dma-coherent buffers if encryption bit can't fit
   into the dma coherent mask (Tom Lendacky)
 - avoid limiting request size if swiotlb is not used (me)
 - fix swiotlb handling in dma_direct_sync_sg_for_cpu/device
   (Fugang Duan)

----------------------------------------------------------------
Christoph Hellwig (2):
      dma-mapping: add a dma_addressing_limited helper
      dma-direct: only limit the mapping size if swiotlb could be used

Fugang Duan (1):
      dma-direct: correct the physical addr in dma_direct_sync_sg_for_cpu/device

Tom Lendacky (1):
      dma-direct: Force unencrypted DMA under SME for certain DMA masks

 arch/s390/Kconfig           |  1 +
 arch/s390/mm/init.c         |  7 ++++++-
 arch/x86/Kconfig            |  1 +
 arch/x86/mm/mem_encrypt.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/dma-direct.h  |  9 +++++++++
 include/linux/dma-mapping.h | 14 ++++++++++++++
 kernel/dma/Kconfig          |  3 +++
 kernel/dma/direct.c         | 44 +++++++++++++++++++-------------------------
 8 files changed, 83 insertions(+), 26 deletions(-)
