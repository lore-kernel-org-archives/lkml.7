Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867C6C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6670D208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbfJ1L7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:59:11 -0400
Received: from foss.arm.com ([217.140.110.172]:39164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfJ1L7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:59:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D77B21F1;
        Mon, 28 Oct 2019 04:59:09 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B53003F6C4;
        Mon, 28 Oct 2019 04:59:08 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
To:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     isaacm@codeaurora.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        m.szyprowski@samsung.com, pratikp@codeaurora.org,
        lmark@codeaurora.org
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
 <20191026053026.GA14545@lst.de>
 <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
 <20191028074156.GB20443@lst.de> <20191028112457.GB4122@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c1b37c8d-7bdc-eb81-19c2-29f50568150a@arm.com>
Date:   Mon, 28 Oct 2019 11:59:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191028112457.GB4122@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2019 11:24, Will Deacon wrote:
> Hi Christoph,
> 
> On Mon, Oct 28, 2019 at 08:41:56AM +0100, Christoph Hellwig wrote:
>> On Sat, Oct 26, 2019 at 03:12:57AM -0700, isaacm@codeaurora.org wrote:
>>> On 2019-10-25 22:30, Christoph Hellwig wrote:
>>>> The definition makes very little sense.
>>> Can you please clarify what part doesn’t make sense, and why?
>>
>> It looks like complete garbage to me.  That might just be because it
>> uses tons of terms I've never heard of of and which aren't used anywhere
>> in the DMA API.  It also might be because it doesn't explain how the
>> flag might actually be practically useful.
> 
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

FWIW, that's pretty much how Pratik and Jordan explained it to me - the 
LLC sits directly in front of memory and is more or less transparent, 
although it might treat CPU and device accesses slightly differently (I 
don't remember exactly how the inner cacheablility attribute interacts). 
Certain devices don't get much benefit from the LLC, hence the desire 
for finer-grained control of their outer allocation policy to avoid more 
thrashing than necessary. Furthermore, for stuff in the 
video/GPU/display area certain jobs benefit more than others, hence the 
desire to go even finer-grained than a per-device control in order to 
maximise LLC effectiveness.

Robin.

>>> This is
>>> really just an extension of this patch that got mainlined, so that clients
>>> that use the DMA API can use IOMMU_QCOM_SYS_CACHE as well:
>>> https://patchwork.kernel.org/patch/10946099/
>>>>   Any without a user in the same series it is a complete no-go anyway.
>>> IOMMU_QCOM_SYS_CACHE does not have any current users in the mainline, nor
>>> did it have it in the patch series in which it got merged, yet it is still
>>> present? Furthermore, there are plans to upstream support for one of our
>>> SoCs that may benefit from this, as seen here:
>>> https://www.spinics.net/lists/iommu/msg39608.html.
>>
>> Which means it should have never been merged.  As a general policy we do
>> not add code to the Linux kernel without actual users.
> 
> Yes, in this case I was hoping a user would materialise via a different
> tree, but it didn't happen, hence my post last week about removing this
> altogether:
> 
> https://lore.kernel.org/linux-iommu/20191024153832.GA7966@jcrouse1-lnx.qualcomm.com/T/#t
> 
> which I suspect prompted this patch that unfortunately fails to solve the
> problem.
> 
> Will
> 
