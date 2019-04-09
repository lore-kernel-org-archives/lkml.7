Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5DE2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDIRXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:23:22 -0400
Received: from verein.lst.de ([213.95.11.211]:51817 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfDIRXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:23:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A9F2B68B02; Tue,  9 Apr 2019 19:23:09 +0200 (CEST)
Date:   Tue, 9 Apr 2019 19:23:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
Message-ID: <20190409172309.GD14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-8-hch@lst.de> <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 04:07:02PM +0100, Robin Murphy wrote:
>> -static inline int iommu_dma_init(void)
>> +static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>> +		u64 size, const struct iommu_ops *ops)
>>   {
>> -	return 0;
>>   }
>
> I don't think it makes sense to have a stub for that - AFAICS it should 
> only ever be called form arch code with an inherent "select IOMMU_DMA" 
> (much like the stuff which isn't stubbed currently).
>
> Otherwise, I'm about 97% sure the rest of the move looks OK - thanks for 
> splitting things up.

arm64 only selects IOMMU_DMA if IOMMU_SUPPORT is selected, which can
be disabled.  So to keep some (unusual) arm64 configs compiling we'll need
the stub..
