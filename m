Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A7C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6924E2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WKK1UWhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407345AbfFKX0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:26:50 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:43496 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405384AbfFKX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:26:50 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D9F3DC0A7A;
        Tue, 11 Jun 2019 23:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560295608; bh=yXXz418UXxczQTECEIV7HIqMIAxYjKiLSk3uPK4UjZk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=WKK1UWhLqL3adGtuDvQ6cbOmVVr9/WWLoPpje44569vjls9M7bycPxUHqoX+cCWWc
         k1YPfUQpWQJZD1TMTUbu4/iV9qlANBc/lX0U55dLmA4eN9fl5Z1lVKeVxd1SFVfgsr
         DsEkpUhQJWn1LXiupCbBjeYHCWYcZZuzlgZlZRSo4LxGixtzv87d+Q3a/ZWcIu5j41
         QILhqq9dPmkdu2ls47aXgJG6qjtxCgZ8+LMYD7DLpFzzK6wDW92+fVsHNM6SzDZ/lu
         QyFFYYqqnVWowscsF55L/btrLg7UB17KDEL9YxnsRH9HvgRFS0D4tj/82eeu+PJCRk
         qybnNqXzrWxbA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A95A5A006A;
        Tue, 11 Jun 2019 23:26:48 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Jun 2019 16:26:48 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Jun 2019 04:56:45 +0530
Received: from [10.10.161.35] (10.10.161.35) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Jun 2019 04:56:57 +0530
Subject: Re: ARC Assembler: bundle_align_mode directive support
To:     Cupertino Miranda <Cupertino.Miranda@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <3962a9ad199cea45b1cfadb80be551aab83b7028.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A2525686@us01wembx1.internal.synopsys.com>
 <d79085cbc6126c2a4fad173934e1e9b29523abba.camel@synopsys.com>
 <015f8668b5fff15e781722165f38fa4beacffcf1.camel@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <c37d8c8d-8654-7965-bc74-0d3377766621@synopsys.com>
Date:   Tue, 11 Jun 2019 16:26:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <015f8668b5fff15e781722165f38fa4beacffcf1.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.35]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 1:40 PM, Cupertino Miranda wrote:
> Hi Eugeniy,
> 
> If I understand well what this optimization would do is ... this
> optimization would replace conditional code by fixed jumps that would
> turn out to be always happening. Like fixed ARC build aux registers
> based conditional jumps.
> 
> I don't understand several things:
>  1st. Can't we invalidate multiple icache lines, and synchronize them
> through all CPUs?

Please read his prev email once again. The issue can happen before icache sync can
do the magic. Code update involves updating both dcache and icache lines. Further
dcache update is propagated by hardware (cache coh unit) while icache by Linux
cross core IPI calls. However the potential race is when the patching core's
dcache flush is propagated to other core, but icache cross call is not not
seen/executed by other core and that core also happens to be executing around the
region of code being patched - such that of the 2 icache lines involved, 1 exists
already (old) but the other doesn't (evicted a while back) so fetches the new line
- as a result the 2 icache lines don't correspond to same instruction.


> I am afraid no one might know the actual truth to
> this question. :-)

We do, hopefully now u do too ;-)


> Suggestion: Can't we make use of instruction slots to perform this ?
> Please notice ei_s is a short 16 bit instruction. 

As you mention below EI_s takes an index into jump table. Simplistically each jump
label would correspond to a unique indexes, how do we assign unique indexs for
these instances. Remember we define the macro just once in a header as follows

| static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
| {
|	asm_volatile_goto("1:\n\t"
|		 "b_s %l[l_yes]\n\t"
|		 ".pushsection __jump_table,  \"aw\"\n\t"
|		 ".word 1b, %l[l_yes], %c0\n\t"
|		 ".popsection\n\t"
|		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
|
|	return false;
|l_yes:
|	return true;
|}

Do we have a gcc asm constraint etc to achieve that. IMO EI_S is useful for
baremetal hand written pure asm code, not so much as targeted by compiler proper.


> Replacing the
> instruction with an "ei_s <index>" and a nop in case of 32 bit
> instruction ? Do all of the Linux compatible target support instruction
> slots ?
> Anyway it will not solve the invalid instruction in the remaining
> icache line.
> 
> For referemce, I still think this optimization is a little useless and
> a can of worms,

You mean the whole jump label framework is useless.

How about looking at real code, rather than speculating about the merits of kernel
developers: I can understand u have reservations about our meritocracy, but this
feature was done by smarter folks ;-)

The function below is used in hot schedular path:

u64 sched_clock_cpu(int cpu)
{
	if (!static_branch_unlikely(&sched_clock_running))
		return 0;

	return sched_clock();
}

Here it reads a flag every call

80304194 <sched_clock_cpu>:
80304194:	ld	r2,[0x80713a00]
8030419c:	brge.nt	r2,0x1,12	;803041a8 <sched_clock_cpu+0x14>
803041a0:	mov_s	r0,0
803041a2:	j_s.d	[blink]
803041a4:	mov_s	r1,0
803041a6:	nop_s
803041a8:	b	266756	;803453ac <sched_clock>

With jump label we replace the LD with a nop as that is more likely to be true.

800562f8 <sched_clock_cpu>:
800562f8:	nop
800562fc:	mov_s	r0,0
800562fe:	j_s.d	[blink]
80056300:	mov_s	r1,0
80056302:	nop_s
80056304:	b	257676	;80095190 <sched_clock>


> as for actual use cases the customer can know at
> compile time all of the this constant jumps for its target.
> No one that would care for performance would prefer this feature to
> actual clear out of its code.

????

> 
> Looking at it, It seems to me that Linux kernel should evolve to a JIT
> compilation approach, instead of this JIT juggling one.

There is in-kernel JIT compiler already, used for bigger code chunks, not so much
for 2 or 4 bytes: every use case is different.

> 
> Best regards,
> Cupertino
> 
> 
> On Tue, 2019-06-11 at 18:47 +0000, Eugeniy Paltsev wrote:
>> Hi Vineet,
>>
>> On Mon, 2019-06-10 at 15:55 +0000, Vineet Gupta wrote:
>>> On 6/8/19 11:21 AM, Eugeniy Paltsev wrote:
>>>> Hi Cupertino,
>>>>
>>>> I tried to use ".bundle_align_mode" directive in ARC assembly,
>>>> but I got following error:
>>>> ----------------->8--------------
>>>> Assembler messages:
>>>> Error: unknown pseudo-op: `.bundle_align_mode'
>>>> ----------------->8--------------
>>>>
>>>> Is it possible to implement it in ARC assembler?
>>>> There is some context about the reason we want to have it:
>>>>
>>>> I'm trying to add support of jump labels for ARC in linux kernel.
>>>> Jump labels
>>>> provide an interface to generate static branches using self-
>>>> modifying code.
>>>> This allows us to implement conditional branches where changing
>>>> branch
>>>> direction is expensive but branch selection is basically 'free'.
>>>>
>>>> There is nuance in current implementation:
>>>> We need to patch code by rewriting 32-bit NOP by 32-bit BRANCH
>>>> instruction (or vice versa).
>>>> It can be easily done with following code:
>>>> ----------------->8--------------
>>>> write_32_bit(new_instruction)
>>>> flush_l1_dcache_range_this_cpu
>>>> invalidate_l1_icache_range_all_cpu
>>>> ----------------->8--------------
>>>>
>>>> I$ update will be atomic in most of cases except the patched
>>>> instruction share
>>>> two L1 cache lines (so first 16 bits of instruction are in the
>>>> one cache line and
>>>> last 16 bit are in another cache line).
>>>> In such case we can execute half-updated instruction if we are
>>>> patching live code (and we are unlucky enough :)
>>>
>>> While I understand your need for alignment, I don't see how you can
>>> possibly
>>> execute stray lines.
>>> dcache flush will be propagated by hardware (SCU) to all cores (as
>>> applicable) and
>>> the icache cache flush xcall is synchronous and will have to finish
>>> on all cores
>>> before we proceed to execute the cod eitself.
>>>
>>
>> It's easy as hell - we may execute some code on one CPU and patch it
>> on another CPU at the same moment :)
>>
>> And here is the example of the situation when we can get the issue:
>> - Let's imagine we have SMP system with CPU#0 and CPU#1.
>> - We have instruction which share two L1 cache lines:
>> ~ ---------------------------------|---------------------------------
>> ~
>> ~            |instruction-Z (32-bit instruction we
>> patch)|            ~
>> ~ ---------------------------------|---------------------------------
>> ~
>> ~   cache-line-X                   | cache-line-
>> Y                     ~
>> ~ ---------------------------------|---------------------------------
>> ~
>>
>> CPU#0 is trying to switch our static branch, so it will patch the
>> code (instruction-Z)
>> CPU#1 is executing this code with our static branch, so it execute
>> the code (with instruction-Z) that will be patched.
>>
>> 1) CPU#0: we generate new instruction (to replace 'instruction-Z')
>>    and write it with 32-bit store (st). It is written to CPU#0 L1
>> data cache.
>> 2) CPU#0: we call our function flush_icache_range.
>>    It firstly will flush L1 data cache region on CPU#0.
>>    In our example it will flush CPU#0 L1 'cache-line-X' and 'cache-
>> line-Y' to L2 cache.
>> 3) CPU#1: we are executing code which is in 'cache-line-X'.
>>    'cache-line-Y' is __NOT__ in the L1 instruction cache of CPU#1.
>>    We need to execute 'instruction-Z', but only half of the
>> instruction is in L1 instruction cache.
>>    CPU#1 fetch 'cache-line-Y' to L1 instruction cache.
>> 4)  Ooops: now we have corrupted 'instruction-Z' in L1 instruction
>> cache of CPU#1:
>>    First 16 bit of this instruction (which belongs to 'cache-line-X') 
>> are old (not patched).
>>    Last 16 bit of this instruction (which belongs to 'cache-line-Y')
>> are new (patched).
>>
>>>> As of today I simply align by 4 byte instruction which can be
>>>> patched with ".balign 4" directive:
>>>> ----------------->8--------------
>>>> static __always_inline bool arch_static_branch_jump(struct
>>>> static_key *key,
>>>>     bool branch)
>>>> {
>>>> asm_volatile_goto(".balign 4\n"
>>>>  "1:\n"
>>>>  "b %l[l_yes]\n" // <- instruction which can be patched
>>>>  ".pushsection __jump_table, \"aw\"\n"
>>>>  ".word 1b, %l[l_yes], %c0\n"
>>>>  ".popsection\n"
>>>>  : : "i" (&((char *)key)[branch]) : : l_yes);
>>>>
>>>> return false;
>>>> l_yes:
>>>> return true;
>>>> }
>>>> ----------------->8--------------
>>>>
>>>> In that case patched instruction is aligned with one 16-bit NOP
>>>> if this is required.
>>>> However 'align by 4' directive is much stricter than it actually
>>>> required.
>>>
>>> I don't quite understand. Can u write a couple of lines of pseudo
>>> assembly to show
>>> what the issue is.
>>
>> All instructions on ARCv2 are aligned by 2 byte (even if the
>> instruction is 4-byte long).
>>
>> Using '.balign' directive we align instruction which can be
>> patched by 4 byte.
>> So compiler will add one 'nop_s' before our instruction if it is not
>> 4 byte aligned.
>>
>> So this code
>> ------------------->8---------------
>> -----
>>  .balign 4
>>  1:
>>  b %l[l_yes]   #<- instruction which can be patched
>> ------------------->8--------------------
>> may turn into this:
>> -----------------
>> -->8--------------------
>> bla-bla-bla
>>  b l_yes       #<- instruction which can be patched
>> bla-bla-bla
>> ------------------->8--------------------
>> or that:
>> ----
>> --------------->8--------------------
>> bla-bla-bla
>>  nop_s         # padding
>>  b l_yes       #<- instruction which can be patched
>> bla-bla-bla
>> ----------------
>> --->8--------------------
>>
>> In most of the cases this extra 'nop_s' is unnecessary as it is fine
>> to have our instruction
>> not 4 byte aligned if it doesn't cross l1 cache line boundary.
>>
>> It is't the huge problem - but we are adding one unnecessary 'nop'
>> while we try to optimize hot code.
>>
>>>
>>>> It's enough
>>>> that our 32-bit instruction don't cross l1 cache line boundary.
>>>> That will save us from adding useless NOP padding in most of the
>>>> cases.
>>>> It can be implemented with ".bundle_align_mode" directive which
>>>> isn't supported by ARC AS unfortunately.
>>>
>>> This seems like a reasonable request (contingent to the difficulty
>>> of
>>> implementation in binutils). but I can't comprehend why you would
>>> need it.
>>
>> If we will have ".bundle_align_mode" directive supported we can add
>> extra 'nop_s' only if it's really required
>> (if our instruction _really_ cross L1 cache line boundary). So we
>> won't add useless NOP to hot code.
>>
>> --
>>  Eugeniy Paltsev

