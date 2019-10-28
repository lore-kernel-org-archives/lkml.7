Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6507BCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E2B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbfJ1Lhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:37:32 -0400
Received: from verein.lst.de ([213.95.11.211]:34029 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfJ1Lhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:37:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4BA268AFE; Mon, 28 Oct 2019 12:37:28 +0100 (CET)
Date:   Mon, 28 Oct 2019 12:37:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, isaacm@codeaurora.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191028113728.GA24055@lst.de>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org> <20191026053026.GA14545@lst.de> <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org> <20191028074156.GB20443@lst.de> <20191028112457.GB4122@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028112457.GB4122@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:24:58AM +0000, Will Deacon wrote:
> Agreed. The way I /think/ it works is that on many SoCs there is a
> system/last-level cache (LLC) which effectively sits in front of memory for
> all masters. Even if a device isn't coherent with the CPU caches, we still
> want to be able to allocate into the LLC. Why this doesn't happen
> automatically is beyond me, but it appears that on these Qualcomm designs
> you actually have to set the memory attributes up in the page-table to
> ensure that the resulting memory transactions are non-cacheable for the CPU
> but cacheable for the LLC. Without any changes, the transactions are
> non-cacheable in both of them which assumedly has a performance cost.
> 
> But you can see that I'm piecing things together myself here. Isaac?

If that is the case it sounds like we'd want to drive this through
DT properties, not the driver API.  But again, without an actual consumer
it pretty much is a moot point anyway.
