Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2633BC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052A02054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbfFMPWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:22:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731988AbfFMMnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:43:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E04BE2B;
        Thu, 13 Jun 2019 05:43:20 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76DA33F694;
        Thu, 13 Jun 2019 05:43:18 -0700 (PDT)
Subject: Re: [PATCH 0/4] support reserving crashkernel above 4G on arm64 kdump
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        rppt@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, ebiederm@xmission.com, horms@verge.net.au,
        takahiro.akashi@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com
References: <20190507035058.63992-1-chenzhou10@huawei.com>
 <51995efd-8469-7c15-0d5e-935b63fe2d9f@arm.com>
 <638a5d22-8d51-8d63-2d8a-a38bbb8fb1d6@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <72a9c52b-1b24-57e8-e29f-b5a53524744b@arm.com>
Date:   Thu, 13 Jun 2019 13:43:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <638a5d22-8d51-8d63-2d8a-a38bbb8fb1d6@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen Zhou,

On 13/06/2019 12:27, Chen Zhou wrote:
> On 2019/6/6 0:32, James Morse wrote:
>> On 07/05/2019 04:50, Chen Zhou wrote:
>>> We use crashkernel=X to reserve crashkernel below 4G, which will fail
>>> when there is no enough memory. Currently, crashkernel=Y@X can be used
>>> to reserve crashkernel above 4G, in this case, if swiotlb or DMA buffers
>>> are requierd, capture kernel will boot failure because of no low memory.
>>
>>> When crashkernel is reserved above 4G in memory, kernel should reserve
>>> some amount of low memory for swiotlb and some DMA buffers. So there may
>>> be two crash kernel regions, one is below 4G, the other is above 4G.
>>
>> This is a good argument for supporting the 'crashkernel=...,low' version.
>> What is the 'crashkernel=...,high' version for?
>>
>> Wouldn't it be simpler to relax the ARCH_LOW_ADDRESS_LIMIT if we see 'crashkernel=...,low'
>> in the kernel cmdline?
>>
>> I don't see what the 'crashkernel=...,high' variant is giving us, it just complicates the
>> flow of reserve_crashkernel().
>>
>> If we called reserve_crashkernel_low() at the beginning of reserve_crashkernel() we could
>> use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
>> memblock_end_of_DRAM().
>> I think this is a simpler change that gives you what you want.
> 
> According to your suggestions, we should do like this:
> 1. call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
> 2. mark the low region as 'nomap'
> 3. use crashk_low_res.end to change some limit variable from ARCH_LOW_ADDRESS_LIMIT to
> memblock_end_of_DRAM()
> 4. rename crashk_low_res as "Crash kernel (low)" for arm64

> 5. add an 'linux,low-memory-range' node in DT

(This bit would happen in kexec-tools)


> Do i understand correctly?

Yes, I think this is simpler and still gives you what you want.
It also leaves the existing behaviour unchanged, which helps with keeping compatibility
with existing user-space and older kdump kernels.


Thanks,

James
