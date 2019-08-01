Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64863C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA5A2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gs6eJLcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfHAOVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:21:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfHAOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o3McWM/2bHyYOyL1mFZJ/4Q0USrtCE0kV4BVYCLDzEY=; b=Gs6eJLcnWsNhmKTj7X+mSbYPe
        sWN22x7cdspZVuBOb/sWdUdPLhLBDtpvcboWjDhtNcMhLNRBsMfY6by3qN+lcy3LRZiUTk0N+2HWP
        kOMZJFvxoPcRRNE0uvjE3622yufdZBOfEmuk+pAqJ8990LoLVBjJVTweC5ML2/fcSI/I5yQk9xkzC
        DXo9lzPx4qs2+vDYwixYfvb2WsV3i/so3GWZx5jh//NyzYZwmzw2WyL3kD9ImGZ15MoGVv0+nXyc2
        pqAha+cjJpUedSiG3zLHHfWNCMILWDl3fGMNdumhlKXZRRXsvXSn/qs7h+oJomhUXmSe+q3FHmFnl
        YsYxtSn1Q==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htBxQ-0006JC-Ow; Thu, 01 Aug 2019 14:21:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: fix default dma_mmap_* pgprot
Date:   Thu,  1 Aug 2019 17:21:17 +0300
Message-Id: <20190801142118.21225-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As Shawn pointed out we've had issues with the dma mmap pgprots ever
since the dma_common_mmap helper was added beyong the initial
architectures - we default to uncached mappings, but for devices that
are DMA coherent, or if the DMA_ATTR_NON_CONSISTENT is set (and
supported) this can lead to aliasing of cache attributes.  This patch
fixes that.  My explanation of why this hasn't been much of an issue
is that the dma_mmap_ helpers aren't used widely and mostly just in
architecture specific drivers.
