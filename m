Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B1620675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rq65C9SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404202AbfDRSRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:17:08 -0400
Received: from mail.efficios.com ([167.114.142.138]:56458 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403809AbfDRSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:17:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 707DD1C9B8B;
        Thu, 18 Apr 2019 14:17:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ISyeVO-AYyxj; Thu, 18 Apr 2019 14:17:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6D9161C9B84;
        Thu, 18 Apr 2019 14:17:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6D9161C9B84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555611422;
        bh=rWwzlRn715UarwlNR6rPz3NyFK6iQRJnbSbTHPCvlfw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rq65C9SKQh6NHPYH+ygeqwiAhDA26/gMHB4tDvCQhGwZHB2UQD4GdKtM88Pt17RxE
         yxsab4+GXQM6MLKh8xUlk9/6xSa8tAbyW6L/0OxhINy3muMg3Va3XKKd76FrvPQR8W
         kENFIXV0BiwVvzfK9y+YOyRacJIeIRjQhJ/h3GXQ/9NNxaYFGZ009KTEjScO6I+ykg
         A7du5GOMvc651HWuKDxuVJUQfnxoRww0by5GPZ2mb8kZ+R2c2XtWVRHUl9new39RO5
         8OclRPBPNxz1mWbvNCwoZNj9tYjvFxCt6K7EhvJFUBAU+l0FlrOt+fjaqkv8t1WO4D
         fBB3lhMqaE6AQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id tuEvgNxHkgFD; Thu, 18 Apr 2019 14:17:02 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5340F1C9B7A;
        Thu, 18 Apr 2019 14:17:02 -0400 (EDT)
Date:   Thu, 18 Apr 2019 14:17:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     nd <nd@arm.com>, Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <Will.Deacon@arm.com>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1531569198.1389.1555611422188.JavaMail.zimbra@efficios.com>
In-Reply-To: <846db7ef-f75e-53b8-3c4c-461ec730a17e@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com> <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com> <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com> <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com> <79996d13-2ba2-ed7d-b202-e7d38f1fd870@arm.com> <604915684.1299.1555607449814.JavaMail.zimbra@efficios.com> <846db7ef-f75e-53b8-3c4c-461ec730a17e@arm.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v8)
Thread-Index: AQHU9HpbUigwBDiNHkaVVFlkWH4PtKZAhB6AgAAE+oCAAD0+gIABIvSAgAAl0IBuJwpORvyO4hCAgAAA5YCAAAdqgLYG8wpA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 18, 2019, at 1:37 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:

> On 18/04/2019 18:10, Mathieu Desnoyers wrote:
>> 
>> ----- On Apr 18, 2019, at 12:07 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>> 
>>> On 18/04/2019 16:41, Mathieu Desnoyers wrote:
>>>> ----- On Apr 18, 2019, at 11:33 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>>>>
>>>>> On 18/04/2019 14:17, Mathieu Desnoyers wrote:
>>>>>> ----- On Apr 17, 2019, at 3:56 PM, Mathieu Desnoyers
>>>>>> mathieu.desnoyers@efficios.com wrote:
>>>>>>> ----- On Apr 17, 2019, at 12:17 PM, Joseph Myers joseph@codesourcery.com wrote:
>>>>>>>> On Wed, 17 Apr 2019, Mathieu Desnoyers wrote:
>>>>>>>>
>>>>>>>>>> +/* RSEQ_SIG is a signature required before each abort handler code.
>>>>>>>>>> +
>>>>>>>>>> +   It is a 32-bit value that maps to actual architecture code compiled
>>>>>>>>>> +   into applications and libraries. It needs to be defined for each
>>>>>>>>>> +   architecture. When choosing this value, it needs to be taken into
>>>>>>>>>> +   account that generating invalid instructions may have ill effects on
>>>>>>>>>> +   tools like objdump, and may also have impact on the CPU speculative
>>>>>>>>>> +   execution efficiency in some cases.  */
>>>>>>>>>> +
>>>>>>>>>> +#define RSEQ_SIG 0xd428bc00	/* BRK #0x45E0.  */
>>>>>>>>>
>>>>>>>>> After further investigation, we should probably do the following
>>>>>>>>> to handle compiling with -mbig-endian on aarch64, which generates
>>>>>>>>> binaries with mixed code vs data endianness (little endian code,
>>>>>>>>> big endian data):
>>>>>>>>
>>>>>>>> First, the comment on RSEQ_SIG should specify whether it is to be
>>>>>>>> interpreted in the code or the data endianness.
>>>>>>>
>>>>>>> Right. The signature passed as argument to the rseq registration
>>>>>>> system call needs to be in data endianness (currently exposed kernel
>>>>>>> ABI).
>>>>>>>
>>>>>>> Ideally for userspace, we want to define a signature in code endianness
>>>>>>> that happens to nicely match specific code patterns.
>>>>> ...
>>>>>> For aarch64, I think we can simply do:
>>>>>>
>>>>>> /*
>>>>>>  * aarch64 -mbig-endian generates mixed endianness code vs data:
>>>>>>  * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
>>>>>>  * matches code endianness.
>>>>>>  */
>>>>>> #define RSEQ_SIG_CODE   0xd428bc00      /* BRK #0x45E0.  */
>>>>>>
>>>>>> #ifdef __ARM_BIG_ENDIAN
>>>>>> #define RSEQ_SIG_DATA   0x00bc28d4      /* BRK #0x45E0.  */
>>>>>> #else
>>>>>> #define RSEQ_SIG_DATA   RSEQ_SIG_CODE
>>>>>> #endif
>>>>>>
>>>>>> #define RSEQ_SIG        RSEQ_SIG_DATA
>>>>>>
>>>>>> Feedback is most welcome,
>>>>>
>>>>> so the RSEQ_SIG value is supposed to be used with .word
>>>>> in asm instead of .inst?
>>>>
>>>> We want a .inst so it translates into a valid trap instruction.
>>>> It's better to trap in case program execution reaches this
>>>> by mistake (makes debugging easier).
>>>
>>> that does not make sense to me.
>>>
>>> ".inst" is an asm directive that requires a the value to
>>> be the same on BE and LE (normal insn encoding).
>>>
>>> ".word" is an asm directive that requires the value to
>>> use swapped encoding on BE (if it's used in the instruction
>>> stream it will create a data mapping symbol and disasm to
>>> .word value instead of the instruction mnemonics).
>>>
>>> so which one is it?
>> 
>> We declare the signature with ".inst" in assembler.
>> 
>> However, we also need to pass that 32-bit signature value as
>> argument to the rseq system call when registering rseq.
>> 
>> The signature comparison is performed by the kernel before
>> moving the instruction pointer to the abort handler. It compares
>> the signature received as parameter by sys_rseq (data) to the
>> 4-byte signature preceding the abort IP.
>> 
>> On aarch64 big endian, AFAIU the signature in the code is in
>> little endian, and the signature value passed as argument to
>> the rseq system call is in big endian. One way to handle this
>> is to swap the byte order of the signature "data" representation
>> passed as argument to sys_rseq.
> 
> you have to add a documentation comment somewhere
> explaining if RSEQ_SIG is the value that's passed to
> the kernel and then aarch64 asm code has to use
> 
> .inst endianfixup(RSEQ_SIG) // or
> .word RSEQ_SIG

Using ".word" won't allow objdump to show the instruction it
maps to. It will consider it as data. So .inst is preferred here.

> 
> or if RSEQ_SIG is used as
> 
> .inst RSEQ_SIG
> 
> in aarch64 asm and then endianfixup(RSEQ_SIG) should
> be passed to the syscall.

At this stage, we control the meaning of the definitions we
publicly expose. They are part of glibc headers, not part of the
kernel uapi.

On architectures where data and code endianness match, RSEQ_SIG
can be used both as argument to sys_rseq and as value for
.inst in assembler.

On architectures where data and code endianness differ, I am
tempted to declare them separately:

* RSEQ_SIG_CODE: for use with .inst in assembly,
* RSEQ_SIG_DATA (mapping to RSEQ_SIG): to pass as parameter to sys_rseq.

So those specific architectures would use "RSEQ_SIG_CODE" with
.inst in assembly, and we can still pass the RSEQ_SIG as parameter
to sys_rseq in generic rseq registration code.

> either way it can be a brk 0x45e0 on both LE and BE,
> but in the latter case you have to document this in
> arch independent way, since the syscall api must be
> portable (i assume "RSEQ_SIG" is part of the api).

The RSEQ_SIG is defined by glibc bits/rseq.h which is included from
sys/rseq.h. It's therefore not part of the Linux kernel uapi. So
we can define whatever we need to at this point, but we won't be
able to change it after it has been exposed for a given
architecture.

All the kernel ABI expects is a data-endian value of the signature
it needs to compare to when it loads the 4 bytes prior to the abort
ip.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
