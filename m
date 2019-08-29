Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D75C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077462189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfH2G1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:27:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfH2G1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:27:03 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5D623BD6BCA87A6F7C9;
        Thu, 29 Aug 2019 14:26:58 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 14:26:49 +0800
Subject: Re: [PATCH v6 06/12] powerpc/fsl_booke/32: implement KASLR
 infrastructure
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>
CC:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>,
        <wangkefeng.wang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>, <zhaohongjiang@huawei.com>,
        <thunder.leizhen@huawei.com>, <fanchengyang@huawei.com>,
        <yebin10@huawei.com>
References: <20190809100800.5426-1-yanaijie@huawei.com>
 <20190809100800.5426-7-yanaijie@huawei.com>
 <20190828045454.GB17757@home.buserror.net>
 <2db76c55-df5f-5ca8-f0a6-bcee75b8edaa@c-s.fr>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <11ef88f7-e418-c48e-f96c-1256c1179bca@huawei.com>
Date:   Thu, 29 Aug 2019 14:26:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2db76c55-df5f-5ca8-f0a6-bcee75b8edaa@c-s.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/28 13:47, Christophe Leroy wrote:
> 
> 
> Le 28/08/2019 à 06:54, Scott Wood a écrit :
>> On Fri, Aug 09, 2019 at 06:07:54PM +0800, Jason Yan wrote:
>>> This patch add support to boot kernel from places other than KERNELBASE.
>>> Since CONFIG_RELOCATABLE has already supported, what we need to do is
>>> map or copy kernel to a proper place and relocate. Freescale Book-E
>>> parts expect lowmem to be mapped by fixed TLB entries(TLB1). The TLB1
>>> entries are not suitable to map the kernel directly in a randomized
>>> region, so we chose to copy the kernel to a proper place and restart to
>>> relocate.
>>>
>>> The offset of the kernel was not randomized yet(a fixed 64M is set). We
>>> will randomize it in the next patch.
>>>
>>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>>> Cc: Diana Craciun <diana.craciun@nxp.com>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Tested-by: Diana Craciun <diana.craciun@nxp.com>
>>> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/Kconfig                          | 11 ++++
>>>   arch/powerpc/kernel/Makefile                  |  1 +
>>>   arch/powerpc/kernel/early_32.c                |  2 +-
>>>   arch/powerpc/kernel/fsl_booke_entry_mapping.S | 17 +++--
>>>   arch/powerpc/kernel/head_fsl_booke.S          | 13 +++-
>>>   arch/powerpc/kernel/kaslr_booke.c             | 62 +++++++++++++++++++
>>>   arch/powerpc/mm/mmu_decl.h                    |  7 +++
>>>   arch/powerpc/mm/nohash/fsl_booke.c            |  7 ++-
>>>   8 files changed, 105 insertions(+), 15 deletions(-)
>>>   create mode 100644 arch/powerpc/kernel/kaslr_booke.c
>>>
> 
> [...]
> 
>>> diff --git a/arch/powerpc/kernel/kaslr_booke.c 
>>> b/arch/powerpc/kernel/kaslr_booke.c
>>> new file mode 100644
>>> index 000000000000..f8dc60534ac1
>>> --- /dev/null
>>> +++ b/arch/powerpc/kernel/kaslr_booke.c
>>
>> Shouldn't this go under arch/powerpc/mm/nohash?
>>
>>> +/*
>>> + * To see if we need to relocate the kernel to a random offset
>>> + * void *dt_ptr - address of the device tree
>>> + * phys_addr_t size - size of the first memory block
>>> + */
>>> +notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
>>> +{
>>> +    unsigned long tlb_virt;
>>> +    phys_addr_t tlb_phys;
>>> +    unsigned long offset;
>>> +    unsigned long kernel_sz;
>>> +
>>> +    kernel_sz = (unsigned long)_end - KERNELBASE;
>>
>> Why KERNELBASE and not kernstart_addr?
>>
>>> +
>>> +    offset = kaslr_choose_location(dt_ptr, size, kernel_sz);
>>> +
>>> +    if (offset == 0)
>>> +        return;
>>> +
>>> +    kernstart_virt_addr += offset;
>>> +    kernstart_addr += offset;
>>> +
>>> +    is_second_reloc = 1;
>>> +
>>> +    if (offset >= SZ_64M) {
>>> +        tlb_virt = round_down(kernstart_virt_addr, SZ_64M);
>>> +        tlb_phys = round_down(kernstart_addr, SZ_64M);
>>
>> If kernstart_addr wasn't 64M-aligned before adding offset, then "offset
>>> = SZ_64M" is not necessarily going to detect when you've crossed a
>> mapping boundary.
>>
>>> +
>>> +        /* Create kernel map to relocate in */
>>> +        create_tlb_entry(tlb_phys, tlb_virt, 1);
>>> +    }
>>> +
>>> +    /* Copy the kernel to it's new location and run */
>>> +    memcpy((void *)kernstart_virt_addr, (void *)KERNELBASE, kernel_sz);
>>> +
>>> +    reloc_kernel_entry(dt_ptr, kernstart_virt_addr);
>>> +}
>>
>> After copying, call flush_icache_range() on the destination.
> 
> Function copy_and_flush() does the copy and the flush. I think it should 
> be used instead of memcpy() + flush_icache_range()
> 

Hi Christophe,

Thanks for the suggestion. But I think copy_and_flush() is not included 
in fsl booke code, maybe move this function to misc.S?

> Christophe
> 
> .
> 

