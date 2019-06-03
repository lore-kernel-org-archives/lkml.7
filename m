Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD27C28CC5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AF027AD5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 02:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfFCCYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 22:24:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfFCCYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:24:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 108B9137E52AEBD42766;
        Mon,  3 Jun 2019 10:24:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Jun 2019
 10:24:08 +0800
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
To:     Bhupesh Sharma <bhsharma@redhat.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <akpm@linux-foundation.org>,
        <ard.biesheuvel@linaro.org>, <rppt@linux.ibm.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <ebiederm@xmission.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <a9d017d0-82d3-3e5f-4af2-4c611393106d@redhat.com>
 <bf4050c5-cfb7-fd69-4892-1e0b65861d34@huawei.com>
CC:     <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <takahiro.akashi@linaro.org>, <horms@verge.net.au>,
        <linux-arm-kernel@lists.infradead.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <1567962e-f60b-60c2-1f73-10e07377be1e@huawei.com>
Date:   Mon, 3 Jun 2019 10:24:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <bf4050c5-cfb7-fd69-4892-1e0b65861d34@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Sorry to ping you.
What's your suggestion about this patch series? I am looking forward to your replay.

Thanks,
Chen Zhou


On 2019/5/16 11:19, Chen Zhou wrote:
> Hi Bhupesh,
> 
> On 2019/5/15 13:06, Bhupesh Sharma wrote:
>> +Cc kexec-list.
>>
>> Hi Chen,
>>
>> I think we are still in the quiet period of the merge cycle, but this is a change which will be useful for systems like HPE Apollo where we are looking at reserving crashkernel across a larger range.
>>
>> Some comments inline and in respective patch threads..
>>
>> On 05/07/2019 09:20 AM, Chen Zhou wrote:
>>> This patch series enable reserving crashkernel on high memory in arm64.
>>
>> Please fix the patch subject, it should be v5.
>> Also please Cc the kexec-list (kexec@lists.infradead.org) for future versions to allow wider review of the patchset.
>>
>>> We use crashkernel=X to reserve crashkernel below 4G, which will fail
>>> when there is no enough memory. Currently, crashkernel=Y@X can be used
>>> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
>>> are requierd, capture kernel will boot failure because of no low memory.
>>
>> ... ^^ required
>>
>> s/capture kernel will boot failure because of no low memory./capture kernel boot will fail because there is no low memory available for allocation.
>>
>>> When crashkernel is reserved above 4G in memory, kernel should reserve
>>> some amount of low memory for swiotlb and some DMA buffers. So there may
>>> be two crash kernel regions, one is below 4G, the other is above 4G. Then
>>> Crash dump kernel reads more than one crash kernel regions via a dtb
>>> property under node /chosen,
>>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
>>
>> Please use consistent naming for the second kernel, better to use crash dump kernel.
>>
>> I have tested this on my HPE Apollo machine and with crashkernel=886M,high syntax, I can get the board to reserve a larger memory range for the crashkernel (i.e. 886M):
>>
>> # dmesg | grep -i crash
>> [    0.000000] kexec_core: Reserving 256MB of low memory at 3560MB for crashkernel (System low RAM: 2029MB)
>> [    0.000000] crashkernel reserved: 0x0000000bc5a00000 - 0x0000000bfd000000 (886 MB)
>>
>> kexec/kdump can also work also work fine on the board.
>>
>> So, with the changes suggested in this cover letter and individual patches, please feel free to add:
>>
>> Reviewed-and-Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
>>
>> Thanks,
>> Bhupesh
>>
> 
> Thanks for you review and test. I will fix these later.
> 
> Thanks,
> Chen Zhou
> 
>>> Besides, we need to modify kexec-tools:
>>>    arm64: support more than one crash kernel regions(see [1])
>>>
>>> I post this patch series about one month ago. The previous changes and
>>> discussions can be retrived from:
>>>
>>> Changes since [v4]
>>> - reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>>>
>>> Changes since [v3]
>>> - Add memblock_cap_memory_ranges back for multiple ranges.
>>> - Fix some compiling warnings.
>>>
>>> Changes since [v2]
>>> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
>>>    two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
>>>    patch.
>>>
>>> Changes since [v1]:
>>> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
>>> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
>>>    in fdt_enforce_memory_region().
>>>    There are at most two crash kernel regions, for two crash kernel regions
>>>    case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
>>>    and then remove the memory range in the middle.
>>>
>>> [1]: http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
>>> [v1]: https://lkml.org/lkml/2019/4/2/1174
>>> [v2]: https://lkml.org/lkml/2019/4/9/86
>>> [v3]: https://lkml.org/lkml/2019/4/9/306
>>> [v4]: https://lkml.org/lkml/2019/4/15/273
>>>
>>> Chen Zhou (3):
>>>    x86: kdump: move reserve_crashkernel_low() into kexec_core.c
>>>    arm64: kdump: support reserving crashkernel above 4G
>>>    kdump: update Documentation about crashkernel on arm64
>>>
>>> Mike Rapoport (1):
>>>    memblock: extend memblock_cap_memory_range to multiple ranges
>>>
>>>   Documentation/admin-guide/kernel-parameters.txt |  6 +--
>>>   arch/arm64/include/asm/kexec.h                  |  3 ++
>>>   arch/arm64/kernel/setup.c                       |  3 ++
>>>   arch/arm64/mm/init.c                            | 72 +++++++++++++++++++------
>>>   arch/x86/include/asm/kexec.h                    |  3 ++
>>>   arch/x86/kernel/setup.c                         | 66 +++--------------------
>>>   include/linux/kexec.h                           |  5 ++
>>>   include/linux/memblock.h                        |  2 +-
>>>   kernel/kexec_core.c                             | 56 +++++++++++++++++++
>>>   mm/memblock.c                                   | 44 +++++++--------
>>>   10 files changed, 157 insertions(+), 103 deletions(-)
>>>
>>
>>
>> .
>>
> 
> 
> .
> 

