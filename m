Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152702075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RLo5EPop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfC0IFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:05:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfC0IFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YTimLkmVGcosS08x++tA4YThRjiAJsplcLRxVuPtfT0=; b=RLo5EPopwT3zOugjw20h0YJRo
        h/Nr/PB7yxc/s3yo27RivAFMFCAxnc+oOQB4yP5d8r+AaGfqkx/mfzFO2xTmnc333UyT4zvtjnEKU
        nWKVWebJFwPSUXQPrkZs3+zEh+vdu5lrdwsy91vfNBJ7AZu8DJ4Kfsw3U27gnvonklP5hRDKDO5XC
        +J+hcAEH2oAr8h0mx/HmxjI1sJlSalHiWj25cEjfJvY3/zN6wFGwD7u2aQF87Z8g4Y0PO+dRxnOtS
        74G65fcDAIKB9j/wKnDQEk/WU3FV/utnMLViMxYW4UpcQVzIRGq2B6SwmULe+JlBBBHz2yiHtmlz9
        B0vMaWXog==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93YZ-0005Ew-BM; Wed, 27 Mar 2019 08:05:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: implement generic dma_map_ops for IOMMUs v2 [rebase + resend]
Date:   Wed, 27 Mar 2019 09:04:27 +0100
Message-Id: <20190327080448.5500-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

please take a look at this series, which implements a completely generic
set of dma_map_ops for IOMMU drivers.  This is done by taking the
existing arm64 code, moving it to drivers/iommu and then massaging it
so that it can also work for architectures with DMA remapping.  This
should help future ports to support IOMMUs more easily, and also allow
to remove various custom IOMMU dma_map_ops implementations, like Tom
was planning to for the AMD one.

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git dma-iommu-ops.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.2

Changes since v1:
 - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
 - keep using a scatterlist in iommu_dma_alloc
 - split out mmap/sgtable fixes and move them early in the series
 - updated a few commit logs
