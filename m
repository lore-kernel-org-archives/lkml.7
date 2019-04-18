Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C2BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3ED2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389660AbfDRQlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:41:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRQlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:41:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5302380D;
        Thu, 18 Apr 2019 09:41:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0132E3F557;
        Thu, 18 Apr 2019 09:41:01 -0700 (PDT)
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-13-hch@lst.de>
 <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com> <20190410061157.GA5278@lst.de>
 <20190417063358.GA24139@lst.de>
 <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
 <20190418163512.GA25347@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <433dec64-ef15-b31d-ace4-4c72b81d2942@arm.com>
Date:   Thu, 18 Apr 2019 17:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418163512.GA25347@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2019 17:35, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 04:06:56PM +0100, Robin Murphy wrote:
>> OK, I'm still looking at mmap and get_sgtable, but for now I've pushed out
>> a partial branch that consolidates alloc and free in a way which makes
>> sense to me:
>>
>>    git://linux-arm.org/linux-rm  dma/rework
>>
>> Please let me know what you think.
> 
>  From a very high level POV this looks ok, but sometimes a bit to
> convoluted to me.  The major issue why I went with the version I posted
> is that I can cleanly ifdef out the remap code in just a few sections.
> In this version it is spread out a lot more, and the use of IS_ENABLED
> means that we'd need a lot more stubs for functionality that won't
> ever be called but needs to be compilable.

What functionality do you have planned in that regard? I did do a quick 
build test of my arm64 config with DMA_DIRECT_REMAP hacked out, and 
dma-iommu.o appeared to link OK (although other bits of arm64 and 
dma-direct didn't, as expected). I will try x86 with IOMMU_DMA to make 
sure, though.

Robin.
