Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E9ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD3D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfJOLMS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:12:18 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42398 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfJOLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:12:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iKKkR-0004nD-5y; Tue, 15 Oct 2019 05:12:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iKKkQ-0005CK-BC; Tue, 15 Oct 2019 05:12:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     lijiang <lijiang@redhat.com>
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
Date:   Tue, 15 Oct 2019 06:11:21 -0500
In-Reply-To: <f3fc12b9-be39-d430-52f5-d1b76b2599a3@redhat.com> (lijiang's
        message of "Mon, 14 Oct 2019 18:02:22 +0800")
Message-ID: <87tv8az2jq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1iKKkQ-0005CK-BC;;;mid=<87tv8az2jq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/CQX+QOBFNW++gFp6mHXP7BzIXPyWEAgA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the backup region
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lijiang <lijiang@redhat.com> writes:

> 在 2019年10月12日 20:16, Dave Young 写道:
>> Hi Eric,
>> 
>> On 10/12/19 at 06:26am, Eric W. Biederman wrote:
>>> Lianbo Jiang <lijiang@redhat.com> writes:
>>>
>>>> When the crashkernel kernel command line option is specified, the
>>>> low 1MiB memory will always be reserved, which makes that the memory
>>>> allocated later won't fall into the low 1MiB area, thereby, it's not
>>>> necessary to create a backup region and also no need to copy the first
>>>> 640k content to a backup region.
>>>>
>>>> Currently, the code related to the backup region can be safely removed,
>>>> so lets clean up.
>>>>
>>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>>> ---
>>>
>>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>>> index eb651fbde92a..cc5774fc84c0 100644
>>>> --- a/arch/x86/kernel/crash.c
>>>> +++ b/arch/x86/kernel/crash.c
>>>> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>>>  
>>>>  #ifdef CONFIG_KEXEC_FILE
>>>>  
>>>> -static unsigned long crash_zero_bytes;
>>>> -
>>>>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>>>>  {
>>>>  	unsigned int *nr_ranges = arg;
>>>> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>>>>  {
>>>>  	struct crash_mem *cmem = arg;
>>>>  
>>>> -	cmem->ranges[cmem->nr_ranges].start = res->start;
>>>> -	cmem->ranges[cmem->nr_ranges].end = res->end;
>>>> -	cmem->nr_ranges++;
>>>> +	if (res->start >= SZ_1M) {
>>>> +		cmem->ranges[cmem->nr_ranges].start = res->start;
>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>> +		cmem->nr_ranges++;
>>>> +	} else if (res->end > SZ_1M) {
>>>> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
>>>> +		cmem->ranges[cmem->nr_ranges].end = res->end;
>>>> +		cmem->nr_ranges++;
>>>> +	}
>>>
>>> What is going on with this chunk?  I can guess but this needs a clear
>>> comment.
>> 
>> Indeed it needs some code comment, this is based on some offline
>> discussion.  cat /proc/vmcore will give a warning because ioremap is
>> mapping the system ram.
>> 
>> We pass the first 1M to kdump kernel in e820 as system ram so that 2nd
>> kernel can use the low 1M memory because for example the trampoline
>> code.
>> 
> Thank you, Eric and Dave. I will add the code comment as below if it would be OK.
>
> @@ -234,9 +232,20 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  {
>         struct crash_mem *cmem = arg;
>  
> -       cmem->ranges[cmem->nr_ranges].start = res->start;
> -       cmem->ranges[cmem->nr_ranges].end = res->end;
> -       cmem->nr_ranges++;
> +       /*
> +        * Currently, pass the low 1MiB range to kdump kernel in e820
> +        * as system ram so that kdump kernel can also use the low 1MiB
> +        * memory due to the real mode trampoline code.
> +        * And later, the low 1MiB range will be exclued from elf header,
> +        * which will avoid remapping the 1MiB system ram when dumping
> +        * vmcore.
> +        */
> +       if (res->start >= SZ_1M) {
> +               cmem->ranges[cmem->nr_ranges].start = res->start;
> +               cmem->ranges[cmem->nr_ranges].end = res->end;
> +               cmem->nr_ranges++;
> +       } else if (res->end > SZ_1M) {
> +               cmem->ranges[cmem->nr_ranges].start = SZ_1M;
> +               cmem->ranges[cmem->nr_ranges].end = res->end;
> +               cmem->nr_ranges++;
> +       }
>  
>         return 0;
>  }

I just read through the appropriate section of crash.c and the way
things are structured doing this work in
prepare_elf64_ram_headers_callback is wrong.

This can be done in a simpler manner in elf_header_exclude_ranges.
Something like:

	/* The low 1MiB is always reserved */
	ret = crash_exclude_mem_range(cmem, 0, 1024*1024);
	if (ret)
		return ret;

Eric
