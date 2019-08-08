Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF3C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE04C21743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfHHE3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:29:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbfHHE3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:29:20 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43D6FA41CF4B4EF45A55;
        Thu,  8 Aug 2019 12:29:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 12:29:10 +0800
Subject: Re: [PATCH v5 03/10] powerpc: introduce kimage_vaddr to store the
 kernel base
To:     Michael Ellerman <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <christophe.leroy@c-s.fr>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>
References: <20190807065706.11411-1-yanaijie@huawei.com>
 <20190807065706.11411-4-yanaijie@huawei.com>
 <8736idunz8.fsf@concordia.ellerman.id.au>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <df60a486-d2ff-aeb2-f7fa-93e89026ae9a@huawei.com>
Date:   Thu, 8 Aug 2019 12:29:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8736idunz8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/7 21:03, Michael Ellerman wrote:
> Jason Yan <yanaijie@huawei.com> writes:
>> Now the kernel base is a fixed value - KERNELBASE. To support KASLR, we
>> need a variable to store the kernel base.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Cc: Diana Craciun <diana.craciun@nxp.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
>> Tested-by: Diana Craciun <diana.craciun@nxp.com>
>> ---
>>   arch/powerpc/include/asm/page.h | 2 ++
>>   arch/powerpc/mm/init-common.c   | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>> index 0d52f57fca04..60a68d3a54b1 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -315,6 +315,8 @@ void arch_free_page(struct page *page, int order);
>>   
>>   struct vm_area_struct;
>>   
>> +extern unsigned long kimage_vaddr;
>> +
>>   #include <asm-generic/memory_model.h>
>>   #endif /* __ASSEMBLY__ */
>>   #include <asm/slice.h>
>> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
>> index 152ae0d21435..d4801ce48dc5 100644
>> --- a/arch/powerpc/mm/init-common.c
>> +++ b/arch/powerpc/mm/init-common.c
>> @@ -25,6 +25,8 @@ phys_addr_t memstart_addr = (phys_addr_t)~0ull;
>>   EXPORT_SYMBOL_GPL(memstart_addr);
>>   phys_addr_t kernstart_addr;
>>   EXPORT_SYMBOL_GPL(kernstart_addr);
>> +unsigned long kimage_vaddr = KERNELBASE;
>> +EXPORT_SYMBOL_GPL(kimage_vaddr);
> 
> The names of the #defines and variables we use for these values are not
> very consistent already, but using kimage_vaddr makes it worse I think.
> 
> Isn't this going to have the same value as kernstart_addr, but the
> virtual rather than physical address?
> 

Yes, that's true.

> If so kernstart_virt_addr would seem better.
> 

OK, I will take kernstart_virt_addr if no better name appears.

> cheers
> 
> .
> 

