Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E00BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5720645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dfVA0Hgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfCYWDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:03:17 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6188 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfCYWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:03:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9950250002>; Mon, 25 Mar 2019 15:03:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 15:03:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 25 Mar 2019 15:03:14 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Mar
 2019 22:03:14 +0000
Subject: Re: [PATCH 1/1] x86/mm: Fix limit mmap() of /dev/mem to valid
 physical addresses
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Craig Bergstrom <craigb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Sean Young <sean@mess.org>, Ingo Molnar <mingo@kernel.org>
References: <20190318224653.26549-1-rcampbell@nvidia.com>
 <20190318224653.26549-2-rcampbell@nvidia.com>
 <alpine.DEB.2.21.1903231840100.1798@nanos.tec.linutronix.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <39b65bda-cef5-4ea2-ddaa-418e8e71e306@nvidia.com>
Date:   Mon, 25 Mar 2019 15:03:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903231840100.1798@nanos.tec.linutronix.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553551398; bh=RdQf0w1kH0blqaiDYjrJO7+525p5iLqlIS3aC4aJNp8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dfVA0HgsIXPkoPqskT84Sje7zO0kTcJKxIPQ0JU4N+A7wdRvdIk99xDjRCJY5WURl
         tWqiGJ/z9Tjiv4M3h+dBmv2r8G1JjFHx+Ef5vobOuFfLfwDy2r59G7M/aRTUn31XMv
         78q6BDsRHNSumOXcsvWpB2iOLOMB0vG6kxPm2Sgl7zmjGHyqF17B7b9oB0RfwnOl9k
         5dEBydL1aosMg/3CD9o8mjOzSHTvpYaqAs1EC6i//oNrFpUF/JAOJcpCT0nb/0FRvk
         VXNo2H8RIKk0Wb6gxhu21KyDWAFC0Pmco+qZMUMm4XBu3ac8Mt6ewddwX6mQJ1Ed7Y
         06GkjDlNE2hrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/19 12:02 PM, Thomas Gleixner wrote:
> Ralph,
> 
> On Mon, 18 Mar 2019, rcampbell@nvidia.com wrote:
>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
>> If CONFIG_DEBUG_VIRTUAL is enabled, a read or write to /dev/mem can
>> trigger a VIRTUAL_BUG_ON() depending on the value of high_memory.
>> For example:
>>
>> read_mem()
>>    valid_phys_addr_range(p=401f1550, count=8)
>>      __pa(high_memory)
>>        __phys_addr(x=ffffc88000000000)
>>          // __START_KERNEL_map = ffffffff80000000
>>          // y = ffffc88000000000 - ffffffff80000000
>>          VIRTUAL_BUG_ON(phys_addr_valid(400000000000))
>>            // boot_cpu_data.x86_phys_bits=46
> 
> I have no idea why all the irrelevant information in this example would be
> helpful, but after extracting the meat I think I know what you want to say.
> 
>> Since by design high_memory is outside the range of valid physical
>> addresses, use the non-error checking version __pa_nodebug(high_memory).
> 
> high_memory is not outside the range of valid physical addresses by
> design. It's only outside when memory is populated right at the end of the
> physical address space.
> 
> So what you really want to say in the changelog is:
> 
>   valid_phys_addr_range() is used to sanity check the physical address range
>   of an operation, e.g. access to /dev/mem. It uses __pa(high_memory)
>   internally.
>   
>   If memory is populated at the end of the physical address space, then
>   __pa(high_memory) is outside of the physical address space because:
> 
>       high_memory = (void *)__va(max_pfn * PAGE_SIZE - 1) + 1;
> 
>   For the comparison in valid_phys_addr_range() this is not an issue, but if
>   CONFIG_DEBUG_VIRTUAL is enabled, __pa() maps to __phys_addr(), which
>   verifies that the resulting physical address is within the valid physical
>   address space of the CPU. So in the case that memory is populated at the
>   end of the physical address space, this is not true and triggers a
>   VIRTUAL_BUG_ON().
> 
>   Use ... instead, because ...
> 
>> Fixes: be62a32044061cb4a3b70a10598e093f1319102e ("x86/mm: Limit mmap() of
> 
> Please limit the sha1 to the first 12 characters.
> 
>> /dev/mem to valid physical addresses")
>>
> 
> No newline between Fixes and the rest please.
> 
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> 

Thanks for the comments. I'll apply them and send a v2 when ready.

>> --- a/arch/x86/mm/mmap.c
>> +++ b/arch/x86/mm/mmap.c
>> @@ -230,7 +230,7 @@ bool mmap_address_hint_valid(unsigned long addr, unsigned long len)
>>   /* Can we access it for direct reading/writing? Must be RAM: */
>>   int valid_phys_addr_range(phys_addr_t addr, size_t count)
>>   {
>> -	return addr + count <= __pa(high_memory);
>> +	return addr + count <= __pa_nodebug(high_memory);
> 
> This lacks a comment. Aside of that I think there is no point in using
> __pa(high_memory) here. This is all about the physical address range. So
> this can be simply expressed via:
> 
> 	return addr + count <= max_pfn * PAGE_SIZE;
> 
> which is much more obvious.
> 
> Thanks,
> 
> 	tglx

This looks OK to me for x86_64 but looking at arch/x86/mm/init_32.c,
initmem_init() sets high_memory based on highstart_pfn or max_low_pfn
depending on CONFIG_HIGHMEM. Would using max_pfn in this case work?
