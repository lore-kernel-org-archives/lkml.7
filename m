Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7361B20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfHNQ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:56:49 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37072 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfHNQ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:56:48 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hxwZj-0007WM-Jh; Wed, 14 Aug 2019 10:56:41 -0600
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@vger.kernel.org
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
 <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com>
 <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
 <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com>
 <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
 <e1f78a33-18bb-bd6e-eede-e5e86758a4d0@deltatee.com>
 <CAEbi=3f+JDywuHYspfYKuC8z2wm8inRenBz+3DYbKK3ixFjU_g@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0d81412d-73fc-fa56-6f84-dedda72b9cc6@deltatee.com>
Date:   Wed, 14 Aug 2019 10:56:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEbi=3f+JDywuHYspfYKuC8z2wm8inRenBz+3DYbKK3ixFjU_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: linux-mm@vger.kernel.org, hch@lst.de, michaeljclark@mac.com, linux-riscv@lists.infradead.org, greentime.hu@sifive.com, olof@lixom.net, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, paul.walmsley@sifive.com, green.hu@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-08-14 7:35 a.m., Greentime Hu wrote:
> Logan Gunthorpe <logang@deltatee.com> 於 2019年8月14日 週三 上午12:50寫道：
>>
>> On 2019-08-13 10:39 a.m., Paul Walmsley wrote:
>>> On Tue, 13 Aug 2019, Logan Gunthorpe wrote:
>>>
>>>> On 2019-08-13 12:04 a.m., Greentime Hu wrote:
>>>>
>>>>> Every architecture with mmu defines their own pfn_valid().
>>>>
>>>> Not true. Arm64, for example just uses the generic implementation in
>>>> mmzone.h.
>>>
>>> arm64 seems to define their own:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n899
>>
>> Oh, yup. My mistake.
>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/mm/init.c#n235
>>>
>>> While there are many architectures which have their own pfn_valid();
>>> oddly, almost none of them set HAVE_ARCH_PFN_VALID ?
>>
>> Yes, much of this is super confusing. Seems HAVE_ARCH_PFN_VALID only
>> matters if SPARSEMEM is set. So risc-v probably doesn't need to set it
>> and we just need a #ifdef !CONFIG_FLATMEM around the pfn_valid
>> definition like other arches.
>>
> 
> Maybe this commit explains why it used HAVE_ARCH_PFN_VALID instead of SPARSEMEM.
> https://github.com/torvalds/linux/commit/7b7bf499f79de3f6c85a340c8453a78789523f85
> 
> BTW, I found another issue here.
> #define FIXADDR_TOP            (VMALLOC_START)
> #define FIXADDR_START           (FIXADDR_TOP - FIXADDR_SIZE)
> #define VMEMMAP_END    (VMALLOC_START - 1)
> #define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
> These 2 regions are overlapped.
> 
> How about this fix? Not sure if it is good for everyone.

Yes, this looks good to me. I can fold these changes into my patch and
send a v5 to the list.

Thanks!

Logan


> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 3f12b069af1d..3c4d394679d0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -115,9 +115,6 @@ config PGTABLE_LEVELS
>         default 3 if 64BIT
>         default 2
> 
> -config HAVE_ARCH_PFN_VALID
> -       def_bool y
> -
>  menu "Platform type"
> 
>  choice
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index c207f6634b91..72e106b60bc5 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -26,7 +26,7 @@ enum fixed_addresses {
>  };
> 
>  #define FIXADDR_SIZE           (__end_of_fixed_addresses * PAGE_SIZE)
> -#define FIXADDR_TOP            (VMALLOC_START)
> +#define FIXADDR_TOP            (VMEMMAP_START)
>  #define FIXADDR_START          (FIXADDR_TOP - FIXADDR_SIZE)
> 
>  #define FIXMAP_PAGE_IO         PAGE_KERNEL
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 8ddb6c7fedac..83830997dce6 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -100,8 +100,10 @@ extern unsigned long min_low_pfn;
>  #define page_to_bus(page)      (page_to_phys(page))
>  #define phys_to_page(paddr)    (pfn_to_page(phys_to_pfn(paddr)))
> 
> +#if defined(CONFIG_FLATMEM)
>  #define pfn_valid(pfn) \
>         (((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
> +#endif
> 
>  #define ARCH_PFN_OFFSET                (pfn_base)

