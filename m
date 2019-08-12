Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6729C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886F620679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfHLPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:52:08 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36846 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfHLPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:52:08 -0400
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hxCbx-0006Ga-2Z; Mon, 12 Aug 2019 09:51:54 -0600
To:     Greentime Hu <green.hu@gmail.com>
Cc:     greentime.hu@sifive.com, paul.walmsley@sifive.com,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190109203911.7887-1-logang@deltatee.com>
 <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com>
 <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com>
 <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
 <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com>
Date:   Mon, 12 Aug 2019 09:51:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, michaeljclark@mac.com, linux-riscv@lists.infradead.org, olof@lixom.net, zong@andestech.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, paul.walmsley@sifive.com, greentime.hu@sifive.com, green.hu@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-08-11 10:01 p.m., Greentime Hu wrote:
> Hi Logan,
> 
> Logan Gunthorpe <logang@deltatee.com> 於 2019年8月10日 週六 上午3:03寫道：
>>
>>
>>
>> On 2019-08-09 11:01 a.m., Greentime Hu wrote:
>>> Hi Logan,
>>>
>>> Logan Gunthorpe <logang@deltatee.com> 於 2019年8月9日 週五 下午11:47寫道：
>>>>
>>>>
>>>>
>>>> On 2019-08-08 10:23 p.m., Greentime Hu wrote:
>>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>>> index 3f12b069af1d..208b3e14ccd8 100644
>>>>> --- a/arch/riscv/Kconfig
>>>>> +++ b/arch/riscv/Kconfig
>>>>> @@ -116,7 +116,8 @@ config PGTABLE_LEVELS
>>>>>         default 2
>>>>>
>>>>>  config HAVE_ARCH_PFN_VALID
>>>>> -       def_bool y
>>>>> +       bool
>>>>> +       default !SPARSEMEM_VMEMMAP
>>>>>
>>>>>  menu "Platform type"
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>>>>> index 8ddb6c7fedac..6991f7a5a4a7 100644
>>>>> --- a/arch/riscv/include/asm/page.h
>>>>> +++ b/arch/riscv/include/asm/page.h
>>>>> @@ -93,16 +93,20 @@ extern unsigned long min_low_pfn;
>>>>>  #define virt_to_pfn(vaddr)     (phys_to_pfn(__pa(vaddr)))
>>>>>  #define pfn_to_virt(pfn)       (__va(pfn_to_phys(pfn)))
>>>>>
>>>>> +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
>>>>> +#define pfn_valid(pfn) \
>>>>> +       (((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
>>>>>  #define virt_to_page(vaddr)    (pfn_to_page(virt_to_pfn(vaddr)))
>>>>>  #define page_to_virt(page)     (pfn_to_virt(page_to_pfn(page)))
>>>>> +#else
>>>>> +#define virt_to_page(vaddr)    ((struct page *)((((u64)vaddr -
>>>>> va_pa_offset) / PAGE_SIZE) * sizeof(struct page) + VMEMMAP_START))
>>>>> +#define page_to_virt(pg)       ((void *)(((((u64)pg - VMEMMAP_START) /
>>>>> sizeof(struct page)) * PAGE_SIZE) + va_pa_offset))
>>>>> +#endif
>>>>
>>>> This doesn't make sense to me at all. It should always use pfn_to_page()
>>>> for virt_to_page() and the generic pfn_to_page()/page_to_pfn()
>>>> implementations essentially already do what you are doing in a cleaner
>>>> way. So I'd be really surprised if this does anything at all.
>>>>
>>>
>>> Thank you for point me out that. I just checked the generic
>>> implementation and I should use that one.
>>> Sorry I didn't check the generic one and just implement it again.
>>> I think the only patch we need is the first part to use generic
>>> pfn_valid(). I just tested it and yes it can boot successfully in dts
>>> with hole.
>>>
>>> It will fail in this check ((pfn)-pfn_base) < max_mapnr.
>>
>> Sounds to me like max_mapnr is not set correctly. See the code in
>> setup_bootmem(). Seems like 'mem_size' should be set to the largest
>> memory block, not just the one that contains the kernel...
>>
>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 3f12b069af1d..208b3e14ccd8 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -116,7 +116,8 @@ config PGTABLE_LEVELS
>>>         default 2
>>>
>>>  config HAVE_ARCH_PFN_VALID
>>> -       def_bool y
>>> +       bool
>>> +       default !SPARSEMEM_VMEMMAP
>>>
>>>  menu "Platform type"
>>>
>>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>>> index 8ddb6c7fedac..80d28fa1e2eb 100644
>>> --- a/arch/riscv/include/asm/page.h
>>> +++ b/arch/riscv/include/asm/page.h
>>> @@ -100,8 +100,10 @@ extern unsigned long min_low_pfn;
>>>  #define page_to_bus(page)      (page_to_phys(page))
>>>  #define phys_to_page(paddr)    (pfn_to_page(phys_to_pfn(paddr)))
>>>
>>> +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
>>>  #define pfn_valid(pfn) \
>>>         (((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
>>> +#endif
>>>
>>>  #define ARCH_PFN_OFFSET                (pfn_base)
>>
>>
>> This patch still makes no sense. I'm not sure why we have an arch
>> specific pfn_valid() because it's very similar to the generic one. But
>> my guess is there's a reason for it and it's not doing what it is
>> supposed when you remove it for the sparsemem case.
> 
> It will use another pfn_valid() implementation in
> include/linux/mmzone.h if CONFIG_SPARSEMEM and
> !CONFIG_HAVE_ARCH_PFN_VALID
> It will be this one.
> 
> static inline int pfn_valid(unsigned long pfn)
> {
>         if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>                 return 0;
>         return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> }

Ah, ok I see. "page.h" is only included in no-mmu arches. Which explains
why riscv re-implements that macro. Couple follow up questions then:

* Did you test the memory-with-hole scenario without the sparsemem
patches? It seems pfn_valid() will be wrong regardless of sparse/flat mem.

* Any chance we can just use the generic pfn_valid() function in all
cases not just sparsemem? Can you test that?

Thanks,

Logan
