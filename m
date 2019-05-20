Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3581CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37EC20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0+Lk/4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfETHau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:30:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfETHat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qgNFm3PFNvGCZEJePHJzrfYiVzHItl2iua2I5Kqs9tI=; b=s0+Lk/4wJo19CELPQ76eBDI8b
        I4G+BxD5DnPoSQb2ovAGteBxATcZdGTE3NEMzIuUB9e4/i5f/6XlSV8YJkdtcNG1eBx/rUttwjtlc
        dI05l2FHkXkhLjOiQ/8BuJpzeeOQdO20EvKQ+pku+kjo17RyntRtvDBRvtRRsydGlhNHRXdUkbYsC
        zsCAqfphrPUu/TwqlgrsanD+wMjuEWvgSq7YGJF3qDtFlakLynVIr8mm+4UVk9j7OfARB+vr/cm1m
        Tke4DRYsIq+2LpwMRmZmU99QVYZrnIV6m0GOjEcddiNu+qC/OwbXEZKbp+eugSHHlU+UrtiycBJhl
        +ULrAJwHg==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSckq-0003ju-6K; Mon, 20 May 2019 07:30:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: implement generic dma_map_ops for IOMMUs v5
Date:   Mon, 20 May 2019 09:29:24 +0200
Message-Id: <20190520072948.11412-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin and Joerg,

I think we are finally ready for the generic dma-iommu series.  I have
various DMA API changes pending, and Tom has patches ready to convert
the AMD and Intel iommu drivers over to it.  I'd love to have this
in a stable branch shared between the dma-mapping and iommu trees
the day after rc2 is released.  I volunteer to create the branch,
but I'm fine with it living in the iommu tree as well.  Before that
Will has already said he wants to send the first patch in the series
to Linus for this merge window.


A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git dma-iommu-ops.5

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.5

Changes since v4:
 - rebased to 5.2-rc1

Changes since v3:
 - fold the separate patch to refactor mmap bounds checking
 - don't warn on not finding a vm_area
 - improve a commit log
 - refactor __dma_iommu_free a little differently
 - remove a minor MSI map cleanup to avoid a conflict with the
   "Split iommu_dma_map_msi_msg" series

Changes since v2:
 - address various review comments and include patches from Robin

Changes since v1:
 - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
 - keep using a scatterlist in iommu_dma_alloc
 - split out mmap/sgtable fixes and move them early in the series
 - updated a few commit logs
