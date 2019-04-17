Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546B8C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AE920835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YBVZZIOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbfDQPak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:30:40 -0400
Received: from mail.efficios.com ([167.114.142.138]:58642 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQPak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:30:40 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 519451D703D;
        Wed, 17 Apr 2019 11:30:38 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 8_wyW29sxaK2; Wed, 17 Apr 2019 11:30:37 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 867421D7036;
        Wed, 17 Apr 2019 11:30:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 867421D7036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555515037;
        bh=6yMJLMgc1Gv5YXdnBxBhmtwPvjH6Jkg/Q6lE2gpLj5U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YBVZZIOu1vs941KgsKmVgzy9hOLnsqvXfHmG1paM+9MbqvK58rGAn6UNyMpAuxr6E
         jIzWC1vL5LHHvQ/lR/zEfiKnRdGhgBGSpSafLCMrtpnduJbwFnwUNJ2Ggu5D+rSaTW
         QGuc/J9drOoNwwpKMA/IdPX6KUG70QSiTBKpNjqh9jGrgz1GJHno8hgSKXn09B9QQM
         Xt2cZuRPzb+bUE4SOi1MS6EvG3Vv1eU25XEFcDyDwLyqQy8y0/i/ipgFBHnT0fOt44
         DrT29dOG19+mzGP0w7gh9ribwflsENneVlmNVSND2duY8iQ7hRWDWJ9pVwnWyi2WCZ
         IaT/sa46s7Isw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id kM4gkQuzsUU0; Wed, 17 Apr 2019 11:30:37 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 714891D7027;
        Wed, 17 Apr 2019 11:30:37 -0400 (EDT)
Date:   Wed, 17 Apr 2019 11:30:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     richard earnshaw <Richard.Earnshaw@arm.com>
Cc:     peter maydell <peter.maydell@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>
Message-ID: <211627248.490.1555515037279.JavaMail.zimbra@efficios.com>
In-Reply-To: <1583901617.467.1555512184036.JavaMail.zimbra@efficios.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com> <CAFEAcA849mmSds9euyvR2uLWqEeA2eedkmcq1O4pT6-S0oK8BA@mail.gmail.com> <936773156.261.1555333890988.JavaMail.zimbra@efficios.com> <CAFEAcA8YP5vvZpa_5dvv00koupsry9_3x2EB0cjvE6vtoi8sog@mail.gmail.com> <71495082.295.1555335441325.JavaMail.zimbra@efficios.com> <755179555.1337.1555421945337.JavaMail.zimbra@efficios.com> <cecd4a6e-4a36-1785-4f65-486ba3847a06@arm.com> <1583901617.467.1555512184036.JavaMail.zimbra@efficios.com>
Subject: Re: rseq/arm32: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/arm32: choosing rseq code signature
Thread-Index: Kl7P3cfIxmCIehH4hF96wGRn+XPyHQeGmC8B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 17, 2019, at 10:43 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 17, 2019, at 6:37 AM, richard earnshaw Richard.Earnshaw@arm.com
> wrote:
> 
>> On 16/04/2019 14:39, Mathieu Desnoyers wrote:
>>> ----- On Apr 15, 2019, at 9:37 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:
>>> 
>>>> ----- On Apr 15, 2019, at 9:30 AM, peter maydell peter.maydell@linaro.org wrote:
>>>>
>>>>> On Mon, 15 Apr 2019 at 14:11, Mathieu Desnoyers
>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>>
>>>>>> ----- On Apr 11, 2019, at 3:55 PM, peter maydell peter.maydell@linaro.org wrote:
>>>>>>
>>>>>>> On Thu, 11 Apr 2019 at 18:51, Mathieu Desnoyers
>>>>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>>>>  * This translates to the following instruction pattern in the T16 instruction
>>>>>>>>  * set:
>>>>>>>>  *
>>>>>>>>  * little endian:
>>>>>>>>  * def3        udf    #243      ; 0xf3
>>>>>>>>  * e7f5        b.n    <7f5>
>>>>>>>>  *
>>>>>>>>  * big endian:
>>>>>>>>  * e7f5        b.n    <7f5>
>>>>>>>>  * def3        udf    #243      ; 0xf3
>>>>>>>
>>>>>>> Do we really care about big-endian instruction-ordering for Thumb?
>>>>>>> It requires (AIUI) either an ARMv7R CPU which implements and sets
>>>>>>> SCTLR.IE to 1, or a v6-or-earlier CPU using BE32, and it's going to
>>>>>>> be even rarer than normal BE8 big-endian...
>>>>>>
>>>>>> I don't think we care enough about it to look for a trick to
>>>>>> turn the branch into something else (which would not branch away from the
>>>>>> udf instruction), but considering this signature will be ABI, it's good to
>>>>>> be thorough documentation-wise and cover all existing cases.
>>>>>
>>>>> I think if you want to document it it would be helpful to
>>>>> readers to make it clear that this is the ultra-rare
>>>>> big-endian-instruction-order "big endian Thumb", not the only
>>>>> moderately-rare little-endian-instructions-big-endian-data
>>>>> "big endian Thumb".
>>>>
>>>> I'm actually very much concerned about environments with big endian
>>>> data and little endian code. Which gcc compiler flags do I need to
>>>> use to test it ?
>>>>
>>>> I'm concerned about a signature mismatch between what is passed to
>>>> the rseq system call ("data-endian signature") and what is generated
>>>> in the code ("instruction-endian signature").
>>> 
>>> Based on this page:
>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0360f/CDFBBCHB.html
>>> 
>>> My understanding is that the situation is as follows (please confirm):
>>> 
>>> - Prior to ARMv6, you could build and run code that is either big or little
>>> endian,
>>>   given you had a matching Linux kernel endianness. Code and data endianness
>>>   needed
>>>   to match,
>>> - Starting from ARMv6, only little endian code is supported. The endianness for
>>> data
>>>   access can be changed through bit [9], the E bit, of the Program Status
>>>   Register,
>>>   (mixed endianness)
>>> 
>>> Looking at ARM build options for gcc, it seems you can select either big or
>>> little
>>> endian (-mbig-endian or -mlittle-endian (default)) which affects both
>>> instruction and
>>> data endianness. So I suspect the -mbig-endian option is really only useful for
>>> pre-ARMv6.
>> 
>> -mbig-endian is still correct, even on later architectures.  The linker
>> gets involved, however, and (using the mapping symbol information) swaps
>> the code segments to little-endian form (this is why you have to use
>> .inst rather than .word when inserting instructions, so that the correct
>> mapping symbols are inserted).
> 
> So what you're saying is that if I have:
> 
> void main()
> {
>        asm volatile (
>                        ".arm\n\t"
>                        ".inst 0xe7f5def3\n\t"
>                        ".long 0xe7f5def3\n\t");
> }
> 
> and compile it with:
> 
> arm-linux-gnueabihf-gcc -mbig-endian -march=armv6 -c -o arm-big-endianv6.o
> arm-test-endian.c
> 
> It's expected that the generated .o will have big endian instructions, matching
> the endianness of the data, e.g.:
> 
> hexdump arm-big-endianv6.o
> 
> [...]
> 0000030 0a00 0900 80b5 00af f5e7 f3de f5e7 f3de
> 
> But it's then at the linking stage that the linker will
> reverse the endianness of the ".inst" (but not .long).
> 
> Let's see:
> 
> arm-linux-gnueabihf-gcc -nodefaultlibs -nostdlib -mbig-endian -march=armv6 -o
> arm-big-endianv6 arm-big-endianv6.o
> /usr/lib/gcc-cross/arm-linux-gnueabihf/7/../../../../arm-linux-gnueabihf/bin/ld:
> warning: cannot find entry symbol _start; defaulting to 00000000000001b0
> 
> hexdump gives me:
> [...]
> 00001b0 80b5 00af f5e7 f3de f5e7 f3de c046 bd46
> 
> So it has not reversed the instruction endianness.
> 
> What am I doing wrong ?

It seems to be specific to using armv6 and armv7* with gcc 7.
gcc 8 seems to indeed reverse the code vs data endianness.

So we need to figure out whether .inst is the right things to
do to declare a signature, or if it's better to use ".long"
which would probably generate an invalid instruction on BE...

Thanks,

Mathieu

> 
> I'm using:
> 
> gcc version 7.3.0 (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04)
> GNU ld (GNU Binutils for Ubuntu) 2.30
> 
> Thanks,
> 
> Mathieu
> 
>> 
>>> 
>>> For ARMv6+ mixed-endianness, it seems to be a mode that temporarily swap
>>> endianness
>>> of load/store instructions for specific memory accesses communicating with DMA
>>> devices,
>>> so I don't see any scenario where we can generate a binary that has little
>>> endian code
>>> and big endian data. If that is true, then it should be fine to declare the
>>> signature
>>> with ".arm .inst" and expect the data endianness to be the same as code
>>> endianness.
>>> 
>>> Am I missing something ?
>>> 
>>> Thanks,
>>> 
>>> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
