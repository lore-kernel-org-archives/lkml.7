Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5ECC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E3F20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436805AbfHIPrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:47:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45332 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436647AbfHIPrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:47:00 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hw76S-0000Nl-DT; Fri, 09 Aug 2019 09:46:53 -0600
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com>
Date:   Fri, 9 Aug 2019 09:46:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
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



On 2019-08-08 10:23 p.m., Greentime Hu wrote:
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 3f12b069af1d..208b3e14ccd8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -116,7 +116,8 @@ config PGTABLE_LEVELS
>         default 2
> 
>  config HAVE_ARCH_PFN_VALID
> -       def_bool y
> +       bool
> +       default !SPARSEMEM_VMEMMAP
> 
>  menu "Platform type"
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 8ddb6c7fedac..6991f7a5a4a7 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -93,16 +93,20 @@ extern unsigned long min_low_pfn;
>  #define virt_to_pfn(vaddr)     (phys_to_pfn(__pa(vaddr)))
>  #define pfn_to_virt(pfn)       (__va(pfn_to_phys(pfn)))
> 
> +#if !defined(CONFIG_SPARSEMEM_VMEMMAP)
> +#define pfn_valid(pfn) \
> +       (((pfn) >= pfn_base) && (((pfn)-pfn_base) < max_mapnr))
>  #define virt_to_page(vaddr)    (pfn_to_page(virt_to_pfn(vaddr)))
>  #define page_to_virt(page)     (pfn_to_virt(page_to_pfn(page)))
> +#else
> +#define virt_to_page(vaddr)    ((struct page *)((((u64)vaddr -
> va_pa_offset) / PAGE_SIZE) * sizeof(struct page) + VMEMMAP_START))
> +#define page_to_virt(pg)       ((void *)(((((u64)pg - VMEMMAP_START) /
> sizeof(struct page)) * PAGE_SIZE) + va_pa_offset))
> +#endif

This doesn't make sense to me at all. It should always use pfn_to_page()
for virt_to_page() and the generic pfn_to_page()/page_to_pfn()
implementations essentially already do what you are doing in a cleaner
way. So I'd be really surprised if this does anything at all.

Logan
