Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76537C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2179120684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eNwZVCzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfDONLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:11:33 -0400
Received: from mail.efficios.com ([167.114.142.138]:39550 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDONLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:11:33 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1DFD5B7850;
        Mon, 15 Apr 2019 09:11:32 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id c6iAZGumT-3x; Mon, 15 Apr 2019 09:11:31 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 697E6B784A;
        Mon, 15 Apr 2019 09:11:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 697E6B784A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555333891;
        bh=a1M60/X8aoD7PZVcRB7tjpsPkm9TwjAjSw0B/sKmFiY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eNwZVCzEdVoQGw/HC4obKnrsGtFBJ50dRhyXONl881CrllGyEVeyOGx4KcyWMq9Bd
         DYhqBtfxRTvx4x/Jli0yAAwHtV5+wzOMOHbT8nUG6C/IbNuXA0JQSZIcI6apaYGlTk
         ZRlg89PQ8wXp/nxwWPKPBD342QRSvy4CMgFIHwyIHte5jrqF7HwxukjopP5CxXKoPk
         NwJdch+1hGop+uaYB4nyyT+pntifH40rxyDfAYRE7xXwwI9Sy4VNT/kBV5WHD8umq2
         eE+t9QXBkI3iBH9VV9rUDBpcFgQsz66J6DQIJ1L06cTN3e4vTYX/MTG4VOIda+lpJA
         xlo2ugNtAgy9g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id tbbd8f5Asyty; Mon, 15 Apr 2019 09:11:31 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4E773B7845;
        Mon, 15 Apr 2019 09:11:31 -0400 (EDT)
Date:   Mon, 15 Apr 2019 09:11:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     peter maydell <peter.maydell@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>,
        richard earnshaw <richard.earnshaw@arm.com>
Message-ID: <936773156.261.1555333890988.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFEAcA849mmSds9euyvR2uLWqEeA2eedkmcq1O4pT6-S0oK8BA@mail.gmail.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com> <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com> <20190411164219.GE29081@fuggles.cambridge.arm.com> <1469455003.811.1555005112414.JavaMail.zimbra@efficios.com> <CAFEAcA849mmSds9euyvR2uLWqEeA2eedkmcq1O4pT6-S0oK8BA@mail.gmail.com>
Subject: Re: rseq/arm32: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/arm32: choosing rseq code signature
Thread-Index: GTYOyR4kdTfxbInO6WNJz6P29g6WSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 11, 2019, at 3:55 PM, peter maydell peter.maydell@linaro.org w=
rote:

> On Thu, 11 Apr 2019 at 18:51, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> ----- On Apr 11, 2019, at 12:42 PM, Will Deacon will.deacon@arm.com wrot=
e:
>> > Peter suggests that anything of the form 0xe7fxdefx should trap in bot=
h A32
>> > and T32, although it does assemble to UDF; B <imm11> in T16. I'm not s=
ure we
>> > should get too obsessed with trying to encode a signature that univers=
ally
>> > decodes to a trap.
>>
>> That's a nice trick.
>>
>> >
>> > Whatever you choose, it would be worth checking that it doesn't clash =
with
>> > other allocations such as software breakpoints in GDB.
>>
>> GDB seems to have [1] :
>>
>> #define ARM_LE_BREAKPOINT {0xFE,0xDE,0xFF,0xE7}
>> #define ARM_BE_BREAKPOINT {0xE7,0xFF,0xDE,0xFE}
>> #define THUMB_LE_BREAKPOINT {0xbe,0xbe}
>> #define THUMB_BE_BREAKPOINT {0xbe,0xbe}
>>
>> None of which match the value you hint at.
>=20
> Hmm? The ARM BPs match 0xe7fxdefx when considered with
> the appropriate endianness (clearly somebody has
> been down this line of thought before). Still, as long as
> we pick different values for the 8 bits of freedom we
> have it should be fine.

Right.=C2=A0I selected 0xe7f5def3, which should ensure we are distinct
from gdb's choice.

>=20
>> /*
>>  * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate oper=
and
>>  * value 0x5de3. This traps if user-space reaches this instruction by mi=
stake,
>>  * and the uncommon operand ensures the kernel does not move the instruc=
tion
>>  * pointer to attacker-controlled code on rseq abort.
>>  *
>>  * The instruction pattern in the A32 instruction set is:
>>  *
>>  * e7f5def3    udf    #24035    ; 0x5de3
>>  *
>>  * This translates to the following instruction pattern in the T16 instr=
uction
>>  * set:
>>  *
>>  * little endian:
>>  * def3        udf    #243      ; 0xf3
>>  * e7f5        b.n    <7f5>
>>  *
>>  * big endian:
>>  * e7f5        b.n    <7f5>
>>  * def3        udf    #243      ; 0xf3
>=20
> Do we really care about big-endian instruction-ordering for Thumb?
> It requires (AIUI) either an ARMv7R CPU which implements and sets
> SCTLR.IE to 1, or a v6-or-earlier CPU using BE32, and it's going to
> be even rarer than normal BE8 big-endian...

I don't think we care enough about it to look for a trick to
turn the branch into something else (which would not branch away from the
udf instruction), but considering this signature will be ABI, it's good to
be thorough documentation-wise and cover all existing cases.

Thoughts ?

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
