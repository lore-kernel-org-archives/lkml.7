Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C522206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfFMP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:28:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728927AbfFML2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:28:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6D86DE8FDE300608686F;
        Thu, 13 Jun 2019 19:27:48 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Jun 2019
 19:27:43 +0800
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
To:     James Morse <james.morse@arm.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <51995efd-8469-7c15-0d5e-935b63fe2d9f@arm.com>
CC:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <rppt@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <ebiederm@xmission.com>, <horms@verge.net.au>,
        <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <638a5d22-8d51-8d63-2d8a-a38bbb8fb1d6@huawei.com>
Date:   Thu, 13 Jun 2019 19:27:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <51995efd-8469-7c15-0d5e-935b63fe2d9f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/6 0:32, James Morse wrote:
> Hi!
> 
> On 07/05/2019 04:50, Chen Zhou wrote:
>> We use crashkernel=X to reserve crashkernel below 4G, which will fail
>> when there is no enough memory. Currently, crashkernel=Y@X can be used
>> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
>> are requierd, capture kernel will boot failure because of no low memory.
> 
>> When crashkernel is reserved above 4G in memory, kernel should reserve
>> some amount of low memory for swiotlb and some DMA buffers. So there may
>> be two crash kernel regions, one is below 4G, the other is above 4G.
> 
> This is a good argument for supporting the 'crashkernel=...,low' version.
> What is the 'crashkernel=...,high' version for?
> 
> Wouldn't it be simpler to relax the ARCH_LOW_ADDRESS_LIMIT if we see 'crashkernel=...,low'
> in the kernel cmdline?
> 
> I don't see what the 'crashkernel=...,high' variant is giving us, it just complicates the
> flow of reserve_crashkernel().
> 
> If we called reserve_crashkernel_low() at the beginning of reserve_crashkernel() we could
> use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
> memblock_end_of_DRAM().
> I think this is a simpler change that gives you what you want.

According to your suggestions, we should do like this:
1. call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
2. mark the low region as 'nomap'
3. use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
memblock_end_of_DRAM()
4. rename crashk_low_res as "Crash kernel (low)" for arm64
5. add an 'linux,low-memory-range' node in DT

Do i understand correctly?

> 
> 
>> Then
>> Crash dump kernel reads more than one crash kernel regions via a dtb
>> property under node /chosen,
>> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
> 
> Won't this break if your kdump kernel doesn't know what the extra parameters are?
> Or if it expects two ranges, but only gets one? These DT properties should be treated as
> ABI between kernel versions, we can't really change it like this.
> 
> I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
> think the simplest thing to do is to add an 'linux,low-memory-range' that we
> memblock_add() after memblock_cap_memory_range() has been called.
> If its missing, or the new kernel doesn't know what its for, everything keeps working.
> 
> 
>> Besides, we need to modify kexec-tools:
>>   arm64: support more than one crash kernel regions(see [1])
> 
>> I post this patch series about one month ago. The previous changes and
>> discussions can be retrived from:
> 
> Ah, this wasn't obvious as you've stopped numbering the series. Please label the next one
> 'v6' so that we can describe this as 'v5'. (duplicate numbering would be even more confusing!)
> 
ok.

> 
> Thanks,
> 
> James
> 
> .
> 

Thanks,
Chen Zhou

