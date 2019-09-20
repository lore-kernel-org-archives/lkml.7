Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC35C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 11:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D862086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 11:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408804AbfITL6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 07:58:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404368AbfITL6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:58:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4CA721C0E8ACA61F84EB;
        Fri, 20 Sep 2019 19:58:02 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 19:57:59 +0800
Subject: Re: [PATCH 07/32] x86: Use pr_warn instead of pr_warning
To:     Robert Richter <rric@kernel.org>
CC:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-8-wangkefeng.wang@huawei.com>
 <20190920092850.26usohzmatmqrlor@rric.localdomain>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <7a517b43-7e86-79ba-5954-dd746c309c87@huawei.com>
Date:   Fri, 20 Sep 2019 19:57:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920092850.26usohzmatmqrlor@rric.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/20 17:28, Robert Richter wrote:
> On 20.09.19 14:25:19, Kefeng Wang wrote:
>> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
>> pr_warning"), removing pr_warning so all logging messages use a
>> consistent <prefix>_warn style. Let's do it.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Robert Richter <rric@kernel.org>
>> Cc: Darren Hart <dvhart@infradead.org>
>> Cc: Andy Shevchenko <andy@infradead.org>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  arch/x86/kernel/amd_gart_64.c          | 11 ++++---
>>  arch/x86/kernel/apic/apic.c            | 41 ++++++++++++--------------
>>  arch/x86/kernel/setup_percpu.c         |  4 +--
>>  arch/x86/kernel/tboot.c                | 15 +++++-----
>>  arch/x86/kernel/tsc_sync.c             |  8 ++---
>>  arch/x86/kernel/umip.c                 |  6 ++--
>>  arch/x86/mm/kmmio.c                    |  7 ++---
>>  arch/x86/mm/mmio-mod.c                 |  6 ++--
>>  arch/x86/mm/numa_emulation.c           |  4 +--
>>  arch/x86/mm/testmmiotrace.c            |  6 ++--
>>  arch/x86/oprofile/op_x86_model.h       |  6 ++--
> For oprofile:
>
> Acked-by: Robert Richter <rric@kernel.org>
>
> But see below:
>
>>  arch/x86/platform/olpc/olpc-xo15-sci.c |  2 +-
>>  arch/x86/platform/sfi/sfi.c            |  3 +-
>>  arch/x86/xen/setup.c                   |  2 +-
>>  14 files changed, 57 insertions(+), 64 deletions(-)
>>
>> diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
>> index a585ea6f686a..53545c9c7cad 100644
>> --- a/arch/x86/kernel/amd_gart_64.c
>> +++ b/arch/x86/kernel/amd_gart_64.c
>> @@ -665,7 +664,7 @@ static __init int init_amd_gatt(struct agp_kern_info *info)
>>  
>>   nommu:
>>  	/* Should not happen anymore */
>> -	pr_warning("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
>> +	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
>>  	       "falling back to iommu=soft.\n");
> This indentation should be fixed too, while at it.
Will update later, thanks.
>
>>  	return -1;
>>  }
> -Robert
>
> .
>

