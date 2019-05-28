Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C65C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFCF20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfE1GZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:25:02 -0400
Received: from foss.arm.com ([217.140.101.70]:49616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfE1GY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:24:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CF1AA78;
        Mon, 27 May 2019 23:24:59 -0700 (PDT)
Received: from [192.168.1.27] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDF5D3F690;
        Mon, 27 May 2019 23:24:56 -0700 (PDT)
Subject: Re: [PATCH 1/4] arm64: module: create module allocations without exec
 permissions
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, marc.zyngier@arm.com,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20190523102256.29168-1-ard.biesheuvel@arm.com>
 <20190523102256.29168-2-ard.biesheuvel@arm.com>
 <d82eb4fe-8113-3f8e-f465-26679ebae2df@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <f67efae5-1565-5459-2877-31bdd1a40c0f@arm.com>
Date:   Tue, 28 May 2019 08:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d82eb4fe-8113-3f8e-f465-26679ebae2df@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 7:35 AM, Anshuman Khandual wrote:
> 
> 
> On 05/23/2019 03:52 PM, Ard Biesheuvel wrote:
>> Now that the core code manages the executable permissions of code
>> regions of modules explicitly, it is no longer necessary to create
> 
> I guess the permission transition for various module sections happen
> through module_enable_[ro|nx]() after allocating via module_alloc().
> 

Indeed.

>> the module vmalloc regions with RWX permissions, and we can create
>> them with RW- permissions instead, which is preferred from a
>> security perspective.
> 
> Makes sense. Will this be followed in all architectures now ?
> 

I am not sure if every architecture implements module_enable_[ro|nx](), 
but if they do, they should probably apply this change as well.

>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
>> ---
>>   arch/arm64/kernel/module.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
>> index 2e4e3915b4d0..88f0ed31d9aa 100644
>> --- a/arch/arm64/kernel/module.c
>> +++ b/arch/arm64/kernel/module.c
>> @@ -41,7 +41,7 @@ void *module_alloc(unsigned long size)
>>   
>>   	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>>   				module_alloc_base + MODULES_VSIZE,
>> -				gfp_mask, PAGE_KERNEL_EXEC, 0,
>> +				gfp_mask, PAGE_KERNEL, 0,
>>   				NUMA_NO_NODE, __builtin_return_address(0));
>>   
>>   	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
>> @@ -57,7 +57,7 @@ void *module_alloc(unsigned long size)
>>   		 */
>>   		p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>>   				module_alloc_base + SZ_4G, GFP_KERNEL,
>> -				PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
>> +				PAGE_KERNEL, 0, NUMA_NO_NODE,
>>   				__builtin_return_address(0));
>>   
>>   	if (p && (kasan_module_alloc(p, size) < 0)) {
>>
> 
> Which just makes sure that PTE_PXN never gets dropped while creating
> these mappings.
> 

Not sure what you mean. Is there a question here?


