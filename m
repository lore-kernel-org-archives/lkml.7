Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DD720684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCEJhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:37:00 -0500
Received: from foss.arm.com ([217.140.101.70]:45460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfCEJg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:36:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04737A78;
        Tue,  5 Mar 2019 01:36:59 -0800 (PST)
Received: from [10.37.12.57] (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244823F71D;
        Tue,  5 Mar 2019 01:36:54 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
To:     Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190304195951.1118807-1-arnd@arndb.de>
 <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <c1bf689e-63b0-24a1-14ad-4c026017f12c@arm.com>
Date:   Tue, 5 Mar 2019 09:36:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 3/4/19 11:56 PM, Robin Murphy wrote:
> On 2019-03-04 7:59 pm, Arnd Bergmann wrote:
>> This reverts commit b907e20508d0 ("swiotlb: remove 
>> SWIOTLB_MAP_ERROR"), which
>> introduced an overflow warning in configurations that have a larger
>> dma_addr_t than phys_addr_t:
>>
>> In file included from include/linux/dma-direct.h:5,
>>                   from kernel/dma/swiotlb.c:23:
>> kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
>> include/linux/dma-mapping.h:136:28: error: conversion from 'long long 
>> unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from 
>> '18446744073709551615' to '4294967295' [-Werror=overflow]
>>   #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
>>                              ^
>> kernel/dma/swiotlb.c:544:9: note: in expansion of macro 
>> 'DMA_MAPPING_ERROR'
>>    return DMA_MAPPING_ERROR;
>>
>> The configuration that caused this is on 32-bit ARM, where the DMA 
>> address
>> space depends on the enabled hardware platforms, while the physical
>> address space depends on the type of MMU chosen (classic vs LPAE).
> 
> Are these real platforms, or random configs? Realistically I don't see a 
> great deal of need to support DMA_ADDR_T_64BIT for non-LPAE. 

This is selected by CONFIG_XEN no matter the type of MMU chosen (see 
more below).

> Particularly in this case since AFAIK the only selector of SWIOTLB on 
> Arm is Xen, and that by definition is never going to be useful on 
> non-LPAE hardware.

While Xen itself requires LPAE, it is still possible to run a non-LPAE 
kernel in the guest. For instance, last time I checked, Debian was 
shipping only non-LPAE kernel for Arm32.

On Arm, swiotlb is only used by the hardware domain (aka Dom0) to allow 
DMA in memory mapped from other guest. So the returned DMA address may 
be 64-bit. Hence why we select DMA_ADDR_T_64BIT above.

Cheers,

-- 
Julien Grall
