Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D11EC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DF12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390898AbfJPDYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:24:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390756AbfJPDYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:24:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A13308980F1;
        Wed, 16 Oct 2019 03:24:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 665675D6A5;
        Wed, 16 Oct 2019 03:24:21 +0000 (UTC)
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
 <f3fc12b9-be39-d430-52f5-d1b76b2599a3@redhat.com>
 <87tv8az2jq.fsf@x220.int.ebiederm.org>
From:   lijiang <lijiang@redhat.com>
Message-ID: <54e8e316-1c7e-8d2e-270c-d5e178b46024@redhat.com>
Date:   Wed, 16 Oct 2019 11:24:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87tv8az2jq.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 16 Oct 2019 03:24:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年10月15日 19:11, Eric W. Biederman 写道:
> lijiang <lijiang@redhat.com> writes:
> 
>> 在 2019年10月12日 20:16, Dave Young 写道:
>>> Hi Eric,
>>>
>>> On 10/12/19 at 06:26am, Eric W. Biederman wrote:
>>>> Lianbo Jiang <lijiang@redhat.com> writes:
>>>>
>>>>> When the crashkernel kernel command line option is specified, the
>>>>> low 1MiB memory will always be reserved, which makes that the memory
>>>>> allocated later won't fall into the low 1MiB area, thereby, it's not
>>>>> necessary to create a backup region and also no need to copy the first
>>>>> 640k content to a backup region.
>>>>>
>>>>> Currently, the code related to the backup region can be safely removed,
>>>>> so lets clean up.
>>>>>
>>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>>> ---
>>>>
>>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>>> index eb651fbde92a..cc5774fc84c0 100644
>>>>> --- a/arch/x86/kernel/crash.c
>>>>> +++ b/arch/x86/kernel/crash.c
>>>>> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>>>>  
>>>>>  #ifdef CONFIG_KEXEC_FILE
>>>>>  
>>>>> -static unsigned long crash_zero_bytes;
>>>>> -
>>>>>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>>>>>  {
>>>>>  	unsigned int *nr_ranges = arg;
>>>>> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>>>>>  {
>>>>>  	struct crash_mem *cmem = arg;
>>>>>  
>>>>> -	cmem->ranges[cmem->nr_ranges].start = res->start;
>>>>> -	cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>> -	cmem->nr_ranges++;
>>>>> +	if (res->start >= SZ_1M) {
>>>>> +		cmem->ranges[cmem->nr_ranges].start = res->start;
>>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>> +		cmem->nr_ranges++;
>>>>> +	} else if (res->end > SZ_1M) {
>>>>> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>>> +		cmem->nr_ranges++;
>>>>> +	}
>>>>
>>>> What is going on with this chunk?  I can guess but this needs a clear
>>>> comment.
>>>
>>> Indeed it needs some code comment, this is based on some offline
>>> discussion.  cat /proc/vmcore will give a warning because ioremap is
>>> mapping the system ram.
>>>
>>> We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
>>> kernel can use the low 1M memory because for example the trampoline
>>> code.
>>>
>> Thank you, Eric and Dave. I will add the code comment as below if it would be OK.
>>
>> @@ -234,9 +232,20 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>>  {
>>         struct crash_mem *cmem = arg;
>>  
>> -       cmem->ranges[cmem->nr_ranges].start = res->start;
>> -       cmem->ranges[cmem->nr_ranges].end = res->end;
>> -       cmem->nr_ranges++;
>> +       /*
>> +        * Currently, pass the low 1MiB range to kdump kernel in e820
>> +        * as system ram so that kdump kernel can also use the low 1MiB
>> +        * memory due to the real mode trampoline code.
>> +        * And later, the low 1MiB range will be exclued from elf header,
>> +        * which will avoid remapping the 1MiB system ram when dumping
>> +        * vmcore.
>> +        */
>> +       if (res->start >= SZ_1M) {
>> +               cmem->ranges[cmem->nr_ranges].start = res->start;
>> +               cmem->ranges[cmem->nr_ranges].end = res->end;
>> +               cmem->nr_ranges++;
>> +       } else if (res->end > SZ_1M) {
>> +               cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>> +               cmem->ranges[cmem->nr_ranges].end = res->end;
>> +               cmem->nr_ranges++;
>> +       }
>>  
>>         return 0;
>>  }
> 
> I just read through the appropriate section of crash.c and the way
> things are structured doing this work in
> prepare_elf64_ram_headers_callback is wrong.
> 
> This can be done in a simpler manner in elf_header_exclude_ranges.
> Something like:
> 
Thank you, Eric. It seems that here is a more reasonable place, i will make
a test about it and improve it in next post.

Lianbo

> 	/* The low 1MiB is always reserved */
> 	ret = crash_exclude_mem_range(cmem, 0, 1024*1024);
> 	if (ret)
> 		return ret;
> 
> Eric
> 
