Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C7217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MErEXGov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbfDRNRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:17:55 -0400
Received: from mail.efficios.com ([167.114.142.138]:49820 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388685AbfDRNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:17:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3C5171D8529;
        Thu, 18 Apr 2019 09:17:52 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id fxHENaeXTtJc; Thu, 18 Apr 2019 09:17:51 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 757801D8523;
        Thu, 18 Apr 2019 09:17:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 757801D8523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555593471;
        bh=daQRIz/GzW0nifT6WuMGpD1kzSG3Ak1hQ59bUiNIxkU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MErEXGovJB1p/YvnWbMGm4TgEIwTmcrceDoEIAFWz43qscgGdeuCAcGiLwCJqcEIj
         mFT4xnNgHimvFUoZMUVOCAuDUG4MFWw77+Ji9mcVhV1pmoq17kEhFoIOlpzVv8bPKe
         V8G3R+GCYYh1tsoilWfVOc1+QyGKVMFOeeo9tlfQWhvLorcV4EITlqmtyLJ3ybgCcY
         UJHiMMorklsTPxWEWysVFiNTeThFYfm0v3ZBWmCCbDZHnakw6Qefc0s4TTkJ7+lPGs
         4KAKSXnL0lsLkTp4JKzGJcqEUe8YsGxNLnlRNO6tTvOn6hv0mzY8bUHqDR5pj71zep
         zqABuIFa84rlA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 4A4zMfLTEaIW; Thu, 18 Apr 2019 09:17:51 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 556B31D8517;
        Thu, 18 Apr 2019 09:17:51 -0400 (EDT)
Date:   Thu, 18 Apr 2019 09:17:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
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
Message-ID: <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
In-Reply-To: <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <20190416173216.9028-2-mathieu.desnoyers@efficios.com> <364803063.586.1555516769056.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk> <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v8)
Thread-Index: INCuEl4HoV36+9kj4Py2i1v2aaL1in9pdVtq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 17, 2019, at 3:56 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 17, 2019, at 12:17 PM, Joseph Myers joseph@codesourcery.com wrote:
> 
>> On Wed, 17 Apr 2019, Mathieu Desnoyers wrote:
>> 
>>> > +/* RSEQ_SIG is a signature required before each abort handler code.
>>> > +
>>> > +   It is a 32-bit value that maps to actual architecture code compiled
>>> > +   into applications and libraries. It needs to be defined for each
>>> > +   architecture. When choosing this value, it needs to be taken into
>>> > +   account that generating invalid instructions may have ill effects on
>>> > +   tools like objdump, and may also have impact on the CPU speculative
>>> > +   execution efficiency in some cases.  */
>>> > +
>>> > +#define RSEQ_SIG 0xd428bc00	/* BRK #0x45E0.  */
>>> 
>>> After further investigation, we should probably do the following
>>> to handle compiling with -mbig-endian on aarch64, which generates
>>> binaries with mixed code vs data endianness (little endian code,
>>> big endian data):
>> 
>> First, the comment on RSEQ_SIG should specify whether it is to be
>> interpreted in the code or the data endianness.
> 
> Right. The signature passed as argument to the rseq registration
> system call needs to be in data endianness (currently exposed kernel
> ABI).
> 
> Ideally for userspace, we want to define a signature in code endianness
> that happens to nicely match specific code patterns.
> 
>> 
>>> For ARM32, the situation is a bit more complex. Only armv6+
>>> generates mixed-endianness code vs data with -mbig-endian.
>>> Prior to armv6, the code and data endianness matches. Therefore,
>>> I plan to #ifdef the reversed endianness handling with:
>>> 
>>> #if __ARM_ARCH >= 6 && __ARM_BIG_ENDIAN
>>> 
>>> on arm32.
>> 
>> That doesn't work well because BE code (.o files) can be built for v5te
>> (for example) and used on a range of different architecture variants with
>> both BE32 and BE8 - the choice between BE32 and BE8 is a link-time choice,
>> not a compile-time choice.  So if the value for Arm is a compile-time
>> constant, it should also work for both BE32 and BE8.
> 
> Good to know! Then we need to be even more careful.
> 
>> 
>> In turn, that suggests to me that RSEQ_SIG should be defined to be a value
>> that is always in the code endianness (and whatever corresponding kernel
>> code handles RSEQ_SIG values should act accordingly on architectures where
>> the two endiannesses can differ).  If the kernel ABI is already fixed in a
>> way that prevents such a definition of RSEQ_SIG semantics as using code
>> endianness, a value should be chosen for Arm that works for both
>> endiannesses.
> 
> It might be tricky to pick up a trap instruction that is a palindrome
> endianness-wise.
> 
>> 
>> (Also, installed glibc headers are supposed to work with older compilers,
>> and support for __ARM_ARCH was only added in GCC 4.8.  Before that you
>> need to test lots of separate macros for different architecture variants
>> to determine a version number.)
> 
> Good point!
> 
> Here is an alternative to the palindrome approach. I'm taking arm32
> as an example:
> 
> * We define RSEQ_SIG_CODE in code endianness, meant to be used with
>  .inst in rseq assembly:
> 
> #define RSEQ_SIG_CODE 0xe7f5def3
> 
> * We define RSEQ_SIG_DATA in data endianness:
> 
> #define RSEQ_SIG_DATA \
>        ({ \
>                int sig; \
>                asm volatile (  "b 2f\n\t" \
>                                ".arm\n\t" \
>                                "1: .inst 0xe7f5def3\n\t" \
>                                "2:\n\t" \
>                                "ldr %[sig], 1b\n\t" \
>                                : [sig] "=r" (sig)); \
>                sig; \
>        })
> 
> Technically, only glibc and early-adopter libraries wishing to
> register rseq need to use RSEQ_SIG_DATA. The RSEQ_SIG_CODE needs
> to be used from inline assembly to create the signatures before
> each abort handler.

The approach above should work for arm32 be8 vs be32 linker weirdness.

For aarch64, I think we can simply do:

/*
 * aarch64 -mbig-endian generates mixed endianness code vs data:
 * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
 * matches code endianness.
 */
#define RSEQ_SIG_CODE   0xd428bc00      /* BRK #0x45E0.  */

#ifdef __ARM_BIG_ENDIAN
#define RSEQ_SIG_DATA   0x00bc28d4      /* BRK #0x45E0.  */
#else
#define RSEQ_SIG_DATA   RSEQ_SIG_CODE
#endif

#define RSEQ_SIG        RSEQ_SIG_DATA

Feedback is most welcome,

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
