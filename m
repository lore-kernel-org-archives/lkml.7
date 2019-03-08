Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54292C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2803720851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCHR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:26:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33228 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfCHR0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:26:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37302A78;
        Fri,  8 Mar 2019 09:26:01 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F02613F575;
        Fri,  8 Mar 2019 09:25:58 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190304195951.1118807-1-arnd@arndb.de>
 <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
 <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
 <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com>
 <20190308152355.GA20230@lst.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <124f4e49-9eb1-99d9-35f4-c2ef3dff8415@arm.com>
Date:   Fri, 8 Mar 2019 17:25:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308152355.GA20230@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 08/03/2019 15:23, Christoph Hellwig wrote:
> On Tue, Mar 05, 2019 at 09:41:46AM +0000, Julien Grall wrote:
>> On Xen, dma_addr_t will always be 64-bit while the phys_addr_t will depend
>> on the MMU type. So we may have phys_addr_t smaller than dma_addr_t from
>> the kernel point of view.
> 
> How can dma_addr_t on arm have value > 32-bit when physical
> addresses are 32-bit only?

The number of platform with IOMMU protected all DMA-capable device is not yet 
there. So we decided to not require IOMMU for Dom0. Instead, its memory is be 
directly mapped (i.e guest physical address == host physical address) and will 
always be below 4GB to cater the short page table case.

In the common case, Dom0 also contains the PV backend drivers. Those drivers may 
directly use the guest buffer in the DMA request (so a copy is avoided). To 
avoid using a bounce buffer too much, xen-swiotlb will find the host physical 
address associated to the guest buffer and will use it to compute the DMA address.

While Dom0 kernel may only deal with 32-bit physical address, the hypervisor can 
still deal with up to 40-bit physical address. This means the guest memory can 
be allocated above the 4GB threshold. Hence why the dma_addr_t is always 64-bit 
with CONFIG_XEN=y.

Cheers,

-- 
Julien Grall
