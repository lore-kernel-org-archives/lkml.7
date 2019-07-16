Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FBBC76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540FF2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfGPMCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:02:23 -0400
Received: from foss.arm.com ([217.140.110.172]:33892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfGPMCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:02:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA1762B;
        Tue, 16 Jul 2019 05:02:21 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80CF63F71A;
        Tue, 16 Jul 2019 05:02:20 -0700 (PDT)
Subject: Re: cma_remap when using dma_alloc_attr :- DMA_ATTR_NO_KERNEL_MAPPING
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
References: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        pankaj.suryawanshi@einfochips.com, minchan@kernel.org,
        minchan.kim@gmail.com, Christoph Hellwig <hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <57f8aa35-d460-9933-a547-fbf578ea42d3@arm.com>
Date:   Tue, 16 Jul 2019 13:02:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2019 19:30, Pankaj Suryawanshi wrote:
> Hello,
> 
> When we allocate cma memory using dma_alloc_attr using
> DMA_ATTR_NO_KERNEL_MAPPING attribute. It will return physical address
> without virtual mapping and thats the use case of this attribute. but lets
> say some vpu/gpu drivers required virtual mapping of some part of the
> allocation. then we dont have anything to remap that allocated memory to
> virtual memory. and in 32-bit system it difficult for devices like android
> to work all the time with virtual mapping, it degrade the performance.
> 
> For Example :
> 
> Lets say 4k video allocation required 300MB cma memory but not required
> virtual mapping for all the 300MB, its require only 20MB virtually mapped
> at some specific use case/point of video, and unmap virtual mapping after
> uses, at that time this functions will be useful, it works like ioremap()
> for cma_alloc() using dma apis.

Hmm, is there any significant reason that this case couldn't be handled 
with just get_vm_area() plus dma_mmap_attrs(). I know it's only 
*intended* for userspace mappings, but since the basic machinery is there...

Robin.

> /*
>           * function call(s) to create virtual map of given physical memory
>           * range [base, base+size) of CMA memory.
> */
> void *cma_remap(__u32 base, __u32 size)
> {
>          struct page *page = phys_to_page(base);
>          void *virt;
> 
>          pr_debug("cma: request to map 0x%08x for size 0x%08x\n",
>                          base, size);
> 
>          size = PAGE_ALIGN(size);
> 
>          pgprot_t prot = get_dma_pgprot(DMA_ATTR, PAGE_KERNEL);
> 
>          if (PageHighMem(page)){
>                  virt = dma_alloc_remap(page, size, GFP_KERNEL, prot,
> __builtin_return_address(0));
>          }
>          else
>          {
>                  dma_remap(page, size, prot);
>                  virt = page_address(page);
>          }
> 
>          if (!virt)
>                  pr_err("\x1b[31m" " cma: failed to map 0x%08x" "\x1b[0m\n",
>                                  base);
>          else
>                  pr_debug("cma: 0x%08x is virtually mapped to 0x%08x\n",
>                                  base, (__u32) virt);
> 
>          return virt;
> }
> 
> /*
>           * function call(s) to remove virtual map of given virtual memory
>           * range [virt, virt+size) of CMA memory.
> */
> 
> void cma_unmap(void *virt, __u32 size)
> {
>          size = PAGE_ALIGN(size);
>          unsigned long pfn = virt_to_pfn(virt);
>          struct page *page = pfn_to_page(pfn);
> 
>                  if (PageHighMem(page))
>                          dma_free_remap(virt, size);
>                  else
>                          dma_remap(page, size, PAGE_KERNEL);
> 
>          pr_debug(" cma: virtual address 0x%08x is unmapped\n",
>                          (__u32) virt);
> }
> 
> This functions should be added in arch/arm/mm/dma-mapping.c file.
> 
> Please let me know if i am missing anything.
> 
> Regards,
> Pankaj
> 
