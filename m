Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA78C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8956720835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mNmyclgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbfDRPlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:41:09 -0400
Received: from mail.efficios.com ([167.114.142.138]:34544 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:41:09 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EE8E418CA18;
        Thu, 18 Apr 2019 11:41:07 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HlrPFju684Kz; Thu, 18 Apr 2019 11:41:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6293318CA10;
        Thu, 18 Apr 2019 11:41:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6293318CA10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555602067;
        bh=8DlPRt44lm3eiwiK9yLHyGozIyGwAdDpWlkTLTD9+3s=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mNmyclgGgEzkIM7+UQr6ygDrX7rb6a672T0Z0ghBopOM3O9XD8OOzvgKoy82R1J6M
         do2CzpH2H7XdzqwfbYe7rgFVdYQbxlEr6OJ6zxJtUrwN1HdFz9nWBPMxnsGH2p/0dh
         TTz2tcEvHF47My7ummqlShPrm60EvxF2rug+l+dlUa5v53hPiANZNau1QZCEYCVCFW
         gAup7EbUlha8AF2dv3HRZdavpel3qmxYDjvFjmaWJwnEN35bUXzg9Kdrc/ZNBdSbwD
         MbfmrmzGWJchDisilKYyuaOybBJPDYB80RgfUTz8remZ+yBeBs68ZtxmrIoHpMWYop
         G6E/P6SAskZog==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id XTq_iuxT4JEJ; Thu, 18 Apr 2019 11:41:07 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 42EA918CA04;
        Thu, 18 Apr 2019 11:41:07 -0400 (EDT)
Date:   Thu, 18 Apr 2019 11:41:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <Will.Deacon@arm.com>, nd <nd@arm.com>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com>
In-Reply-To: <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <20190416173216.9028-2-mathieu.desnoyers@efficios.com> <364803063.586.1555516769056.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk> <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com> <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com> <6cbfea7b-9d83-74a5-9cd2-af56a5d68818@arm.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v8)
Thread-Index: AQHU9HpbUigwBDiNHkaVVFlkWH4PtKZAhB6AgAAE+oCAAD0+gIABIvSAgAAl0IBuJwpORg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 18, 2019, at 11:33 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:

> On 18/04/2019 14:17, Mathieu Desnoyers wrote:
>> ----- On Apr 17, 2019, at 3:56 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>>> ----- On Apr 17, 2019, at 12:17 PM, Joseph Myers joseph@codesourcery.com wrote:
>>>> On Wed, 17 Apr 2019, Mathieu Desnoyers wrote:
>>>>
>>>>>> +/* RSEQ_SIG is a signature required before each abort handler code.
>>>>>> +
>>>>>> +   It is a 32-bit value that maps to actual architecture code compiled
>>>>>> +   into applications and libraries. It needs to be defined for each
>>>>>> +   architecture. When choosing this value, it needs to be taken into
>>>>>> +   account that generating invalid instructions may have ill effects on
>>>>>> +   tools like objdump, and may also have impact on the CPU speculative
>>>>>> +   execution efficiency in some cases.  */
>>>>>> +
>>>>>> +#define RSEQ_SIG 0xd428bc00	/* BRK #0x45E0.  */
>>>>>
>>>>> After further investigation, we should probably do the following
>>>>> to handle compiling with -mbig-endian on aarch64, which generates
>>>>> binaries with mixed code vs data endianness (little endian code,
>>>>> big endian data):
>>>>
>>>> First, the comment on RSEQ_SIG should specify whether it is to be
>>>> interpreted in the code or the data endianness.
>>>
>>> Right. The signature passed as argument to the rseq registration
>>> system call needs to be in data endianness (currently exposed kernel
>>> ABI).
>>>
>>> Ideally for userspace, we want to define a signature in code endianness
>>> that happens to nicely match specific code patterns.
> ...
>> For aarch64, I think we can simply do:
>> 
>> /*
>>  * aarch64 -mbig-endian generates mixed endianness code vs data:
>>  * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
>>  * matches code endianness.
>>  */
>> #define RSEQ_SIG_CODE   0xd428bc00      /* BRK #0x45E0.  */
>> 
>> #ifdef __ARM_BIG_ENDIAN
>> #define RSEQ_SIG_DATA   0x00bc28d4      /* BRK #0x45E0.  */
>> #else
>> #define RSEQ_SIG_DATA   RSEQ_SIG_CODE
>> #endif
>> 
>> #define RSEQ_SIG        RSEQ_SIG_DATA
>> 
>> Feedback is most welcome,
> 
> so the RSEQ_SIG value is supposed to be used with .word
> in asm instead of .inst?

We want a .inst so it translates into a valid trap instruction.
It's better to trap in case program execution reaches this
by mistake (makes debugging easier).

> 
> i don't think we use __ARM_* in public headers currently,
> but hopefully aarch64_be compilers implement it.

Can I use #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__  then ?

> 
> otherwise this looks ok to me.
> 
> (i think a rare palindrome instruction would work too, e.g.
> 0a5f5f0a 	and	w10, w24, wzr, lsr #23 // shifted 0
> 2a5f5f2a 	orr	w10, w25, wzr, lsr #23
> eb9f9feb 	negs	x11, xzr, asr #39
> c83f3fc8 	stxp	wzr, x8, x15, [x30]  // store to LR ignoring success
> d9ffffd9 	stz2g	x25, [x30, #-16]!    // v8.5 tag+zero 2 granules around LR
> etc. it does not need to be a guaranteed trap)

Unfortunately it's not a trap :/

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
