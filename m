Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B36C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B432526660
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfEaJFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:05:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEaJFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:05:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93933341;
        Fri, 31 May 2019 02:05:11 -0700 (PDT)
Received: from [10.162.42.223] (p8cg001049571a15.blr.arm.com [10.162.42.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 143BB3F59C;
        Fri, 31 May 2019 02:05:08 -0700 (PDT)
Subject: Re: [PATCH 4/4] arm64/mm: Drop vm_fault_t argument from
 __do_page_fault()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <1559133285-27986-1-git-send-email-anshuman.khandual@arm.com>
 <1559133285-27986-5-git-send-email-anshuman.khandual@arm.com>
 <20190529151134.GH31777@lakrids.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5e565fd3-0d2b-31a5-8644-c91ccc5fb05e@arm.com>
Date:   Fri, 31 May 2019 14:35:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190529151134.GH31777@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2019 08:41 PM, Mark Rutland wrote:
> On Wed, May 29, 2019 at 06:04:45PM +0530, Anshuman Khandual wrote:
>> __do_page_fault() is over complicated with multiple goto statements. This
>> cleans up code flow and while there drops the vm_fault_t argument.
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com> 
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> ---
>>  arch/arm64/mm/fault.c | 38 ++++++++++++++++----------------------
>>  1 file changed, 16 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 170c71f..a53a30e 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -397,37 +397,31 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
>>  static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
>>  			   unsigned int mm_flags, unsigned long vm_flags)
>>  {
>> -	struct vm_area_struct *vma;
>> -	vm_fault_t fault;
>> +	struct vm_area_struct *vma = find_vma(mm, addr);
>>  
>> -	vma = find_vma(mm, addr);
>> -	fault = VM_FAULT_BADMAP;
>>  	if (unlikely(!vma))
>> -		goto out;
>> -	if (unlikely(vma->vm_start > addr))
>> -		goto check_stack;
>> +		return VM_FAULT_BADMAP;
>>  
>>  	/*
>> -	 * Ok, we have a good vm_area for this memory access, so we can handle
>> -	 * it.
>> +	 * Check if the VMA has got the required permssion with respect
>> +	 * to the access fault here.
>>  	 */
> 
> We already had a perfectly good comment for this check:
> 
> 	/*
> 	 * Check that the permissions on the VMA allow for the fault which
> 	 * occurred.
> 	 */
> 
> ... so please keep that and minimize the diff.

Sure, will keep all the existing comments here.

> 
>> -good_area:
>> +	if (!(vma->vm_flags & vm_flags))
>> +		return VM_FAULT_BADACCESS;
>> +
>>  	/*
>> -	 * Check that the permissions on the VMA allow for the fault which
>> -	 * occurred.
>> +	 * There is a valid VMA for this access. But before proceeding
>> +	 * make sure that it has required flags if there is an attempt
>> +	 * to expand the stack downwards.
>>  	 */
> 
> I think we can drop this comment, given we didn't have it previously.

Okay.

> 
>> -	if (!(vma->vm_flags & vm_flags)) {
>> -		fault = VM_FAULT_BADACCESS;
>> -		goto out;
>> -	}
>> +	if (unlikely(vma->vm_start > addr)) {
>> +		if (!(vma->vm_flags & VM_GROWSDOWN))
>> +			return VM_FAULT_BADMAP;
>>  
>> +		if (expand_stack(vma, addr))
>> +			return VM_FAULT_BADMAP;
> 
> You can drop the line space between these two if statements.

Will do.

> 
>> +	}
>>  	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags);
>> -
>> -check_stack:
>> -	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
>> -		goto good_area;
>> -out:
>> -	return fault;
> 
> We used to check the stack before the checknig the rest of the vm_flags,
> so this changes the precedence of the VM_FAULT_BADMAP and
> VM_FAULT_BADACCESS return codes.
> 
> Please check the stack before checking the other vm_flags.

Though it makes some sense to move VMA permission check earlier in the function as it
is the quicker one but I understand need to maintain the existing code flow in a clean
up patch like this. Will retain the existing flow.
