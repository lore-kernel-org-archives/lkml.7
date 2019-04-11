Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA727C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9595F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="N2faBdda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDKRvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:51:55 -0400
Received: from mail.efficios.com ([167.114.142.138]:58322 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfDKRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:51:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6F7D71D3480;
        Thu, 11 Apr 2019 13:51:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id eK_xt-1xLeHD; Thu, 11 Apr 2019 13:51:52 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B4B6F1D3475;
        Thu, 11 Apr 2019 13:51:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B4B6F1D3475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555005112;
        bh=vhsxrFXy1X+SwRp8Dcw0sUAHq25a6H/X/S6ETRMKmM8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=N2faBddanJGu+zOA1uaw3QGNH9GpsSKBZT2BEu6Wdm7CvHLphg5Lix0Q7fwQXVxfu
         qafceUxF4ZbXjKnxrUPHeZrbuG6TRhbuWJ9tdIt/fBfGXMYaGgu+f08wrLWSD0NgsA
         ZUDxUnHXU3o0RfjlLNZv4irfWbEr0CXduZuARUI2IWTjoVzQmOWwCBIkHBz3VEggFn
         uaFrN3BlsAEDNCLG6quGwO9gXsxhpowp9fIRY+1VsHHodaTwsM6BaiAcSqxbaenmSo
         xsRUkWXfJJTlHv/z3LEjWJI2WL4+8NOHpS1ij1Mzh/4h5cWucbaZm7NDtDtsYatOQh
         2wqE65TKdb8Pg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id oLaKaNOVLNiE; Thu, 11 Apr 2019 13:51:52 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9178C1D346E;
        Thu, 11 Apr 2019 13:51:52 -0400 (EDT)
Date:   Thu, 11 Apr 2019 13:51:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>,
        peter maydell <peter.maydell@linaro.org>,
        richard earnshaw <richard.earnshaw@arm.com>
Message-ID: <1469455003.811.1555005112414.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190411164219.GE29081@fuggles.cambridge.arm.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com> <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com> <20190411164219.GE29081@fuggles.cambridge.arm.com>
Subject: Re: rseq/arm32: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/arm32: choosing rseq code signature
Thread-Index: OaESARLi4wUkWowqO71sUhY1Y3b8bw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 11, 2019, at 12:42 PM, Will Deacon will.deacon@arm.com wrote:

> Hi Mathieu,
> 
> On Wed, Apr 10, 2019 at 04:29:19PM -0400, Mathieu Desnoyers wrote:
>> ----- On Apr 9, 2019, at 3:32 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> > We are about to include the code signature required prior to restartable
>> > sequences abort handlers into glibc, which will make this ABI choice final.
>> > We need architecture maintainer input on that signature value.
>> > 
>> > That code signature is placed before each abort handler, so the kernel can
>> > validate that it is indeed jumping to an abort handler (and not some
>> > arbitrary attacker-chosen code). The signature is never executed.
>> > 
>> > The current discussion thread on the glibc mailing list leads us towards
>> > using a trap with uncommon immediate operand, which simplifies integration
>> > with disassemblers, emulators, makes it easier to debug if the control
>> > flow gets redirected there by mistake, and is nicer for some architecture's
>> > speculative execution.
>> > 
>> > We can have different signatures for each sub-architecture, as long as they
>> > don't have to co-exist within the same process. We can special-case with
>> > #ifdef for each sub-architecture and endianness if need be. If the architecture
>> > has instruction set extensions that can co-exist with the architecture
>> > instruction set within the same process (e.g. thumb for arm), we need to take
>> > into account to which instruction the chosen signature value would map (and
>> > possibly decide if we need to extend rseq to support many signatures).
>> > 
>> > Here is an example of rseq signature definition template:
>> > 
>> > /*
>> > * TODO: document trap instruction objdump output on each sub-architecture
>> > * instruction sets, as well as instruction set extensions.
>> > */
>> > #define RSEQ_SIG 0x########
>> > 
>> > Ideally we'd need a patch on top of the Linux kernel
>> > tools/testing/selftests/rseq/rseq-arm.h file that updates
>> > the signature value, so I can then pick it up for the glibc
>> > patchset.
>> 
>> Would the following diff work for you ? If so, can I get your
>> acked-by ?
> 
> I had a quick chat with Richard and Peter (CC'd), since they're much more
> familiar with the A32 instruction set than I am and also have a better view
> of what might already be in use.
> 
> Peter suggests that anything of the form 0xe7fxdefx should trap in both A32
> and T32, although it does assemble to UDF; B <imm11> in T16. I'm not sure we
> should get too obsessed with trying to encode a signature that universally
> decodes to a trap.

That's a nice trick.

> 
> Whatever you choose, it would be worth checking that it doesn't clash with
> other allocations such as software breakpoints in GDB.

GDB seems to have [1] :

#define ARM_LE_BREAKPOINT {0xFE,0xDE,0xFF,0xE7}
#define ARM_BE_BREAKPOINT {0xE7,0xFF,0xDE,0xFE}
#define THUMB_LE_BREAKPOINT {0xbe,0xbe}
#define THUMB_BE_BREAKPOINT {0xbe,0xbe}

None of which match the value you hint at.

So I could pick "0xe7f5def3", which would map to the following comment:

/*
 * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
 * value 0x5de3. This traps if user-space reaches this instruction by mistake,
 * and the uncommon operand ensures the kernel does not move the instruction
 * pointer to attacker-controlled code on rseq abort.
 *
 * The instruction pattern in the A32 instruction set is:
 *
 * e7f5def3    udf    #24035    ; 0x5de3
 *
 * This translates to the following instruction pattern in the T16 instruction
 * set:
 *
 * little endian:
 * def3        udf    #243      ; 0xf3
 * e7f5        b.n    <7f5>
 *
 * big endian:
 * e7f5        b.n    <7f5>
 * def3        udf    #243      ; 0xf3
 */
#define RSEQ_SIG        0xe7f5def3

Thoughts ?

Thanks!

Mathieu

[1] https://github.com/bminor/binutils-gdb/blob/master/gdb/arm-tdep.c#L7705-L7742

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
