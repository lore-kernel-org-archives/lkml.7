Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65CEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7D52183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfDXT1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:27:12 -0400
Received: from verein.lst.de ([213.95.11.211]:56600 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfDXT1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:27:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 253F368C4E; Wed, 24 Apr 2019 21:26:53 +0200 (CEST)
Date:   Wed, 24 Apr 2019 21:26:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, robin.murphy@arm.com,
        vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Message-ID: <20190424192652.GA29032@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com> <20190326230131.16275-2-nicoleotsuka@gmail.com> <20190424150638.GA22191@lst.de> <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424183310.GA6168@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:33:11AM -0700, Nicolin Chen wrote:
> I feel it's similar to my previous set, which did most of these
> internally except the renaming part. But Catalin had a concern
> that some platforms might have limits on CMA range [1]. Will it
> be still okay to do the fallback internally?
> 
> [1: https://www.spinics.net/lists/arm-kernel/msg714295.html ]

Catalins statement is correct, but I don't see how it applies to
your patch.  Your patch just ensures that the fallback we have
in most callers is uniformly applied everywhere.  The non-iommu
callers will still need to select a specific zone and/or retry
just the page allocator with other flags if the CMA (or fallback)
page doesn't match what they need.  dma-direct does this correctly
and I think the arm32 allocator does as well, although it is a bit
hard to follow sometimes.
