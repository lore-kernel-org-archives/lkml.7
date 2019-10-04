Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E0AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6F215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfJDKw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:52:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDKw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:52:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1F6915A1;
        Fri,  4 Oct 2019 03:52:25 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C78EC3F706;
        Fri,  4 Oct 2019 03:52:24 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Poison initmem while freeing with
 free_reserved_area()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <1570163038-32067-1-git-send-email-anshuman.khandual@arm.com>
 <600676fd-1b39-74f4-49a7-3c807ee24cff@arm.com>
 <50d88564-c645-62f4-b5b3-3ce7a4425b0a@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5d771515-e630-bc6e-b81b-8fd208c21011@arm.com>
Date:   Fri, 4 Oct 2019 11:52:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <50d88564-c645-62f4-b5b3-3ce7a4425b0a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 11:48, Anshuman Khandual wrote:
> 
> 
> On 10/04/2019 03:49 PM, Steven Price wrote:
>> On 04/10/2019 05:23, Anshuman Khandual wrote:
>>> Platform implementation for free_initmem() should poison the memory while
>>> freeing it up. Hence pass across POISON_FREE_INITMEM while calling into
>>> free_reserved_area(). The same is being followed in the generic fallback
>>> for free_initmem() and some other platforms overriding it.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> Is there a good reason you haven't made a similar change to
>> free_initrd_mem() - the same logic seems to apply. However this change
>> looks fine to me.
> 
> We will use generic free_initrd_mem() going forward as proposed in a recent
> patch which does call free_reserved_area() with POISON_FREE_INITMEM.
> 
> https://patchwork.kernel.org/patch/11165379/

Great - that sounds like a very good reason!

Thanks,

Steve

>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>>
>>> ---
>>>  arch/arm64/mm/init.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 45c00a54909c..ea7d38011e83 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -571,7 +571,7 @@ void free_initmem(void)
>>>  {
>>>  	free_reserved_area(lm_alias(__init_begin),
>>>  			   lm_alias(__init_end),
>>> -			   0, "unused kernel");
>>> +			   POISON_FREE_INITMEM, "unused kernel");
>>>  	/*
>>>  	 * Unmap the __init region but leave the VM area in place. This
>>>  	 * prevents the region from being reused for kernel modules, which
>>>
>>
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

