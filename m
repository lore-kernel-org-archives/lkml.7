Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7319FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9702088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfDYMaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:30:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfDYMaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:30:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76C51AF32;
        Thu, 25 Apr 2019 12:30:15 +0000 (UTC)
Subject: Re: x86/paravirt: Detect over-sized patching bugs in
 paravirt_patch_call()
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de> <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
 <20190425081012.GA115378@gmail.com> <20190425091717.GA72229@gmail.com>
 <20190425092131.GL4038@hirez.programming.kicks-ass.net>
 <20190425095039.GC115378@gmail.com>
 <20190425102210.GM4038@hirez.programming.kicks-ass.net>
 <20190425105745.GA29840@gmail.com>
 <cde4b650-7fe5-869e-9cd8-327150bd092e@suse.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b9f94dff-24d1-7ded-9baa-0df6ec2b6a8b@suse.com>
Date:   Thu, 25 Apr 2019 14:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cde4b650-7fe5-869e-9cd8-327150bd092e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 13:30, Juergen Gross wrote:
> On 25/04/2019 12:57, Ingo Molnar wrote:
>>
>> * Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Thu, Apr 25, 2019 at 11:50:39AM +0200, Ingo Molnar wrote:
>>>>
>>>> * Peter Zijlstra <peterz@infradead.org> wrote:
>>>>
>>>>> On Thu, Apr 25, 2019 at 11:17:17AM +0200, Ingo Molnar wrote:
>>>>>> It basically means that we silently won't do any patching and the kernel 
>>>>>> will crash later on in mysterious ways, because paravirt patching is 
>>>>>> usually relied on.
>>>>>
>>>>> That's OK. The compiler emits an indirect CALL/JMP to the pv_ops
>>>>> structure contents. That _should_ stay valid and function correctly at
>>>>> all times.
>>>>
>>>> It might result in a correctly executing kernel in terms of code 
>>>> generation, but it doesn't result in a viable kernel: some of the places 
>>>> rely on the patching going through and don't know what to do when it 
>>>> doesn't and misbehave or crash in interesting ways.
>>>>
>>>> Guess how I know this. ;-)
>>>
>>> What sites would that be? It really should work AFAIK.
>>
>> So for example I tried to increasing the size of one of the struct 
>> patch_xxl members:
>>
>> --- a/arch/x86/kernel/paravirt_patch.c
>> +++ b/arch/x86/kernel/paravirt_patch.c
>> @@ -28,7 +28,7 @@ struct patch_xxl {
>>  	const unsigned char	irq_restore_fl[2];
>>  # ifdef CONFIG_X86_64
>>  	const unsigned char	cpu_wbinvd[2];
>> -	const unsigned char	cpu_usergs_sysret64[6];
>> +	const unsigned char	cpu_usergs_sysret64[60];
>>  	const unsigned char	cpu_swapgs[3];
>>  	const unsigned char	mov64[3];
>>  # else
>>
>> Which with the vanilla kernel crashes on boot much, much later:
>>
>> [    2.478026] PANIC: double fault, error_code: 0x0
> 
> Sure, there is no NOP padding applied. Pre-populating the area with
> 1 byte NOPs would avoid the crash.

This is wrong, of course.

But the indirect jmp is failing as struct pv_ops isn't mapped by the
user page tables.


Juergen
