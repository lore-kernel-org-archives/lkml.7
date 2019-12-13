Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58240C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE42073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLMJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:55:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:50010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfLMJzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:55:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FA82AFC2;
        Fri, 13 Dec 2019 09:55:09 +0000 (UTC)
Subject: Re: [PATCH] x86-64/entry: add instruction suffix to SYSRET
To:     Andy Lutomirski <luto@kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <cbecab05-9e95-5dec-ef81-499617c153a6@suse.com>
 <08B92B44-CCA9-4B83-B9CC-F1601D44B73F@amacapital.net>
 <0053f606-f4f7-3951-f40b-b7bd08703590@suse.com>
 <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <ed9d8df6-0fe7-ca15-bab2-4d9cbbfe62f0@suse.com>
Date:   Fri, 13 Dec 2019 10:55:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CALCETrWHNunMzP1xHmOhvHG20_baoeXhNbCcEJgCgm5xzGM5Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2019 22:43, Andy Lutomirski wrote:
> On Tue, Dec 10, 2019 at 7:40 AM Jan Beulich <jbeulich@suse.com> wrote:
>>
>> On 10.12.2019 16:29, Andy Lutomirski wrote:
>>>> On Dec 10, 2019, at 2:48 AM, Jan Beulich <JBeulich@suse.com> wrote:
>>>>
>>>> ﻿Omitting suffixes from instructions in AT&T mode is bad practice when
>>>> operand size cannot be determined by the assembler from register
>>>> operands, and is likely going to be warned about by upstream gas in the
>>>> future. Add the missing suffix here.
>>>>
>>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>>
>>>> --- a/arch/x86/entry/entry_64.S
>>>> +++ b/arch/x86/entry/entry_64.S
>>>> @@ -1728,7 +1728,7 @@ END(nmi)
>>>> SYM_CODE_START(ignore_sysret)
>>>>    UNWIND_HINT_EMPTY
>>>>    mov    $-ENOSYS, %eax
>>>> -    sysret
>>>> +    sysretl
>>>
>>> Isn’t the default sysretq?  sysretl looks more correct, but that suggests
>>> that your changelog is wrong.
>>
>> No, this is different from ret, and more like iret and lret.
>>
>>> Is this code even reachable?
>>
>> Yes afaict, supported by the comment ahead of the symbol. syscall_init()
>> puts its address into MSR_CSTAR when !IA32_EMULATION.
>>
> 
> What I meant was: can a program actually get itself into 32-bit mode
> to execute a 32-bit SYSCALL instruction?

Why not? It can set up a 32-bit code segment descriptor, far-branch
into it, and then execute SYSCALL. I can't see anything preventing
this in the logic involved in descriptor adjustment system calls. In
fact it looks to be at least partly the opposite - fill_ldt()
disallows creation of 64-bit code segments (oddly enough
fill_user_desc() then still copies the bit back, despite there
apparently being no way for it to get set).

> Anyway, the change itself is Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> But let's please clarify the changelog:
> 
> ignore_sysret contains an unsuffixed 'sysret' instruction.  gas
> correctly interprets this as sysretl, but leaving it up to gas to
> guess when there is no register operand that implies a size is bad
> practice, and upstream gas is likely to warn about this in the future.
> Use 'sysretl' explicitly.  This does not change the assembled output.

Fine with me, changed.

Jan
