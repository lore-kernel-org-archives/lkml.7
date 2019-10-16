Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B260FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA6721848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394066AbfJPOae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:30:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbfJPOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFBD98A1C8D;
        Wed, 16 Oct 2019 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7848100EA05;
        Wed, 16 Oct 2019 14:30:19 +0000 (UTC)
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
Message-ID: <93e6713a-8027-3a7a-4445-9bee56b19f62@redhat.com>
Date:   Wed, 16 Oct 2019 22:30:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8736fu1d8k.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 16 Oct 2019 14:30:33 +0000 (UTC)
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
The above code does not get the results what we expected, it gets the reserved
memory marked as 'IORES_DESC_RESERVED' in the low 1MiB range.

Finally, kdump kernel happened the panic as follow:
......
[    3.555662] Kernel panic - not syncing: Real mode trampoline was not allocated
[    3.556660] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc3+ #4
[    3.556660] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1009C 07/27/2018
[    3.556660] Call Trace:
[    3.556660]  dump_stack+0x46/0x60
[    3.556660]  panic+0xfb/0x2d7
[    3.556660]  ? hv_init_spinlocks+0x7f/0x7f
[    3.556660]  init_real_mode+0x27/0x1fa
[    3.556660]  ? hv_init_spinlocks+0x7f/0x7f
[    3.556660]  ? do_one_initcall+0x46/0x1e4
[    3.556660]  ? proc_register+0xd0/0x130
[    3.556660]  ? kernel_init_freeable+0xe2/0x242
[    3.556660]  ? rest_init+0xaa/0xaa
[    3.556660]  ? kernel_init+0xa/0x106
[    3.556660]  ? ret_from_fork+0x22/0x40
[    3.556660] Rebooting in 10 seconds..
[    3.556660] ACPI MEMORY or I/O RESET_REG.

I modified the above code, and tested it. This can find out the system ram in
the low 1MiB range. And it worked well.

@@ -356,11 +338,11 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
        memset(&cmd, 0, sizeof(struct crash_memmap_data));
        cmd.params = params;
 
+       /* Add the low 1MiB */
+       cmd.type = E820_TYPE_RAM;
+       flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+       walk_iomem_res_desc(IORES_DESC_NONE, flags, 0, 1024*1024 - 1, &cmd,
+                       memmap_entry_callback);

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
If so, it can not find out the reserved memory marked as 'IORES_DESC_RESERVED' in
the low 1MiB range, finally, it doesn't pass the reserved memory in the low 1MiB to
kdump kernel, which could cause some problems, such as SME or PCI MMCONFIG issue.

> memory below 1MiB as unconditionally reserved.   I don't properly
> understand the IORES_DESC_RESERVED flag, and how that differs from
I found three commits about 'IORES_DESC_RESERVED' flag, hope this helps.
1.ae9e13d621d6 ("x86/e820, ioport: Add a new I/O resource descriptor IORES_DESC_RESERVED")
2.5da04cc86d12 ("x86/mm: Rework ioremap resource mapping determination")
3.980621daf368 ("x86/crash: Add e820 reserved ranges to kdump kernel's e820 table")

> flags.  So please test my suggestions to verify the code works as
> expected.
> 
I have tested the two changes that you mentioned, please refer to the reply above.

Thanks.
Lianbo

> Eric
> 
