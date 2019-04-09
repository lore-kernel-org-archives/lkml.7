Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF790C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E3520880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDIJIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:08:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIJIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:08:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 90249B177B81D34F2DA8;
        Tue,  9 Apr 2019 17:08:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 17:08:01 +0800
Subject: Re: [PATCH 0/3] support reserving crashkernel above 4G on arm64 kdump
To:     Bhupesh Sharma <bhsharma@redhat.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <akpm@linux-foundation.org>,
        <rppt@linux.ibm.com>, <ard.biesheuvel@linaro.org>,
        <takahiro.akashi@linaro.org>
References: <20190403030546.23718-1-chenzhou10@huawei.com>
 <49012d55-2020-e2ac-1102-59a5f3911a29@redhat.com>
CC:     <wangkefeng.wang@huawei.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <573f2b4b-9a55-d9b2-6de5-0b60eba0b211@huawei.com>
Date:   Tue, 9 Apr 2019 17:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <49012d55-2020-e2ac-1102-59a5f3911a29@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 2019/4/9 13:20, Bhupesh Sharma wrote:
> Hi Chen,
> 
> Thanks for the patchset.
> 
> Before I review the patches in detail, I have a couple of generic queries. Please see them in-line:
> 
> On 04/03/2019 11:05 AM, Chen Zhou wrote:
>> When crashkernel is reserved above 4G in memory, kernel should reserve
>> some amount of low memory for swiotlb and some DMA buffers. So there may
>> be two crash kernel regions, one is below 4G, the other is above 4G.
>>
>> Crash dump kernel reads more than one crash kernel regions via a dtb
>> property under node /chosen,
>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
>>
>> Besides, we need to modify kexec-tools:
>>    arm64: support more than one crash kernel regions
>>
>> Chen Zhou (3):
>>    arm64: kdump: support reserving crashkernel above 4G
>>    arm64: kdump: support more than one crash kernel regions
>>    kdump: update Documentation about crashkernel on arm64
>>
>>   Documentation/admin-guide/kernel-parameters.txt |   4 +-
>>   arch/arm64/kernel/setup.c                       |   3 +
>>   arch/arm64/mm/init.c                            | 108 ++++++++++++++++++++----
>>   include/linux/memblock.h                        |   1 +
>>   mm/memblock.c                                   |  40 +++++++++
>>   5 files changed, 139 insertions(+), 17 deletions(-)
> 
> I am wondering about the use-case for the same. I remember normally fedora-based arm64 systems can do well with a maximum crashkernel size of <=512MB reserved below the 4G boundary.
> 
> So, do you mean that for your use-case (may be a huawei board based setup?), you need:
> 
> - more than 512MB of crashkernel size, or
> - you want to split the crashkernel reservation across the 4GB boundary irrespective of the crashkernel size value.
> 
> Thanks,
> Bhupesh
> 
> 
> .
> 

I do this based on below reasons.

1. ARM64 kdump support crashkernel=Y[@X], but now it seems unusable if X is specified above 4GB.
2. There are some cases we couldn't reserve 512MB crashkernel below 4G successfully if there is
no continous 512MB system RAM below 4GB. In this case, we need to reserve crashkernel above 4GB.
3. As the memory increases, the bitmap_size in makedumpfile may also increases, we need more memory
in kdump capture kernel for kernel dump.

Thanks,
Chen Zhou


