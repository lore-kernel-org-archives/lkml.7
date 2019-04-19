Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7E1C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF83F204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfDSSfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:07 -0400
Received: from verein.lst.de ([213.95.11.211]:56138 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfDSSfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:35:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3141F68B20; Fri, 19 Apr 2019 11:08:00 +0200 (CEST)
Date:   Fri, 19 Apr 2019 11:07:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Message-ID: <20190419090759.GA22885@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de> <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com> <20190418163512.GA25347@lst.de> <433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 05:41:00PM +0100, Robin Murphy wrote:
>>  From a very high level POV this looks ok, but sometimes a bit to
>> convoluted to me.  The major issue why I went with the version I posted
>> is that I can cleanly ifdef out the remap code in just a few sections.
>> In this version it is spread out a lot more, and the use of IS_ENABLED
>> means that we'd need a lot more stubs for functionality that won't
>> ever be called but needs to be compilable.
>
> What functionality do you have planned in that regard? I did do a quick 
> build test of my arm64 config with DMA_DIRECT_REMAP hacked out, and 
> dma-iommu.o appeared to link OK (although other bits of arm64 and 
> dma-direct didn't, as expected). I will try x86 with IOMMU_DMA to make 
> sure, though.

Yeah, this seems to actually work, there just is a huge chunk of
remapping that is hopefully discarded by the compiler even without the
ifdefs.
