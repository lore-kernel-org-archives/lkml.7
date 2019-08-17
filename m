Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717F0C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D51B2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfHQSUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 14:20:32 -0400
Received: from foss.arm.com ([217.140.110.172]:42342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfHQSUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 14:20:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DD5337;
        Sat, 17 Aug 2019 11:20:31 -0700 (PDT)
Received: from [10.37.12.25] (unknown [10.37.12.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A66F3F706;
        Sat, 17 Aug 2019 11:20:29 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 07/11] swiotlb-xen: provide a single
 page-coherent.h header
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190816130013.31154-1-hch@lst.de>
 <20190816130013.31154-8-hch@lst.de>
 <9a3261c6-5d92-cf6b-1ae8-3a8e8b5ef0d4@arm.com>
 <20190817065011.GA18599@lst.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <21746bbf-618a-d12b-c767-f9e865f4dd20@arm.com>
Date:   Sat, 17 Aug 2019 19:20:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817065011.GA18599@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 8/17/19 7:50 AM, Christoph Hellwig wrote:
> On Fri, Aug 16, 2019 at 11:40:43PM +0100, Julien Grall wrote:
>> I am not sure I agree with this rename. The implementation of the helpers
>> are very Arm specific as this is assuming Dom0 is 1:1 mapped.
>>
>> This was necessary due to the lack of IOMMU on Arm platforms back then.
>> But this is now a pain to get rid of it on newer platform...
> 
> So if you look at the final version of the header after the whole
> series, what assumes a 1:1 mapping?  It all just is
> 
> 	if (pfn_valid())
> 		local cache sync;
> 	else
> 		call into the arch code;

In the context of Xen Arm, the dev_addr is a host physical address. From 
my understanding pfn_valid() is dealing with a guest physical frame.

Therefore by passing PFN_DOWN(dev_addr) in argument you assume that the 
host and guest address spaces are the same.

> 
> are you concerned that the local cache sync might have to be split
> up more for a non-1:1 map in that case?  We could just movea
> the xen_dma_* routines into the arch instead of __xen_dma, but it
> really helps to have a common interface header.
Moving xen_dma_* routines into the arch would be a good option. 
Although, I would still consider a stub version for arch not requiring 
specific DMA.

Cheers,

-- 
Julien Grall

