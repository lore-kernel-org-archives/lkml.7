Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBEFC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4EF2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbfEWSFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:05:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387408AbfEWSFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:05:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFFF4374;
        Thu, 23 May 2019 11:05:52 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB46E3F5AF;
        Thu, 23 May 2019 11:05:50 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20190522072018.10660-1-horia.geanta@nxp.com>
 <20190522123243.GA26390@lst.de>
 <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
 <20190522130921.GA26874@lst.de>
 <fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
 <20190522133400.GA27229@lst.de>
 <CGME20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b@epcas2p3.samsung.com>
 <ed26de5e-aee4-4e19-095c-cc551012d475@arm.com>
 <0c79721a-11cb-c945-5626-3d43cc299fe6@samsung.com>
 <20190523164332.GA22245@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <49076a29-a0f5-f5f0-6c2a-a2180edd1674@arm.com>
Date:   Thu, 23 May 2019 19:05:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523164332.GA22245@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2019 17:43, Christoph Hellwig wrote:
> On Thu, May 23, 2019 at 07:35:07AM +0200, Marek Szyprowski wrote:
>> Don't we have DMA_BIDIRECTIONAL for such case?
> 
> Not sure if it was intended for that case, but it definitively should
> do the right thing for swiotlb, and it should also do the right thing
> in terms of cache maintainance.
> 
>> Maybe we should update
>> documentation a bit to point that DMA_FROM_DEVICE expects the whole
>> buffer to be filled by the device?
> 
> Probably. Horia, can you try to use DMA_BIDIRECTIONAL?
> 

Yes, in general that should be a viable option. I got rather focused on 
the distinction that a "partial" FROM_DEVICE mapping would still be 
allowed to physically prevent the device from making any reads, whereas 
BIDIRECTIONAL would not, but I suspect any benefit being lost there is 
mostly one of debugging visibility rather than appreciable security, and 
probably not enough to justify additional complexity on its own - I 
couldn't say off-hand how many IOMMUs actually support write-only 
permissions anyway.

Whichever way, I'd certainly have no objection to formalising what seems 
to be the existing behaviour (both SWIOTLB and ARM dmabounce look 
consistent, at least) as something like "for the DMA_FROM_DEVICE 
direction, any parts of the buffer not written to by the device will 
become undefined". The IOMMU bounce page stuff is going to be another 
one in this boat, too.

Robin.
