Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F6C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F6A214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfHHIjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:39:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4220 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfHHIjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:39:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E49C46160CF7EB186C3B;
        Thu,  8 Aug 2019 16:39:37 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 16:39:27 +0800
Subject: Re: [PATCH v5 10/10] powerpc/fsl_booke/kaslr: dump out kernel offset
 information on panic
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
 <20190807065706.11411-11-yanaijie@huawei.com>
 <87zhklt9eg.fsf@concordia.ellerman.id.au>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <9113cc5b-0e89-f423-712a-79220af82b92@huawei.com>
Date:   Thu, 8 Aug 2019 16:39:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87zhklt9eg.fsf@concordia.ellerman.id.au>
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
>> When kaslr is enabled, the kernel offset is different for every boot.
>> This brings some difficult to debug the kernel. Dump out the kernel
>> offset when panic so that we can easily debug the kernel.
> 
> Some of this is taken from the arm64 version right? Please say so when
> you copy other people's code.
> 

No problem. Architectures like x86 or arm64 or s390 both have this
similar code. I guess x86 is the first one.

>> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
>> index c4ed328a7b96..078fe3d76feb 100644
>> --- a/arch/powerpc/kernel/machine_kexec.c
>> +++ b/arch/powerpc/kernel/machine_kexec.c
>> @@ -86,6 +86,7 @@ void arch_crash_save_vmcoreinfo(void)
>>   	VMCOREINFO_STRUCT_SIZE(mmu_psize_def);
>>   	VMCOREINFO_OFFSET(mmu_psize_def, shift);
>>   #endif
>> +	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
>>   }
> 
> There's no mention of that in the commit log.
> 
> Please split it into a separate patch and describe what you're doing and
> why.

OK

> 
>> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
>> index 1f8db666468d..064075f02837 100644
>> --- a/arch/powerpc/kernel/setup-common.c
>> +++ b/arch/powerpc/kernel/setup-common.c
>> @@ -715,12 +715,31 @@ static struct notifier_block ppc_panic_block = {
>>   	.priority = INT_MIN /* may not return; must be done last */
>>   };
>>   
>> +/*
>> + * Dump out kernel offset information on panic.
>> + */
>> +static int dump_kernel_offset(struct notifier_block *self, unsigned long v,
>> +			      void *p)
>> +{
>> +	pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
>> +		 kaslr_offset(), KERNELBASE);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct notifier_block kernel_offset_notifier = {
>> +	.notifier_call = dump_kernel_offset
>> +};
>> +
>>   void __init setup_panic(void)
>>   {
>>   	/* PPC64 always does a hard irq disable in its panic handler */
>>   	if (!IS_ENABLED(CONFIG_PPC64) && !ppc_md.panic)
>>   		return;
>>   	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
> 
>> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0)
>> +		atomic_notifier_chain_register(&panic_notifier_list,
>> +					       &kernel_offset_notifier);
> 
> Don't you want to do that before the return above?
> 

Eagle eye. This should not affected by the conditions above.

>>   }
> 
> cheers
> 
> .
> 

