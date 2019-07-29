Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88DAC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B953820578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfG2N71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:59:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33868 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfG2N71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:59:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC2E8B87C8480C7DA8F3;
        Mon, 29 Jul 2019 21:43:42 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 21:43:36 +0800
Subject: Re: [RFC PATCH 08/10] powerpc/fsl_booke/kaslr: clear the original
 kernel if randomized
To:     Christophe Leroy <christophe.leroy@c-s.fr>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>
References: <20190717080621.40424-1-yanaijie@huawei.com>
 <20190717080621.40424-9-yanaijie@huawei.com>
 <a09b4f53-2ccd-e675-4385-b53fd91fbafc@c-s.fr>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <704624a1-36b7-50d7-cf8d-2923b2a97367@huawei.com>
Date:   Mon, 29 Jul 2019 21:43:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a09b4f53-2ccd-e675-4385-b53fd91fbafc@c-s.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/29 19:19, Christophe Leroy wrote:
> 
> 
> Le 17/07/2019 à 10:06, Jason Yan a écrit :
>> The original kernel still exists in the memory, clear it now.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Cc: Diana Craciun <diana.craciun@nxp.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/powerpc/kernel/kaslr_booke.c  | 11 +++++++++++
>>   arch/powerpc/mm/mmu_decl.h         |  2 ++
>>   arch/powerpc/mm/nohash/fsl_booke.c |  1 +
>>   3 files changed, 14 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/kaslr_booke.c 
>> b/arch/powerpc/kernel/kaslr_booke.c
>> index 90357f4bd313..00339c05879f 100644
>> --- a/arch/powerpc/kernel/kaslr_booke.c
>> +++ b/arch/powerpc/kernel/kaslr_booke.c
>> @@ -412,3 +412,14 @@ notrace void __init kaslr_early_init(void 
>> *dt_ptr, phys_addr_t size)
>>       reloc_kernel_entry(dt_ptr, kimage_vaddr);
>>   }
>> +
>> +void __init kaslr_second_init(void)
>> +{
>> +    /* If randomized, clear the original kernel */
>> +    if (kimage_vaddr != KERNELBASE) {
>> +        unsigned long kernel_sz;
>> +
>> +        kernel_sz = (unsigned long)_end - kimage_vaddr;
>> +        memset((void *)KERNELBASE, 0, kernel_sz);
> 
> Why are we clearing ? Is that just to tidy up or is it of security 
> importance ?
> 

If we leave it there, attackers can still find the kernel object very
easy, it's still dangerous especially if without 
CONFIG_STRICT_KERNEL_RWX enabled.

> If so, maybe memzero_explicit() should be used instead ?
> 

OK

>> +    }
>> +}
>> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
>> index 754ae1e69f92..9912ee598f9b 100644
>> --- a/arch/powerpc/mm/mmu_decl.h
>> +++ b/arch/powerpc/mm/mmu_decl.h
>> @@ -150,8 +150,10 @@ extern void loadcam_multi(int first_idx, int num, 
>> int tmp_idx);
>>   #ifdef CONFIG_RANDOMIZE_BASE
>>   extern void kaslr_early_init(void *dt_ptr, phys_addr_t size);
>> +extern void kaslr_second_init(void);
> 
> No new 'extern' please.
> 
>>   #else
>>   static inline void kaslr_early_init(void *dt_ptr, phys_addr_t size) {}
>> +static inline void kaslr_second_init(void) {}
>>   #endif
>>   struct tlbcam {
>> diff --git a/arch/powerpc/mm/nohash/fsl_booke.c 
>> b/arch/powerpc/mm/nohash/fsl_booke.c
>> index 8d25a8dc965f..fa5a87f5c08e 100644
>> --- a/arch/powerpc/mm/nohash/fsl_booke.c
>> +++ b/arch/powerpc/mm/nohash/fsl_booke.c
>> @@ -269,6 +269,7 @@ notrace void __init relocate_init(u64 dt_ptr, 
>> phys_addr_t start)
>>       kernstart_addr = start;
>>       if (is_second_reloc) {
>>           virt_phys_offset = PAGE_OFFSET - memstart_addr;
>> +        kaslr_second_init();
>>           return;
>>       }
>>
> 
> Christophe
> 
> .
> 

