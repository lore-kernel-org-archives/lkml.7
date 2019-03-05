Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD6420684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCEJlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:41:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45520 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfCEJlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:41:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E9FAA78;
        Tue,  5 Mar 2019 01:41:52 -0800 (PST)
Received: from [10.37.12.57] (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66C53F71D;
        Tue,  5 Mar 2019 01:41:48 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
To:     Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190304195951.1118807-1-arnd@arndb.de>
 <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
 <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com>
Date:   Tue, 5 Mar 2019 09:41:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 3/5/19 8:16 AM, Arnd Bergmann wrote:
> On Tue, Mar 5, 2019 at 12:56 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2019-03-04 7:59 pm, Arnd Bergmann wrote:
>>> This reverts commit b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR"), which
>>> introduced an overflow warning in configurations that have a larger
>>> dma_addr_t than phys_addr_t:
>>>
>>> In file included from include/linux/dma-direct.h:5,
>>>                    from kernel/dma/swiotlb.c:23:
>>> kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
>>> include/linux/dma-mapping.h:136:28: error: conversion from 'long long unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
>>>    #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
>>>                               ^
>>> kernel/dma/swiotlb.c:544:9: note: in expansion of macro 'DMA_MAPPING_ERROR'
>>>     return DMA_MAPPING_ERROR;
>>>
>>> The configuration that caused this is on 32-bit ARM, where the DMA address
>>> space depends on the enabled hardware platforms, while the physical
>>> address space depends on the type of MMU chosen (classic vs LPAE).
>>
>> Are these real platforms, or random configs? Realistically I don't see a
>> great deal of need to support DMA_ADDR_T_64BIT for non-LPAE.
>> Particularly in this case since AFAIK the only selector of SWIOTLB on
>> Arm is Xen, and that by definition is never going to be useful on
>> non-LPAE hardware.
> ...
> On Mon, Mar 4, 2019 at 11:00 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> What about making the phys_addr_t and dma_addr_t have the same
>> width with some magic #ifdef hackery?
> 
> As far as I can tell, only randconfig builds see this problem, in
> real systems phys_addr_t is normally the same as dma_addr_t,
> and you could reasonably have a machine with a larger phys_addr_t
> than dma_addr_t but wouldn't need to bother.

On Xen, dma_addr_t will always be 64-bit while the phys_addr_t will 
depend on the MMU type. So we may have phys_addr_t smaller than 
dma_addr_t from the kernel point of view.

Cheers,

-- 
Julien Grall
