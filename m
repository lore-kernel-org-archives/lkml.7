Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26040C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072F4222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfIZKqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:46:21 -0400
Received: from foss.arm.com ([217.140.110.172]:45326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfIZKqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:46:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 567981576;
        Thu, 26 Sep 2019 03:46:20 -0700 (PDT)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE7E83F67D;
        Thu, 26 Sep 2019 03:46:18 -0700 (PDT)
Subject: Re: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Julien Grall <julien.grall@arm.com>,
        Rob Herring <robh@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
References: <20190925215006.12056-1-robh@kernel.org>
 <e898c025-32a7-1d2c-3501-c99556f7cdd4@arm.com>
 <1ae7f42e-bf93-b335-b543-653fae5cf49f@epam.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <28440326-ed76-b014-c1b8-02125c3214b9@arm.com>
Date:   Thu, 26 Sep 2019 11:46:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1ae7f42e-bf93-b335-b543-653fae5cf49f@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-26 11:17 am, Oleksandr Andrushchenko wrote:
> 
> On 9/26/19 12:49 PM, Julien Grall wrote:
>> Hi Rob,
>>
>>
>> On 9/25/19 10:50 PM, Rob Herring wrote:
>>> As the comment says, this isn't a DT based device. of_dma_configure()
>>> is going to stop allowing a NULL DT node, so this needs to be fixed.
>>
>> And this can't work on arch not selecting CONFIG_OF and can select
>> CONFIG_XEN_GRANT_DMA_ALLOC.
>>
>> We are lucky enough on x86 because, AFAICT, arch_setup_dma_ops is just
>> a nop.
>>
> No luck is needed as [1] does nothing for those platforms not using
> CONFIG_OF
>>>
>>> Not sure exactly what setup besides arch_setup_dma_ops is needed...
>>
>> We probably want to update dma_mask, coherent_dma_mask and
>> dma_pfn_offset.
>>
>> Also, while look at of_configure_dma, I noticed that we consider the
>> DMA will not be coherent for the grant-table. Oleksandr, do you know
>> why they can't be coherent?
> The main and the only reason to use of_configure_dma is that if we don't
> then we
> are about to stay with dma_dummy_ops [2]. It effectively means that
> operations on dma-bufs
> will end up returning errors, like [3], [4], thus not making it possible
> for Xen PV DRM and DMA
> part of gntdev driver to do what we need (dma-bufs in our use-cases
> allow zero-copying
> while using graphics buffers and many more).
> 
> I didn't find any better way of achieving that, but of_configure_dma...
> If there is any better solution which will not break the existing
> functionality then
> I will definitely change the drivers so we do not abuse DT )
> Before that, please keep in mind that merging this RFC will break Xen PV
> DRM +
> DMA buf support in gntdev...
> Hope we can work out some acceptable solution, so everyone is happy

As I mentioned elsewhere, the recent dma-direct rework means that 
dma_dummy_ops are now only explicitly installed for the ACPI error case, 
so - much as I may dislike it - you should get regular (direct/SWIOTLB) 
ops by default again.

Coherency is trickier - if the guest is allocating buffers for the PV 
device, which may be shared directly with hardware by the host driver, 
then the coherency of the PV device should really reflect that of the 
underlying hardware to avoid potential problems. There are some cases 
where the stage 2 attributes alone wouldn't be enough to correct a mismatch.

Robin.
