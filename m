Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A721929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394243AbfJYGJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:09:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:54592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394092AbfJYGJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:09:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5C05B544;
        Fri, 25 Oct 2019 06:09:02 +0000 (UTC)
Subject: Re: [PATCH] x86/stackframe/32: repair 32-bit Xen PV
To:     Jan Beulich <JBeulich@suse.com>, Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <ef1c9381-dfc7-7150-feca-581f4d798513@suse.com>
 <CALCETrWAALF7EgxHGs-rtZwk1Fxttr56QKXeB6QssXbyXDs+kA@mail.gmail.com>
 <4c4b0cdf-55e5-7be5-bf49-08fe8fd18dca@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <76fd94f0-cfc6-5ad5-673b-725f4d72a69b@suse.com>
Date:   Fri, 25 Oct 2019 08:09:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4c4b0cdf-55e5-7be5-bf49-08fe8fd18dca@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.19 08:06, Jan Beulich wrote:
> On 24.10.2019 18:11, Andy Lutomirski wrote:
>> On Mon, Oct 7, 2019 at 3:41 AM Jan Beulich <jbeulich@suse.com> wrote:
>>>
>>> Once again RPL checks have been introduced which don't account for a
>>> 32-bit kernel living in ring 1 when running in a PV Xen domain. The
>>> case in FIXUP_FRAME has been preventing boot; adjust BUG_IF_WRONG_CR3
>>> as well just in case.
>>
>> I'm okay with the generated code, but IMO the macro is too indirect
>> for something that's trivial.
>>
>>>
>>> Fixes: 3c88c692c287 ("x86/stackframe/32: Provide consistent pt_regs")
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>
>>> --- a/arch/x86/entry/entry_32.S
>>> +++ b/arch/x86/entry/entry_32.S
>>> @@ -48,6 +48,17 @@
>>>
>>>    #include "calling.h"
>>>
>>> +#ifndef CONFIG_XEN_PV
>>> +# define USER_SEGMENT_RPL_MASK SEGMENT_RPL_MASK
>>> +#else
>>> +/*
>>> + * When running paravirtualized on Xen the kernel runs in ring 1, and hence
>>> + * simple mask based tests (i.e. ones not comparing against USER_RPL) have to
>>> + * ignore bit 0. See also the C-level get_kernel_rpl().
>>> + */
>>
>> How about:
>>
>> /*
>>    * When running on Xen PV, the actual %cs register in the kernel is 1, not 0.
>>    * If we need to distinguish between a %cs from kernel mode and a %cs from
>>    * user mode, we can do test $2 instead of test $3.
>>    */
>> #define USER_SEGMENT_RPL_MASK 2
> 
> I.e. you're fine using just the single bit in all configurations?
> 
>>> +# define USER_SEGMENT_RPL_MASK (SEGMENT_RPL_MASK & ~1)
>>> +#endif
>>> +
>>>           .section .entry.text, "ax"
>>>
>>>    /*
>>> @@ -172,7 +183,7 @@
>>>           ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>>>           .if \no_user_check == 0
>>>           /* coming from usermode? */
>>> -       testl   $SEGMENT_RPL_MASK, PT_CS(%esp)
>>> +       testl   $USER_SEGMENT_RPL_MASK, PT_CS(%esp)
>>
>> Shouldn't PT_CS(%esp) be 0 if we came from the kernel?  I'm guessing
>> the actual bug is in whatever code put 1 in here in the first place.
>>
>> In other words, I'm having trouble understanding why there is any
>> context in which some value would be 3 for user mode and 1 for kernel
>> mode.  Obviously if we're manually IRETing to kernel mode, we need to
>> set CS to 1, but if we're filling in our own PT_CS, we should just
>> write 0.
>>
>> The supposedly offending commit (""x86/stackframe/32: Provide
>> consistent pt_regs") looks correct to me, so I suspect that the
>> problem is elsewhere.  Or is it intentional that Xen PV's asm
>> (arch/x86/xen/whatever) sticks 1 into the CS field on the stack?
> 
> Manually created / updated frames _could_ in principle modify the
> RPL, but ones coming from hardware (old 32-bit hypervisors) or Xen
> (64-bit hypervisors) will have an RPL of 1, as already said by
> Andrew. We could in principle also add a VM assist for the
> hypervisor to store an RPL of 0, but I'd expect this to require
> further kernel changes, and together with the old behavior still
> being required to support I'm unconvinced this would be worth it.
> 
>> Also, why are we supporting 32-bit Linux PV guests at all?  Can we
>> just delete this code instead?
> 
> This was already suggested by Jürgen (now also CC-ed), but in reply
> it was pointed out that the process would be to first deprecate the
> code, and remove it only a couple of releases later if no-one comes
> up with a reason to retain it.

Thanks for the reminder.

I'll send a patch with the deprecation warning for 32-bit PV.


Juergen
