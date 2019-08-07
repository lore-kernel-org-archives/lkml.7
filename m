Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB155C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7776F20665
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 03:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfHGDQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 23:16:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbfHGDQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:16:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10C93FA9AE40F21242A4;
        Wed,  7 Aug 2019 11:16:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 11:16:20 +0800
Subject: Re: [PATCH v4 07/10] powerpc/fsl_booke/32: randomize the kernel image
 offset
To:     Christophe Leroy <christophe.leroy@c-s.fr>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <diana.craciun@nxp.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>
References: <20190805064335.19156-1-yanaijie@huawei.com>
 <20190805064335.19156-8-yanaijie@huawei.com>
 <3edec35b-8d61-07ff-558d-2d7e0c28a0e2@c-s.fr>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <16e058a4-9794-6998-46e4-0e63b9fce7e3@huawei.com>
Date:   Wed, 7 Aug 2019 11:16:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <3edec35b-8d61-07ff-558d-2d7e0c28a0e2@c-s.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/8/6 15:56, Christophe Leroy wrote:
> 
> 
> Le 05/08/2019 à 08:43, Jason Yan a écrit :
>> After we have the basic support of relocate the kernel in some
>> appropriate place, we can start to randomize the offset now.
>>
>> Entropy is derived from the banner and timer, which will change every
>> build and boot. This not so much safe so additionally the bootloader may
>> pass entropy via the /chosen/kaslr-seed node in device tree.
>>
>> We will use the first 512M of the low memory to randomize the kernel
>> image. The memory will be split in 64M zones. We will use the lower 8
>> bit of the entropy to decide the index of the 64M zone. Then we chose a
>> 16K aligned offset inside the 64M zone to put the kernel in.
>>
>>      KERNELBASE
>>
>>          |-->   64M   <--|
>>          |               |
>>          +---------------+    +----------------+---------------+
>>          |               |....|    |kernel|    |               |
>>          +---------------+    +----------------+---------------+
>>          |                         |
>>          |----->   offset    <-----|
>>
>>                                kimage_vaddr
>>
>> We also check if we will overlap with some areas like the dtb area, the
>> initrd area or the crashkernel area. If we cannot find a proper area,
>> kaslr will be disabled and boot from the original kernel.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Cc: Diana Craciun <diana.craciun@nxp.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
>> Tested-by: Diana Craciun <diana.craciun@nxp.com>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 

Thanks for your help,

> One small comment below
> 
>> ---
>>   arch/powerpc/kernel/kaslr_booke.c | 322 +++++++++++++++++++++++++++++-
>>   1 file changed, 320 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/kaslr_booke.c 
>> b/arch/powerpc/kernel/kaslr_booke.c
>> index 30f84c0321b2..97250cad71de 100644
>> --- a/arch/powerpc/kernel/kaslr_booke.c
>> +++ b/arch/powerpc/kernel/kaslr_booke.c
>> @@ -23,6 +23,8 @@
>>   #include <linux/delay.h>
>>   #include <linux/highmem.h>
>>   #include <linux/memblock.h>
>> +#include <linux/libfdt.h>
>> +#include <linux/crash_core.h>
>>   #include <asm/pgalloc.h>
>>   #include <asm/prom.h>
>>   #include <asm/io.h>
>> @@ -34,15 +36,329 @@
>>   #include <asm/machdep.h>
>>   #include <asm/setup.h>
>>   #include <asm/paca.h>
>> +#include <asm/kdump.h>
>>   #include <mm/mmu_decl.h>
>> +#include <generated/compile.h>
>> +#include <generated/utsrelease.h>
>> +
>> +#ifdef DEBUG
>> +#define DBG(fmt...) printk(KERN_ERR fmt)
>> +#else
>> +#define DBG(fmt...)
>> +#endif
>> +
>> +struct regions {
>> +    unsigned long pa_start;
>> +    unsigned long pa_end;
>> +    unsigned long kernel_size;
>> +    unsigned long dtb_start;
>> +    unsigned long dtb_end;
>> +    unsigned long initrd_start;
>> +    unsigned long initrd_end;
>> +    unsigned long crash_start;
>> +    unsigned long crash_end;
>> +    int reserved_mem;
>> +    int reserved_mem_addr_cells;
>> +    int reserved_mem_size_cells;
>> +};
>>   extern int is_second_reloc;
>> +/* Simplified build-specific string for starting entropy. */
>> +static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
>> +        LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
>> +
>> +static __init void kaslr_get_cmdline(void *fdt)
>> +{
>> +    int node = fdt_path_offset(fdt, "/chosen");
>> +
>> +    early_init_dt_scan_chosen(node, "chosen", 1, boot_command_line);
>> +}
>> +
>> +static unsigned long __init rotate_xor(unsigned long hash, const void 
>> *area,
>> +                       size_t size)
>> +{
>> +    size_t i;
>> +    unsigned long *ptr = (unsigned long *)area;
> 
> As area is a void *, this cast shouldn't be necessary. Or maybe it is 
> necessary because it discards the const ?
> 

It's true the cast is not necessary. The ptr can be made const and then 
remove the cast.

> Christophe
> 

