Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B04ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB8C21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbfJPIks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:40:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389094AbfJPIkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 473FB18CB8E5;
        Wed, 16 Oct 2019 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 378E260A97;
        Wed, 16 Oct 2019 08:40:32 +0000 (UTC)
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the
 backup region
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com, vgoyal@redhat.com,
        kexec@lists.infradead.org
References: <20191012022140.19003-1-lijiang@redhat.com>
 <20191012022140.19003-4-lijiang@redhat.com>
 <87d0f22oi5.fsf@x220.int.ebiederm.org>
 <20191012121625.GA11587@dhcp-128-65.nay.redhat.com>
 <87zhi51ers.fsf@x220.int.ebiederm.org>
 <72edff0b-9778-2e83-224b-7fe70dfb8d73@redhat.com>
 <8736fu1d8k.fsf@x220.int.ebiederm.org>
From:   lijiang <lijiang@redhat.com>
Message-ID: <c42dd338-6fee-9311-df3a-0a3aa8c80cde@redhat.com>
Date:   Wed, 16 Oct 2019 16:40:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8736fu1d8k.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Wed, 16 Oct 2019 08:40:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年10月15日 19:04, Eric W. Biederman 写道:
> lijiang <lijiang@redhat.com> writes:
> 
>> 在 2019年10月13日 11:54, Eric W. Biederman 写道:
>>> Dave Young <dyoung@redhat.com> writes:
>>>
>>>> Hi Eric,
>>>>
>>>> On 10/12/19 at 06:26am, Eric W. Biederman wrote:
>>>>> Lianbo Jiang <lijiang@redhat.com> writes:
>>>>>
>>>>>> When the crashkernel kernel command line option is specified, the
>>>>>> low 1MiB memory will always be reserved, which makes that the memory
>>>>>> allocated later won't fall into the low 1MiB area, thereby, it's not
>>>>>> necessary to create a backup region and also no need to copy the first
>>>>>> 640k content to a backup region.
>>>>>>
>>>>>> Currently, the code related to the backup region can be safely removed,
>>>>>> so lets clean up.
>>>>>>
>>>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>>>> ---
>>>>>
>>>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>>>> index eb651fbde92a..cc5774fc84c0 100644
>>>>>> --- a/arch/x86/kernel/crash.c
>>>>>> +++ b/arch/x86/kernel/crash.c
>>>>>> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>>>>>  
>>>>>>  #ifdef CONFIG_KEXEC_FILE
>>>>>>  
>>>>>> -static unsigned long crash_zero_bytes;
>>>>>> -
>>>>>>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>>>>>>  {
>>>>>>  	unsigned int *nr_ranges = arg;
>>>>>> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>>>>>>  {
>>>>>>  	struct crash_mem *cmem = arg;
>>>>>>  
>>>>>> -	cmem->ranges[cmem->nr_ranges].start = res->start;
>>>>>> -	cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>>> -	cmem->nr_ranges++;
>>>>>> +	if (res->start >= SZ_1M) {
>>>>>> +		cmem->ranges[cmem->nr_ranges].start = res->start;
>>>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>>> +		cmem->nr_ranges++;
>>>>>> +	} else if (res->end > SZ_1M) {
>>>>>> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>>>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>>> +		cmem->nr_ranges++;
>>>>>> +	}
>>>>>
>>>>> What is going on with this chunk?  I can guess but this needs a clear
>>>>> comment.
>>>>
>>>> Indeed it needs some code comment, this is based on some offline
>>>> discussion.  cat /proc/vmcore will give a warning because ioremap is
>>>> mapping the system ram.
>>>>
>>>> We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
>>>> kernel can use the low 1M memory because for example the trampoline
>>>> code.
>>>>
>>>>>
>>>>>>  
>>>>>>  	return 0;
>>>>>>  }
>>>>>
>>>>>> @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>>>>>>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>>>>>>  	cmd.params = params;
>>>>>>  
>>>>>> -	/* Add first 640K segment */
>>>>>> -	ei.addr = image->arch.backup_src_start;
>>>>>> -	ei.size = image->arch.backup_src_sz;
>>>>>> +	/*
>>>>>> +	 * Add the low memory range[0x1000, SZ_1M], skip
>>>>>> +	 * the first zero page.
>>>>>> +	 */
>>>>>> +	ei.addr = PAGE_SIZE;
>>>>>> +	ei.size = SZ_1M - PAGE_SIZE;
>>>>>>  	ei.type = E820_TYPE_RAM;
>>>>>>  	add_e820_entry(params, &ei);
>>>>>
>>>>> Likewise here.  Why do we need a special case?
>>>>> Why the magic with PAGE_SIZE?
>>>>
>>>> Good catch, the zero page part is useless, I think no other special
>>>> reason, just assumed zero page is not usable, but it should be ok to
>>>> remove the special handling, just pass 0 - 1M is good enough.
>>>
>>> But if we have stopped special casing the low 1M.  Why do we need a
>>> special case here at all?
>>>
>> Here, need to pass the low memory range to kdump kernel, which will guarantee
>> the availability of low memory in kdump kernel, otherwise, kdump kernel won't
>> use the low memory region.
>>
>>> If you need the special case it is almost certainly wrong to say you
>>> have ram above 640KiB and below 1MiB.  That is the legacy ROM and video
>>> MMIO area.
>>>
>>> There is a reason the original code said 640KiB.
>>>
>> Do you mean that the 640k region is good enough here instead of 1MiB?
> 
> Reading through the code of crash_setup_memap_entries I see that what
> the code is doing now.  The code is repeating the e820 memory map with
> the memory areas that were not reserved for the crash kernel removed.
> 
> In which case what the code needs to be doing something like:
> 
> 	cmd.type = E820_TYPE_RAM;
> 	flags = IORESOURCE_MEM;
> 	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, 1024*1024, &cmd,
> 			       memmap_entry_callback);
> 
> Depending on which bugs exist it might make sense to limit this to
> the low 640KiB.  But finding something the kernel already recognizes
> as RAM should prevent most of those problems already.  Barring bugs
> I admit it doesn't make sense to repeat the work that someone else
> has already done.
> 
> This bit:
> 	/* Add e820 reserved ranges */
> 	cmd.type = E820_TYPE_RESERVED;
> 	flags = IORESOURCE_MEM;
> 	walk_iomem_res_desc(IORES_DESC_RESERVED, flags, 0, -1, &cmd,
> 			   memmap_entry_callback);
> 
> Should probably start at 1MiB instead of 0.  Just so we don't report the
> memory below 1MiB as unconditionally reserved.   I don't properly
> understand the IORES_DESC_RESERVED flag, and how that differs from
> flags.  So please test my suggestions to verify the code works as
> expected.
> 
Thanks for your comment, Eric.

I will make a test based on your suggestions. But i need an SME machine,
maybe i will reply later.

Thanks.
Lianbo

> Eric
> 
