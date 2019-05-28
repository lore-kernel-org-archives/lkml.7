Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F31C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275B0208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfE1IXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:23:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51850 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfE1IXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:23:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9959341;
        Tue, 28 May 2019 01:23:18 -0700 (PDT)
Received: from [192.168.1.27] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F7303F59C;
        Tue, 28 May 2019 01:23:16 -0700 (PDT)
Subject: Re: [PATCH 3/4] arm64/kprobes: set VM_FLUSH_RESET_PERMS on kprobe
 instruction pages
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
 <20190523102256.29168-4-ard.biesheuvel@arm.com>
 <e10f0e6c-2669-8e1e-1b28-ed7816e0b248@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <7c5e1fea-c93e-fc5b-8c77-c9bd9ec41fb3@arm.com>
Date:   Tue, 28 May 2019 10:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e10f0e6c-2669-8e1e-1b28-ed7816e0b248@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 10:20 AM, Anshuman Khandual wrote:
> 
> 
> On 05/23/2019 03:52 PM, Ard Biesheuvel wrote:
>> In order to avoid transient inconsistencies where freed code pages
>> are remapped writable while stale TLB entries still exist on other
>> cores, mark the kprobes text pages with the VM_FLUSH_RESET_PERMS
>> attribute. This instructs the core vmalloc code not to defer the
>> TLB flush when this region is unmapped and returned to the page
>> allocator.
> 
> Makes sense.
> 
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
>> ---
>>   arch/arm64/kernel/probes/kprobes.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index 2509fcb6d404..036cfbf9682a 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -131,8 +131,10 @@ void *alloc_insn_page(void)
>>   	void *page;
>>   
>>   	page = vmalloc_exec(PAGE_SIZE);
>> -	if (page)
>> +	if (page) {
>>   		set_memory_ro((unsigned long)page, 1);
>> +		set_vm_flush_reset_perms(page);
>> +	}
> 
> Looks good. It seems there might be more users who would like to set
> VM_FLUSH_RESET_PERMS right after their allocation for the same reason.
> Hence would not it help to have a variant like vmalloc_exec_reset() or
> such which will tag vm_struct->flags with VM_FLUSH_RESET_PERMS right
> after it's allocation without requiring the caller to do the same.
> 

If there is a sufficient number of similar users, then of course, it 
makes sense to factor this out. However, the kprobes code is slightly 
unusual in the sense that it allocates memory and immediately remaps it 
read-only, and relies on code patching to populate this allocation. I am 
not expecting to see this pattern in other places.



