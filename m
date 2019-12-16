Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D040C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0A2206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfLPKL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:11:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:37060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfLPKL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:11:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C003AB98;
        Mon, 16 Dec 2019 10:11:25 +0000 (UTC)
Subject: Re: [PATCH] x86-64/entry: add instruction suffix to SYSRET
To:     Andy Lutomirski <luto@kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
 <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net>
 <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
 <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com>
 <ed9d8df6-0fe7-ca15-bab2-4d9cbbfe62f0@suse.com>
 <CALCETrXoK+6gNn=3_yZdkHScd=N-a2f_VPC-svkFfHVsiVusVw@mail.gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <62d9f87d-de55-3fb4-664d-d24897f4dd9b@suse.com>
Date:   Mon, 16 Dec 2019 11:11:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXoK+6gNn=3_yZdkHScd=N-a2f_VPC-svkFfHVsiVusVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.2019 18:49, Andy Lutomirski wrote:
> On Fri, Dec 13, 2019 at 1:55 AM Jan Beulich <jbeulich@suse.com> wrote:
>>
>> On 12.12.2019 22:43, Andy Lutomirski wrote:
>>> On Tue, Dec 10, 2019 at 7:40 AM Jan Beulich <jbeulich@suse.com> wrote:
>>>>
>>>> On 10.12.2019 16:29, Andy Lutomirski wrote:
>>>>>> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>>>>
>>>>>> ﻿Omitting suffixes from instructions in AT&T mode is bad practice when
>>>>>> operand size cannot be determined by the assembler from register
>>>>>> operands, and is likely going to be warned about by upstream gas in the
>>>>>> future. Add the missing suffix here.
>>>>>>
>>>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>>>>
>>>>>> --- a/arch/x86/entry/entry_64.S
>>>>>> +++ b/arch/x86/entry/entry_64.S
>>>>>> @@ -1728,7 +1728,7 @@ END(nmi)
>>>>>> SYM_CODE_START(ignore_sysret)
>>>>>>    UNWIND_HINT_EMPTY
>>>>>>    mov    $-ENOSYS, %eax
>>>>>> -    sysret
>>>>>> +    sysretl
>>>>>
>>>>> Isn’t the default sysretq?  sysretl looks more correct, but that suggests
>>>>> that your changelog is wrong.
>>>>
>>>> No, this is different from ret, and more like iret and lret.
>>>>
>>>>> Is this code even reachable?
>>>>
>>>> Yes afaict, supported by the comment ahead of the symbol. syscall_init()
>>>> puts its address into MSR_CSTAR when !IA32_EMULATION.
>>>>
>>>
>>> What I meant was: can a program actually get itself into 32-bit mode
>>> to execute a 32-bit SYSCALL instruction?
>>
>> Why not? It can set up a 32-bit code segment descriptor, far-branch
>> into it, and then execute SYSCALL. I can't see anything preventing
>> this in the logic involved in descriptor adjustment system calls. In
>> fact it looks to be at least partly the opposite - fill_ldt()
>> disallows creation of 64-bit code segments (oddly enough
>> fill_user_desc() then still copies the bit back, despite there
>> apparently being no way for it to get set).
> 
> Do we allow creation of 32-bit code segments on !IA32_EMULATION
> kernels?

As per above - I think so.

>  I think we shouldn't, but I'm not really sure.

It may be a little exotic, but I can't see any reason to disallow
a 64-bit process to switch to compatibility mode temporarily. One
contrived use case could be to be able to invoke INTO or BOUND.

Jan
