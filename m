Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64803C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386E720674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfDRPHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:07:00 -0400
Received: from foss.arm.com ([217.140.101.70]:35120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388457AbfDRPHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:07:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E06515AB;
        Thu, 18 Apr 2019 08:06:59 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458363F5AF;
        Thu, 18 Apr 2019 08:06:58 -0700 (PDT)
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
Date:   Thu, 18 Apr 2019 16:06:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417063358.GA24139@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2019 07:33, Christoph Hellwig wrote:
> On Wed, Apr 10, 2019 at 08:11:57AM +0200, Christoph Hellwig wrote:
>> On Tue, Apr 09, 2019 at 06:59:32PM +0100, Robin Murphy wrote:
>>> On 27/03/2019 08:04, Christoph Hellwig wrote:
>>>> This keeps the code together and will simplify compiling the code
>>>> out on architectures that are always dma coherent.
>>>
>>> And this is where things take a turn in the direction I just can't get on
>>> with - I'm looking at the final result and the twisty maze of little
>>> disjoint helpers all overlapping each other in functionality is really
>>> difficult to follow. And I would *much* rather have things rely on
>>> compile-time constant optimisation than spend the future having to fix the
>>> #ifdefed parts for arm64 whenever x86-centric changes fail to test them.
>>
>> Can you draft up a patch on top of my series to show me what you
>> want?  I can take care of finishing it up and moving the changes
>> into the right patches in the series.
> 
> Any chance to make some progress on this?  Or at least a better
> description of what you want?

OK, I'm still looking at mmap and get_sgtable, but for now I've pushed 
out a partial branch that consolidates alloc and free in a way which 
makes sense to me:

   git://linux-arm.org/linux-rm  dma/rework

Please let me know what you think.

Robin.
